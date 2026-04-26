Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C71FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzk8-0000HU-Ma; Sun, 26 Apr 2026 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjt-0008QE-JC
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjq-0000Iv-Uo
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso35013515ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210893; x=1777815693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftntJNMSr0Al9uQHHp51tG7x8A4jpjGmGU9o5FpGbUc=;
 b=WsvWDXRczsCfsmoMmK9kBL5Pri/PG+uZ7Tbxf5STWhQj5zcSBYQX79QTaAAQhm9EBY
 UV7JNqbAZE8Od5uZFmah74JR2oI45SvJhLEDhJbGrAimOxqaStLfpYXIaXXk/+LcB43P
 1WTd4JMAwdevSsyc85nfMNmX8K639ckWZwtUenxWkoOcDE1TunpV3yeKdLJnGtndhVNj
 cSE5DGWd8X1M0AG3L/0uqDA9aTyZuyw0InZWz8RiROo47Rv42f7oevmIqH+qXg1b9ofD
 8/CP8sn/5KzOa8HbRRMS0R1fDGhbIxdjqiI69oT2Q0+1Vi9hi+3vVbYjDQf5BUxHXhax
 1m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210893; x=1777815693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ftntJNMSr0Al9uQHHp51tG7x8A4jpjGmGU9o5FpGbUc=;
 b=GqT+siQbqlfKYx79R2e2Xzb2wm0+a6IiNghOkzJZaJY60jNspemcx4keodF0JOpwb3
 ZZRkMAyUKhl1mNAOivJlPCa3kGKhLkBan2pIS1djULflHudFSQp/UHLrSluiQkTdMBm4
 Z4NWqxhnWlPV1hFDa8c3IHUM8ubgPI68MXnhOGnPE8gNifM2LHYLUx2PMXKpnkow/Goa
 AXrgbde7YuKPTixra4kxiXTUxNIGb+EZzSabUBuvmSYyREccmTv6pTQpq+VwT4O9aVkJ
 0sFKX+2EXWHXDhrI8SNZNsnPYXp5CWRgzvY88UgfJw7iTrEsAr+8t4HJhS+EqQdw1mpE
 5eOA==
X-Gm-Message-State: AOJu0Yx6PIn+lZBy58xlFN+x/SBzeNqdUfwZocKsB57d4miDR3xAjrKy
 3ZdjQnUMfuSN8gWNzfHM4htRfHAYZ1WhhkEMxKI9wI3yMt2SHodldh1UJj8hw9sm6O/LGzjTc76
 EXw1fGhg=
X-Gm-Gg: AeBDiet6ks4UAnuld9ZPea+5kcOsRLNNSIMo1R3yDDLkHjtknYNfj+xz8i0mLix6QlL
 N/sp2wllI3+e/dKFT2IZuXB+m474HzYKGPqZn0nYgJWArrKWC48tbMhi1G9cRKHv2GbuNR4Nt2z
 wCmA96G2W8N5ILWTBC2Ea/3lhpk9Ywd0RDspo/XukBmW6DESKWSKToEowzswVdBMssaG6MPS/AM
 e6PuPI0BZrrY9xLODDms+TDVPAsXaFzu73TwkPRZ4EVtI6IfIe5Hocn0rQKuNpXQHAUy63pR6Ru
 pYhBZKqtjsIW/oxdFLTGDsmp79Kkfdy8EkZtey5MBmQx2KBQTgz4B4bjWqHJCnM8ih82sciEcxg
 52pWb/hpyCQerfAGVM0Q5MI/OIGrIknznYtrAglKuo1YFiOHFTmcjAF9YZV4ByY1+7uckPJ/8Hp
 Ys//Ss4srga8sZJC1jSWs9j3RA/hVvuiizEP+19imu
X-Received: by 2002:a17:902:cec6:b0:2b2:49a7:a5ca with SMTP id
 d9443c01a7336-2b5f9e8f561mr402948115ad.5.1777210892321; 
 Sun, 26 Apr 2026 06:41:32 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 32/84] fpu: Return structure from unpack_raw64
Date: Sun, 26 Apr 2026 23:39:09 +1000
Message-ID: <20260426134002.865628-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6cca31af30..99b1cce894 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -633,12 +633,12 @@ static const FloatFmt floatx80_params[3] = {
 };
 
 /* Unpack a float to parts, but do not canonicalize.  */
-static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
+static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
 
-    *r = (FloatParts64) {
+    return (FloatParts64) {
         .cls = float_class_unclassified,
         .sign = extract64(raw, f_size + e_size, 1),
         .exp = extract64(raw, f_size, e_size),
@@ -648,37 +648,37 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
 
 static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
 {
-    unpack_raw64(p, &float4_e2m1_params, f);
+    *p = unpack_raw64(&float4_e2m1_params, f);
 }
 
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
-    unpack_raw64(p, &float8_e4m3_params, f);
+    *p = unpack_raw64(&float8_e4m3_params, f);
 }
 
 static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
 {
-    unpack_raw64(p, &float8_e5m2_params, f);
+    *p = unpack_raw64(&float8_e5m2_params, f);
 }
 
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
-    unpack_raw64(p, &float16_params, f);
+    *p = unpack_raw64(&float16_params, f);
 }
 
 static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
 {
-    unpack_raw64(p, &bfloat16_params, f);
+    *p = unpack_raw64(&bfloat16_params, f);
 }
 
 static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
 {
-    unpack_raw64(p, &float32_params, f);
+    *p = unpack_raw64(&float32_params, f);
 }
 
 static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
 {
-    unpack_raw64(p, &float64_params, f);
+    *p = unpack_raw64(&float64_params, f);
 }
 
 static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
-- 
2.43.0


