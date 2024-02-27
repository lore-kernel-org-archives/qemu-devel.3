Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A150C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VT-0006WZ-8N; Tue, 27 Feb 2024 13:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VR-0006Vy-83
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:45 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VP-0001TM-LJ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:44 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so3146822b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059722; x=1709664522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keqqLzVNAo4uH25B4sgF/a/mk1kxuvixDsagaZwoXEA=;
 b=OxK0o86DootcJA/PGAIEqljBMZ2pcp5uozj74eTAIIF7l8CDGiujiSMd7d0rKtfGGW
 8hLBmHrFV8r+wqEcV8LamQm/8isQ3IjYM/lzhfYZ05oEoenj6IQvCufH+HcFRKgjYY0F
 K6l9rPw9kjj3nDVj9NcfHIYzRq6wLezNaXVO33NG5jxgA6A2NcirkOsYJEAsoy3BfQSv
 hF7OJ2/EGRx4mFEFS6HRUwl3sH5iPdu14oimDHcyIYC/UVXcpmokFTAHkScktD/hVDlF
 FXbhLdcLlNvzuuqjZfy8fstYm/KsyEGy81g22kZgoPD451NEi3N7LMA68tnZcpD4rfv+
 384A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059722; x=1709664522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keqqLzVNAo4uH25B4sgF/a/mk1kxuvixDsagaZwoXEA=;
 b=bLBybGEm0OF3BSCZUfz5/fBIPPktopZoh0hiyTqmId5lGtYeLKCc2lFR/uezBos2Q8
 tT3n3rO5yBNwk7S/lsp6liB2l7gtbveRH8ouH1uFAofyYL7k6CNQ5B/A+mH/ltFWILCa
 fAaft0bbXi4aKPVcZ5QX6+LoW9clqJDCKggtIYoRmDiFLs/wTZae15LndobPd1yN3EcP
 /Qb+fZ+LAC9DdUfIP8FV+jQuRGAG4mVCS4quLt0ZbUJaHTSr2pbHkDlHDDXTJivyVtfC
 857PXcCvrvMz+SlFJSXPGmzi/fYwCxP4k7x0TXDPjilWZH4tnoCabW15nAwt3aDOWyNN
 1aKA==
X-Gm-Message-State: AOJu0Yx5EPQBNz8oqiI+5qpZR3Dlmuh2uvHfyP+QAv3sLSrfRTA+RXy6
 PtBk2YjVQzIoBr05GcFQkS9i2n3nRUMWpaGb0Ursn97Pj/4Uwc2MkfauTycAaJzkl4TgLopN0cK
 B
X-Google-Smtp-Source: AGHT+IFg+iVNWZ+9fJ0/jQQHfCeuyonZ5yzNXN582wH8RQlWA1PEJhjT83ehpvoPFfrH/og9tZDzdw==
X-Received: by 2002:a05:6a00:987:b0:6e5:8d9:d59a with SMTP id
 u7-20020a056a00098700b006e508d9d59amr11052223pfg.16.1709059722234; 
 Tue, 27 Feb 2024 10:48:42 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 04/14] linux-user/elfload: Stack allocate struct mm_struct
Date: Tue, 27 Feb 2024 08:48:23 -1000
Message-Id: <20240227184833.193836-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ignoring the fact that g_malloc cannot fail, the structure
is quite small and might as well be allocated locally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cc43487a37..98b82b1a49 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4099,7 +4099,7 @@ struct mm_struct {
     int mm_count;           /* number of mappings */
 };
 
-static struct mm_struct *vma_init(void);
+static void vma_init(struct mm_struct *);
 static void vma_delete(struct mm_struct *);
 static int vma_add_mapping(struct mm_struct *, target_ulong,
                            target_ulong, abi_ulong);
@@ -4174,17 +4174,10 @@ static inline void bswap_note(struct elf_note *en) { }
  * thread that received the signal is stopped.
  */
 
-static struct mm_struct *vma_init(void)
+static void vma_init(struct mm_struct *mm)
 {
-    struct mm_struct *mm;
-
-    if ((mm = g_malloc(sizeof (*mm))) == NULL)
-        return (NULL);
-
     mm->mm_count = 0;
     QTAILQ_INIT(&mm->mm_mmap);
-
-    return (mm);
 }
 
 static void vma_delete(struct mm_struct *mm)
@@ -4195,7 +4188,6 @@ static void vma_delete(struct mm_struct *mm)
         QTAILQ_REMOVE(&mm->mm_mmap, vma, vma_link);
         g_free(vma);
     }
-    g_free(mm);
 }
 
 static int vma_add_mapping(struct mm_struct *mm, target_ulong start,
@@ -4638,7 +4630,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     struct elfhdr elf;
     struct elf_phdr phdr;
     struct rlimit dumpsize;
-    struct mm_struct *mm = NULL;
+    struct mm_struct mm;
     off_t offset = 0, data_offset = 0;
     int segs = 0;
     int fd = -1;
@@ -4664,11 +4656,10 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      * set up structure containing this information.  After
      * this point vma_xxx functions can be used.
      */
-    if ((mm = vma_init()) == NULL)
-        goto out;
+    vma_init(&mm);
 
-    walk_memory_regions(mm, vma_walker);
-    segs = vma_get_mapping_count(mm);
+    walk_memory_regions(&mm, vma_walker);
+    segs = vma_get_mapping_count(&mm);
 
     /*
      * Construct valid coredump ELF header.  We also
@@ -4701,7 +4692,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      * Write program headers for memory regions mapped in
      * the target process.
      */
-    for (vma = vma_first(mm); vma != NULL; vma = vma_next(vma)) {
+    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
         (void) memset(&phdr, 0, sizeof (phdr));
 
         phdr.p_type = PT_LOAD;
@@ -4738,7 +4729,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     /*
      * Finally we can dump process memory into corefile as well.
      */
-    for (vma = vma_first(mm); vma != NULL; vma = vma_next(vma)) {
+    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
         abi_ulong addr;
         abi_ulong end;
 
@@ -4767,8 +4758,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
  out:
     free_note_info(&info);
-    if (mm != NULL)
-        vma_delete(mm);
+    vma_delete(&mm);
     (void) close(fd);
 
     if (errno != 0)
-- 
2.34.1


