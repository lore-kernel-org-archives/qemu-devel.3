Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8839EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLh-0000tO-C3; Thu, 01 May 2025 17:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLV-0000mM-Ng
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLS-0001T8-Go
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso1560318b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134485; x=1746739285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lQC8i/0dPaM85oLPPx0UiyxJ6AllGzTfuqWrQATKIE=;
 b=ZIXxa2UhVjzbSCR5aebpby665XzQibuAU5s8DleGAVsWK3NbnBcNvzkGEvpcVsQe7f
 uSzMh+ch88KCccgxddg3nwjvsWlNNu27HmvMppZkD+qapAJkrxIR7z6NuvIRl8N5zySs
 ZZDyivJTk7DzTeReDjG2U+ahv2WzQmisBcvBhBYaJ6j7/lrx4adGPUnyL39QcS1WW5/k
 LOFY6mE91Cz03ZnXvVNxp2P0rWg6Rqr6ybvaYxtwtN4POcWIAKCgjlCvlsNy0c6V4hnj
 cpGuOGwbjYrKwQMHqPFb06I9X2qlarUsMV7Vensetv0rx7SIOhYlcsIfovKKP6nAq+wD
 KwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134485; x=1746739285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lQC8i/0dPaM85oLPPx0UiyxJ6AllGzTfuqWrQATKIE=;
 b=r+CoDhs2Y0PJvMrf/7ySAO4WPYxfM3O4HKFZcGE+ai7p8BMg4ATw7EE+3W4rcNwITR
 fgk3FL14W6l/4j0IYKKKiMKH4SI7l4GfzwMkXcbxSEz8UAgZC/rp/jyDMrPWxkArUx6j
 7oFfH9WZkeWVTB+b9UCRohuM0GQZt39Cc4LuHmYdgbzNDXiMPsbrdbbGResOhxuQS1oR
 Oo0cS9hTR5ideh1WFlC9FBFnUbVNRSTohsjk/w/ZbGu4C9QBFxuJdxz9x+d15WRsZiR8
 k7zRH2I4OxIVAMoLtgQUfPzzdnDl3uNKTLumez7uyuU1WEg4KkxP7ZaNQ4zatGH3wA+i
 lo5A==
X-Gm-Message-State: AOJu0YwYMM0LtQn8eMrSaPcnIy3Z9DOIAD0n1f3//i6PNuycaJc7GT5j
 8d20uEDTu6UT1jKc/E9XxQayEfCM1CGDn0x7GZG8/ih4yT96ZDkEdgMKgl+H2FWaZlj099m48Ep
 b
X-Gm-Gg: ASbGnct9fPm1lMdZWBI/UjY1D3zGVhaxa/xK6jV3SCimzAA2GFMEARIy12qHlrkCr90
 HQ7fMAG9FgTyScS37/2wRSCga46zCccctlUrn5Kb6vQb8bDqzaTpxKghCngIba3xZAd2CptVilz
 LDpO1Dh6MZYZqIX/WvkKPGkZxdfvc1z4munpf/2YYANDWxUXlPkLF3GcvvHYxt/3LiihRY5M7K6
 uuVxjJLcF8du54vvCY/sP74GP7v2wdUTqD1Z+le+ySgPflCDYwZGSdjOrjEHk98i9HlY7fNg1zh
 ++xk0+l/hpdNQUhHvGlb8pLOyFwzoZXeAfpq4kSoRa2lnN5l+iDRmjNjRce+eD+66jWMW8Ub8E0
 =
X-Google-Smtp-Source: AGHT+IG+fXxqI3GbdBWum0Z+GAXHOm9OEuArLBSocM9lYZ5ZST9V6GT1TmZWu+ufn/1tgmocGiGnzA==
X-Received: by 2002:a17:90b:2d50:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-30a4e6b5788mr747383a91.34.1746134484854; 
 Thu, 01 May 2025 14:21:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/59] accel/tcg: Use vaddr for walk_memory_regions callback
Date: Thu,  1 May 2025 14:20:26 -0700
Message-ID: <20250501212113.2961531-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Use vaddr instead of target_ulong.  At the same time,
use int instead of unsigned long for flags, to match
page_set_flags().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/page-protection.h |  5 ++---
 accel/tcg/user-exec.c          | 10 +++++-----
 linux-user/elfload.c           | 19 +++++++++----------
 linux-user/syscall.c           |  8 ++++----
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 1de72e31e6..8f0b769b13 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -14,6 +14,7 @@
 
 #include "cpu-param.h"
 #include "exec/target_long.h"
