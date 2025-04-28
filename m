Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900C9C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9I9p-0002Ix-23; Mon, 28 Apr 2025 02:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9j-0002IZ-5d; Mon, 28 Apr 2025 02:39:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9g-0006nS-P6; Mon, 28 Apr 2025 02:39:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22401f4d35aso52576155ad.2; 
 Sun, 27 Apr 2025 23:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822381; x=1746427181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dK6O7z60HbSeZt8wVKmalny4ZAGsn1II5uWKl1TPKnE=;
 b=ZRZq9V/Hq3s4i617VLHylixCy357bslDWx4+FwIGnZDnTOI8Q+hmg8OBzXm1CPvd4g
 lXSxOBI5PAufmRX//rA34zfCB+sXAKTFWCmLiqEszvMNvGt7YEcxHUBFXfdHsBafTeWI
 a9jGUuXVZnu21X0WwAHQN4AR/2rfydP5WrMLGWvDJTRkR/fXqKS8tap56LryOiUHsCTl
 Y4mulffhmUdgPt75idLERGNd8yVEgiYmoM8BBQQ3/yrB4eSQCiKLYcGARyyBO7czpEgE
 n16lpFIIWgXd7aS94Yv0nWBu6VUu+D0v4xpzNjikqXBITbLy86VST5hyuy6J4lbW4mRU
 OkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822381; x=1746427181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK6O7z60HbSeZt8wVKmalny4ZAGsn1II5uWKl1TPKnE=;
 b=GkU8l8Mi0eOnvMziOzotWfouY1cPzLb1ydBWivkSfkYkQ2gaKYWrmAgXsG8ksrl4UJ
 1ed7NR4YHNC7wFgCdOz5rnXqgR5NajksEHplac7VfTuSuwVOvgdsJ47l9+MOsiJ/sfdr
 0Q8IcTX1PQzEGIPNSGeXpomlwtwRDO8XYfWMyC3Fi68qM5IxjKAcxvOZww8hOsfALh/n
 1ACC7ums6bppll4UGK2YL3OQOhnU5j/ErWkSfPEx2xL0HTcvwRir8RNXO1Ay3Ub4Vdzx
 1Hm9e45xaiYWy9f4dPzPuCRw5xlvai5d75zq1smfH8rhlf7UWVE43ifC6Ec9Y5X1GJ13
 0SOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeUOn6li4MWrEKuVXBK7oWba8H0itDd7E6KU2SG3AWnMVDVQ1OlzHVD5icOxKsGfdrfQKdaVTtO3PucA==@nongnu.org,
 AJvYcCVwIAD1S3y+PEe4ImpDKa1qc1ceXEM1dH8i95TQp91qxHLGR3pUAKiyNOYsoELax4DKt6LnYFY0k2zkxA==@nongnu.org,
 AJvYcCVx4M6bJZl4YVNdHZRfvyqgFVnfODxkUJIXHMPVWk8foSvsdygRTiU2QjYVhvr5H44yXVlpUP0UWLc=@nongnu.org,
 AJvYcCW89pKQmi93xnKfPgdQ8o1jHT3HvtlpdTl6rmlidd0MEgpXx6YcrqbmloMhwGUuVhZLQ4HSxjU8yg==@nongnu.org
X-Gm-Message-State: AOJu0YwEEdfPHQPGeNsZa8dKytZuxpbA9gsMq5OUM0xS2a7xAf7JZiJk
 ueIj6lfdUo4cSC9ezGHo6SprQkAg0I1LWWaoFwCi1t9Eq8fvNVLjAiy8T9Y1
X-Gm-Gg: ASbGnctN3gZFsPSiZRaYgDxD5Oc2HdVOK+bA0f5yE1KAwS6BrPK5QCfpRe5GgSUBvqB
 BAJjZzsIKLMS0dEYaPJ0L2LQd9RA2o1wWgcGWntXxAg0FO/UniXIF7Vq6CXbW0tEgVFouRPhgXe
 nSrgVuedpkg6kuuGWSRryLzBh9H/sIzn5OfHQs70NbXYNyGyO4w4IPW36y1q1MDCuKIYO6dUKnA
 /phio9eR0ekcmuZat1vqimBovu956gcPVwImPQ2/ux+YvGuCur+L8Fsbnvt+HoeyLjp90cZ/mW4
 J5cPIsTpcJbO4gLw13b3F1Om+1tGVcbjLGbSpA==
X-Google-Smtp-Source: AGHT+IHPd7IjtWljONhKaRHyhvOAjolgIljZ6M+cmIGcBSZiB7onlO9bQZ2wvguMrsXMbppPtLQsow==
X-Received: by 2002:a17:902:f683:b0:223:62f5:fd44 with SMTP id
 d9443c01a7336-22dbf62c38emr164470995ad.40.1745822380908; 
 Sun, 27 Apr 2025 23:39:40 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:39:40 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v3 00/20] Enable QEMU TCI to run 32bit guests on browsers
Date: Mon, 28 Apr 2025 15:38:49 +0900
Message-ID: <cover.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62f.google.com
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

V3:

- Fixed the argument type of cpreg_key_compare to use gpointer instead of
  void*.
- Fixed the multiline comment to ensure it starts with "/*" on a separate
  line.
- Fixed the commit message to remove a confusing link in the
  util/cacheflush.c patch.
- Resolved patch conflicts against the latest upstream master branch in the
  gitlab CI configuration patch.
- The patches 01, 02, 03, 06, and 07 are included in this series sololy to
  ensure successful builds. They have already been picked up by the pull
  requests, so please ignore them.

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
 include/glib-compat.h                         |   7 +
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
 40 files changed, 710 insertions(+), 66 deletions(-)
 create mode 100644 configs/meson/emscripten.txt
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 create mode 100644 util/coroutine-wasm.c

-- 
2.43.0


