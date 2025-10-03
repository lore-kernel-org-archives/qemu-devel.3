Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F9CCD183
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTs-0007U1-Bo; Thu, 02 Oct 2025 23:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTi-0007P0-DL
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:06 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTY-0001My-6U
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b555ab7fabaso1670433a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462133; x=1760066933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrYtjq67SLX3onjtinxyLh62+YNxAOIxYKTbQ6LotAs=;
 b=LJAbEXzcDr/8nluuB8/jMz2FleYn9rLpXmiDwm6F/EwKWTJEP9NgPI28R9kL0v/uYt
 IGLrqKz+yF703DkAB3KZmZKy2cYlTKB54uqj07vMv0XEe7q9+dE/icaJ/gmQnwdjMgkf
 k02VqK7yJIw/7xUGgyeRr/pvRKC0V3e5K8gIN5L4c4Qz+Zrf+PbVe6frrDPAJ3j4TCGK
 0BasPWc+l26Bw2tYqWVBY3Zs8fZY3yQNmC7h0+57BXX2bhQGquzwkmGQGUE/aN0DyVEY
 9Nb48VaUi6Pvv1wenzdUBIQD9S2tffPSJi6WCVcjIzWMDuvRNpLX9caQ0FVm3PxE9XAe
 SzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462133; x=1760066933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrYtjq67SLX3onjtinxyLh62+YNxAOIxYKTbQ6LotAs=;
 b=xRTOM1he7HECVB6Q4nlsoo5OdW+tj1hLVU1ukTBjTCZOdfwYxesPuM+ILaD4OcqwO0
 2RHx5PkTggZfwSGdTu55UhWaHQqI1CP9+7qnhi6P10brRJ+pHVFjjC7ciwaAoMEybyFI
 Vp+a9T/WtqPgU5xxpBXeHIU05ixtfdNDrvZX2VJjwA1mKkf8ocnjrB8Lov1DG+SzT93j
 OqazsjK8HGYYte8+CkP7P1oOR/Mmv7RpgIrPzbe/xqpoanfgZSilKzJDC8q+49Z4y4Is
 0RQrpyPBdbddnNTiqnB0lE65bVI3UK/Q/g0VimJ7etjhl8vp5cLqjyLCp1OgySBxqUVj
 BeYg==
X-Gm-Message-State: AOJu0YzDcy0cS7NjZRaATn3SMUQGugFvKiu3Cmcs6ld9X4Ic0XJAPOau
 I5aBPtbGrRkqT+3VvBLt9Q9KXvqkJcCjkXmH77qMNuyNv2vUp9TFuoLAdZpDUg==
X-Gm-Gg: ASbGncvxCZ33amCEm+b1ZNKheLVd07cTcKD9qKmZEyrDdpjdSVx+FQBdaUc0N9Edj0J
 STtp5H6T+JAfUxyPiKOUmQzOCxlPJtjq0X7IkIiXZw8dPqDXL8BcP7OiUYLxhoZLxhKN/9XGjDF
 C721atZoakdauqcJKh+VZSAi59IAY3XGp5Bay5AXvmXJTBTSLWhcH+66p608m88RilJCnnU9Y9r
 NZon6D94Ng0bvqd6kDAenRWsvFyp72aN36IxI4nkEXv4GIGcOYTmZBz/1dC3MO8KSp2e3M4aXVa
 q/8aC4Uk287Yt+0fLlefIkWVFq494EXBKmRHQgdv6duCr/b6ExxZPKR+mhGYb8gy6PnCKtcrrBt
 4nGwBQnGgkNVu3ZvV/EDHO7iWr0VHy4IOt47BKvdqDeIykC9hSY6UxGw64tDZ7nd0gZFv2ZWG1b
 3mkoaDBcMrFhu9t2uv2e8Efkg7FjZT4cBPkn5LRWszyutUazFxfbKuyhTOpWpC2IQ=