+#include "exec/vaddr.h"
 #include "exec/translation-block.h"
 
 int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc);
@@ -88,9 +89,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
 __attribute__((returns_nonnull))
 void *page_get_target_data(target_ulong address);
 
-typedef int (*walk_memory_regions_fn)(void *, target_ulong,
-                                      target_ulong, unsigned long);
-
+typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
 int walk_memory_regions(void *, walk_memory_regions_fn);
 
 void page_dump(FILE *f);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 17e3be337f..25d86567e7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -199,13 +199,13 @@ int walk_memory_regions(void *priv, walk_memory_regions_fn fn)
     return rc;
 }
 
-static int dump_region(void *priv, target_ulong start,
-                       target_ulong end, unsigned long prot)
+static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 {
-    FILE *f = (FILE *)priv;
+    FILE *f = opaque;
 
-    fprintf(f, TARGET_FMT_lx"-"TARGET_FMT_lx" "TARGET_FMT_lx" %c%c%c\n",
-            start, end, end - start,
+    fprintf(f, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+            " " TARGET_ABI_FMT_ptr " %c%c%c\n",
+            (abi_ptr)start, (abi_ptr)end, (abi_ptr)(end - start),
             ((prot & PAGE_READ) ? 'r' : '-'),
             ((prot & PAGE_WRITE) ? 'w' : '-'),
             ((prot & PAGE_EXEC) ? 'x' : '-'));
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 87c6d3ab9f..82ebf6a212 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4059,8 +4059,7 @@ static void bswap_note(struct elf_note *en)
 /*
  * Calculate file (dump) size of given memory region.
  */
-static size_t vma_dump_size(target_ulong start, target_ulong end,
-                            unsigned long flags)
+static size_t vma_dump_size(vaddr start, vaddr end, int flags)
 {
     /* The area must be readable. */
     if (!(flags & PAGE_READ)) {
@@ -4253,8 +4252,8 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
-static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_page_unprotect_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
         size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
@@ -4275,8 +4274,8 @@ typedef struct {
     size_t size;
 } CountAndSizeRegions;
 
-static int wmr_count_and_size_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_count_and_size_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     CountAndSizeRegions *css = opaque;
 
@@ -4290,8 +4289,8 @@ typedef struct {
     off_t offset;
 } FillRegionPhdr;
 
-static int wmr_fill_region_phdr(void *opaque, target_ulong start,
-                                target_ulong end, unsigned long flags)
+static int wmr_fill_region_phdr(void *opaque, vaddr start,
+                                vaddr end, int flags)
 {
     FillRegionPhdr *d = opaque;
     struct elf_phdr *phdr = d->phdr;
@@ -4313,8 +4312,8 @@ static int wmr_fill_region_phdr(void *opaque, target_ulong start,
     return 0;
 }
 
-static int wmr_write_region(void *opaque, target_ulong start,
-                            target_ulong end, unsigned long flags)
+static int wmr_write_region(void *opaque, vaddr start,
+                            vaddr end, int flags)
 {
     int fd = *(int *)opaque;
     size_t size = vma_dump_size(start, end, flags);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5826ac3adb..23b901b713 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8135,8 +8135,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
  * Callback for walk_memory_regions, when read_self_maps() fails.
  * Proceed without the benefit of host /proc/self/maps cross-check.
  */
-static int open_self_maps_3(void *opaque, target_ulong guest_start,
-                            target_ulong guest_end, unsigned long flags)
+static int open_self_maps_3(void *opaque, vaddr guest_start,
+                            vaddr guest_end, int flags)
 {
     static const MapInfo mi = { .is_priv = true };
 
@@ -8147,8 +8147,8 @@ static int open_self_maps_3(void *opaque, target_ulong guest_start,
 /*
  * Callback for walk_memory_regions, when read_self_maps() succeeds.
  */
-static int open_self_maps_2(void *opaque, target_ulong guest_start,
-                            target_ulong guest_end, unsigned long flags)
+static int open_self_maps_2(void *opaque, vaddr guest_start,
+                            vaddr guest_end, int flags)
 {
     const struct open_self_maps_data *d = opaque;
     uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
-- 
2.43.0


