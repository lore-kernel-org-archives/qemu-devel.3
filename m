Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA54ECA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoU-0004ud-OC; Tue, 02 Sep 2025 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoM-0004hh-Kl
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoD-0004dX-SO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso36309455e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818743; x=1757423543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z49Tz7P6VsH+8nABXwGo+kVjw04xdCM0IalzzOL0Bow=;
 b=u3QIH/knsi5/BkTfckAM0QK0+uXi7wLfPPSRDwWdY23wIp86VxaAJRKE8XOKFQIEIk
 HBK0RJR/nAVhDMomibrqn62RWSQT4nucEfhdwHil0NuJFR87bPQXcFy/0CMFPinM6QtV
 J/MmQq2ZlnR8oCAXJUws0PwgBiqAKnYHe3ehTLmfXtJqKnX0uYdzPWCMlpNDaQgXZLWM
 iBWPwYhHGN6GLYD7oCWp0WOZUjSbDhuXdrhOZzic4tE4Npm71y0p18KsxVkj8IyZlQ7n
 YEU4Oz0UMsXYTjPIijrC6LGiU+fzTg65T0dxD2Rid65dcOT1P++PGwz3bTsbq+wckEMu
 lLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818743; x=1757423543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z49Tz7P6VsH+8nABXwGo+kVjw04xdCM0IalzzOL0Bow=;
 b=WE99MFDiU1Ftdf9fB/B1qimcPnyjwUGcrNU6C+/WpZVWfm+j87eSf9531ndP9ijfb4
 NPa+yChhAxinOEgcN1yjzmGeVXnfxbBHfuPcwc1Yqww/sySxwFTPMhwXub+CXGKxhbco
 c9RP3+3/PXNGsYsNsPZt8iiQqyABulc/JhhRWHa3O1Dn9U6yLTtKdoafXmHsSvzSwQAn
 Ew4B9Mb+TraBFBrVCwqzFxsVzwGgyuewY5ZmMgw5u/uEEsOjUvo1JpfDdKIm7QR5Tbr9
 QNBqVeE24KmSCZULC1oBz5WqIhM6RgtTWNUUdO/yvzOK6c9Fjnp0k/NZPaB+kkzh8WUp
 LNmw==
X-Gm-Message-State: AOJu0YyFWk6Bp60SZ2rsSJR8vAETjFtFCxWH82ElMdXGy0Yh84qfpU1N
 9zmD4nR5RmcFOvh+SRIi9Mw6Aw/MDX0Okssj07HihAM87qikssTMC2X1+iS1Z7Rrqi88m3HFwfs
 cmM9F
X-Gm-Gg: ASbGnctnlkY7QoB8ROq07v8FSL074SLByulJWrtTxRLNtIErPEEgxGC5S5blI2sdXYN
 m4MVV36UY/SXAsgv0u8SozzkLVUDk7KmPiyn1RDk/bVSqAFoouekEj1kOPt9Dm1HPTRnDcr9KvX
 9NYeLzd1G26x/9BMQsGBsVDtN2XjlpaiVC9JBifEfoN+UpIkS74yfCAb8OLAN2AbxYt8Tg+8+Qn
 7FqpgpllvXUcXE5Q+F/l3eiT37cLWjMVvq9ouS5WFPfWOVGbEWnlYNScDrnSwurpKqeD3QeJU80
 hU45Q3OWoZnLgtfA/ckS8fMj/yBPbx170WjY6fW7e6pUuZbH/BGupPLNrwbC5qeb0sQ4Tl4TvXb
 OUh/oGFh+m8hZRXACZo9YPy+NdmtloQ2IlvQs+kgZUCMkmkISNAA3WlUfwFCogpdofPJ3kflLjz
 5V77fBzHo=
