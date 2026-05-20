Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC97ACD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlep-00016s-BO; Wed, 20 May 2026 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcR-0004TA-Sj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcM-0002DT-Ov
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:11 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b458ca2296so38241955ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301559; x=1779906359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NExW4LAN/g5Vp2EXgAs1nazVMjrbniHoK3lm+fA8UEE=;
 b=sKmW8Btq0+BiHdQ+zl96NdNOO2o7f4Fx38YvWEln6en1c3JHXZmL2ETVZ6cngDpakc
 wLtZJFASVbPv4JnR+b7lQtyRhKW55FzllPvGAULfpk07XaW4WfEdtssqYX/s6N6ms4bj
 q4dBNH8J25v0naeBBX8HpgKxmjXXVWHOhhmamo1ZpV+mzuWeos25Jv8HnERehod6PVJH
 HyjfJnlVn/NCmLmG1ab+UZiT/v1akeWhLWUwCEFs7VQewJNmmo8ScgBB2rNlYmV0vyxT
 1DhXBI+YS1rOZKPybRroMqG8pwimcp3847LE9alcEAAWMxTKYc2/NIe/ryxo8ykVNkmk
 BV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301559; x=1779906359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NExW4LAN/g5Vp2EXgAs1nazVMjrbniHoK3lm+fA8UEE=;
 b=slJLJonj0qEisr1OXzGPUzW5dlEuUf7X0QrS3U/Cnro+EyBB8xCBz/vA8RdTyUIV5N
 BG/WU1OPx0Gm1TrqvMFQhkHfqmEbM6Zir/RF/E/lcjooKWGHe7n/qgY7Mjcsp+EKcAOJ
 iYQHQFFQ6I0u67tBWJ1y9nevZ3Jz+zckdlR0NRqku3GepPP3nBB8AhYbp5xctEW5YUMy
 ceerIkAlwUBu4x2ZPjaxkuthDpAhyKMnFJ/jsM2uO6jlgTzKPiF5OBNCZ/nkDWXElRN1
 QIw4//TdisLHc4xP0+Wc78XrzAc4Evp6PZiYVN0qc4Vtbv01witlmM7MMrlZf9l5gh/p
 f6NA==
X-Gm-Message-State: AOJu0Yy9fdvcB32QpfTRWKqLPGnfplHgYiNly1L7fNM59Qh3vmwVRSYc
 7tIz8tQ+NHzeKjj5BgGCC8Ala3pRu3iGg0XU3C1U1TjzHRDElVKZ1y9VLvYQNmRaOY8un6hQX81
 gocWCxL0=
X-Gm-Gg: Acq92OEmzc/SH0VhLhZjHGCRYwfDItj/CpgV/UeInKcSJddDqBKcrtn/K86bBSSf6fJ
 oFm7iSvJxcLKT2icti5uzufC8kulajtNIFd5bYd8bvZbSUKiZGGIkcXwzHtZoVVvgbKJjse7kVM
 8zybV7Tq/JPwGVuv7iFxaANVHfBjHdHVGIIuY35DC1lfjxmzHYwSDruvJ44qnQdlmlvkkCN4sZw
 5HITV9PLelb2W8TtR8MjGShxbj2gzCaMxAw2klZSTNRdZvJUVbdd1PX/wktT3Xc+MuiW6OYyNAb
 njV9cgyBuZ808rfKUp+ukbYCb9M0OY8pegA7YQql6vontY/zYBumAKd+QxwpGmC0YfK3caSRD3t
 7EvWnZNs3LYNxxgspBzfmO4lF+zvAkxdnkM3E8/7EuGfIVAne2qeEiC0Mq8kWKSiLYjlRhQxIMY
 9MsTV0ZDpJoZClbiPon8Qwik7zW8f0bc08VHUZZKA=
X-Received: by 2002:a17:903:2f07:b0:2bd:a403:4ab8 with SMTP id
 d9443c01a7336-2bda403553emr210851475ad.25.1779301558945; 
 Wed, 20 May 2026 11:25:58 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 60/64] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Wed, 20 May 2026 11:22:09 -0700
Message-ID: <20260520182213.872945-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8f6cc2974f..fce38dfbb0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1625,6 +1625,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 160850be53..b6ce4826fb 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -832,3 +832,28 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[0], m[0], 4, d[H4(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[0], m[1], 4, d[H4(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[1], m[0], 4, d[H4(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[1], m[1], 4, d[H4(3)], &ctx);
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
index 02d5e007f9..aff0f332ac 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7419,6 +7419,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6404c26540..e7f2f30abb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1217,6 +1217,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


