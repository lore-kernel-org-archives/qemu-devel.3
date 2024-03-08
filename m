Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C89C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAm-0007YZ-BC; Fri, 08 Mar 2024 16:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAk-0007Xv-L3
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAi-0001lg-EU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:34 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso22205135ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934870; x=1710539670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbLXBf9PZRgdI1o9+wy6/DHlIur7WPYPPRv0odsFMu4=;
 b=J05Cdj1RCYOdHnKgLUIbq37X7t3VwKRqTRpOsewx8IkTGLREFPMgTjgGWcRllXoo0d
 kd+3i5t2p4D//kCu8KSJxDEwq6k2px1zPzdQ9+u1v5MzNk/vRSUoQmFEZQeO1hG4T1ev
 2wconuaavOdB+QuhHRxqx1x3Woln6sapbHmQc1r7YMg/6cNoFC7deJA4EaFp413pTQAZ
 E/HTD6g8I+v1qr4xbtbQ/dpqCnMjvQqTnLLMwM+PsEzIjCfYaTf0/OhgHW/UoQr5zFPt
 oXonIoWwMmyX/0w5vaBcHg6SVI40HDsWiVllWj56AW/0cdlxGGWSWipAtvc8ttwEnohY
 m34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934870; x=1710539670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbLXBf9PZRgdI1o9+wy6/DHlIur7WPYPPRv0odsFMu4=;
 b=L0pW/OB9QByzB5heEu87OBsi6ho4uSgQnC2TQc3JmUcnY6q3qMLX5zz6U32mlZxSVY
 2GLPY8qLULKHSp+DleKGBgJRo+Q9eDbIfwB6MkDdkuM6RjDPdTUO31FhNAr3J9jMi5sL
 TwUz8vbov0/OPra6z+qtUL3fC9YUk0ynrs/WlDIX3X4O33wjBipnigkUMgo7wvJzcVki
 Jw74Huvb0wIsKTZmHzCz78VQKQWNELkQZL7af0AKyp1vbYM9j3QgHvJ0ayeQ5HboOTn3
 41UntqDbdaFMFRNrzHsE1cfAjg9AruKuoiCw/zuZljsl8XTS85p9Olw402fFSNFjjfY7
 A4Hg==
X-Gm-Message-State: AOJu0YyyKnWWrSo1kQpg3gb4dEZMbFY4eX+ijT/kWi7k8B+TPqp/HDfU
 wFzWfNGThZeNuF0cCIodkLqHifTzmkG1kBZ0aTmxQy/kIE6x8dTYxg77BIIF5paMVCQq3E6trwq
 Q
X-Google-Smtp-Source: AGHT+IGP0tOmGFEAISJLfLBe8Ve5CvC/QChmnyKzkKAggF2p5c2TT2a1acE5Dl/pG494VEihqWnlug==
X-Received: by 2002:a17:902:f68b:b0:1db:8c35:c40d with SMTP id
 l11-20020a170902f68b00b001db8c35c40dmr412015plg.27.1709934870020; 
 Fri, 08 Mar 2024 13:54:30 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 05/10] target/riscv: use vext_set_tail_elems_1s() in
 vcrypto insns
Date: Fri,  8 Mar 2024 18:53:45 -0300
Message-ID: <20240308215402.117405-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Vcrypto insns should also use the same helper the regular vector insns
uses to update the tail elements.

Move vext_set_tail_elems_1s() to vector_internals.c and make it public.
Use it in vcrypto_helper.c to set tail elements instead of
vext_set_elems_1s(). Helpers must set env->vstart = 0 after setting the
tail.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vcrypto_helper.c   | 63 ++++++++++++---------------------
 target/riscv/vector_helper.c    | 25 -------------
 target/riscv/vector_internals.c | 28 +++++++++++++++
 target/riscv/vector_internals.h |  4 +++
 4 files changed, 55 insertions(+), 65 deletions(-)

diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index e2d719b13b..66d449c274 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -218,9 +218,7 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
     void HELPER(NAME)(void *vd, void *vs2, CPURISCVState *env,            \
                       uint32_t desc)                                      \
     {                                                                     \
-        uint32_t vl = env->vl;                                            \
         uint32_t total_elems = vext_get_total_elems(env, desc, 4);        \
-        uint32_t vta = vext_vta(desc);                                    \
                                                                           \
         for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {        \
             AESState round_key;                                           \
@@ -233,18 +231,16 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
             *((uint64_t *)vd + H8(i * 2 + 0)) = round_state.d[0];         \
             *((uint64_t *)vd + H8(i * 2 + 1)) = round_state.d[1];         \
         }                                                                 \
-        env->vstart = 0;                                                  \
         /* set tail elements to 1s */                                     \
-        vext_set_elems_1s(vd, vta, vl * 4, total_elems * 4);              \
+        vext_set_tail_elems_1s(env, vd, desc, 4, total_elems);            \
+        env->vstart = 0;                                                  \
     }
 
 #define GEN_ZVKNED_HELPER_VS(NAME, ...)                                   \
     void HELPER(NAME)(void *vd, void *vs2, CPURISCVState *env,            \
                       uint32_t desc)                                      \
     {                                                                     \
-        uint32_t vl = env->vl;                                            \
         uint32_t total_elems = vext_get_total_elems(env, desc, 4);        \
-        uint32_t vta = vext_vta(desc);                                    \
                                                                           \
         for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {        \
             AESState round_key;                                           \
@@ -257,9 +253,9 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
             *((uint64_t *)vd + H8(i * 2 + 0)) = round_state.d[0];         \
             *((uint64_t *)vd + H8(i * 2 + 1)) = round_state.d[1];         \
         }                                                                 \
-        env->vstart = 0;                                                  \
         /* set tail elements to 1s */                                     \
-        vext_set_elems_1s(vd, vta, vl * 4, total_elems * 4);              \
+        vext_set_tail_elems_1s(env, vd, desc, 4, total_elems);            \
+        env->vstart = 0;                                                  \
     }
 
 GEN_ZVKNED_HELPER_VV(vaesef_vv, aesenc_SB_SR_AK(&round_state,
@@ -301,9 +297,7 @@ void HELPER(vaeskf1_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
 {
     uint32_t *vd = vd_vptr;
     uint32_t *vs2 = vs2_vptr;
-    uint32_t vl = env->vl;
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
-    uint32_t vta = vext_vta(desc);
 
     uimm &= 0b1111;
     if (uimm > 10 || uimm == 0) {
@@ -337,9 +331,9 @@ void HELPER(vaeskf1_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
         vd[i * 4 + H4(2)] = rk[6];
         vd[i * 4 + H4(3)] = rk[7];
     }
-    env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, vl * 4, total_elems * 4);
+    vext_set_tail_elems_1s(env, vd, desc, 4, total_elems);
+    env->vstart = 0;
 }
 
 void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
@@ -347,9 +341,7 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
 {
     uint32_t *vd = vd_vptr;
     uint32_t *vs2 = vs2_vptr;
-    uint32_t vl = env->vl;
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
-    uint32_t vta = vext_vta(desc);
 
     uimm &= 0b1111;
     if (uimm > 14 || uimm < 2) {
@@ -394,9 +386,9 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
         vd[i * 4 + H4(2)] = rk[10];
         vd[i * 4 + H4(3)] = rk[11];
     }
-    env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, vl * 4, total_elems * 4);
+    vext_set_tail_elems_1s(env, vd, desc, 4, total_elems);
+    env->vstart = 0;
 }
 
 static inline uint32_t sig0_sha256(uint32_t x)
@@ -455,7 +447,6 @@ void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     uint32_t sew = FIELD_EX64(env->vtype, VTYPE, VSEW);
     uint32_t esz = sew == MO_32 ? 4 : 8;
     uint32_t total_elems;
-    uint32_t vta = vext_vta(desc);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         if (sew == MO_32) {
@@ -469,7 +460,7 @@ void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     }
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -570,7 +561,6 @@ void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 {
     const uint32_t esz = 4;
     uint32_t total_elems;
-    uint32_t vta = vext_vta(desc);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
@@ -579,7 +569,7 @@ void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -588,7 +578,6 @@ void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 {
     const uint32_t esz = 8;
     uint32_t total_elems;
-    uint32_t vta = vext_vta(desc);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
@@ -597,7 +586,7 @@ void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -606,7 +595,6 @@ void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 {
     const uint32_t esz = 4;
     uint32_t total_elems;
-    uint32_t vta = vext_vta(desc);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
@@ -615,7 +603,7 @@ void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -624,7 +612,6 @@ void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 {
     uint32_t esz = 8;
     uint32_t total_elems;
-    uint32_t vta = vext_vta(desc);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
         vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
@@ -633,7 +620,7 @@ void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -653,7 +640,6 @@ void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
 {
     uint32_t esz = memop_size(FIELD_EX64(env->vtype, VTYPE, VSEW));
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vta = vext_vta(desc);
     uint32_t *vd = vd_vptr;
     uint32_t *vs1 = vs1_vptr;
     uint32_t *vs2 = vs2_vptr;
@@ -672,7 +658,7 @@ void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
             vd[(i * 8) + j] = bswap32(w[H4(j + 16)]);
         }
     }
-    vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd_vptr, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -752,7 +738,6 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
 {
     uint32_t esz = memop_size(FIELD_EX64(env->vtype, VTYPE, VSEW));
     uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vta = vext_vta(desc);
     uint32_t *vd = vd_vptr;
     uint32_t *vs2 = vs2_vptr;
     uint32_t v1[8], v2[8], v3[8];
@@ -767,7 +752,7 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
             vd[i * 8 + k] = bswap32(v1[H4(k)]);
         }
     }
-    vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd_vptr, desc, esz, total_elems);
     env->vstart = 0;
 }
 
@@ -777,7 +762,6 @@ void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
     uint64_t *vd = vd_vptr;
     uint64_t *vs1 = vs1_vptr;
     uint64_t *vs2 = vs2_vptr;
-    uint32_t vta = vext_vta(desc);
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
@@ -805,7 +789,7 @@ void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
         vd[i * 2 + 1] = brev8(Z[1]);
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
+    vext_set_tail_elems_1s(env, vd, desc, 4, total_elems);
     env->vstart = 0;
 }
 
@@ -814,7 +798,6 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
 {
     uint64_t *vd = vd_vptr;
     uint64_t *vs2 = vs2_vptr;
-    uint32_t vta = vext_vta(desc);
     uint32_t total_elems = vext_get_total_elems(env, desc, 4);
 
     for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
@@ -839,7 +822,7 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
         vd[i * 2 + 1] = brev8(Z[1]);
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
+    vext_set_tail_elems_1s(env, vd, desc, 4, total_elems);
     env->vstart = 0;
 }
 
@@ -881,9 +864,9 @@ void HELPER(vsm4k_vi)(void *vd, void *vs2, uint32_t uimm5, CPURISCVState *env,
         }
     }
 
