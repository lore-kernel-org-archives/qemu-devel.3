Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2185C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzo-00018n-09; Wed, 08 Jul 2026 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzm-00018M-77
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzk-00074b-G3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cace91f112so9698595ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527571; x=1784132371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d1KhmcESwLH150n44WbyB6xyj+p1NFPfgYQqqrbdI3E=;
 b=GTnS9q/etdkmKXpsePweYXyyW02fY7Odi2E88GNJhwyJFrP6bj70OXlY5iW1pR06gG
 CZTLQkr1S6m847lr+zOYJus6ikhwCUb+wjVdpyS3g4sGkdq1Uuo0pk95mmAEswWyUlvO
 zfHFgbSYTPNEGp6a2lVmW63dgoqnsGJjVTD2CrYIxTR6r6i9FtfFoHY4a4svT3b3zxqI
 FkS1RqlrG3J8Dth1RIMa/KJZYHH/F4WpA5UWNXYHZaI/7aRMI6r1AnQLbpH5zQHFhWPU
 JGYdqgiMA2ANAqGdcpULNm0MINUNY/3JbZLrGrEAq5xnqXCbZtvHvaYjeywumpxhfTQ9
 /JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527571; x=1784132371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d1KhmcESwLH150n44WbyB6xyj+p1NFPfgYQqqrbdI3E=;
 b=VRNYcjpthIBQyU2dvfvhnIue6y12OXbXM9Ipx9GJl8g4ZxsJDp2gb+fbOnsBse8TzZ
 0APGU3WURpywmEsZNJavK/Sm3aRYInBjX7iWjDzuiGYc1CllgvID2Kwgxr/WllXq4HzZ
 WNOZFtQWzF6gnY0twiyrk3wdaCRx+TplPy5ab5SGkGJfNzOVsBeCHnZZj13jOirH+NKB
 GGhuuwRndGEc6jWpCOdYLvabR/F7YB8UeOxfv6/XCANBs24hg/+wSMY64OdnCg0bWDhM
 y2pvIB+sYshE82A4n8asndT5LQ38/GmvXzJGSm98koDwkJdEf6eZzLIgwjsUSvDu+vN/
 o4Ww==
X-Gm-Message-State: AOJu0YxOgEWEZf3H9XfAg3rE6QnYa27c9K46Txzmp2s8xiCL8yuCOdqk
 fdOfnu2I7WRFljt5AkD4GWqA8FiSu1AB0iDBt9M8qGsWLas8J71FOPNlboRT/LMFj4a80r99lFg
 x8umEkbNKLUpT8P41tNQfoGwzubbx50t6ugry0FlDOEsrkv+Zy2tYabV/6D30CH6pd+l5lk5QCJ
 jRHXHRJ/05WUc92wZt3zwZK/xZA2R9+nuXzpXc1TE=
X-Gm-Gg: AfdE7cnOL4Vhy8sdi90I0aGQOqhjZCfm/5orb4HHQ6uDMCc3UVuBoJhWKTI1Dxpo1pK
 tvKS8cgOIEgPuKVhLE/0t2DfYUCuTQaNjlu11XOtHDl5lR9y5kK2uM4mR8qfDvj8ah+8drQSFbL
 HedHtauJoJOxFx+sRCDZBpFx/ek0r6JxuMM3wUQyvUUmRLlKj9rwRCA5ljC1/DYPdj9RbQFfBSf
 ru6kE/c0vaQMjnDks/cKhA9hvnp8Vd0cO9evlJ9vOWLO+c4SNuEDPrNWQkLcKTyEHrzb06a9lNb
 jdhoLr/OAQHjYI553A/digIM82INb3Wa9TQRkn3w1rerKn8inGyVQsJIOrbtRJ/PrDsudNP1iWT
 R81B9kdVxvX+Me7ireRAeJOQWcYZ0wFE6wFADOanw1gXKmdYWsC3Ap1PG3Nq5yUArcplrQFJJ2Q
 KH8HOoBiuntZ3dwSpAUgE4GTZIt6OUhowoKPamlSuasgd8sD8+xAkgSIXX//nJWnrMgiwCR5WAH
 Xbmxl0mzdxsp4fS
X-Received: by 2002:a17:902:f68d:b0:2c9:960c:f73b with SMTP id
 d9443c01a7336-2ccea4645ddmr32597665ad.24.1783527570688; 
 Wed, 08 Jul 2026 09:19:30 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:30 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 8/9] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Date: Thu,  9 Jul 2026 00:18:58 +0800
Message-ID: <20260708161859.1124848-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
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
FP32 elements to a vector of OFP8 elements. The vfncvt.sat.f.f.q instruction
converts a vector of FP32 elements to a vector of OFP8 elements with saturation.
The VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: FP32 to OFP8.e4m3
* altfmt = 1: FP32 to OFP8.e5m2

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode                    |  2 +
 .../riscv/tcg/insn_trans/trans_rvofp8.c.inc   | 63 +++++++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc   | 40 ++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d690dc3bc1..8a0551abd7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -974,6 +974,8 @@ vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
 
 # *** Zvfofp8min Extension ***
+vfncvt_f_f_q          010010 . ..... 11001 001 ..... 1010111 @r2_vm
+vfncvt_sat_f_f_q      010010 . ..... 11011 001 ..... 1010111 @r2_vm
 vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
 
 # *** Zvbc vector crypto extension ***
diff --git a/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc b/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc
index d28f92e050..619ee4d773 100644
--- a/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc
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
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 23262b1d03..cccd0f5a25 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -621,6 +621,46 @@ static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
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
+    bool ret = vext_quad_narrow_check_common(s, vd, vs, vm) &&
+               vext_check_input_eew(s, vs, s->sew + 2, -1, 0, vm);
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
2.55.0


