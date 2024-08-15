Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764EC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebn3-0003Tw-MO; Thu, 15 Aug 2024 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmz-0003EB-Md
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:21 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmx-0000Cm-JR
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:21 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8385f38fcdso62758566b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733358; x=1724338158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/2O2QWI/Uf5GFig2yGm0H8WH7A5Eq7y7uzfXzjAjGQ=;
 b=VHI+ezQy9nJYvXNJ9KJNSjLGmRnEBI80BE+9s1djV91H1MWGtTQYuhjSHD9pQNeiUs
 TNsXQd9pQwKEfD4Dz+jOmVb2FlFEIfyLZKR7pdecxCKOGdY/YaHlgnRSQnOclntV1pGT
 JbO/UFTNLoeyhYfdTn105lt8Ls2oZhkfMC8vOiOs9GMtBfnNeeWe9G4r+vFh/oUZ3k2o
 w47ymYNjhCgPskd4eLk3IFhYg2FfvCCOOJEqijopCIjaynetAkhCbIbfLgGm6wG1yByD
 XkdouJW/is6JF6W5VZsCeDPbMS10zUXxUvVNRE9pKAqi1+kg5w8p0bbQA/z+yWfyJ1E+
 PybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733358; x=1724338158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/2O2QWI/Uf5GFig2yGm0H8WH7A5Eq7y7uzfXzjAjGQ=;
 b=M25g6LnvPDicAbCn4NV3/T1wPl8BKKP0jHksnhToab1q6lv+sVl98vx2jYF1u4MUC0
 ZYulSYvaC3+E6Ee/j0GMo2+uzFGsT5RWi7rfvhR9f74fejUbfremG6m6Hrknzawpy5y6
 QPp6boqalZA3ZNbm3Y/zTaQdYSYJyxenMp6wVp0t04guhOeE0xmqzqrWk6LD+7ORaak0
 waHog0hK/VvqEEYfBiiZ7SpcpCQKKFD+s5ToJNi5xsUUIdz9ewJ6NDARPwcTQzfhpff1
 UZJQCLmEelXl0RCkv1BrNrUKNDNZ5vKYvNj711khWuH79dHCFxDX7OIibbSvGC61jWCZ
 D48w==
X-Gm-Message-State: AOJu0YxRYzwMgf1ItVHZ1yU8DlLr+5yi3+ryG8INsGCRl82lfM1pxe/I
 XdMKuXkywXFGgpnPdtACEfMy6U2kQ1tlORKcOvhfaQICbhyxtUMhv9pX3b0okvc=
X-Google-Smtp-Source: AGHT+IHXTM05zKcMC3ai7A5C/iBWIIgK3CctC56tk/IKn4JZbRNe8vqdBLyxeG6i9ObU80ciNjkSQg==
X-Received: by 2002:a17:906:cad9:b0:a7d:a29e:5c33 with SMTP id
 a640c23a62f3a-a8366c36624mr400869666b.28.1723733357602; 
 Thu, 15 Aug 2024 07:49:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6c07sm112618866b.43.2024.08.15.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59A465F95A;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 07/21] target/i386: allow access_ptr to force slow path on
 failed probe
Date: Thu, 15 Aug 2024 15:48:57 +0100
Message-Id: <20240815144911.1931487-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

When we are using TCG plugin memory callbacks probe_access_internal
will return TLB_MMIO to force the slow path for memory access. This
results in probe_access returning NULL but the x86 access_ptr function
happily accepts an empty haddr resulting in segfault hilarity.

Check for an empty haddr to prevent the segfault and enable plugins to
track all the memory operations for the x86 save/restore helpers. As
we also want to run the slow path when instrumenting *-user we should
also not have the short cutting test_ptr macro.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
Reviewed-by: Alexandre Iooss <erdnaxe@crans.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-8-alex.bennee@linaro.org>

diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index 56a1181ea5..e68b73a24b 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -58,6 +58,11 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
 
     assert(addr >= ac->vaddr);
 
+    /* No haddr means probe_access wants to force slow path */
+    if (!ac->haddr1) {
+        return NULL;
+    }
+
 #ifdef CONFIG_USER_ONLY
     assert(offset <= ac->size1 - len);
     return ac->haddr1 + offset;
@@ -78,17 +83,11 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
 #endif
 }
 
-#ifdef CONFIG_USER_ONLY
-# define test_ptr(p)  true
-#else
-# define test_ptr(p)  likely(p)
-#endif
-
 uint8_t access_ldb(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint8_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return ldub_p(p);
     }
     return cpu_ldub_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -98,7 +97,7 @@ uint16_t access_ldw(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint16_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return lduw_le_p(p);
     }
     return cpu_lduw_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -108,7 +107,7 @@ uint32_t access_ldl(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint32_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return ldl_le_p(p);
     }
     return cpu_ldl_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -118,7 +117,7 @@ uint64_t access_ldq(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint64_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return ldq_le_p(p);
     }
     return cpu_ldq_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -128,7 +127,7 @@ void access_stb(X86Access *ac, vaddr addr, uint8_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint8_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stb_p(p, val);
     } else {
         cpu_stb_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
@@ -139,7 +138,7 @@ void access_stw(X86Access *ac, vaddr addr, uint16_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint16_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stw_le_p(p, val);
     } else {
         cpu_stw_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
@@ -150,7 +149,7 @@ void access_stl(X86Access *ac, vaddr addr, uint32_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint32_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stl_le_p(p, val);
     } else {
         cpu_stl_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
@@ -161,7 +160,7 @@ void access_stq(X86Access *ac, vaddr addr, uint64_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint64_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stq_le_p(p, val);
     } else {
         cpu_stq_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
-- 
2.39.2