X-Google-Smtp-Source: AGHT+IHSP+3fjWLi76E1x0dpnlRRq2m6no1oxkMFpAmHrCCRBw+3FH5swBqkU7yPNa1wAkeLptyRlg==
X-Received: by 2002:a05:600c:1ca4:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45b8554e2ffmr108493355e9.10.1756818742847; 
 Tue, 02 Sep 2025 06:12:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm44165075e9.3.2025.09.02.06.12.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/39] hw/mips: Remove mipssim machine
Date: Tue,  2 Sep 2025 15:10:04 +0200
Message-ID: <20250902131016.84968-28-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The "mipssim" machine is deprecated since commit facfc943cb9
("hw/mips: Mark the "mipssim" machine as deprecated"), released
in v10.0; time to remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20250828143800.49842-2-philmd@linaro.org>
---
 MAINTAINERS                             |   1 -
 docs/about/deprecated.rst               |  12 --
 docs/about/removed-features.rst         |   5 +
 docs/system/target-mips.rst             |  11 --
 configs/devices/mips-softmmu/common.mak |   1 -
 hw/mips/mipssim.c                       | 249 ------------------------
 hw/mips/Kconfig                         |   7 -
 hw/mips/meson.build                     |   1 -
 8 files changed, 5 insertions(+), 282 deletions(-)
 delete mode 100644 hw/mips/mipssim.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 07c9f929d2b..40fc6900829 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1414,7 +1414,6 @@ F: tests/functional/mips*/test_tuxrun.py
 Mipssim
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Orphan
-F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
 Fuloong 2E
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6ae69206817..b2420732e1d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -313,18 +313,6 @@ and serves as the initial engineering sample rather than a production version.
 A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
 replace the older A0 version.
 
