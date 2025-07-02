Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEDC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfc-0007T9-67; Wed, 02 Jul 2025 08:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfX-0007QY-Ha
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:31 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfO-0000vZ-0X
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:31 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso2467588fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459658; x=1752064458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRXJMgeeVVCv0nE8CT0UrRZMnHKW8fzexT57UrsofhA=;
 b=J87s0qOPp4s7xDd9Xb8plgKuzFcWlHehkL3/xXwt5334Z0yIM9yxHKtmruAx02YWYK
 TUF0uI7f0k/kIL4pkE5IHop68YpgNpFIvE64/LcvHi6Q/Ea+yTLv6nXtebXv1Jpir97B
 uaGZlw5f6SJck6B3bBQqGhvhYmvZvSLKaCbFHkdn6O6PRnXVzGHJBHIpgEnkLS1DQ7Qp
 pnEjnV71qOZI9OV6HqZRMHu9B2bGQAjXHVWIt+YG6EVwhoHUNeKGWOHOYrMgRDofDml8
 Gy/cTA8dqWqrhOb6yLCOkN4wusS0aHkryWx8fpHOuR1vyw5EbPtBR+VkXqG3lLua4kc8
 BylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459658; x=1752064458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRXJMgeeVVCv0nE8CT0UrRZMnHKW8fzexT57UrsofhA=;
 b=g6pJ7mbCBwhhIS3y1gCfi170jZv6FJ1qRsw5ny8POLvF5vIrIUfkbygYFQk1ReG4nQ
 rALOU+d5hNs8uc6L3zMUs0K39iSA0hRHiluK8/V7+SLZbH9NtPOa+V6qg2N7CZOg6Pbn
 gwTU4HGIaNB9WP/yslcIW/KaJid7okXmBA5Sst8vmye96zCiBwhQLmJODP4TTzwgWnIu
 DI9ey4lf2oT+IHFTOT8QZADJvof7Ujdycrw4n4dCsQ7pPq867iPNMOxvy7vvgiajZoXt
 IUZeiJMcRG7CWZwmYvelGJ7r1H5ufs+im03BVKMbh3l2xcnkZ30Esu4lHD3Kct2YxQPl
 dQbg==
X-Gm-Message-State: AOJu0YzyYCAsBjTAmblPjIgqsFVCDxFrLNx45SyumOZXiPGu/qWwBKHu
 IibJLanoMzqckKSkx4SK7PyZG/p2wryofItQgPQZNtxjKpGKbklDxiWuMYnA0ZBm1zBJGDPEbGO
 9K2IRB0o=
X-Gm-Gg: ASbGnctlbLuR6sOvxAjokItvQ3new7pT7Qt6Uxt02ShemVjFb57u4s9UkS+8ZdRHsXj
 RyU03rcv95K+SOVL+JmCWo4i1oJo6MvNZp0awuM+msaDbK1B+CCZHrQasiKOqwuyrvL0ZyP4P7t
 DwObiKecwJ055aoNQ3aPkp+mIMRZ4wmlZP3ZCG7uq0qtF/Fk+5gCAcnmRWzimQIK3Zm3XRV1m5w
 AK5Nmv1GmviCofUsCVEqzJia78BT9BKG1bRvB6YzwnrH/yn6bRbESWORhh9ED7XT4P46RDrFaDB
 moh7iwQEqnFLDq8txW80PYaUIhfJDoNgte0EZo9z5n0r0AmqhqGBSyPHZcrbjrF6Lqc0oA==
X-Google-Smtp-Source: AGHT+IE79kv1nLyn7kStDd9dKtJNzJvqNFsQPJa71p3C2bX/4g0Q1tk61/6JYTDhth4yBh0bmuWgbA==
X-Received: by 2002:a05:6870:7092:b0:2d4:d9d6:c8cf with SMTP id
 586e51a60fabf-2f5a8d299bbmr2106907fac.5.1751459658214; 
 Wed, 02 Jul 2025 05:34:18 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 04/97] target/arm: Add isar feature tests for SME2p1, SVE2p1
Date: Wed,  2 Jul 2025 06:32:37 -0600
Message-ID: <20250702123410.761208-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 63 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h          |  1 +
 2 files changed, 64 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4452e7c21e..f1afb9093b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -603,6 +603,11 @@ static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, RPRES);
 }
 
+static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, LUT) != 0;
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
@@ -931,6 +936,11 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2p1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) >= 2;
+}
+
 static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
@@ -976,6 +986,21 @@ static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, B16B16) != 0;
+}
+
+static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, B16B16) != 0;
+}
+
+static inline bool isar_feature_aa64_sme_f16f16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F16F16) != 0;
+}
+
 static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F64F64);
@@ -991,6 +1016,44 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, SMEVER) != 0;
+}
+
+static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, SMEVER) >= 2;
+}
+
+/*
+ * Combinations of feature tests, for ease of use with TRANS_FEAT.
+ */
+static inline bool isar_feature_aa64_sme_or_sve2p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2p1(id);
+}
+
+static inline bool isar_feature_aa64_sme2_or_sve2p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) || isar_feature_aa64_sve2p1(id);
+}
+
+static inline bool isar_feature_aa64_sme2p1_or_sve2p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2p1(id) || isar_feature_aa64_sve2p1(id);
+}
+
+static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
+}
+
+static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 052ca20283..a6a54a605a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2195,6 +2195,7 @@ FIELD(ID_AA64ISAR2, SYSINSTR_128, 36, 4)
 FIELD(ID_AA64ISAR2, PRFMSLC, 40, 4)
 FIELD(ID_AA64ISAR2, RPRFM, 48, 4)
 FIELD(ID_AA64ISAR2, CSSC, 52, 4)
+FIELD(ID_AA64ISAR2, LUT, 56, 4)
 FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
 
 FIELD(ID_AA64PFR0, EL0, 0, 4)
-- 
2.43.0


