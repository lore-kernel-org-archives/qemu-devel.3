Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCFBC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSVp-0008Up-Gn; Wed, 27 Mar 2024 08:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpSVk-0008PK-RH
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:36:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpSVe-0001Nv-Df
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:36:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41495dce900so2305515e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711542960; x=1712147760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dHPiCwQF79BPMModaOwYBf3OmPPjTsxZ6lTE9hUDCIY=;
 b=X4T5NrGmMOHzxMSwW2W9QtgYj5rhrJEasaqy8qh9qMQwXXcbNNjUGWs3M15G+gXc5J
 jNmQNHayGYoxOvhOILudJxdXE1wPZt/64wjATNeJtHFkQgcVtumY1Du5nbjCdzrtg5mL
 E9GV01Y3XYzbb7Bw02jj+soA0vXdbz5WPE8h+BCJipnJO3hIwwHhKeaCeW0vq5yVGsqv
 J0DQtAQWso1Zk/kMs+3un5iP8a3F6RlGj2/a/O5ga2gF2m0CxQGMSx+o9fg4J/Be4DfU
 fnmoffb+W2foPspBsGkq0aKP5VIKiyVTkJ9etjVdFVjehbIO/5p2PMi/8T40a/EPRU6i
 yxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711542960; x=1712147760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHPiCwQF79BPMModaOwYBf3OmPPjTsxZ6lTE9hUDCIY=;
 b=c5bshgyLpWx9g7cZQft8Yu5aEWDpaLbx5+WRdggZAnGStUH5/3IpuBFq97LN1Ff82w
 4cuQw5YUHIACEVQEpr+RtcL53fvtnrKUqVC3VcduGL2sYvQNOV/kdIWp6Jo6isqJQTdA
 KcMgk9KdVFU5jf4k68wS46o9EzWNxYO4iz3A8c/Z3JYlnhz1GqlR7vFfFTx5Lxqw52FR
 X5BCvtVP224631cI1Sq8gVRrc/2nY5f+JcWNeXINE3mpnYWhUx4YaCQOkkt8t+UTjWOk
 dD2vPmYiEh3GaCo9dgrjrfMIUwffh///Z2aDneyubNwHBZd6kjfpDSw2l3rSGCuHACfu
 T8Ow==
X-Gm-Message-State: AOJu0YyuwmTu9xmn0BXoAeKR5PbgvUkl+cyfbiTJ4N9+v7v4MVBskDuR
 UF0efuYuhwIQDgfPADuY52TPENw5RPzaTijLviNK/Ls83wiqYUxh9sIW98wlmLoAfHOCYqriY/P
 J
X-Google-Smtp-Source: AGHT+IEr/sqARWn6szSHrDpXdq+2XB3ycucFs9hbYoINMUKUnlSN1rE2mOR5bwQWVJAe/crb+dHGtA==
X-Received: by 2002:a05:600c:4506:b0:414:90ab:9d29 with SMTP id
 t6-20020a05600c450600b0041490ab9d29mr3259180wmo.0.1711542958640; 
 Wed, 27 Mar 2024 05:35:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 bl40-20020adfe268000000b0033e03d37685sm14701902wrb.55.2024.03.27.05.35.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 05:35:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 devel@lists.libvirt.org, Marek Vasut <marex@denx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH-for-9.1] target/nios2: Remove machines and system emulation
Date: Wed, 27 Mar 2024 13:35:53 +0100
Message-ID: <20240327123554.3633-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Remove the Nios II machines and the system emulation code
(deprecated since v8.2 in commit 9997771bc1 "target/nios2:
Deprecate the Nios II architecture").

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               |   4 -
 docs/about/deprecated.rst                 |   5 -
 docs/about/emulation.rst                  |   3 -
 docs/about/removed-features.rst           |   5 +
 docs/system/replay.rst                    |   2 +-
 configs/devices/nios2-softmmu/default.mak |   6 -
 configs/targets/nios2-softmmu.mak         |   2 -
 qapi/machine.json                         |   2 +-
 hw/nios2/boot.h                           |  10 -
 include/hw/intc/nios2_vic.h               |  66 ----
 include/sysemu/arch_init.h                |   1 -
 target/nios2/cpu-param.h                  |   6 +-
 target/nios2/cpu.h                        |  42 ---
 target/nios2/helper.h                     |   9 -
 target/nios2/mmu.h                        |  52 ---
 hw/intc/nios2_vic.c                       | 313 ------------------
 hw/nios2/10m50_devboard.c                 | 181 -----------
 hw/nios2/boot.c                           | 234 --------------
 hw/nios2/generic_nommu.c                  | 101 ------
 target/nios2/cpu.c                        | 160 +---------
 target/nios2/helper.c                     | 371 ----------------------
 target/nios2/mmu.c                        | 216 -------------
 target/nios2/monitor.c                    |  35 --
 target/nios2/nios2-semi.c                 | 230 --------------
 target/nios2/op_helper.c                  |  45 ---
 target/nios2/translate.c                  | 254 +--------------
 tests/qtest/machine-none-test.c           |   1 -
 .gitlab-ci.d/buildtest.yml                |   4 +-
 .gitlab-ci.d/crossbuilds.yml              |   2 +-
 hw/Kconfig                                |   1 -
 hw/intc/Kconfig                           |   3 -
 hw/intc/meson.build                       |   1 -
 hw/meson.build                            |   1 -
 hw/nios2/Kconfig                          |  13 -
 hw/nios2/meson.build                      |   6 -
 qemu-options.hx                           |   8 +-
 scripts/coverity-scan/COMPONENTS.md       |   2 +-
 target/nios2/meson.build                  |   9 -
 tests/avocado/boot_linux_console.py       |   8 -
 tests/avocado/replay_kernel.py            |  11 -
 tests/tcg/nios2/Makefile.softmmu-target   |  32 --
 tests/tcg/nios2/test-shadow-1.S           |  40 ---
 42 files changed, 24 insertions(+), 2473 deletions(-)
 delete mode 100644 configs/devices/nios2-softmmu/default.mak
 delete mode 100644 configs/targets/nios2-softmmu.mak
 delete mode 100644 hw/nios2/boot.h
 delete mode 100644 include/hw/intc/nios2_vic.h
 delete mode 100644 target/nios2/mmu.h
 delete mode 100644 hw/intc/nios2_vic.c
 delete mode 100644 hw/nios2/10m50_devboard.c
 delete mode 100644 hw/nios2/boot.c
 delete mode 100644 hw/nios2/generic_nommu.c
 delete mode 100644 target/nios2/helper.c
 delete mode 100644 target/nios2/mmu.c
 delete mode 100644 target/nios2/monitor.c
 delete mode 100644 target/nios2/nios2-semi.c
 delete mode 100644 hw/nios2/Kconfig
 delete mode 100644 hw/nios2/meson.build
 delete mode 100644 tests/tcg/nios2/Makefile.softmmu-target
 delete mode 100644 tests/tcg/nios2/test-shadow-1.S

diff --git a/MAINTAINERS b/MAINTAINERS
index a07af6b9d4..3b48fcf8d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,11 +296,7 @@ R: Chris Wulff <crwulff@gmail.com>
 R: Marek Vasut <marex@denx.de>
 S: Orphan
 F: target/nios2/
-F: hw/nios2/
-F: hw/intc/nios2_vic.c
 F: disas/nios2.c
-F: include/hw/intc/nios2_vic.h
-F: configs/devices/nios2-softmmu/default.mak
 F: tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
 F: tests/tcg/nios2/
 
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..0b709dfc72 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -226,11 +226,6 @@ These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
-Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The Nios II architecture is orphan.
-
 ``shix`` (since 9.0)
 ''''''''''''''''''''
 
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a2eefe3f3f..a7c185bbfb 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -180,9 +180,6 @@ for that architecture.
   * - MIPS
     - System
     - Unified Hosting Interface (MD01069)
-  * - Nios II
-    - System
-    - https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;hb=HEAD
   * - RISC-V
     - System and User-mode
     - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f9cf874f7b..43a9bfa29f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -841,6 +841,11 @@ ppc ``taihu`` machine (removed in 7.2)
 This machine was removed because it was partially emulated and 405
 machines are very similar. Use the ``ref405ep`` machine instead.
 
+Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (removed 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Nios II architecture is orphan.
+
 linux-user mode CPUs
 --------------------
 
diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index ca7c17c63d..28e5772a2b 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -24,7 +24,7 @@ Deterministic replay has the following features:
  * Writes execution log into the file for later replaying for multiple times
    on different machines.
  * Supports i386, x86_64, ARM, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
-   PowerPC, PowerPC64, M68000, Microblaze, OpenRISC, Nios II, SPARC,
+   PowerPC, PowerPC64, M68000, Microblaze, OpenRISC, SPARC,
    and Xtensa hardware platforms.
  * Performs deterministic replay of all operations with keyboard and mouse
    input devices, serial ports, and network.
diff --git a/configs/devices/nios2-softmmu/default.mak b/configs/devices/nios2-softmmu/default.mak
deleted file mode 100644
index e130d024e6..0000000000
--- a/configs/devices/nios2-softmmu/default.mak
+++ /dev/null
@@ -1,6 +0,0 @@
-# Default configuration for nios2-softmmu
-
-# Boards:
-#
-CONFIG_NIOS2_10M50=y
-CONFIG_NIOS2_GENERIC_NOMMU=y
diff --git a/configs/targets/nios2-softmmu.mak b/configs/targets/nios2-softmmu.mak
deleted file mode 100644
index c99ae3777e..0000000000
--- a/configs/targets/nios2-softmmu.mak
+++ /dev/null
@@ -1,2 +0,0 @@
-TARGET_ARCH=nios2
-TARGET_NEED_FDT=y
diff --git a/qapi/machine.json b/qapi/machine.json
index e8b60641f2..6ab713a4c4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -33,7 +33,7 @@
 { 'enum' : 'SysEmuTarget',
   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
-             'mips64el', 'mipsel', 'nios2', 'or1k', 'ppc',
+             'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore',
              'x86_64', 'xtensa', 'xtensaeb' ] }
diff --git a/hw/nios2/boot.h b/hw/nios2/boot.h
deleted file mode 100644
index 59b9fbfc62..0000000000
--- a/hw/nios2/boot.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef NIOS2_BOOT_H
-#define NIOS2_BOOT_H
-
-#include "cpu.h"
-
-void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base, uint32_t ramsize,
-                       const char *initrd_filename, const char *dtb_filename,
-                       void (*machine_cpu_reset)(Nios2CPU *));
-
-#endif /* NIOS2_BOOT_H */
diff --git a/include/hw/intc/nios2_vic.h b/include/hw/intc/nios2_vic.h
deleted file mode 100644
index 5c975a2ac4..0000000000
--- a/include/hw/intc/nios2_vic.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Vectored Interrupt Controller for nios2 processor
- *
- * Copyright (c) 2022 Neuroblade
- *
- * Interface:
- * QOM property "cpu": link to the Nios2 CPU (must be set)
- * Unnamed GPIO inputs 0..NIOS2_VIC_MAX_IRQ-1: input IRQ lines
- * IRQ should be connected to nios2 IRQ0.
- *
- * Reference: "Embedded Peripherals IP User Guide
- *             for Intel® Quartus® Prime Design Suite: 21.4"
- * Chapter 38 "Vectored Interrupt Controller Core"
- * See: https://www.intel.com/content/www/us/en/docs/programmable/683130/21-4/vectored-interrupt-controller-core.html
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef HW_INTC_NIOS2_VIC_H
-#define HW_INTC_NIOS2_VIC_H
-
-#include "hw/sysbus.h"
-
-#define TYPE_NIOS2_VIC "nios2-vic"
-OBJECT_DECLARE_SIMPLE_TYPE(Nios2VIC, NIOS2_VIC)
-
-#define NIOS2_VIC_MAX_IRQ 32
-
-struct Nios2VIC {
-    /*< private >*/
-    SysBusDevice parent_obj;
-
-    /*< public >*/
-    qemu_irq output_int;
-
-    /* properties */
-    CPUState *cpu;
-    MemoryRegion csr;
-
-    uint32_t int_config[NIOS2_VIC_MAX_IRQ];
-    uint32_t vic_config;
-    uint32_t int_raw_status;
-    uint32_t int_enable;
-    uint32_t sw_int;
-    uint32_t vic_status;
-    uint32_t vec_tbl_base;
-    uint32_t vec_tbl_addr;
-};
-
-#endif /* HW_INTC_NIOS2_VIC_H */
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8850cb1a14..8d041aa84e 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -18,7 +18,6 @@ enum {
     QEMU_ARCH_XTENSA = (1 << 12),
     QEMU_ARCH_OPENRISC = (1 << 13),
     QEMU_ARCH_TRICORE = (1 << 16),
-    QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
     QEMU_ARCH_RX = (1 << 20),
diff --git a/target/nios2/cpu-param.h b/target/nios2/cpu-param.h
index 767bba4b7b..9fe9a97a6c 100644
--- a/target/nios2/cpu-param.h
+++ b/target/nios2/cpu-param.h
@@ -11,10 +11,6 @@
 #define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 12
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
-#ifdef CONFIG_USER_ONLY
-# define TARGET_VIRT_ADDR_SPACE_BITS 31
-#else
-# define TARGET_VIRT_ADDR_SPACE_BITS 32
-#endif
+#define TARGET_VIRT_ADDR_SPACE_BITS 31
 
 #endif
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 4164a3432e..2969b116d5 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -26,9 +26,6 @@
 #include "hw/registerfields.h"
 
 typedef struct CPUArchState CPUNios2State;
-#if !defined(CONFIG_USER_ONLY)
-#include "mmu.h"
-#endif
 
 /**
  * Nios2CPUClass:
@@ -179,19 +176,10 @@ FIELD(CR_TLBMISC, EE, 24, 1)
 #define EXCP_MPUD     17
 
 struct CPUArchState {
-#ifdef CONFIG_USER_ONLY
     uint32_t regs[NUM_GP_REGS];
-#else
-    uint32_t shadow_regs[NUM_REG_SETS][NUM_GP_REGS];
-    /* Pointer into shadow_regs for the current register set. */
-    uint32_t *regs;
-#endif
     uint32_t ctrl[NUM_CR_REGS];
     uint32_t pc;
 
-#if !defined(CONFIG_USER_ONLY)
-    Nios2MMU mmu;
-#endif
     int error_code;
 };
 
