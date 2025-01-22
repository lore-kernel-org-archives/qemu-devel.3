Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F5EC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadur-0002QB-4X; Wed, 22 Jan 2025 11:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tadul-0002MC-4U
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:49:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tadui-00059A-UR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:49:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so70941955e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1737564550; x=1738169350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFJJKfgkBEGM7sJusVELCJJSwbQK6DNE8A418I+aIT0=;
 b=gBkU+qpqmYAnh2YGf4xSeHJVUXj77RwQyuLfgzRtqamkAM7P+8ZOysX7bY53UOmmm8
 8LMgVF+bLOhXqT9XOtRoYsd4lK8onmIa8rurmtdthYos6agAogOXN8zcQ91JXPh7D/U+
 GaeBElaRxIDegzhkHzaprIjOEYTV0E/Otaf+VRP2rODv0Chqiw8cvGmYxewVI1NULO/F
 UNQCpsmb3XBb/StshKNels7q5/xajlXTE63iCeA+ANrQjPHm3ARVEL96lcTc7Fv3fjg3
 km0hku8xrTV/lMaFf3E43MxvU8775tDLu2K4hUcHNSNOipu6RCZJRklkczqLWo8+Uy7c
 /q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564550; x=1738169350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFJJKfgkBEGM7sJusVELCJJSwbQK6DNE8A418I+aIT0=;
 b=Bj5tzyrco1KTCxbIH/Xx8v/Kp+sxn/LI5kcOWz3IEAiOV60CTgKwxwvPvwjxQm7mXV
 uNXmOs0pIhh9l2IHXjQGX9KVyjHluEFGNqQ8WHkHf+T9iQtJACSyVzNcyUOjc7WIsHgn
 l034ME8zREPsAjhj72w+w0xSR7CXPPZ0MjSdvZFlqjCAMUfEuOv6F7ZYrv1G1M32sXe5
 087putbw0bEuOyflzqWtYN+mR3qcNMXU9OVSUgCYWQeKZWhyuxynPWAs1yGCpzz8hObl
 mkLXypPCjjZ/cKA0gMvaWw4DXsMoU1nlo78Cb7ATJrKuZ1+7NlRb67mvi2FE92+mu5Az
 dG9A==
X-Gm-Message-State: AOJu0YxLBhg7fSPc+x2XgrqekUGl/fUDDJsYdaGiqkmemW4QiEDQgW19
 nZGA9htemsi6s2Cp+k1sjsuy/+LiDOG5hddroFddLxjySyvpK5G+wgfcuy0+NGHSqvuHyf1ZcCx
 BTFk=
X-Gm-Gg: ASbGnctMxpIiIEPBnNnOgsGH/5vOU+3i7l/69J74SjpEhNoizdiPdw/so3i8UDHq1H5
 eRCMiIzf6qspiU8WvVsjcfNcZ6p6EQErHOttHqp+etnATLY20yKqXaCSzwr1jkt1+/RJzjrPlTH
 yY1EQ9xFOS2SiVD/t7JJ5EG6jIe0LyivXiK/AxsgyWevzSI1UHieGyhcgs7MOKsMeWHwWCtiI15
 v0rA4pp3KD/T+g5e5S/e7QK/EDSOIXumYSS5LWoFpx8p3H40jy29qDvugyQsERUCBwlSOElcC84
 6bdnCvO9HkbDH9tzu/96PiYTGYk88iD5Rn0=
X-Google-Smtp-Source: AGHT+IElisiAtz7vDytLa2ac3g+k5tcdi6Kk7J6YQrFsU0Dm2TVBn5/7M42jyODk0rDS/8zXQRgv6w==
X-Received: by 2002:a05:600c:3d05:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-438af40851bmr59092435e9.1.1737564549726; 
 Wed, 22 Jan 2025 08:49:09 -0800 (PST)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c059sm32095105e9.8.2025.01.22.08.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:49:09 -0800 (PST)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [RFC 1/1 v3] target/riscv: use tcg ops generation to emulate whole
 reg rvv loads/stores.
Date: Wed, 22 Jan 2025 16:49:05 +0000
Message-ID: <20250122164905.13615-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122164905.13615-1-paolo.savini@embecosm.com>
References: <20250122164905.13615-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x334.google.com
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
---
 target/riscv/insn_trans/trans_rvv.c.inc | 164 +++++++++++++++++-------
 1 file changed, 119 insertions(+), 45 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..85935276de 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1100,25 +1100,99 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
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
+    mark_vs_dirty(s);
 
-    uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
-    data = FIELD_DP32(data, VDATA, VM, 1);
-    dest = tcg_temp_new_ptr();
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
-                                      s->cfg_ptr->vlenb, data));
+    uint32_t vlen = s->cfg_ptr->vlenb << 3;
 
-    base = get_gpr(s, rs1, EXT_NONE);
-    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    /*
+     * Load/store multiple bytes per iteration.
+     * When possible do this atomically.
+     * Update vstart with the number of processed elements.
+     * Use the helper function if either:
+     * - vstart is not 0.
+     * - the target has 32 bit registers and we are loading/storing 64 bit long
+     *   elements. This is to ensure that we process every element with a single
+     *   memory instruction.
+     * - whether the helper function performs better:
+     *   on x86 the helper function performs better with few combinations of NF,
+     *   ESZ and VLEN.
+     *   Other architectures may have other combinations or conditions and they
+     *   can be added here if necessary.
+     */
 
-    mark_vs_dirty(s);
+    bool use_helper_fn = !s->vstart_eq_zero || (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
+
+#if defined(HOST_X86_64)
+    use_helper_fn |= ((nf == 4) && (log2_esz == 0) && (vlen == 1024)) ||
+                     ((nf == 8) && (log2_esz == 0) && (vlen == 512))  ||
+                     ((nf == 8) && (log2_esz == 0) && (vlen == 1024)) ||
+                     ((nf == 8) && (log2_esz == 3) && (vlen == 1024));
+#endif
 
-    fn(dest, base, tcg_env, desc);
+     if (!use_helper_fn) {
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
@@ -1128,42 +1202,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
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
2.34.1


