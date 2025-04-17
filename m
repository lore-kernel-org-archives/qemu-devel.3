Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E57C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P1J-0005oZ-LE; Thu, 17 Apr 2025 09:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0o-0005gY-3Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0m-0007xA-3b
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso7377465e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895434; x=1745500234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpvzKS4fhMbrSGoMDkIuIIpRkQ7Sei208LhlRgunzTI=;
 b=aLn8u6FdjZvoJr09gy6YXppAEtbKymcc+ATFzdSCNHGHB9WOVCX84pjvvlM9YN54Ln
 24CquWdYD9zMPZ2bSVkNRPBEJIAz5h+B4p9NhbAH8owIqDOY5ZdnYg4vvE4OmXZOgYXm
 CJ5YeiPbVVpY4JNdnJn0b2z2SL3HGZQm+cNZjP4GwOW02L5naaLmfluV+vqiSUlo5OSM
 FTkNZiOvvl3SxeAT7p01QPCIPbSigCYEo+ZHxjGikeWI2vFQ93ldQCVjw6lbqKvrOwPk
 SfpN3CAsbKHswKwPhCimX9oH0fmgG2bA9lyq6EU8bSzyX5ibaaW/aP0rRHNepW2mwUAf
 YXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895434; x=1745500234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpvzKS4fhMbrSGoMDkIuIIpRkQ7Sei208LhlRgunzTI=;
 b=vWT+nn33rNfqylmLE7X4TtGcGqUUdemmagYzg/bBBrt3fo8oT4SYgNQbUUJL9MORjc
 dEiB332M6XwyDFgRi3pEc+XFaDkIXFeVsLiZhdmMaCOevIUzXvx3CErYbBdUxYN/WWut
 VtQDfs+CxXadY24cIm+IScu7iduf6r1kgsGo5o7XCvQ34uLK6bshiSsNPO1kcH0Eb9s/
 nkw5CJ6t5tpU2KZLpPXkorRmHB2M0dMKa9cVpLr4gmzrM/I/+Acf1UDXoYExnbO4kLE9
 yWd4AE+CFngOJeMrI2Hdx0DNKYli9Q56MYOcS2q8awxSfDQ0kS06lY4dekW5SrifVVoL
 v5iQ==
X-Gm-Message-State: AOJu0YzB59ZfFTU68Sr6eU3DLcrcn6vU+MSnk3ME4GT5HAO/7AQ12+/p
 O7krlLr9x5D2IWkoqyvCIM2Y5K209UDAhf5SczLubvtRM3N+wP2Qd4oMsntzWQsby2fATCGQpzz
 6
X-Gm-Gg: ASbGncsdkLfSpbbh1c85ubmDHNq46rniIfJlp0dNb/y8rKlWm7LMSCfCYDOJVy3GMBF
 EG9UKxT6ouGRHFz5s/2to9mk6czzLrZkSsyA1UvKzcbcCtGZFEcH/6PzYIqwOjEKRhZoFoJJCQR
 iNLY9ACFz5WdGZlHTfpli5UR+/wCzdB9iphhygbJYzDGwA239u81OrSJc+rQ0FGec3wVUARHHV7
 TyAQ7362sMEc/WNDeCFZ24+eA0KEwMXmgtWwpuCVBX17Sxk7NsNwbzSYWr7dJEaX09ae+eds1I/
 mUYxM7BvcCBgXGUB4A2kX5p2YNrfFiRr12y9ThVphJ1N13J/vsLrwka90rjtJMEqkrw/+IsE46l
 qYuAwY4U/WKf/v5o=
X-Google-Smtp-Source: AGHT+IFqWvzj+boW6hQs1Rp1ZbubFxkp4k9mxeFoak/P1umfJCzDv9gquJ4TQGmnGVMNAZ+/duXYoA==
X-Received: by 2002:a05:600c:4e09:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-4405d616b9cmr60431365e9.12.1744895433897; 
 Thu, 17 Apr 2025 06:10:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5a98c3sm52930925e9.38.2025.04.17.06.10.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/mips: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Thu, 17 Apr 2025 15:10:02 +0200
