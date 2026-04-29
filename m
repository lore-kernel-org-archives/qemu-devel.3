Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C736CFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMK-0002w7-6x; Wed, 29 Apr 2026 18:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMI-0002hJ-Jv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:18 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMG-0005Gp-Vq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:18 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35fb166b0c6so737194a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501575; x=1778106375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O4hKnrM8IFMNxLNYNqBPp5uIxhITOfd/CNA0UapkwA=;
 b=c+Qls06mKIvA6OKpaUIGg9JSLpqCtAeQP9eerTgp5Memp2Qnb0Y6MWWXmyfGxdJgiY
 Uz25IZ760ePGskruOvr7y5IvfW7MHGzL6y07/xRB9o1F6jd6xA6v9INctzVIaGWd0Emq
 rFIo1v1k+uj4ayrqiqG0mBqN14ysYvTN+gw//righnPMMEATxCA6joEF+e6BFa8vWez/
 TK9B9MB36zATxij3Ur1oKrby2fVSV+S5kU0hnhXXj5IJFP9VSZs5b3jkftkCmhzGaTyI
 59jiyH2Jrs2ky+PEh3qFVKd5lkFlahZUIOOgd3N7B13pCoCBbZTbpxIHk3oAF+wn380Y
 3oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501575; x=1778106375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7O4hKnrM8IFMNxLNYNqBPp5uIxhITOfd/CNA0UapkwA=;
 b=KcaO0YWtOJJhM45T8XGdPeIFzaxSgbWaYVtgC2Z0pxdBEOYP4lSFaBY1YaEIsRyizs
 IbTQznp/+OgvAu5zrU0ZQW+ErjbUNfy1p/2ef5Zq5P/fDZ6uCOD8WhzAwMVDI60WjZ9L
 KgYfdViFPZQrTZtU++XESSTHORtAqbDtQKr63AY/VTHwefXTDre29+IVF4SvyWIuZIqn
 f3/uk931G0B6lt87rEA3OztOyZ+wCLlitC3y86D/39XrVHuB8Pv63b3XVH+fPcR0mzOk
 MsL2yFSMl45f4i9U01RnwCGbYza8IRbWzrATS2py2euaSTLSt4FrnxMG5eldBZOBwoGq
 0Fbw==
X-Gm-Message-State: AOJu0Yz287gL1z8vh00hNom9zDExkOmtotsuzshu8isjTc/FsB/fsFQN
 VrwQTiBRiF0B6f0vNfpoWExbw8hOiHh3Eq+wMGoBUZtD/CDRBPPhdBDMaHI6lQN+d2uuk1OGQsX
 lmUudnOA=
X-Gm-Gg: AeBDievgZ2mpdfDRH8S5kD1ymzEu9++AgkzBOSILpp61AaOB8XdFG9K1yzJUmQNx6tW
 uhJh8CoJeRwPPI3rvEDKGFe4uRSzIBvKwqgGPNcCU5vyMqPWoMlYPWhhjAts0n5kMkRIR2RQfgJ
 28z/KExwx5DqmsQnKoreNAq5IC8gne/V15AFsOjLGwRM+oOhp3kENl+XLQ3TM8oiwbcUdwTGhXM
 NR0LC68dvHXkTDdRSfnAogAhj9PWP91PUwHfwK4HeR3CQ3LV6OB3vIpc+4ALodGSCPLJU+UWnMF
 gf0dvtrQ2AFwq5dI2K2J0rGkofS8A1zTIEFtiqkQUVBHYC0f80aA7aXWn0cXqFS0KfZ07ecDRib
 Tk+PqmnnToUyruKAb8t4lmAMdC2pOcGfXD8gCm+Cm6KzmB7THtmpz52UMi17wJLNos9iZtMBpX/
 zhB9jOrSeeY2QYT19+llCpzXFJpbCbuiAFMIycz5nx
X-Received: by 2002:a17:90b:52:b0:35d:a31e:6b04 with SMTP id
 98e67ed59e1d1-364c44b5c8bmr8676a91.3.1777501575367; 
 Wed, 29 Apr 2026 15:26:15 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/48] fpu: Return struct from float4_e2m1_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:30 +1000
Message-ID: <20260429222445.26301-34-richard.henderson@linaro.org>
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

Inline float4_e2m1_unpack_raw at the same time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 99b1cce894..c1d0140484 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
-{
-    *p = unpack_raw64(&float4_e2m1_params, f);
-}
-
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
     *p = unpack_raw64(&float8_e4m3_params, f);
@@ -1473,11 +1468,11 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
-static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
-                                         float_status *s)
+static FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
 {
-    float4_e2m1_unpack_raw(p, f);
-    parts64_canonicalize(p, s, &float4_e2m1_params);
+    FloatParts64 p = unpack_raw64(&float4_e2m1_params, f);
+    parts64_canonicalize(&p, s, &float4_e2m1_params);
+    return p;
 }
 
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
@@ -2699,9 +2694,7 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
 
 float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
 {
-    FloatParts64 p;
-
-    float4_e2m1_unpack_canonical(&p, a, s);
+    FloatParts64 p = float4_e2m1_unpack_canonical(a, s);
     parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, false);
 }
-- 
2.43.0


