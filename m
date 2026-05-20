Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0139ACD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkaN-0002Zd-W7; Wed, 20 May 2026 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZG-0001cM-II
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:51 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ9-00021c-Kz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:50 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so2780900a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297522; x=1779902322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+P1uL8Ve2PxkJ/Xgs2JNHb0YhQ1hDFIb5oD/QLJAt4=;
 b=qILgXhv4WMMTl/p/wKrfvpuB7n50V+CeLjbMa6v0lyQX/huj+OUv3wfVG9CXjUT7+m
 AL3MHvN/T5Ev4/3yWRJfnCcLAWepJ1yj7WLlt4QwizfF3kcbg0jc589YC1SS+s3ACqnz
 cyF33xrktjFkc0LDyYPUJNT+RG9UNOfhSgq7NgxpQ+mupLMuQO8Ta4rmrCNFpZozNUrV
 OWh7/U+dmVMGhRoWiuWqpx72Q5295q0Rmk9pqr1j/CoxZ+zOV/b6ZYLejWPfgA7X6trA
 4Aj6vizevcKdLAJngjmc0AxUUk82J0Gj8hi9pAVykTY+68RHfic8nCLFdHxl+OEzvjvN
 m2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297522; x=1779902322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+P1uL8Ve2PxkJ/Xgs2JNHb0YhQ1hDFIb5oD/QLJAt4=;
 b=QCsuiYoSB1Bt0kW6tP18EFtXz3GCCZ/Muirpr5NHetDw8ttcQhmRGtCevmu2+uQj4I
 TXWURlW0wdcmUHHvDDy06/etGzWQLRelScsAST7wU6JuXL1iY1r8+Lx+Rzpa/vt2+MlL
 j3XhsB5n3G1DMy2hsktmyi/eZNgri8E9UdR5DdkO+m23qYgexaYK4Qtta4c5fbA5Ube8
 dWVvw5GvV2oeGsPZXv3Ow2rrnPoWnfov+/b8TAUaIdoakWKCrgegmDlTMRunSFFYsdA0
 R767gTv8nyPqIzHx0M/o3CeIJRMO9KgZZ1kpI0i6R7nOLA8ZtvAT38KsPQjfZid0zHXo
 nWwQ==
X-Gm-Message-State: AOJu0YxFsE/kXH+dC9IrNekzrEt3mxtrdfR1PGF9O9pNoJne8FzkmeDZ
 guM5ohB3qyDAKlfwS/Yo+vMHhBYXt/01B7TogxBMOI5MS+CTueuSvxsp8DLTYJLiLq2tmOZeelk
 jyW6j7sg=
X-Gm-Gg: Acq92OFaYUE0gIawJCZbqIYnMji0b+vmChfrkGu01zYWdw+uAYyeAGu6dtYgMrmpKnY
 NRcwbB7St2Y80b37cKN6ETxjBhwcvAoAGTqf8hdYogmqku1/0LA7FZqv7pgC054nQyUqO2l9zCi
 0EEBDapyZYiLChLYANR8ca/aDXh8ZsFYzt+De+eoetH+NpIgKgcNzX3V1j1ej8kR3KZeH1hogWW
 usan4eMr5aNAzEhE9r/2xwTaTdipVQUyJ1D9NgpRUb1gmWnBi8L0kI3sOgaRnaZzFp+ceLprY1h
 RWzFIMP8VMKSn7Qalzkr+/Iy/8q0KCF8arjP1kwJPDOUsBC/wuNVfCPbV3navLHj2zXyXemqYXU
 AtrgLCU5Apb+nDFvPwfDw03k8EHsZjhJMZ/Pro7J+Qx2gMCS+cWqcNxDuj7aBv9uK/RaUDXDzA8
 AOnmqe0GGktb0r768ZQR7N9A37HsQ5
X-Received: by 2002:a17:90a:dfc4:b0:369:742a:4259 with SMTP id
 98e67ed59e1d1-36a3c802ce5mr314738a91.0.1779297522111; 
 Wed, 20 May 2026 10:18:42 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 29/30] fpu: Fix NaN encoding for E4M3 in parts64_uncanon
Date: Wed, 20 May 2026 10:18:19 -0700
Message-ID: <20260520171820.848839-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 fpu/softfloat-parts.c.inc | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

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
index 559e40d196..d6687df982 100644
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
 
@@ -507,10 +512,24 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
             return;
         case float_class_qnan:
         case float_class_snan:
-            assert(fmt->exp_max_kind != float_expmax_normal);
             p->exp = fmt->exp_max;
-            fracN(shr)(p, fmt->frac_shift);
-            return;
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
+                return;
+            case float_expmax_normal:
+                break;
+            }
+            g_assert_not_reached();
         default:
             break;
         }
-- 
2.43.0


