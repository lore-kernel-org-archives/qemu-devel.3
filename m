Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86585CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbK-0005g9-KR; Fri, 22 May 2026 14:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbF-0005RH-1K
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:57 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbD-0005d3-FH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:56 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c7b9f54d3deso6468987a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474474; x=1780079274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vaXGPhPcEspPib85CstdsUrhGWg1HWPTQKD0EVWs1c=;
 b=JLFXCla46BU2wgUIVZ/CGFGk240NhEMF4GsXAI4Egb/a8mG30PsnuHhLJlRv9ituUw
 kieIuKazaQCdT+QMfYjh5p8a/ViyEs3oAWe035DykQcMIlhbx59wxTPkNBp//xLohZ6a
 +z69C5Jjhz2lfhXTJbc36gxZC14wMJKlQ5D6yElySQskEF+7fiYJp+0zn1AmUGsHTVSu
 XzSU8/SvGBl8aQX/6wfJ3UARvGSk1RHnPnpQKUIVlREbYAPd2jOku4nYHetY0L13DIqM
 4Odm/DOLnF+DWyJ7b0Sw5gflhydGHoOwiubEqcxrUuXZAyZn8xVMLH8r3KkEG3K1E5mz
 fGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474474; x=1780079274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vaXGPhPcEspPib85CstdsUrhGWg1HWPTQKD0EVWs1c=;
 b=kKArtzggHGGXZd3Ow68mT/s0O3YHyysCMrKe3fyWg6+v4tS7+rdlaBfMN3pSNhiO02
 1JwZcfMRPurLKYAqwL4v+pTf16ga4x11YAP+WZa1kXDs4rb5qz/bAU1JEIRuNM5EoC+i
 wicTo/BldF/w9UgVjg/MOozB9NVLHzcLys0Hb2UXf3jQw5vo4W7+c9fSkFmMItiuwm5a
 u+bflWHvGXJ/ttfZNjkD+Rpkpv+2nzPVst03t207n+I9evlUMhTCzexQIMgLj1HpjLSV
 f4J2npUFPxPaUnob7la8i3VNfdow9AfI3SiYzJbj1vebCluBCQRSPj2kO7w70e2VKJns
 XLTg==
X-Gm-Message-State: AOJu0YxIOt/Q1D+3IXblvMDfBDwpA5mcAI7ddEB7pyX9pvFthHbtpKXe
 4J4Dp+eBVRJKA311+8NtNWoDIrWrX+m3Dfgp7b8N90+t92eXUccNkhA/XpdaXhTOSmDhC1Jm7/P
 al33N
X-Gm-Gg: Acq92OGTZWlESNbcvXl8ODmzeE95kak24scrlfc6I7Ojyb90iwhAsTPdxkZdW0VO18F
 fDpmb83Lkyn3x8Aq7NfA2ghFsFJmwWZTvN+ffQoydlWvRea4mGe2pag74aupBI6dlq9F/iLRF/2
 G8gT5CJo8yAVxGHA9IrbKQ0HyztXM6ja0kdr8oqJXiiiOGpTjeiolUGVH9Smr7gJ5nf5QXfVpLc
 TdFNVB1nHycum+ZiTkQAYZ1T6XLpLSq0ZQ31rO878bLT+fAcqInXtMRP7A1CxBYAnR8A47ZuVdE
 qDO0egs8FzBtObYIYjoKisnAUuffqDOkrbFendYWJAtyxRBxoxqQPf+NuR3B+fZQMn0G5oKkGBS
 j+TLV9B4TFd0NgciNI2bi2ulZ9TcMrM6BcbzdJP4NjNE1hejUteNoETqd6Hv+ptPghSdlKL/2jQ
 H22S/uToVGiwPYODiYz6JsueAQeyO/49rI9GCh+z0=
X-Received: by 2002:a17:903:24c:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2beb0675f69mr49210005ad.39.1779474473592; 
 Fri, 22 May 2026 11:27:53 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 29/30] fpu: Fix NaN encoding for E4M3 in parts64_uncanon
Date: Fri, 22 May 2026 11:26:57 -0700
Message-ID: <20260522182658.184604-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

There is only one NaN fractional encoding for E4M3.  Retain the
incoming sign, but force the outgoing fraction to the unique value.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           |  2 ++
 fpu/softfloat-parts.c.inc | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index be6b02d866..2c3bf01213 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -499,6 +499,8 @@ const FloatFmt float8_e4m3_params = {
 
 /* 110 << frac_shift, with the implicit bit set */
 #define E4M3_NORMAL_FRAC_MAX  0xe000000000000000ull
+/* 111 << frac_shift, no implicit bit */
+#define E4M3_NAN_FRAC         0x7000000000000000ull
 
 const FloatFmt float8_e5m2_params = {
     FLOAT_PARAMS(5, 2)
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 559e40d196..d0064f5d22 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -278,11 +278,16 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
                                           const FloatFmt *fmt, bool saturate)
 {
     assert(N == 64);
+    p->exp = fmt->exp_max;
     if (saturate) {
-        p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
     } else {
-        *p = partsN(default_nan)(s);
+        /*
+         * The class isn't actually used after this point in uncanon,
+         * but for clarity while debugging, don't leave it set to normal.
+         */
+        p->cls = float_class_qnan;
+        p->frac_hi = E4M3_NAN_FRAC;
     }
 }
 
@@ -507,9 +512,24 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
             return;
         case float_class_qnan:
         case float_class_snan:
-            assert(fmt->exp_max_kind != float_expmax_normal);
             p->exp = fmt->exp_max;
-            fracN(shr)(p, fmt->frac_shift);
+            switch (fmt->exp_max_kind) {
+            case float_expmax_e4m3:
+                /*
+                 * There is only one NaN encoding for E4M3, and with a
+                 * conversion from another format, the input NaN fraction
+                 * may not apply.
+                 */
+                assert(N == 64);
+                p->frac_hi = E4M3_NAN_FRAC;
+                /* fall through */
+            case float_expmax_ieee:
+                fracN(shr)(p, fmt->frac_shift);
+                break;
+            case float_expmax_normal:
+            default:
+                g_assert_not_reached();
+            }
             return;
         default:
             break;
-- 
2.43.0


