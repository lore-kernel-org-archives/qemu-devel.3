Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB06CD6E57
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzS-0005dd-C8; Sat, 30 May 2026 17:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzH-0005c4-An
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzF-0000cU-MW
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so1654835ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175572; x=1780780372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uem/XZ/RrL0sYo24Yo2p7PELinzpZMdXnM1d28t/L4Y=;
 b=p43LkHFIz2nqcNiH9gfiJ2hXFDirc9Wh5UgbCmsKcSzuiav2hD38B+f3phrTU9kbZK
 9zAYJYldvxtbtLXvzbksiKAYv5gE2xIePpIUi+aE5nBOHLW5GEo7LiAE57WwAhKyWHmm
 1U008CYqddUOC1m04cyzfU9deCAXlA3AjnWDoQcK7KWLcoUM8X8xzN1lz8ux848LEf/o
 5o9eJwgrko0o4igDLSkLHuR4l0Vev2nRw2v8VtRIVCYmiYtPuM0Qwjmh059erCqAayg7
 0JZnppGBmFtauD7aMeor+g0Ugooi/+kygQpXfLVC+6yddwbbnkFnIIZmK5UQv6U2MMBk
 GnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175572; x=1780780372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uem/XZ/RrL0sYo24Yo2p7PELinzpZMdXnM1d28t/L4Y=;
 b=qkMKzkMKFth7180uIdvqZ3iMggWl46OAXOqQLVPKmfjHDAey0F6BwImoj27HBioobO
 fYFDoMqaqyFRDEbMpGke2Wu4xVcNmpGZPMcUyPlYKUDCJ2+/hk8lfdCqyC2+CEFN3FDl
 CRvqZVS3hjR+ezOe5ZFpCjcD2qY/7kyuKxyhx320T444WXlpjXj2ci7R/dSiQauSkHZI
 AgGZxlqsuQaT9UyHNUPxfaNbkUoPW9qSoivUcgb6VrZ9byJjOdSynYUfg0lLef5Kl3O8
 8emYiJ/iObmJbkGWFjWgmHNxQfjNT4nP7veD0tywWYM2KvRs1jaqVS3uBwBJyAAyHEdr
 osBg==
X-Gm-Message-State: AOJu0Yx10y4t5q5Q62SY+X+vuu9mq8CzAd37Z366hiFV0jS+Vr0wEGu4
 wvk0at995AxUcbsCiHXJ/LURuPlhayuj4TkbZz882ZO+vw/bTAOsIPjdnpMKfOUbd66SiBv3EOk
 1wG09rvM=
X-Gm-Gg: Acq92OEb16oTORbfmBc7yub59Njskz1Q5G4Wdv0VH94GDv/KX0y2iLvPw73ix4ypIiI
 +ss+bSZfNmAlnfvhjC/6y0xsIhpGTy+vApr9gwyc8Uo4Q+GUQF6mKsKBrlZTSGq0bfW4aiPYNXv
 0fCds/NyEOmJ8snY4MUBDbKvNyKcdb8kF8C53Gq1az9/0qufNRuVMBMvA5Hzp/+SMS9O162Q/9O
 oV7jk8cYxfigM5N7aaqNMuhjmZugGijlBNhQnBmAcL2Gif6sVm1rRLJ2Foof/i9Dvyljt4snZ6k
 lsG3TxEH4QJfBJ0ZPTteQoQPmjxyb7E/jR+j26ySXn3t1RnqxCX+276RbO5mtcgm05Kmzil5Cnb
 AV/rOKRjnCUbu8Txogullo/lLn3nWJlpx5PsowxScJa7nYdgH8CUqNad87QC0fdr2ozUNwgXzA5
 I5tNPN2CE4QW82CZ7drtyqxIfi22c6nlNt6kSft8c=
X-Received: by 2002:a17:903:32c4:b0:2bf:dd8b:7cd with SMTP id
 d9443c01a7336-2bfdd8b0ac6mr45708155ad.10.1780175571258; 
 Sat, 30 May 2026 14:12:51 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 02/13] linux-user: Use PGBRange in load_elf_image
Date: Sat, 30 May 2026 14:12:36 -0700
Message-ID: <20260530211248.375318-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Collect into range instead of loaddr+hiaddr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e1e1ee4674..fb774adf25 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1278,7 +1278,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                            char **pinterp_name)
 {
     g_autofree struct elf_phdr *phdr = NULL;
-    abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align;
+    PGBRange range = { -1, 0 };
+    abi_ulong load_addr, load_bias, error, align;
     size_t reserve_size, align_size;
     int i, prot_exec;
     Error *err = NULL;
@@ -1318,19 +1319,18 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * Find the maximum size of the image and allocate an appropriate
      * amount of memory to handle that.  Locate the interpreter, if any.
      */
-    loaddr = -1, hiaddr = 0;
     align = 0;
     info->exec_stack = EXSTACK_DEFAULT;
     for (i = 0; i < ehdr->e_phnum; ++i) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
             abi_ulong a = eppnt->p_vaddr & TARGET_PAGE_MASK;
-            if (a < loaddr) {
-                loaddr = a;
+            if (a < range.lo) {
+                range.lo = a;
             }
             a = eppnt->p_vaddr + eppnt->p_memsz - 1;
-            if (a > hiaddr) {
-                hiaddr = a;
+            if (a > range.hi) {
+                range.hi = a;
             }
             ++info->nsegs;
             align |= eppnt->p_align;
@@ -1361,7 +1361,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
         }
     }
 
-    load_addr = loaddr;
+    load_addr = range.lo;
 
     align = pow2ceil(align);
 
@@ -1371,13 +1371,13 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Make sure that the low address does not conflict with
              * MMAP_MIN_ADDR or the QEMU application itself.
              */
-            probe_guest_base(image_name, loaddr, hiaddr);
+            probe_guest_base(image_name, range.lo, range.hi);
         } else {
             /*
              * The binary is dynamic, but we still need to
              * select guest_base.  In this case we pass a size.
              */
-            probe_guest_base(image_name, 0, hiaddr - loaddr);
+            probe_guest_base(image_name, 0, range.hi - range.lo);
 
             /*
              * Avoid collision with the loader by providing a different
@@ -1414,7 +1414,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    reserve_size = (size_t)hiaddr - loaddr + 1;
+    reserve_size = range.hi - range.lo + 1;
     align_size = reserve_size;
 
     if (ehdr->e_type != ET_EXEC && align > qemu_real_host_page_size()) {
@@ -1443,7 +1443,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
         load_addr = align_addr;
     }
 
-    load_bias = load_addr - loaddr;
+    load_bias = load_addr - range.lo;
 
     if (elf_is_fdpic(ehdr)) {
         struct elf32_fdpic_loadseg *loadsegs = info->loadsegs =
@@ -1474,7 +1474,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     info->start_data = -1;
     info->end_data = 0;
     /* Usual start for brk is after all sections of the main executable. */
-    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
+    info->brk = TARGET_PAGE_ALIGN(range.hi + load_bias);
     info->elf_flags = ehdr->e_flags;
 #ifdef TARGET_MIPS
     info->use_k0_tls = (ehdr->e_flags & EF_MIPS_MACH) == EF_MIPS_MACH_OCTEON;
-- 
2.43.0


