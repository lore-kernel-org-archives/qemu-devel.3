Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E027CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqvc-000187-0C; Wed, 06 Mar 2024 08:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rhnYl-0004Yi-Rd; Wed, 06 Mar 2024 04:27:37 -0500
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rhnYh-0006Ku-PB; Wed, 06 Mar 2024 04:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709717247; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=LIzolYSPEY8lQqokyCBzX1llQAG/f1M6mvqTokSnVhA=;
 b=AwpJcVwIf7gpbdAhNCHM1iORiHqK45OkZal+Der3N9QuFsP3fe+bvs25HheCDmJSg54zMaGrRTS1Hwc3a567oTZZmaZXs91setmf4TjRmElj2V+2Qh6PPf3paK57OytfrUuNX45y1odKbL2c3OkdPZ4NtTNuEFdD/kV8AouKs98=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W1wzahE_1709716938; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W1wzahE_1709716938) by smtp.aliyun-inc.com;
 Wed, 06 Mar 2024 17:22:19 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 3/4] target/riscv: Replace element agnostic for vector
 instructions
Date: Wed,  6 Mar 2024 17:20:11 +0800
Message-ID: <20240306092013.21231-4-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
References: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:03:17 -0500
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

Replace vext_set_elems_1s_le with vext_set_elems_1s for RVV and
vcrypto.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/vcrypto_helper.c   | 32 ++++++------
 target/riscv/vector_helper.c    | 92 ++++++++++++++++-----------------
 target/riscv/vector_internals.c |  8 +--
 target/riscv/vector_internals.h |  4 +-
 4 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index f818749a63..d6c52c1fd0 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -235,7 +235,7 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
         }                                                                 \
         env->vstart = 0;                                                  \
         /* set tail elements to 1s */                                     \
-        vext_set_elems_1s_le(vd, vta, vl * 4, total_elems * 4);              \
+        vext_set_elems_1s(vd, vta, 4, vl, total_elems * 4);               \
     }
 
 #define GEN_ZVKNED_HELPER_VS(NAME, ...)                                   \
@@ -259,7 +259,7 @@ static inline void xor_round_key(AESState *round_state, AESState *round_key)
         }                                                                 \
         env->vstart = 0;                                                  \
         /* set tail elements to 1s */                                     \
-        vext_set_elems_1s_le(vd, vta, vl * 4, total_elems * 4);              \
+        vext_set_elems_1s(vd, vta, 4, vl, total_elems * 4);               \
     }
 
 GEN_ZVKNED_HELPER_VV(vaesef_vv, aesenc_SB_SR_AK(&round_state,
@@ -339,7 +339,7 @@ void HELPER(vaeskf1_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     }
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, vl * 4, total_elems * 4);
+    vext_set_elems_1s(vd, vta, 4, vl, total_elems * 4);
 }
 
 void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
@@ -396,7 +396,7 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     }
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, vl * 4, total_elems * 4);
+    vext_set_elems_1s(vd, vta, 4, vl, total_elems * 4);
 }
 
 static inline uint32_t sig0_sha256(uint32_t x)
@@ -469,7 +469,7 @@ void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     }
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s_le(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -579,7 +579,7 @@ void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s_le(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -597,7 +597,7 @@ void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s_le(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -615,7 +615,7 @@ void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s_le(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -633,7 +633,7 @@ void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
 
     /* set tail elements to 1s */
     total_elems = vext_get_total_elems(env, desc, esz);
-    vext_set_elems_1s_le(vd, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -672,7 +672,7 @@ void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
             vd[(i * 8) + j] = bswap32(w[H4(j + 16)]);
         }
     }
-    vext_set_elems_1s_le(vd_vptr, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd_vptr, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -767,7 +767,7 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
             vd[i * 8 + k] = bswap32(v1[H4(k)]);
         }
     }
-    vext_set_elems_1s_le(vd_vptr, vta, env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd_vptr, vta, esz, env->vl, total_elems * esz);
     env->vstart = 0;
 }
 
@@ -805,7 +805,7 @@ void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
         vd[i * 2 + 1] = brev8(Z[1]);
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, env->vl * 4, total_elems * 4);
+    vext_set_elems_1s(vd, vta, 4, env->vl, total_elems * 4);
     env->vstart = 0;
 }
 