@@ -212,17 +200,9 @@ struct ArchCPU {
     CPUNios2State env;
 
     bool diverr_present;
-    bool mmu_present;
-    bool eic_present;
-
-    uint32_t pid_num_bits;
-    uint32_t tlb_num_ways;
-    uint32_t tlb_num_entries;
 
     /* Addresses that are hard-coded in the FPGA build settings */
     uint32_t reset_addr;
-    uint32_t exception_addr;
-    uint32_t fast_tlb_miss_addr;
 
     /* Bits within each control register which are reserved or readonly. */
     ControlRegState cr_state[NUM_CR_REGS];
@@ -240,26 +220,11 @@ static inline bool nios2_cr_reserved(const ControlRegState *s)
     return (s->writable | s->readonly) == 0;
 }
 
-static inline void nios2_update_crs(CPUNios2State *env)
-{
-#ifndef CONFIG_USER_ONLY
-    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
-    env->regs = env->shadow_regs[crs];
-#endif
-}
-
 void nios2_tcg_init(void);
-void nios2_cpu_do_interrupt(CPUState *cs);
-void dump_mmu(CPUNios2State *env);
 void nios2_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-G_NORETURN void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
-                                              MMUAccessType access_type, int mmu_idx,
-                                              uintptr_t retaddr);
 G_NORETURN void nios2_cpu_loop_exit_advance(CPUNios2State *env,
                                             uintptr_t retaddr);
 
-void do_nios2_semihosting(CPUNios2State *env);
-
 #define CPU_RESOLVING_TYPE TYPE_NIOS2_CPU
 
 #define cpu_gen_code cpu_nios2_gen_code
@@ -270,13 +235,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-#ifndef CONFIG_USER_ONLY
-hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr);
-#endif
-
 typedef CPUNios2State CPUArchState;
 typedef Nios2CPU ArchCPU;
 
