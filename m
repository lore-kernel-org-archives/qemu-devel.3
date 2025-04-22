Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0B4C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76B9-0001Ey-U7; Tue, 22 Apr 2025 01:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76B5-0001EO-Gg; Tue, 22 Apr 2025 01:28:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76B2-0007mf-PZ; Tue, 22 Apr 2025 01:28:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227c7e57da2so41052585ad.0; 
 Mon, 21 Apr 2025 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299684; x=1745904484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LlssLeV8PwZvAQFxPCo+Tq04KcXHAkZ9FCrXDlrN+HU=;
 b=WrLgwMBtr7sCcv5+3SlpnaxClXjQvQRd2iqi25yrhrs2qgdAGYkkz6Ahkf/MBZuEY3
 sxcKyVn25qdXaQbMcu5YPlAiTLKBuetY5Ou5O3RJAAFB6U+VdUE9hoFmcU3Pi33EGG62
 Qu7zykKgItzmnKgBQd4yQ8v5J2FuFCFQaPOiq1P8kjUSp4HA0SySUL0781MmOO/odjuq
 1JjLsQ4YZUBP6LsLqX6gPPGu/39rvdrd6L+QvHsHD/5f0Cc65BB4kFfpyZUrNqxa5E5u
 rnjjkutt2rtY7ll9rxE0p0t0qdzm4A1oDnB94RpHkzq3SfpbC2ybikUYqHqZOKbwlSjZ
 xQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299684; x=1745904484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LlssLeV8PwZvAQFxPCo+Tq04KcXHAkZ9FCrXDlrN+HU=;
 b=RvKmMTm/Pf4XPPw5wgw10RroRt/qvTwDemydu6+A7Rf6N8HoKxqqfFC5Zfv4Tpee8d
 Fv3t6aZsMuwx8R9dnhzoAu/4mXgBgvQclAlyLWuTdui1lyzMk/9ifiSgg1wCOEzX/ADP
 aM8w6fy2bZlewAYkGJzvxVGlOSj4sh+RQsrFf42VIye6SkugsQTt4iMSJijSmx+aamqC
 QZ9Z8woqiGegi8akt7JX92uRGxUH1snqrD7fco0sgkxBWONLS4Bh5DFMr+u1U15t79CP
 +ee+1zSKY2H+mN0VUjSEkPmTQHaeGvf+Ox63GEL6aXm9oWxJfjJwiAgfgJVmqaEX5yJx
 J2hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2OlYV6CMl0TKNKrXg9cx3ODiq0ttXmoO3wQ1Q4MxlG5Lo87kqH9r2cs45+nJ5iDYPtYVuW7rly8v0gg==@nongnu.org,
 AJvYcCXOder6gwOik2m8fmEsCoEmpPzdWWuA6RMEUYibeF6OtG6lOQ+KGXgtbbIhmK0loot6/2yh3h0SvA==@nongnu.org,
 AJvYcCXq04xao1bJy9cSIYl4jyYZGYXYlcejSQzLWEGTvzoQp9lp4X+J2BZU1q+kgUr5BzMWuo0NPP/WCBg=@nongnu.org,
 AJvYcCXu/On7HBht/6Ypjp1TMS433oTwPEdDonZnv+zNTBYlSFEZHvp0oWaDUL6EnhL/bfJG5HJxzi1GUPA/wA==@nongnu.org
X-Gm-Message-State: AOJu0YxOeySIT/n8aPlFM85Sit8cfS5f8ZZCwwf4bAh1BfYNJDiK0UT4
 hFPU/Oew6qh1q0G+UqcjKUx2nBs/utNQbpG+RNAkE03RmIml2jOaiU2fZfmv
X-Gm-Gg: ASbGncsXGt1pf7A6n6ZngDUnsd4TsLcZJuWvQiR76ECrUifxwEpaBeOLrBUW3Aj0Ew7
 HnALOgX/pj8nMLNWoMpEFQk6fLWxnL7FoIFLCdPsey6y45KvlGWapLgvhgdWDSK3DghwmO5OFpj
 1phl7w84y+tOyYzI7vJZwUBtx8bhlSXLi4mcVEpqa1+lqh8f9hPdmfPuRjyRwSc38sTC6EoKVq4
 tVDrqSUaleIZfJUfi3UE1Ha8XQh7ku/RS7Yn7a696LdQwqCHGXoUKwL6ycL1+x5sDyba9LuI8du
 UuzF0ne72KNaO+4/nhPOhm+BvuK2uaofSqQzfY4cQF1b2DnBT9jHWy/Ed/k=