@@ -839,7 +839,7 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
         vd[i * 2 + 1] = brev8(Z[1]);
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, env->vl * 4, total_elems * 4);
+    vext_set_elems_1s(vd, vta, 4, env->vl, total_elems * 4);
     env->vstart = 0;
 }
 
@@ -883,7 +883,7 @@ void HELPER(vsm4k_vi)(void *vd, void *vs2, uint32_t uimm5, CPURISCVState *env,
 
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vext_vta(desc), esz, env->vl, total_elems * esz);
 }
 
 static void do_sm4_round(uint32_t *rk, uint32_t *buf)
@@ -932,7 +932,7 @@ void HELPER(vsm4r_vv)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
 
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vext_vta(desc), esz, env->vl, total_elems * esz);
 }
 
 void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
@@ -966,5 +966,5 @@ void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
 
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vext_vta(desc), esz, env->vl, total_elems * esz);
 }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6ed73ed70a..4816439815 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -187,7 +187,7 @@ static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
     }
 
     for (k = 0; k < nf; ++k) {
-        vext_set_elems_1s_le(vd, vta, (k * max_elems + vl) * esz,
+        vext_set_elems_1s(vd, vta, esz, k * max_elems + vl,
                           (k * max_elems + max_elems) * esz);
     }
 }
@@ -213,7 +213,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
                 /* set masked-off elements to 1s */
-                vext_set_elems_1s_le(vd, vma, (i + k * max_elems) * esz,
+                vext_set_elems_1s(vd, vma, esz, i + k * max_elems,
                                   (i + k * max_elems + 1) * esz);
                 k++;
                 continue;
@@ -393,7 +393,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
                 /* set masked-off elements to 1s */
-                vext_set_elems_1s_le(vd, vma, (i + k * max_elems) * esz,
+                vext_set_elems_1s(vd, vma, esz, i + k * max_elems,
                                   (i + k * max_elems + 1) * esz);
                 k++;
                 continue;
@@ -523,7 +523,7 @@ ProbeSuccess:
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
                 /* set masked-off elements to 1s */
-                vext_set_elems_1s_le(vd, vma, (i + k * max_elems) * esz,
+                vext_set_elems_1s(vd, vma, esz, i + k * max_elems,
                                   (i + k * max_elems + 1) * esz);
                 k++;
                 continue;
@@ -887,7 +887,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     }                                                         \
     env->vstart = 0;                                          \
     /* set tail elements to 1s */                             \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);  \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);   \
 }
 
 GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC)
@@ -918,7 +918,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     }                                                                    \
     env->vstart = 0;                                                     \
     /* set tail elements to 1s */                                        \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);             \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);              \
 }
 
 GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC)
@@ -1082,7 +1082,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         TS1 s1 = *((TS1 *)vs1 + HS1(i));                                  \
@@ -1091,7 +1091,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7)
@@ -1129,7 +1129,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     for (i = env->vstart; i < vl; i++) {                    \
         if (!vm && !vext_elem_mask(v0, i)) {                \
             /* set masked-off elements to 1s */             \
-            vext_set_elems_1s_le(vd, vma, i * esz,             \
+            vext_set_elems_1s(vd, vma, esz, i,              \
                               (i + 1) * esz);               \
             continue;                                       \
         }                                                   \
@@ -1138,7 +1138,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     }                                                       \
     env->vstart = 0;                                        \
     /* set tail elements to 1s */                           \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);\
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz); \
 }
 
 GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7)
@@ -1806,7 +1806,7 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     }                                                                \
     env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);          \
 }
 
 GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1)
