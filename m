Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9884E73170
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu4J-0007CS-Pm; Mon, 02 Feb 2026 08:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4F-00075s-LR
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4B-0002hc-89
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso37133235e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039250; x=1770644050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wb6+lM6pydrnwcLmZGcqj6kVPeiLe8pR1QP6em9mlF8=;
 b=AOpyN+Zjk9hvyRhDUJnmafdGsxWmvSsAdEdQCoXr1Fwgza6Oo0Xpbw7R/is1khmfUO
 UGb5pF5YAa8ewYEUymZeS6ySkmD+UBfZAEhXGiDu2BciheqOtKK0DlrOkCnZMmaAjcxz
 YCttxf1nw6ssg+9TsCgzB3GuLSM9caTxacTiasDJLgd0/LT7WPakV4H6A191rRF92gVa
 BRnshXaaWXIKtA2kXsKDogLNhgV9sgtZSBPUn04zxkOn2fn65Dr2QWebfQVS8bl1y1F4
 ywyyrhIr9JXQe3N9MtFxHFyVlqRuHroxVzvSGRS4Z6rPeuLCDdXazDddHX5PZymys/my
 feGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039250; x=1770644050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wb6+lM6pydrnwcLmZGcqj6kVPeiLe8pR1QP6em9mlF8=;
 b=cXy5cDmkR9cR64EpiQYR/8UFX3J3BiBKl2ebGctoePo44dYBXOIRfaxpj42KpIQUOe
 ga8SkkfCk1I9qP41mKs9tS20HEA1LZS3SqMjI7+YHk1wmiENRbKGByZBMaoJl0F0kzio
 F98JjZPKZyu3kgtZDRMMO5vVk27QFxYtd/pk6HV+3DF1bvKEzrOZL3qioH19CqYahK3c
 as8dA3PIxj1YcAn0Q9jfKhLn77HDcl8Kf/7s54pyDMV3io+OQ5AulkPisD8ZC0YVswXo
 H0nx1chOHfHipBB0tyN/W/pIXlvQQA1yuxUiI90jqpH5yDddqQfKUfDcEjn6/RpMQm3b
 clIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXScmjbbb0gFroPS5YFrc2f4Sew0n6cu9uHWeoMY8WJeWSqRMvpytwoYWD+2w31kuvfCIh6hvwofYJW@nongnu.org
X-Gm-Message-State: AOJu0Yx11J+4LtxjbZCtUGn1Sd7NL+f2H0OvftZE4aIMhHBEXhKL7P+f
 R/AmnzYLZeOQrYncb1VB1dEz+YzlwVJDD8kpJycOtSTWAK5Icmjb0+nihONO96SCCF4=
X-Gm-Gg: AZuq6aIet1+V9oXwSVdypZEPygVvEphSkqOqgOvzjZB2440rs5W7dlt0mCBIcgP59kP
 rF7XxJjWBFJIvOff3MMHSIcvydFfUF9L197q5Dwn6eK6Ia1e7YiPoZuDtRFHU4KNftXi6boA40c
 zYNKY8WdHI0EI7vnFm3YQg8pqqsQcu6qU1YqGQiGF5u8SRTAK0iD2UyNls+suCg/AZG/6rayC5O
 jTQQmAMCoq+6PnxzkT7t0YeA5DmXU+WyXULcxbkt42hPx+E3r0/ma5H9lrzy5Hl/7V+Q6nBlLfL
 4zq2Av7W4u2+8En6ctYq/HMi4dQTmFcenBJn7agJD2NvmoDISvZZpT6Ut6MR5hujSiw3jt/nNyL
 xvxuD64MrWKtP/ZLHtJCn5RaXxc5QyRNbMyuHbwruageIxlx/jXamUCB/G4FT+HaJilNmLbRW3i
 2E/t/M08jsFzWannldtse9E75Exfx1og==
X-Received: by 2002:a05:600c:19cc:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-482db4563b7mr156150385e9.14.1770039249839; 
 Mon, 02 Feb 2026 05:34:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 12/15] target/arm/tcg: Correct SVE/SME BF16 checks
Date: Mon,  2 Feb 2026 13:33:50 +0000
Message-ID: <20260202133353.2231685-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

As with I8MM, the BF16 field of ID_AA64ZFR0_EL1 is set when the
CPU implements FEAT_BF16 and either FEAT_SVE or FEAT_SME, so
we need to have separate checks for "(SVE || SME) && BF16"
and "SVE && BF16". Follow the same pattern as with I8MM:

 * aa64_sve_sme_bf16 means (SVE || SME) && BF16
 * aa64_sve_bf16 means (SVE && BF16)

BFMMLA is the only SVE BF16 insn that isn't in SME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  7 ++++++-
 target/arm/tcg/translate-sve.c | 16 ++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8b8de5db04..1bcf28ab08 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1434,7 +1434,7 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BITPERM) != 0;
 }
 
-static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sme_sve_bf16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BFLOAT16) != 0;
 }
@@ -1548,6 +1548,11 @@ static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
 }
 
+static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 53d35f6de9..956ddee123 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4430,7 +4430,7 @@ TRANS_FEAT(FCVT_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVT_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
@@ -7818,7 +7818,7 @@ TRANS_FEAT(FCVTNT_sh, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVTNT_ds, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
@@ -7875,9 +7875,9 @@ TRANS_FEAT(FDOT_zzzz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzzz,
 TRANS_FEAT(FDOT_zzxz, aa64_sme2_or_sve2p1, gen_gvec_env_arg_zzxz,
            gen_helper_sme2_fdot_idx_h, a)
 
-TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
+TRANS_FEAT(BFDOT_zzzz, aa64_sme_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
-TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
+TRANS_FEAT(BFDOT_zzxz, aa64_sme_sve_bf16, gen_gvec_env_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
 
 TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
@@ -7890,8 +7890,8 @@ static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
                               s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
-TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
-TRANS_FEAT(BFMLALT_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, true)
+TRANS_FEAT(BFMLALB_zzzw, aa64_sme_sve_bf16, do_BFMLAL_zzzw, a, false)
+TRANS_FEAT(BFMLALT_zzzw, aa64_sme_sve_bf16, do_BFMLAL_zzzw, a, true)
 
 static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 {
@@ -7901,8 +7901,8 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
                               s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
-TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-TRANS_FEAT(BFMLALT_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, true)
+TRANS_FEAT(BFMLALB_zzxw, aa64_sme_sve_bf16, do_BFMLAL_zzxw, a, false)
+TRANS_FEAT(BFMLALT_zzxw, aa64_sme_sve_bf16, do_BFMLAL_zzxw, a, true)
 
 static bool do_BFMLSL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
-- 
2.43.0


