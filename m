Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C49ECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqA-0003u9-HK; Thu, 18 Jun 2026 15:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq2-0003sU-NZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIpv-0007rA-Pr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c6bc87f4d5so5988225ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812530; x=1782417330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sb+MPff6QX844HAYEHBQvEZrKABgvd2wf2uC/76ZV/g=;
 b=EY6dS6DavLd3Ayr8qGifRx27tMpyx/sli0Wr5z/VvWjp8u0+g9uxZT1UcNRwdnzLL1
 a/9QV7KcyGC6X/k8+JRYV3Uo1yoTVjnVJHY3Z9BEM3req7NK1+IILjg/FMRjg6J+Cz5f
 KBk8hzL38CwdJDXvlAKRUEnH1959kqP6m3+AKn8D7NhWjQeW85ai2f7eN2n4ym303uDY
 p+5UWxI8KxAGtjR8HHJDm7CyDS+uuYcF6ARXzxlG3bsFGflRlse2NeGXG4bGYg3RYC64
 ULZuJ1DDjiQf3r3ro+XSsZCRa7bWPPbQWAOxaJh7kJNszBAc5OnYajXUC+ijswQk8s8h
 g+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812530; x=1782417330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sb+MPff6QX844HAYEHBQvEZrKABgvd2wf2uC/76ZV/g=;
 b=nsmK3fhwE9O4qixxlbtTxRFRkrGrCfwc1TGCRU6754+NuqNprn2DYjtXOLz/s/dLJP
 GVKllWBgT81RRxMLwDSLUwQtTUg2Lw2N1IJT3p6l1C6q0Wh3Fgm/IxCSMTFfhv7S3JiG
 HWiQAAcNeJ3ZIxSWcMrXOYMTQxVm3bYo+B/oRvVQdwMJiwevnm1BicxNUt3i2Hm8bq0G
 ze2N50l006R3gARtJaeNkNE0TC1ktLBQgVNLr7tmiL5Va1Su0xWaUhDLQFcpCF693eDf
 zkTrWOyhFGOAY+Fyk/jjGrtSrX+ad9fRKQ4LTq0qL9Ykn8F/fCVO+ieJ1paYTxk+jGjd
 s3dg==
X-Gm-Message-State: AOJu0YzqD3VHeBjBwuTfBwbAlhW++GNUxNBF9vWAymV25PSN+b5J2OQe
 Q96ObFVE1tO1q9dyoR4320uh+cK42h+GuL544wCb075qx7YqcJMzg1aW3wB+s5+ghtGiPzLwOp4
 k17hK
X-Gm-Gg: AfdE7ckHxYOt9K3YwFWaT4kELqwrkzjB6uwvDe5UMmbBsT21NWES6SkZG+lFwLsO3SG
 w3whFHBGqLDbmHi38m7hxgf6/v9k9MCOclIs8lVlJEz3Z69C5H2muJSsv7ojPjkMG6iVSLCOjvZ
 Gh08Env3A4PWbHSMsyvr9NsJhW05VfEvJVJRxgWuNIJmQFiNgrhWYcmAiy/mXMyflA1ThTT0b35
 mCGMnacaJcp+ABSDTcSWlSDHyjI7I8sh98en02iwPFV60KzamidmKwW6UmRwQ1dYxAbnwxcVoL1
 sCRXcNl9IFjIJrrODYENA5M1LLGjjYGPkfCMBZNf027UP+ET9xELXwI1Xa2YGPA5Yizk23/xm31
 whDRcB6l1yDB6C58HSiytn2rcV1pCWWr1C7/VyJ5A6IUd8bxeUuFMwKoSzGWPGn6ZxKrJIYvL3d
 zv7rV97iUrafRHSxyBAFui940PZ78e5xmGXbH31HR9G78EDTuTDzpl/v8o3umW
X-Received: by 2002:a17:903:1983:b0:2c1:e9f8:758d with SMTP id
 d9443c01a7336-2c718fc39c5mr7552795ad.22.1781812529734; 
 Thu, 18 Jun 2026 12:55:29 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/13] linux-user: Use PGBRange in load_elf_image
Date: Thu, 18 Jun 2026 12:55:08 -0700
Message-ID: <20260618195520.589907-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aa4986a3d8..b32abd569f 100644
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


