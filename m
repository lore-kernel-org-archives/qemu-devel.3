Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50B3CAC5A1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5p-0004nS-TM; Tue, 16 Sep 2025 14:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4m-000399-SQ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4c-0001cK-EE
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45f2c5ef00fso24679365e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045996; x=1758650796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iUSGbKecK/il7MHJUX3WdtSZLN2LPW6TZ0vx6cLCdjI=;
 b=lMo3ZMXr41HWUPrXx1/FZR3jAUna+ItSSNOkh3qOooHVvxNEhaJn8ZmySJsm6FqGer
 PvK9D4ljsErESQIppa2JRcYj2nqdQKRs1JhXCP/Sw1mPX/OqchHCJEAz0WU/xCwOXRF4
 nPMxauXvDQog2D3exTMXE7d1AHOfyfJGcHAn4i3pTZrNTlkQMaBYjrcJAXNF76hj3mhF
 4EBC0FbLuGJwOUPaCzJGktLa3stMNURJigm3jA5b4MRsRsRnK13ilD9PIiGnoWnP/Tub
 3a6oOD0Rtj2kru9n2IhHeLzy8/5KyuXpX9s5ePTlhm8nAP+KjiQg3xI+Bin5ZsJ8Z2iR
 P3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045996; x=1758650796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUSGbKecK/il7MHJUX3WdtSZLN2LPW6TZ0vx6cLCdjI=;
 b=fWO3lIYRa0rAX4Wv5qfKxwz4WiBTCupf+LoWAcbT8f0momwG9xNBfFjdQDmJPSRcyy
 iKSsX7Nh17VEzAOJyC2kbd3iYJHLbwSoE0tgI7zeYOy2epoyfvALV2ZkSvq7NeWW4zTF
 cyfdEmycbG4fDzUw3RHMRnQ07jpT/IFaXbhJKaOOGU1Rzh8ztpvy3Qro5xlPp4DE+MnJ
 hTHR+6FloU5jEsfcH98ToNmJzOcvCaNAbuX4G8mL/P4OfhtF+ODfZH0HnhwWuVKxUD6l
 rCcnq7KliNjLRdiGQL4cVF0ufalNXAC/nfaoeFFGS7QLsrpBaTJf78l+MYTk5q5l5K3H
 nmYw==
X-Gm-Message-State: AOJu0YwkqTyy3CS3XnvNNEaBe2op2FrR906x8ay3ZeEbsxY5AQeZ7CUh
 /BXp32BmaQnVlSTwOwsz4gcmhp3MEEO7lxF9zYjDhM6xeVmSK2Obt+tLZj/wrvjb4/cut+7vx/G
 LPo4J
X-Gm-Gg: ASbGncvJa7FmDwfauGaAp0Rw4qgIXGhgzWzbB1fX1NFZ4EMmmZ/wdm4qGR+zJ8zfVn0
 hDLtRSIvh4UFgCcdrDTa4eFoDdPXC+XbDRDvMn5QsrR6APajVJKDwV8sclf5cQgE6kDDyV9Drd1
 7qFCqbMPUF+Mur4SpXOeMzGt9LDM+RNSRWBQMIeybtrwuztfdQtFb20L1Gz0M/siHnq0xRTu1dg
 QFBKw+/QlCrKBcsX4638WbsXdHQFB9ElOIBvVeb2/G/8b887YXo8QmXHGN8fd2v5zp+TPZrhpUE
 IM5VbzqOVOT/xgO/XDxs1WQ5W9SrU06+pTGvL61mI3ek0FTlNvGlRHHrv3ppXJer/e3NxjAmmmn
 IYDcGW79/L6qcN9Exw4rtXu62VwWQ
X-Google-Smtp-Source: AGHT+IHxsv5UH8m/FIUnvHir7BW0eDdGEDIGfdLgij1cFOQAbNPYT+wp+3EX8qZfwkgEVFBbzrP93Q==
X-Received: by 2002:a05:600c:45c4:b0:45b:9912:9f30 with SMTP id
 5b1f17b1804b1-45f211ca9a5mr173953065e9.6.1758045995510; 
 Tue, 16 Sep 2025 11:06:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/36] system: drop the -old-param option
Date: Tue, 16 Sep 2025 19:05:54 +0100
Message-ID: <20250916180611.1481266-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

We deprecated the command line option -old-param for the 10.0
release, which allows us to drop it in 10.2.  This option was used to
boot Arm targets with a very old boot protocol using the
'param_struct' ABI.  We only ever needed this on a handful of board
types which have all now been removed from QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250828162700.3308812-1-peter.maydell@linaro.org
---
 docs/about/deprecated.rst       | 13 ------
 docs/about/removed-features.rst | 12 +++++
 include/system/system.h         |  1 -
 hw/arm/boot.c                   | 81 +--------------------------------
 system/globals.c                |  1 -
 system/vl.c                     |  4 --
 qemu-options.hx                 |  7 ---
 7 files changed, 13 insertions(+), 106 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f0314147698..03f7cabf730 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -68,19 +68,6 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
-``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``-old-param`` command line option is specific to Arm targets:
-it is used when directly booting a guest kernel to pass it the
-command line and other information via the old ``param_struct`` ABI,
-rather than the newer ATAGS or DTB mechanisms. This option was only
-ever needed to support ancient kernels on some old board types
-like the ``akita`` or ``terrier``; it has been deprecated in the
-kernel since 2001. None of the board types QEMU supports need
-``param_struct`` support, so this option has been deprecated and will
-be removed in a future QEMU version.
-
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 65fd564d229..07ca4079d4b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -560,6 +560,18 @@ the options along with the machine models they were intended for.
 
 Use ``-run-with user=..`` instead.
 
