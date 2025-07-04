Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9009BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFN-0004G1-OA; Fri, 04 Jul 2025 12:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF3-0002CV-B9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF1-0006pV-HK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so6167755e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646382; x=1752251182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EHw/YvlXnGE5Lhnz23NcN4KbjhsX92Q6fIh7SOhpDm8=;
 b=jL8HZj1Zxo5XlXpFsFKynM5h4aUpwNZhZnT/+nSs4bNPNg1LJ22IfErODIqdxUYxAT
 nnTmJ6qcJ6raa+Eh2AuO85o+0TgQVCZL31ES2f2+Z4D8IyN9+HD61Z4k+znArKoyW7DY
 Ql8j/ndAMCr+GN4HbPgOl788zk5jBDltzEMuoclBUylTQkDGdlQWemjDpXYcaIhQowvV
 RGVie5fvEi54O+BakCbIkmP3a1vwnVhytWHIdMrqDpZSe4jk5GMojiSPwA5McuFnnjZB
 RntKZIUZxW9CyC8rYIox4UiSCKJJ2YOrC5jTfy3xSkB08icuY7w8BjjieB8SMvueH53h
 a7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646382; x=1752251182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHw/YvlXnGE5Lhnz23NcN4KbjhsX92Q6fIh7SOhpDm8=;
 b=GY7s1Bq5nvIzYPOOnS8oZkm0CZ4excS/DRD9jnkvHQ3DKCoPaJ9C0Tj8FzYVtWwjpc
 v5JUoN7vAk6tzyvXR/3IncSdp+IFLmuaHWTjIhPjxeNBwcMvFyIOwEhQ8Cr+vYp102tv
 PY83ByULtLUkXVTUXNlaGg7n8pvVklNH3M0OZzj8/KmywzEyco1n7wWTBxAv2kZovd3X
 pS+cWcctSoo4jpVsafw0L0P7bzBlZkW4bIiH+pNPbpSH7kMNY+tZkq5rp3GBKwTxnI4n
 kwTrBVigro1dePrGvuANmUKEqeVi9fzVDFG7LNleJcNVo0bVf7A3WfEqwbF1mq+57kw1
 +7MA==
X-Gm-Message-State: AOJu0YwWdWsk8GVvG+16H9USTWs7eyCTL3dtajhVTbZu1CDL6rdXzp6V
 A52X3C2r0etGCUTBL5ob5MlPw/JHi0WmUOxy8OlDxoK9mvP/EZDpnVfiRksL0TzAhV2S9cllynB
 EYchA
X-Gm-Gg: ASbGncv1Wj5eKEj7QLtQapPIJwINeOEWuu3NuGHrJdaTUBf1E1cO9KKOmFt+35ihTzj
 lE0B7ruNYN+9ALg4nPqzz3eW8vh37l9tBTkT9YR9lhaqf7O1NU89HFF+T2gzUeV5FWz5g5DGOSF
 6FdXktYL2TsHWPMvbhO3XHHYrDPAapZlEPqM8qkQG2yp+rK0KXOF9MHw634UkJND+aksM+Gs645
 msMYsOFlzmSGwkammU98k/VzUaDsss8WWfEM/+YLDaEBh78m5/z2ruAV8OBj0GLZT9uJyPJHpDL
 wTfpZyvFSzLjtB8bU9BrVBslLxs2RdnLgR4SbgVIh18SY4eqg8n8UlTyQIhmP52AGn7s
X-Google-Smtp-Source: AGHT+IGBzSrlkXCc8T9cZeZU83p6iQNoJeq3IrARSc4Yk1GE8Kx3j2vbYG3FNDu+PLds53IeuOc47A==
X-Received: by 2002:a05:6000:1a8b:b0:3b4:cb0:b6e8 with SMTP id
 ffacd0b85a97d-3b4964e56d5mr2742724f8f.42.1751646382154; 
 Fri, 04 Jul 2025 09:26:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 083/119] target/arm: Fold predtest_ones into helper_sve_brkns
Date: Fri,  4 Jul 2025 17:24:23 +0100
Message-ID: <20250704162501.249138-84-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Merge predtest_ones into its only caller.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-72-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5b5871ba138..492e42acc84 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4061,31 +4061,25 @@ void HELPER(sve_brkn)(void *vd, void *vn, void *vg, uint32_t pred_desc)
     }
 }
 
-/* As if PredTest(Ones(PL), D, esz).  */
-static uint32_t predtest_ones(ARMPredicateReg *d, intptr_t oprsz,
-                              uint64_t esz_mask)
-{
-    uint32_t flags = PREDTEST_INIT;
-    intptr_t i;
-
-    for (i = 0; i < oprsz / 8; i++) {
-        flags = iter_predtest_fwd(d->p[i], esz_mask, flags);
-    }
-    if (oprsz & 7) {
-        uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
-        flags = iter_predtest_fwd(d->p[i], esz_mask & mask, flags);
-    }
-    return flags;
-}
-
 uint32_t HELPER(sve_brkns)(void *vd, void *vn, void *vg, uint32_t pred_desc)
 {
     intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
     if (last_active_pred(vn, vg, oprsz)) {
-        return predtest_ones(vd, oprsz, -1);
-    } else {
-        return do_zero(vd, oprsz);
+        ARMPredicateReg *d = vd;
+        uint32_t flags = PREDTEST_INIT;
+        intptr_t i;
+
+        /* As if PredTest(Ones(PL), D, MO_8).  */
+        for (i = 0; i < oprsz / 8; i++) {
+            flags = iter_predtest_fwd(d->p[i], -1, flags);
+        }
+        if (oprsz & 7) {
+            uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
+            flags = iter_predtest_fwd(d->p[i], mask, flags);
+        }
+        return flags;
     }
+    return do_zero(vd, oprsz);
 }
 
 uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
-- 
2.43.0