-Mips ``mipssim`` machine (since 10.0)
-'''''''''''''''''''''''''''''''''''''
-
-Linux dropped support for this virtual machine type in kernel v3.7, and
-there does not seem to be anybody around who is still using this board
-in QEMU: Most former MIPS-related people are working on other architectures
-in their everyday job nowadays, and we are also not aware of anybody still
-using old binaries with this board (i.e. there is also no binary available
-online to check that this board did not completely bitrot yet). It is
-recommended to use another MIPS machine for future MIPS code development
-instead.
-
 RISC-V default machine option (since 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 332d07e2b18..dc3d4eaa2d1 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1107,6 +1107,11 @@ were added for little endian CPUs. Big endian support was never tested
 and likely never worked. Starting with QEMU v10.1, the machines are now
 only available as little-endian machines.
 
+Mips ``mipssim`` machine (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''''
+
+Linux dropped support for this virtual machine type in kernel v3.7, and
+there was also no binary available online to use with that board.
 
 linux-user mode CPUs
 --------------------
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index 9028c3b304d..2a152e13380 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -12,8 +12,6 @@ machine types are emulated:
 
 -  An ACER Pica \"pica61\". This machine needs the 64-bit emulator.
 
--  MIPS emulator pseudo board \"mipssim\"
-
 -  A MIPS Magnum R4000 machine \"magnum\". This machine needs the
    64-bit emulator.
 
@@ -80,15 +78,6 @@ The Loongson-3 virtual platform emulation supports:
 
 -  Both KVM and TCG supported
 
-The mipssim pseudo board emulation provides an environment similar to
-what the proprietary MIPS emulator uses for running Linux. It supports:
-
--  A range of MIPS CPUs, default is the 24Kf
-
--  PC style serial port
-
--  MIPSnet network emulation
-
 .. include:: cpu-models-mips.rst.inc
 
 .. _nanoMIPS-System-emulator:
diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mips-softmmu/common.mak
index b50107feafe..cdeae7ce450 100644
--- a/configs/devices/mips-softmmu/common.mak
+++ b/configs/devices/mips-softmmu/common.mak
@@ -6,4 +6,3 @@
 
 # Boards are selected by default, uncomment to keep out of the build.
 # CONFIG_MALTA=n
-# CONFIG_MIPSSIM=n
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
deleted file mode 100644
index e843307b9b6..00000000000
--- a/hw/mips/mipssim.c
+++ /dev/null
@@ -1,249 +0,0 @@
-/*
- * QEMU/mipssim emulation
- *
- * Emulates a very simple machine model similar to the one used by the
- * proprietary MIPS emulator.
- *
- * Copyright (c) 2007 Thiemo Seufer
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
-#include "qapi/error.h"
-#include "qemu/datadir.h"
-#include "system/address-spaces.h"
-#include "hw/clock.h"
-#include "hw/mips/mips.h"
-#include "hw/char/serial-mm.h"
-#include "net/net.h"
-#include "system/system.h"
-#include "hw/boards.h"
-#include "hw/loader.h"
-#include "elf.h"
-#include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
-#include "qemu/error-report.h"
-#include "system/qtest.h"
-#include "system/reset.h"
-#include "cpu.h"
-
-#define BIOS_SIZE (4 * MiB)
-
-static struct _loaderparams {
-    int ram_size;
-    const char *kernel_filename;
-    const char *kernel_cmdline;
-    const char *initrd_filename;
-} loaderparams;
-
-typedef struct ResetData {
-    MIPSCPU *cpu;
-    uint64_t vector;
-} ResetData;
-
-static uint64_t load_kernel(void)
-{
-    uint64_t entry, kernel_high, initrd_size;
-    long kernel_size;
-    ram_addr_t initrd_offset;
-
-    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
-                           cpu_mips_kseg0_to_phys, NULL,
-                           &entry, NULL,
-                           &kernel_high, NULL,
-                           TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
-                           EM_MIPS, 1, 0);
-    if (kernel_size < 0) {
-        error_report("could not load kernel '%s': %s",
-                     loaderparams.kernel_filename,
-                     load_elf_strerror(kernel_size));
-        exit(1);
-    }
-
-    /* load initrd */
-    initrd_size = 0;
-    initrd_offset = 0;
-    if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size(loaderparams.initrd_filename);
-        if (initrd_size > 0) {
-            initrd_offset = ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
-            if (initrd_offset + initrd_size > loaderparams.ram_size) {
-                error_report("memory too small for initial ram disk '%s'",
-                             loaderparams.initrd_filename);
-                exit(1);
-            }
-            initrd_size = load_image_targphys(loaderparams.initrd_filename,
-                initrd_offset, loaderparams.ram_size - initrd_offset);
-        }
-        if (initrd_size == (target_ulong) -1) {
-            error_report("could not load initial ram disk '%s'",
-                         loaderparams.initrd_filename);
-            exit(1);
-        }
-    }
-    return entry;
-}
-
-static void main_cpu_reset(void *opaque)
-{
-    ResetData *s = (ResetData *)opaque;
-    CPUMIPSState *env = &s->cpu->env;
-
-    cpu_reset(CPU(s->cpu));
-    env->active_tc.PC = s->vector & ~(target_ulong)1;
-    if (s->vector & 1) {
-        env->hflags |= MIPS_HFLAG_M16;
-    }
-}
-
-static void mipsnet_init(int base, qemu_irq irq)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    dev = qemu_create_nic_device("mipsnet", true, NULL);
-    if (!dev) {
-        return;
-    }
-
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_connect_irq(s, 0, irq);
-    memory_region_add_subregion(get_system_io(),
-                                base,
-                                sysbus_mmio_get_region(s, 0));
-}
-
-static void
-mips_mipssim_init(MachineState *machine)
-{
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
-    const char *bios_name = TARGET_BIG_ENDIAN ? "mips_bios.bin"
-                                              : "mipsel_bios.bin";
-    char *filename;
-    MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *isa = g_new(MemoryRegion, 1);
-    MemoryRegion *bios = g_new(MemoryRegion, 1);
-    Clock *cpuclk;
-    MIPSCPU *cpu;
-    CPUMIPSState *env;
-    ResetData *reset_info;
-    int bios_size;
-
-    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
-#ifdef TARGET_MIPS64
-    clock_set_hz(cpuclk, 6000000); /* 6 MHz */
-#else
-    clock_set_hz(cpuclk, 12000000); /* 12 MHz */
-#endif
-
-    /* Init CPUs. */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
-                                     TARGET_BIG_ENDIAN);
-    env = &cpu->env;
-
-    reset_info = g_new0(ResetData, 1);
-    reset_info->cpu = cpu;
-    reset_info->vector = env->active_tc.PC;
-    qemu_register_reset(main_cpu_reset, reset_info);
-
-    /* Allocate RAM. */
-    memory_region_init_rom(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
-                           &error_fatal);
-
-    memory_region_add_subregion(address_space_mem, 0, machine->ram);
-
-    /* Map the BIOS / boot exception handler. */
-    memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
-    /* Load a BIOS / boot exception handler image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                              machine->firmware ?: bios_name);
-    if (filename) {
-        bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
-        g_free(filename);
-    } else {
-        bios_size = -1;
-    }
-    if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-        machine->firmware && !qtest_enabled()) {
-        /* Bail out if we have neither a kernel image nor boot vector code. */
-        error_report("Could not load MIPS bios '%s'", machine->firmware);
-        exit(1);
-    } else {
-        /* We have a boot vector start address. */
-        env->active_tc.PC = (target_long)(int32_t)0xbfc00000;
-    }
-
-    if (kernel_filename) {
-        loaderparams.ram_size = machine->ram_size;
-        loaderparams.kernel_filename = kernel_filename;
-        loaderparams.kernel_cmdline = kernel_cmdline;
-        loaderparams.initrd_filename = initrd_filename;
-        reset_info->vector = load_kernel();
-    }
-
-    /* Init CPU internal devices. */
-    cpu_mips_irq_init_cpu(cpu);
-    cpu_mips_clock_init(cpu);
-
-    /*
-     * Register 64 KB of ISA IO space at 0x1fd00000.  But without interrupts
-     * (except for the hardcoded serial port interrupt) -device cannot work,
-     * so do not expose the ISA bus to the user.
-     */
-    memory_region_init_alias(isa, NULL, "isa_mmio",
-                             get_system_io(), 0, 0x00010000);
-    memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
-
-    /*
-     * A single 16450 sits at offset 0x3f8. It is attached to
-     * MIPS CPU INT2, which is interrupt 4.
-     */
-    if (serial_hd(0)) {
-        DeviceState *dev = qdev_new(TYPE_SERIAL_MM);
-
-        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-        qdev_prop_set_uint8(dev, "regshift", 0);
-        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
-        memory_region_add_subregion(get_system_io(), 0x3f8,
-                      sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
-    }
-
-    /* MIPSnet uses the MIPS CPU INT0, which is interrupt 2. */
-    mipsnet_init(0x4200, env->irq[2]);
-}
-
-static void mips_mipssim_machine_init(MachineClass *mc)
-{
-    mc->desc = "MIPS MIPSsim platform";
-    mc->init = mips_mipssim_init;
-#ifdef TARGET_MIPS64
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("5Kf");
-#else
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
-#endif
-    mc->default_ram_id = "mips_mipssim.ram";
-}
-
-DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index f84fffcd323..b59cb2f1114 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -13,13 +13,6 @@ config MALTA
     select SERIAL_MM
     select SMBUS_EEPROM
 
-config MIPSSIM
-    bool
-    default y
-    depends on MIPS
-    select SERIAL_MM
-    select MIPSNET
-
 config JAZZ
     bool
     default y
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 31dbd2bf4d9..390f0fd7f9d 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -8,7 +8,6 @@ mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
 
 if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
-mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
 mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
 endif
-- 
2.51.0


