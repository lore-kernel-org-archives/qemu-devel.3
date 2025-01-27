Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B729C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNSX-00066L-4N; Mon, 27 Jan 2025 06:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNSB-000614-Do
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:38:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNS8-0005Er-BK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:38:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so44609085e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737977931; x=1738582731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uL+nnGyGOIubwvzcr2z3yGpj5dC7Jx5PGuyfw3ZHtPA=;
 b=vFHi0fXoI5Y0r6xCKe8YY2REAlR7joZUigBzw9yjP9gdkJtQsscyeDE5GInmNaLnun
 4gEu7NhdyOaUgo7oE1moQMa3RoanFD1TiBEBt+8CIUk/qyVRbLYjPOGthC6WKN2Rsri0
 wwkNJTtvGwM3vT5PU2MaDzXedcsbFtNcf1yOofJ8GQrpZgo3NGZALxBkT2QK5/GIP0H4
 PB67qrDKm6wKRoy+Um2v0joMee8WHFi+ErQUlVVDUOZPxsCfte23yLPCAoCb88nD41EO
 8vgglxKaZooZVH2tXE+Dicxeph8AUtnJxAUIyj5z0pP7O5Ph0jlrXDiC2mH4EkmsbFJS
 qI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737977931; x=1738582731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uL+nnGyGOIubwvzcr2z3yGpj5dC7Jx5PGuyfw3ZHtPA=;
 b=kdGNkDaOVwNrHHHtxma0gDzeckLthhLPfh59uBHJmsIruW3P1i6DmrvkDGUqIXgRdX
 0MLyl1UkZz0KdZw7wFU6OkKmxKby7BD/tb1eD1UZxkF+u6egYuDEcz/FJQBWNBsKMeRd
 H2fJH+t3n+VnAsTyxsOJ6YpG4yKYWPSxUinSFCDq8DjtbQDJADFsR17Ib5d7zwvQ3DA+
 TcO67fOC3k85Hu4qJPUpv8WM22iVJDW9s5SF5reH9wU9M6oduWs9M97FnRHwC9vgCb+D
 HdCNUQszw5Ha+YKenSGKKh+ibACbm/mYVIXzMVT073Y9pI+qlGSMAVQTYudgCuEY4en0
 miVQ==
X-Gm-Message-State: AOJu0YxVTiNXA//q9Mbs4G84pFZhZJyz+RfRQ1F9yl3PxT9AR0AaNYsJ
 igDzUHwDO+k4kaq8ztl//3R998+tETLBD11t8Exxui5ch54ezQWkWhGaMA628sqs2Bk4/+V9pwD
 HssQ=
X-Gm-Gg: ASbGnctUYBUalnU3LKZVFfyVYErpL1LeEXc1wH8O8f0z1jRfHf6WhSeiNgT4c6nC/Xc
 x0EjNwPXvSraCti4h0ILI9a/vVb4xhdOqH7EuufaN/zYXEJTD28oKIwMnBagXNdK5wCVIVxZHqm
 iYpkIGZw+YHtt/OKMuR1rhlKsP3yWHZAhVR9gTsyCz/RBjvPU3BlNtks19tSLQ09Y2akKxDsxtM
 QG0KgJ2gXmqXCbegb0YVjl0IsXS7BLqgwZAbsWNtzNCNXixjnOF3Ne/TSEZ9LvQxjzjNds9gozf
 u4pafTR+PZYa5g5dQVzFK1PxR+Ufq5pYYUsIO0F90rCEPdTWqUaK9Q0=
X-Google-Smtp-Source: AGHT+IF4ibR7kZRreK3zGw/53OzPbMV5BDzRm6fHb6QGe1KZCCEtl9T0CyI8Zp8iSXw5RdnPvibVFA==
X-Received: by 2002:a05:600c:35c3:b0:438:a290:3ce0 with SMTP id
 5b1f17b1804b1-438a2903f47mr322246355e9.8.1737977930619; 
 Mon, 27 Jan 2025 03:38:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0d1sm130524395e9.26.2025.01.27.03.38.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:38:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/loader: Pass ELFDATA endian order argument to
 load_elf_as()
Date: Mon, 27 Jan 2025 12:38:23 +0100
Message-ID: <20250127113824.50177-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127113824.50177-1-philmd@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Rather than passing a boolean 'is_big_endian' argument,
directly pass the ELFDATA, which can be unspecified using
the ELFDATANONE value.

Update the call sites:
  0 -> ELFDATA2LSB
  1 -> ELFDATA2MSB

Note, this allow removing the target_words_bigendian() call
in the GENERIC_LOADER device, where we pass ELFDATANONE.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loader.h      |  2 +-
 hw/core/loader.c         |  8 ++++----
 hw/arm/armv7m.c          |  2 +-
 hw/arm/boot.c            | 16 ++++++++--------
 hw/avr/boot.c            |  2 +-
 hw/core/generic-loader.c |  6 +-----
 6 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 8202c376043..84737c05b8d 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -162,7 +162,7 @@ ssize_t load_elf_as(const char *filename,
                     uint64_t (*elf_note_fn)(void *, void *, bool),
                     uint64_t (*translate_fn)(void *, uint64_t),
                     void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
-                    uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                    uint64_t *highaddr, uint32_t *pflags, int elf_data_order,
                     int elf_machine, int clear_lsb, int data_swab,
                     AddressSpace *as);
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 0cd34425e9c..84c7f7987ec 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -413,7 +413,8 @@ ssize_t load_elf(const char *filename,
                  int elf_machine, int clear_lsb, int data_swab)
 {
     return load_elf_as(filename, elf_note_fn, translate_fn, translate_opaque,
-                       pentry, lowaddr, highaddr, pflags, big_endian,
+                       pentry, lowaddr, highaddr, pflags,
+                       big_endian ? ELFDATA2MSB : ELFDATA2LSB,
                        elf_machine, clear_lsb, data_swab, NULL);
 }
 
