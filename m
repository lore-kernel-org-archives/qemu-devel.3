Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1E3E7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14G-0005iN-Hi; Mon, 02 Feb 2026 16:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn13v-000362-4g; Mon, 02 Feb 2026 16:02:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn13o-0004XJ-7L; Mon, 02 Feb 2026 16:02:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D0451851B2;
 Mon, 02 Feb 2026 23:57:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5722835B329;
 Mon, 02 Feb 2026 23:58:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 38/74] target/i386/tcg: mask addresses for VSIB
Date: Mon,  2 Feb 2026 23:57:49 +0300
Message-ID: <20260202205833.941615-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

VSIB can have either 32-bit or 64-bit addresses, pass a constant mask to
the helper and apply it before the load.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5e3572ef2e94608568b1a73eab9d382b250936eb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index a2e4d48039..853196b2bb 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2362,42 +2362,42 @@ void glue(helper_vpmaskmovq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 void glue(helper_vpgatherdd, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (2 << SHIFT); i++) {
         if (v->L(i) >> 31) {
             target_ulong addr = a0
                 + ((target_ulong)(int32_t)s->L(i) << scale);
-            d->L(i) = cpu_ldl_data_ra(env, addr, GETPC());
+            d->L(i) = cpu_ldl_data_ra(env, addr & amask, GETPC());
         }
         v->L(i) = 0;
     }
 }
 
 void glue(helper_vpgatherdq, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->Q(i) >> 63) {
             target_ulong addr = a0
                 + ((target_ulong)(int32_t)s->L(i) << scale);
-            d->Q(i) = cpu_ldq_data_ra(env, addr, GETPC());
+            d->Q(i) = cpu_ldq_data_ra(env, addr & amask, GETPC());
         }
         v->Q(i) = 0;
     }
 }
 
 void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->L(i) >> 31) {
             target_ulong addr = a0
                 + ((target_ulong)(int64_t)s->Q(i) << scale);
-            d->L(i) = cpu_ldl_data_ra(env, addr, GETPC());
+            d->L(i) = cpu_ldl_data_ra(env, addr & amask, GETPC());
         }
         v->L(i) = 0;
     }
@@ -2408,14 +2408,14 @@ void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
 }
 
 void glue(helper_vpgatherqq, SUFFIX)(CPUX86State *env,
-        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale)
+        Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
     for (i = 0; i < (1 << SHIFT); i++) {
         if (v->Q(i) >> 63) {
             target_ulong addr = a0
                 + ((target_ulong)(int64_t)s->Q(i) << scale);
-            d->Q(i) = cpu_ldq_data_ra(env, addr, GETPC());
+            d->Q(i) = cpu_ldq_data_ra(env, addr & amask, GETPC());
         }
         v->Q(i) = 0;
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 1a7fab9333..12e7f5f943 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -43,8 +43,8 @@ typedef void (*SSEFunc_0_pppi)(TCGv_ptr reg_a, TCGv_ptr reg_b, TCGv_ptr reg_c,
                                TCGv_i32 val);
 typedef void (*SSEFunc_0_eppt)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
                                TCGv val);
-typedef void (*SSEFunc_0_epppti)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
-                                 TCGv_ptr reg_c, TCGv a0, TCGv_i32 scale);
+typedef void (*SSEFunc_0_eppptit)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
+                                 TCGv_ptr reg_c, TCGv a0, TCGv_i32 scale, TCGv amask);
 typedef void (*SSEFunc_0_eppppi)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
                                   TCGv_ptr reg_c, TCGv_ptr reg_d, TCGv_i32 flags);
 typedef void (*SSEFunc_0_eppppii)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
@@ -1098,18 +1098,19 @@ VEXW_AVX(VPMASKMOV, vpmaskmov)
 
 /* Same as above, but with extra arguments to the helper.  */
 static inline void gen_vsib_avx(DisasContext *s, X86DecodedInsn *decode,
-                                SSEFunc_0_epppti d_xmm, SSEFunc_0_epppti q_xmm,
-                                SSEFunc_0_epppti d_ymm, SSEFunc_0_epppti q_ymm)
+                                SSEFunc_0_eppptit d_xmm, SSEFunc_0_eppptit q_xmm,
+                                SSEFunc_0_eppptit d_ymm, SSEFunc_0_eppptit q_ymm)
 {
-    SSEFunc_0_epppti d = s->vex_l ? d_ymm : d_xmm;
-    SSEFunc_0_epppti q = s->vex_l ? q_ymm : q_xmm;
-    SSEFunc_0_epppti fn = s->vex_w ? q : d;
+    SSEFunc_0_eppptit d = s->vex_l ? d_ymm : d_xmm;
+    SSEFunc_0_eppptit q = s->vex_l ? q_ymm : q_xmm;
+    SSEFunc_0_eppptit fn = s->vex_w ? q : d;
     TCGv_i32 scale = tcg_constant_i32(decode->mem.scale);
     TCGv_ptr index = tcg_temp_new_ptr();
+    TCGv mask = tcg_constant_tl(MAKE_64BIT_MASK(0, 8 << s->aflag));
 
     /* Pass third input as (index, base, scale) */
     tcg_gen_addi_ptr(index, tcg_env, ZMM_OFFSET(decode->mem.index));
-    fn(tcg_env, OP_PTR0, OP_PTR1, index, s->A0, scale);
+    fn(tcg_env, OP_PTR0, OP_PTR1, index, s->A0, scale, mask);
 
     /*
      * There are two output operands, so zero OP1's high 128 bits
diff --git a/target/i386/tcg/ops_sse_header.h.inc b/target/i386/tcg/ops_sse_header.h.inc
index d92c6faf6d..bbeb7301c3 100644
--- a/target/i386/tcg/ops_sse_header.h.inc
+++ b/target/i386/tcg/ops_sse_header.h.inc
@@ -388,10 +388,10 @@ DEF_HELPER_4(glue(vpmaskmovd_st, SUFFIX), void, env, Reg, Reg, tl)
 DEF_HELPER_4(glue(vpmaskmovq_st, SUFFIX), void, env, Reg, Reg, tl)
 DEF_HELPER_4(glue(vpmaskmovd, SUFFIX), void, env, Reg, Reg, Reg)
 DEF_HELPER_4(glue(vpmaskmovq, SUFFIX), void, env, Reg, Reg, Reg)
-DEF_HELPER_6(glue(vpgatherdd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
-DEF_HELPER_6(glue(vpgatherdq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
-DEF_HELPER_6(glue(vpgatherqd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
-DEF_HELPER_6(glue(vpgatherqq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32)
+DEF_HELPER_7(glue(vpgatherdd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
+DEF_HELPER_7(glue(vpgatherdq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
+DEF_HELPER_7(glue(vpgatherqd, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
+DEF_HELPER_7(glue(vpgatherqq, SUFFIX), void, env, Reg, Reg, Reg, tl, i32, tl)
 #if SHIFT == 2
 DEF_HELPER_3(vpermd_ymm, void, Reg, Reg, Reg)
 DEF_HELPER_4(vpermdq_ymm, void, Reg, Reg, Reg, i32)
-- 
2.47.3


