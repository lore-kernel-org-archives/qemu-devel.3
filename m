Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8850AC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONh-0001SK-9d; Tue, 01 Sep 2026 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONf-0001RK-Ox
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONe-0007Lv-5K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so120104766b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268704; x=1788873504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uNK48Jx+kVyDaN0kaJ+88YSDWMhPok2qF3qvJEC0n0M=;
 b=AxSu5om4sc8E726sSUQFfTtuQtK5VBqyKP/QKBkvRoVTBn2Y5D8z6YNjzO56rlXH08
 z5GimhirdWBwz7KZSQ36ke+trY8fyAu82WuCEncjn9Bppe/WxrW9OCysoIR6kZX4J+1x
 7SmGptto4pzUwdAeo41E7Mr41JABcdrChNmeIDT+c99pL5vzmxbm4/MLJR2AnyY9v8IZ
 JJEiz1hO5oi+QLWS5J2O4Ack4tzqmhf7Bz1BTlmVloCWj0KmXq06J+Tw90mQE5OdAt50
 tzisieISUg+KhpTIdAyoapOdcKXlNjdtwEe9DLg5VNB6koIw466MtoGl3ipqHQhYYZLi
 jlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268704; x=1788873504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uNK48Jx+kVyDaN0kaJ+88YSDWMhPok2qF3qvJEC0n0M=;
 b=gL5J17057g++4esoxQ4Q6S32B0eAPnKYGzoCaaJB/+mLI5c8fB1DcVviVV+smoRwRz
 rtan7Jj/OGiX1Lq9L0GeqrHXI9Xkgl6T3S4MH6RAUEAialTaQOHgZzREgeZpIk/CSq02
 bEcuxAJDIAUy92ZPiOMv5fGIVnYb8j0Iz1MRbN1+GHHkBh/SYmW0T9YBqs1oFLRJtxUu
 nVDHaZCuD41APkOc9aTC+Nqji/bePFAfNwWf6ev6bYPbb/aDTkm4LMF7ArpCTRYyinNT
 YpR/8S0+21swQ+TdHlpZh6wjkPt96t5lPtnioo872ylBU3Yip1qyiQawDHtpO7mReyUO
 Nkaw==
X-Gm-Message-State: AFuF++mCDzygMRv41CRTayWyXYJrGULMp9g/OsyqynnDIVV5LZCpSwtp
 oM7f9NKcKJ3NaA2Um2PYZ5CIYN+ZiKWdSJacj3JFZQVPEcP9hA3cFfaKd0sIRnumtRGRxYSG5Nw
 wPUxIMIc=
X-Gm-Gg: AR+sD10yarga+gs12Ti6NmtSlqcP3TGy7Q/RjncBuA2j962uSrxm26oMPzGMsPLNIIc
 XCdWZVD15+QZqn6gzUCmuzrRLGylVhTMQIkHjQpPftTbSvnc/jIsMJyuneoxV+Rpf5/hLjW6RHd
 2deS4ZVvb89Sjm2iyekqrmUHy85fgNnZ1SuP/pcOiPO8IUJUh2sK1TYDrj+Eih9iTng2ZBAUPrm
 BSdkkskPHbF8Fz5oMIGk0yEYpyIjZvSfARhd6SdSZj+U0Y+YzC0xas194OxU+SomDmauBYc3DsJ
 Iqte8olbIw0i8e5A5ek4ratBp5hXwVGKtgxsq6dG44Z2HYu3QQKasRUAx0BVC/ChlAc7nx5IYov
 ZeQW+Q+Y21KgA1SCTFj1qWpUQOChieZDTT9qHF7P2ZYG8wETeWdKOmQKqST8DVNv4ZUT/p89/vX
 L2nFogyHjy7mVLZ/2DsLTcUhpXnTQdvJMdugS6fkJmTAsjntmxeGoHaiczQ761l7iRjYDF+FpVa
 0Zh9GJsftSf/JL0R33w64SAYLb+9VL/6o5b0/aXqUnAdehLvkqJYl18tkj2gI+1No+n658=
X-Received: by 2002:a17:907:ea91:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c2556fe5799mr2292180266b.9.1788268704356; 
 Tue, 01 Sep 2026 06:18:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/58] target/arm: Rename isar_feature_aa64_sve_sm4
Date: Tue,  1 Sep 2026 14:17:25 +0100
Message-ID: <20260901131732.2263947-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

Rename from isar_feature_aa64_sve2_sm4 to match
the feature name: FEAT_SVE_SM4.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/cpu-features.h          | 2 +-
 target/arm/tcg/translate-sve.c     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 8669f3f8330..0ec7a7b5859 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -130,7 +130,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve_sha3, ARM_HWCAP2_A64_SVESHA3);
-    GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
+    GET_FEATURE_ID(aa64_sve_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
     GET_FEATURE_ID(aa64_sve_i8mm, ARM_HWCAP2_A64_SVEI8MM);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 83791768c6e..7afbfca4183 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -196,7 +196,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve_sha3, ARM_HWCAP2_A64_SVESHA3);
-    GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
+    GET_FEATURE_ID(aa64_sve_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
     GET_FEATURE_ID(aa64_sve_i8mm, ARM_HWCAP2_A64_SVEI8MM);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 60e3f88c9e7..749dbfe6fb0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1559,7 +1559,7 @@ static inline bool isar_feature_aa64_sve_sha3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SHA3) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_sm4(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SM4) != 0;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index cf5445870cc..3d823674cca 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8302,9 +8302,9 @@ TRANS_FEAT_STREAMING_IF(AESE, aa64_sve_aes, aa64_ssve_aes,
 TRANS_FEAT_STREAMING_IF(AESD, aa64_sve_aes, aa64_ssve_aes,
                         gen_gvec_ool_arg_zzz, gen_helper_crypto_aesd, a, 0)
 
-TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4e, a, 0)
-TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4ekey, a, 0)
 
 TRANS_FEAT_STREAMING_IF(RAX1, aa64_sve_sha3, aa64_sme2p1,
-- 
2.43.0


