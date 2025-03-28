Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE27C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 17:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyDvd-0007JW-10; Fri, 28 Mar 2025 13:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDvb-0007Iy-7G
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:35 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDvZ-0003KN-54
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:34 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fbc00143d6so1468360b6e.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743184531; x=1743789331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYwdx/b2OGQgAVCciSrxPH8SiijoimtZp2y9rlzhyo8=;
 b=vmQ4eMKtEM4u75dDbuFzuOJrBV/v2cjp46m04HoiMiTiaAMeXynFX/pBU5+hlJqyqp
 HdvyvTkny0kVCFwiMrtxPC5SrZ7Rj97LnT17EGsu8pj4dqIrReD2pj42BaNyZrxmpndO
 a2Zh3emuG9ODuaBE00o93cJI3pzP+2PFWzMtVo/mvgKqmg/0hmsdvofEuGDXqBN4PLLp
 aVkVdjZwRBhykEuNsvCNr8nRNpD6LsVSxbgpfG5/YlGBDhVtGoCPR/g058VVf/RDC+jz
 +9G1f5gMVDpoS3Fco3mkgJgrGmL+HrilWfybO3b9p0LHOVRDam3BbNN54/O4aSjeoLdQ
 2Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743184532; x=1743789332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYwdx/b2OGQgAVCciSrxPH8SiijoimtZp2y9rlzhyo8=;
 b=U5weJQFZPuzr3ehavC3z7tbXMI31NRLfErq3b9OFQZT0Pv/o6BqHY8qmCzpf/sz6Ks
 TVKAvvV/5uKkhBuu9wbiHZnd2XsVPMes+Jmjf8IKVc9rlWjuC6oaAxYD0zSaYCTHlz+9
 Iru/OWisB1tpmFoE7FIGvNL4xJS2hnGCvhtpPdo/Lw74V9eVOGojFBXdK4XYGVRZLmeG
 2DE80MyW9mg3DXmYg8Hl5a04plKs8ZfWLNQcI2GBlOm9v/uYhTNkinLkFWQgi7ndhmPE
 vpIV8QGeMXOFkYm/lu+L1OXCCRxrSp7uNI5+3QWXjfpRGHuYopEnM6J2InEpQeR0DF2R
 Qgrw==
X-Gm-Message-State: AOJu0Yy/ygAhc/XoMZYmRWYPkApnlzQKiF/e+CVHz0l3o0ANWouDuenz
 fspuM6WRfB9EXK56hrix5vLDD/AtzAibO93yXRIrGfC6yOnTKBjcPBkV7eBCgBeKWxmiJqIYoBu
 R
X-Gm-Gg: ASbGncujsrEGNLF4zFeFzc2KtbpmFj23yRye+h6KX4cN8qAv4EzRPSu2IEyZjYeYTIz
 rFAGwmWhPY6GWiuNbCEC861joua48mz8+SD+h/NrbhVBj9GRa7GbnWxLT/SSQMdUQQPkLCsLtbC
 kBmRdXZi0dxWOqmiab/B7OqS5XEtovMJZxuVZ0eaGz13Mp6kDReg4BRP1qTOloMH7eK5FcggNYC
 qHCiXdf65KJrqkV8R3UB+ZXWReJKbLkX1V4FsCIYqOuWrRz7YEYWxPnyL8T95jVfXTRWQP3NwKm
 9uzxwHKR5+SU6KSjPm0rVba2oqwCK0j1CskNLlevL9OI571JCwuQ0N9mrP5/cDukp1a8yEBnITa
 yFjn+VrGDgGs=
X-Google-Smtp-Source: AGHT+IHIyzPjBjUwJRpxzQGrxpgILqK9jhpg2X02WJDJ+WC3j0jT1S8qdxpV4VHn64Ks+z9Ilh/bDw==
X-Received: by 2002:a05:6808:1408:b0:3fb:2e8f:4dd8 with SMTP id
 5614622812f47-3ff0f54f247mr106878b6e.15.1743184531585; 
 Fri, 28 Mar 2025 10:55:31 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff0529511esm410338b6e.46.2025.03.28.10.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 10:55:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
Subject: [PATCH 2/3] target/mips: Require even maskbits in update_pagemask
Date: Fri, 28 Mar 2025 12:55:25 -0500
Message-ID: <20250328175526.368121-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328175526.368121-1-richard.henderson@linaro.org>
References: <20250328175526.368121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

The number of bits set in PageMask must be even.

Fixes: d40b55bc1b86 ("target/mips: Fix PageMask with variable page size")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/system/cp0_helper.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 8c2114c58a..5db8166d45 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -866,24 +866,17 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 {
-    uint32_t mask;
-    int maskbits;
-
     /* Don't care MASKX as we don't support 1KB page */
-    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
-    maskbits = cto32(mask);
+    uint32_t mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero */
-    if ((mask >> maskbits) != 0) {
-        goto invalid;
+    /* Ensure no more set bit after first zero, and maskbits even. */
+    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+        env->CP0_PageMask = mask << CP0PM_MASK;
+    } else {
+        /* When invalid, set to default target page size. */
+        env->CP0_PageMask = 0;
     }
-    env->CP0_PageMask = mask << CP0PM_MASK;
-
-    return;
-
-invalid:
-    /* When invalid, set to default target page size. */
-    env->CP0_PageMask = 0;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
-- 
2.43.0