diff --git a/target/nios2/helper.h b/target/nios2/helper.h
index 1648d76ade..a4513ec669 100644
--- a/target/nios2/helper.h
+++ b/target/nios2/helper.h
@@ -21,12 +21,3 @@
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, s32, env, s32, s32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
-
-#if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_3(eret, noreturn, env, i32, i32)
-DEF_HELPER_FLAGS_2(rdprs, TCG_CALL_NO_WG, i32, env, i32)
-DEF_HELPER_3(wrprs, void, env, i32, i32)
-DEF_HELPER_2(mmu_write_tlbacc, void, env, i32)
-DEF_HELPER_2(mmu_write_tlbmisc, void, env, i32)
-DEF_HELPER_2(mmu_write_pteaddr, void, env, i32)
-#endif
diff --git a/target/nios2/mmu.h b/target/nios2/mmu.h
deleted file mode 100644
index 5b085900fb..0000000000
--- a/target/nios2/mmu.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Altera Nios II MMU emulation for qemu.
- *
- * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#ifndef NIOS2_MMU_H
-#define NIOS2_MMU_H
-
-#include "cpu.h"
-
-typedef struct Nios2TLBEntry {
-    target_ulong tag;
-    target_ulong data;
-} Nios2TLBEntry;
-
-typedef struct Nios2MMU {
-    int tlb_entry_mask;
-    uint32_t pteaddr_wr;
-    uint32_t tlbacc_wr;
-    uint32_t tlbmisc_wr;
-    Nios2TLBEntry *tlb;
-} Nios2MMU;
-
-typedef struct Nios2MMULookup {
-    target_ulong vaddr;
-    target_ulong paddr;
-    int prot;
-} Nios2MMULookup;
-
-void mmu_flip_um(CPUNios2State *env, unsigned int um);
-unsigned int mmu_translate(CPUNios2State *env,
-                           Nios2MMULookup *lu,
-                           target_ulong vaddr, int rw, int mmu_idx);
-void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v);
-void mmu_init(CPUNios2State *env);
-
-#endif /* NIOS2_MMU_H */
diff --git a/hw/intc/nios2_vic.c b/hw/intc/nios2_vic.c
deleted file mode 100644
index 7e2d9d6327..0000000000
--- a/hw/intc/nios2_vic.c
+++ /dev/null
@@ -1,313 +0,0 @@
-/*
- * Vectored Interrupt Controller for nios2 processor
- *
- * Copyright (c) 2022 Neuroblade
- *
- * Interface:
- * QOM property "cpu": link to the Nios2 CPU (must be set)
- * Unnamed GPIO inputs 0..NIOS2_VIC_MAX_IRQ-1: input IRQ lines
- * IRQ should be connected to nios2 IRQ0.
- *
- * Reference: "Embedded Peripherals IP User Guide
- *             for Intel® Quartus® Prime Design Suite: 21.4"
- * Chapter 38 "Vectored Interrupt Controller Core"
- * See: https://www.intel.com/content/www/us/en/docs/programmable/683130/21-4/vectored-interrupt-controller-core.html
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "hw/sysbus.h"
-#include "migration/vmstate.h"
-#include "qapi/error.h"
-#include "qemu/bitops.h"
-#include "qemu/log.h"
-#include "qom/object.h"
-#include "hw/intc/nios2_vic.h"
-#include "cpu.h"
-
-
-enum {
-    INT_CONFIG0 = 0,
-    INT_CONFIG31 = 31,
-    INT_ENABLE = 32,
-    INT_ENABLE_SET = 33,
-    INT_ENABLE_CLR = 34,
-    INT_PENDING = 35,
-    INT_RAW_STATUS = 36,
-    SW_INTERRUPT = 37,
-    SW_INTERRUPT_SET = 38,
-    SW_INTERRUPT_CLR = 39,
-    VIC_CONFIG = 40,
-    VIC_STATUS = 41,
-    VEC_TBL_BASE = 42,
-    VEC_TBL_ADDR = 43,
-    CSR_COUNT /* Last! */
-};
-
-/* Requested interrupt level (INT_CONFIG[0:5]) */
-static inline uint32_t vic_int_config_ril(const Nios2VIC *vic, int irq_num)
-{
-    return extract32(vic->int_config[irq_num], 0, 6);
-}
-
-/* Requested NMI (INT_CONFIG[6]) */
-static inline uint32_t vic_int_config_rnmi(const Nios2VIC *vic, int irq_num)
-{
-    return extract32(vic->int_config[irq_num], 6, 1);
-}
-
-/* Requested register set (INT_CONFIG[7:12]) */
-static inline uint32_t vic_int_config_rrs(const Nios2VIC *vic, int irq_num)
-{
-    return extract32(vic->int_config[irq_num], 7, 6);
-}
-
-static inline uint32_t vic_config_vec_size(const Nios2VIC *vic)
-{
-    return 1 << (2 + extract32(vic->vic_config, 0, 3));
-}
-
-static inline uint32_t vic_int_pending(const Nios2VIC *vic)
-{
-    return (vic->int_raw_status | vic->sw_int) & vic->int_enable;
-}
-
-static void vic_update_irq(Nios2VIC *vic)
-{
-    Nios2CPU *cpu = NIOS2_CPU(vic->cpu);
-    uint32_t pending = vic_int_pending(vic);
-    int irq = -1;
-    int max_ril = 0;
-    /* Note that if RIL is 0 for an interrupt it is effectively disabled */
-
-    vic->vec_tbl_addr = 0;
-    vic->vic_status = 0;
-
-    if (pending == 0) {
-        qemu_irq_lower(vic->output_int);
-        return;
-    }
-
-    for (int i = 0; i < NIOS2_VIC_MAX_IRQ; i++) {
-        if (pending & BIT(i)) {
-            int ril = vic_int_config_ril(vic, i);
-            if (ril > max_ril) {
-                irq = i;
-                max_ril = ril;
-            }
-        }
-    }
-
-    if (irq < 0) {
-        qemu_irq_lower(vic->output_int);
-        return;
-    }
-
-    vic->vec_tbl_addr = irq * vic_config_vec_size(vic) + vic->vec_tbl_base;
-    vic->vic_status = irq | BIT(31);
-
-    /*
-     * In hardware, the interface between the VIC and the CPU is via the
-     * External Interrupt Controller interface, where the interrupt controller
-     * presents the CPU with a packet of data containing:
-     *  - Requested Handler Address (RHA): 32 bits
-     *  - Requested Register Set (RRS) : 6 bits
-     *  - Requested Interrupt Level (RIL) : 6 bits
-     *  - Requested NMI flag (RNMI) : 1 bit
-     * In our emulation, we implement this by writing the data directly to
-     * fields in the CPU object and then raising the IRQ line to tell
-     * the CPU that we've done so.
-     */
-
-    cpu->rha = vic->vec_tbl_addr;
-    cpu->ril = max_ril;
-    cpu->rrs = vic_int_config_rrs(vic, irq);
-    cpu->rnmi = vic_int_config_rnmi(vic, irq);
-
-    qemu_irq_raise(vic->output_int);
-}
-
-static void vic_set_irq(void *opaque, int irq_num, int level)
-{
-    Nios2VIC *vic = opaque;
-
-    vic->int_raw_status = deposit32(vic->int_raw_status, irq_num, 1, !!level);
-    vic_update_irq(vic);
-}
-
-static void nios2_vic_reset(DeviceState *dev)
-{
-    Nios2VIC *vic = NIOS2_VIC(dev);
-
-    memset(&vic->int_config, 0, sizeof(vic->int_config));
-    vic->vic_config = 0;
-    vic->int_raw_status = 0;
-    vic->int_enable = 0;
-    vic->sw_int = 0;
-    vic->vic_status = 0;
-    vic->vec_tbl_base = 0;
-    vic->vec_tbl_addr = 0;
-}
-
-static uint64_t nios2_vic_csr_read(void *opaque, hwaddr offset, unsigned size)
-{
-    Nios2VIC *vic = opaque;
-    int index = offset / 4;
-
-    switch (index) {
-    case INT_CONFIG0 ... INT_CONFIG31:
-        return vic->int_config[index - INT_CONFIG0];
-    case INT_ENABLE:
-        return vic->int_enable;
-    case INT_PENDING:
-        return vic_int_pending(vic);
-    case INT_RAW_STATUS:
-        return vic->int_raw_status;
-    case SW_INTERRUPT:
-        return vic->sw_int;
-    case VIC_CONFIG:
-        return vic->vic_config;
-    case VIC_STATUS:
-        return vic->vic_status;
-    case VEC_TBL_BASE:
-        return vic->vec_tbl_base;
-    case VEC_TBL_ADDR:
-        return vic->vec_tbl_addr;
-    default:
-        return 0;
-    }
-}
-
-static void nios2_vic_csr_write(void *opaque, hwaddr offset, uint64_t value,
-                                unsigned size)
-{
-    Nios2VIC *vic = opaque;
-    int index = offset / 4;
-
-    switch (index) {
-    case INT_CONFIG0 ... INT_CONFIG31:
-        vic->int_config[index - INT_CONFIG0] = value;
-        break;
-    case INT_ENABLE:
-        vic->int_enable = value;
-        break;
-    case INT_ENABLE_SET:
-        vic->int_enable |= value;
-        break;
-    case INT_ENABLE_CLR:
-        vic->int_enable &= ~value;
-        break;
-    case SW_INTERRUPT:
-        vic->sw_int = value;
-        break;
-    case SW_INTERRUPT_SET:
-        vic->sw_int |= value;
-        break;
-    case SW_INTERRUPT_CLR:
-        vic->sw_int &= ~value;
-        break;
-    case VIC_CONFIG:
-        vic->vic_config = value;
-        break;
-    case VEC_TBL_BASE:
-        vic->vec_tbl_base = value;
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "nios2-vic: write to invalid CSR address %#"
-                      HWADDR_PRIx "\n", offset);
-    }
-
-    vic_update_irq(vic);
-}
-
-static const MemoryRegionOps nios2_vic_csr_ops = {
-    .read = nios2_vic_csr_read,
-    .write = nios2_vic_csr_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = { .min_access_size = 4, .max_access_size = 4 }
-};
-
-static void nios2_vic_realize(DeviceState *dev, Error **errp)
-{
-    Nios2VIC *vic = NIOS2_VIC(dev);
-
-    if (!vic->cpu) {
-        /* This is a programming error in the code using this device */
-        error_setg(errp, "nios2-vic 'cpu' link property was not set");
-        return;
-    }
-
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &vic->output_int);
-    qdev_init_gpio_in(dev, vic_set_irq, NIOS2_VIC_MAX_IRQ);
-
-    memory_region_init_io(&vic->csr, OBJECT(dev), &nios2_vic_csr_ops, vic,
-                          "nios2.vic.csr", CSR_COUNT * sizeof(uint32_t));
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &vic->csr);
-}
-
-static Property nios2_vic_properties[] = {
-    DEFINE_PROP_LINK("cpu", Nios2VIC, cpu, TYPE_CPU, CPUState *),
-    DEFINE_PROP_END_OF_LIST()
-};
-
-static const VMStateDescription nios2_vic_vmstate = {
-    .name = "nios2-vic",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]){
-        VMSTATE_UINT32_ARRAY(int_config, Nios2VIC, 32),
-        VMSTATE_UINT32(vic_config, Nios2VIC),
-        VMSTATE_UINT32(int_raw_status, Nios2VIC),
-        VMSTATE_UINT32(int_enable, Nios2VIC),
-        VMSTATE_UINT32(sw_int, Nios2VIC),
-        VMSTATE_UINT32(vic_status, Nios2VIC),
-        VMSTATE_UINT32(vec_tbl_base, Nios2VIC),
-        VMSTATE_UINT32(vec_tbl_addr, Nios2VIC),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static void nios2_vic_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->reset = nios2_vic_reset;
-    dc->realize = nios2_vic_realize;
-    dc->vmsd = &nios2_vic_vmstate;
-    device_class_set_props(dc, nios2_vic_properties);
-}
-
-static const TypeInfo nios2_vic_info = {
-    .name = TYPE_NIOS2_VIC,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(Nios2VIC),
-    .class_init = nios2_vic_class_init,
-};
-
-static void nios2_vic_register_types(void)
-{
-    type_register_static(&nios2_vic_info);
-}
-
-type_init(nios2_vic_register_types);
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
deleted file mode 100644
index 6cb32f777b..0000000000
--- a/hw/nios2/10m50_devboard.c
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- * Altera 10M50 Nios2 GHRD
- *
- * Copyright (c) 2016 Marek Vasut <marek.vasut@gmail.com>
- *
- * Based on LabX device code
- *
- * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-
-#include "hw/sysbus.h"
-#include "hw/char/serial.h"
-#include "hw/intc/nios2_vic.h"
-#include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
-#include "hw/boards.h"
-#include "exec/memory.h"
-#include "exec/address-spaces.h"
-#include "qemu/config-file.h"
-
-#include "boot.h"
-
-struct Nios2MachineState {
-    MachineState parent_obj;
-
-    MemoryRegion phys_tcm;
-    MemoryRegion phys_tcm_alias;
-    MemoryRegion phys_ram;
-    MemoryRegion phys_ram_alias;
-
-    bool vic;
-};
-
-#define TYPE_NIOS2_MACHINE  MACHINE_TYPE_NAME("10m50-ghrd")
-OBJECT_DECLARE_TYPE(Nios2MachineState, MachineClass, NIOS2_MACHINE)
-
-#define BINARY_DEVICE_TREE_FILE    "10m50-devboard.dtb"
-
-static void nios2_10m50_ghrd_init(MachineState *machine)
-{
-    Nios2MachineState *nms = NIOS2_MACHINE(machine);
-    Nios2CPU *cpu;
-    DeviceState *dev;
-    MemoryRegion *address_space_mem = get_system_memory();
-    ram_addr_t tcm_base = 0x0;
-    ram_addr_t tcm_size = 0x1000;    /* 1 kiB, but QEMU limit is 4 kiB */
-    ram_addr_t ram_base = 0x08000000;
-    ram_addr_t ram_size = 0x08000000;
-    qemu_irq irq[32];
-    int i;
-
-    /* Physical TCM (tb_ram_1k) with alias at 0xc0000000 */
-    memory_region_init_ram(&nms->phys_tcm, NULL, "nios2.tcm", tcm_size,
-                           &error_abort);
-    memory_region_init_alias(&nms->phys_tcm_alias, NULL, "nios2.tcm.alias",
-                             &nms->phys_tcm, 0, tcm_size);
-    memory_region_add_subregion(address_space_mem, tcm_base, &nms->phys_tcm);
-    memory_region_add_subregion(address_space_mem, 0xc0000000 + tcm_base,
-                                &nms->phys_tcm_alias);
-
-    /* Physical DRAM with alias at 0xc0000000 */
-    memory_region_init_ram(&nms->phys_ram, NULL, "nios2.ram", ram_size,
-                           &error_abort);
-    memory_region_init_alias(&nms->phys_ram_alias, NULL, "nios2.ram.alias",
-                             &nms->phys_ram, 0, ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, &nms->phys_ram);
-    memory_region_add_subregion(address_space_mem, 0xc0000000 + ram_base,
-                                &nms->phys_ram_alias);
-
-    /* Create CPU.  We need to set eic_present between init and realize. */
-    cpu = NIOS2_CPU(object_new(TYPE_NIOS2_CPU));
-
-    /* Enable the External Interrupt Controller within the CPU. */
-    cpu->eic_present = nms->vic;
-
-    /* Configure new exception vectors. */
-    cpu->reset_addr = 0xd4000000;
-    cpu->exception_addr = 0xc8000120;
-    cpu->fast_tlb_miss_addr = 0xc0000100;
-
-    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
-
-    if (nms->vic) {
-        dev = qdev_new(TYPE_NIOS2_VIC);
-        MemoryRegion *dev_mr;
-        qemu_irq cpu_irq;
-
-        object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-        cpu_irq = qdev_get_gpio_in_named(DEVICE(cpu), "EIC", 0);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq);
-        for (i = 0; i < 32; i++) {
-            irq[i] = qdev_get_gpio_in(dev, i);
-        }
-
-        dev_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(address_space_mem, 0x18002000, dev_mr);
-    } else {
-        for (i = 0; i < 32; i++) {
-            irq[i] = qdev_get_gpio_in_named(DEVICE(cpu), "IRQ", i);
-        }
-    }
-
-    /* Register: Altera 16550 UART */
-    serial_mm_init(address_space_mem, 0xf8001600, 2, irq[1], 115200,
-                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
-
-    /* Register: Timer sys_clk_timer  */
-    dev = qdev_new("ALTR.timer");
-    qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xf8001440);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[0]);
-
-    /* Register: Timer sys_clk_timer_1  */
-    dev = qdev_new("ALTR.timer");
-    qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xe0000880);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[5]);
-
-    nios2_load_kernel(cpu, ram_base, ram_size, machine->initrd_filename,
-                      BINARY_DEVICE_TREE_FILE, NULL);
-}
-
-static bool get_vic(Object *obj, Error **errp)
-{
-    Nios2MachineState *nms = NIOS2_MACHINE(obj);
-    return nms->vic;
-}
-
-static void set_vic(Object *obj, bool value, Error **errp)
-{
-    Nios2MachineState *nms = NIOS2_MACHINE(obj);
-    nms->vic = value;
-}
-
-static void nios2_10m50_ghrd_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Altera 10M50 GHRD Nios II design";
-    mc->init = nios2_10m50_ghrd_init;
-    mc->is_default = true;
-    mc->deprecation_reason = "Nios II architecture is deprecated";
-
-    object_class_property_add_bool(oc, "vic", get_vic, set_vic);
-    object_class_property_set_description(oc, "vic",
-        "Set on/off to enable/disable the Vectored Interrupt Controller");
-}
-
-static const TypeInfo nios2_10m50_ghrd_type_info = {
-    .name          = TYPE_NIOS2_MACHINE,
-    .parent        = TYPE_MACHINE,
-    .instance_size = sizeof(Nios2MachineState),
-    .class_init    = nios2_10m50_ghrd_class_init,
-};
-
-static void nios2_10m50_ghrd_type_init(void)
-{
-    type_register_static(&nios2_10m50_ghrd_type_info);
-}
-type_init(nios2_10m50_ghrd_type_init);
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
deleted file mode 100644
index cd75803fc2..0000000000
--- a/hw/nios2/boot.c
+++ /dev/null
@@ -1,234 +0,0 @@
-/*
- * Nios2 kernel loader
- *
- * Copyright (c) 2016 Marek Vasut <marek.vasut@gmail.com>
- *
- * Based on microblaze kernel loader
- *
- * Copyright (c) 2012 Peter Crosthwaite <peter.crosthwaite@petalogix.com>
- * Copyright (c) 2012 PetaLogix
- * Copyright (c) 2009 Edgar E. Iglesias.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "qemu/datadir.h"
-#include "qemu/option.h"
-#include "qemu/config-file.h"
-#include "qemu/error-report.h"
-#include "qemu/guest-random.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/reset.h"
-#include "hw/boards.h"
-#include "hw/loader.h"
-#include "elf.h"
-
-#include "boot.h"
-
-#include <libfdt.h>
-
-#define NIOS2_MAGIC    0x534f494e
-
-static struct nios2_boot_info {
-    void (*machine_cpu_reset)(Nios2CPU *);
-    uint32_t bootstrap_pc;
-    uint32_t cmdline;
-    uint32_t initrd_start;
-    uint32_t initrd_end;
-    uint32_t fdt;
-} boot_info;
-
-static void main_cpu_reset(void *opaque)
-{
-    Nios2CPU *cpu = opaque;
-    CPUState *cs = CPU(cpu);
-    CPUNios2State *env = &cpu->env;
-
-    cpu_reset(CPU(cpu));
-
-    env->regs[R_ARG0] = NIOS2_MAGIC;
-    env->regs[R_ARG1] = boot_info.initrd_start;
-    env->regs[R_ARG2] = boot_info.fdt;
-    env->regs[R_ARG3] = boot_info.cmdline;
-
-    cpu_set_pc(cs, boot_info.bootstrap_pc);
-    if (boot_info.machine_cpu_reset) {
-        boot_info.machine_cpu_reset(cpu);
-    }
-}
-
-static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
-{
-    return addr - 0xc0000000LL;
-}
-
-static int nios2_load_dtb(struct nios2_boot_info bi, const uint32_t ramsize,
-                          const char *kernel_cmdline, const char *dtb_filename)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    int fdt_size;
-    void *fdt = NULL;
-    int r;
-    uint8_t rng_seed[32];
-
-    if (dtb_filename) {
-        fdt = load_device_tree(dtb_filename, &fdt_size);
-    }
-    if (!fdt) {
-        return 0;
-    }
-
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
-
-    if (kernel_cmdline) {
-        r = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                                    kernel_cmdline);
-        if (r < 0) {
-            fprintf(stderr, "couldn't set /chosen/bootargs\n");
-        }
-    }
-
-    if (bi.initrd_start) {
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
-                              translate_kernel_address(NULL, bi.initrd_start));
-
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                              translate_kernel_address(NULL, bi.initrd_end));
-    }
-
-    cpu_physical_memory_write(bi.fdt, fdt, fdt_size);
-
-    /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
-    machine->fdt = fdt;
-
-    return fdt_size;
-}
-
-void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
-                            uint32_t ramsize,
-                            const char *initrd_filename,
-                            const char *dtb_filename,
-                            void (*machine_cpu_reset)(Nios2CPU *))
-{
-    const char *kernel_filename;
-    const char *kernel_cmdline;
-    const char *dtb_arg;
-    char *filename = NULL;
-
-    kernel_filename = current_machine->kernel_filename;
-    kernel_cmdline = current_machine->kernel_cmdline;
-    dtb_arg = current_machine->dtb;
-    /* default to pcbios dtb as passed by machine_init */
-    if (!dtb_arg) {
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
-    }
-
-    boot_info.machine_cpu_reset = machine_cpu_reset;
-    qemu_register_reset(main_cpu_reset, cpu);
-
-    if (kernel_filename) {
-        int kernel_size, fdt_size;
-        uint64_t entry, high;
-
-        /* Boots a kernel elf binary. */
-        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, NULL, &high, NULL,
-                               TARGET_BIG_ENDIAN, EM_ALTERA_NIOS2, 0, 0);
-        if ((uint32_t)entry == 0xc0000000) {
-            /*
-             * The Nios II processor reference guide documents that the
-             * kernel is placed at virtual memory address 0xc0000000,
-             * and we've got something that points there.  Reload it
-             * and adjust the entry to get the address in physical RAM.
-             */
-            kernel_size = load_elf(kernel_filename, NULL,
-                                   translate_kernel_address, NULL,
-                                   &entry, NULL, NULL, NULL,
-                                   TARGET_BIG_ENDIAN, EM_ALTERA_NIOS2, 0, 0);
-            boot_info.bootstrap_pc = ddr_base + 0xc0000000 +
-                (entry & 0x07ffffff);
-        } else {
-            /* Use the entry point in the ELF image.  */
-            boot_info.bootstrap_pc = (uint32_t)entry;
-        }
-
-        /* If it wasn't an ELF image, try an u-boot image. */
-        if (kernel_size < 0) {
-            hwaddr uentry, loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
-
-            kernel_size = load_uimage(kernel_filename, &uentry, &loadaddr, 0,
-                                      NULL, NULL);
-            boot_info.bootstrap_pc = uentry;
-            high = loadaddr + kernel_size;
-        }
-
-        /* Not an ELF image nor an u-boot image, try a RAW image. */
-        if (kernel_size < 0) {
-            kernel_size = load_image_targphys(kernel_filename, ddr_base,
-                                              ramsize);
-            boot_info.bootstrap_pc = ddr_base;
-            high = ddr_base + kernel_size;
-        }
-
-        high = ROUND_UP(high, 1 * MiB);
-
-        /* If initrd is available, it goes after the kernel, aligned to 1M. */
-        if (initrd_filename) {
-            int initrd_size;
-            uint32_t initrd_offset;
-
-            boot_info.initrd_start = high;
-            initrd_offset = boot_info.initrd_start - ddr_base;
-
-            initrd_size = load_ramdisk(initrd_filename,
-                                       boot_info.initrd_start,
-                                       ramsize - initrd_offset);
-            if (initrd_size < 0) {
-                initrd_size = load_image_targphys(initrd_filename,
-                                                  boot_info.initrd_start,
-                                                  ramsize - initrd_offset);
-            }
-            if (initrd_size < 0) {
-                error_report("could not load initrd '%s'",
-                             initrd_filename);
-                exit(EXIT_FAILURE);
-            }
-            high += initrd_size;
-        }
-        high = ROUND_UP(high, 4);
-        boot_info.initrd_end = high;
-
-        /* Device tree must be placed right after initrd (if available) */
-        boot_info.fdt = high;
-        fdt_size = nios2_load_dtb(boot_info, ramsize, kernel_cmdline,
-                                  /* Preference a -dtb argument */
-                                  dtb_arg ? dtb_arg : filename);
-        high += fdt_size;
-
-        /* Kernel command is at the end, 4k aligned. */
-        boot_info.cmdline = ROUND_UP(high, 4 * KiB);
-        if (kernel_cmdline && strlen(kernel_cmdline)) {
-            pstrcpy_targphys("cmdline", boot_info.cmdline, 256, kernel_cmdline);
-        }
-    }
-    g_free(filename);
-}
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
deleted file mode 100644
index defa16953f..0000000000
--- a/hw/nios2/generic_nommu.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * Generic simulator target with no MMU or devices.  This emulation is
- * compatible with the libgloss qemu-hosted.ld linker script for using
- * QEMU as an instruction set simulator.
- *
- * Copyright (c) 2018-2019 Mentor Graphics
- *
- * Copyright (c) 2016 Marek Vasut <marek.vasut@gmail.com>
- *
- * Based on LabX device code
- *
- * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-
-#include "hw/char/serial.h"
-#include "hw/boards.h"
-#include "exec/memory.h"
-#include "exec/address-spaces.h"
-#include "qemu/config-file.h"
-
-#include "boot.h"
-
-#define BINARY_DEVICE_TREE_FILE    "generic-nommu.dtb"
-
-static void nios2_generic_nommu_init(MachineState *machine)
-{
-    Nios2CPU *cpu;
-    MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *phys_tcm = g_new(MemoryRegion, 1);
-    MemoryRegion *phys_tcm_alias = g_new(MemoryRegion, 1);
-    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
-    MemoryRegion *phys_ram_alias = g_new(MemoryRegion, 1);
-    ram_addr_t tcm_base = 0x0;
-    ram_addr_t tcm_size = 0x1000;    /* 1 kiB, but QEMU limit is 4 kiB */
-    ram_addr_t ram_base = 0x10000000;
-    ram_addr_t ram_size = 0x08000000;
-
-    /* Physical TCM (tb_ram_1k) with alias at 0xc0000000 */
-    memory_region_init_ram(phys_tcm, NULL, "nios2.tcm", tcm_size,
-                           &error_abort);
-    memory_region_init_alias(phys_tcm_alias, NULL, "nios2.tcm.alias",
-                             phys_tcm, 0, tcm_size);
-    memory_region_add_subregion(address_space_mem, tcm_base, phys_tcm);
-    memory_region_add_subregion(address_space_mem, 0xc0000000 + tcm_base,
-                                phys_tcm_alias);
-
-    /* Physical DRAM with alias at 0xc0000000 */
-    memory_region_init_ram(phys_ram, NULL, "nios2.ram", ram_size,
-                           &error_abort);
-    memory_region_init_alias(phys_ram_alias, NULL, "nios2.ram.alias",
-                             phys_ram, 0, ram_size);
-    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
-    memory_region_add_subregion(address_space_mem, 0xc0000000 + ram_base,
-                                phys_ram_alias);
-
-    cpu = NIOS2_CPU(cpu_create(TYPE_NIOS2_CPU));
-
-    /* Remove MMU */
-    cpu->mmu_present = false;
-
-    /* Reset vector is the first 32 bytes of RAM.  */
-    cpu->reset_addr = ram_base;
-
-    /* The interrupt vector comes right after reset.  */
-    cpu->exception_addr = ram_base + 0x20;
-
-    /*
-     * The linker script does have a TLB miss memory region declared,
-     * but this should never be used with no MMU.
-     */
-    cpu->fast_tlb_miss_addr = 0x7fff400;
-
-    nios2_load_kernel(cpu, ram_base, ram_size, machine->initrd_filename,
-                      BINARY_DEVICE_TREE_FILE, NULL);
-}
-
-static void nios2_generic_nommu_machine_init(struct MachineClass *mc)
-{
-    mc->desc = "Generic NOMMU Nios II design";
-    mc->init = nios2_generic_nommu_init;
-    mc->deprecation_reason = "Nios II architecture is deprecated";
-}
-
-DEFINE_MACHINE("nios2-generic-nommu", nios2_generic_nommu_machine_init);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 679aff5730..621f32f4a7 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -68,53 +68,9 @@ static void nios2_cpu_reset_hold(Object *obj)
     memset(env->ctrl, 0, sizeof(env->ctrl));
     env->pc = cpu->reset_addr;
 
