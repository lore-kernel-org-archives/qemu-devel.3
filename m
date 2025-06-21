Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA65C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z3-00056B-OL; Sat, 21 Jun 2025 19:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z1-000540-RP
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z0-0004Sz-6V
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2537410b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549849; x=1751154649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=05jes30QjbJSb+isjiELnMuGCwR9QpLL588UWezAIlE=;
 b=QbhmQ3M7s9HOxWTyN/LA/fBDqLKcelB857w/3ny29fbqIOMB08OwonbRu3ndYVKMHU
 bP/tIZes2POq+zexJhNy4GzRvdY25+nHAdHhmaQVx7UmgB6sAlVEvc0rDW4UpzT/ZtHq
 zQ0xzym94iW0KfmeegWGtAHrg9fTRmUAQ3vhGMV4xpLpJ1Gqze5OdXuCWJcSU3Mk59Lv
 DY1TtPiF2P7qF/CNekOxGfrnbDKNttyVkoLvgSxbYPK97keapJTvoNenXnz4UgZVaTbh
 ej8miebfTh77q6F7qMTd1d6j5BcKTk6O9yoY7O2H9iuO+fb7vawnbdvZKvvIL/rQgkwy
 0GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549849; x=1751154649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05jes30QjbJSb+isjiELnMuGCwR9QpLL588UWezAIlE=;
 b=MD8e9Bb1zIMetpjhPwJvCYcaxQ/8HNEfRwOMMm2crBDVJKGwMfaDK+s7FCWvzJ53fN
 LB6BjAVXL0MpXEz9HFOXyBhYsC7Nhxjv181vwyByYJMCjjMaRa/1DxLChhYVdDfAd2I/
 tpB0i1FRdRZzhwuZHX2QhMXVy4eFyXrJN7k8AOZWB/4NyBcc4DCJfGGJosnbMssYa+CY
 TDyFL1T1OE0qQn/dhz8tdQgGYgPTFQZ0uMVZ9ouZnQVeccOQJt2q8xRHNwkE0MZYTyJL
 /GC+HhupxBZrZWRvGUVvprPDbYhaJekMalNer5e1/0Vaqg8RcfMn1khfQx26s3Mbg/6M
 74QA==
X-Gm-Message-State: AOJu0YwLV5p8yYkuGDkDuV1k/24OQYlA7y/IbhhOuCgKblcgZhGKs9oR
 9uJ39ykPyKRAutC3ETjDbBwgpyifygN48T78qx/7V4tSN4LrJ0Un2HmaJpim0Zi2ttia+eqONkx
 k83j7
X-Gm-Gg: ASbGncvZZjRBqrhMoGcMlA8sUJFBUn5bqZZ9MDArteyfyicWPnG/NLMRu/5doDyP986
 kBrwQePj+fe5uajKHPay5va+LZfDfueOQjchV7Qm5a5wFn94FvFaATdb1N4T2DdVoenaoJ/K7E0
 dYF58PlHAFFtA5HD+jXUNfOL4CK4o+clH14P8Nhyu2Xe3rflHvdAZOzAKQTEqJfB/mqVg234f1t
 6c6PibP0K7BwbP1tt0zEV29C5jlufJuDS/9I1ucshd4qxngh32rpR61npOwx9NmI2ZuLIkOjS6g
 R9iWuC0lJUpQ5w0CL22aY7YTjvgWgrjmMZSZotU37T2PHZcNzLIWtKrijLgXvCJBqay/cpoI5O9
 xbnuY1WhvY77w9BqfMio8
X-Google-Smtp-Source: AGHT+IEXvKhjc/VLioA24YHeSmK/CQrX5lZ981MJOKc99QhENDqSvkbNK0Dnb3eslda86UiVWugclw==
X-Received: by 2002:a05:6a00:2d06:b0:748:68dd:eb8c with SMTP id
 d2e1a72fcca58-7490d7a9aa3mr11034646b3a.23.1750549848844; 
 Sat, 21 Jun 2025 16:50:48 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 015/101] target/arm: Add isar feature tests for SME2, SVE2p1
Date: Sat, 21 Jun 2025 16:49:11 -0700
Message-ID: <20250621235037.74091-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4452e7c21e..650abcb054 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -931,6 +931,11 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
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
@@ -976,6 +981,11 @@ static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, B16B16) != 0;
+}
+
 static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F64F64);
@@ -991,6 +1001,51 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
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
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
-- 
2.43.0


