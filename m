Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E698AD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PQ-0007dB-F9; Fri, 15 Nov 2024 15:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PB-0007X3-6h
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P9-0004Nq-DW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-210e5369b7dso25392745ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704338; x=1732309138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u0kRCYJEdfCPc7Ck3L3jOULPW0HIyB/R3/8bipse23E=;
 b=jEGMkkjrhn7xohr3eMKfbimOPF0cs30YzzmAVp5G+/zavuhvIxJT6g0d13cBXb2CaQ
 oYMXnCaGA+k/rsNjRQjZQSmSEflBmm35uVeOKnv0vIZA95O+r2u2zbcrpXUOZM5H47Qc
 4OSiyXc5Mg/CJzPJ/NqcZ3OfGUQLiD16hluruHJ0VgCsQ0Q9lTvfkMx6q7gq7fUzbEJH
 mTDb35PlAYycEwryXhTzOgQJIwXBe6iQsoF2QZ5l+zzGFgD/eqXoXvG2KBUmi2xS9YKI
 sm8YPl9F0PambcJ1yp0shSENULxzm8jMEfFt6G9fED8jYaHZvs8JrBNpBU29NDkWvIVr
 riVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704338; x=1732309138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0kRCYJEdfCPc7Ck3L3jOULPW0HIyB/R3/8bipse23E=;
 b=bc6+aIqRGsAa2rRXQk0IOTT4qHMpaM+E6f+1PffmqjLezrGwffXUtTy9qad2OjAufV
 A12OAKgaHnArsO1lXk/oD6mf3Ps/NMH2NXs42BTKyudsCJJxJ7CHL753UN9jjrEwvhWg
 IveWyfb5C7i+WoRsNkDhB4qPQc88KjGL/AQk81n/p84+ZhI5y5SYPj0LzQr8abk2g8rD
 CroI51RSq0iGCHTGapfCsVzkKiRCZ06EU4K868iravkISGv7FyT/5SUBfmHROZOD1VcQ
 vnzhQg5cqyK/r2J5H/BhN1qbO1ku2PwTmf9BdmhRoy6rNbLs4jd130cDFaHO/SPcAxqM
 AhUw==
X-Gm-Message-State: AOJu0Yz10KDW58Z54fvANTZ5kEZA+fzeCybyQtjsIuM0hGftZoV7BQWh
 CqiuGrFwMHypMstdu6etBIBodAoPec8gRWW2wpGiIuOd5XdeopTThSzL/X4ug6XR2b4EVs6X0F5
 J
X-Google-Smtp-Source: AGHT+IGCj7lPCykHd8gTruUFetT3faBFTBJKQBS/g6oHogyiI1Fh4nZNth+sphWQ+kHSMuG/OQboOQ==
X-Received: by 2002:a17:902:cecf:b0:1fa:1dd8:947a with SMTP id
 d9443c01a7336-211d0ebf182mr46472545ad.46.1731704338124; 
 Fri, 15 Nov 2024 12:58:58 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] linux-user: Honor elf alignment when placing images
Date: Fri, 15 Nov 2024 12:58:42 -0800
Message-ID: <20241115205849.266094-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Most binaries don't actually depend on more than page alignment,
but any binary can request it.  Not honoring this was a bug.

This became obvious when gdb reported

    Failed to read a valid object file image from memory

when examining some vdso which are marked as needing more
than page alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d6ad77d27d..90e79a01b4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3179,7 +3179,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                            char **pinterp_name)
 {
     g_autofree struct elf_phdr *phdr = NULL;
-    abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
+    abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align;
+    size_t reserve_size, align_size;
     int i, prot_exec;
     Error *err = NULL;
 
@@ -3263,6 +3264,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     load_addr = loaddr;
 
+    align = pow2ceil(info->alignment);
+    info->alignment = align;
+
     if (pinterp_name != NULL) {
         if (ehdr->e_type == ET_EXEC) {
             /*
@@ -3271,8 +3275,6 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              */
             probe_guest_base(image_name, loaddr, hiaddr);
         } else {
-            abi_ulong align;
-
             /*
              * The binary is dynamic, but we still need to
              * select guest_base.  In this case we pass a size.
@@ -3290,10 +3292,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Since we do not have complete control over the guest
              * address space, we prefer the kernel to choose some address
              * rather than force the use of LOAD_ADDR via MAP_FIXED.
-             * But without MAP_FIXED we cannot guarantee alignment,
-             * only suggest it.
              */
-            align = pow2ceil(info->alignment);
             if (align) {
                 load_addr &= -align;
             }
@@ -3317,13 +3316,35 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr = target_mmap(load_addr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
+    reserve_size = (size_t)hiaddr - loaddr + 1;
+    align_size = reserve_size;
+
+    if (ehdr->e_type != ET_EXEC && align > qemu_real_host_page_size()) {
+        align_size += align - 1;
+    }
+
+    load_addr = target_mmap(load_addr, align_size, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
                             (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
                             -1, 0);
     if (load_addr == -1) {
         goto exit_mmap;
     }
+
+    if (align_size != reserve_size) {
+        abi_ulong align_addr = ROUND_UP(load_addr, align);
+        abi_ulong align_end = align_addr + reserve_size;
+        abi_ulong load_end = load_addr + align_size;
+
+        if (align_addr != load_addr) {
+            target_munmap(load_addr, align_addr - load_addr);
+        }
+        if (align_end != load_end) {
+            target_munmap(align_end, load_end - align_end);
+        }
+        load_addr = align_addr;
+    }
+
     load_bias = load_addr - loaddr;
 
     if (elf_is_fdpic(ehdr)) {
-- 
2.43.0


