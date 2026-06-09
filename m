Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80A5CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23h-0004cL-RR; Tue, 09 Jun 2026 15:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21S-0003Hj-K2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:11 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21C-00047E-7Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:21:57 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so3728112a91.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032892; x=1781637692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEZChDC1OdtmKFkGf/mgdW+kDHfZFX5ELTDL9qf9qag=;
 b=XfoGLT/8jH1Tuh9OAb5+SIhnMUgRHwzVU5wTrTxiLKMV2DehWzIf5hFVFIL0vXeX9Q
 DXqC5sz64R4q3gQEIqiVt2g5UY1cQBIhgTm0Lwd1cYi02I1uXM+HxMNMIuzdy0dr8/Sm
 cPTZZE693PwchVkDCudDZbBsp/OCnsSh1Nhhb9LnpmQZ97HfQiphyh2/RnskgxEcaTNl
 QdCO81+I/sr+PMK+yyfPC6/DSkNvKA+jpTc43UGDAtuQfGiBbXDBGrqXlt4+Eu34mrSI
 0I2W93d4/AkMQ4fWL/9sRv+tGNvYP5omip/dC7bgxF4bgpYzrOaw96+TuVa5vuOUMvAn
 jJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032892; x=1781637692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aEZChDC1OdtmKFkGf/mgdW+kDHfZFX5ELTDL9qf9qag=;
 b=fqrZ3W5uwiLe9mmr0bwjNbXp0FiQhhuQYE+htvWf2uS5pI/1tjesq4TPraBw3MQvc2
 T3D2CGKdW2wUwj9hXGIp7UIL3qy1/MQMJ5Bzl1PEdfG9Wsjnwv/vkBm7d6ghM9gUnjEO
 PU5nSmQhV+MkFGDZ531nzD3x18ApVKVr9QKj6QGuCNaUcKdQbUpGzL3+mGRou5o3qSVj
 WeNyhczibhq1pCM0NsBQPhDXzAySEfhqoIropQtGlTTaVn0H3KSZTRZCPz7GRvtfptfC
 cqgc5MkQAUGm/kjbJjM7p375YR+9xcfsvNBnJshtZ6QxDYJakQFTrl44eAo0erRq4RKp
 aVww==
X-Gm-Message-State: AOJu0Yz13jBhU2NdBPLg0tIdnAQqWhIETLUG3bawTahQ096Vhwo67zSu
 x1aIASX4VfiDmaknUS3P03a9QdOz+yvDRC/qzj1GBeQs/tpLNI4nVQecydhKkR5TFpucPpN7owK
 sD/ICwCA=
X-Gm-Gg: Acq92OEMdhbZEF0531Ba1Dr1xqqNO+DakW8dWSUMDcm0IUIit1qKu0AlAB7BX1t3KF9
 g6PLzCE+wsSDKfu05aLDIeDXI35ndDONVeE19PIIFnnlYEom/ix9yc64RVLRqJf6fza4WHE2Y1X
 aInI38sZMy7SH468oI/mClLeSDPn2uYp5jvtSDDZa0o7FKOPUJSV6Xy5NsNEoIlEKZg3A8skIsT
 bMJV8CoJ4V+GcWxH3UFYHMjlEsCtFWtGr2p40mo31UgWapuRvuGhMN0Yabh6yN+nlcinbz2pYbu
 MSJzKdVk8Tiv8xaZTvg27ZBRwcOh241cQE7W3Ad3fBLjbhZqpv/qVbKd4RIg33Iq8BTLlOX0F/k
 LQmb1L8F3HHfLd2y/Zwr6nRiOr27lqDJFAf21440yHZcSfCJ+VHPkogX7kVmvVZd2IVzAhZtAW6
 0X0tP/48hLfHz4ap1FvWsnR/r8byCZYSvdghDk3V8=
X-Received: by 2002:a17:90b:4b0b:b0:36b:a2cc:4857 with SMTP id
 98e67ed59e1d1-370efdaca8fmr26729008a91.18.1781032891694; 
 Tue, 09 Jun 2026 12:21:31 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 28/45] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Tue,  9 Jun 2026 12:20:52 -0700
Message-ID: <20260609192110.752384-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1c0c404b7c..06c14e82ea 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b48dd01a2c..e466ab5b8a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1389,6 +1389,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 470f7d891e..41fa9bfca3 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -160,6 +160,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