X-Google-Smtp-Source: AGHT+IHud7/aqNVHqUlvMR9p9zobEuKDbwSSH92PhK7xD8g7kXzvl6OyVxAU7dXMRh4D5ulA2ZsBwg==
X-Received: by 2002:a17:903:320e:b0:22c:33b2:e410 with SMTP id
 d9443c01a7336-22c53379f1emr210419905ad.2.1745299683567; 
 Mon, 21 Apr 2025 22:28:03 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:02 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 00/20] Enable QEMU TCI to run 32bit guests on browsers
Date: Tue, 22 Apr 2025 14:27:04 +0900
Message-Id: <cover.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

V2:

- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.
- Fixed typo in the comment in include/glib-compat.h: s/insted/instead/
- In util/cacheflush.c patch, added an explanation for the change to both
  the code comment and the commit message.
- Split the block/file-posix.c hunk that adds "#include <sys/ioctl.h>" into
  a separate commit and revised the commit message to clarify the purpose of
  the patch.
- Removed the Emscripten-specific stub of copy_file_range in
  stubs/emscripten.c. Instead, updated the type of the existing
  copy_file_range stub in block/file-posix.c to match the declaration in the
  Emscripten headers and avoid a compilation error.
- Moved the change that was incorrectly applied to os-posix.h into os-wasm.h
- Split MAINTAINERS file change to each commit that adds new files.
- Unified two consecutive #ifndef macros into a single condition in
  qemu-options.hx.
- Instead of porting mmap-alloc.c to Emscripten, this version excludes the
  file entirely. The rationale is described in the commit message.
- In meson.build, added a check to ensure TCI is enabled for the wasm build.
- Split the Dockerfile addition from the previous 18th patch into a separate
  commit.

V1:

This patch series is split from the original "Enable QEMU to run on
browsers" series, focusing solely on the essential code changes needed to
compile QEMU TCI with Emscripten. It also inclues fixes based on feedback
received in the original series, thank you for the comments.

# Supported features in this series

This patch series enables TCI interpreter mode with 32bit guest
support. While the original series included the non-TCI backend and 9pfs
patches, those components are not included here. They will be reintroduced
in follow-up series after the foundational patches have been merged.

# Emscripten-Based Coroutine Backend

Emscripten does not support couroutine methods currently used by QEMU but
provides a coroutine implementation called "fiber". This patch series
introduces a coroutine backend using fiber. However, fiber does not support
submitting coroutines to other threads. As a result, this patch series
doesn't support components like hw/9pfs, which rely on that behavior.

# Overview of build process

This section provides an overview of the build process for compiling QEMU
using Emscripten. Full instructions are available in the sample
repository[1].

To compile QEMU with Emscripten, the following dependencies are required.
The emsdk-wasm32-cross.docker environment includes all necessary components
and can be used as the build environment:

- Emscripten SDK (emsdk) v3.1.50
- Libraries cross-compiled with Emscripten (refer to
  emsdk-wasm32-cross.docker for build steps)
  - GLib v2.84.0
  - zlib v1.3.1
  - libffi v3.4.7
  - Pixman v0.44.2

QEMU can be compiled using Emscripten's emconfigure and emmake, which
automatically set environment variables such as CC for targeting Emscripten.

emconfigure configure --static --disable-tools \
                      --target-list=arm-softmmu --enable-tcg-interpreter
emmake make -j$(nproc)

This process generates the following files:

- qemu-system-arm.js
- qemu-system-arm.wasm
- qemu-system-arm.worker.js

Guest images can be packaged using Emscripten's file_packager.py tool.
For example, if the images are stored in a directory named "pack", the
following command packages them, allowing QEMU to access them through
Emscripten's virtual filesystem:

/path/to/file_packager.py qemu-system-arm.data --preload pack > load.js

This process generates the following files:

- qemu-system-arm.data
- load.js

Emscripten allows passing arguments to the QEMU command via the Module
object in JavaScript:

Module['arguments'] = [
    '-nographic', '-m', '512M', '-machine', 'virt',
    '-L', 'pack/',
    '-global', 'virtio-mmio.force-legacy=false',
    '-device', 'virtio-blk-device,drive=d0',
    '-drive', 'file=pack/rootfs.bin,if=none,format=raw,id=d0',
    '-kernel', 'pack/kernel.img',
    '-append', 'console=ttyAMA0 root=/dev/vda loglevel=7',
];

The sample repository[1] provides a complete setup, including an HTML file
that implements a terminal UI.

[1] https://github.com/ktock/qemu-wasm-sample/tree/tcidev

# Additional references

- Original patch series "Enable QEMU to run on browsers":
  https://patchew.org/QEMU/cover.1744032780.git.ktokunaga.mail@gmail.com/
- A talk at FOSDEM 2025:
  https://fosdem.org/2025/schedule/event/fosdem-2025-6290-running-qemu-inside-browser/

Kohei Tokunaga (20):
  hw/core/loader.c: Fix type conflict of GLib function pointers
  qom/object.c: Fix type conflict of GLib function pointers
  system/vl.c: Fix type conflict of GLib function pointers
  target/arm/helper.c: Fix type conflict of GLib function pointers
  target/i386/cpu.c: Fix type conflict of GLib function pointers
  contrib/plugins: Fix type conflict of GLib function pointers
  hw/net/can: Fix type conflict of GLib function pointers
  target/ppc: Fix type conflict of GLib function pointers
  target/s390x: Fix type conflict of GLib function pointers
  include/glib-compat.h: Poison g_list_sort and g_slist_sort
  util/cacheflush.c: Update cache flushing mechanism for Emscripten
  block: Add including of ioctl header for Emscripten build
  block: Fix type confict of the copy_file_range stub
  include/qemu/osdep.h: Add Emscripten-specific OS dependencies
  Disable options unsupported on Emscripten
  util: exclude mmap-alloc.c from compilation target on Emscripten
  util: Add coroutine backend for emscripten
  meson: Add wasm build in build scripts
  tests: Add Dockerfile containing dependencies for Emscripten build
  gitlab: Enable CI for wasm build

 .gitlab-ci.d/buildtest-template.yml           |  27 ++++
 .gitlab-ci.d/buildtest.yml                    |   9 ++
 .gitlab-ci.d/container-cross.yml              |   5 +
 MAINTAINERS                                   |   9 ++
 backends/meson.build                          |   6 +-
 block/file-posix.c                            |   8 +-
 configs/meson/emscripten.txt                  |   8 +
 configure                                     |   7 +
 contrib/plugins/cache.c                       |  12 +-
 contrib/plugins/cflow.c                       |  10 +-
 contrib/plugins/hotblocks.c                   |   4 +-
 contrib/plugins/hotpages.c                    |   4 +-
 contrib/plugins/howvec.c                      |   4 +-
 contrib/plugins/hwprofile.c                   |   8 +-
 hw/core/loader.c                              |   4 +-
 hw/net/can/xlnx-versal-canfd.c                |   4 +-
 include/glib-compat.h                         |   6 +
 include/qemu/cacheflush.h                     |   7 +
 include/qemu/osdep.h                          |   8 +-
 include/system/os-wasm.h                      | 104 +++++++++++++
 meson.build                                   |  29 +++-
 meson_options.txt                             |   2 +-
 os-wasm.c                                     | 119 ++++++++++++++
 qemu-options.hx                               |   4 +-
 qom/object.c                                  |   7 +-
 scripts/meson-buildoptions.sh                 |   2 +-
 system/memory.c                               |   2 +-
 system/physmem.c                              |   9 +-
 system/vl.c                                   |   8 +-
 target/arm/helper.c                           |   4 +-
 target/i386/cpu.c                             |  11 +-
 target/ppc/cpu_init.c                         |   4 +-
 target/s390x/cpu_models.c                     |   4 +-
 .../dockerfiles/emsdk-wasm32-cross.docker     | 145 ++++++++++++++++++
 tests/tcg/plugins/mem.c                       |   4 +-
 tests/tcg/plugins/syscall.c                   |   4 +-
 util/cacheflush.c                             |   4 +
 util/coroutine-wasm.c                         | 127 +++++++++++++++
 util/meson.build                              |   4 +-
 util/oslib-posix.c                            |  28 ++++
 40 files changed, 709 insertions(+), 66 deletions(-)
 create mode 100644 configs/meson/emscripten.txt
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 create mode 100644 util/coroutine-wasm.c

-- 
2.25.1


