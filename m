Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08764CD6E52
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrc-0000VP-EB; Sat, 30 May 2026 19:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSra-0000TG-80
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:06 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrY-0007dU-Ie
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:05 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36bb3551f6eso1949891a91.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182783; x=1780787583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFZDxQPlMUk4Y3zCdCtj6jkmwOnh+sTkiuf5F+8SjLo=;
 b=CglyTx1f7FjTTjoLf6lsiXk8JCBtUi/Eunh+M2wpd9WxiSmS0NMWjXDS1B3dgvT3Cm
 4Esm830JKY3Lbm0M77Tp9u/DLbLr1UWdLw9Vb1htbPEHrY9FVXGLAOBcSGdIP97KAzGa
 4KIbwCoPc+7ufLa4nylfDKWHYaC+1WnnyLRLrMBHh3tHpBsHWqeIYXgpnGjHg37UJDC5
 2fJkr2OtaKJQkEg9rddyKiWW5YCvdxyasUu3i+cEmoiLtSjDxm6X511peU5DLO/mj8QT
 jJZyhAQT59HD1n+GtKKw3U4VoR0YBEqdHbKH8INpO1oSEh7sdQ0Pn4Pa0yW90jcSYqdZ
 TN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182783; x=1780787583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WFZDxQPlMUk4Y3zCdCtj6jkmwOnh+sTkiuf5F+8SjLo=;
 b=XMrmjukstX7pBM7iAz7PVBjm0um+kHHqz0SUZ9TRneUQ2E7Dk/b5PJ2sCrsmQXHdzP
 Mxt4KzawGtKGc3Rh4CjG9LvQWTkPE4by+wsLkLWlsIKIl3u69TQs/udtCPT3dHPAZz9H
 12vnnIzATq93RDWikWbWCnMUI3YDwWSmVTsv4aeaJYSwFkp1kTQXEaAGvXUF1twFpo6k
 CnFy+l5FmYb5zcicpvO++xwPZzvSffo0gD7JNuwMDlLY3v6M5ca4WOHkJ0S4Sz461bX5
 8Ka+v7J7KJe2hl3+SwYeDowyOxt3MlV3E11BQXX71OpbtQselQb+WAg5cyIFsefnF8ES
 D/LA==
X-Gm-Message-State: AOJu0YzBEESvBq29ebpbPaWUPIO+W/cjEowOdoBko6P+7rL1XBi6zRDA
 I+PD3lC39LlsagtFzs7f3tr//mZfVshYW4W1O+8i2qWiIsnSifv97a4gCd0HplwI9dMNSkGyZB8
 n59oMj70=
X-Gm-Gg: Acq92OF9jCjZ5Z+2rlTiunVEfRyQKpckXvjyFUoph7yLl3TZQui9KH+hTvlUVCehXH0
 CHqSa0gFV6DwM9KElAK/5zNHR8IpMzGHq7D/t5igXRQdMJvwVInJdZ6ms25FP1315qsldyyJSuo
 26lmQe8E84e9Bp9qgV4Ku7KIER5LiRyM1rmpxt7uN8W8TchkmGeiZH6HsUSNLPtYH/Oy0Sj4e9n
 U7MhF1vFrFd3gDBmXJwTkb02arhqkH5anxWmQNiikzRw7ehGs7u8MvkTfIfIv/uUtfUFswfw/7J
 OSsNLgJv+88muOlTQxw3S81LfZqQ8UHRdDEwQlPOrDhAz8w+2Tac3kQhBofXxG+Wd4alyrt4B6T
 +0IaajzBrjFXGHUM+Xg9AVBruWmgsU1LDU+OdgiaztjKxQon9GKrC4UjbV9KtGshQ3a9izTPQWe
 /1oKJZV2RPvZItpFVXz3kLMEfKqeiPM6BSShcQsBs=
X-Received: by 2002:a05:6a20:244b:b0:3b3:9199:b1a2 with SMTP id
 adf61e73a8af0-3b427f80487mr5190326637.42.1780182782602; 
 Sat, 30 May 2026 16:13:02 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:13:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 36/41] target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
Date: Sat, 30 May 2026 16:12:24 -0700
Message-ID: <20260530231229.400441-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 35 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4629a3cf3e..1fc8db8d58 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1630,6 +1630,11 @@ static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP2);
 }
 
+static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5995d77577..3c74f02022 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -35,3 +35,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index a25e0a1d92..9db4ff4c2f 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -806,3 +806,28 @@ void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint64_t *n = vn;
+    uint64_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float32 d0 = f8dotadd_s(n[0], m[0], 8, d[H4(0)], &ctx);
+        float32 d1 = f8dotadd_s(n[0], m[1], 8, d[H4(1)], &ctx);
+        float32 d2 = f8dotadd_s(n[1], m[0], 8, d[H4(2)], &ctx);
+        float32 d3 = f8dotadd_s(n[1], m[1], 8, d[H4(3)], &ctx);
+
+        d[H4(0)] = d0;
+        d[H4(1)] = d1;
+        d[H4(2)] = d2;
+        d[H4(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 83d90cfcf4..367f87f05d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7501,6 +7501,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
+TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a3e404e7fe..6922e91010 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1227,6 +1227,8 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
+FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


