Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6599C44500
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMKr-00071G-N9; Thu, 02 Jul 2026 14:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKo-0006zg-B4
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKm-0005Ks-FM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so7696755e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017623; x=1783622423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HuLTZKHdzjaw9RJu77G2oDzJlKwJvCa0+C6Yhk9ClPY=;
 b=Bj9ZSQOioN46wD6oJnI6Mf+MCkAYGuAATfDMdPDQmMOzthfXd5Ip6mDQAqIFpylFu7
 zyR9zlUNMlrpzRVAgB7d2pFru7SyCGBq7T6kaSLaZe2MadIn+1ebsxceYz6aIUy8pXrD
 P9GIAR88f+ozcUo+XasC1TXk0moKqK5xONBPe+Ulht20BYLFSr3TE9vVJnB0yyXWBMHu
 V6PDdoNV2LgYgLY8drYw0IdOlKvDazxYQcbRMxN78U5dqB92YSWAu794ZkmwUVjw4jlP
 Roh4F6PfUIew5YhfqOVriITuIesTi+wTfhAvBgrSmvdtTevVbkHXxjStteXQbPiRZk/2
 idNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017623; x=1783622423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HuLTZKHdzjaw9RJu77G2oDzJlKwJvCa0+C6Yhk9ClPY=;
 b=bgHYXWmv/kVmNa47vO/w3J8B+ESCO2a8T4uH1dd6mILwUXd6zeQiQRHTi77JJ6SY0T
 kwLhZQhAi1keXmJVHpZN62GN2ChFbgGWkKMaGk0jFGZnBXNZYhlquuAH0JMwPqNkK/CC
 FoFcaNvWvLpdovZP6J6rogEIMJlo9JMkOJIEvTpdjBSqS8WtytIT4Jcg626oGVgcbhP5
 Hh/zORYqv8oRW+Y3TDPe9XVXt/ThqaBnn6XCSI+TOFcyMvBv1dXLPn192gw+FeaVebvm
 Mow98APCgafNEFI8tcDM9+iwLrTL0ZNo0p0QH4QBVi9ucg3VSFCxZjaN/HyQWj116jv0
 74OQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kKcvA4RFZzeLFv6x7c0zPCOIol6R1zwui+g+5gVqUfpwctBmZ0lsVOYdwaGMFJQsMPDGkarDLtBhX@nongnu.org
X-Gm-Message-State: AOJu0YxPdxDy0wMPuZqN54/aSgITyxXN4bJBOPcOpl0tD9VKtSlHldVo
 0ECUG3U4nExpytg0PYWLMgHS9bEgajnevHmfMZxJsdYZiwYr0fi3WQ94glw9h7V/bghEiucv06t
 vbOo5/5KVuQ==
X-Gm-Gg: AfdE7ckGTaCX6xvANTsZZCVKKRzCRbCT9W+dLWcWgt7vB+JwyXLnz/Yogrkguo/fJBV
 6pcqTnNA6EzDQ8bulUTcv4mLlRumKBG4+A/C/+J2rggyjcUDkrwb3ZQQMZO23mYUVRoE94jC/oo
 2/xNJCmFlh62pqAgGvrLyEsU6LADcfitFEQ6wKeha08fgxCMzMJzuT0IKvrrZijhfGmxH2l0fpF
 0nREPFoJlTUmyP+jgCfCxPQZg+rHksrx2rCnuQPjya71L4MYGYiNEoQgf4c4nvT1FW1L07atn81
 tZmHIlp+tT8Y/Ztgo0qTgh3z5ODcije2rMyUie37i7qDAnSXHyIWhAd/AqUbXzKczQhqwmSO0qt
 WR/DyKqszUvAkR02hJ01z0BzY+V0uu6TAGjv8s3CkQf4it2frC6fGDouCYnr/vRlCQPxD9Gauyp
 bcpA0oE35qXTURI8FmPheE7vYDP7Ko7YuVFMZJ8fMOpRgV3bsuQXpOwkaLp3sWyc0KUnuMQonFw
 6pI5Dn3JiQaKvAmnmmg1A==
X-Received: by 2002:a05:600c:6986:b0:493:bd04:2cfb with SMTP id
 5b1f17b1804b1-493c9b77ee7mr16871725e9.13.1783017622828; 
 Thu, 02 Jul 2026 11:40:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/11] target/arm: Separate syndrome functions for A32 and A64
Date: Thu,  2 Jul 2026 19:40:10 +0100
Message-ID: <20260702184019.3431139-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Currently we have one syn_fp_access_trap() which we use for fp
traps from A64 and from VFP and Neon A32. This means that A64
has to specify arguments that are always fixed for it (coproc
and is_16bit) and A32 can't specify arguments it needs to (TA).

Split it up into syn_a64_fp_access_trap() and
syn_a32_fp_access_trap(). This is a refactor with no
behavioural change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h          | 28 ++++++++++++++++++++++------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate-vfp.c |  2 +-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 0eb54c15ce..2a6fa903f2 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -345,21 +345,37 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
 
 /*
  * ISS encoding for an exception from an access to a register of
- * instruction resulting from the FPEN or TFP traps.
+ * instruction resulting from the FPEN or TFP traps. Note that
+ * the TA and COPROC fields are only valid when an AArch32 insn
+ * traps to AArch32 EL2; they are RES0 for traps to AArch64.
  */
-FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COPROC, 0, 4)
+FIELD(FP_ISS, TA, 5, 1)
 FIELD(FP_ISS, COND, 20, 4)
 FIELD(FP_ISS, CV, 24, 1)
 
-static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
-                                          int coproc)
+static inline uint32_t syn_a64_fp_access_trap(int cv, int cond)
 {
-    /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
+    /* AArch64 FP/SIMD trap: TA and coproc are RES0, insn is 64 bits */
     uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
-    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
 
     res = FIELD_DP32(res, FP_ISS, CV, cv);
     res = FIELD_DP32(res, FP_ISS, COND, cond);
+
+    return res;
+}
+
+static inline uint32_t syn_a32_fp_access_trap(int cv, int cond,
+                                              int ta, int coproc)
+{
+    /* AArch32 VFP or Neon trap: TA and coproc valid, insn is 64 bits */
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, TA, ta);
     res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
 
     return res;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 227719ef25..90b6778553 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1439,7 +1439,7 @@ static bool fp_access_check_only(DisasContext *s)
         s->fp_access_checked = -1;
 
         gen_exception_insn_el(s, 0, EXCP_UDEF,
-                              syn_fp_access_trap(1, 0xe, false, 0),
+                              syn_a64_fp_access_trap(1, 0xe),
                               s->fp_excp_el);
         return false;
     }
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 6f6b234c9a..7474973952 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -228,7 +228,7 @@ static bool vfp_access_check_a(DisasContext *s, bool ignore_vfp_enabled)
          * this field to 0xA.
          */
         int coproc = arm_dc_feature(s, ARM_FEATURE_V8) ? 0 : 0xa;
-        uint32_t syn = syn_fp_access_trap(1, 0xe, false, coproc);
+        uint32_t syn = syn_a32_fp_access_trap(1, 0xe, 0, coproc);
 
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn, s->fp_excp_el);
         return false;
-- 
2.43.0


