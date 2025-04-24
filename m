Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2726C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lFu-0003TF-GB; Wed, 23 Apr 2025 21:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFQ-0002es-Dz
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFL-00078y-TR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso525973b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457562; x=1746062362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+AhSAw0yISu1j2mAPNZj8JIUUEWW3orS97qT0s5kocY=;
 b=EWdxRNf9KM20uTq8gXydcsWsLIWdkVy+fBz9K6op+Q/Sjx4SzziJcZXXxE/udVS11d
 MyugfSPzpT4a7ggMXif03jzgAc/fo959Siq0nmVY1/DP2LQ6S5nqSN1LlEiW7zDK2vLf
 os+7YgVjfMPEOEQOU4fJso1WQ74l7YhhzASOO1L2kX8vP4tuDk/YJUSgGR6BqRKdl3lj
 bHNYRS51ntxiYqZnZcs3KPpX1zXrVIb6ytIYvUdNO6GxdD542oer5Ug9MpbDSTSkH6qy
 LOqMBLvmInytgZ97nSse+L5GtGw7pQnZuZrTM715VGhQJg/RsWyig3/n+B6T1MtOBq9+
 zaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457562; x=1746062362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AhSAw0yISu1j2mAPNZj8JIUUEWW3orS97qT0s5kocY=;
 b=BSSnzvryJPUXNtnoGWh7UP/CHzGluoemEUJWBXeb+4f6FOh20dcMAZTdKasw3AnXTf
 K3L+hO0P5AoaJ3rkVLAFTjjmRadlCjovMfwRus2RwcFDCc7hXgY+6bENHBn0AuL0i9mR
 V+V3rZMVuoWNMyxDKHEXg2x5yvOxK3pz2ELvqJvjo9bmN4ceima2pANNR6wW9yXMTU9X
 kdMI0l0EABQtMtq4exxYqR1mpWbi8pe/xocc4ikNzceyju3X3WkbnLha2oYyVXwVIW7b
 M21FODA9RX8XajklYepNL9rOsZ/x/s9kXw3tPRvLP1puFt+x3sXXewnuPDfqiaCtmtka
 Mg5A==
X-Gm-Message-State: AOJu0YxN54O6tFxLMzIqgQaw9wC/fbHw2ydcf84nAJOnc1LA4yItIFpf
 r1TgVzQYkcshtgjMknGI9/lpE+j3nhxn+to23xkbrnXdyvHgj1jLuQXN/+qyw3h4SpkMUVvzh9L
 u
X-Gm-Gg: ASbGnctW/6NrBOQANq+EfCuFG57Y/p3wxOgYK+rIfSU5CchYFJrGHdwFpmqcjKAk+ga
 ALzJxy/TM0zB/UD+OlawrYjZAjn1DiQt5nrmejiLKKZnudqMIwxSPABmTqr7Ag4s/nFY9e8buig
 mCzolC/TZuMt2aFzWb1nVzPaJGucomtVMNHDQXn8NvCGNE+PfdSl4RMTXjCu3E+9IRxThUtCFXW
 4jA4tQcuxTFKOmSdjPOujN+Klpyvml7JFagm97iBmbMzFNeOqNguuTqxpt0JyaLC8BK6AJ9Km9F
 tPkRNiQqugPuOa9KarNyTSiqM40SGnkpeuXHB258x3UKKS1+/JRwlIIFilYpGQbhElo0po4Ysoa
 KVaR+Xv57dA==
X-Google-Smtp-Source: AGHT+IG0+XOYeLml61p6d8wfvVV3mUhUPGrV89/ZpYefGfRfmkRJgQ7573RcKo/Z/lZaKpVFcwnwBQ==
X-Received: by 2002:a05:6a00:e1b:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-73e268ee7b6mr704357b3a.11.1745457562190; 
 Wed, 23 Apr 2025 18:19:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/15] accel/tcg: Merge tb_invalidate_phys_range{__locked}
Date: Wed, 23 Apr 2025 18:19:07 -0700
Message-ID: <20250424011918.599958-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Merge tb_invalidate_phys_page_fast__locked into its
only caller, tb_invalidate_phys_range_fast.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index e8a465c9ac..67a2570b4c 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1203,38 +1203,24 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
     page_collection_unlock(pages);
 }
 
-/*
- * Call with all @pages in the range [@start, @start + len[ locked.
- */
-static void tb_invalidate_phys_page_fast__locked(struct page_collection *pages,
-                                                 tb_page_addr_t start,
-                                                 unsigned len, uintptr_t ra)
-{
-    PageDesc *p;
-
-    p = page_find(start >> TARGET_PAGE_BITS);
-    if (!p) {
-        return;
-    }
-
-    assert_page_locked(p);
-    tb_invalidate_phys_page_range__locked(NULL, pages, p, start, start + len - 1, ra);
-}
-
 /*
  * len must be <= 8 and start must be a multiple of len.
  * Called via softmmu_template.h when code areas are written to with
  * iothread mutex not held.
  */
-void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
-                                   unsigned size,
-                                   uintptr_t retaddr)
+void tb_invalidate_phys_range_fast(ram_addr_t start,
+                                   unsigned len, uintptr_t ra)
 {
-    struct page_collection *pages;
+    PageDesc *p = page_find(start >> TARGET_PAGE_BITS);
 
-    pages = page_collection_lock(ram_addr, ram_addr + size - 1);
-    tb_invalidate_phys_page_fast__locked(pages, ram_addr, size, retaddr);
-    page_collection_unlock(pages);
+    if (p) {
+        ram_addr_t last = start + len - 1;
+        struct page_collection *pages = page_collection_lock(start, last);
+
+        tb_invalidate_phys_page_range__locked(NULL, pages, p,
+                                              start, last, ra);
+        page_collection_unlock(pages);
+    }
 }
 
 #endif /* CONFIG_USER_ONLY */
-- 
2.43.0


