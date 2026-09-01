Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8936EC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONj-0001Su-J5; Tue, 01 Sep 2026 09:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONe-0001QO-KX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONc-0007Li-TS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso164234766b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268703; x=1788873503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c98Lr2N5u7AQTGIDts7hCizhIARHaZjsitv4d+Vm5YU=;
 b=PFvGFCZ7uRPwasAvX3Kl4btTAdwOCdUc0sYggRdUeU5MwSpPjS42SkhkV8q8cF1EQm
 aBzepQOZlAwq0WwFLv7ANbu+FBsrdZDOPq5D+uUWY8dXbhjp/svAjtnfeq0dR7kI+yRb
 wZGFpXVNME1zG8pFo4l1qkxPSZvo573Wz0jMOai3Jhqf1f3wy+XzdAORa4baIaCuSHeU
 qO2kCnNmDh+baoWQh7AArf3VrPUfqmzn6X7/vqQPuPb3L9CSRgcoApE81xLWr8oNF9Mw
 jZFN/tcGA7KLV2gg4HlWhwd9/Z2toAj0iN5x41vKugWUA94CgNB2kPezPf7Szdp28P8Y
 dTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268703; x=1788873503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c98Lr2N5u7AQTGIDts7hCizhIARHaZjsitv4d+Vm5YU=;
 b=PDhsIqFewiOFFQH6+I/ViBJ3WNrfnrEbf0GgzCS/v5YxXulMpfYm9BznmDw3TNbuS8
 GS501trdlwfXICxSVFgoe2iZJe5vezKPXCUerPbARfqu9UtAKpYVuIixx3Wb1ijK6g2K
 UrB+G3WHNAg1F7aHV/nzg6baZ88vhENl6sALBvNCCGy5Yf1qbnfWfUktyPnnZx0isLvk
 Thf2/+GIHTvaML1zO1K74v3lRl03zWj3oxUSDsZDEDCldYZU5SmheDf/h97FeRYDQMm2
 5/rOAgT05GhJJsrFGeNj8yE4Avvic2oaHKKowGHRLnuNGqooLsgbI57p0K0wHj49YrdF
 EZDg==
X-Gm-Message-State: AFuF++mvtAvboM2yJW9Hgyh6V5sCw3Igcykfps+CzvrBpVKZrmNNaLBP
 R2CZL8JFuk7O0+YdKZBoqh/uh2KXqMCeJQR4wLAxTSlBoiP9LIqNSY0ngDpWLZMASK1ZcHd4I1z
 H78gnqyQ=
X-Gm-Gg: AR+sD10oBV4tAStUZMyNvZA3/gG2rAVjqwNMDsUVkYvMwvOUv83+q3CW2spI+bynz72
 yhyQvRLqqk21u1WSXtp7a7sv/XVmm/j63sCX1rxcwhcK/0j4QBAX8R9eRx6Sp4N6ZJzW6J9rqLn
 ZozRVOI6Vb5nwDMAFeEQBVyFtFte8aZ3hQTCnFiNYdICmG/5/Vl/H9pllGC3vmPevZUMTM9SFAr
 HeMDWYrhaUHcuGb+8INW6BHapAmjyYmZmcYHSrVAf5+5FSWF5uxUxz4mNXsDnCZ4CPO8WYN2HLm
 AsYxma15PzvZTfDBOdkJyokgc1jj/9Cs0xAPPkOclr6XMOpzURwCrDWv/GCOXhTs6Gk0fHRgYsJ
 DnUuhKc0vvrjqIRyH2faJYnWJIQyC3dmPPqhcK5hgCrW6dJAjsV2Gp1vmuKVsRgYoMsx7nIpMp4
 z0g4MTLOnyuGe+/d0XjOWxjjtaufwFyfx8TFTGK5//D64D9JmSmvsx+xYvDDo4ybgwBTQ0nWOb3
 hlhrL3aS08eXPHsq/GQFsG0W3xwxIxpucEWUEisi1ahODvqRsnpC22lk6BSRkYQuI/Ozg==
X-Received: by 2002:a17:907:d88:b0:c25:cb9c:2e3 with SMTP id
 a640c23a62f3a-c25cb9c0427mr1246366b.4.1788268703447; 
 Tue, 01 Sep 2026 06:18:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/58] target/arm: Rename isar_feature_aa64_sve_sha3
Date: Tue,  1 Sep 2026 14:17:24 +0100
Message-ID: <20260901131732.2263947-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

Rename from isar_feature_aa64_sve2_sha3 to match
the feature name: FEAT_SVE_SHA3.

Reorg trans_RAX1 to use TRANS_FEAT_STREAMING_IF.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h |  2 +-
 linux-user/aarch64/elfload.c       |  2 +-
 target/arm/cpu-features.h          |  2 +-
 target/arm/tcg/translate-sve.c     | 13 ++-----------
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 818b6f690a3..8669f3f8330 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -129,7 +129,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
-    GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
+    GET_FEATURE_ID(aa64_sve_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 0569350e376..83791768c6e 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -195,7 +195,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
-    GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
+    GET_FEATURE_ID(aa64_sve_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7d7837c6851..60e3f88c9e7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1554,7 +1554,7 @@ static inline bool isar_feature_aa64_sme_sve_bf16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BFLOAT16) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_sha3(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SHA3) != 0;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 87d6b5785c4..cf5445870cc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8307,17 +8307,8 @@ TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
 TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4ekey, a, 0)
 
-static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
-{
-    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
-        return false;
-    }
-    if (!dc_isar_feature(aa64_sme2p1, s)) {
-        /* SME2p1 adds this as valid in streaming SVE mode */
-        s->is_nonstreaming = true;
-    }
-    return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
-}
+TRANS_FEAT_STREAMING_IF(RAX1, aa64_sve_sha3, aa64_sme2p1,
+                        gen_gvec_fn_arg_zzz, gen_gvec_rax1, a)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.43.0


