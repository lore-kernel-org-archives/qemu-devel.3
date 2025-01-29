Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CB2C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2z-0000tK-Cb; Tue, 28 Jan 2025 20:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2v-0000qf-GF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2t-0003XK-Ui
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166f1e589cso45644185ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114750; x=1738719550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GA8OMBaKoWm1dr2kAwaJfnYaqSkCIQYp9JiJNnvOmTg=;
 b=roAFD/4CwyZcTTBCq51UFh9VYMT5K2oh6RLTCkoZjvr2ya71ZlBWbs9ZXedf+HlQAL
 ZXsYhDvNm6ogY+ZDV/dn47DxpCK1+Cde3Uk3S6Hrzg7k9YQ/TMSKw3KTUVBHiQw6yxpn
 oSZzLZxZnoRY9HeVPej6gNgX6Xb7ZfQhI/HPFGQS0WZrlS4ajQGlkVrcm63n/sPKSMHX
 kx4gSWbp3Hw3u/PmJrQWEUGgyirI0IemTZKFWDXEMRJKC+b9WFzmAbeF8ma6UcsHQdq4
 YTuv+lP9+zvBh47GajcdjRc/LRzPHhhxG+g4adJT/HPzuFZQBdaXValj8dMJCDAanxuK
 wdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114750; x=1738719550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GA8OMBaKoWm1dr2kAwaJfnYaqSkCIQYp9JiJNnvOmTg=;
 b=AjZzfQC8VUqd2wlY0kLk2hzuGsEGZFuRNfyetN7DPVl+sYw8iDAg9THzhkEyPCQ7ZT
 qxCTt3Y4MhZHFe9FR86D7R5oicZzVLHl7USguUgP5qqlsRUyRg7IwVKcPvmHWYw3V3c1
 39minNZOQBCL3VM5Nl81btUiF2K+mubAtk3CwmAHOfH/GjI7ZdjaGO+IcMh7J362zi+t
 eEYKImsmX8Cos9Po5JsXS5ozmue6ki3WhNYXtxdzwsel/iH2HzW6uVKzVv0Wb3JS8sA2
 eFqMQfBaIs5prGGsY1vOgpvpbeUbassIq+G5JzJRQELgjkZGCBVCozsFwt8MOnthY/Hk
 c0sA==
X-Gm-Message-State: AOJu0YzSOYGOqg+iYpC++jGb+XLFdVZSr9CWXdAb9jNFKMPsj8/fLjMa
 BGPAnIGvM2AYKs1IRTbqcWrj2EPddJBvbwFIgAwctxQyeKmH41Ag/DCkioNboezvlBiHaCQNzsV
 Y
X-Gm-Gg: ASbGncvbwEyWBksZFWaB10s9ad3WIwaeEKjS8f8phTrduAUQpO6+cm7Vxo48XiCceTH
 uGr11TRIsaZqa/BnK32isnBR+spvmabxroYmw5LqObOTZHRWFvJEmGAb5D4bn3nJ9KmlR/EZxRg
 5DuLCHhRcF8SRxPoaw2GIIWILH7T4xsz3VWjX0uxyeH8JhxvgcA7KEmv9emBga6MKYPDfywcMgp
 34ercPfA49TxbOOI/87+VuJYfw6tnytQu6/191VRwQXonOeWcqONHJ7v3jCHYadGMXegdfvu2c8
 h/tJsrDRX/TgNgGhVbnNj0HmVlhuhUjEBTmRH0pTsX6Z0L2QGA==
X-Google-Smtp-Source: AGHT+IF+oL8ssgO+RQg4KFHvb5WP2QMCKOZIDFhJtl4xLwG2rpz2Vv9pywV3/7NX4IshlYOQnd7ncw==
X-Received: by 2002:a17:903:2a8b:b0:215:97c5:52b4 with SMTP id
 d9443c01a7336-21dd7dccd5amr18064725ad.39.1738114750658; 
 Tue, 28 Jan 2025 17:39:10 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 17/34] target/arm: Move float*_ah_chs to vec_internal.h
Date: Tue, 28 Jan 2025 17:38:40 -0800
Message-ID: <20250129013857.135256-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 20 ++++++++++++++++++++
 target/arm/tcg/helper-a64.c   | 15 +--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 094f5c169c..a673935f48 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -20,6 +20,8 @@
 #ifndef TARGET_ARM_VEC_INTERNAL_H
 #define TARGET_ARM_VEC_INTERNAL_H
 
+#include "fpu/softfloat.h"
+
 /*
  * Note that vector data is stored in host-endian 64-bit chunks,
  * so addressing units smaller than that needs a host-endian fixup.
@@ -265,4 +267,22 @@ float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
  */
 bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
 
+/*
+ * Negate as for FPCR.AH=1 -- do not negate NaNs.
+ */
+static inline float16 float16_ah_chs(float16 a)
+{
+    return float16_is_any_nan(a) ? a : float16_chs(a);
+}
+
+static inline float32 float32_ah_chs(float32 a)
+{
+    return float32_is_any_nan(a) ? a : float32_chs(a);
+}
+
+static inline float64 float64_ah_chs(float64 a)
+{
+    return float64_is_any_nan(a) ? a : float64_chs(a);
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ba21efd0bb..dc96c92a21 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
+#include "vec_internal.h"
 
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
@@ -208,20 +209,6 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, float_status *fpst)
     return -float64_lt(b, a, fpst);
 }
 
-static float16 float16_ah_chs(float16 a)
-{
-    return float16_is_any_nan(a) ? a : float16_chs(a);
-}
-
-static float32 float32_ah_chs(float32 a)
-{
-    return float32_is_any_nan(a) ? a : float32_chs(a);
-}
-
-static float64 float64_ah_chs(float64 a)
-{
-    return float64_is_any_nan(a) ? a : float64_chs(a);
-}
 /*
  * Reciprocal step and sqrt step. Note that unlike the A32/T32
  * versions, these do a fully fused multiply-add or
-- 
2.43.0


