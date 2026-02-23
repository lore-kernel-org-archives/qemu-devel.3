Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA38BE98E09
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRDM-0002Yy-Br; Mon, 23 Feb 2026 03:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRDD-0002Sr-82
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRDB-0008Ll-NF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:39 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a871daa98fso28459015ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834956; x=1772439756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBmenqM3WCnGpamf2NpIeChrhVjPkJlu+S3ypFDoHA8=;
 b=TQhVxrwBgoechY3RQ8kpPN6W/CbZfx6RgyBOr8Ufe4+SafjQhx6Ouc4tkYuYkgt9nG
 FEwbYbc6JCIoNxxW+YyVV41YZK4GlBItpzQp/xaz4AhnZT+Zp1Lu+rkLMvia5gJMeSlJ
 UxDPuUwWgsY1a8e+KZDGI7q7l7cveU2/oeqoBPV4erpaLouH3HRRY1t3WDHaBQtZZ/wu
 JS+C7DDQa05YvGKDMGU/Aaqq7KNwIPAkVZ9PdfQG/ldlJRB+rSnof2nKMhG0L+6Rj0EC
 A4Jq96c+IhDRstQegFbLnkagjRkYF7mrWQ1W+VpCCdLPQ+2wwG+n3adlrRgn+Qdy2tFf
 eUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834956; x=1772439756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IBmenqM3WCnGpamf2NpIeChrhVjPkJlu+S3ypFDoHA8=;
 b=b5Urpr4gKOtvaj0c7LXfrIjBQ1+H9hCxw47Ps40msZM2pFCT9KgXo71EwZdCh3q6XH
 rOQ7KSpaZkw6QRChjukMamtTJBnHOHiXek1iyyO6I6i9q3ja+wn89J/4W9gJweYVBjTf
 ZptpCeAflaX4tdFEpt9tom5YzPoBb3K/izG6UKs2nxy+YaTDEUmwltojv8mcR1VciKfD
 R1vHyNxHD2lSmbtSfM9DqRuRnNsaQP8Kz+9+AOy+kaR2iqhI+HkBo22zd0x5lHsArL3G
 89s5dX43jwpovj068kOBlTFGhw6NlXzr5SbeJD2EXHLdRDO+lAKtlOQI+DqL6xcaSuFm
 lVQw==
X-Gm-Message-State: AOJu0YwzroxULT/WIb4C56XZMbwj5gaphseXeOHPsAnI5yyDO7ib44eT
 oD1f1YTkSe5pO4FDT3iUyk1gcIuxAZ25rTnBUfFLb4a3ki2Ufnx66mKBCf4WTiNH4pQeua+b5a3
 IeLA0A78=
X-Gm-Gg: ATEYQzyVS27yx4jiF1iwVNqmEvfp5hLA5waP8IlnJ+6LIexeeRxK4demK8ayiQxN6y7
 5lSP6ZNLn3wm5LqL+cXH4nP4dGeq1LIdQJTO/LKAspms8CR/3y7vUGt7wtA4+OkUQytO4xTgpUB
 FFav8WmcfLyhd74xOUDqX70aaoz3ET8kNwpE+s0JQs99sADNBqFcakpbmXP8xJYeSXrZwmR/0kO
 Me6lgEq76UFlkPQDm20cx7fFk9yErbj+jF3j2jroWO0hDYJ866dh2YRBw7vIl+5MkRZmzv9Tj9U
 05/SpXfZYAWMhwcdLZM90ycRyV7Vcg6gOxQEhApRkOIgsXnkIcr83eSlpvYEenpyIYMe3jbJEvV
 C29gN+7WBeFDteCl8BER1rNSVQgAqYHWOTus4cBQbNJUvoi6E5k1AUtKdFCPYsjQIduRLbQPi8U
 ju/5f/cGIvwCDrPGi7dof/CNK8BV2Lfut1W8JcIgdBH+0S/kT5c+DXi7XyYIeT8u7PeA==
X-Received: by 2002:a17:903:2acc:b0:2a0:9755:2e97 with SMTP id
 d9443c01a7336-2ad7444c497mr78249215ad.15.1771834956230; 
 Mon, 23 Feb 2026 00:22:36 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 9/9] fpu: Add conversion routines for OCP FP4 E2M1
Date: Mon, 23 Feb 2026 19:21:54 +1100
Message-ID: <20260223082154.5623-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Max Chou <max.chou@sifive.com>

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Update for exp_max_kind]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |  1 +
 include/fpu/softfloat.h       |  4 +++-
 fpu/softfloat.c               | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 9c84a101e5..ead146c22d 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -122,6 +122,7 @@ typedef uint16_t bfloat16;
 /*
  * Open Compute Project (OCP) Microscaling Formats
  */
+typedef uint8_t float4_e2m1;
 typedef uint8_t float8_e4m3;
 typedef uint8_t float8_e5m2;
 
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 31d3f76d3f..8389a07b04 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -190,9 +190,11 @@ float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
 /*----------------------------------------------------------------------------
-| OCP FP8 conversion routines.
+| OCP FP{4,8} conversion routines.
 *----------------------------------------------------------------------------*/
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
 float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool sat, float_status *status);
 float8_e4m3 float32_to_float8_e4m3(float32, bool sat, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6e21882ab2..91c34307c8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -574,6 +574,11 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float4_e2m1_params = {
+    FLOAT_PARAMS(2, 1),
+    .exp_max_kind = float_expmax_normal,
+};
+
 static const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .exp_max_kind = float_expmax_e4m3
@@ -641,6 +646,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
+{
+    unpack_raw64(p, &float4_e2m1_params, f);
+}
+
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
     unpack_raw64(p, &float8_e4m3_params, f);
@@ -1709,6 +1719,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
+                                         float_status *s)
+{
+    float4_e2m1_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float4_e2m1_params);
+}
+
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
                                          float_status *s)
 {
@@ -2929,6 +2946,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float4_e2m1_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e4m3_round_pack_canonical(&p, s, false);
+}
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
     FloatParts64 p;
-- 
2.43.0


