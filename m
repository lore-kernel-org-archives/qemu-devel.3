Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B45FD2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciE-0002wG-D8; Tue, 27 Jan 2026 01:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci7-0002tA-SO
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:00 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci6-0006kX-7s
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:59 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so30272135ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495876; x=1770100676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSipeGHekKq/Th8UdKMG6p6qZH5c26imSBj5IlO1nPg=;
 b=IxeVzypCDEYfEwSuEXG+MlnxLITo4+zMRIMS60RXSx2Iy7AY93jyY6vpfdEFEdeDtN
 GvyKKmvJDS+J2PaY18CTsIpr1usM9kOsD2QO8+ki+O60Z0FTrq8/G7M7ozZiYpCLD7Co
 hXI3X2vsc9FAJ9Gfs1nm1Fg0hjWu3zjk8bxxGHVVzjnjbEqHcHgr2Vv+IJiMtg3WModo
 cLp712o72IVPCn+uK2/xFuNVOoqFhP+iGmVeJF3XZqVzHNaAOvdX/Z6U5MYcWxqa2Pd/
 lCgmyUM7D/2XjN4RMJD2S/XnK1LLqT+EDXHXCuJ8W5fJwkC6kfjuY8ibaJmPn93WTpKO
 cWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495876; x=1770100676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fSipeGHekKq/Th8UdKMG6p6qZH5c26imSBj5IlO1nPg=;
 b=fXRPuUL30F6ov1+/DKrVmZkZgRnk2y0pZToi3Wu5PKB+/MEfRNxJ2ueLkCPxHoT9E2
 5aEROpoRKx5BWZ9n83VoDUk1ptxQ4Zi18sEIbo1w8YTbktI1xrCxyWSBR9KW/gIMnAAP
 Ac9xgPMV9wDCtxae6mZQY629YDYnAFm/exrOHgqqdy/JbmXH2A+0S743228hXVnMaeG6
 T/wIlzk2wCiZ0YsRTB5zGyIlP62CPDBbg5E92kt1tDP5T8sx2S+4gtGCIZ9RPO9z7Kky
 n5CHSTOn/I8DW0EBTfSz0UeLCsT2+AeqINPxmwdATMoul4UXPJg6HPGhe1bbyObAmUaf
 qGBA==
X-Gm-Message-State: AOJu0Yy7zqVrVLbRW5uJcQ9VF84dj0onWzzTAYRy2MCgCcx1IUR6k5Ii
 /3jzbQs+6lSmW3nqNXVTs+K02Oh4ilHUAdnwswR6QYbcmoK3Dcpp+fqyvrvyf+F6cytfDgsohRf
 fjA0wB0DVbe7d1+eM70hIaUZXvKpwNGFNi/gZe0UKvYhpy6KdCMhElXCLg+pUo26HRfxBUkwHOA
 wV2BEYU4B9iPNFCx9wUMolsiPFk6mAYZHMWhQMFae6lg==
X-Gm-Gg: AZuq6aKWW20+lCdzbjQygvTZbOTofAK5LmObOXTfNllV9x1S0nwN0OTeSEz9FmHnL+f
 eNJjdxrHBaNbfPBAwppEIlkW4ODBb5JKYFWSc3iJsjSLUfME1uCY0tyCv7Gmltfdc8Lq04hunli
 seFijkJ7t9JEoqiWMC3V1ypvVS4P1KPNi9X8TujGq1AFZ6fHoBMldwCy3o+rkTvSJKX++WPucMl
 PhfAOBCeNtT4AIHYdzYpgKbmnoyGA9hDUNQAfDtk2pKvTYYzOUDkftGiDcukX6qgNkJnPOuYI2O
 O4mbzeFkrFkNUIh6dd0jSpT2K+jKSN0InDOtu+/R86kb7NjtHsWF6R+ClG4inOBXFemAIRzkvx7
 noQbA+420nWOrt8wAm8WxSHWWisZy65/3tUOWeOj0uH0+k326q5vtpoMDcQtyAqIrVG3hVqnLyN
 P2GI9bsh84hi8Iq6Im847Na+bo0L9LaV/3gKp8fGVaWEdtsoz+WZynMuwITao2i84oVwU59N440
 wsCIO3E/EXOJxU=
X-Received: by 2002:a17:903:906:b0:2a7:c340:4c3d with SMTP id
 d9443c01a7336-2a870d58b2fmr6918555ad.13.1769495876008; 
 Mon, 26 Jan 2026 22:37:56 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:55 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 10/17] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Date: Tue, 27 Jan 2026 14:37:16 +0800
