Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E02AF483D6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWT-0001gI-3h; Mon, 23 Mar 2026 12:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWQ-0001di-Tg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWO-0000Ua-Vb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so2660195e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284774; x=1774889574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T6H6sf+k0veQoe0EHL4gat/mLrbBV0Ns7HTDzxebBos=;
 b=fDXSbeHr9pgWwJDuwErpnC8uMNaTYVzEOGqWXoqMfjhjWkfYzedoQwdGBaz0WO2w3A
 Zo9DQjuemKRO4T9fZAcixLQvBieVpzsTHNDdjwneI7fuTgJ7QxKccGXeAEhDukY6PLfR
 wzjmCHzGdgB3nYHTGgIxngyMUUOgCLTlJDLMyPDzD0QqCpEsY5icaCg4CQOglzlmnxQA
 nmZgcykjo+M9FSQ9mvw/eEHjbtToZ1xIem4hvltDaPJY000DdmFELRrf/lVIyxLR845k
 f14bVErmAS9eDikxqAsa1lZdkwzjZHuTGUo2PJObgctJEX+iYud357pgU30S8hhHzy+c
 LRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284774; x=1774889574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T6H6sf+k0veQoe0EHL4gat/mLrbBV0Ns7HTDzxebBos=;
 b=jgWr60PMd/aFnbL3YPTfufVimsNpmBscEglV+4ljQFZvLXYeqfe1yQX2ZTH7PstHQi
 u9hL2Z4VKNClaw2FetX4Vn4TUuIqL/qanUaoZS+M9mk8dPEz0ZNZ9alEoY84dizKjcWQ
 pzDuu7zCbxoLU3jTn9Xpc83pLTVIvy4RQnCon7qNZ8ZGgsgZDZ1YCSiZbCGF+rulYsn8
 7BGADMBYUmuFVYoLABfdclaPCnTO53SiZ/rKBHc3YEd+sDgLzoHZnsSK6obgYOW9zPVW
 rHqu5mTSAeWL9Tro1Fy4kTfNtFIxmgAyhi7Ghahi2f8VGD6VEUcODuDFsqZSoMsxuYO/
 cxkg==
X-Gm-Message-State: AOJu0Yy5RNn8REtSHlJnjJHBVaanfnZm3kdpQFED+4j5oFw/OF9jwtUR
 noXnAzLvXzObaKRhJ5UYt6Ban8O9HWyTkiSAcdn3bFzMk4JqZJ1WnzncCV8qSA7UGZxoHZTkfUg
 BO3NW8cE=
X-Gm-Gg: ATEYQzxT3Wps6GclZDLm2s+HM5M/YkcT+IBGI0VnJiFQqbhHPVrUUkOdYXqmLjeHEBU
 Es69nxMv2SQ7T7FI2uhY8TRO7Zp9et5Dtd11BzwWl782/UkabmMX86StKJfy8BfdbOuFpHnUCUh
 Gvt0VMF5QX8aCMrzydp6L0J8nZLc2Gvmj5KKi26eD/oS59Q4YO0Tg4ZhKzn5HxybNGG8CE3YeNH
 sOH+hG+ViCSNiKUC25DhwsPV3xc9BKKwtZT85ttf7UPTPdBuPDJ5saQl/PM88CcIxAp1snJoMAc
 VVb4femapePlsB8Wvi7hTDqsynFetztJJN+gY3UvPqIZqtfTgIeRz+x6aFrfl8/xyNASb/lNAaG
 W9DJTCqwtb+D5u3wyPsfpA9IEl01Ccs9FSCXueRqygkKnqigg63XEefwSry/E+ZosxHYWg1m0Ms
 gYTswSUjpfvvVFt1JYjPZNEf5xNz5Sb4TqV0uGMeI+y1j7YHACdujZ12yJYgVOS54Up7zuvB56+
 CmnqI3eB34=
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id
 5b1f17b1804b1-486ff01efcdmr172669495e9.32.1774284773961; 
 Mon, 23 Mar 2026 09:52:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487031790fdsm245344725e9.3.2026.03.23.09.52.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:52:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/27] hw/core/loader: fix error handling for
 load_image_targphys callers
Date: Mon, 23 Mar 2026 17:51:56 +0100
Message-ID: <20260323165218.96607-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Trieu Huynh <vikingtc4@gmail.com>

Use QEMU's Error API to handle load_image_targphys() failures
consistently across callers.

- Use &error_fatal for callers that previously passed NULL, ensuring
the process exits early on failure instead of continuing in an invalid
state.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260318141415.8538-2-vikingtc4@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/dp264.c     |  2 +-
 hw/hppa/machine.c    |  2 +-
 hw/m68k/next-cube.c  | 11 +++++++++--
 hw/m68k/q800.c       |  2 +-
 hw/m68k/virt.c       |  2 +-
 hw/microblaze/boot.c |  3 ++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 98219f04569..2ab3c147471 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -190,7 +190,7 @@ static void clipper_init(MachineState *machine)
             /* Put the initrd image as high in memory as possible.  */
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+                                ram_size - initrd_base, &error_fatal);
 
             address_space_stq_le(&address_space_memory, param_offset + 0x100,
                                  initrd_base + 0xfffffc0000000000ULL,
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 318ebfeee46..3663bac53bd 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -527,7 +527,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             }
 
             load_image_targphys(initrd_filename, initrd_base, initrd_size,
-                                NULL);
+                                &error_fatal);
             cpu[0]->env.initrd_base = initrd_base;
             cpu[0]->env.initrd_end  = initrd_base + initrd_size;
         }
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 26177c7b867..4bfe5bcf569 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1326,9 +1326,16 @@ static void next_cube_init(MachineState *machine)
     memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
                              0x20000);
     memory_region_add_subregion(sysmem, 0x0, &m->rom2);
-    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
+    Error *local_err = NULL;
+    if (load_image_targphys(bios_name, 0x01000000, 0x20000, &local_err) < 8) {
         if (!qtest_enabled()) {
-            error_report("Failed to load firmware '%s'.", bios_name);
+            if (local_err) {
+                error_report_err(local_err);
+            } else {
+                error_report("Firmware image '%s' is too short.", bios_name);
+            }
+        } else {
+            error_free(local_err);
         }
     } else {
         uint8_t *ptr;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ded531394e6..c0d78eb7d71 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -633,7 +633,7 @@ static void q800_machine_init(MachineState *machine)
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+                                ram_size - initrd_base, &error_fatal);
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e67900c727d..ffe6e234155 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -292,7 +292,7 @@ static void virt_init(MachineState *machine)
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base, NULL);
+                                ram_size - initrd_base, &error_fatal);
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index a6f9ebab90c..4ad5ffd34bd 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -38,6 +38,7 @@
 #include "hw/core/loader.h"
 #include "elf.h"
 #include "qemu/cutils.h"
+#include "qapi/error.h"
 
 #include "boot.h"
 
@@ -171,7 +172,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
         /* Not an ELF image nor an u-boot image, try a RAW image.  */
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, ddr_base,
-                                              ramsize, NULL);
+                                              ramsize, &error_fatal);
             boot_info.bootstrap_pc = ddr_base;
             high = (ddr_base + kernel_size + 3) & ~3;
         }
-- 
2.53.0


