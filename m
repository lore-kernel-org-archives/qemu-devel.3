Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E86C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNST-00062g-B3; Mon, 27 Jan 2025 06:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNS5-0005zX-R7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:38:50 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNS3-0005Dz-3O
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:38:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2299560f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737977925; x=1738582725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duOqb1GCMJx47PEXJD6iEC2jwq3vPcsjz9INrZ4jd4c=;
 b=a1Gvi2c8CdABavKz3SYRmeVC1qz4mcgQyD7/kxnuGXAZS2raUuqMMsCZDNhlG8whOa
 FNZPG5sw2UwFRofV5CTiIN/jKGFiY0EyIPDI8EcOvzgCnynKqcrxWtCVhu7g9r/8b+Qs
 260qRmKM5KFOvxv+3q6pdZxT17Pym2Yk9F0mdzmebRQIQUIA5ZDYfb/Zje32tBSGo7Jk
 1h5G0x/Gv61tyS2cBPMrwDcN0R5eGWJJ8Zp0NP2Z1HjhX4mXBPnTerJoK5fLNN481Drn
 UaAu4QULdr0vMCmLhfmO6QuhLPfXSoaPgG/MasC4aavHu43u41D69IfthxDNujWNwE05
 1O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737977925; x=1738582725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duOqb1GCMJx47PEXJD6iEC2jwq3vPcsjz9INrZ4jd4c=;
 b=g17+eJQiSB1th4WsWJMoEJjAqP8xrU/nHhgct9xDC1c167GeelB1g0ss6Yu8UQu0W+
 ZNt9N3fDMfgrYkNQb/asGRH5/31gvlj+Nh3DzOxZn5Wg+nVn/b3pw9N8wvLgLydtwOv+
 WtT4eExQQ1yxoKnIXyo7iO1yTCUoLNqP9GnFvcty+zi4GxUWyR3PcLMGwL+wdg3F4iF1
 1ewDpqwfdbZSYqcdNYT927GrxBtVGFyes/eMc0JgbqYqdXJQiC02YGiWrnBXJpVr8HKi
 h3f12W8S95vW+t1ILdHr6HLdTenIpLU6zaZWAyhriPo6E7TL4t05XOu7fbUR1I6j/YxD
 v+LA==
X-Gm-Message-State: AOJu0YzmxRyTbcfmZFFU62XV0IlwEPkR9z//nVp/G4ObnaJYOU5uezk9
 0mexiUazIFiCUS7Fd0SIzsmA80KvE3z16/DlsWQ/umvkemiosPb6vnW3QoFasQHgHyHFxXGo8Ez
 otPI=
X-Gm-Gg: ASbGncu3c0QADNlkKz8905C47k4YePwjbNZNriFMaVMy1XfyYNodE32YYfJ5qyXa8GM
 t7tn0N8tTYRaiyA1+TLXkRm74naPqz5GzwJ4F0pO2Qr7fuD9a8kyl0a+sff/azxvJgLYWtWcewd
 jIxWtF3vv/dEE9mRaU411zPlwp4yy5VW0BAx/kmfoIkCfSrwcfJVJQqcp3DQ+m8kyhKSMPTomxO
 br3ID7XXW9HSYLlyHYcz/omtNRfVOx0cdZgjTu8pazaDpPEmeOtxU4+3xN6aZsJo6UCkz59q7nH
 EweOwZYokMlICSTjawSRs2WGiQEDJ1ZHHeHYApY4R2R73TfC9IBv0djHh+wPdGV+3A==
X-Google-Smtp-Source: AGHT+IE9m0Pju6AwqBuwa4CUoGUL98YIzUfDhFgQ9YFtEW+7z1/21S1cV6mkfoT9w9qLyFOOF1CAqw==
X-Received: by 2002:adf:eb10:0:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38bf566ce7dmr28102438f8f.29.1737977925293; 
 Mon, 27 Jan 2025 03:38:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c3994sm10608811f8f.81.2025.01.27.03.38.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:38:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] hw/loader: Pass ELFDATA endian order argument to
 load_elf_ram_sym()
Date: Mon, 27 Jan 2025 12:38:22 +0100
Message-ID: <20250127113824.50177-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127113824.50177-1-philmd@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loader.h |  4 ++--
 hw/core/loader.c    | 23 ++++++++++-------------
 hw/riscv/boot.c     |  3 ++-
 3 files changed, 14 insertions(+), 16 deletions(-)

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
index fc2e8f91267..0cd34425e9c 100644
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
@@ -439,11 +440,11 @@ ssize_t load_elf_ram_sym(const char *filename,
                          uint64_t (*translate_fn)(void *, uint64_t),
                          void *translate_opaque, uint64_t *pentry,
                          uint64_t *lowaddr, uint64_t *highaddr,
-                         uint32_t *pflags, int big_endian, int elf_machine,
+                         uint32_t *pflags, int elf_data_order, int elf_machine,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
 {
-    int fd, host_data_order, target_data_order, must_swab;
+    int fd, host_data_order, must_swab;
     ssize_t ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
 
@@ -461,22 +462,18 @@ ssize_t load_elf_ram_sym(const char *filename,
         ret = ELF_LOAD_NOT_ELF;
         goto fail;
     }
+
+    if (elf_data_order != ELFDATANONE && elf_data_order != e_ident[EI_DATA]) {
+        ret = ELF_LOAD_WRONG_ENDIAN;
+        goto fail;
+    }
+
 #if HOST_BIG_ENDIAN
     host_data_order = ELFDATA2MSB;
 #else
     host_data_order = ELFDATA2LSB;
 #endif
     must_swab = host_data_order != e_ident[EI_DATA];
-    if (big_endian) {
-        target_data_order = ELFDATA2MSB;
-    } else {
-        target_data_order = ELFDATA2LSB;
-    }
-
-    if (target_data_order != e_ident[EI_DATA]) {
-        ret = ELF_LOAD_WRONG_ENDIAN;
-        goto fail;
-    }
 
     lseek(fd, 0, SEEK_SET);
     if (e_ident[EI_CLASS] == ELFCLASS64) {
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


