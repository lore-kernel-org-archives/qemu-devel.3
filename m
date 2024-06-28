Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A21C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWJ-0002WI-N7; Fri, 28 Jun 2024 10:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWH-0002Vt-5n
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:09 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCW6-0004VE-RF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:07 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ccc40e72eso630243e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584634; x=1720189434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G22fQN40fbFYvTKwEhcW1cHU/qR1FCgG6nD09XlMchg=;
 b=AQ6kf/BfXoBsG+qPIppU5dsJc6nwRRHOLrMJfd1qq/u/6xmq0YcU8z0M1sPrU2TKPb
 2AV1vTfSK0KEKNUM9OKH0YVji7ub8OZL4jurw7rRVPbNOAvj21/XgE80dcquMI4WQlKW
 uhrzZhhmaLc+iEmVVY80kAfF4P5fWVYB9DwP1q0ggs4+O0d9tTNgQXIjX4n0vx8OzuFk
 IOyC3z3qRCrMopeEvxXIo85mg+mXX+OM34LZz6cEmNizaBZSGQqfhaB99ciJfBIqP/Wd
 Jm858mqz2dzasc/gAftz7Ucc3KqfnPTfy253uH3oZhDdBC7MKW3KfdsJsmbXiCohWX+c
 GbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584634; x=1720189434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G22fQN40fbFYvTKwEhcW1cHU/qR1FCgG6nD09XlMchg=;
 b=puNN0JnnTABG9vB67K3fGc1N/AddZj8bZ2YqnUfA+sBmIhVjrjZMt3NFlfRYORMZGy
 aPfoAISZgiZJLOQVOyQbeErCGhFShIbhcJkWBZg+l9m84L9IX+/1NI+ZN0g9OT4xFniJ
 BLCEjeHiBQp9ZjIevpwsAXAoy/ndC1II3kv7VOXbP5wWsTLK4dvGpda1EbGp1XAiE/bu
 zGMeVNRI8b/qkGfSLO0nKs/9tq5H8dh7KcAsidQBR17GznMpHUZkVE24+hHe6o8Hd00E
 g6yrjEna5UAkIZsnqRI99uIBiHyRhLW0/3wYyK5kid2PGzINi6nTqVKc0JkHvxDJpAtR
 T6Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ9aK+cY1D+rb6t3Lq30hPQGsqN+wYBC8948+DVsEw0TMsNWmIYNJ4vpx9oqvF1kJTgOH03IRNNCOh/AwvP9gChYQ48Qc=
X-Gm-Message-State: AOJu0YzUGxVC6bKD8wBE1nmn2gkMPepoYUiB3wksNH1yedHyGwFZ9HjV
 sdt1Gmp+GTfMDWMHd2GGQ+b2D117L5XCKyYrbxf7GgfEq66+5pJQolthDFkdsl8=
X-Google-Smtp-Source: AGHT+IF9sAKLNbBThys7jatmuCgrD4zLHz4CGP5kAALtn2KLtc7D3cfkDmq4ws8T1/cX0NFUAblqew==
X-Received: by 2002:a05:6512:3d04:b0:52c:df8a:5938 with SMTP id
 2adb3069b0e04-52ce1835465mr15710033e87.26.1719584630259; 
 Fri, 28 Jun 2024 07:23:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/9] target/arm: Make vfp_get_fpscr() call vfp_get_{fpcr, fpsr}
Date: Fri, 28 Jun 2024 15:23:40 +0100
Message-Id: <20240628142347.1283015-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In AArch32, the floating point control and status bits are all in a
single register, FPSCR.  In AArch64, these were split into separate
FPCR and FPSR registers, but the bit layouts remained the same, with
no overlaps, so that you could construct an FPSCR value by ORing FPCR
and FPSR, or equivalently could produce FPSR and FPCR by masking an
FPSCR value.  For QEMU's implementation, we opted to use masking to
produce FPSR and FPCR, because we started with an AArch32
implementation of FPSCR.

