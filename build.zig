const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "libtess2",
        .target = target,
        .optimize = optimize,
    });

    const src_files = [_][]const u8{
        "Source/bucketalloc.c",
        "Source/dict.c",
        "Source/geom.c",
        "Source/mesh.c",
        "Source/priorityq.c",
        "Source/sweep.c",
        "Source/tess.c",
    };

    lib.addCSourceFiles(&src_files, &.{"-std=c89"});

    lib.addIncludePath("Include");
    lib.addIncludePath("Source");

    lib.linkSystemLibrary("c");
    lib.installHeadersDirectory("Include", ".");
    b.installArtifact(lib);
}
