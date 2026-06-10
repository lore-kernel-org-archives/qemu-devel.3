Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA3FCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYB-0001sY-Pf; Wed, 10 Jun 2026 12:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY1-0000cR-K1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXz-0005dj-O0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:57 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so4877706f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107974; x=1781712774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fg+Av3nHRSmDgv3J78A1wQ5bvDMK+OkVvsRiCkfAwl0=;
 b=NNJjA03E7N4tEq7MczDBC9EZNU9BKlRbG+xLmnoyJp68Kw/LhTXEQ7y5efBFBOj9uE
 UrZn+mtbaZaIWhRna0VgyzHcr73V21Kaul5O264C0JBzmSfQQr9PciiPnp4zLt8l8hiA
 3vOqGjPvwN8c7AaNLbTrY5q7HYxLZywJdh6aUHYy3N//h7hjQ/9+5PZ+KUY4emI4FD9D
 DnQuI7AK60ApY+FVB2UATjh4LeXt0t6qHbX3PNGIMjOP7MlluqJVkVB9OAC9HhNYpNv4
 6G1mE0s63Re8vONco3oO+OcfvMKw7TxtvgSVflTidd7QEEt6zOPKjofRyCl1GkzYt7SX
 2XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107974; x=1781712774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fg+Av3nHRSmDgv3J78A1wQ5bvDMK+OkVvsRiCkfAwl0=;
 b=cfocgYP9CJioQyRA93C2+/SUD4NcGn2E1JBSP+Gt7UHR2qC2VJ5G3i2p5V+n21yn3a
 iNaxCM+9YZmVnkvwfMQ9lusA5z5SRcpeMPunj1NXW5RAQDrOebcB3zxfZRDfTZcNhHl8
 IN+ENqMBhIVz5/jHRapi6Ce2KJ7a6f+Ayp5+81PkyI7+2vhi9gPYFix/0icM2O9DCbwJ
 oPYfSk4hXeeIjlISn3Ppe5eEd6yqCm1wyUQhXIHeF0oPmND71Zj6ARw4czrdc8ovAloD
 JedFCM//ipw9nImqXycapOHXrtaFh6fq8fCDYK7ofiDcVGrQfoNDAeQSjOzQhgQN3Gtp
 YHDg==
X-Gm-Message-State: AOJu0Yy0D0BjBCgr5h7RMPm5J6WWR9SSaXtDfUpK/uqLgOIJ2m2wpfhC
 8hPhUNV4tBOke/dzn5WMuiUUMnt+Zp8OIV487rumt2QKlSaKkGz0XvFi/eFjweIAmx8rOqOIMZe
 DOtDU
X-Gm-Gg: Acq92OEni6itsl82SXgKcQ/5DOCDHoHfIZJ0g66V1BZ8UgpmiA4HzcBmn+EENtUvHkk
 l1UTgzJdqFnXXD0VJzabxQhDKwjE6BjfNrKcR9yK0NQxj/D3qC7qxYGVaTsFA4CChMi17BibyyJ
 6cIFUMMGe9DSdW5QMgwV/vLBJ92wD/b1/3hn41TiFF1/HB4QYNybDgoZDnOGXLqIlWmUluirYgR
 aCXufeWNubbCE8aoO52wXd8buT+PNzS9YfCG6GP0erHIF+VpVrSFgTw7cd3wvVHNThEaQ+CtHCj
 asnNeylCeOKmUH06QVx5R8sSvVugbBQJB2yJySMecLtmgoNbyD8wHP2IiiLMUsLng5r77dtZp5X
 80NtZP4Of5OK9NNd96gbq9PoPdXMATKT8u9cLXF07Gtkq519vXTZItBw47UvgxaixKf/9/oYpmp
 +bkXoNq6jNgOLQcfzBx7Nz6V1C/0nZt9//B1GHeNfUKU1RFZJ1yW5yFRMBqCwqslA2tzkv/2fcx
 NgyNAh7LGeqHyEXUpa+Zo+XIJq6pjgCuylBuN+DPqIx53tzsx+/kA==
X-Received: by 2002:a5d:4574:0:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-460302ec8dbmr30578977f8f.10.1781107974297; 
 Wed, 10 Jun 2026 09:12:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/71] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
Date: Wed, 10 Jun 2026 17:11:28 +0100
Message-ID: <20260610161202.2235298-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode        |  3 +++
 target/arm/tcg/fp8_helper.c      | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/translate-a64.c   |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e30c7e5ca9..3c806259f9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1921,6 +1921,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+F1CVTL          0.10 1110 001 00001 01111 0 ..... .....     @qrr_h
+F2CVTL          0.10 1110 011 00001 01111 0 ..... .....     @qrr_h
+
 BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
 BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
 
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index aad03b0817..0f3c279696 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -103,6 +103,14 @@ static bfloat16 fcvt_fp8_to_b16(uint8_t x, fp8_input_fn *f8fmt,
     return bfloat16_round_pack_canonical(&p, s);
 }
 
+static float16 fcvt_fp8_to_f16(uint8_t x, fp8_input_fn *f8fmt,
+                               int scale, float_status *s)
+{
+    FloatParts64 p = f8fmt(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return float16_round_pack_canonical(&p, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -123,6 +131,27 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     clear_tail(vd, 16, simd_maxsz(desc));
 }
 
+void HELPER(advsimd_fcvtl_hb)(void *vd, void *vn,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn, scratch[16];
+    float16 *d = vd;
+
+    if (vd == vn) {
+        n = memcpy(scratch, vn, 16);
+    }
+    n += ctx.high * 8;
+
+    for (size_t i = 0; i < 8; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(i)], input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, 16, simd_maxsz(desc));
+}
+
 void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 966f83d796..718463422b 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -7,3 +7,5 @@ DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5e8c86235b..439a405064 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10740,6 +10740,9 @@ static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
     return true;
 }
 
+TRANS_FEAT(F1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, false)
+TRANS_FEAT(F2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, true)
+
 TRANS_FEAT(BF1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, false)
 TRANS_FEAT(BF2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, true)
 
-- 
2.43.0


