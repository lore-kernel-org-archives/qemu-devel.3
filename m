Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A66C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeZ-0000t2-Gd; Wed, 26 Aug 2026 13:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe2-0000An-9P
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdz-0004qb-TH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8548db7428aso346639b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766154; x=1788370954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmXUq+fsPwyO80LzQiEP88Q3vooswSB7fXANN1O62Rw=;
 b=nOGf0HvUMUtoZFmmemxbBUFOdfcRVb3kfS4Xdv5yktk0rDdrtnVXOU+Q6sjYPVP5Q+
 tc5xGuG4bbuxY5hbJkTH4v25U1vReW381cBT7hxyYMALi7OvvuZAtfGhbIp6EQdjyRs5
 ezyMoKVvmr46WPU53q+ttqxIcmkS8EJHXKmeaeDtfo7vfA6n2UohqnbOrvYvxjdL3+xK
 y68hqwgK+6Pf3oRbLS9Mrk8rGCiKRY/Qktt8DppbCSPmILY87Re4cdUm5IAVNdxxAeAm
 fJOE5HnSAULVxMTIPObPAMsGomjx4ClgmOHjyPjzofhLcnbjusveFS/0Yee+qLZu4Ae3
 GlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766154; x=1788370954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SmXUq+fsPwyO80LzQiEP88Q3vooswSB7fXANN1O62Rw=;
 b=lwQOjo29wW55gT+NajB4V8xNMeBpivU7dZydcr3MRJsYuWt6Z22etnVrrlixurNHYQ
 KQJzIM8ZfZ2o38G1IMcE5DmoefJPf/cyf4xxhdcxqApINbWv+tN6Fzodg/x39e3SJp8Q
 AQ/ffQOBH1EHXL9/nZ88uppvfHJ0NSlS+tucdIcn2pG4ERueB/xQyVGTRkNSwCGejIg8
 kwDRqW4NbwwCgGwsfygWLIx7mcYjJAAgpguj5tU1zXwRCdB3VP4AP1J+RCAFlE6n24T5
 FuMFtXMgY+va4eRr0i55SYj8N8861lgz0uOcspeJdFfQlXVRGexNwNlI3f+b4JNksEjK
 lInw==
X-Gm-Message-State: AFuF++l5jCadBxHL1YD9grtk1csxELxOLx6XqD5kl/ym2/PnuPsJs9ow
 YJ10EJ3tcDEhI9A9562wlV+oEpOud9ESXJ5Re5dZXI+LKv0YrWuVtPur56VANtNVLTfAxjgBnxj
 BZvj46RM=
X-Gm-Gg: AR+sD10qPFAwowe5oCZdeP8vOA0xBuhhl/ty5AgJP0e/+kN3JH0dinZ6G4u+UXOFneH
 /d5U9Z/Cu87DiO16XFKN0FqM+ULw/HVDUiTKcJ0Y0EPpCsZp9kFw1ws5d3fldhiKJ7mCne/Bnwm
 jJriFvJSc2K2Ney+P6ZqCpZ2Gw7nVd+GuYGgov9/8aHLcDP/nDrbugSG2TJVD6rGYRG1nxFFzbn
 rnKhQiM96CiaBdxq02N6Ld66AtPMN4zu8Awje62DFvDbrA4VkGbsblyeACNcJHKN4SMmX63RHSl
 +uMQ4r8O0pRefiB2C4TS7Zsl3TO/dQ4XVJw0lV3SfEAl7CiVq88Kx49oNH29qZnG1an1Xb7nrsT
 FF5ctyt0zyViiQ5vOGFc2+SQSqqKX7fAJ86ePaqsNdP3LnM2PEwAT5/SSTuiGrsslHKf/+5NYHf
 mgxJ4BGD/6t8jOuDRXjuL/1aGFUHtjcRG5uVfhP66Ba054GkDvVkXaSGaDmQTEHL7Fj+bG71zY0
 /OT6oep9ed3ZVVamA==
X-Received: by 2002:a05:6a00:6c83:b0:851:92fe:504b with SMTP id
 d2e1a72fcca58-85372faee4amr3814823b3a.7.1787766154492; 
 Wed, 26 Aug 2026 10:42:34 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 17/25] target/arm: Rename isar_feature_aa64_sve_sha3
Date: Wed, 26 Aug 2026 10:42:04 -0700
Message-ID: <20260826174213.614571-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Rename from isar_feature_aa64_sve2_sha3 to match
the feature name: FEAT_SVE_SHA3.

Reorg trans_RAX1 to use TRANS_FEAT_STREAMING_IF.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h |  2 +-
 target/arm/cpu-features.h          |  2 +-
 linux-user/aarch64/elfload.c       |  2 +-
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
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 857adf4ee07..f94e8efe471 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1549,7 +1549,7 @@ static inline bool isar_feature_aa64_sme_sve_bf16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BFLOAT16) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_sha3(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SHA3) != 0;
 }
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
2.53.0