Message-ID: <20250417131004.47205-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/jazz.c    | 10 +++-------
 hw/mips/malta.c   | 21 ++++++---------------
 hw/mips/mipssim.c | 10 +++-------
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 1700c3765de..34879334037 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -59,12 +59,6 @@ enum jazz_model_e {
     JAZZ_PICA61,
 };
 
-#if TARGET_BIG_ENDIAN
-#define BIOS_FILENAME "mips_bios.bin"
-#else
-#define BIOS_FILENAME "mipsel_bios.bin"
-#endif
-
 static void main_cpu_reset(void *opaque)
 {
     MIPSCPU *cpu = opaque;
@@ -168,6 +162,8 @@ static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
 static void mips_jazz_init(MachineState *machine,
                            enum jazz_model_e jazz_model)
 {
+    const char *bios_name = TARGET_BIG_ENDIAN ? "mips_bios.bin"
+                                              : "mipsel_bios.bin";
     MemoryRegion *address_space = get_system_memory();
     char *filename;
     int bios_size, n;
@@ -245,7 +241,7 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
 
     /* load the BIOS image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: bios_name);
     if (filename) {
         bios_size = load_image_targphys(filename, 0xfff00000LL,
                                         MAGNUM_BIOS_SIZE);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 8e9cea70b13..cbdbb210568 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -94,12 +94,6 @@ typedef struct {
     bool display_inited;
 } MaltaFPGAState;
 
-#if TARGET_BIG_ENDIAN
-#define BIOS_FILENAME "mips_bios.bin"
-#else
-#define BIOS_FILENAME "mipsel_bios.bin"
-#endif
-
 #define TYPE_MIPS_MALTA "mips-malta"
 OBJECT_DECLARE_SIMPLE_TYPE(MaltaState, MIPS_MALTA)
 
@@ -383,11 +377,7 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
 
     /* STATUS Register */
     case 0x00208:
-#if TARGET_BIG_ENDIAN
-        val = 0x00000012;
-#else
-        val = 0x00000010;
-#endif
+        val = TARGET_BIG_ENDIAN ? 0x00000012 : 0x00000010;
         break;
 
     /* JMPRS Register */
@@ -1177,9 +1167,12 @@ void mips_malta_init(MachineState *machine)
         target_long bios_size = FLASH_SIZE;
         /* Load firmware from flash. */
         if (!dinfo) {
+            const char *bios_name = TARGET_BIG_ENDIAN ? "mips_bios.bin"
+                                                        : "mipsel_bios.bin";
+
             /* Load a BIOS image. */
             filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                                      machine->firmware ?: BIOS_FILENAME);
+                                      machine->firmware ?: bios_name);
             if (filename) {
                 bios_size = load_image_targphys(filename, FLASH_ADDRESS,
                                                 BIOS_SIZE);
@@ -1197,8 +1190,7 @@ void mips_malta_init(MachineState *machine)
          * In little endian mode the 32bit words in the bios are swapped,
          * a neat trick which allows bi-endian firmware.
          */
-#if !TARGET_BIG_ENDIAN
-        {
+        if (!TARGET_BIG_ENDIAN) {
             uint32_t *end, *addr;
             const size_t swapsize = MIN(bios_size, 0x3e0000);
             addr = rom_ptr(FLASH_ADDRESS, swapsize);
@@ -1211,7 +1203,6 @@ void mips_malta_init(MachineState *machine)
                 addr++;
             }
         }
-#endif
     }
 
     /*
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index b6dabf2893a..46ab7f86c7f 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -46,12 +46,6 @@
 
 #define BIOS_SIZE (4 * MiB)
 
-#if TARGET_BIG_ENDIAN
-#define BIOS_FILENAME "mips_bios.bin"
-#else
-#define BIOS_FILENAME "mipsel_bios.bin"
-#endif
-
 static struct _loaderparams {
     int ram_size;
     const char *kernel_filename;
@@ -143,6 +137,8 @@ mips_mipssim_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    const char *bios_name = TARGET_BIG_ENDIAN ? "mips_bios.bin"
+                                              : "mipsel_bios.bin";
     char *filename;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
@@ -179,7 +175,7 @@ mips_mipssim_init(MachineState *machine)
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
     /* Load a BIOS / boot exception handler image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: bios_name);
     if (filename) {
         bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
         g_free(filename);
-- 
2.47.1


