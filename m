Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB4BE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mj-0007MD-Rp; Thu, 19 Feb 2026 05:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-0007IC-W5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-00064g-2S
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:28 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43621bf67ceso533049f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497258; x=1772102058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f1C6jaV9rVPZltyegP5pK+FRYZqGt2KdDwkRHXIZajo=;
 b=SymmsJgPXZxpYaw6J1k3nw9Lc+zrDQ9xkOIrrPpSDBCngf4YNyjY4NzjGoyX6Tt2kU
 D/MwNQcInzvrCtz5Db/SNLS6C0wBAep/RGNalOXVMxdTO7jvyPITSc7FqxrEGBv1YaiV
 m1Z5Xnhr8eEvwROB9QqZwq2P6maTfA/fLE5GKPtHPgxlkNwZUnCiu9qJCnrazrYrv4nO
 a7yRoU7iI/YxS20XiVgvkabm8jufwOnzidQfXJ/by6qOGj5YOOZF7bW9ogFOObXbP2fr
 Q9dRpunShmQDkUyx/GxLjVutZERDHU63VYIQbnDTp0gm1h7hIIFcZQrHry7o1O6zYx7k
 bioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497258; x=1772102058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f1C6jaV9rVPZltyegP5pK+FRYZqGt2KdDwkRHXIZajo=;
 b=qOWCNkxB9ixQolD3ANluZ21U/Q9+GVbQfprTH6/X6zRcVa651knW5jJU5hPDdNMsac
 TQeHJq36IiJz3HnTAhGsDhLlMB2zrQq83Jxc7tELy9S2AgPWlbrMN1laiysoJETeTdwR
 4/asnKUFpfiQMXMBegDlMEt2UhicnAkacsOqW//bvt2Tfy7vBcBazhiIaGA6dKFbz1Mt
 FGQQqFi8jXGkXLtPX1rBiT2bQfFX0Td7iKvCwNQr99NodkEkZINn31ue3ClNFCvQ+7Ey
 LhoComI7/BMOAyRt3H/Y1OqwEe1S6QgFJ4st3/obecJWLQ38nojafzV+Ik5MAb11TCIg
 hSFQ==
X-Gm-Message-State: AOJu0YzI2I0Fsd3Pow5X2NOdDWFUNxGynl9aHaXluy4MW92rqFs1/gdW
 IzDvy9+1T3rXEhEchzYwT60hVeLEUqmVje2okyI0AMybaApNwrBKLLoJAH+hjp6lYm2/eFQHx6Z
 1XHRB
X-Gm-Gg: AZuq6aKkuSirUrj2hADKPYjoTLQiicwYRc7cygMcza8JA2ykhY/FcMiX2bYkGXrWH/l
 9CjJUjNl6RGGH5ia/vcyQsPiXiIb37k4mNrz54X4toEfIgdPSop/b7ER8C9b2E8BmGpYYxcZq4Q
 X/mToE72Cudf8vz3bucbz6BSTrY4ZvyJaF2k+V5/hLl4SaDlPDyQWn+5NzJLb1V8J4eQfAJQEhS
 5UhZQAA+WULPDK1LwLOUa6A+jK6IvOZ3wHn28R7yQwvTcMkUFQ3oI/FiKrmeNc0+llGZTqWnvY+
 VPxjX9GLAuvuTxRwOxUfLqHXAhU5HsUn1bNIaI+WHH65C9IijPEkiYWA6aexeR5H9cGdbykPx6Y
 KQNTIn3t4X1FwtV4DsCe1ZFgP3Y3bRb3BD6UXbP2u5vUU7eKpTnq4ah+DrCKs1iXAXIGLf6flmN
 J7e9HHMDiWNSgLElNCGy3T1FR2dCD/8gW/8sd0V76d7L3Z6w/AH1DI2lIZKI1UuxumzntmpA7Jw
 UmRshzUkIh5Q9eCrvaVOzcikE6LYbUElOKl4Rgceg==
X-Received: by 2002:a05:600c:4750:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-48379bfd6b6mr278218565e9.23.1771497257516; 
 Thu, 19 Feb 2026 02:34:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] target/arm/tcg: Correct SVE/SME I8MM checks
Date: Thu, 19 Feb 2026 10:33:44 +0000
Message-ID: <20260219103405.3793357-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The I8MM field of ID_AA64ZFR0_EL1 is set when the CPU implements
FEAT_I8MM and either FEAT_SVE or FEAT_SME. Currently we assume
that it is only set for FEAT_SVE. Update the feature checks:
 * we rename the existing feature check function to sve_sme_i8mm
   to indicate that it is true for either SVE or SME I8MM
 * we add a new check function for FEAT_SVE && FEAT_I8MM (giving
   it the sve_i8mm name that the old function used to have)
 * the instructions which are (SVE || SME) && I8MM need their
   checks updating to sve_sme_i8mm: these are SUDOT, USDOT
 * instructions which are SVE && I8MM (i.e. really SVE-only) stay
   unchanged with sve_i8mm: these are SMMLA, USMMLA, UMMLA

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-12-peter.maydell@linaro.org
---
 target/arm/cpu-features.h      | 8 +++++++-
 target/arm/tcg/translate-sve.c | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6935ef2f78..40eb8cef17 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1464,7 +1464,8 @@ static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SM4) != 0;
 }
 
-static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
+/* Note that this is true if either SVE or SME are implemented with I8MM */
+static inline bool isar_feature_aa64_sme_sve_i8mm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, I8MM) != 0;
 }
@@ -1557,6 +1558,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 44eda7b07d..53d35f6de9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3758,9 +3758,9 @@ TRANS_FEAT(UDOT_zzxw_4s, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
 TRANS_FEAT(UDOT_zzxw_4d, aa64_sme_or_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4h, a)
 
-TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SUDOT_zzxw_4s, aa64_sme_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sudot_idx_4b, a)
-TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(USDOT_zzxw_4s, aa64_sme_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
 TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
@@ -7778,7 +7778,7 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
 TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sme_or_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
-TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT(USDOT_zzzz_4s, aa64_sme_sve_i8mm, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_usdot_4b, a, 0)
 
 TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
-- 
2.43.0


