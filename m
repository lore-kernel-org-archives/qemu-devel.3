Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4402EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTj-0007dJ-8w; Wed, 04 Mar 2026 08:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSw-000770-Qd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:47 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSu-0005Hy-AV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:41 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-829756f3ee9so485397b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631639; x=1773236439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQhK6dmWDOa1gBz5c44K1WDUuXSMny0o88foILV0BxU=;
 b=FDhcDPXPyGvrL/pda8ArrGccXqdF+J8VyBADXNEvskDncpeodyVkDyEu3/zj2XkusB
 PflV7KDQpOP40TVPPMnJfdn9dTWuB8gDUgplhVam6+EfUhTgCzoHoPGIdyc4OnntDrkA
 /oO6JIiWm8JEjPxqiM1vVHXKhb/owaoftFTkcAPFVCN8DVnvsyZaGQAda5Rp16ZMnqXI
 B70CUmLZnJQXTkaqITFg9e6M8vx8nC1YrzZRZnn5swmTXjTFU+M24To354HrP2Kkc38T
 qMv4oKPk/nP7bNimT0JWLNDr7rPSaNCyPsmSLvK0GY9Mqa3BDSs1+FiHvknLSfWnI7Yo
 rU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631639; x=1773236439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wQhK6dmWDOa1gBz5c44K1WDUuXSMny0o88foILV0BxU=;
 b=a+RdryzkHmaA1+/A6+lDmy7Sg3Wg8mayU+DbR/J9mLSL4Z8+zyaSvI5nG5StR3EkEs
 w/0yJOZbU89USgDtGfrIQkquyVcb3Xi8Qa2OKm7OFB4kNbEduiEzzxgcZxKVHuCEZRAQ
 PhEfzYfZ7k4c5TrEKnJs4tQnPu3Ymkh1I6Q2cmIY/gO2elxtIWqvAAqKoTzoS9TI+8LW
 AXmFmtdLL8mMLJcZF8mr2qPlZwAQR5fQf/BQ6dCHvzWRpKDCKPtAKAZx3VTBTAD1tAci
 AnvQ7sSZdFQaC31QyQkNdqqYu/gtdhJ/jktgCbMgsLu+2nn5+UvdrSJF29Lim/f+khph
 R+VQ==
X-Gm-Message-State: AOJu0Yyky2PqfkEqjOw8H5NUltSvs2Rt3jr1SPNvdFRkdaIKvz5ixi38
 mu6gCmUK8IewlBXkyMsuf7RP5fzpEOrtUN39rX1Ni1ilPfwefycmWLln9JPBLVWZmDX3NCWC/Pq
 iBn+m3AwMTDiOuetlIG6sKkMifbhu/iTNzqaByx84DHvMtuU83ImaQvJPnxMxd2bekHHuEHZZUX
 Ge9JCg3cJrvGVfi9VNPpHCqJTbmLIjwvYqVxuHvRUUug==
X-Gm-Gg: ATEYQzzSTNi5JWxWtawGoMAxt80E36bC4LVqrM9mMc3Iy4wEwjoUBWISxaBawjCbvk/
 jt/Jdmv8tjSdLo06D4WfgynT9mOXOiMRU7TiKh7cI5hHKnlw7b3ZP2kfVwgZwAgz+obywBYzFr6
 szV+mLyUILDO3+aTPE57BVPzoSSN0QM4CchxeC5tvG87Dy0FL44TVW0M86rx34ilAuYP/IUEHQ5
 BJJOxJYBWp/sLATV5uTV8Zm/S3eHVFVZR1/7Djx/qwlVDcBnySw3sZ4KjSIN17Rk6DC5xhwYvNC
 +KJb6zANqTR5WqUuu1ayQhcvyTQcKa2vg2WRu1+GFPufIZfuRSpCyd2wSvSOOEVYrJ+KqLMW64I
 Ysk9RmaC+DvGg3M5Sb6Ykz5+4ame25fscVIUbRFpnd05BGuRaHnX6mt552zk6VWeH7v5d3kAUWv
 kEZqCcxOPLCwqf8kz4sv8frvnr7e3QcKF1rkw3dSqsuQZ7dPezREzbvNdpSYUzV/rJWl7zu+u8X
 eObhankF0Iwvn7XdYQG97hrBgc=
X-Received: by 2002:a05:6a00:4504:b0:81d:e9b1:b6e3 with SMTP id
 d2e1a72fcca58-8297291a6a5mr1846982b3a.14.1772631638669; 
 Wed, 04 Mar 2026 05:40:38 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:38 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 07/14] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Date: Wed,  4 Mar 2026 21:39:59 +0800
Message-ID: <20260304134006.2908449-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
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
index d28f92e050..619ee4d773 100644
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
@@ -40,3 +47,59 @@ static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
     }
     return false;
 }
+
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
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 161bf94a07..bbe864dd7c 100644
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