-#if defined(CONFIG_USER_ONLY)
     /* Start in user mode with interrupts enabled. */
     env->ctrl[CR_STATUS] = CR_STATUS_RSIE | CR_STATUS_U | CR_STATUS_PIE;
     memset(env->regs, 0, sizeof(env->regs));
-#else
-    env->ctrl[CR_STATUS] = CR_STATUS_RSIE;
-    nios2_update_crs(env);
-    memset(env->shadow_regs, 0, sizeof(env->shadow_regs));
-#endif
-}
-
-#ifndef CONFIG_USER_ONLY
-static void eic_set_irq(void *opaque, int irq, int level)
-{
-    Nios2CPU *cpu = opaque;
-    CPUState *cs = CPU(cpu);
-
-    if (level) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-    }
-}
-
-static void iic_set_irq(void *opaque, int irq, int level)
-{
-    Nios2CPU *cpu = opaque;
-    CPUNios2State *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-
-    env->ctrl[CR_IPENDING] = deposit32(env->ctrl[CR_IPENDING], irq, 1, !!level);
-
-    if (env->ctrl[CR_IPENDING]) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-    }
-}
-#endif
-
-static void nios2_cpu_initfn(Object *obj)
-{
-#if !defined(CONFIG_USER_ONLY)
-    Nios2CPU *cpu = NIOS2_CPU(obj);
-
-    mmu_init(&cpu->env);
-#endif
 }
 
 static ObjectClass *nios2_cpu_class_by_name(const char *cpu_model)
@@ -146,37 +102,9 @@ static void realize_cr_status(CPUState *cs)
     RO_REG(CR_EXCEPTION);
     WR_REG(CR_BADADDR);
 
-    if (cpu->eic_present) {
-        WR_FIELD(CR_STATUS, RSIE);
-        RO_FIELD(CR_STATUS, NMI);
-        WR_FIELD(CR_STATUS, PRS);
-        RO_FIELD(CR_STATUS, CRS);
-        WR_FIELD(CR_STATUS, IL);
-        WR_FIELD(CR_STATUS, IH);
-    } else {
-        RO_FIELD(CR_STATUS, RSIE);
-        WR_REG(CR_IENABLE);
-        RO_REG(CR_IPENDING);
-    }
-
-    if (cpu->mmu_present) {
-        WR_FIELD(CR_STATUS, U);
-        WR_FIELD(CR_STATUS, EH);
-
-        WR_FIELD(CR_PTEADDR, VPN);
-        WR_FIELD(CR_PTEADDR, PTBASE);
-
-        RO_FIELD(CR_TLBMISC, D);
-        RO_FIELD(CR_TLBMISC, PERM);
-        RO_FIELD(CR_TLBMISC, BAD);
-        RO_FIELD(CR_TLBMISC, DBL);
-        WR_FIELD(CR_TLBMISC, PID);
-        WR_FIELD(CR_TLBMISC, WE);
-        WR_FIELD(CR_TLBMISC, RD);
-        WR_FIELD(CR_TLBMISC, WAY);
-
-        WR_REG(CR_TLBACC);
-    }
+    RO_FIELD(CR_STATUS, RSIE);
+    WR_REG(CR_IENABLE);
+    RO_REG(CR_IPENDING);
 
     /*
      * TODO: ECC (config, eccinj) and MPU (config, mpubase, mpuacc) are
@@ -209,65 +137,9 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     /* We have reserved storage for cpuid; might as well use it. */
     cpu->env.ctrl[CR_CPUID] = cs->cpu_index;
 
-#ifndef CONFIG_USER_ONLY
-    if (cpu->eic_present) {
-        qdev_init_gpio_in_named(DEVICE(cpu), eic_set_irq, "EIC", 1);
-    } else {
-        qdev_init_gpio_in_named(DEVICE(cpu), iic_set_irq, "IRQ", 32);
-    }
-#endif
-
     ncc->parent_realize(dev, errp);
 }
 
-#ifndef CONFIG_USER_ONLY
-static bool eic_take_interrupt(Nios2CPU *cpu)
-{
-    CPUNios2State *env = &cpu->env;
-    const uint32_t status = env->ctrl[CR_STATUS];
-
-    if (cpu->rnmi) {
-        return !(status & CR_STATUS_NMI);
-    }
-    if (!(status & CR_STATUS_PIE)) {
-        return false;
-    }
-    if (cpu->ril <= FIELD_EX32(status, CR_STATUS, IL)) {
-        return false;
-    }
-    if (cpu->rrs != FIELD_EX32(status, CR_STATUS, CRS)) {
-        return true;
-    }
-    return status & CR_STATUS_RSIE;
-}
-
-static bool iic_take_interrupt(Nios2CPU *cpu)
-{
-    CPUNios2State *env = &cpu->env;
-
-    if (!(env->ctrl[CR_STATUS] & CR_STATUS_PIE)) {
-        return false;
-    }
-    return env->ctrl[CR_IPENDING] & env->ctrl[CR_IENABLE];
-}
-
-static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
-        if (cpu->eic_present
-            ? eic_take_interrupt(cpu)
-            : iic_take_interrupt(cpu)) {
-            cs->exception_index = EXCP_IRQ;
-            nios2_cpu_do_interrupt(cs);
-            return true;
-        }
-    }
-    return false;
-}
-#endif /* !CONFIG_USER_ONLY */
-
 static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     /* NOTE: NiosII R2 is not supported yet. */
