Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D480E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRy-0000Fl-Mz; Wed, 11 Dec 2024 11:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRv-0000EU-Fz
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRt-0007hH-T1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a2033562so59602725e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934027; x=1734538827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6eEv6wPqQgMdCISzrXsTLaQsxZwE/ao0DoOYZ7nU5Y=;
 b=wTvk6kRju3/QRk+MNdPvj4gp6ndsvDAy4r/MBGjR2frKYxpIVvecgb+QhyORK8AE/2
 FIpcCuP3fgrX2HVNUPwTwrmqa3DPcp+QVzmitgG4JU7FhWOuhn/uoKntYzHZv5QPiOjz
 nq360azh/p7N0FUcNLo5Jc1nizhlllqAzE6mpc6UV8+b6Wz0igJCUOBEflJbZzP9QBc9
 5Q9+tSfbkkjBvdZyJ6751zRO5IyEmoVV75js8jWh9HwlmLuP/xoVO8xPiAGcjKQk/84P
 yukAenqpzWR/xlT8C0SqIECZthJYdUhXEO0fm6lmASOnP9GYrgJvwVLRTcYmOpi+Bo/V
 ZCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934027; x=1734538827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6eEv6wPqQgMdCISzrXsTLaQsxZwE/ao0DoOYZ7nU5Y=;
 b=IPQOsbIoN/zK3v7fXSf2ZadT+XWUlIyv2Yn85XAY3tE6g9pot3sRHvMiYmUb7lEIyt
 Zm+qoPxnX27RgNVsQQtA1ucy85wno2brLkltz6bl02/lTmXhs/o3u1bHr4yvAFySvAWJ
 YSmrtuQ2hrihqb2nTvaUgEydIgkBtRvsnl0dk95BNTbLwfwf5T0UuQJHmM6zfbKv1yP+
 q6hka+VXCSIcxApY7O3LFvenGgcQgw5qs7O5E80k83wTNhlF2AlHv0IfuqqH7iXT8wnB
 l2YAJPSSPsX7vNGtB/kgar+Jqx8J7uE91TU0+9gUI2Bht9gq6/dShtxgQmveFebEVTss
 UMLg==
X-Gm-Message-State: AOJu0YwTChZFmLbbaGfhyzFzRhcwrv/HRPabhfESn3xGjVRffRf688Io
 UUbxfeEdSsLWluu85zJ0jmBVHPHZB5JSvKtcPawdBKbhGkObRZC4O6MBkE9qMZ5QebthquosvEH
 3
X-Gm-Gg: ASbGncu58d+D4HU/aTK6es9waOpvPxDvjpQosMAMFBAHjWEJEodtK3Sgxr72Zw6aOtS
 d90lnawsyaYDNQzxvcS66pCvM42jIxPOhjk65P9qphD0VruA3wahuf8bgnR/tMkaRSxDDXoUAZE
 FO32if/54O8jtNSaeIMEdtpVluHkBc/AMDv7f1aggFdAalczXi6FHFffVxQUbk3pHIiq1ZpM3N9
 6oDF7bc4jtXFN/+LxpP1vYdd9D8+uhuFNKD+73OsS/6jWcAVtaayLI+HMDN
X-Google-Smtp-Source: AGHT+IGZ6RGcHkUrzCICWBlKUuLRdM9mM8MTsLxlKPWMyWobX7I4XCANwFdR0CJarDz6rLsFyNBeRQ==
X-Received: by 2002:a05:600c:548a:b0:434:f609:1afa with SMTP id
 5b1f17b1804b1-43622823a9bmr3473915e9.4.1733934027369; 
 Wed, 11 Dec 2024 08:20:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/72] target/x86: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:08 +0000
Message-Id: <20241211162004.2795499-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Set the FloatInfZeroNaNRule explicitly for the x86 target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-12-peter.maydell@linaro.org
---
 target/i386/tcg/fpu_helper.c   | 7 +++++++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 53b49bb2977..3295753e075 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -173,6 +173,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
+    /*
+     * Only SSE has multiply-add instructions. In the SDM Section 14.5.2
+     * "Fused-Multiply-ADD (FMA) Numeric Behavior" the NaN handling is
+     * specified -- for 0 * inf + NaN the input NaN is selected, and if
+     * there are multiple input NaNs they are selected in the order a, b, c.
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3062d19402d..ad4f7096d09 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -490,7 +490,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * Temporarily fall back to ifdef ladder
          */
 #if defined(TARGET_HPPA) || \
-    defined(TARGET_I386) || defined(TARGET_LOONGARCH)
+    defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
-- 
2.34.1


