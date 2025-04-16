Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A04CC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xvR-0000t5-Ng; Wed, 16 Apr 2025 04:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvN-0000qZ-BN; Wed, 16 Apr 2025 04:15:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvI-0005Wh-Uj; Wed, 16 Apr 2025 04:15:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so6357465b3a.3; 
 Wed, 16 Apr 2025 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791304; x=1745396104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ING2HGFiKOFyUXL5i8qkzkYCFauLgKvXn4yhvf3BVL0=;
 b=jEE+rHuRpe7FjqwuGlw1t/2lKWZlDb+DN53RnZvBMo3tSIxRXj8HwTPX7RVv7kWUeP
 LEKT7JMOhfAAGA+MZtO+ex0eJb9VkGaQmDSg5R/Hvx8XwuHOFM3UJbK7wZ6c/F3XgRKw
 wQfpJJeWOjqtbCC7Pk2O5dVtpqP7KaIPSfNCX54ezy0eZYVL8owDlwvAQbLQ4/WYCPuu
 LFLmqqXROE2bYfs+zwRoy8iANGOKGLp4et0DNrXCTSWyOJ9a3BXBVQxirB62Y7Agu5L2
 dVK1iBAzwG/6O5KMm7F1MMGooOlTE52wCHX7Nn/A67t1L2Hd+ty8q0zRlNvBIZc7v+F/
 LI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791304; x=1745396104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ING2HGFiKOFyUXL5i8qkzkYCFauLgKvXn4yhvf3BVL0=;
 b=KISekQqXIl4c3UIFbvkn88FUgFHT5LIEcSfE+tj9CnC4c51dgkfQXwvdxPfnmYNRpk
 Usi1NMx7aPX7cGPIWvrq8gK9fZq5OToSW2FtRuPCcfbOhyeqN+JL5iCTtZMpnxLk9PS7
 qJsUdpGmGGTxKQCzn0NownZysb0Kz/Rxxp6vh+tZeAlrlnjXIl3qTMiWu5WE/qt4lFkj
 FjTgiD2CoefEiyH2y2+l6Lt0c15Wv8ebDayBdeFqJGnHEbZXp153PUyfgsTA0na9AnXB
 uoqyK8adPHsLINi0ovc+26XMPdEhUvgFu48w8g3We7eXGd5iGGkeWKDSYWsX/1jE1ict
 +urQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcI0786b4IXvUB5AVLuaxP9JyBVnfOA1EVM+lpAiLV2bJoeQ6j93IRd9bcbSZj4gMAgpsuvyUmCpkOpA==@nongnu.org,
 AJvYcCVXXvesCKHgBAOiWppf416v+wYxrPXFJz2baf/enVMAcd0E9OK7t+OZRqoqRXI+wExcjzTJgcQENA==@nongnu.org,
 AJvYcCX7E9LCMZQemOddAI29pnmNNl5d/H55IHgilFdiLotDwzPQ6m2rac4g6XzuWPuv6KTYd63kPTzAwGc=@nongnu.org,
 AJvYcCXWD/cr7hPy3uX9bEmZ1HSzUkbzuRkpfF0i7qfxBfcEoa0ghzMcJgePtSLaIb7AUp6EEm2OLlvdDx48/A==@nongnu.org
X-Gm-Message-State: AOJu0YzO5bBWmsF+hRAWeqIS3lBP3eFCwlEhydSYk31rB3FSJ9PfQ24p
 VXZXxR9RyR5C52lkLTaPGKsQKBMv9noGtOjiFzbK/OAIa/Wpkwj111hrzEGB
X-Gm-Gg: ASbGncuZo1wCrtPvrptD923feI7QMdCtOW/CP0wYB8RTKQQqidvpXe8WBOUCaXQ5WXa
 jx5V+RTSRHg1qFhzUitSvLxfO+CHF7zUBFdIqCjt7H7+QnNQ7TDeq40Tsp/4HQpaXTOrHjOMt6P
 A8HMjRBDxHlJH6wMvLBmD6wQItePs6cOgKfnlXqnNwnBtYvFX576ws6cdT/iR0BVuXwCO01pjEO
 jSkrMEOntlxTajIim1lVm2qXdhS3n130xdPvY8bJjIWvBgDwMekOGFlbsUWIpQ+at5kE9bccxGW
 ggqNtaqDz2bZFn44LA31pLN7x7S5jDQ77yi42a+5A85egAISsIGlyrvAWg==
X-Google-Smtp-Source: AGHT+IHAV4QzikLGi7SxmNgM9JTe3jUohlZ1WDwKBrs6Ev2Pjp40RsFBYFABVCha2SjKF/HNz2SXUA==
X-Received: by 2002:a05:6a00:801b:b0:736:5545:5b84 with SMTP id
 d2e1a72fcca58-73c266beee1mr1612181b3a.3.1744791303785; 
 Wed, 16 Apr 2025 01:15:03 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:03 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 00/19] Enable QEMU TCI to run 32bit guests on browsers
Date: Wed, 16 Apr 2025 17:14:05 +0900
Message-Id: <cover.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
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

Kohei Tokunaga (19):
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
  block: Update block to compile with Emscripten
  include/qemu/osdep.h: Add Emscripten-specific OS dependencies
  Disable options unsupported on Emscripten
  util/mmap-alloc: Add qemu_ram_mmap implementation for emscripten
  util: Add coroutine backend for emscripten
  meson: Add wasm build in build scripts
  gitlab: Enable CI for wasm build
  MAINTAINERS: Update MAINTAINERS file for wasm-related files

 .gitlab-ci.d/buildtest-template.yml           |  27 ++++
 .gitlab-ci.d/buildtest.yml                    |   9 ++
 .gitlab-ci.d/container-cross.yml              |   5 +
 MAINTAINERS                                   |  10 ++
 block/file-posix.c                            |   6 +
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
 include/qemu/cacheflush.h                     |   3 +-
 include/qemu/osdep.h                          |   8 +-
 include/system/os-posix.h                     |   3 +-
 include/system/os-wasm.h                      | 105 +++++++++++++
 meson.build                                   |  25 ++-
 meson_options.txt                             |   2 +-
 os-wasm.c                                     | 119 ++++++++++++++
 qemu-options.hx                               |   4 +-
 qom/object.c                                  |   7 +-
 scripts/meson-buildoptions.sh                 |   2 +-
 stubs/emscripten.c                            |  13 ++
 stubs/meson.build                             |   4 +
 system/vl.c                                   |   8 +-
 target/arm/helper.c                           |   4 +-
 target/i386/cpu.c                             |  11 +-
 target/ppc/cpu_init.c                         |   4 +-
 target/s390x/cpu_models.c                     |   4 +-
 .../dockerfiles/emsdk-wasm32-cross.docker     | 145 ++++++++++++++++++
 tests/tcg/plugins/mem.c                       |   4 +-
 tests/tcg/plugins/syscall.c                   |   4 +-
 util/cacheflush.c                             |   3 +-
 util/coroutine-wasm.c                         | 127 +++++++++++++++
 util/mmap-alloc.c                             |  18 +++
 39 files changed, 697 insertions(+), 58 deletions(-)
 create mode 100644 configs/meson/emscripten.txt
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c
 create mode 100644 stubs/emscripten.c
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 create mode 100644 util/coroutine-wasm.c

-- 
2.25.1