The addition of the (AArch64-only) FEAT_AFP adds new bits to the FPCR
which overlap with some bits in the FPSR.  This means we'll no longer
be able to consider the FPSCR-encoded value as the primary one, but
instead need to treat FPSR/FPCR as the primary encoding and construct
the FPSCR from those.  (This remains possible because the FEAT_AFP
bits in FPCR don't appear in the FPSCR.)

As the first step in this refactoring, make vfp_get_fpscr() call
vfp_get_fpcr() and vfp_get_fpsr(), instead of the other way around.

Note that vfp_get_fpcsr_from_host() returns only bits in the FPSR
(for the cumulative fp exception bits), so we can simply rename
it without needing to add a new function for getting FPCR bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 24 +++++++++++++++---------
 target/arm/vfp_helper.c | 34 ++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3841359d0f1..68a9922f88e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1714,10 +1714,21 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_NZCV_MASK (FPCR_N | FPCR_Z | FPCR_C | FPCR_V)
 #define FPCR_NZCVQC_MASK (FPCR_NZCV_MASK | FPCR_QC)
 
-static inline uint32_t vfp_get_fpsr(CPUARMState *env)
-{
-    return vfp_get_fpscr(env) & FPSR_MASK;
-}
+/**
+ * vfp_get_fpsr: read the AArch64 FPSR
+ * @env: CPU context
+ *
+ * Return the current AArch64 FPSR value
+ */
+uint32_t vfp_get_fpsr(CPUARMState *env);
+
+/**
+ * vfp_get_fpcr: read the AArch64 FPCR
+ * @env: CPU context
+ *
+ * Return the current AArch64 FPCR value
+ */
+uint32_t vfp_get_fpcr(CPUARMState *env);
 
 static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
 {
@@ -1725,11 +1736,6 @@ static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
     vfp_set_fpscr(env, new_fpscr);
 }
 
-static inline uint32_t vfp_get_fpcr(CPUARMState *env)
-{
-    return vfp_get_fpscr(env) & FPCR_MASK;
-}
-
 static inline void vfp_set_fpcr(CPUARMState *env, uint32_t val)
 {
     uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPCR_MASK) | (val & FPCR_MASK);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index dd67825270b..a87d39e4d9b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -85,7 +85,7 @@ static inline int vfp_exceptbits_to_host(int target_bits)
     return host_bits;
 }
 
-static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t i;
 
@@ -156,7 +156,7 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 
 #else
 
-static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     return 0;
 }
@@ -167,26 +167,36 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 
 #endif
 
-uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+uint32_t vfp_get_fpcr(CPUARMState *env)
 {
-    uint32_t i, fpscr;
-
-    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
+    uint32_t fpcr = (env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_MASK)
+        | (env->vfp.vec_len << 16)
+        | (env->vfp.vec_stride << 20);
 
     /*
      * M-profile LTPSIZE is the same bits [18:16] as A-profile Len; whichever
      * of the two is not applicable to this CPU will always be zero.
      */
-    fpscr |= env->v7m.ltpsize << 16;
+    fpcr |= env->v7m.ltpsize << 16;
 
-    fpscr |= vfp_get_fpscr_from_host(env);
+    return fpcr;
+}
+
+uint32_t vfp_get_fpsr(CPUARMState *env)
+{
+    uint32_t fpsr = env->vfp.xregs[ARM_VFP_FPSCR] & FPSR_MASK;
+    uint32_t i;
+
+    fpsr |= vfp_get_fpsr_from_host(env);
 
     i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-    fpscr |= i ? FPCR_QC : 0;
+    fpsr |= i ? FPCR_QC : 0;
+    return fpsr;
+}
 
-    return fpscr;
+uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+{
+    return (vfp_get_fpcr(env) & FPCR_MASK) | (vfp_get_fpsr(env) & FPSR_MASK);
 }
 
 uint32_t vfp_get_fpscr(CPUARMState *env)
-- 
2.34.1