@@ -1829,7 +1829,7 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     }                                                                \
     env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);          \
 }
 
 GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1)
@@ -1853,7 +1853,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     }                                                                \
     env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);          \
 }
 
 GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1)
@@ -1879,7 +1879,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     }                                                                \
     env->vstart = 0;                                                 \
     /* set tail elements to 1s */                                    \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);         \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);          \
 }
 
 GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1)
@@ -1919,7 +1919,7 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);
             continue;
         }
         fn(vd, vs1, vs2, i, env, vxrm);
@@ -1958,7 +1958,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
         break;
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);
 }
 
 /* generate helpers for fixed point instructions with OPIVV format */
@@ -2044,7 +2044,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);
             continue;
         }
         fn(vd, s1, vs2, i, env, vxrm);
@@ -2083,7 +2083,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
         break;
     }
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);
 }
 
 /* generate helpers for fixed point instructions with OPIVX format */
@@ -2841,7 +2841,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             /* set masked-off elements to 1s */           \
-            vext_set_elems_1s_le(vd, vma, i * ESZ,           \
+            vext_set_elems_1s(vd, vma, ESZ, i,            \
                               (i + 1) * ESZ);             \
             continue;                                     \
         }                                                 \
@@ -2849,7 +2849,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     }                                                     \
     env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
-    vext_set_elems_1s_le(vd, vta, vl * ESZ,                  \
+    vext_set_elems_1s(vd, vta, ESZ, vl,                   \
                       total_elems * ESZ);                 \
 }
 
@@ -2884,7 +2884,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     for (i = env->vstart; i < vl; i++) {                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
             /* set masked-off elements to 1s */           \
-            vext_set_elems_1s_le(vd, vma, i * ESZ,           \
+            vext_set_elems_1s(vd, vma, ESZ, i,            \
                               (i + 1) * ESZ);             \
             continue;                                     \
         }                                                 \
@@ -2892,7 +2892,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     }                                                     \
     env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
-    vext_set_elems_1s_le(vd, vta, vl * ESZ,                  \
+    vext_set_elems_1s(vd, vta, ESZ, vl,                   \
                       total_elems * ESZ);                 \
 }
 
@@ -3473,14 +3473,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
             /* set masked-off elements to 1s */        \
-            vext_set_elems_1s_le(vd, vma, i * ESZ,        \
+            vext_set_elems_1s(vd, vma, ESZ, i,         \
                               (i + 1) * ESZ);          \
             continue;                                  \
         }                                              \
         do_##NAME(vd, vs2, i, env);                    \
     }                                                  \
     env->vstart = 0;                                   \
-    vext_set_elems_1s_le(vd, vta, vl * ESZ,               \
+    vext_set_elems_1s(vd, vta, ESZ, vl,                \
                       total_elems * ESZ);              \
 }
 
@@ -4228,7 +4228,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     }                                                         \
     env->vstart = 0;                                          \
     /* set tail elements to 1s */                             \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);  \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);   \
 }
 
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2)
@@ -4397,7 +4397,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     *((TD *)vd + HD(0)) = s1;                             \
     env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
-    vext_set_elems_1s_le(vd, vta, esz, vlenb);               \
+    vext_set_elems_1s(vd, vta, esz, 1, vlenb);            \
 }
 
 /* vd[0] = sum(vs1[0], vs2[*]) */
@@ -4483,7 +4483,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     *((TD *)vd + HD(0)) = s1;                              \
     env->vstart = 0;                                       \
     /* set tail elements to 1s */                          \
-    vext_set_elems_1s_le(vd, vta, esz, vlenb);                \
+    vext_set_elems_1s(vd, vta, esz, 1, vlenb);             \
 }
 
 /* Unordered sum */
