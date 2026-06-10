Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325B6CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYO-0002Rd-II; Wed, 10 Jun 2026 12:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYJ-0002BU-Ab
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYH-000603-Ik
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490e1904089so3416825e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107992; x=1781712792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uBnE02oZ6ge03IDSrd0TW8V+eHFhRn3CLIQlSGcmlTs=;
 b=wxqL/EOhWAWWcEB5N3f6yYke884gMPk0aTaIyAoiBSn2YWkkvNA4XgLuTfYmLKlrnv
 ZJcBOUz2LH37DIA0uxr/OodTtQYTU6p8MxvlYLm0VII3FvoBU61jCafsEd3g/PQJiGSn
 7kfN3M0+sl85FmebhmjdyeIBPnmOXcwyQ+SgPcNOfaDt7iw0BGiGPM3grUO5aLhMQGPN
 xOmzQvZsQuqunZdB4A/h+uBna1MEl5HCb/aVAJRSDJiv3h+rM26koeDzqgf1ztbZV32p
 zk7oCy9d14OvuZq/RZPm3z/7pUYM2DP1ZTyACeGXayyFJG8n2QV+KZJ/QO+pSiTWcqn0
 JmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107992; x=1781712792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uBnE02oZ6ge03IDSrd0TW8V+eHFhRn3CLIQlSGcmlTs=;
 b=S8ItlQUkY3PW5VtvVED0zq3keq/YNECtqiVfRh6ugmMo4nlTZH2J5Txw/YFbR5FeZb
 hcLNbgGb9i5qqiuFZOE/WBQr19LtZjIzoqYBFM2cDTz2D27pOvAI/C4+xIXa6CIEFdIa
 2e/Tq1iiaGnLxXGgaRsgS3aKvVrPfWVA6JYZqsVFvax7yO6c0d7R9sNhmYPDGiDn9A8P
 Xn4Er6lLp4EdhyzZM5SoSL0BHIVTdY3P+C3pjaAXxPdJqzNBni8Ljzab2pDLHN44BgaJ
 tX95me5TMbMcOXwE3yH0S6axgLQTbPChKeBlzm9/+5yBV0ObsJPXiT18ZiAa5kWFK5+f
 636w==
X-Gm-Message-State: AOJu0YyIxRr3I367tjyl/y9AT1fsiwKiTIerFgJPuMaRWzveS3sIPhpo
 hXn2Q/c/Hu+ksh2yrPfWppFYp1TSIp8foBy/k17S9IOTS61tbJV4zuiONE3v3AbyLa8nGnrdAW/
 v7Pg1
X-Gm-Gg: Acq92OFFKAM9w5l3RYr1OfdiruYCzom66o9Ji7U7DbAhCfO+z0LUQ76na/skGfyCGPD
 3w+0Vl7B2H2NKFNyMOBSWaG5+TlzEc4fwz1dxVyDMdixDzqYLXgsv9+Qbig/dbYiO55uJCyCXMj
 ZD9y0kL5gVr4XR8eDMl6yCSsytF2NJOMY9HMMdjNZetfnwOwFc63MkPcXUOANoWTuklXJAcZd1g
 u8qBrZfzVh3kUfg/1Nwz95Dre4PO36NRcaDR3Zym6T+MNHv+TYFBvYRkb51nN1EjeSL9P2dY5hK
 vRS0qKWy8xZ0m2RCWoDtIDCLYN80fh0TWpwLG7Z2oJd2dx25P+j50acByM9ET2q6G9DrWjcWZ2F
 RxqDQknd7/adBdhDIRpaaGtepzB7KMb51C5yJnWmgG91R+nMioEjl0fj6xsUpo6GoxYkx2yb9Nn
 MYFke1T7J5Y8Xo9HTEd+msZcZmlDN19RPu+IZ5kArfAKxbpMBnLxBpjHIP0nm/vuYwLNjhebwp/
 AjeqQV/7brOlfmnN3V5WVPLZSl90U0PaPqyj0HtHl4=
X-Received: by 2002:a05:600c:4e09:b0:490:e190:3b50 with SMTP id
 5b1f17b1804b1-490e1903e37mr18159085e9.9.1781107992012; 
 Wed, 10 Jun 2026 09:13:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/71] target/arm: Enable FEAT_FP8 for -cpu max
Date: Wed, 10 Jun 2026 17:11:41 +0100
Message-ID: <20260610161202.2235298-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 3 +++
 target/arm/tcg/cpu64.c        | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1328cce15c..b8f452f2f9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 5ed7a7badb..1c0c404b7c 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
+                               ARM_HWCAP2_A64_F8E4M3 |
+                               ARM_HWCAP2_A64_F8E5M2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 234368ba7a..7a6f1c6601 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1397,6 +1397,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
-- 
2.43.0