@@ -331,36 +203,14 @@ static int nios2_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
 static Property nios2_properties[] = {
     DEFINE_PROP_BOOL("diverr_present", Nios2CPU, diverr_present, true),
-    DEFINE_PROP_BOOL("mmu_present", Nios2CPU, mmu_present, true),
-    /* ALTR,pid-num-bits */
-    DEFINE_PROP_UINT32("mmu_pid_num_bits", Nios2CPU, pid_num_bits, 8),
-    /* ALTR,tlb-num-ways */
-    DEFINE_PROP_UINT32("mmu_tlb_num_ways", Nios2CPU, tlb_num_ways, 16),
-    /* ALTR,tlb-num-entries */
-    DEFINE_PROP_UINT32("mmu_pid_num_entries", Nios2CPU, tlb_num_entries, 256),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-#ifndef CONFIG_USER_ONLY
-#include "hw/core/sysemu-cpu-ops.h"
-
-static const struct SysemuCPUOps nios2_sysemu_ops = {
-    .get_phys_page_debug = nios2_cpu_get_phys_page_debug,
-};
-#endif
-
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps nios2_tcg_ops = {
     .initialize = nios2_tcg_init,
     .restore_state_to_opc = nios2_restore_state_to_opc,
-
-#ifndef CONFIG_USER_ONLY
-    .tlb_fill = nios2_cpu_tlb_fill,
-    .cpu_exec_interrupt = nios2_cpu_exec_interrupt,
-    .do_interrupt = nios2_cpu_do_interrupt,
-    .do_unaligned_access = nios2_cpu_do_unaligned_access,
-#endif /* !CONFIG_USER_ONLY */
 };
 
 static void nios2_cpu_class_init(ObjectClass *oc, void *data)
@@ -383,9 +233,6 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = nios2_cpu_set_pc;
     cc->get_pc = nios2_cpu_get_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
-#ifndef CONFIG_USER_ONLY
-    cc->sysemu_ops = &nios2_sysemu_ops;
-#endif
     cc->gdb_read_register = nios2_cpu_gdb_read_register;
     cc->gdb_write_register = nios2_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 49;
@@ -397,7 +244,6 @@ static const TypeInfo nios2_cpu_type_info = {
     .parent = TYPE_CPU,
     .instance_size = sizeof(Nios2CPU),
     .instance_align = __alignof(Nios2CPU),
-    .instance_init = nios2_cpu_initfn,
     .class_size = sizeof(Nios2CPUClass),
     .class_init = nios2_cpu_class_init,
 };
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
deleted file mode 100644
index ac57121afc..0000000000
--- a/target/nios2/helper.c
+++ /dev/null
@@ -1,371 +0,0 @@
-/*
- * Altera Nios II helper routines.
- *
- * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#include "qemu/osdep.h"
-
-#include "cpu.h"
-#include "qemu/host-utils.h"
-#include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
-#include "exec/log.h"
-#include "exec/helper-proto.h"
-#include "semihosting/semihost.h"
-
-
-static void do_exception(Nios2CPU *cpu, uint32_t exception_addr,
-                         uint32_t tlbmisc_set, bool is_break)
-{
-    CPUNios2State *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-    uint32_t old_status = env->ctrl[CR_STATUS];
-    uint32_t new_status = old_status;
-
-    /* With shadow regs, exceptions are always taken into CRS 0. */
-    new_status &= ~R_CR_STATUS_CRS_MASK;
-    env->regs = env->shadow_regs[0];
-
-    if ((old_status & CR_STATUS_EH) == 0) {
-        int r_ea = R_EA, cr_es = CR_ESTATUS;
-
-        if (is_break) {
-            r_ea = R_BA;
-            cr_es = CR_BSTATUS;
-        }
-        env->ctrl[cr_es] = old_status;
-        env->regs[r_ea] = env->pc;
-
-        if (cpu->mmu_present) {
-            new_status |= CR_STATUS_EH;
-
-            /*
-             * There are 4 bits that are always written.
-             * Explicitly clear them, to be set via the argument.
-             */
-            env->ctrl[CR_TLBMISC] &= ~(CR_TLBMISC_D |
-                                       CR_TLBMISC_PERM |
-                                       CR_TLBMISC_BAD |
-                                       CR_TLBMISC_DBL);
-            env->ctrl[CR_TLBMISC] |= tlbmisc_set;
-        }
-
-        /*
-         * With shadow regs, and EH == 0, PRS is set from CRS.
-         * At least, so says Table 3-9, and some other text,
-         * though Table 3-38 says otherwise.
-         */
-        new_status = FIELD_DP32(new_status, CR_STATUS, PRS,
-                                FIELD_EX32(old_status, CR_STATUS, CRS));
-    }
-
-    new_status &= ~(CR_STATUS_PIE | CR_STATUS_U);
-
-    env->ctrl[CR_STATUS] = new_status;
-    if (!is_break) {
-        env->ctrl[CR_EXCEPTION] = FIELD_DP32(0, CR_EXCEPTION, CAUSE,
-                                             cs->exception_index);
-    }
-    env->pc = exception_addr;
-}
-
-static void do_iic_irq(Nios2CPU *cpu)
-{
-    do_exception(cpu, cpu->exception_addr, 0, false);
-}
-
-static void do_eic_irq(Nios2CPU *cpu)
-{
-    CPUNios2State *env = &cpu->env;
-    uint32_t old_status = env->ctrl[CR_STATUS];
-    uint32_t new_status = old_status;
-    uint32_t old_rs = FIELD_EX32(old_status, CR_STATUS, CRS);
-    uint32_t new_rs = cpu->rrs;
-
-    new_status = FIELD_DP32(new_status, CR_STATUS, CRS, new_rs);
-    new_status = FIELD_DP32(new_status, CR_STATUS, IL, cpu->ril);
-    new_status = FIELD_DP32(new_status, CR_STATUS, NMI, cpu->rnmi);
-    new_status &= ~(CR_STATUS_RSIE | CR_STATUS_U);
-    new_status |= CR_STATUS_IH;
-
-    if (!(new_status & CR_STATUS_EH)) {
-        new_status = FIELD_DP32(new_status, CR_STATUS, PRS, old_rs);
-        if (new_rs == 0) {
-            env->ctrl[CR_ESTATUS] = old_status;
-        } else {
-            if (new_rs != old_rs) {
-                old_status |= CR_STATUS_SRS;
-            }
-            env->shadow_regs[new_rs][R_SSTATUS] = old_status;
-        }
-        env->shadow_regs[new_rs][R_EA] = env->pc;
-    }
-
-    env->ctrl[CR_STATUS] = new_status;
-    nios2_update_crs(env);
-
-    env->pc = cpu->rha;
-}
-
-void nios2_cpu_do_interrupt(CPUState *cs)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-    uint32_t tlbmisc_set = 0;
-
-    if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *name = NULL;
-
-        switch (cs->exception_index) {
-        case EXCP_IRQ:
-            name = "interrupt";
-            break;
-        case EXCP_TLB_X:
-        case EXCP_TLB_D:
-            if (env->ctrl[CR_STATUS] & CR_STATUS_EH) {
-                name = "TLB MISS (double)";
-            } else {
-                name = "TLB MISS (fast)";
-            }
-            break;
-        case EXCP_PERM_R:
-        case EXCP_PERM_W:
-        case EXCP_PERM_X:
-            name = "TLB PERM";
-            break;
-        case EXCP_SUPERA_X:
-        case EXCP_SUPERA_D:
-            name = "SUPERVISOR (address)";
-            break;
-        case EXCP_SUPERI:
-            name = "SUPERVISOR (insn)";
-            break;
-        case EXCP_ILLEGAL:
-            name = "ILLEGAL insn";
-            break;
-        case EXCP_UNALIGN:
-            name = "Misaligned (data)";
-            break;
-        case EXCP_UNALIGND:
-            name = "Misaligned (destination)";
-            break;
-        case EXCP_DIV:
-            name = "DIV error";
-            break;
-        case EXCP_TRAP:
-            name = "TRAP insn";
-            break;
-        case EXCP_BREAK:
-            name = "BREAK insn";
-            break;
-        case EXCP_SEMIHOST:
-            name = "SEMIHOST insn";
-            break;
-        }
-        if (name) {
-            qemu_log("%s at pc=0x%08x\n", name, env->pc);
-        } else {
-            qemu_log("Unknown exception %d at pc=0x%08x\n",
-                     cs->exception_index, env->pc);
-        }
-    }
-
-    switch (cs->exception_index) {
-    case EXCP_IRQ:
-        /* Note that PC is advanced for interrupts as well. */
-        env->pc += 4;
-        if (cpu->eic_present) {
-            do_eic_irq(cpu);
-        } else {
-            do_iic_irq(cpu);
-        }
-        break;
-
-    case EXCP_TLB_D:
-        tlbmisc_set = CR_TLBMISC_D;
-        /* fall through */
-    case EXCP_TLB_X:
-        if (env->ctrl[CR_STATUS] & CR_STATUS_EH) {
-            tlbmisc_set |= CR_TLBMISC_DBL;
-            /*
-             * Normally, we don't write to tlbmisc unless !EH,
-             * so do it manually for the double-tlb miss exception.
-             */
-            env->ctrl[CR_TLBMISC] &= ~(CR_TLBMISC_D |
-                                       CR_TLBMISC_PERM |
-                                       CR_TLBMISC_BAD);
-            env->ctrl[CR_TLBMISC] |= tlbmisc_set;
-            do_exception(cpu, cpu->exception_addr, 0, false);
-        } else {
-            tlbmisc_set |= CR_TLBMISC_WE;
-            do_exception(cpu, cpu->fast_tlb_miss_addr, tlbmisc_set, false);
-        }
-        break;
-
-    case EXCP_PERM_R:
-    case EXCP_PERM_W:
-        tlbmisc_set = CR_TLBMISC_D;
-        /* fall through */
-    case EXCP_PERM_X:
-        tlbmisc_set |= CR_TLBMISC_PERM;
-        if (!(env->ctrl[CR_STATUS] & CR_STATUS_EH)) {
-            tlbmisc_set |= CR_TLBMISC_WE;
-        }
-        do_exception(cpu, cpu->exception_addr, tlbmisc_set, false);
-        break;
-
-    case EXCP_SUPERA_D:
-    case EXCP_UNALIGN:
-        tlbmisc_set = CR_TLBMISC_D;
-        /* fall through */
-    case EXCP_SUPERA_X:
-    case EXCP_UNALIGND:
-        tlbmisc_set |= CR_TLBMISC_BAD;
-        do_exception(cpu, cpu->exception_addr, tlbmisc_set, false);
-        break;
-
-    case EXCP_SUPERI:
-    case EXCP_ILLEGAL:
-    case EXCP_DIV:
-    case EXCP_TRAP:
-        do_exception(cpu, cpu->exception_addr, 0, false);
-        break;
-
-    case EXCP_BREAK:
-        do_exception(cpu, cpu->exception_addr, 0, true);
-        break;
-
-    case EXCP_SEMIHOST:
-        do_nios2_semihosting(env);
-        break;
-
-    default:
-        cpu_abort(cs, "unhandled exception type=%d\n", cs->exception_index);
-    }
-}
-
-hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-    target_ulong vaddr, paddr = 0;
-    Nios2MMULookup lu;
-    unsigned int hit;
-
-    if (cpu->mmu_present && (addr < 0xC0000000)) {
-        hit = mmu_translate(env, &lu, addr, 0, 0);
-        if (hit) {
-            vaddr = addr & TARGET_PAGE_MASK;
-            paddr = lu.paddr + vaddr - lu.vaddr;
-        } else {
-            paddr = -1;
-            qemu_log("cpu_get_phys_page debug MISS: %#" PRIx64 "\n", addr);
-        }
-    } else {
-        paddr = addr & TARGET_PAGE_MASK;
-    }
-
-    return paddr;
-}
-
-void nios2_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-                                   MMUAccessType access_type,
-                                   int mmu_idx, uintptr_t retaddr)
-{
-    CPUNios2State *env = cpu_env(cs);
-
-    env->ctrl[CR_BADADDR] = addr;
-    cs->exception_index = EXCP_UNALIGN;
-    nios2_cpu_loop_exit_advance(env, retaddr);
-}
-
-bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr)
-{
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-    unsigned int excp;
-    target_ulong vaddr, paddr;
-    Nios2MMULookup lu;
-    unsigned int hit;
-
-    if (!cpu->mmu_present) {
-        /* No MMU */
-        address &= TARGET_PAGE_MASK;
-        tlb_set_page(cs, address, address, PAGE_BITS,
-                     mmu_idx, TARGET_PAGE_SIZE);
-        return true;
-    }
-
-    if (MMU_SUPERVISOR_IDX == mmu_idx) {
-        if (address >= 0xC0000000) {
-            /* Kernel physical page - TLB bypassed */
-            address &= TARGET_PAGE_MASK;
-            tlb_set_page(cs, address, address, PAGE_BITS,
-                         mmu_idx, TARGET_PAGE_SIZE);
-            return true;
-        }
-    } else {
-        if (address >= 0x80000000) {
-            /* Illegal access from user mode */
-            if (probe) {
-                return false;
-            }
-            cs->exception_index = (access_type == MMU_INST_FETCH
-                                   ? EXCP_SUPERA_X : EXCP_SUPERA_D);
-            env->ctrl[CR_BADADDR] = address;
-            nios2_cpu_loop_exit_advance(env, retaddr);
-        }
-    }
-
-    /* Virtual page.  */
-    hit = mmu_translate(env, &lu, address, access_type, mmu_idx);
-    if (hit) {
-        vaddr = address & TARGET_PAGE_MASK;
-        paddr = lu.paddr + vaddr - lu.vaddr;
-
-        if (((access_type == MMU_DATA_LOAD) && (lu.prot & PAGE_READ)) ||
-            ((access_type == MMU_DATA_STORE) && (lu.prot & PAGE_WRITE)) ||
-            ((access_type == MMU_INST_FETCH) && (lu.prot & PAGE_EXEC))) {
-            tlb_set_page(cs, vaddr, paddr, lu.prot,
-                         mmu_idx, TARGET_PAGE_SIZE);
-            return true;
-        }
-
-        /* Permission violation */
-        excp = (access_type == MMU_DATA_LOAD ? EXCP_PERM_R :
-                access_type == MMU_DATA_STORE ? EXCP_PERM_W : EXCP_PERM_X);
-    } else {
-        excp = (access_type == MMU_INST_FETCH ? EXCP_TLB_X: EXCP_TLB_D);
-    }
-
-    if (probe) {
-        return false;
-    }
-
-    env->ctrl[CR_TLBMISC] = FIELD_DP32(env->ctrl[CR_TLBMISC], CR_TLBMISC, D,
-                                       access_type != MMU_INST_FETCH);
-    env->ctrl[CR_PTEADDR] = FIELD_DP32(env->ctrl[CR_PTEADDR], CR_PTEADDR, VPN,
-                                       address >> TARGET_PAGE_BITS);
-    env->mmu.pteaddr_wr = env->ctrl[CR_PTEADDR];
-
-    cs->exception_index = excp;
-    env->ctrl[CR_BADADDR] = address;
-    nios2_cpu_loop_exit_advance(env, retaddr);
-}
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
deleted file mode 100644
index d9b690b78e..0000000000
--- a/target/nios2/mmu.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * Altera Nios II MMU emulation for qemu.
- *
- * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#include "qemu/osdep.h"
-#include "qemu/qemu-print.h"
-#include "cpu.h"
-#include "exec/exec-all.h"
-#include "mmu.h"
-#include "exec/helper-proto.h"
-#include "trace/trace-target_nios2.h"
-
-
-/* rw - 0 = read, 1 = write, 2 = fetch.  */
-unsigned int mmu_translate(CPUNios2State *env,
-                           Nios2MMULookup *lu,
-                           target_ulong vaddr, int rw, int mmu_idx)
-{
-    Nios2CPU *cpu = env_archcpu(env);
-    int pid = FIELD_EX32(env->mmu.tlbmisc_wr, CR_TLBMISC, PID);
-    int vpn = vaddr >> 12;
-    int way, n_ways = cpu->tlb_num_ways;
-
-    for (way = 0; way < n_ways; way++) {
-        uint32_t index = (way * n_ways) + (vpn & env->mmu.tlb_entry_mask);
-        Nios2TLBEntry *entry = &env->mmu.tlb[index];
-
-        if (((entry->tag >> 12) != vpn) ||
-            (((entry->tag & (1 << 11)) == 0) &&
-            ((entry->tag & ((1 << cpu->pid_num_bits) - 1)) != pid))) {
-            trace_nios2_mmu_translate_miss(vaddr, pid, index, entry->tag);
-            continue;
-        }
-
-        lu->vaddr = vaddr & TARGET_PAGE_MASK;
-        lu->paddr = FIELD_EX32(entry->data, CR_TLBACC, PFN) << TARGET_PAGE_BITS;
-        lu->prot = ((entry->data & CR_TLBACC_R) ? PAGE_READ : 0) |
-                   ((entry->data & CR_TLBACC_W) ? PAGE_WRITE : 0) |
-                   ((entry->data & CR_TLBACC_X) ? PAGE_EXEC : 0);
-
-        trace_nios2_mmu_translate_hit(vaddr, pid, index, lu->paddr, lu->prot);
-        return 1;
-    }
-    return 0;
-}
-
-static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
-{
-    CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = env_archcpu(env);
-    int idx;
-
-    for (idx = 0; idx < cpu->tlb_num_entries; idx++) {
-        Nios2TLBEntry *entry = &env->mmu.tlb[idx];
-
-        if ((entry->tag & (1 << 10)) && (!(entry->tag & (1 << 11))) &&
-            ((entry->tag & ((1 << cpu->pid_num_bits) - 1)) == pid)) {
-            uint32_t vaddr = entry->tag & TARGET_PAGE_MASK;
-
-            trace_nios2_mmu_flush_pid_hit(pid, idx, vaddr);
-            tlb_flush_page(cs, vaddr);
-        } else {
-            trace_nios2_mmu_flush_pid_miss(pid, idx, entry->tag);
-        }
-    }
-}
-
-void helper_mmu_write_tlbacc(CPUNios2State *env, uint32_t v)
-{
-    CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = env_archcpu(env);
-
-    trace_nios2_mmu_write_tlbacc(FIELD_EX32(v, CR_TLBACC, IG),
-                                 (v & CR_TLBACC_C) ? 'C' : '.',
-                                 (v & CR_TLBACC_R) ? 'R' : '.',
-                                 (v & CR_TLBACC_W) ? 'W' : '.',
-                                 (v & CR_TLBACC_X) ? 'X' : '.',
-                                 (v & CR_TLBACC_G) ? 'G' : '.',
-                                 FIELD_EX32(v, CR_TLBACC, PFN));
-
-    /* if tlbmisc.WE == 1 then trigger a TLB write on writes to TLBACC */
-    if (env->ctrl[CR_TLBMISC] & CR_TLBMISC_WE) {
-        int way = FIELD_EX32(env->ctrl[CR_TLBMISC], CR_TLBMISC, WAY);
-        int vpn = FIELD_EX32(env->mmu.pteaddr_wr, CR_PTEADDR, VPN);
-        int pid = FIELD_EX32(env->mmu.tlbmisc_wr, CR_TLBMISC, PID);
-        int g = FIELD_EX32(v, CR_TLBACC, G);
-        int valid = FIELD_EX32(vpn, CR_TLBACC, PFN) < 0xC0000;
-        Nios2TLBEntry *entry =
-            &env->mmu.tlb[(way * cpu->tlb_num_ways) +
-                          (vpn & env->mmu.tlb_entry_mask)];
-        uint32_t newTag = (vpn << 12) | (g << 11) | (valid << 10) | pid;
-        uint32_t newData = v & (CR_TLBACC_C | CR_TLBACC_R | CR_TLBACC_W |
-                                CR_TLBACC_X | R_CR_TLBACC_PFN_MASK);
-
-        if ((entry->tag != newTag) || (entry->data != newData)) {
-            if (entry->tag & (1 << 10)) {
-                /* Flush existing entry */
-                tlb_flush_page(cs, entry->tag & TARGET_PAGE_MASK);
-            }
-            entry->tag = newTag;
-            entry->data = newData;
-        }
-        /* Auto-increment tlbmisc.WAY */
-        env->ctrl[CR_TLBMISC] = FIELD_DP32(env->ctrl[CR_TLBMISC],
-                                           CR_TLBMISC, WAY,
-                                           (way + 1) & (cpu->tlb_num_ways - 1));
-    }
-
-    /* Writes to TLBACC don't change the read-back value */
-    env->mmu.tlbacc_wr = v;
-}
-
-void helper_mmu_write_tlbmisc(CPUNios2State *env, uint32_t v)
-{
-    Nios2CPU *cpu = env_archcpu(env);
-    uint32_t new_pid = FIELD_EX32(v, CR_TLBMISC, PID);
-    uint32_t old_pid = FIELD_EX32(env->mmu.tlbmisc_wr, CR_TLBMISC, PID);
-    uint32_t way = FIELD_EX32(v, CR_TLBMISC, WAY);
-
-    trace_nios2_mmu_write_tlbmisc(way,
-                                  (v & CR_TLBMISC_RD) ? 'R' : '.',
-                                  (v & CR_TLBMISC_WE) ? 'W' : '.',
-                                  (v & CR_TLBMISC_DBL) ? '2' : '.',
-                                  (v & CR_TLBMISC_BAD) ? 'B' : '.',
-                                  (v & CR_TLBMISC_PERM) ? 'P' : '.',
-                                  (v & CR_TLBMISC_D) ? 'D' : '.',
-                                  new_pid);
-
-    if (new_pid != old_pid) {
-        mmu_flush_pid(env, old_pid);
-    }
-
-    /* if tlbmisc.RD == 1 then trigger a TLB read on writes to TLBMISC */
-    if (v & CR_TLBMISC_RD) {
-        int vpn = FIELD_EX32(env->mmu.pteaddr_wr, CR_PTEADDR, VPN);
-        Nios2TLBEntry *entry =
-            &env->mmu.tlb[(way * cpu->tlb_num_ways) +
-                          (vpn & env->mmu.tlb_entry_mask)];
-
-        env->ctrl[CR_TLBACC] &= R_CR_TLBACC_IG_MASK;
-        env->ctrl[CR_TLBACC] |= entry->data;
-        env->ctrl[CR_TLBACC] |= (entry->tag & (1 << 11)) ? CR_TLBACC_G : 0;
-        env->ctrl[CR_TLBMISC] = FIELD_DP32(v, CR_TLBMISC, PID,
-                                           entry->tag &
-                                           ((1 << cpu->pid_num_bits) - 1));
-        env->ctrl[CR_PTEADDR] = FIELD_DP32(env->ctrl[CR_PTEADDR],
-                                           CR_PTEADDR, VPN,
-                                           entry->tag >> TARGET_PAGE_BITS);
-    } else {
-        env->ctrl[CR_TLBMISC] = v;
-    }
-
-    env->mmu.tlbmisc_wr = v;
-}
-
-void helper_mmu_write_pteaddr(CPUNios2State *env, uint32_t v)
-{
-    trace_nios2_mmu_write_pteaddr(FIELD_EX32(v, CR_PTEADDR, PTBASE),
-                                  FIELD_EX32(v, CR_PTEADDR, VPN));
-
-    /* Writes to PTEADDR don't change the read-back VPN value */
-    env->ctrl[CR_PTEADDR] = ((v & ~R_CR_PTEADDR_VPN_MASK) |
-                             (env->ctrl[CR_PTEADDR] & R_CR_PTEADDR_VPN_MASK));
-    env->mmu.pteaddr_wr = v;
-}
-
-void mmu_init(CPUNios2State *env)
-{
-    Nios2CPU *cpu = env_archcpu(env);
-    Nios2MMU *mmu = &env->mmu;
-
-    mmu->tlb_entry_mask = (cpu->tlb_num_entries / cpu->tlb_num_ways) - 1;
-    mmu->tlb = g_new0(Nios2TLBEntry, cpu->tlb_num_entries);
-}
-
-void dump_mmu(CPUNios2State *env)
-{
-    Nios2CPU *cpu = env_archcpu(env);
-    int i;
-
-    qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
-                cpu->tlb_num_ways, cpu->tlb_num_entries,
-                cpu->pid_num_bits);
-
-    for (i = 0; i < cpu->tlb_num_entries; i++) {
-        Nios2TLBEntry *entry = &env->mmu.tlb[i];
-        qemu_printf("TLB[%d] = %08X %08X %c VPN %05X "
-                    "PID %02X %c PFN %05X %c%c%c%c\n",
-                    i, entry->tag, entry->data,
-                    (entry->tag & (1 << 10)) ? 'V' : '-',
-                    entry->tag >> 12,
-                    entry->tag & ((1 << cpu->pid_num_bits) - 1),
-                    (entry->tag & (1 << 11)) ? 'G' : '-',
-                    FIELD_EX32(entry->data, CR_TLBACC, PFN),
-                    (entry->data & CR_TLBACC_C) ? 'C' : '-',
-                    (entry->data & CR_TLBACC_R) ? 'R' : '-',
-                    (entry->data & CR_TLBACC_W) ? 'W' : '-',
-                    (entry->data & CR_TLBACC_X) ? 'X' : '-');
-    }
-}
diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
deleted file mode 100644
index 0152dec3fa..0000000000
--- a/target/nios2/monitor.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * QEMU monitor
- *
- * Copyright (c) 2003-2004 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
-#include "monitor/hmp.h"
-
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-{
-    CPUArchState *env1 = mon_get_cpu_env(mon);
-
-    dump_mmu(env1);
-}
diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
deleted file mode 100644
index 420702e293..0000000000
--- a/target/nios2/nios2-semi.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/*
- *  Nios II Semihosting syscall interface.
- *  This code is derived from m68k-semi.c.
- *  The semihosting protocol implemented here is described in the
- *  libgloss sources:
- *  https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;hb=HEAD
- *
- *  Copyright (c) 2017-2019 Mentor Graphics
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "gdbstub/syscalls.h"
-#include "gdbstub/helpers.h"
-#include "semihosting/syscalls.h"
-#include "semihosting/uaccess.h"
-#include "qemu/log.h"
-
-#define HOSTED_EXIT  0
-#define HOSTED_INIT_SIM 1
-#define HOSTED_OPEN 2
-#define HOSTED_CLOSE 3
-#define HOSTED_READ 4
-#define HOSTED_WRITE 5
-#define HOSTED_LSEEK 6
-#define HOSTED_RENAME 7
-#define HOSTED_UNLINK 8
-#define HOSTED_STAT 9
-#define HOSTED_FSTAT 10
-#define HOSTED_GETTIMEOFDAY 11
-#define HOSTED_ISATTY 12
-#define HOSTED_SYSTEM 13
-
-static int host_to_gdb_errno(int err)
-{
-#define E(X)  case E##X: return GDB_E##X
-    switch (err) {
-    E(PERM);
-    E(NOENT);
-    E(INTR);
-    E(BADF);
-    E(ACCES);
-    E(FAULT);
-    E(BUSY);
-    E(EXIST);
-    E(NODEV);
-    E(NOTDIR);
-    E(ISDIR);
-    E(INVAL);
-    E(NFILE);
-    E(MFILE);
-    E(FBIG);
-    E(NOSPC);
-    E(SPIPE);
-    E(ROFS);
-    E(NAMETOOLONG);
-    default:
-        return GDB_EUNKNOWN;
-    }
-#undef E
-}
-
-static void nios2_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
-{
-    CPUNios2State *env = cpu_env(cs);
-    target_ulong args = env->regs[R_ARG1];
-
-    if (put_user_u32(ret, args) ||
-        put_user_u32(host_to_gdb_errno(err), args + 4)) {
-        /*
-         * The nios2 semihosting ABI does not provide any way to report this
-         * error to the guest, so the best we can do is log it in qemu.
-         * It is always a guest error not to pass us a valid argument block.
-         */
-        qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: return value "
-                      "discarded because argument block not writable\n");
-    }
-}
-
-static void nios2_semi_u64_cb(CPUState *cs, uint64_t ret, int err)
-{
-    CPUNios2State *env = cpu_env(cs);
-    target_ulong args = env->regs[R_ARG1];
-
-    if (put_user_u32(ret >> 32, args) ||
-        put_user_u32(ret, args + 4) ||
-        put_user_u32(host_to_gdb_errno(err), args + 8)) {
-        /* No way to report this via nios2 semihosting ABI; just log it */
-        qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: return value "
-                      "discarded because argument block not writable\n");
-    }
-}
-
-/*
- * Read the input value from the argument block; fail the semihosting
- * call if the memory read fails.
- */
-#define GET_ARG(n) do {                                 \
-    if (get_user_ual(arg ## n, args + (n) * 4)) {       \
-        goto failed;                                    \
-    }                                                   \
-} while (0)
-
-#define GET_ARG64(n) do {                               \
-    if (get_user_ual(arg ## n, args + (n) * 4)) {       \
-        goto failed64;                                  \
-    }                                                   \
-} while (0)
-
-void do_nios2_semihosting(CPUNios2State *env)
-{
-    CPUState *cs = env_cpu(env);
-    int nr;
-    uint32_t args;
-    target_ulong arg0, arg1, arg2, arg3;
-
-    nr = env->regs[R_ARG0];
-    args = env->regs[R_ARG1];
-    switch (nr) {
-    case HOSTED_EXIT:
-        gdb_exit(env->regs[R_ARG1]);
-        exit(env->regs[R_ARG1]);
-
-    case HOSTED_OPEN:
-        GET_ARG(0);
-        GET_ARG(1);
-        GET_ARG(2);
-        GET_ARG(3);
-        semihost_sys_open(cs, nios2_semi_u32_cb, arg0, arg1, arg2, arg3);
-        break;
-
-    case HOSTED_CLOSE:
-        GET_ARG(0);
-        semihost_sys_close(cs, nios2_semi_u32_cb, arg0);
-        break;
-
-    case HOSTED_READ:
-        GET_ARG(0);
-        GET_ARG(1);
-        GET_ARG(2);
-        semihost_sys_read(cs, nios2_semi_u32_cb, arg0, arg1, arg2);
-        break;
-
-    case HOSTED_WRITE:
-        GET_ARG(0);
-        GET_ARG(1);
-        GET_ARG(2);
-        semihost_sys_write(cs, nios2_semi_u32_cb, arg0, arg1, arg2);
-        break;
-
-    case HOSTED_LSEEK:
-        GET_ARG64(0);
-        GET_ARG64(1);
-        GET_ARG64(2);
-        GET_ARG64(3);
-        semihost_sys_lseek(cs, nios2_semi_u64_cb, arg0,
-                           deposit64(arg2, 32, 32, arg1), arg3);
-        break;
-
-    case HOSTED_RENAME:
-        GET_ARG(0);
-        GET_ARG(1);
-        GET_ARG(2);
-        GET_ARG(3);
-        semihost_sys_rename(cs, nios2_semi_u32_cb, arg0, arg1, arg2, arg3);
-        break;
-
-    case HOSTED_UNLINK:
-        GET_ARG(0);
-        GET_ARG(1);
-        semihost_sys_remove(cs, nios2_semi_u32_cb, arg0, arg1);
-        break;
-
-    case HOSTED_STAT:
-        GET_ARG(0);
-        GET_ARG(1);
-        GET_ARG(2);
-        semihost_sys_stat(cs, nios2_semi_u32_cb, arg0, arg1, arg2);
-        break;
-
-    case HOSTED_FSTAT:
-        GET_ARG(0);
-        GET_ARG(1);
-        semihost_sys_fstat(cs, nios2_semi_u32_cb, arg0, arg1);
-        break;
-
-    case HOSTED_GETTIMEOFDAY:
-        GET_ARG(0);
-        GET_ARG(1);
-        semihost_sys_gettimeofday(cs, nios2_semi_u32_cb, arg0, arg1);
-        break;
-
-    case HOSTED_ISATTY:
-        GET_ARG(0);
-        semihost_sys_isatty(cs, nios2_semi_u32_cb, arg0);
-        break;
-
-    case HOSTED_SYSTEM:
-        GET_ARG(0);
-        GET_ARG(1);
-        semihost_sys_system(cs, nios2_semi_u32_cb, arg0, arg1);
-        break;
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: unsupported "
-                      "semihosting syscall %d\n", nr);
-        nios2_semi_u32_cb(cs, -1, ENOSYS);
-        break;
-
-    failed:
-        nios2_semi_u32_cb(cs, -1, EFAULT);
-        break;
-    failed64:
-        nios2_semi_u64_cb(cs, -1, EFAULT);
-        break;
-    }
-}
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index 5017457c5e..7baa6dbd41 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -72,48 +72,3 @@ uint32_t helper_divu(CPUNios2State *env, uint32_t num, uint32_t den)
     }
     return num / den;
 }