@@ -4708,7 +4708,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = sum;                                      \
@@ -4718,7 +4718,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 GEN_VEXT_VIOTA_M(viota_m_b, uint8_t,  H1)
@@ -4741,14 +4741,14 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = i;                                        \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 GEN_VEXT_VID_V(vid_v_b, uint8_t,  H1)
@@ -4777,13 +4777,13 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     for (i = i_min; i < vl; i++) {                                        \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
@@ -4810,7 +4810,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     for (i = env->vstart; i < i_max; ++i) {                               \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + s1));              \
@@ -4824,7 +4824,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                                                                           \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
@@ -4850,7 +4850,7 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     for (i = env->vstart; i < vl; i++) {                                    \
         if (!vm && !vext_elem_mask(v0, i)) {                                \
             /* set masked-off elements to 1s */                             \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);             \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);              \
             continue;                                                       \
         }                                                                   \
         if (i == 0) {                                                       \
@@ -4861,7 +4861,7 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     }                                                                       \
     env->vstart = 0;                                                        \
     /* set tail elements to 1s */                                           \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);                \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);                 \
 }
 
 GEN_VEXT_VSLIE1UP(8,  H1)
@@ -4899,7 +4899,7 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     for (i = env->vstart; i < vl; i++) {                                      \
         if (!vm && !vext_elem_mask(v0, i)) {                                  \
             /* set masked-off elements to 1s */                               \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);            \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);                \
             continue;                                                         \
         }                                                                     \
         if (i == vl - 1) {                                                    \
@@ -4910,7 +4910,7 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     }                                                                         \
     env->vstart = 0;                                                          \
     /* set tail elements to 1s */                                             \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);               \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);                   \
 }
 
 GEN_VEXT_VSLIDE1DOWN(8,  H1)
@@ -4974,7 +4974,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         index = *((TS1 *)vs1 + HS1(i));                                   \
@@ -4986,7 +4986,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
@@ -5017,7 +5017,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);           \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);            \
             continue;                                                     \
         }                                                                 \
         if (index >= vlmax) {                                             \
@@ -5028,7 +5028,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 /* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
@@ -5057,7 +5057,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);               \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
@@ -5098,14 +5098,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     for (i = env->vstart; i < vl; i++) {                         \
         if (!vm && !vext_elem_mask(v0, i)) {                     \
             /* set masked-off elements to 1s */                  \
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);  \
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);   \
             continue;                                            \
         }                                                        \
         *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));       \
     }                                                            \
     env->vstart = 0;                                             \
     /* set tail elements to 1s */                                \
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);     \
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);      \
 }
 
 GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1)
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 455be96996..0166e81e02 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -100,14 +100,14 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);
             continue;
         }
         fn(vd, vs1, vs2, i);
     }
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);
 }
 
 void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
@@ -124,12 +124,12 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
-            vext_set_elems_1s_le(vd, vma, i * esz, (i + 1) * esz);
+            vext_set_elems_1s(vd, vma, esz, i, (i + 1) * esz);
             continue;
         }
         fn(vd, s1, vs2, i);
     }
     env->vstart = 0;
     /* set tail elements to 1s */
-    vext_set_elems_1s_le(vd, vta, vl * esz, total_elems * esz);
+    vext_set_elems_1s(vd, vta, esz, vl, total_elems * esz);
 }
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index c96e52f926..de7d2681e6 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -156,7 +156,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     for (i = env->vstart; i < vl; i++) {               \
         if (!vm && !vext_elem_mask(v0, i)) {           \
             /* set masked-off elements to 1s */        \
-            vext_set_elems_1s_le(vd, vma, i * ESZ,        \
+            vext_set_elems_1s(vd, vma, ESZ, i,         \
                               (i + 1) * ESZ);          \
             continue;                                  \
         }                                              \
@@ -164,7 +164,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     }                                                  \
     env->vstart = 0;                                   \
     /* set tail elements to 1s */                      \
-    vext_set_elems_1s_le(vd, vta, vl * ESZ,               \
+    vext_set_elems_1s(vd, vta, ESZ, vl,                \
                       total_elems * ESZ);              \
 }
 
-- 
2.41.0


