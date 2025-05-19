Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8065C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3S-0000fA-6w; Mon, 19 May 2025 00:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnq-0006aY-Lo; Mon, 19 May 2025 00:08:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrno-0004E1-E2; Mon, 19 May 2025 00:08:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so50988975ad.0; 
 Sun, 18 May 2025 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627714; x=1748232514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruf1j0nP1SwXf+YKRbMUui7Aq4aZBAxDrN7XhtLdW6I=;
 b=grs8qjr2t/N7Vt027BY40YDTbn0lay8oa6XFtLoW5hIjVUl3WzNCKiVD3yJFBMwCCH
 1o0YljSZi//nSWqLn2lnFfbzs5qqPLU9YJvwt+GApvSYvI/cPbM1F9eCPcimEAZ150VD
 TeW3c6C4kHv5e2Lj1qlX8Cowu2zGPwn4UYtUER4s2RNEfsWwc9T4N/tC/8qu5Gu8Al2s
 sQ17z3NUdPf64rw8XEPPe5wD66p74pxxHGgXBdVkWkjznQJcDbLXJt8f0Axi7fdbGESe
 ygz66gyn9OIpUXwuaUlhw+JaiPsQIlF5xrfPrzjfVSjirL7b7NRUobPZp+Oraa0yiiMU
 21Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627714; x=1748232514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruf1j0nP1SwXf+YKRbMUui7Aq4aZBAxDrN7XhtLdW6I=;
 b=Ef0wiZUN77RslRy2Qde+LB2TVBCHwizvTkM3k8i3Pirrvwtd9TPwwviLkNjogkiLT1
 OOwCzQMb6WB1fhObT7XITcz6mpXomNq8sUEnurLmhvlGTNmpCgVpoh6cafA7mghqbff0
 O7+GwF71iRuS9/HuvWCQ/zKa94anCQuqTGLausl3tA4NT1xTnPt3vfNjEjUYF8fed+p1
 qjS0T35Lwuh9X4GKG5p0dcFPuzkAlWjvhwY2ajJoZKTo57bTxdGsmMosg2ruaGOineHW
 gas3FtALFgBoB3KJecCPpLaLeeARYYfGExD5DevoHuMozGrJ5buIfozDnsi2qIv+g5IZ
 EO5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKZEmUIeNHf3uJOJHbakiGw+D7rYn3hF25kQDAup1OxjQcmp+hPRGWyTd8Xv/D/3mhPeioVBukS05FHw==@nongnu.org
X-Gm-Message-State: AOJu0Yyz0GxiCKKMothfRhfXWoFze/LvmmuwIFgr1YBERtyObnZuazDx
 yDI9kJxQFwZFq7dwU4gHnw0nW25fgM9Pv2brLQuL82Y7IcnSxAXuPyWnPPeBtA==
X-Gm-Gg: ASbGncs3MrhPqUe6hJejymZY41OHyn8L1uxv2/os34TahkXYyfOa2h3Ts7VfIEVFR1z
 m3RG9sV5g3+Ky9ugnCwc9n+MlQ5LYEL7+33y6hE6BjXLZwT21mqguuZYF5HilgB6CFAKGoyGSct
 t/HtKECa7LCfstYPVTkvpW80VenLoB21SRW6Rx2Ci12uy1c0H9UOTbJ1CG5/cF561Ep4+21C6tl
 23oQAE1+2PU93nIqRGJnHn6PHWaqmg/fFtHzujPadlIAI9IXG+79XBPw7ivcfJKhjEhq3xOMO6+
 z0ZynEppz8sZP3dv6CIZ8fIC0b/xnBDUrTsTQXPz+ux8tNRobiQQv03MG8qNQuySon6EX/jIc8W
 t+RwJwjkFxmFkzY+dg6iXkftEhDW50QD1/d20dDbyH7ieLLY9Kw7QDioa
X-Google-Smtp-Source: AGHT+IFSXYa0BIukxCQms0bdOCB6HAsX+ueJuWDO9Kz5EoUyjAonK5S04jnAYpNiU0r7XpUS6IyatQ==
X-Received: by 2002:a17:902:da91:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-231d4ae1de4mr159808625ad.3.1747627714039; 
 Sun, 18 May 2025 21:08:34 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 27/56] target/riscv: rvv: Apply vext_check_input_eew to vector
 narrow/widen instructions
Date: Mon, 19 May 2025 14:05:24 +1000
Message-ID: <20250519040555.3797167-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  9 ++-
 target/riscv/insn_trans/trans_rvv.c.inc    | 77 +++++++++++++++++-----
 2 files changed, 68 insertions(+), 18 deletions(-)

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
index 954f03291b..1d2b46fc44 100644
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
 
@@ -1815,6 +1821,16 @@ static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -1862,6 +1878,14 @@ static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -2333,13 +2357,13 @@ GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
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
@@ -2680,6 +2704,17 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -2719,6 +2754,16 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -2843,14 +2888,14 @@ GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
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
2.49.0