-
-#ifndef CONFIG_USER_ONLY
-void helper_eret(CPUNios2State *env, uint32_t new_status, uint32_t new_pc)
-{
-    Nios2CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-
-    if (unlikely(new_pc & 3)) {
-        env->ctrl[CR_BADADDR] = new_pc;
-        cs->exception_index = EXCP_UNALIGND;
-        nios2_cpu_loop_exit_advance(env, GETPC());
-    }
-
-    /*
-     * None of estatus, bstatus, or sstatus have constraints on write;
-     * do not allow reserved fields in status to be set.
-     * When shadow registers are enabled, eret *does* restore CRS.
-     * Rather than testing eic_present to decide, mask CRS out of
-     * the set of readonly fields.
-     */
-    new_status &= cpu->cr_state[CR_STATUS].writable |
-                  (cpu->cr_state[CR_STATUS].readonly & R_CR_STATUS_CRS_MASK);
-
-    env->ctrl[CR_STATUS] = new_status;
-    env->pc = new_pc;
-    nios2_update_crs(env);
-    cpu_loop_exit(cs);
-}
-
-/*
- * RDPRS and WRPRS are implemented out of line so that if PRS == CRS,
- * all of the tcg global temporaries are synced back to ENV.
- */
-uint32_t helper_rdprs(CPUNios2State *env, uint32_t regno)
-{
-    unsigned prs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, PRS);
-    return env->shadow_regs[prs][regno];
-}
-
-void helper_wrprs(CPUNios2State *env, uint32_t regno, uint32_t val)
-{
-    unsigned prs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, PRS);
-    env->shadow_regs[prs][regno] = val;
-}
-#endif /* !CONFIG_USER_ONLY */
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 7ddc6ac1a2..34c3e6fc79 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -50,6 +50,8 @@
         INSTRUCTION_FLG(gen_excp, EXCP_UNIMPL)
 #define INSTRUCTION_ILLEGAL()              \
         INSTRUCTION_FLG(gen_excp, EXCP_ILLEGAL)
