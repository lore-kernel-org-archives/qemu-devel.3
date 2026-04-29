Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B9FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMU-000421-1m; Wed, 29 Apr 2026 18:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMS-0003wA-DC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:28 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMQ-0005Kp-Si
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:28 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so144333a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501585; x=1778106385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jv5RFKdPLv46ih/w2n/zKnqzkDwNcWDPMIdbZftxxbA=;
 b=WnDVjkcg7W5a4+gLxXdbwUpl9S6+53e/vp6l3zx8zswAb9om4UzuIEd/h6+2bLEmqZ
 LHY3OONhiWlZ8DGtti8aO95NAVTEFdfY7uTesSJ3o1gXHagRtSrEUhSIXKv1u9ciSCYs
 V313KJAwwBh2f8sod5Q4SKSykwFcFpxRS2BsTCJfdGuLhly7e4ogplV2O43ctz77nmWH
 0/A6uC4rfVJhPUtE6/wE4wvhOfux3uYPsM4J6B9GeZAyeWFxyeVNM4qNNCo7kGVNNyvV
 VxWs34ikO283jIH+VdsNacqPFigtLu64MSRG1xtsuk1i4sw/IOEZyhx2CwTZ2Hpqpnxu
 cfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501585; x=1778106385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jv5RFKdPLv46ih/w2n/zKnqzkDwNcWDPMIdbZftxxbA=;
 b=UEyQPPJ+bDckSNfDtlihI2PMfwoOuMSszQ92FZ7tribuylHvy3oaRRYyJM2cgDdGtR
 49K41Ydm6uFXbfnymSQUf3HDWxMRIEvw7FoGb68IWUUqJYpHOnqAFtRF7xSFQYvsV/jz
 g4lP75KWtYUT5Fe/jJUK1NKcCwgRJSWjs80qlPCUxByzxD1CGGU5qqK54+F1t9UTnFDV
 SUnubMPyPCVLBjee9ps7f/pHzryWjKqYVbd2PakmqMQPGXEWORngTKI7758D9QhTKvMU
 MfyS5ICyl1skuCAt0nTNl5EPCY7697FkFOd//EU80DD+L/36qLCm0W25nJ53gbJxnSw6
 6isA==
X-Gm-Message-State: AOJu0YwCwKY2MGxfVm3Nw3Qx2fPfwmYtm5wem8gC9YwLATCWnziOs1TR
 6SOvvUHbDGaC3+Pokq/1c0YmZsc/mrg8y03PGPzhskh47eoY4wKUoD5hC9SK//WYbmdFjQoolxC
 xEkgp8as=
X-Gm-Gg: AeBDieuCHMX40qD7nKCbVioyy5lQgE7YmNmPyvNSZoicvnER8tIuJCCAGNriJ0anvNZ
 ySSNSyGoT0UDBCMdD6hT9OVPHsFASw75J6GQaPYwGpxUiZoIUI/t1RAKIrCzDLr4ttN6EQmcgVM
 dQP/uN6RFwwNS1r5sdQIpgyQwjLZRb4H5I86MkEkJbxw1Rm3+PwSOrsUv8IbeJl7PrHG2WCxC+3
 V64/yaxT/ZI1REFxOYx1mo18K1/jwDH/rDHpo2P9iJmiwN1xdDLW/SUnTLCMDXeu+KtaHcZh6A5
 wo73mOz+FEcUDl3lFAbGk9vOleQSM4raBVva3I0wAGgrDc9a9NvRQ7VuorC0vH7o9DT+sya1RrZ
 syz21T2MkT6cRx9Tgy4igxeZVvgMrP00ddf/6hb8mTX3hhhh5A/ikqXfaBefjyZiAW8Azlf0kXT
 wMLsa8AE2+aFC+Uvhrx7c98WTe6BQpS4dPcIIlO2Un
X-Received: by 2002:a17:90b:4b04:b0:35f:b1ad:fdfc with SMTP id
 98e67ed59e1d1-364c3189552mr177313a91.27.1777501585355; 
 Wed, 29 Apr 2026 15:26:25 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/48] fpu: Return struct from float16a_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:34 +1000
Message-ID: <20260429222445.26301-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cdf95a8517..dee5dcd0d2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1474,17 +1474,18 @@ static FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
     return p;
 }
 
-static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
-                                      float_status *s, const FloatFmt *params)
+static FloatParts64 float16a_unpack_canonical(float16 f, float_status *s,
+                                              const FloatFmt *params)
 {
-    *p = unpack_raw64(&float16_params, f);
-    parts64_canonicalize(p, s, params);
+    FloatParts64 p = unpack_raw64(&float16_params, f);
+    parts64_canonicalize(&p, s, params);
+    return p;
 }
 
 static void float16_unpack_canonical(FloatParts64 *p, float16 f,
                                      float_status *s)
 {
-    float16a_unpack_canonical(p, f, s, &float16_params);
+    *p = float16a_unpack_canonical(f, s, &float16_params);
 }
 
 static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
@@ -2701,9 +2702,8 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-    FloatParts64 p;
+    FloatParts64 p = float16a_unpack_canonical(a, s, fmt16);
 
-    float16a_unpack_canonical(&p, a, s, fmt16);
     parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
@@ -2711,9 +2711,8 @@ float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 float64 float16_to_float64(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-    FloatParts64 p;
+    FloatParts64 p = float16a_unpack_canonical(a, s, fmt16);
 
-    float16a_unpack_canonical(&p, a, s, fmt16);
     parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
-- 
2.43.0


