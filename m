Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E3EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfo-00070V-51; Mon, 29 Jun 2026 08:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tH-Og
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfV-0007NE-7j
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-474303f3c72so434821f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734450; x=1783339250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+eAs302DE7f4GmSyP0JJV9n2j02SGwYGE/QqXwuEST8=;
 b=g4lTzNl+ZuTUCQ4SLZ5FqhgQG63CmCn3sefEIESHUPvapKb+y0noYM5sRGz3/87GkB
 hifKYmhQVcaWtI6WuOFw1l08arrw3DUlTpbgdEVyPNCzDtjaZkk5LE+hUOvu+kBZRxPN
 BwnBIF9Y7JXWxa+GEWtLVMWx3WQWuSWA9ELelyo0wDsQq4gZKsX+QZhwvK64wbD/g+rw
 WYzxnvqDZjNBYU1QA4+YzVGop22Qk6xDtTnXigToRzUv33BF4F5g1HcmwAhg0a1oQ9Yt
 BWl0+3XjUdmBwLjPMGRFqkVVII+69d+x/62K2G3OA+8irvFiOEaxPGuCgLgIneDAq5qE
 jt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734450; x=1783339250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+eAs302DE7f4GmSyP0JJV9n2j02SGwYGE/QqXwuEST8=;
 b=fhG7ggcaQIrE4wxm1iPzMoDWgteMoyLMbrsADOuZ9uTTzTYkqWHBiWz1Ai5OWFCHLg
 AOXIok0dYm75qMnM9MhQrLQYPx8G1IYSd5qCHW/KP59NBX8wNWmeSLfxIYejMz01fLi1
 oaZorfTa5wgR2ibXYtgOHE2beMEkDx53UUGhGEyt+FY8x62dsKkQxlkCR2Gz4ZOfgr8n
 Vs+zVbA7gkbXG5qwpyoWYPt0mYsosZg2LOgjawAmJ8B79spJFlZVM/nqqg1kMUWAkTtQ
 0xCTYOBdq4CBTD2HRYvqR/8uU6guorS3VJEOYEvP13BYH55wkTU5E4yOKEHaBNEn2xaa
 jiLQ==
X-Gm-Message-State: AOJu0Yx2w0amWWS+NZ8Ca+yjFKk6lkpc3DB//38qCFuGKVPzxr2ESrEO
 Bf57P6aX9NjY9mQ+Gj0BQVXZ7mXuY/W1SiZDsugS099Oo8Ir2LXXsg9+1Bqo9eYuSXfHE4HcqsI
 KxQ0a
X-Gm-Gg: AfdE7claNT19szT5itSdbygp9j3181++FxFE/HcqRRw/H24DL1hI2s/Bl8N40W36upC
 KcKVqU6gyAeahoGYIOVM5vz3yDMQ8DA7IIHo3QDf1bsX8KEsJpyt4LL42Zr4JeZgN45xBFfDaGV
 KtmEEghrbSAwhQBjvRMGzqNhRBGk0ikb6l8pogKOuemq5iqwaBf6H/tsoBs58MDUh7WnH3D+ppG
 1sZSuRN4MeQFhufd6CcFg8UadpidS5nrlcAgJILenXbvCPkwQzs5nELS6BE6bzRDRWN5jc0O/qh
 UmiFm5Fhvr50QjakST0Y6WeVLph++HExEU0aPEQ13yfVzl3i6vjn2Wp3fGj2GDQgWBX06AHAJ1x
 DqzstOTLeA8cFfHdFyj/WTWYHDUcCa12YhbkoUsUXNoSQvPgPxxe0Qo+qYP2HBF4RB/Uy49VDp6
 uW76eOMlUT9qTigeR+Se/ZqoZoC+6zQi2lIYpS4uuBl0ZdwvElR6pPNIVUMwYi0eKJacSUiYNCI
 uI6UTBzRk13c4zN5CH+CQ==
X-Received: by 2002:a05:6000:1447:b0:464:8d68:616f with SMTP id
 ffacd0b85a97d-46dc2b0b64bmr27159193f8f.31.1782734442565; 
 Mon, 29 Jun 2026 05:00:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/54] target/arm: Rename isar_feature_aa64_sve_aes
Date: Mon, 29 Jun 2026 12:59:45 +0100
Message-ID: <20260629120032.1645265-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Rename from isar_feature_aa64_sve2_aes to match
the feature name: FEAT_SVE_AES.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260618040718.572950-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/cpu-features.h          | 2 +-
 target/arm/tcg/translate-sve.c     | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 5ea5232a57..2fb7dcd778 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -126,7 +126,7 @@ static uint32_t get_elf_hwcap2(void)
 
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
-    GET_FEATURE_ID(aa64_sve2_aes, ARM_HWCAP2_A64_SVEAES);
+    GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 4887a3a7b7..3479e61a12 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -184,7 +184,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
 
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
-    GET_FEATURE_ID(aa64_sve2_aes, ARM_HWCAP2_A64_SVEAES);
+    GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a80b251589..af843b32d3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1524,7 +1524,7 @@ static inline bool isar_feature_aa64_sve2p2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) >= 3;
 }
 
-static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 63f64796e5..9f0f0e0e12 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8174,14 +8174,14 @@ TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_udot_2h, a, 0)
 
-TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
+TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
-TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
+TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesimc, a->rd, a->rd, 0)
 
-TRANS_FEAT_NONSTREAMING(AESE, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(AESE, aa64_sve_aes, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_aese, a, 0)
-TRANS_FEAT_NONSTREAMING(AESD, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(AESD, aa64_sve_aes, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_aesd, a, 0)
 
 TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
-- 
2.43.0


