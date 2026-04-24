Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF3BFB44A8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DI-00021b-Qs; Fri, 24 Apr 2026 00:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DH-0001o9-00
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:23 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DE-0003XX-Hv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:22 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40ede943bf0so4724252fac.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005139; x=1777609939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4lvls8REn2eXN6U4nRWxnCtYhx8hX39DXmOAnRWBww=;
 b=XDEjhZOuLQ2sc7EPFeDKmkYQYQVin73DwxVfuK2r7KpyN09kGYH795nVr4sQ6DWBfP
 4h6eAt0zbXINKARdxUY4aU0PzQyqF4MMIq2TqpCe0bPY/8ouZdLwVk4iJeJUp/actFBL
 /DqEezmQOmosYALbWT7zF0xrUvuZ8jmJw2TlMf1aiyO9PTL90c40jxazctIUf1p1RGSe
 4kXmQVsBCc/+XXNJI58akIFwXIUGdg+VM4pDwMVv9iqq+bACNm1ojkz72cWz3k3xMX32
 vTTuyuXpe7VpJzQIkZYqZDgYu5IEDWDM42GzUxPdiuOZaQLK2Asrn3egW/hWDqETKcjZ
 NhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005139; x=1777609939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j4lvls8REn2eXN6U4nRWxnCtYhx8hX39DXmOAnRWBww=;
 b=eyEjOhS2vchZ74cYmFa1CojmG7OUlVisVdG5XDqd1ae5VrGca+veJodOkyzjE0omI1
 r8A9avaTWX49AtyMZ2wH/6jGiQvuo4AQueCORmSOJ16foejCiiM2DSLRwJO8q2rv5GG4
 9nbZT4cFM2jCLRUXHhBAUozHJ4G8LV46GQXagw20hnw6lKKUjzCVVBS36JZNd8v9w1KC
 +9aiT6Jtw133siDEJ4VUbpLN13JSDV1VJ1hGeyhowATasIQT65wMZhN+GAm5rsE6TsM6
 aEECS/qaiAJF6MDurEk08TQu873tGZ9NoS/Fadw5TSxptKLfBVCeofzvVXiD3A0EBfIP
 Pxlw==
X-Gm-Message-State: AOJu0YwZfM7kzevw/v6Bw/rlCI8NXRVneR1tCoxWHS6zZQpdaF1foYU3
 wPxRBs4VVdCLeGvSXD8aXcf9GBKZ5b2uG7OtRogLZtuF67eO7B4THySbOhmE3Q87W530R6tQh+K
 yxC6BdLk=
X-Gm-Gg: AeBDieuMUtDR/fR1MKLhD86vOCewb5OpA1liFyPiqgVpsol5O92Jqze4O0K9wmZsc1e
 7xKRnc4lvBimSnVt7PjEzaXbKYqyAn/p1GPyByDY4KlSyBpHNs9iS/0oLlKkfdSxmiaV1fZwz5j
 GXyNx9BVSpg8M0ADZ8Lwn6jopZuAHDdSFZvzC8p+Fi+bp57mZ4GrfHMgb0aoSFeHXu/wCaTAt6d
 kD2EP8XUBpq/Xv1JqGEaKSSWPDQeshm/lL+tSRpkDHvFFG9He+caWmUmLn56oCNbfvFNVEouGv6
 b9tithH+vbqDHsrWwyIaYiCKQc0CQHOaMg1RyrFRkOl/m+6nvK/l89xODML0ciK+kpFdJNaaRAt
 LCkqtoBpa+hJlF0KaS+KBwraxr3ZWhaPNxBGq3xjzBYE9cXvQhC/sQ7WDkS7C43RfmHS5GvALRJ
 i70+BazKODG7bzvV4PwxLMSY+yxnBx7aaTn7HMv/VXRRp3GpoRjnoiyqc9VX51gg==
X-Received: by 2002:a05:6870:4687:b0:42f:ee6c:35fb with SMTP id
 586e51a60fabf-42fee6c5c29mr3036229fac.20.1777005139056; 
 Thu, 23 Apr 2026 21:32:19 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 28/40] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Fri, 24 Apr 2026 14:30:02 +1000
Message-ID: <20260424043014.46305-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index ed4923b1d5..32c7a82647 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -192,6 +192,34 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = float8_e5m2_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = float8_e4m3_to_float16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d, nelem, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1540cbd6de..e31ab609f9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4080,6 +4080,15 @@ static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
+TRANS_FEAT(F1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, false, false)
+TRANS_FEAT(F2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, true, false)
+TRANS_FEAT(F1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, false, true)
+TRANS_FEAT(F2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, true, true)
+
 TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
            gen_helper_sve2_bfcvt, false, false)
 TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e7984fa8e0..ca110f4bc1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1091,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+F1CVT           01100101 00 001 000 001100 ..... .....          @rd_rn_e0
+F2CVT           01100101 00 001 000 001101 ..... .....          @rd_rn_e0
+F1CVTLT         01100101 00 001 001 001100 ..... .....          @rd_rn_e0
+F2CVTLT         01100101 00 001 001 001101 ..... .....          @rd_rn_e0
+
 BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
 BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
-- 
2.43.0


