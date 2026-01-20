Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1990D26284
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGff-0004vF-G7; Tue, 20 Jan 2026 13:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfc-0004nC-LP
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfa-0006Y0-Lz
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so5015671f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934496; x=1769539296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MIJXPRC0+/9WoWGyCOIUjQQBuO8DkQLYIb8yEgeRGpc=;
 b=XlEADt+3OdMeGuOT0w6MBeCyrhM0vU/39TsyfBUCPUsTCYleUAgXtb/DLjrJ21Z7ju
 Sk/QcZGWiADITFR5xPoO+w/PsjaN326ucO6Iuxy7//ScSHRBgEBew0/JsiCRLq2EUOIs
 15PaniAG3EH1egzctWbR06IPuSPosA94zTFFCpxYzYbS+KgZ9uDt4Px5srxYVYLSH7U/
 3n4EqShmer2T7t2Q4tac7wgaSQ+GRtlzUSUa4oDHl7bedED1p2s/tkdtWmd1wvizDHO1
 GNgInqRyz9wgTdK8S8hzvpG0iyeWn+7ULhBOBJxQH8n/dWArryanRZuDQ8o7glek5Yjg
 ZLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934496; x=1769539296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MIJXPRC0+/9WoWGyCOIUjQQBuO8DkQLYIb8yEgeRGpc=;
 b=AyWu04bLbpes6uD4xeTTIjGFp6IDB0VI1UnD9CHVjfhlbyLjqtkSMauGg6u6jW3ORr
 gitoELrQULyYsL/ImVuPtvnbxpcDZ9NgFyGJHQQ9gnkYuCxAVeRLlfGrBquM4Uy0Hci+
 tV9QIniy1vQnciT9qFf6ympaCRy8zsRyE1ymm+QIO9NT5KqwugvznNonPtdGAtz16KTO
 faLFhyi/KGlKwxH7XiSFI0Zm/PAyGvI3NuCxjLsPQIo+393+VZs6htnPEPukdqygVOKH
 6ZSsJ4dUbVAN2NfZ9kdl3JF/Ub2ow3SBtu9ZY3bAd2i7brEEj7kHDBaYr05XpeixVsF5
 PLbg==
X-Gm-Message-State: AOJu0YzPAjHC4CKcc4JQuDJ45m47cUvSH8tQV72JmFmOi8nHhxBL/iIm
 zAQA7fJikIDccZzPTlxJmuErUvIG9yNQi5wu8ga2ejOrDf2gUib4cQVeJ2/q4pQ/TD0JR8FzzcW
 XJVR2I90=
X-Gm-Gg: AZuq6aInZA5oB0DOkRp1JTbSxBUkkNYx+uIFZaxQFMmwRwVI6lsSMW8CXRUC4nlKsGP
 w/710xQpkkeLvWVRULfCY/G8bTIkT/BEuwxMp/M949YSarZC5hJOTBQ1L4gZNtyvSlr1Qpx3waP
 fJnVNc5rLP9FAkooLkZ7R34TPRfInBZ9sl+DyzH4O1gxA0kN7zbXJQxjXZn6bPARhclg/5kV7Ko
 Y2tT4wEcKRcYI+niM4lFuJ/SwuoM5KmKKU9UCARaDlziaxKIE0V8dswgHYHjO8WQ9K689aEJuRu
 bmlbrT63HEOzeDZDISc2jqjIuTZ8wdlJnY1w8+LZeDJohK/99eZhBTQFOtLtnj9KhMOVo+unp64
 ianIR0QHr7fPuGsniO9qUGC2MpGSYjleg8ppOWCLABf/v4vNoR2ZVUNkqBBpJWGo1sHGksL+lJ5
 NE8oHYBeUxD+oq8ECWRCd0bMoLeWm84P2h085PN2xoYW2YQkYLxzPwH4axP1Gd
X-Received: by 2002:a5d:5f95:0:b0:42f:b690:6788 with SMTP id
 ffacd0b85a97d-4356997f4afmr22400846f8f.10.1768934496478; 
 Tue, 20 Jan 2026 10:41:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb1fsm30853426f8f.35.2026.01.20.10.41.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] hw/loader: Rename LOAD_IMAGE_MAX _GUNZIP_BYTES to
 _DECOMPRESSED_BYTES
Date: Tue, 20 Jan 2026 19:38:55 +0100
Message-ID: <20260120183902.73845-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

From: Daan De Meyer <daan.j.demeyer@gmail.com>

Preparation for adding support for zstd compressed efi zboot kernel
images.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Message-ID: <20251124123521.1058183-2-daan.j.demeyer@gmail.com>
[PMD: Wrap long line to avoid checkpatch.pl warning]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/loader.h | 2 +-
 hw/arm/boot.c            | 4 ++--
 hw/core/loader.c         | 9 +++++----
 hw/nvram/fw_cfg.c        | 3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index 6f917035034..1f14dccbca9 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -82,7 +82,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr);
  * load_image_gzipped_buffer() will read. It prevents
  * g_malloc() in those functions from allocating a huge amount of memory.
  */
-#define LOAD_IMAGE_MAX_GUNZIP_BYTES (256 << 20)
+#define LOAD_IMAGE_MAX_DECOMPRESSED_BYTES (256 << 20)
 
 ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
                                   uint8_t **buffer);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e22609de93a..c97d4c4e118 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -816,14 +816,14 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
                                    hwaddr *entry, AddressSpace *as)
 {
+    const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
     uint64_t kernel_size = 0;
     uint8_t *buffer;
     ssize_t size;
 
     /* On aarch64, it's the bootloader's job to uncompress the kernel. */
-    size = load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_GUNZIP_BYTES,
-                                     &buffer);
+    size = load_image_gzipped_buffer(filename, max_bytes, &buffer);
 
     if (size < 0) {
         gsize len;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index f4581f76b9a..79cb96b4664 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -829,8 +829,8 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
         goto out;
     }
 
-    if (max_sz > LOAD_IMAGE_MAX_GUNZIP_BYTES) {
-        max_sz = LOAD_IMAGE_MAX_GUNZIP_BYTES;
+    if (max_sz > LOAD_IMAGE_MAX_DECOMPRESSED_BYTES) {
+        max_sz = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     }
 
     data = g_malloc(max_sz);
@@ -896,6 +896,7 @@ struct linux_efi_zboot_header {
  */
 ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
+    const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     const struct linux_efi_zboot_header *header;
     uint8_t *data = NULL;
     ssize_t ploff, plsize;
@@ -931,8 +932,8 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
         return -1;
     }
 
-    data = g_malloc(LOAD_IMAGE_MAX_GUNZIP_BYTES);
-    bytes = gunzip(data, LOAD_IMAGE_MAX_GUNZIP_BYTES, *buffer + ploff, plsize);
+    data = g_malloc(max_bytes);
+    bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
     if (bytes < 0) {
         fprintf(stderr, "failed to decompress EFI zboot image\n");
         g_free(data);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 437ab6e210f..69e97361453 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1115,7 +1115,8 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
 
     if (try_decompress) {
         size = load_image_gzipped_buffer(image_name,
-                                         LOAD_IMAGE_MAX_GUNZIP_BYTES, &data);
+                                         LOAD_IMAGE_MAX_DECOMPRESSED_BYTES,
+                                         &data);
     }
 
     if (size == (size_t)-1) {
-- 
2.52.0


