Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1CDC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80R-0007Iy-3A; Thu, 06 Feb 2025 14:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg808-0007BZ-To
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:29 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg807-0000UJ-72
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:28 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f49837d36so8234835ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871846; x=1739476646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5OnYjU6bDZdIf9DMwSFEWlUN2+/QNMerChlgqp1dLo=;
 b=iv/JDB2mRaqkvYmu5kzua8qt7Twwde8LQn81Mtlx4uo4OKRG34WUC2NpjFnSfaAyW9
 YlNnWKI0FhoZg4aY3ptYI6LeqVsJOb1h1K7iburG8JEKYy8P6lrQcl3uHbW0TurHanLH
 ejQxtZs+gyRTgmFUDrPdal59BXqwOyY8GDHp/WY6xg1sM3+DwZWr6yiTUgOo1/EjE//R
 olLuJiYQt6Ka8/MjeqeOLfEO0Kh0mB6/WYnyoAz4MSr6dCMxayKCsweQEtsbLBwl5LgI
 OfXZj06HU/75sB1oIukWadfmh6xW6bgHkWmAvs+6S00Mec+F0NWIDCsYK9fsrwfN9498
 +FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871846; x=1739476646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5OnYjU6bDZdIf9DMwSFEWlUN2+/QNMerChlgqp1dLo=;
 b=tX/PkdLcr3fyQVJoIUW/vzq5RYSQokYNFXInsOjOVAPHPvi4FE5R+fdARN/H8FEGkJ
 vd03oIZk6c+2XE6QKiddImCLrHY/PrZB5v2RTKkTMqrcc+W/36K2YpHgEhf6Ppbdu/8v
 46rj3UPgiwFsjaZQEGCgvfGpeB4ZbGzcibboQswD/StpfA3SJnborsD4fpUHChCVaUV5
 zPTwCtsBZg6pHlfLcCrnweC/uD1qd16ZLh0E5xX4TTheFHnkCKbi++NyH9IIHuKjWZYZ
 vwqFdHsETbij3eVlmxfeBCexaX0UI2MkXKoUQTwkM1ztNlCE0HbXvHfftXMUyugKDryr
 PH4A==
X-Gm-Message-State: AOJu0YzdT3Atk+UXR976xINJ3Xa1DnQ2eCGMWr/v6lPoX+GrSM+0xwL6
 LW/OMt10NslGoOfNolAXXrjmKPaK9LZ3mA9edfptH/k01oIlFqaxPS0w+4o0MVEAilsCP90gh9P
 t
X-Gm-Gg: ASbGnct3UGU7U8QHqO0/8N8PwzMjHxBsSFfIrqoBiyOdNOQqX7etjSOj5S+rRJDC/+A
 C8udSWSkOuIeqs41zxYXOpgTatiz/QQFQUYmffPTzMv2V5kCLFsiMH7TyAsxLJ7NbvoCwRqI4Zv
 HiSuaK0XUCIxp1Dt/D0Z172al2CmAW8X4TjRRkP0mjlsHncTj+GyTWnXQRddxzNPFvy6yJ0iF+q
 TkMEtrW7Uo2VD8eaFhVfOJTsy2m3EHWiwzd9qPLfF9FmtZsULgbtpieo6Iu8HgIDj0W5lBWTUvw
 WZAda4dqY4GGHwkB+aK1vb201LRrA/ZeCL1v7Ep711J59ZE=
X-Google-Smtp-Source: AGHT+IH0RrBl1aXrmncgx6FSLJNK7N4LGondb6QtNiNTLvHB57qFQM+coGsMT9LmL5EzPHDlh+cBAg==
X-Received: by 2002:a05:6a21:9011:b0:1db:e536:158e with SMTP id
 adf61e73a8af0-1ee03a8f46fmr1240893637.22.1738871845667; 
 Thu, 06 Feb 2025 11:57:25 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/61] target/arm: Add isar_feature_aa64_sme2*
Date: Thu,  6 Feb 2025 11:56:26 -0800
Message-ID: <20250206195715.2150758-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/cpu-features.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 525e4cee12..5383d6b2d7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -930,6 +930,11 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
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
@@ -990,6 +995,36 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
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
+static inline bool isar_feature_aa64_sme2_b16b16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, B16B16) != 0;
+}
+
+static inline bool isar_feature_aa64_sme2_f16f16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F16F16) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
-- 
2.43.0