-    env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
+    env->vstart = 0;
 }
 
 static void do_sm4_round(uint32_t *rk, uint32_t *buf)
@@ -930,9 +913,9 @@ void HELPER(vsm4r_vv)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
         }
     }
 
-    env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
+    env->vstart = 0;
 }
 
 void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
@@ -964,7 +947,7 @@ void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
         }
     }
 
-    env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
+    env->vstart = 0;
 }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2f715fea5e..1941c0e5f3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -174,31 +174,6 @@ GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
 
-static void vext_set_tail_elems_1s(CPURISCVState *env, void *vd,
-                                   uint32_t desc, uint32_t esz,
-                                   uint32_t max_elems)
-{
-    uint32_t vta = vext_vta(desc);
-    uint32_t nf = vext_nf(desc);
-    int k;
-
-    /*
-     * Section 5.4 of the RVV spec mentions:
-     * "When vstart ≥ vl, there are no body elements, and no
-     *  elements are updated in any destination vector register
-     *  group, including that no tail elements are updated
-     *  with agnostic values."
-     */
-    if (vta == 0 || env->vstart >= env->vl) {
-        return;
-    }
-
-    for (k = 0; k < nf; ++k) {
-        vext_set_elems_1s(vd, vta, (k * max_elems + env->vl) * esz,
-                          (k * max_elems + max_elems) * esz);
-    }
-}
-
 /*
  * stride: access vector element from strided memory
  */
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 12f5964fbb..70d2da2c81 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -33,6 +33,34 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
     memset(base + cnt, -1, tot - cnt);
 }
 
+/*
+ * This function is sensitive to env->vstart. Do not change
+ * vstart before updating the tail elements.
+ */
+void vext_set_tail_elems_1s(CPURISCVState *env, void *vd, uint32_t desc,
+                            uint32_t esz, uint32_t max_elems)
+{
+    uint32_t vta = vext_vta(desc);
+    uint32_t nf = vext_nf(desc);
+    int k;
+
+    /*
+     * Section 5.4 of the RVV spec mentions:
+     * "When vstart ≥ vl, there are no body elements, and no
+     *  elements are updated in any destination vector register
+     *  group, including that no tail elements are updated
+     *  with agnostic values."
+     */
+    if (vta == 0 || env->vstart >= env->vl) {
+        return;
+    }
+
+    for (k = 0; k < nf; ++k) {
+        vext_set_elems_1s(vd, vta, (k * max_elems + env->vl) * esz,
+                          (k * max_elems + max_elems) * esz);
+    }
+}
+
 void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
                 CPURISCVState *env, uint32_t desc,
                 opivv2_fn *fn, uint32_t esz)
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 842765f6c1..c5a2bc4bf3 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -117,6 +117,10 @@ static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
 void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
                        uint32_t tot);
 
+void vext_set_tail_elems_1s(CPURISCVState *env, void *vd,
+                            uint32_t desc, uint32_t esz,
+                            uint32_t max_elems);
+
 /* expand macro args before macro */
 #define RVVCALL(macro, ...)  macro(__VA_ARGS__)
 
-- 
2.43.2