+``-old-param`` option for booting Arm kernels via param_struct (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``-old-param`` command line option was specific to Arm targets:
+it was used when directly booting a guest kernel to pass it the
+command line and other information via the old ``param_struct`` ABI,
+rather than the newer ATAGS or DTB mechanisms. This option was only
+ever needed to support ancient kernels on some old board types
+like the ``akita`` or ``terrier``; it has been deprecated in the
+kernel since 2001. None of the board types QEMU supports need
+``param_struct`` support, so this option has been removed.
+
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/include/system/system.h b/include/system/system.h
index a7effe7dfd8..03a2d0e9005 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -42,7 +42,6 @@ extern int graphic_height;
 extern int graphic_depth;
 extern int display_opengl;
 extern const char *keyboard_layout;
-extern int old_param;
 extern uint8_t *boot_splash_filedata;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d0840308f5a..e77d8679d88 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -337,81 +337,6 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
     WRITE_WORD(p, 0);
 }
 
-static void set_kernel_args_old(const struct arm_boot_info *info,
-                                AddressSpace *as)
-{
-    hwaddr p;
-    const char *s;
-    int initrd_size = info->initrd_size;
-    hwaddr base = info->loader_start;
-
-    /* see linux/include/asm-arm/setup.h */
-    p = base + KERNEL_ARGS_ADDR;
-    /* page_size */
-    WRITE_WORD(p, 4096);
-    /* nr_pages */
-    WRITE_WORD(p, info->ram_size / 4096);
-    /* ramdisk_size */
-    WRITE_WORD(p, 0);
-#define FLAG_READONLY 1
-#define FLAG_RDLOAD   4
-#define FLAG_RDPROMPT 8
-    /* flags */
-    WRITE_WORD(p, FLAG_READONLY | FLAG_RDLOAD | FLAG_RDPROMPT);
-    /* rootdev */
-    WRITE_WORD(p, (31 << 8) | 0); /* /dev/mtdblock0 */
-    /* video_num_cols */
-    WRITE_WORD(p, 0);
-    /* video_num_rows */
-    WRITE_WORD(p, 0);
-    /* video_x */
-    WRITE_WORD(p, 0);
-    /* video_y */
-    WRITE_WORD(p, 0);
-    /* memc_control_reg */
-    WRITE_WORD(p, 0);
-    /* unsigned char sounddefault */
-    /* unsigned char adfsdrives */
-    /* unsigned char bytes_per_char_h */
-    /* unsigned char bytes_per_char_v */
-    WRITE_WORD(p, 0);
-    /* pages_in_bank[4] */
-    WRITE_WORD(p, 0);
-    WRITE_WORD(p, 0);
-    WRITE_WORD(p, 0);
-    WRITE_WORD(p, 0);
-    /* pages_in_vram */
-    WRITE_WORD(p, 0);
-    /* initrd_start */
-    if (initrd_size) {
-        WRITE_WORD(p, info->initrd_start);
-    } else {
-        WRITE_WORD(p, 0);
-    }
-    /* initrd_size */
-    WRITE_WORD(p, initrd_size);
-    /* rd_start */
-    WRITE_WORD(p, 0);
-    /* system_rev */
-    WRITE_WORD(p, 0);
-    /* system_serial_low */
-    WRITE_WORD(p, 0);
-    /* system_serial_high */
-    WRITE_WORD(p, 0);
-    /* mem_fclk_21285 */
-    WRITE_WORD(p, 0);
-    /* zero unused fields */
-    while (p < base + KERNEL_ARGS_ADDR + 256 + 1024) {
-        WRITE_WORD(p, 0);
-    }
-    s = info->kernel_cmdline;
-    if (s) {
-        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED, s, strlen(s) + 1);
-    } else {
-        WRITE_WORD(p, 0);
-    }
-}
-
 static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
                                uint32_t scells, hwaddr mem_len,
                                int numa_node_id)
@@ -802,11 +727,7 @@ static void do_cpu_reset(void *opaque)
                 cpu_set_pc(cs, info->loader_start);
 
                 if (!have_dtb(info)) {
-                    if (old_param) {
-                        set_kernel_args_old(info, as);
-                    } else {
-                        set_kernel_args(info, as);
-                    }
+                    set_kernel_args(info, as);
                 }
             } else if (info->secondary_cpu_reset_hook) {
                 info->secondary_cpu_reset_hook(cpu, info);
diff --git a/system/globals.c b/system/globals.c
index 9640c9511e9..98f9876d5d4 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -52,7 +52,6 @@ bool vga_interface_created;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
-int old_param;
 const char *qemu_name;
 unsigned int nb_prom_envs;
 const char *prom_envs[MAX_PROM_ENVS];
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c66..00f36947257 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3524,10 +3524,6 @@ void qemu_init(int argc, char **argv)
                 prom_envs[nb_prom_envs] = optarg;
                 nb_prom_envs++;
                 break;
-            case QEMU_OPTION_old_param:
-                warn_report("-old-param is deprecated");
-                old_param = 1;
-                break;
             case QEMU_OPTION_rtc:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
                                                false);
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d217..aa44b0e34ae 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5347,13 +5347,6 @@ SRST
         specified, the former is passed to semihosting as it always
         takes precedence.
 ERST
-DEF("old-param", 0, QEMU_OPTION_old_param,
-    "-old-param      old param mode\n", QEMU_ARCH_ARM)
-SRST
-``-old-param``
-    Old param mode (ARM only).
-ERST
-
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "-sandbox on[,obsolete=allow|deny][,elevateprivileges=allow|deny|children]\n" \
     "          [,spawn=allow|deny][,resourcecontrol=allow|deny]\n" \
-- 
2.43.0