+#define INSTRUCTION_SUPERVISOR()              \
+        INSTRUCTION_FLG(gen_excp, EXCP_SUPERI)
 
 /* Special R-Type instruction opcode */
 #define INSN_R_TYPE 0x3A
@@ -133,14 +135,10 @@ typedef struct DisasContext {
     uint32_t          tb_flags;
     TCGv              sink;
     const ControlRegState *cr_state;
-    bool              eic_present;
 } DisasContext;
 
 static TCGv cpu_R[NUM_GP_REGS];
 static TCGv cpu_pc;
-#ifndef CONFIG_USER_ONLY
-static TCGv cpu_crs_R[NUM_GP_REGS];
-#endif
 
 typedef struct Nios2Instruction {
     void     (*handler)(DisasContext *dc, uint32_t code, uint32_t flags);
@@ -174,11 +172,7 @@ static TCGv load_gpr(DisasContext *dc, unsigned reg)
     if (FIELD_EX32(dc->tb_flags, TBFLAGS, CRS0)) {
         return cpu_R[reg];
     }
-#ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
-#else
-    return cpu_crs_R[reg];
-#endif
 }
 
 static TCGv dest_gpr(DisasContext *dc, unsigned reg)
@@ -198,11 +192,7 @@ static TCGv dest_gpr(DisasContext *dc, unsigned reg)
     if (FIELD_EX32(dc->tb_flags, TBFLAGS, CRS0)) {
         return cpu_R[reg];
     }
-#ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
-#else
-    return cpu_crs_R[reg];
-#endif
 }
 
 static void t_gen_helper_raise_exception(DisasContext *dc, uint32_t index)
@@ -301,11 +291,7 @@ static void gen_ldx(DisasContext *dc, uint32_t code, uint32_t flags)
     TCGv data = dest_gpr(dc, instr.b);
 
     tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16.s);
-#ifdef CONFIG_USER_ONLY
     flags |= MO_UNALN;
-#else
-    flags |= MO_ALIGN;
-#endif
     tcg_gen_qemu_ld_tl(data, addr, dc->mem_idx, flags);
 }
 
@@ -317,11 +303,7 @@ static void gen_stx(DisasContext *dc, uint32_t code, uint32_t flags)
 
     TCGv addr = tcg_temp_new();
     tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16.s);
-#ifdef CONFIG_USER_ONLY
     flags |= MO_UNALN;
-#else
-    flags |= MO_ALIGN;
-#endif
     tcg_gen_qemu_st_tl(val, addr, dc->mem_idx, flags);
 }
 
@@ -398,27 +380,6 @@ gen_i_math_logic(andhi, andi, 0, imm_shifted)
 gen_i_math_logic(orhi , ori,  1, imm_shifted)
 gen_i_math_logic(xorhi, xori, 1, imm_shifted)
 
-/* rB <- prs.rA + sigma(IMM16) */
-static void rdprs(DisasContext *dc, uint32_t code, uint32_t flags)
-{
-    if (!dc->eic_present) {
-        t_gen_helper_raise_exception(dc, EXCP_ILLEGAL);
-        return;
-    }
-    if (!gen_check_supervisor(dc)) {
-        return;
-    }
-
-#ifdef CONFIG_USER_ONLY
-    g_assert_not_reached();
-#else
-    I_TYPE(instr, code);
-    TCGv dest = dest_gpr(dc, instr.b);
-    gen_helper_rdprs(dest, tcg_env, tcg_constant_i32(instr.a));
-    tcg_gen_addi_tl(dest, dest, instr.imm16.s);
-#endif
-}
-
 /* Prototype only, defined below */
 static void handle_r_type_instr(DisasContext *dc, uint32_t code,
                                 uint32_t flags);
@@ -480,7 +441,7 @@ static const Nios2Instruction i_type_instructions[] = {
     INSTRUCTION_FLG(gen_stx, MO_TESL),                /* stwio */
     INSTRUCTION_FLG(gen_bxx, TCG_COND_LTU),           /* bltu */
     INSTRUCTION_FLG(gen_ldx, MO_TEUL),                /* ldwio */
-    INSTRUCTION(rdprs),                               /* rdprs */
+    INSTRUCTION_SUPERVISOR(),                         /* rdprs */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_FLG(handle_r_type_instr, 0),          /* R-Type */
     INSTRUCTION_NOP(),                                /* flushd */
@@ -493,29 +454,6 @@ static const Nios2Instruction i_type_instructions[] = {
 /*
  * R-Type instructions
  */
-/*
- * status <- estatus
- * PC <- ea
- */
-static void eret(DisasContext *dc, uint32_t code, uint32_t flags)
-{
-    if (!gen_check_supervisor(dc)) {
-        return;
-    }
-
-#ifdef CONFIG_USER_ONLY
-    g_assert_not_reached();
-#else
-    if (FIELD_EX32(dc->tb_flags, TBFLAGS, CRS0)) {
-        TCGv tmp = tcg_temp_new();
-        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUNios2State, ctrl[CR_ESTATUS]));
-        gen_helper_eret(tcg_env, tmp, load_gpr(dc, R_EA));
-    } else {
-        gen_helper_eret(tcg_env, load_gpr(dc, R_SSTATUS), load_gpr(dc, R_EA));
-    }
-    dc->base.is_jmp = DISAS_NORETURN;
-#endif
-}
 
 /* PC <- ra */
 static void ret(DisasContext *dc, uint32_t code, uint32_t flags)
@@ -533,15 +471,7 @@ static void bret(DisasContext *dc, uint32_t code, uint32_t flags)
         return;
     }
 
-#ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
-#else
-    TCGv tmp = tcg_temp_new();
-    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUNios2State, ctrl[CR_BSTATUS]));
-    gen_helper_eret(tcg_env, tmp, load_gpr(dc, R_BA));
-
-    dc->base.is_jmp = DISAS_NORETURN;
-#endif
 }
 
 /* PC <- rA */
@@ -578,40 +508,7 @@ static void rdctl(DisasContext *dc, uint32_t code, uint32_t flags)
         return;
     }
 
-#ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
-#else
-    R_TYPE(instr, code);
-    TCGv t1, t2, dest = dest_gpr(dc, instr.c);
-
-    /* Reserved registers read as zero. */
-    if (nios2_cr_reserved(&dc->cr_state[instr.imm5])) {
-        tcg_gen_movi_tl(dest, 0);
-        return;
-    }
-
-    switch (instr.imm5) {
-    case CR_IPENDING:
-        /*
-         * The value of the ipending register is synthetic.
-         * In hw, this is the AND of a set of hardware irq lines
-         * with the ienable register.  In qemu, we re-use the space
-         * of CR_IPENDING to store the set of irq lines, and so we
-         * must perform the AND here, and anywhere else we need the
-         * guest value of ipending.
-         */
-        t1 = tcg_temp_new();
-        t2 = tcg_temp_new();
-        tcg_gen_ld_tl(t1, tcg_env, offsetof(CPUNios2State, ctrl[CR_IPENDING]));
-        tcg_gen_ld_tl(t2, tcg_env, offsetof(CPUNios2State, ctrl[CR_IENABLE]));
-        tcg_gen_and_tl(dest, t1, t2);
-        break;
-    default:
-        tcg_gen_ld_tl(dest, tcg_env,
-                      offsetof(CPUNios2State, ctrl[instr.imm5]));
-        break;
-    }
-#endif
 }
 
 /* ctlN <- rA */
@@ -621,90 +518,7 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
         return;
     }
 
-#ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
-#else
-    R_TYPE(instr, code);
-    TCGv v = load_gpr(dc, instr.a);
-    uint32_t ofs = offsetof(CPUNios2State, ctrl[instr.imm5]);
-    uint32_t wr = dc->cr_state[instr.imm5].writable;
-    uint32_t ro = dc->cr_state[instr.imm5].readonly;
-
-    /* Skip reserved or readonly registers. */
-    if (wr == 0) {
-        return;
-    }
-
-    switch (instr.imm5) {
-    case CR_PTEADDR:
-        gen_helper_mmu_write_pteaddr(tcg_env, v);
-        break;
-    case CR_TLBACC:
-        gen_helper_mmu_write_tlbacc(tcg_env, v);
-        break;
-    case CR_TLBMISC:
-        gen_helper_mmu_write_tlbmisc(tcg_env, v);
-        break;
-    case CR_STATUS:
-    case CR_IENABLE:
-        /* If interrupts were enabled using WRCTL, trigger them. */
-        dc->base.is_jmp = DISAS_UPDATE;
-        /* fall through */
-    default:
-        if (wr == -1) {
-            /* The register is entirely writable. */
-            tcg_gen_st_tl(v, tcg_env, ofs);
-        } else {
-            /*
-             * The register is partially read-only or reserved:
-             * merge the value.
-             */
-            TCGv n = tcg_temp_new();
-
-            tcg_gen_andi_tl(n, v, wr);
-
-            if (ro != 0) {
-                TCGv o = tcg_temp_new();
-                tcg_gen_ld_tl(o, tcg_env, ofs);
-                tcg_gen_andi_tl(o, o, ro);
-                tcg_gen_or_tl(n, n, o);
-            }
-
-            tcg_gen_st_tl(n, tcg_env, ofs);
-        }
-        break;
-    }
-#endif
-}
-
-/* prs.rC <- rA */
-static void wrprs(DisasContext *dc, uint32_t code, uint32_t flags)
-{
-    if (!dc->eic_present) {
-        t_gen_helper_raise_exception(dc, EXCP_ILLEGAL);
-        return;
-    }
-    if (!gen_check_supervisor(dc)) {
-        return;
-    }
-
-#ifdef CONFIG_USER_ONLY
-    g_assert_not_reached();
-#else
-    R_TYPE(instr, code);
-    gen_helper_wrprs(tcg_env, tcg_constant_i32(instr.c),
-                     load_gpr(dc, instr.a));
-    /*
-     * The expected write to PRS[r0] is 0, from CRS[r0].
-     * If not, and CRS == PRS (which we cannot tell from here),
-     * we may now have a non-zero value in our current r0.
-     * By ending the TB, we re-evaluate tb_flags and find out.
-     */
-    if (instr.c == 0
-        && (instr.a != 0 || !FIELD_EX32(dc->tb_flags, TBFLAGS, R0_0))) {
-        dc->base.is_jmp = DISAS_UPDATE;
-    }
-#endif
 }
 
 /* Comparison instructions */
