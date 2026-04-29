Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751A0FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLs-0000jO-IS; Wed, 29 Apr 2026 18:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLr-0000ce-BN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:51 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLp-00057E-8N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:50 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso151212a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501547; x=1778106347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhFqGDtxehCmCCSHm32/bhsUWFUsTM8ZpSgycIpHvuM=;
 b=IxZxDqfFy/CktAYGOahohN6PzcyeTdNHfTmvaO4VHrMccTWqzz5lrD5edNMfW3tPD/
 fFZXRpTxaQq0MCDjQaIEV52P8cmsTLvrE/bb5c1CwtUKv+o00GHbdaoDNJlOiyloH9E+
 C/ChDYTscSHYXvVgWNcGaRNsS7VkuLSMdrvfy2Rj7dEnTxvCjwzNYiYdxj5BLHxMKi+i
 tmhAxZcFbQU2X5GxU9iSiOtxta8UQLtfNbrEoN1e9+GP9+ifaSjE19I3xlzfCNaHCMIL
 b0pWluHj5++FpUhnMnPBzPAXgxb7spabIZm/jdspGUrDUuQ6WubXATEp2qCdMhwoHY8C
 eI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501547; x=1778106347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vhFqGDtxehCmCCSHm32/bhsUWFUsTM8ZpSgycIpHvuM=;
 b=czYblbPASOcEzsWYh8BS4onHvpZ9l4LDTQQ/y4t6vk/tlKKabUT3nc9E1ieaQzyFN4
 ekoQ0tWTU1KLoMOJ9Wezptr1rJ2LfSMd1mm7zY4XHO4MCdBEq2vgDB3RliynaPlAOBZ/
 mCUB3yLkxHTItljFoKMA+j+9ayo/R+MmEFirXPW4/Jp3zPddF3BuvBw0CM6E2vK+S2az
 VcoafxvQJvHMgWh3e2dPr/J+bzodGSLh7Syc9Sv7xDMbSbhnpoSx8K93PZ0zbIMTnDD7
 svf48t1iHSHiK2uFv3ox7klCiCCxJcwUsPGzxVcJbQ5rjp2JsCz4HHYzks9Nn/dz4S9u
 ToQQ==
X-Gm-Message-State: AOJu0YyEEJ34kwTFVZTs//R4nFAtSqG4IlNwSBH/ZHDDkQO2e/yxRfb6
 /DeyUofgJOwtUG4aOKsJzEDWLoo298P+l8LVwJ0TMDQgGodSxrMtyDWCXGxjVCr3W/a1k/NJwkz
 xXOUtE6Y=
X-Gm-Gg: AeBDieuBxDY07kFMg0XmsHRRd9IdyAJeXMR9JP5iBRFpKt6DxAGr9cwkwcYvPHz4V4b
 xMaXUy26Rw+VZt89B6wHr+xk2EPWH2vHqFjB1BlD1NlNNgVebu+5E8Kptn8GjrBYDbAob0vuLHl
 eGFI86WlbFJFeABXHYXVYOAE3NXkD7+CwtIEZt37/Fc1jbt63uwAP8VDlA/PDRvIaVZ9p7Uaa4P
 84bOu31NhkqXEokwcE/nd/v1arXW1+Wnw4V7kX2rqYpBbLdBELL185gHDZ30pnJ5mcJjC2JJ5Hs
 K51GZ1l6X6C/5kOdfz1704gPXMNbkzaIlkuq0ra5NpZR1xxqzMfE5hXCZXbyadhRgtSHQniiAQS
 ai2pIZGNnnKlOi309k14/JGhxp49kHFAQ0y3SAeb0cAe2txwAsSXZcxdgLJ7B9t/mJYSNxIiqD2
 muc+VjkuAlZs3abo7tDXYLVxda7AcWhQll+FR57Q9kWwcMzVoVQuQ=
X-Received: by 2002:a17:90b:4a87:b0:35f:b5df:453 with SMTP id
 98e67ed59e1d1-364c30ed44dmr186177a91.22.1777501547509; 
 Wed, 29 Apr 2026 15:25:47 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/48] fpu: Drop parts_sint_to_float
Date: Thu, 30 Apr 2026 08:24:19 +1000
Message-ID: <20260429222445.26301-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Use parts{64,128}_sint_to_float at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 18 +++++-------------
 fpu/softfloat-parts.c.inc |  2 +-
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0b2638c34b..bbfdf1a076 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_sint_to_float(FloatParts64 *p, int64_t a,
-                                  int scale, float_status *s);
-static void parts128_sint_to_float(FloatParts128 *p, int64_t a,
-                                   int scale, float_status *s);
-
-#define parts_sint_to_float(P, I, Z, S) \
-    PARTS_GENERIC_64_128(sint_to_float, P)(P, I, Z, S)
-
 static void parts64_uint_to_float(FloatParts64 *p, uint64_t a,
                                   int scale, float_status *s);
 static void parts128_uint_to_float(FloatParts128 *p, uint64_t a,
@@ -4013,7 +4005,7 @@ float16 int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts64 p;
 
-    parts_sint_to_float(&p, a, scale, status);
+    parts64_sint_to_float(&p, a, scale, status);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4098,7 +4090,7 @@ float64 int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
         return ur.s;
     }
 
-    parts_sint_to_float(&p, a, scale, status);
+    parts64_sint_to_float(&p, a, scale, status);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4131,7 +4123,7 @@ bfloat16 int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts64 p;
 
-    parts_sint_to_float(&p, a, scale, status);
+    parts64_sint_to_float(&p, a, scale, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4203,7 +4195,7 @@ float128 int64_to_float128(int64_t a, float_status *status)
 {
     FloatParts128 p;
 
-    parts_sint_to_float(&p, a, 0, status);
+    parts128_sint_to_float(&p, a, 0, status);
     return float128_round_pack_canonical(&p, status);
 }
 
@@ -4216,7 +4208,7 @@ floatx80 int64_to_floatx80(int64_t a, float_status *status)
 {
     FloatParts128 p;
 
-    parts_sint_to_float(&p, a, 0, status);
+    parts128_sint_to_float(&p, a, 0, status);
     return floatx80_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d8eb9f5b78..8405cf29cd 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1779,7 +1779,7 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
     r |= (a1 || a0 & ~DECOMPOSED_IMPLICIT_BIT);
 
  exact:
-    parts_sint_to_float(a, a_exp, 0, s);
+    partsN(sint_to_float)(a, a_exp, 0, s);
     if (r == 0) {
         return;
     }
-- 
2.43.0