X-Google-Smtp-Source: AGHT+IHygG5ApOfzBkT4je3e3AlSvIJIv6TG4SrrYZeLXedQ4Qa7Z8RUtvPccu1McCLlO73qqo5xCg==
X-Received: by 2002:a05:6a20:9152:b0:248:4d59:93d5 with SMTP id
 adf61e73a8af0-32b62107eafmr1920667637.55.1759462132622; 
 Thu, 02 Oct 2025 20:28:52 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/26] target/riscv: rvv: Fix vslide1[up|down].vx unexpected
 result when XLEN=32 and SEW=64
Date: Fri,  3 Oct 2025 13:27:15 +1000
Message-ID: <20251003032718.1324734-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When XLEN is 32 and SEW is 64, the original implementation of
vslide1up.vx and vslide1down.vx helper functions fills the 32-bit value
of rs1 into the first element of the destination vector register (rd),
which is a 64-bit element.

This commit attempted to resolve the issue by extending the rs1 value
to 64 bits during the TCG translation phase to ensure that the helper
functions won't lost the higer 32 bits.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250124073325.2467664-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 16 ++++----
 target/riscv/vector_helper.c            | 20 +++++-----
 target/riscv/insn_trans/trans_rvv.c.inc | 50 ++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c82bacdc39..b785456ee0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1101,14 +1101,14 @@ DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, i64, ptr, env, i32)
 
 DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7c67d67a13..41ea223106 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5198,11 +5198,11 @@ GEN_VEXT_VSLIE1UP(16, H2)
 GEN_VEXT_VSLIE1UP(32, H4)
 GEN_VEXT_VSLIE1UP(64, H8)
 
-#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                     \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
-                  CPURISCVState *env, uint32_t desc)              \
-{                                                                 \
-    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);             \
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                   \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
@@ -5249,11 +5249,11 @@ GEN_VEXT_VSLIDE1DOWN(16, H2)
 GEN_VEXT_VSLIDE1DOWN(32, H4)
 GEN_VEXT_VSLIDE1DOWN(64, H8)
 
-#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                   \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
-                  CPURISCVState *env, uint32_t desc)              \
-{                                                                 \
-    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                 \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);         \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 71f98fb350..f4b5460340 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3561,7 +3561,6 @@ static bool slideup_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
-GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
 GEN_OPIVI_TRANS(vslideup_vi, IMM_ZX, vslideup_vx, slideup_check)
 
 static bool slidedown_check(DisasContext *s, arg_rmrr *a)
@@ -3572,9 +3571,56 @@ static bool slidedown_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
-GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
+typedef void gen_helper_vslide1_vx(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
+                                TCGv_env, TCGv_i32);
+
+#define GEN_OPIVX_VSLIDE1_TRANS(NAME, CHECK)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (CHECK(s, a)) {                                                  \
+        static gen_helper_vslide1_vx * const fns[4] = {                 \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,               \
+        };                                                              \
+                                                                        \
+        TCGv_ptr dest, src2, mask;                                      \
+        TCGv_i64 src1;                                                  \
+        TCGv_i32 desc;                                                  \
+        uint32_t data = 0;                                              \
+                                                                        \
+        dest = tcg_temp_new_ptr();                                      \
+        mask = tcg_temp_new_ptr();                                      \
+        src2 = tcg_temp_new_ptr();                                      \
+        src1 = tcg_temp_new_i64();                                      \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
+                                s->cfg_ptr->vlenb, data));              \
+                                                                        \
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           \
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
+        tcg_gen_ext_tl_i64(src1, get_gpr(s, a->rs1, EXT_SIGN));         \
+                                                                        \
+        fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
+                                                                        \
+        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        finalize_rvv_inst(s);                                           \
+                                                                        \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_OPIVX_VSLIDE1_TRANS(vslide1up_vx, slideup_check)
+GEN_OPIVX_VSLIDE1_TRANS(vslide1down_vx, slidedown_check)
+
 /* Vector Floating-Point Slide Instructions */
 static bool fslideup_check(DisasContext *s, arg_rmrr *a)
 {
-- 
2.51.0


