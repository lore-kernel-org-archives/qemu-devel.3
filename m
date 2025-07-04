Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696FFC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhT2-0000YW-Pd; Fri, 04 Jul 2025 10:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM7-0004ev-Uf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:41 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM2-00088g-LW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:35 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40ba3d91c35so736677b6e.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639129; x=1752243929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpo5YL86phg7e3gQ3lunP/NsQqxYcAUD6doV1Hx7zww=;
 b=Q4VoHLXcb9iKleJQQGr0lUmNLuVkg7uDEi6ynoyRR3FdoPfJdJVR0/2Vq36t49ZaLL
 3yWeqthdnBQ6vIs7IzKNrwLYDlsNEWUFCIXuz1gARsJ2KLryrGsyMiJO4RXwtoD6Rzes
 wV6FJSjJJvyBEzCXZTNwYMGU5mtTEXbphxkbcuH9wU39xyqWPxonOBiQ4pcjALKlrNYA
 mylgoijQzi7CwyvfohChXrS94j2lkMjWfiBXkCvWK2NzFmssNdMdBTKcZyOwpjgRZvEl
 bZVCQmH4NrDQq5xjBAfdKJOJM6bNdFr+o4JVIvBCTYvCRNAJ+rhHwOypU32zSD59BlyN
 UpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639129; x=1752243929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpo5YL86phg7e3gQ3lunP/NsQqxYcAUD6doV1Hx7zww=;
 b=mVpSqhYsrz2cBssH7SPENFqmvNVIc8vcvVOzVWjYO0f63r1Mui6SXw+BzvEWHIlkRW
 nZE83ppZqEmVKqksk2vUC1kx+PHxucS+YuHS5F6eI+LIaLT679ChDFPBA4S6JUqVV75k
 SXjM1pTqMWV6UT2U7PpmKmDSGR4a7+2GquwaTQNeLsCSPHNUKg5mAmTjtoLIg26Tiwoq
 6XHKYsPQBbcYOREkjRKjLdfe5Ux6nmq22v2DNDPM2u8cKAdT6qSdCiaV2Cs3s7keS5yE
 96P8keVypqCZL/GLX2hpamoUhVFXGs+TvFHf5cQ17obGP5uB1DrBlrLfrzi12nE8+01p
 YD1A==
X-Gm-Message-State: AOJu0YymyDi+jzIUFK/cUX22mEvBcXkpMvwxhnSkeF2wiYbOUVmJED6A
 lixUHu5H74tJtlvW6hqwC2FkWUxFupbBjLLUiJmNRFkplM3KtCRzWMpb/lHAZvC/tSuit/KLE8Z
 0ec7wz1Q=
X-Gm-Gg: ASbGnctSnszxwvmPmjW35NtpkNHZ2PDiTyCtxM2wKkX0Vft1iAvV3H/jFua4JRf8uYa
 DYti0WJPzZ418Vum6m5/b8By75huWOzkU33+nZzZYKMeZUIROb+q68I8MnGw1w5FDfgqerXmGWc
 SoJmGATao0HrL+quG0dw2lXL2dnGevE6HVFk60YG5pSwXLVBFLFb6XTU9LIRH7gFX+75aqvqjlQ
 VffwCL8o0i3pp2s7x0DshKbXAqelpaHiEiVsFZQ05IVQVEYLc85LytiiMRx7AAMvbABS1COtGhj
 +hGaEjWhXOkqBNpLEHf2a6LXpMR23gWOkWLWf849bXNprda1KodcE8adPwQs42/OdZxLfH4aH3u
 M6TxqXOEpmKTK23STeBxgNeCDAMjnbhHEpkUIasGs/IM28oTu9P2Rt9z2vIw=
X-Google-Smtp-Source: AGHT+IEi3n5LPTz6mYFsuRDWdmWrgvZdAllAbpwOw8EtstWIhsx/xgYyz2/8Ut+nj5KlfthHPw5Jlw==
X-Received: by 2002:a05:6808:211f:b0:40c:5b58:c9f9 with SMTP id
 5614622812f47-40d073ccd23mr1493081b6e.22.1751639129235; 
 Fri, 04 Jul 2025 07:25:29 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 071/108] target/arm: Fold predtest_ones into
 helper_sve_brkns
Date: Fri,  4 Jul 2025 08:20:34 -0600
Message-ID: <20250704142112.1018902-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Merge predtest_ones into its only caller.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5b5871ba13..492e42acc8 100644
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


