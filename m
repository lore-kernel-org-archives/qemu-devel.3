Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07D8C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJACT-00020Z-2y; Sun, 25 May 2025 08:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJAAg-0005Ac-4V; Sun, 25 May 2025 08:09:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJAAc-0003YE-AK; Sun, 25 May 2025 08:09:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B74F124E5A;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 15EBF215FC1;
 Sun, 25 May 2025 15:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 40/59] target/riscv: rvv: Apply vext_check_input_eew
 to vector narrow/widen instructions
Date: Sun, 25 May 2025 15:07:57 +0300
Message-Id: <20250525120818.273372-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

Handle the overlap of source registers with different EEWs.
The vd of vector widening mul-add instructions is one of the input
operands.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-9-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 1f090a229f85e662394267680408bd31fd0a99c9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 0a9cd1ec31..066dc364c5 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -119,8 +119,11 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
     REQUIRE_FPU;
     REQUIRE_ZVFBFWMA(ctx);
 
+    uint8_t sew = ctx->sew;
     if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew == MO_16) &&
-        vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
+        vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm) &&
+        vext_check_input_eew(ctx, a->rd, sew + 1, a->rs1, sew, a->vm) &&
+        vext_check_input_eew(ctx, a->rd, sew + 1, a->rs2, sew, a->vm)) {
         uint32_t data = 0;
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
@@ -146,8 +149,10 @@ static bool trans_vfwmaccbf16_vf(DisasContext *ctx, arg_vfwmaccbf16_vf *a)
     REQUIRE_FPU;
     REQUIRE_ZVFBFWMA(ctx);
 
+    uint8_t sew = ctx->sew;
     if (require_rvv(ctx) && (ctx->sew == MO_16) && vext_check_isa_ill(ctx) &&
-        vext_check_ds(ctx, a->rd, a->rs2, a->vm)) {
+        vext_check_ds(ctx, a->rd, a->rs2, a->vm) &&
+        vext_check_input_eew(ctx, a->rd, sew + 1, a->rs2, sew, a->vm)) {
         uint32_t data = 0;
 
         gen_set_rm(ctx, RISCV_FRM_DYN);
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 585ee98b27..2d067a59e2 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -528,6 +528,7 @@ static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
 static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 {
     return vext_wide_check_common(s, vd, vm) &&
+           vext_check_input_eew(s, vs, s->sew, -1, 0, vm) &&
            require_align(vs, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs, s->lmul);
 }
@@ -535,6 +536,7 @@ static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 {
     return vext_wide_check_common(s, vd, vm) &&
+           vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm) &&
            require_align(vs, s->lmul + 1);
 }
 
@@ -553,6 +555,7 @@ static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
            require_align(vs1, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs1, s->lmul);
 }
@@ -575,12 +578,14 @@ static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs1, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
            require_align(vs2, s->lmul + 1);
 }
 
 static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
 {
-    bool ret = vext_narrow_check_common(s, vd, vs, vm);
+    bool ret = vext_narrow_check_common(s, vd, vs, vm) &&
+               vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm);
     if (vd != vs) {
         ret &= require_noover(vd, s->lmul, vs, s->lmul + 1);
     }
@@ -603,6 +608,7 @@ static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_sd(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
            require_align(vs1, s->lmul);
 }
 
@@ -1531,6 +1537,16 @@ static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
+/* OPIVV with overwrite and WIDEN */
+static bool opivv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs1, s->sew, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            gen_helper_gvec_4_ptr *fn,
                            bool (*checkfn)(DisasContext *, arg_rmrr *))
@@ -1578,6 +1594,14 @@ static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
+static bool opivx_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 #define GEN_OPIVX_WIDEN_TRANS(NAME, CHECK) \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
 {                                                                         \
@@ -2049,13 +2073,13 @@ GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
 
 /* Vector Widening Integer Multiply-Add Instructions */
-GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_overwrite_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_overwrite_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_overwrite_widen_check)
 
 /* Vector Integer Merge and Move Instructions */
 static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
@@ -2396,6 +2420,17 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
+static bool opfvv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs1, s->sew, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 /* OPFVV with WIDEN */
 #define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
@@ -2435,6 +2470,16 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
+static bool opfvf_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 /* OPFVF with WIDEN */
 #define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
@@ -2559,14 +2604,14 @@ GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
 
 /* Vector Widening Floating-Point Fused Multiply-Add Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_overwrite_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.39.5