@@ -802,7 +616,6 @@ static void divu(DisasContext *dc, uint32_t code, uint32_t flags)
 
 static void trap(DisasContext *dc, uint32_t code, uint32_t flags)
 {
-#ifdef CONFIG_USER_ONLY
     /*
      * The imm5 field is not stored anywhere on real hw; the kernel
      * has to load the insn and extract the field.  But we can make
@@ -811,28 +624,17 @@ static void trap(DisasContext *dc, uint32_t code, uint32_t flags)
     R_TYPE(instr, code);
     tcg_gen_st_i32(tcg_constant_i32(instr.imm5), tcg_env,
                    offsetof(CPUNios2State, error_code));
-#endif
     t_gen_helper_raise_exception(dc, EXCP_TRAP);
 }
 
 static void gen_break(DisasContext *dc, uint32_t code, uint32_t flags)
 {
-#ifndef CONFIG_USER_ONLY
-    /* The semihosting instruction is "break 1".  */
-    bool is_user = FIELD_EX32(dc->tb_flags, TBFLAGS, U);
-    R_TYPE(instr, code);
-    if (semihosting_enabled(is_user) && instr.imm5 == 1) {
-        t_gen_helper_raise_exception(dc, EXCP_SEMIHOST);
-        return;
-    }
-#endif
-
     t_gen_helper_raise_exception(dc, EXCP_BREAK);
 }
 
 static const Nios2Instruction r_type_instructions[] = {
     INSTRUCTION_ILLEGAL(),
-    INSTRUCTION(eret),                                /* eret */
+    INSTRUCTION_SUPERVISOR(),                         /* eret */
     INSTRUCTION(roli),                                /* roli */
     INSTRUCTION(rol),                                 /* rol */
     INSTRUCTION_NOP(),                                /* flushp */
@@ -851,7 +653,7 @@ static const Nios2Instruction r_type_instructions[] = {
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION(slli),                                /* slli */
     INSTRUCTION(sll),                                 /* sll */
-    INSTRUCTION(wrprs),                               /* wrprs */
+    INSTRUCTION_ILLEGAL(),                            /* wrprs */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION(or),                                  /* or */
     INSTRUCTION(mulxsu),                              /* mulxsu */
@@ -927,19 +729,6 @@ static const char * const gr_regnames[NUM_GP_REGS] = {
     "fp",         "ea",         "ba",         "ra",
 };
 
-#ifndef CONFIG_USER_ONLY
-static const char * const cr_regnames[NUM_CR_REGS] = {
-    "status",     "estatus",    "bstatus",    "ienable",
-    "ipending",   "cpuid",      "res6",       "exception",
-    "pteaddr",    "tlbacc",     "tlbmisc",    "reserved1",
-    "badaddr",    "config",     "mpubase",    "mpuacc",
-    "res16",      "res17",      "res18",      "res19",
-    "res20",      "res21",      "res22",      "res23",
-    "res24",      "res25",      "res26",      "res27",
-    "res28",      "res29",      "res30",      "res31",
-};
-#endif
-
 /* generate intermediate code for basic block 'tb'.  */
 static void nios2_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
@@ -951,7 +740,6 @@ static void nios2_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->mem_idx = cpu_mmu_index(cs, false);
     dc->cr_state = cpu->cr_state;
     dc->tb_flags = dc->base.tb->flags;
-    dc->eic_present = cpu->eic_present;
 
     /* Bound the number of insns to execute to those left on the page.  */
     page_insns = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
@@ -1056,44 +844,12 @@ void nios2_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
 
-#if !defined(CONFIG_USER_ONLY)
-    int j;
-
-    for (i = j = 0; i < NUM_CR_REGS; i++) {
-        if (!nios2_cr_reserved(&cpu->cr_state[i])) {
-            qemu_fprintf(f, "%9s=%8.8x ", cr_regnames[i], env->ctrl[i]);
-            if (++j % 4 == 0) {
-                qemu_fprintf(f, "\n");
-            }
-        }
-    }
-    if (j % 4 != 0) {
-        qemu_fprintf(f, "\n");
-    }
-    if (cpu->mmu_present) {
-        qemu_fprintf(f, " mmu write: VPN=%05X PID %02X TLBACC %08X\n",
-                     env->mmu.pteaddr_wr & R_CR_PTEADDR_VPN_MASK,
-                     FIELD_EX32(env->mmu.tlbmisc_wr, CR_TLBMISC, PID),
-                     env->mmu.tlbacc_wr);
-    }
-#endif
     qemu_fprintf(f, "\n\n");
 }
 
 void nios2_tcg_init(void)
 {
-#ifndef CONFIG_USER_ONLY
-    TCGv_ptr crs = tcg_global_mem_new_ptr(tcg_env,
-                                          offsetof(CPUNios2State, regs), "crs");
-
-    for (int i = 0; i < NUM_GP_REGS; i++) {
-        cpu_crs_R[i] = tcg_global_mem_new(crs, 4 * i, gr_regnames[i]);
-    }
-
-#define offsetof_regs0(N)  offsetof(CPUNios2State, shadow_regs[0][N])
-#else
 #define offsetof_regs0(N)  offsetof(CPUNios2State, regs[N])
-#endif
 
     for (int i = 0; i < NUM_GP_REGS; i++) {
         cpu_R[i] = tcg_global_mem_new(tcg_env, offsetof_regs0(i),
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 31cc0bfb01..05da7bc72d 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -38,7 +38,6 @@ static struct arch2cpu cpus_map[] = {
     { "mipsel", "I7200" },
     { "mips64", "20Kc" },
     { "mips64el", "I6500" },
-    { "nios2", "FIXME" },
     { "or1k", "or1200" },
     { "ppc", "604" },
     { "ppc64", "power8e_v2.1" },
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfdff175c3..5848c73e00 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -164,7 +164,7 @@ build-system-centos:
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt --enable-vfio-user-server
       --enable-modules --enable-trace-backends=dtrace --enable-docs
     TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
-      x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
+      x86_64-softmmu rx-softmmu sh4-softmmu
     MAKE_CHECK_ARGS: check-build
 
 # Previous QEMU release. Used for cross-version migration tests.
@@ -254,7 +254,7 @@ avocado-system-centos:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-avocado
     AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
-      arch:sh4 arch:nios2
+      arch:sh4
 
 build-system-opensuse:
   extends:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 987ba9694b..47bdb99b5b 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -167,7 +167,7 @@ cross-win64-system:
     IMAGE: fedora-win64-cross
     EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu
-                        m68k-softmmu microblazeel-softmmu nios2-softmmu
+                        m68k-softmmu microblazeel-softmmu
                         or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
                         tricore-softmmu xtensaeb-softmmu
   artifacts:
diff --git a/hw/Kconfig b/hw/Kconfig
index 2c00936c28..ea6a68b1a1 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -57,7 +57,6 @@ source loongarch/Kconfig
 source m68k/Kconfig
 source microblaze/Kconfig
 source mips/Kconfig
-source nios2/Kconfig
 source openrisc/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 2b5b2d2301..ad59abebaa 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -87,9 +87,6 @@ config GOLDFISH_PIC
 config M68K_IRQC
     bool
 
-config NIOS2_VIC
-    bool
-
 config LOONGARCH_IPI
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index ed355941d1..58140da5f2 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -68,7 +68,6 @@ specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
-specific_ss.add(when: 'CONFIG_NIOS2_VIC', if_true: files('nios2_vic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 463d702683..fb998aae0f 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -56,7 +56,6 @@ subdir('loongarch')
 subdir('m68k')
 subdir('microblaze')
 subdir('mips')
-subdir('nios2')
 subdir('openrisc')
 subdir('ppc')
 subdir('remote')
diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
deleted file mode 100644
index 4748ae27b6..0000000000
--- a/hw/nios2/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-config NIOS2_10M50
-    bool
-    select NIOS2
-    select SERIAL
-    select ALTERA_TIMER
-    select NIOS2_VIC
-
-config NIOS2_GENERIC_NOMMU
-    bool
-    select NIOS2
-
-config NIOS2
-    bool
diff --git a/hw/nios2/meson.build b/hw/nios2/meson.build
deleted file mode 100644
index 22277bd6c5..0000000000
--- a/hw/nios2/meson.build
+++ /dev/null
@@ -1,6 +0,0 @@
-nios2_ss = ss.source_set()
-nios2_ss.add(files('boot.c'), fdt)
-nios2_ss.add(when: 'CONFIG_NIOS2_10M50', if_true: files('10m50_devboard.c'))
-nios2_ss.add(when: 'CONFIG_NIOS2_GENERIC_NOMMU', if_true: files('generic_nommu.c'))
-
-hw_arch += {'nios2': nios2_ss}
diff --git a/qemu-options.hx b/qemu-options.hx
index 7fd1713fa8..9b084d343f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4849,10 +4849,10 @@ ERST
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
     QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-    QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2 | QEMU_ARCH_RISCV)
+    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
 SRST
 ``-semihosting``
-    Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, Nios II, RISC-V only).
+    Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, RISC-V only).
 
     .. warning::
       Note that this allows guest direct access to the host filesystem, so
@@ -4865,10 +4865,10 @@ DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
     "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]\n" \
     "                semihosting configuration\n",
 QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2 | QEMU_ARCH_RISCV)
+QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
 SRST
 ``-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]``
-    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, Nios II, RISC-V
+    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V
     only).
 
     .. warning::
diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 0e62f10aad..cd1ee3d3cf 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -37,7 +37,7 @@ mips
   ~ (/qemu)?((/include)?/hw/mips/.*|/target/mips/.*)
 
 nios2
-  ~ (/qemu)?((/include)?/hw/nios2/.*|/target/nios2/.*)
+  ~ (/qemu)?(/target/nios2/.*)
 
 openrisc
   ~ (/qemu)?((/include)?/hw/openrisc/.*|/target/openrisc/.*)
diff --git a/target/nios2/meson.build b/target/nios2/meson.build
index 12d8abf0bd..9b89bd4725 100644
--- a/target/nios2/meson.build
+++ b/target/nios2/meson.build
@@ -5,13 +5,4 @@ nios2_ss.add(files(
   'translate.c',
 ))
 
-nios2_system_ss = ss.source_set()
-nios2_system_ss.add(files(
-  'helper.c',
-  'monitor.c',
-  'mmu.c',
-  'nios2-semi.c',
-))
-
 target_arch += {'nios2': nios2_ss}
-target_system_arch += {'nios2': nios2_system_ss}
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 989b65111c..180ac17326 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1426,14 +1426,6 @@ def test_or1k_sim(self):
         tar_hash = '20334cdaf386108c530ff0badaecc955693027dd'
         self.do_test_advcal_2018('20', tar_hash, 'vmlinux')
 
-    def test_nios2_10m50(self):
-        """
-        :avocado: tags=arch:nios2
-        :avocado: tags=machine:10m50-ghrd
-        """
-        tar_hash = 'e4251141726c412ac0407c5a6bceefbbff018918'
-        self.do_test_advcal_2018('14', tar_hash, 'vmlinux.elf')
-
     def test_ppc64_e500(self):
         """
         :avocado: tags=arch:ppc64
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 10d99403a4..2c81412dba 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -382,17 +382,6 @@ def test_or1k_sim(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'vmlinux')
 
-    def test_nios2_10m50(self):
-        """
-        :avocado: tags=arch:nios2
-        :avocado: tags=machine:10m50-ghrd
-        """
-        tar_hash = 'e4251141726c412ac0407c5a6bceefbbff018918'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day14.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'vmlinux.elf')
-
     def test_ppc_g3beige(self):
         """
         :avocado: tags=arch:ppc
diff --git a/tests/tcg/nios2/Makefile.softmmu-target b/tests/tcg/nios2/Makefile.softmmu-target
deleted file mode 100644
index bc7fd55060..0000000000
--- a/tests/tcg/nios2/Makefile.softmmu-target
+++ /dev/null
@@ -1,32 +0,0 @@
-#
-# Nios2 system tests
-#
-# Copyright Linaro Ltd 2022
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-
-NIOS2_SYSTEM_SRC = $(SRC_PATH)/tests/tcg/nios2
-VPATH += $(NIOS2_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS = boot.o intr.o $(MINILIB_OBJS)
-LINK_SCRIPT = $(NIOS2_SYSTEM_SRC)/10m50-ghrd.ld
-
-CFLAGS  += -nostdlib -g -O0 $(MINILIB_INC)
-LDFLAGS += -Wl,-T$(LINK_SCRIPT) -static -nostdlib $(CRT_OBJS) -lgcc
-
-%.o: %.S
-	$(call quiet-command, $(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@, AS, $@)
-
-%.o: %.c
-	$(call quiet-command, $(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@, CC, $@)
-
-# Build and link the tests
-%: %.o $(LINK_SCRIPT) $(CRT_OBJS)
-	$(call quiet-command, $(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS), LD, $@)
-
-QEMU_OPTS = -M 10m50-ghrd,vic=on -semihosting-config enable=on,target=native,chardev=output -kernel
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-TESTS += $(MULTIARCH_TESTS)
-TESTS += test-shadow-1
diff --git a/tests/tcg/nios2/test-shadow-1.S b/tests/tcg/nios2/test-shadow-1.S
deleted file mode 100644
index 79ef69db12..0000000000
--- a/tests/tcg/nios2/test-shadow-1.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Regression test for TCG indirect global lowering.
- *
- * Copyright Linaro Ltd 2022
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "semicall.h"
-
-	.text
-	.set noat
-	.align	2
-	.globl	main
-	.type	main, @function
-
-main:
-	/* Initialize r0 in shadow register set 1. */
-	movhi	at, 1			/* PRS=1, CRS=0, RSIE=0, PIE=0 */
-	wrctl	status, at
-	wrprs	zero, zero
-
-	/* Change current register set to 1. */
-	movi	at, 1 << 10		/* PRS=0, CRS=1, RSIE=0, PIE=0 */
-	wrctl	estatus, at
-	movia	ea, 1f
-	eret
-
-	/* Load address for callr, then end TB. */
-1:	movia	at, 3f
-	br	2f
-
-	/* Test case! TCG abort on indirect lowering across brcond. */
-2:	callr	at
-
-	/* exit(0) */
-3:	movi	r4, HOSTED_EXIT
-	movi	r5, 0
-	semihosting_call
-
-	.size	main, . - main
-- 
2.41.0


