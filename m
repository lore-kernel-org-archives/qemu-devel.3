Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E22C369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2p-0001Dy-2h; Fri, 25 Apr 2025 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2j-0000ts-T0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2h-0004C0-Oa
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so20932655e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595162; x=1746199962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uoy04h9rLvehEGP3nFiHZOklDunSqFjwWSNd5Pi4AWw=;
 b=FZEAQhmQUJki89RUuvGYDfFVHXRKu75YJvl8GO4wLVU0xdRUCSP04mrvM94S3kMVVu
 7B97zdH2pPmDEXDwJr8BWd9mjNigfLA6Vz7Bb68YhwZv7OG6zEgibfu0kpE7FMUqZz/I
 csGCdM5nSdOrp1ghPLYchB3FDP+XPKftd0UYatoJ57N9z+An53c/hQmHmYVcA6NqjMaO
 /5Lz2dbnzeFxKcBXHD/Gel2Hdi3t8IAJHQq8j4m5he35n5S1KpWVAmlqsC7xiOmEAjRt
 EZfvEv6pQGiF3WWv4QGccw3SAzYxqP7oyreHF64Wcu+2iYxQM9kSNPTMkrgYwJX/oFqE
 Wkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595162; x=1746199962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uoy04h9rLvehEGP3nFiHZOklDunSqFjwWSNd5Pi4AWw=;
 b=AdKn12BEUb03HsGxP90HbCtlH6mnIxAGfXfsEVSS8I68eDUX1aYaQ+x8gE0/JWw+gy
 nlk0A9+JFofvCGxI3CJbYzk1ZOXp4sw2EsSY6403EIzB52khWPmYKTFozATBfh6RdWev
 EUEHqII8sqL/sUdAkm22CdwMvbS3Ax4mT8zd6+BQtUlme0l6rJIZ9EcyWatCVeorxGyJ
 TmrcdGI9BFtoaO07QxfLmDRiVhEzVn5FBgUzuK0l/sljcFlYnGe4xgwSKcgyisAE6d39
 gpvsz5GD6wN7K2yr2OL0MWMPAxbDWMXpfJxP5sZD3sYex0bvczlA/uNTwGF2gHx0uZ59
 ZpEg==
X-Gm-Message-State: AOJu0YxclWFROMrTwepEbS1+VGnVqPU5skbgAeiCFlB9i9bKlMAox121
 3OR71OoQ5b1sgaw8vtuUmwvNpVI5VTQorkxAPOfNyxOonEUK/I6a0mislrFTbH67lJXabg3iiHG
 D
X-Gm-Gg: ASbGncu3bA82R8TW8AmpBqOOtTkOpGIbbV8nDDvUOPbSHXAWGwVwbCf9OBkJDWG2uZu
 fZ7QFtI3jz4tlm3XOYdpLI1wdLmLkywqzwY4vrQa1VuDnEVfoMBAXOCB4wBmlZSq/obHgztfKNl
 Pv+0QOlSkgFXw6rQjkpsvLTTOaciMh41VmeDJWuAjN7XUYpwIKIQQpG+bgqQsfPTYh25ks1kHlo
 i5x75+t87+imb6AbKJyCm823C7eMbNasUJ/sq4p3JVPMl5VVarXxFX/LkZUpXgrT5NteKwGhubi
 /1nlK9Bx5NEZf8CDhRO/ENRdeOeiobXM1mpEiBOFtDlISEUTjGz3EsA4KrPvmCMjd1tSKOBDAbX
 zfXbTOql53Eo0TPk=
X-Google-Smtp-Source: AGHT+IHFUqZOXzHZiJNpqQIh1XwQDBgwYZO+OPRW0lxA24Cfk3dGof49tSK3nl8cnVvTujpR+LPAfA==
X-Received: by 2002:a05:6000:144d:b0:39c:140c:308 with SMTP id
 ffacd0b85a97d-3a06d641f42mr6083642f8f.3.1745595161666; 
 Fri, 25 Apr 2025 08:32:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8da58sm2711700f8f.15.2025.04.25.08.32.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 48/58] hw/mips: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Fri, 25 Apr 2025 17:28:32 +0200
Message-ID: <20250425152843.69638-49-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250417131004.47205-7-philmd@linaro.org>
---
 hw/mips/jazz.c    | 11 ++++-------
 hw/mips/malta.c   | 21 ++++++---------------
 hw/mips/mipssim.c | 11 ++++-------
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index cee92e1825e..7fb0b97a388 100644
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
@@ -245,7 +241,8 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
 
     /* load the BIOS image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                              machine->firmware ?: bios_name);
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
index b6dabf2893a..e843307b9b6 100644
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
@@ -179,7 +175,8 @@ mips_mipssim_init(MachineState *machine)
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
     /* Load a BIOS / boot exception handler image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                              machine->firmware ?: bios_name);
     if (filename) {
         bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
         g_free(filename);
-- 
2.47.1


