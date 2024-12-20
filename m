Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C17AE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 15:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOf1U-0000vu-6i; Fri, 20 Dec 2024 10:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tOf1T-0000uu-2f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:34:39 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tOf1Q-00024n-Hy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:34:38 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so55375866b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 07:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734708875; x=1735313675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuaZJpOlhqoq+AVWeiwLZIgDeh/1p5naseS9DVlnL0k=;
 b=WnW3kjPVASSqwTGB/4LgLJ2UuWyGQrdD3ph1elmtn3AvvXOESgaO26wDYF3tA19yES
 5Pkb8egGUh5blJH00yNsujwJ/Oh+D1gQBERW5NmxLg+kpvDKBLXBTh5Lb+Ip5j683+4X
 Xe2HGPkcpS0vFa5+t7ePvskgHu50Bixt8vcpLrcG4hQBBjo1MTU+M7reR5s1RS6ikip5
 6Xi3usvL/SOEVSUoTE2LJj6FSncPXQMHe4DgahzEXlElcMIsNemptENYAI54RgmtoKQT
 wYc69kYjMjI2F49b+gI5ObNdP3HFUk++Ek93ueynuJS4DdmR/SOPtNSRbTXHG+jjL6S9
 h1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734708875; x=1735313675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuaZJpOlhqoq+AVWeiwLZIgDeh/1p5naseS9DVlnL0k=;
 b=j/PBGRsJAXWehoRsfTSJe4qJ0BhcHSjG92vC1t2oBj59prQevO9U6ejalz5dDg2WNJ
 Ae0RpQ61zjAncpiB8r4JN3jBxHejB2FHthHw3AUfdlFf2FtGY508I6PPVHcTxUMzUHlk
 VvqHKM8VsywAKLFoDB7uil/YpQ1A3bOc8R7/WT/CaJD1pa8HVm5bIn6c02WhO4Ym1O/V
 d3Jn+uICcQcgXTCRp2Rqg24Jp0EnmssiGE/yDSctK8IbJHNNvySwp5J4X0ELZb2yCb6h
 FMw5TlN9fW881FJWiPE6hDS7mTlmFJIdHM0V7IB12pdf8EU5EHvEcByefZuIJMsXV4Vf
 XqNw==
X-Gm-Message-State: AOJu0YzgmBew2JSmK/zC+/RJLU6VnZtXPjGcG7XkIy59jnAJg/zrZi5Y
 9N4b7heBy0iGU8aoYr1PJBj77TlOEmJu9dR6GUOpDRM+HNcp0TeomHWQ5v316EtjSOH+ULn+ti9
 cmnpJ6Q==
X-Gm-Gg: ASbGncsAWQb8De54TkdagddcGFDW4LfI6yKRG4bkElgXvCzaCs0IyoCkXiSTsn/LGJU
 4FVwegOE6xaVeyp7Rs0HUnOZg5DwEHzL1czPLX8PznkYKbb9FaW83JL6OHh6XkL3LwyLcgQAMmp
 fU4cxcEJM3sI90FtL4GwAqjNnGzbo2+SckBHdvY3vQBZGb++UJHiA52Z/35M73oGuO65z4UH4o0
 MUsCluQvCpE/cf0csgPTe+kcAKolESyRsfChDh7gvs5TuVK2rYrJvbcB/kCnE/S9w6QiJQQ0+lU
 hou7QpEJ+Ynnal+duggxTxboHmNkd8AuAKwV35xpL5A=
X-Google-Smtp-Source: AGHT+IGmcoDZ4Y480reismbtgVVUzyCxVuy3x9+Vj6jFOZ8K5/O2AJ8vh3VIB1QzNYkXV0iuOFt4kA==
X-Received: by 2002:a17:907:728c:b0:aa6:6c08:dc79 with SMTP id
 a640c23a62f3a-aac2cf50e65mr281224666b.35.1734708875032; 
 Fri, 20 Dec 2024 07:34:35 -0800 (PST)
Received: from paolo-laptop-amd.station (mob-109-118-46-116.net.vodafone.it.
 [109.118.46.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f0128b8sm188131666b.145.2024.12.20.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 07:34:34 -0800 (PST)
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
Subject: [PATCH 1/1] target/riscv: use tcg ops generation to emulate whole reg
 rvv loads/stores.
Date: Fri, 20 Dec 2024 15:34:28 +0000
Message-ID: <20241220153428.16013-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220153428.16013-1-paolo.savini@embecosm.com>
References: <20241220153428.16013-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ej1-x62d.google.com
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
emulation of the whole register load or store.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 125 +++++++++++++++---------
 1 file changed, 78 insertions(+), 47 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..c2c2c53254 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1100,25 +1100,56 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
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
+     * Load/store minimum vlenb bytes per iteration.
+     * When possible do this atomically.
+     * Update vstart with the number of processed elements.
+     */
+    if (s->vstart_eq_zero) {
+        TCGv addr = tcg_temp_new();
+        uint32_t size = s->cfg_ptr->vlenb * nf;
+        TCGv_i128 t16 = tcg_temp_new_i128();
+        MemOp atomicity = MO_ATOM_NONE;
+        if (log2_esz == 0) {
+            atomicity = MO_ATOM_NONE;
+        } else {
+            atomicity = MO_ATOM_IFALIGN_PAIR;
+        }
+        for (int i = 0; i < size; i += 16) {
+            addr = get_address(s, rs1, i);
+            if (is_load) {
+                tcg_gen_qemu_ld_i128(t16, addr, s->mem_idx,
+                        MO_LE | MO_128 | atomicity);
+                tcg_gen_st_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
+            } else {
+                tcg_gen_ld_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
+                tcg_gen_qemu_st_i128(t16, addr, s->mem_idx,
+                        MO_LE | MO_128 | atomicity);
+            }
+            if (i == size - 16) {
+                tcg_gen_movi_tl(cpu_vstart, 0);
+            } else {
+                tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 16 >> log2_esz);
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
@@ -1128,42 +1159,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
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