Message-ID: <20260127063723.442734-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
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

The vfncvt.f.f.q and vfncvt.sat.f.f.q instructions convert a vector of
FP32 elements to a vector of OFP8 elements. The vfncvt.sat.f.fq instruction
converts a vector of FP32 elements to a vector of OFP8 elements with saturation.
The VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: FP32 to OFP8.e4m3
* altfmt = 1: FP32 to OFP8.e5m2

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode                 |  2 +
 target/riscv/insn_trans/trans_rvofp8.c.inc | 63 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    | 39 ++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 49201c0c20..f2b413c7d4 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -974,6 +974,8 @@ vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
 
 # *** Zvfofp8min Extension ***
+vfncvt_f_f_q          010010 . ..... 11001 001 ..... 1010111 @r2_vm
+vfncvt_sat_f_f_q      010010 . ..... 11011 001 ..... 1010111 @r2_vm
 vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
 
 # *** Zvbc vector crypto extension ***
diff --git a/target/riscv/insn_trans/trans_rvofp8.c.inc b/target/riscv/insn_trans/trans_rvofp8.c.inc
index f1a7b0affd..8851209660 100644
--- a/target/riscv/insn_trans/trans_rvofp8.c.inc
+++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
@@ -12,6 +12,13 @@
     }                                       \
 } while (0)
 
+static bool zvfofp8min_narrow_quad_check(DisasContext *s, arg_rmr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_sq(s, a->rd, a->rs2, a->vm) &&
+           (s->sew == MO_8);
+}
 
 static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
 {
@@ -41,3 +48,59 @@ static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
     return false;
 }
 
+static bool trans_vfncvt_f_f_q(DisasContext *ctx, arg_rmr *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFOFP8MIN(ctx);
+
+    if (zvfofp8min_narrow_quad_check(ctx, a)) {
+        gen_helper_gvec_3_ptr *fn;
+        uint32_t data = 0;
+
+        fn = ctx->altfmt ? gen_helper_vfncvt_f_f_q_ofp8e5m2 :
+                           gen_helper_vfncvt_f_f_q_ofp8e4m3;
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), tcg_env,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(ctx);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vfncvt_sat_f_f_q(DisasContext *ctx, arg_rmr *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFOFP8MIN(ctx);
+
+    if (zvfofp8min_narrow_quad_check(ctx, a)) {
+        gen_helper_gvec_3_ptr *fn;
+        uint32_t data = 0;
+
+        fn = ctx->altfmt ? gen_helper_vfncvt_sat_f_f_q_ofp8e5m2 :
+                           gen_helper_vfncvt_sat_f_f_q_ofp8e4m3;
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), tcg_env,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(ctx);
+        return true;
+    }
+    return false;
+}
+
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index bcd45b0aa3..9053b9fb57 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -621,6 +621,45 @@ static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
            require_align(vs1, s->lmul);
 }
 
+/*
+ * Common check function for vector narrowing instructions
+ * of single-width result (SEW) and quad-width source (4*SEW).
+ *
+ * Rules to be checked here:
+ *   1. The largest vector register group used by an instruction
+ *      can not be greater than 8 vector registers
+ *      (Section 31.5.2)
+ *   2. Quad-width SEW cannot greater than ELEN.
+ *      (Section 31.2)
+ *   3. Source vector register number is multiples of 4 * LMUL.
+ *      (Section 31.3.4.2)
+ *   4. Destination vector register number is multiples of LMUL.
+ *      (Section 31.3.4.2)
+ *   5. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 31.5.3)
+ * risc-v unprivileged spec
+ */
+static bool vext_quad_narrow_check_common(DisasContext *s, int vd, int vs2,
+                                          int vm)
+{
+    return (s->lmul <= 1) &&
+           (s->sew < MO_32) &&
+           ((s->sew + 2) <= (s->cfg_ptr->elen >> 4)) &&
+           require_align(vs2, s->lmul + 2) &&
+           require_align(vd, s->lmul) &&
+           require_vm(vm, vd);
+}
+
+static bool vext_check_sq(DisasContext *s, int vd, int vs, int vm)
+{
+    bool ret = vext_quad_narrow_check_common(s, vd, vs, vm);
+    if (vd != vs) {
+        ret &= require_noover(vd, s->lmul, vs, s->lmul + 2);
+    }
+    return ret;
+}
+
 /*
  * Check function for vector reduction instructions.
  *
-- 
2.52.0


