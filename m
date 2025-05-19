Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA742C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3K-0000bh-Js; Mon, 19 May 2025 00:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrn9-0004t1-UX
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrn7-0004B8-HN
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2301ac32320so42315105ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627672; x=1748232472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvYjxJC/6lYT2MLjH/wxW+uRvoxqIu2LLh/2lksDadY=;
 b=Lj+AgTQsLGvDa8NPGWOGqoWXQ3OfD2RB6WaKfrFPxLzCzG1VbuL+ABhweHZuIpulQu
 gc/DI3Icy4JSJwzmTGwRguqbe58GX6N4jUXQaPrpnKFq4ppgQ8dF2sGc+yQ5vg8ZOlL6
 SevaPsInrDNHViHdYtOACzvEy91Cj4uuPyuooe1JbMrSCia+1YdXDlvyVR7vg9hu9hY/
 436V+beEv+Bz7WUUreO1dXIOPnpQp0eLTxN5Y5FnWtYb2oP1MqEnZ3btvtt4NDtdSGMX
 NfTJ+l0KMK6krtGJmNhL1rgz+37M79Cd5gyLJaDkKl9yEZSHjW+V9vHsX+hissJGPPzE
 2Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627672; x=1748232472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvYjxJC/6lYT2MLjH/wxW+uRvoxqIu2LLh/2lksDadY=;
 b=gbhjX8BdirZQX5xuRyqtsybeDuCtxBntrVu/94cTthWxvo+yUMtvsh56CzEzIOXeVm
 YRqX6b3ivTEICu6BU8JH65TSjOohOItBYg0m49bgARW9QtcyVpCbbHKr+xDH3TuqEJtD
 bvMViSuWDH4ZCubxdWKuwUKWMWlkzg/kI9MhYB5e7tVdfjr96vRbiXBgn/n6pw0mLKdN
 yMcH69gxR8EDbW/kPecltKHyxv3M7CMKkVKmi5plI3iYfvExiaXg7GNKCoFUjJ9smSXb
 eFAy2llGlhb98kvawKMM+LgRuuSXzh26qIsLjzfoie0PPg9neM42ybck9ouVARLqLu7x
 a1VQ==
X-Gm-Message-State: AOJu0Ywf3fLgjBOCLGRpxn5F//hru5JoqEUCG4rKF8z0BYVRqevibglA
 2PjYGNFKQ3Ykj7WD9DOR8S7LFnX6410yZYyxtdqVzl/JfUp5X8Y8viidUqqU1A==
X-Gm-Gg: ASbGncujmL8IAjwS5mEcQ9a08BCnHxX98i1lbxQAaLxdIpEzNML1vKQYIZlTmatX5Ap
 D40px6v4ifcJXLG699mXbk+VpO17NwZBLa/TNATfc9AGmidrc2uQjXqV8S1goFbeh523vQlqXSs
 b8e4BM/GJd9G8IKxVZck77cz6Z7QsleHSXYaxnvw+KYPvFVRZEQTAxqsdSQB5/VF51IO5o0MUD1
 J7Ax5r+WJQfbKPr/RxOUOH+hIp2Vhkbk+QY8O9idQfz7jkRtOW2itTNJPrVuAun5CA42Y8bRr/R
 AB4o0Gman7oNVTq7d0FjPVSCZjQM0eGWMV7QFILMSDhEekQfQ7GoUxaduce0K5wM8351q9dOByf
 9YD0EUyzMsoedTKzLLNjlUVSOxV0joCDIvu8eRVBB6/7oSO8cR39qBX6bju6KlaCoATU=
X-Google-Smtp-Source: AGHT+IFFDmO2kXmY+6WST5/9Y8ec/n1ZkhToKvOqN8evRko/V33RkTPmphvibnSjwBPNSZEmVdTFKQ==
X-Received: by 2002:a17:903:2f4c:b0:21f:522b:690f with SMTP id
 d9443c01a7336-231d45af194mr157037135ad.46.1747627671906; 
 Sun, 18 May 2025 21:07:51 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/56] target/riscv: use tcg ops generation to emulate whole
 reg rvv loads/stores.
Date: Mon, 19 May 2025 14:05:12 +1000
Message-ID: <20250519040555.3797167-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Paolo Savini <paolo.savini@embecosm.com>

This patch replaces the use of a helper function with direct tcg ops generation
in order to emulate whole register loads and stores. This is done in order to
improve the performance of QEMU.
We still use the helper function when vstart is not 0 at the beginning of the
emulation of the whole register load or store or when we would end up generating
partial loads or stores of vector elements (e.g. emulating 64 bits element loads
with pairs of 32 bits loads on hosts with 32 bits registers).
The latter condition ensures that we are not surprised by a trap in mid-element
and consecutively that we can update vstart correctly.
We also use the helper function when it performs better than tcg for specific
combinations of vector length, number of fields and element size.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Handerson <richard.henderson@linaro.org>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: "Alex Bennée" <alex.bennee@linaro.org>
Message-ID: <20250313152330.398396-2-paolo.savini@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 155 +++++++++++++++++-------
 1 file changed, 108 insertions(+), 47 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7079f758ad..4ca7b15da1 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1334,25 +1334,86 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
 typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
