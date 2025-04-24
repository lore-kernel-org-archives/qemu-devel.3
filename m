Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539FBC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lH2-0005vm-IL; Wed, 23 Apr 2025 21:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFT-0002lW-5o
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFR-0007AQ-19
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso526023b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457567; x=1746062367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AJHxgd8xUq6D1KvcEBjRZYTNQLKHnzsXGPORpScz2Ns=;
 b=ZqmH19/LZyeCd4I6n9mryrc5rvycjFMJqmmbN0Ioe9T6gi6qKBy0iJnVCJYGCMs1Qp
 +Q78caisfS+TK3zeg0SRoDJCaOgykrbAGIjDamf3qUrux+/At4LVcbmc1rvtrT9vT9ez
 4pxJBb/XZOWSvNPjRKHdv6CgqRkcttcbgQJjfdiP6rtD/UnsNnhEXQsqTzQx7sfVSYGK
 5yZwscj4MbeMnWo3anutHkxndikDogQn8bN2ciUxnoIfHOd/dYod25vqmoAaqi6Re3sY
 L2oiydDs+GOkM9uuiVfcBdxRTUVx3xHvfAf7PT+omnoWCFZXclaGCbowN8MZFZEkojwm
 +zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457567; x=1746062367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJHxgd8xUq6D1KvcEBjRZYTNQLKHnzsXGPORpScz2Ns=;
 b=SKXU82FyS18607kB1YavD+S2zkowB/B9TiJc6B89112EFTln2vg55Ps3e6f86CVEkG
 5NT8e2gtCxKqc0EYc7l17xDZotDtS8GAN2PWmCxnSEPxmEKV9FDPm16yKriDU7sYyHEs
 Uz1kB8gD+D+dknOF+5j2usON3borcHeSeOLPiZzTabfhICeVKvx82foU2o3wjsSVpFLI
 Gx4OutRg5xmOvFNZd5VI3Pd6Y6QLQCMbGHUx16LtQzncNjhtwPfcyA2dEPMoo6gB0EBa
 AmGhh2dcg2fk3xFj4QWvBP+HeQJcDeXgm1Lm+9KOZ0txWQ+x+RODw/f+X9prMhnpTsfN
 ABrQ==
X-Gm-Message-State: AOJu0YwRLozouL+pEUcHVJx2ZlPNxDnHxqGAOvAVovkRw+Vv0uFzbsn/
 pUe8Dy6p/U64Y2l/ov6bQZiySQJVC9sLjt5D+s6SSYcg5CXNdBFAHk0hU3GCwk3qo2I7b6po68W
 U
X-Gm-Gg: ASbGncudiO9WqiUmuyQMlEbJC9QJqWWRhlNUQady4UiIPOevhxlxAQp7Mfs9+fAzELp
 TrlL4/gq5EgmWMkbHZK5DSUW8qEOdqkBYpQdMqY4aV80KHFmsi89uBibcczpXPOvrPMFi5VHiLP
 wBY3sEtkSgT165EQNpZ6ZX2RWxSI3jy909ig7mHrfGKRras7vt4uSmOf3iifmm5qRjmRA/Jh+Lt
 /VwHBZjoLlTKpySeECJZXwNrCT34odp10JidvP0jj/uc0dSxfFrRH2LGE3NApqaE0RTNglW8nrF
 mimsA7lgKR/xIpcF9+Lgkfk49Rj9mm/+If2loYTLQHPBgrl6+Uow/uuBxUjgKc82ZL+18caDcP2
 WqkE1d/37BQ==
X-Google-Smtp-Source: AGHT+IER3+eZHOaBdOBMVaG6qFbNCTB07MsFku2h/slloBF8PLIzVip7O+FNiHqf2b3e1UD9bK5XGQ==
X-Received: by 2002:a05:6a00:1306:b0:73e:2367:c914 with SMTP id
 d2e1a72fcca58-73e2680bccfmr587033b3a.7.1745457567079; 
 Wed, 23 Apr 2025 18:19:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/15] accel/tcg: Use vaddr for walk_memory_regions callback
Date: Wed, 23 Apr 2025 18:19:15 -0700
Message-ID: <20250424011918.599958-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/page-protection.h |  4 +---
 accel/tcg/user-exec.c          | 10 +++++-----
 linux-user/elfload.c           | 19 +++++++++----------
 linux-user/syscall.c           |  8 ++++----
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 1de72e31e6..55aa05ce24 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -88,9 +88,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
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
index 7519b6bcda..e281745e48 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4044,8 +4044,7 @@ static inline void bswap_note(struct elf_note *en) { }
 /*
  * Calculate file (dump) size of given memory region.
  */
-static size_t vma_dump_size(target_ulong start, target_ulong end,
-                            unsigned long flags)
+static size_t vma_dump_size(vaddr start, vaddr end, int flags)
 {
     /* The area must be readable. */
     if (!(flags & PAGE_READ)) {
@@ -4238,8 +4237,8 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
-static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_page_unprotect_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
         size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
@@ -4260,8 +4259,8 @@ typedef struct {
     size_t size;
 } CountAndSizeRegions;
 
-static int wmr_count_and_size_regions(void *opaque, target_ulong start,
-                                      target_ulong end, unsigned long flags)
+static int wmr_count_and_size_regions(void *opaque, vaddr start,
+                                      vaddr end, int flags)
 {
     CountAndSizeRegions *css = opaque;
 
@@ -4275,8 +4274,8 @@ typedef struct {
     off_t offset;
 } FillRegionPhdr;
 
-static int wmr_fill_region_phdr(void *opaque, target_ulong start,
-                                target_ulong end, unsigned long flags)
+static int wmr_fill_region_phdr(void *opaque, vaddr start,
+                                vaddr end, int flags)
 {
     FillRegionPhdr *d = opaque;
     struct elf_phdr *phdr = d->phdr;
@@ -4298,8 +4297,8 @@ static int wmr_fill_region_phdr(void *opaque, target_ulong start,
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


