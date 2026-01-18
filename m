Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10392C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxT-0000CY-R0; Sun, 18 Jan 2026 17:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxK-0008Ll-9F
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxI-0001c0-Mh
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:09 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so38116895ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774147; x=1769378947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY8SF4Lgdoetp90UFxDHJbg0kRe28ldzal692R5R0k0=;
 b=yWFe7ee04KaYK9KFPhxBONIehtf1Lb2M/6PV+Ej1R0E79+sstTy5pD7qdyCF3GlAYF
 SJRvJCr2taTdZkih6vtz38guyFrpvOnNd0w2Ce05VLGMV2X4wEyfuPGXJDckew/TQUCQ
 HB9ApnjvWb2D1nAdhEU/XeMvObbjDBl+TErUtF2zNutnGB0SUeuIc5b2KHexYjWe5vAw
 bOpZXW/UfBaOKEjKT1S8BlgnUZEXzTfqc23SGke2TYThsxUIlMzcxGU5TOFRk1whs3KY
 xon8E7+ayp/69Mvr/sS7GQ9GWUDJ8HVutqZQYOnhoDxEFzuZ2eNhleO5EkF+Ji/uJetg
 ceSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774147; x=1769378947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mY8SF4Lgdoetp90UFxDHJbg0kRe28ldzal692R5R0k0=;
 b=PLXxLimNIuWMtAoFQxK3mS7xDiX/kUsyPp59U/VoejfKoNVrvIT5XnzkXrLJg24tqi
 qIZVjrIpiPvXlwVSWROrnABPrcqaZCxuXMLXPbnrIAbRpWnOsZNIJigbrKAFREp2mb/p
 K4o27r5acApiekM40TqXCto87ZQy3oUCt3iO+3I8oLUG/lAqqVmEyI9Os42G30B/BWJB
 xyjBTMCWxALYSAj4T3//KZGPrVfTH6Z10MWAyzmHq3r+Tds+mEvAwiT9EvibgX4nPoQU
 wDfqtvGq7GbZQmjQ3nqg0KjjX2LRGuDndQxeu6ur7ekBmBN74kkfA3PlMRrRVN+qY1fl
 8ZKA==
X-Gm-Message-State: AOJu0YyJJakUHAXZAOpJ+GzCtSXJPe1RN3gWVnQJFnQO0Z946yjBMvzx
 m/i59TewFdvbgZtqoRoHaWwEwodEXQM9qo9xAvzLqlpOn0YpPbRIIYLMcHcqz1uXqW2Ux+h3KV9
 WBPEYCwA/DA==
X-Gm-Gg: AY/fxX6JI7rwm/jNN4eyFGaCLjxoLqunZtsK81SbwTatLyYFOGQit224WMDLuQqPyBt
 xmK5xXgXQKW6iLKu0BPYSecnX75xerHDeJESRgQdYMT8TO2R4hfyDGAoHQlpeYTWTNJ7WAbW145
 OQ7rGZ2mqGo45ScwZkmlZnYhoKblRCXS1EZ/n081rs+LRdKkV/H6jcYUxGFrSa/K5HiIPWT9rXz
 +9+DOB/pv74beqmacKDsWZ8WxFdDRDYMwdR1Ys8uK5szN5Q59cd1Ewpj/cKK6Xi4dUD5KW0iRl5
 mqjfVcbQJk06WuDHKadv/gyv5ApEwhfRH8mArEVqxsW19VbAS1eheIr520C1yctzHYhmMYgV15+
 l1l4K0Ou/KCnKAg99JbTzyJR37AdimOvXkEe9uSAAEnDCc/qFTxCvOEHFDV8oQtboyPL/w4XqZn
 rmRH0NO/B8icANEbKEFQ==
X-Received: by 2002:a17:902:e84a:b0:2a3:bf5f:926c with SMTP id
 d9443c01a7336-2a7175cbc87mr102103885ad.39.1768774147265; 
 Sun, 18 Jan 2026 14:09:07 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 44/54] target/arm: Drop CONFIG_ATOMIC64 tests
Date: Mon, 19 Jan 2026 09:04:04 +1100
Message-ID: <20260118220414.8177-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a986dc66f6..8b8dc09e72 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -757,20 +757,12 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
 
     if (likely(host)) {
         /* Page tables are in RAM, and we have the host address. */
-#ifdef CONFIG_ATOMIC64
-        data = qatomic_read__nocheck((uint64_t *)host);
+        data = qatomic_read((uint64_t *)host);
         if (ptw->out_be) {
             data = be64_to_cpu(data);
         } else {
             data = le64_to_cpu(data);
         }
-#else
-        if (ptw->out_be) {
-            data = ldq_be_p(host);
-        } else {
-            data = ldq_le_p(host);
-        }
-#endif
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
@@ -798,7 +790,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
+#ifdef CONFIG_TCG
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -903,17 +895,17 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     if (ptw->out_be) {
         old_val = cpu_to_be64(old_val);
         new_val = cpu_to_be64(new_val);
-        cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
+        cur_val = qatomic_cmpxchg((uint64_t *)host, old_val, new_val);
         cur_val = be64_to_cpu(cur_val);
     } else {
         old_val = cpu_to_le64(old_val);
         new_val = cpu_to_le64(new_val);
-        cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
+        cur_val = qatomic_cmpxchg((uint64_t *)host, old_val, new_val);
         cur_val = le64_to_cpu(cur_val);
     }
     return cur_val;
 #else
-    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
+    /* Non-TCG guests only use debug-mode. */
     g_assert_not_reached();
 #endif
 }
-- 
2.43.0