-                             gen_helper_ldst_whole *fn,
-                             DisasContext *s)
+                             uint32_t log2_esz, gen_helper_ldst_whole *fn,
+                             DisasContext *s, bool is_load)
 {
-    TCGv_ptr dest;
-    TCGv base;
-    TCGv_i32 desc;
-
-    uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
-    data = FIELD_DP32(data, VDATA, VM, 1);
-    dest = tcg_temp_new_ptr();
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
-                                      s->cfg_ptr->vlenb, data));
-
-    base = get_gpr(s, rs1, EXT_NONE);
-    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-
     mark_vs_dirty(s);
 
-    fn(dest, base, tcg_env, desc);
+    /*
+     * Load/store multiple bytes per iteration.
+     * When possible do this atomically.
+     * Update vstart with the number of processed elements.
+     * Use the helper function if either:
+     * - vstart is not 0.
+     * - the target has 32 bit registers and we are loading/storing 64 bit long
+     *   elements. This is to ensure that we process every element with a single
+     *   memory instruction.
+     */
+
+    bool use_helper_fn = !(s->vstart_eq_zero) ||
+                          (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
+
+    if (!use_helper_fn) {
+        TCGv addr = tcg_temp_new();
+        uint32_t size = s->cfg_ptr->vlenb * nf;
+        TCGv_i64 t8 = tcg_temp_new_i64();
+        TCGv_i32 t4 = tcg_temp_new_i32();
+        MemOp atomicity = MO_ATOM_NONE;
+        if (log2_esz == 0) {
+            atomicity = MO_ATOM_NONE;
+        } else {
+            atomicity = MO_ATOM_IFALIGN_PAIR;
+        }
+        if (TCG_TARGET_REG_BITS == 64) {
+            for (int i = 0; i < size; i += 8) {
+                addr = get_address(s, rs1, i);
+                if (is_load) {
+                    tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
+                            MO_LE | MO_64 | atomicity);
+                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                } else {
+                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                    tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
+                            MO_LE | MO_64 | atomicity);
+                }
+                if (i == size - 8) {
+                    tcg_gen_movi_tl(cpu_vstart, 0);
+                } else {
+                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
+                }
+            }
+        } else {
+            for (int i = 0; i < size; i += 4) {
+                addr = get_address(s, rs1, i);
+                if (is_load) {
+                    tcg_gen_qemu_ld_i32(t4, addr, s->mem_idx,
+                            MO_LE | MO_32 | atomicity);
+                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
+                } else {
+                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
+                    tcg_gen_qemu_st_i32(t4, addr, s->mem_idx,
+                            MO_LE | MO_32 | atomicity);
+                }
+                if (i == size - 4) {
+                    tcg_gen_movi_tl(cpu_vstart, 0);
+                } else {
+                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
+                }
+            }
+        }
+    } else {
+        TCGv_ptr dest;
+        TCGv base;
+        TCGv_i32 desc;
+        uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
+        data = FIELD_DP32(data, VDATA, VM, 1);
+        dest = tcg_temp_new_ptr();
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                        s->cfg_ptr->vlenb, data));
+        base = get_gpr(s, rs1, EXT_NONE);
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+        fn(dest, base, tcg_env, desc);
+    }
 
     finalize_rvv_inst(s);
     return true;
@@ -1362,42 +1423,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
-static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
-{                                                                         \
-    if (require_rvv(s) &&                                                 \
-        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
-        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                    \
-                                gen_helper_##NAME, s);                    \
-    }                                                                     \
-    return false;                                                         \
-}
-
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
+#define GEN_LDST_WHOLE_TRANS(NAME, ETYPE, ARG_NF, IS_LOAD)                  \
+static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                   \
+{                                                                           \
+    if (require_rvv(s) &&                                                   \
+        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                   \
+        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, ctzl(sizeof(ETYPE)), \
+                                gen_helper_##NAME, s, IS_LOAD);             \
+    }                                                                       \
+    return false;                                                           \
+}
+
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  int8_t,  1, true)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, int16_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, int32_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, int64_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  int8_t,  2, true)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, int16_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, int32_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, int64_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  int8_t,  4, true)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, int16_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, int32_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, int64_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  int8_t,  8, true)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, int16_t, 8, true)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, int32_t, 8, true)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, int64_t, 8, true)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
+GEN_LDST_WHOLE_TRANS(vs1r_v, int8_t, 1, false)
+GEN_LDST_WHOLE_TRANS(vs2r_v, int8_t, 2, false)
+GEN_LDST_WHOLE_TRANS(vs4r_v, int8_t, 4, false)
+GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
 
 /*
  *** Vector Integer Arithmetic Instructions
-- 
2.49.0