@@ -422,14 +423,13 @@ ssize_t load_elf_as(const char *filename,
                     uint64_t (*elf_note_fn)(void *, void *, bool),
                     uint64_t (*translate_fn)(void *, uint64_t),
                     void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
-                    uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                    uint64_t *highaddr, uint32_t *pflags, int elf_data_order,
                     int elf_machine, int clear_lsb, int data_swab,
                     AddressSpace *as)
 {
     return load_elf_ram_sym(filename, elf_note_fn,
                             translate_fn, translate_opaque,
-                            pentry, lowaddr, highaddr, pflags,
-                            big_endian ? ELFDATA2MSB : ELFDATA2LSB,
+                            pentry, lowaddr, highaddr, pflags, elf_data_order,
                             elf_machine, clear_lsb, data_swab, as,
                             true, NULL);
 }
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index a67a890a33e..98a69846119 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -608,7 +608,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
     if (kernel_filename) {
         image_size = load_elf_as(kernel_filename, NULL, NULL, NULL,
                                  &entry, NULL, NULL,
-                                 NULL, 0, EM_ARM, 1, 0, as);
+                                 NULL, ELFDATA2LSB, EM_ARM, 1, 0, as);
         if (image_size < 0) {
             image_size = load_image_targphys_as(kernel_filename, mem_base,
                                                 mem_size, as);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b44bea8a821..cbc24356fc1 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -798,7 +798,7 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
         Elf64_Ehdr h64;
     } elf_header;
     int data_swab = 0;
-    bool big_endian;
+    int elf_data_order;
     ssize_t ret;
     Error *err = NULL;
 
@@ -814,12 +814,12 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     }
 
     if (elf_is64) {
-        big_endian = elf_header.h64.e_ident[EI_DATA] == ELFDATA2MSB;
-        info->endianness = big_endian ? ARM_ENDIANNESS_BE8
-                                      : ARM_ENDIANNESS_LE;
+        elf_data_order = elf_header.h64.e_ident[EI_DATA];
+        info->endianness = elf_data_order == ELFDATA2MSB ? ARM_ENDIANNESS_BE8
+                                                         : ARM_ENDIANNESS_LE;
     } else {
-        big_endian = elf_header.h32.e_ident[EI_DATA] == ELFDATA2MSB;
-        if (big_endian) {
+        elf_data_order = elf_header.h32.e_ident[EI_DATA];
+        if (elf_data_order == ELFDATA2MSB) {
             if (bswap32(elf_header.h32.e_flags) & EF_ARM_BE8) {
                 info->endianness = ARM_ENDIANNESS_BE8;
             } else {
@@ -839,8 +839,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     }
 
     ret = load_elf_as(info->kernel_filename, NULL, NULL, NULL,
-                      pentry, lowaddr, highaddr, NULL, big_endian, elf_machine,
-                      1, data_swab, as);
+                      pentry, lowaddr, highaddr, NULL, elf_data_order,
+                      elf_machine, 1, data_swab, as);
     if (ret <= 0) {
         /* The header loaded but the image didn't */
         error_report("Couldn't load elf '%s': %s",
diff --git a/hw/avr/boot.c b/hw/avr/boot.c
index 6a91dcd12d0..e5a29c7218e 100644
--- a/hw/avr/boot.c
+++ b/hw/avr/boot.c
@@ -73,7 +73,7 @@ bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
 
     bytes_loaded = load_elf_as(filename, NULL, NULL, NULL,
                                &entry, NULL, NULL,
-                               &e_flags, 0, EM_AVR, 0, 0, NULL);
+                               &e_flags, ELFDATA2LSB, EM_AVR, 0, 0, NULL);
     if (bytes_loaded >= 0) {
         /* If ELF file is provided, determine CPU type reading ELF e_flags. */
         const char *elf_cpu = avr_elf_e_flags_to_cpu_type(e_flags);
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 0ddb3a359a2..5fdbc3f3be2 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -31,7 +31,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/tswap.h"
 #include "system/dma.h"
 #include "system/reset.h"
 #include "hw/boards.h"
@@ -63,7 +62,6 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
 {
     GenericLoaderState *s = GENERIC_LOADER(dev);
     hwaddr entry;
-    int big_endian;
     ssize_t size = 0;
 
     s->set_pc = false;
@@ -131,14 +129,12 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         s->cpu = first_cpu;
     }
 
-    big_endian = target_words_bigendian();
-
     if (s->file) {
         AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
 
         if (!s->force_raw) {
             size = load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL, NULL,
-                               NULL, big_endian, 0, 0, 0, as);
+                               NULL, ELFDATANONE, 0, 0, 0, as);
 
             if (size < 0) {
                 size = load_uimage_as(s->file, &entry, NULL, NULL, NULL, NULL,
-- 
2.47.1


