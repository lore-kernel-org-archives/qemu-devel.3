Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2059C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyEV-0001sP-JN; Fri, 31 Jan 2025 16:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyET-0001e2-Dd
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:21 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEQ-0007x1-Vl
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:21 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso1264472f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357637; x=1738962437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDK+q3FCrguxF8M+fgJqjkVgEsMKiL4tl31vLqfa+ps=;
 b=wV2qjLXWgdyBYf1Xdhv0TwNo86lZWLW48XpYYW0Z7PIII7dGQJmvq4ffpCHZVJo3yC
 VEFKHG4w0ezDSAZerWwo2rQZ8ECgbgFiY7uPzMHUgvWq051NY2r/zQ37opM2lT1vt922
 7Wl1/ylpzuEHObEMqQ5iVXZXUTuWhp0hCXB+zFTxCnFx/UjfasYG0XvV5+MbxvOq2yzd
 RdV+0BpJJtDvKD4gX95XGOcPVan9wg40ifldm4IQimLsVoEROjUZbD9AwS5bb9rOcAl2
 zwnRkASUO1XiXcJfcrEXG5dQIcVFQNd+LyJKkm+E8mmk9uDlDPAVwJVSMl9WgWWPnSix
 r44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357637; x=1738962437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDK+q3FCrguxF8M+fgJqjkVgEsMKiL4tl31vLqfa+ps=;
 b=sZV7V7M0rvBHk6Qzjy8f1lFRELqAGi8QiwNz7Wni6AgCvXDelf5jQPrJX6vsu/S+1h
 /Tj3GYRqw1WmJVQQV5AWWzRkAV2/+cPgzjdoB7LybdxnxPSc0G8JaIORvRKfGKurWCIt
 vJ5tJN7V8kjP258bMRAmUUzq7acs0X89P6PZHNZLY9CX1H5hYWdmrOEnmzdncwvH/8XN
 8Pi8AN6FZZMiNZ00Q7R5r1Prena7QWPnlDRhN5+SLWucgJow2RWE5YxRyYYFOcUbh9Tc
 pBhz16j8ZwQ28NaBoa6AuMQTDtQ2KakF0m5x+nNLmoATA766ORXw47D4aAAEzstoUbe2
 THGQ==
X-Gm-Message-State: AOJu0YyZGkkyZAp7+/uzptdiKjC8N3ILA5gxTsnpVSbfKbM99oT1qzkc
 hUi6PN7Qw4GZHWxBzLtoM3aLv1IAgDIU/VkXTkWgUWDKNBPbI0+YeVtm3GbK27S7dribyEDLR0+
 l0Rg=
X-Gm-Gg: ASbGncsxo09fN7Wt5zyBGT3h6icFqdWirI1pETXnCpL4ZD0oWwZo45gFuT1V8Poy7uk
 STngREJih7ENCtsOxU3ZpKS16hd1E6uWwL3i5AyOJZjp+U6btZpMFeU5ZGDgJytKQEtdYiO75bJ
 53yYvj5eZ9cmSpoMzGGZovA5zzhgx3rMpnjdQeA0kCn0GlydjHiak+ddEtxpODORfJg4QticHdO
 G0rUXVaTQqAHkMDEbRwJpws+9x2itYGBFzfWBFJF3ThorthEBcSiWHCYY61bRSzdIXfAsWV05pC
 iRCz4Tev4JxnBb+VXzTeAEjUTfkPKCbLESEYR6m5fjdEKgC5lWCASPDtLhsJB99YtQ==
X-Google-Smtp-Source: AGHT+IGn70PK56UbqPsq8soUBKrTkejEltXmX5pF+n+StVs30XYhBSf5gqZTI/B6cLjEk9GFmki7ng==
X-Received: by 2002:a05:6000:e0a:b0:388:da2a:e48 with SMTP id
 ffacd0b85a97d-38c5197431dmr9361912f8f.23.1738357636671; 
 Fri, 31 Jan 2025 13:07:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c12191dsm5688802f8f.51.2025.01.31.13.07.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/36] hw/loader: Pass ELFDATA endian order argument to
 load_elf_ram_sym()
