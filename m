Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43E3C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcf-0005au-Id; Wed, 30 Apr 2025 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcR-0005AN-Aj
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcN-0001vO-I1
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2295d78b45cso1186975ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031746; x=1746636546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OA/Cegqwe9p0yD6ikSN7G53T07JOQms4URcLJNl+RA=;
 b=sbq1nLre1TDYiSDkDFl+7gFSk4M0gb+DuZj/mmne5Ah5wzor26ZZFb7dL8fRY0iMb1
 19GLjAhX/8ViQPvxF6lklfnx//MNHOUgt2XFxkMXGTodadLn89j1RVPGRvb99BbaHEfE
 HdScgt+JRZdG5Ybd9Cf5iv/9qEMvzQSxl6OA7/yrNFFLdsnZ5w2ruVQbVkWQIRTvXxn3
 OWpYjWM9KyYILfdSeWKrMC+38iH4cRlh7A7+cwaVplptz3NQRTCWZRsZqnOPmuEG9FNf
 FcfM5sX9dpciS7ITFobrCiSUp5OSGNt2DGo36P7EzN7rd1BjgiXOS/MGuq2rwKWNjQzB
 mW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031746; x=1746636546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OA/Cegqwe9p0yD6ikSN7G53T07JOQms4URcLJNl+RA=;
 b=iiaL+BMHWhYKbi5kMaRjhCvwH5q4g07dQAWtrg3tTzKt7+CxgIyPzJbgpPm62mMQTA
 eDoP2CAj754HVeMa9+3STkLH9yPD6hOz/gvW9FjOhudICLiKah9OCWtQYiJc+qKRFLLP
 ZTSyQsl+7MUkyvufBURQvSThy+HE+Ad5OBvitaNOBCKnBVLChL4kOZYz50Y/mqgSqIJq
 Y5x23fmMT6fW8Jf4Wv4fAqNS/j4UHEKqYVthkvmWjqsYYTkNdOgNJB2v5kEngcoCLKrX
 nPdkvzEI5oBQyYFxUZXg+TT8Pzi9arJXAHXr0BBOPTdgFuhqkX3CbaqQsK3iz6PgrTlT
 pk1Q==
X-Gm-Message-State: AOJu0YxlVQ9Se+dfn6HZ2Mxrandw9RPMCZO/htjS9A6eDlDzNzHJ9Bz3
 2VoPFdN8yoqb35GSSJOHoMrguozkSpl1IwG22XcDERL992pPEKYM76XGcegNXzQpPoQAffNmQ3e
 0
X-Gm-Gg: ASbGncuC8pazUMFkdRKRFjcF1DcRTwbklSPpI9fPmcvhAFyQwXfwEVfagE+w/8ulaUp
 3Dv+nNPXNX7Brolh2SfOkIoCU9bFVoyy/+y7VW8+Bmdkj2VY3ourR4wD400JHgLL2BTDNQgNyBK
 saYko0KmaXnQY1yV5vZpjps487qFlPUd2ZrXlXZ2kVOL8jSzhDF+KNSxnKoDXZ1G4f8FaF73dP2
 VvvdTfrJy+UIu7etJZo5VPoB628VymMEN1DBZ+PAbr1Vuq6HBCsIsKh6WjFJIEISiMXuM5ZX//A
 WqegrPft2FU+xeas5n6s6vNH3c0OpMTgEzuAQxbeJiTP5rZ7pId1HnPQwOjgukrLFwBPYlCpW/A
 =
X-Google-Smtp-Source: AGHT+IGPbSP6tUPSBCFcNoPnOm4tFFoeFJYYU4pvDCPIXfE+V7WGsEUVydKEPQXMkdywJuDAeuiCmA==
X-Received: by 2002:a17:902:e88d:b0:223:f928:4553 with SMTP id
 d9443c01a7336-22df5836c5emr52767025ad.44.1746031746084; 
 Wed, 30 Apr 2025 09:49:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 13/16] accel/tcg: Use TCGTBCPUState in struct tb_desc
Date: Wed, 30 Apr 2025 09:48:51 -0700
Message-ID: <20250430164854.2233995-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8e6899950e..4ad84c2db8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -150,12 +150,9 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 #endif /* CONFIG USER ONLY */
 
 struct tb_desc {
-    vaddr pc;
-    uint64_t cs_base;
+    TCGTBCPUState s;
     CPUArchState *env;
     tb_page_addr_t page_addr0;
-    uint32_t flags;
-    uint32_t cflags;
 };
 
 static bool tb_lookup_cmp(const void *p, const void *d)
@@ -163,11 +160,11 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     const TranslationBlock *tb = p;
     const struct tb_desc *desc = d;
 
-    if ((tb_cflags(tb) & CF_PCREL || tb->pc == desc->pc) &&
+    if ((tb_cflags(tb) & CF_PCREL || tb->pc == desc->s.pc) &&
         tb_page_addr0(tb) == desc->page_addr0 &&
-        tb->cs_base == desc->cs_base &&
-        tb->flags == desc->flags &&
-        tb_cflags(tb) == desc->cflags) {
+        tb->cs_base == desc->s.cs_base &&
+        tb->flags == desc->s.flags &&
+        tb_cflags(tb) == desc->s.cflags) {
         /* check next page if needed */
         tb_page_addr_t tb_phys_page1 = tb_page_addr1(tb);
         if (tb_phys_page1 == -1) {
@@ -185,7 +182,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
              * is different for the new TB.  Therefore any exception raised
              * here by the faulting lookup is not premature.
              */
-            virt_page1 = TARGET_PAGE_ALIGN(desc->pc);
+            virt_page1 = TARGET_PAGE_ALIGN(desc->s.pc);
             phys_page1 = get_page_addr_code(desc->env, virt_page1);
             if (tb_phys_page1 == phys_page1) {
                 return true;
@@ -201,11 +198,8 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, TCGTBCPUState s)
     struct tb_desc desc;
     uint32_t h;
 
+    desc.s = s;
     desc.env = cpu_env(cpu);
-    desc.cs_base = s.cs_base;
-    desc.flags = s.flags;
-    desc.cflags = s.cflags;
-    desc.pc = s.pc;
     phys_pc = get_page_addr_code(desc.env, s.pc);
     if (phys_pc == -1) {
         return NULL;
-- 
2.43.0