Date: Fri, 31 Jan 2025 22:05:06 +0100
Message-ID: <20250131210520.85874-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Rather than passing a boolean 'is_big_endian' argument,
directly pass the ELFDATA, which can be unspecified using
the ELFDATANONE value.

Update the call sites:
  0 -> ELFDATA2LSB

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250127113824.50177-5-philmd@linaro.org>
---
 include/hw/loader.h |  4 ++--
 hw/core/loader.c    | 17 +++++++----------
 hw/riscv/boot.c     |  3 ++-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 9bb34e6f062..8202c376043 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -120,7 +120,7 @@ const char *load_elf_strerror(ssize_t error);
  * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
  * @highaddr: Populated with highest loaded address. Ignored if NULL.
  * @pflags: Populated with ELF processor-specific flags. Ignore if NULL.
- * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
+ * @elf_data_order: Expected ELF endianness (ELFDATA2LSB or ELFDATA2MSB).
  * @elf_machine: Expected ELF machine type
  * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
  *             this for non-address data)
@@ -151,7 +151,7 @@ ssize_t load_elf_ram_sym(const char *filename,
                          uint64_t (*translate_fn)(void *, uint64_t),
                          void *translate_opaque, uint64_t *pentry,
                          uint64_t *lowaddr, uint64_t *highaddr,
-                         uint32_t *pflags, int big_endian, int elf_machine,
+                         uint32_t *pflags, int elf_data_order, int elf_machine,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index de6b173f4a1..f1fab3e91b1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -428,7 +428,8 @@ ssize_t load_elf_as(const char *filename,
 {
     return load_elf_ram_sym(filename, elf_note_fn,
                             translate_fn, translate_opaque,
-                            pentry, lowaddr, highaddr, pflags, big_endian,
+                            pentry, lowaddr, highaddr, pflags,
+                            big_endian ? ELFDATA2MSB : ELFDATA2LSB,
                             elf_machine, clear_lsb, data_swab, as,
                             true, NULL);
 }
@@ -439,12 +440,12 @@ ssize_t load_elf_ram_sym(const char *filename,
                          uint64_t (*translate_fn)(void *, uint64_t),
                          void *translate_opaque, uint64_t *pentry,
                          uint64_t *lowaddr, uint64_t *highaddr,
-                         uint32_t *pflags, int big_endian, int elf_machine,
+                         uint32_t *pflags, int elf_data_order, int elf_machine,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
 {
     const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB;
-    int fd, target_data_order, must_swab;
+    int fd, must_swab;
     ssize_t ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
 
@@ -462,18 +463,14 @@ ssize_t load_elf_ram_sym(const char *filename,
         ret = ELF_LOAD_NOT_ELF;
         goto fail;
     }
-    must_swab = host_data_order != e_ident[EI_DATA];
-    if (big_endian) {
-        target_data_order = ELFDATA2MSB;
-    } else {
-        target_data_order = ELFDATA2LSB;
-    }
 
-    if (target_data_order != e_ident[EI_DATA]) {
+    if (elf_data_order != ELFDATANONE && elf_data_order != e_ident[EI_DATA]) {
         ret = ELF_LOAD_WRONG_ENDIAN;
         goto fail;
     }
 
+    must_swab = host_data_order != e_ident[EI_DATA];
+
     lseek(fd, 0, SEEK_SET);
     if (e_ident[EI_CLASS] == ELFCLASS64) {
         ret = load_elf64(filename, fd, elf_note_fn,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 90e75c69a04..c309441b7d8 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -246,7 +246,8 @@ void riscv_load_kernel(MachineState *machine,
      */
     kernel_size = load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NULL,
                                    &info->image_low_addr, &info->image_high_addr,
-                                   NULL, 0, EM_RISCV, 1, 0, NULL, true, sym_cb);
+                                   NULL, ELFDATA2LSB, EM_RISCV,
+                                   1, 0, NULL, true, sym_cb);
     if (kernel_size > 0) {
         info->kernel_size = kernel_size;
         goto out;
-- 
2.47.1


