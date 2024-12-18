Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F29EE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxXr-0000ep-Cl; Wed, 18 Dec 2024 12:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tNxXi-0000Q0-G5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:09:03 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tNxXY-0003np-0v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:09:02 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so1336513466b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734541730; x=1735146530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjKrMxFPl8OMA4kqm+2v9mOTe2EEJBR99lcyaD4JPDU=;
 b=Fb4D7cvQKsK+ujgubWgqcwl2lQY7E67ZTXFB8GyGKE/qj4UteKs2sQdPxi84DCTK4h
 O1nX6zzUZncWQoKEIA1R2JjCV2DCEMgca4ZINPS5/ORDjSuo4JFmtw8zukUP/mXf3ft7
 mm9zzE6x7eOC5xU04ZrTFC3VTrFySkJme7bKEk7KBi6/zzZs3N/Wrl7wKJhUa11BVNDw
 ES/gsEQhwl5tZydz5AIlsXbI6Q0KgY5CrFCLEkYRYNPu39cmp6iM0yrc4uvzRddhX4cD
 Gk6mZGgBZ2TZKdzCQL83mtLviqKXrPS8xRGVIUOErOQDbT4kRvdrBVRxDRlD/0oqqgXM
 GZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541730; x=1735146530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjKrMxFPl8OMA4kqm+2v9mOTe2EEJBR99lcyaD4JPDU=;
 b=N4L/O9XJECSMzp6Eq/MNo+QyspioCn+RxbPmKqkTQaGcYlfk9xEvw4Ya58zTfqYjgq
 k4AIV4tmWsELGrO0IJdxiGBsYEL8l5WtWCSmT388eQzCq9qy6sgWpnPYCFstdUmfoGqp
 YCoti5V5vzT7LWDydr0KyLmX3/0q6nIKBMKu7ZPpWWzi1uL7PAxXMl0Wyo3DUZjK2kV4
 0yUJcbV6lGXOFKUwGZ81XMpSAOMiiprEAhhGuKFsnHrAT1erDNn4wkAPuUlikRgyCN2x
 XNgfobAuT7UDWYP0ZIzhF92Y33gVu7OnLUV25Cg6E2H1UJbSjexItpzZLcTPOI2UbD9r
 pv3Q==
X-Gm-Message-State: AOJu0Yzwg1QtiW8SW00hHBlwYT4z2of24E5xD+bp0yGgTQJ41DwEUfXE
 EDtDxdgI2IgZroIZaEbSdfF4w2gw5Bo6JL7voVqX6VK9r7uhrQC/iBTe9u0VvySHQMqF7MRIhia
 TrsB+Vw==
X-Gm-Gg: ASbGncutSYjNWqUShe+7IL+HtUgy100qX3+YhK6MksbuhdRTYGNcLSXzakPKjf/gl8c
 1NXREjlbnmUm3dBS3A/t8/fbTlEsTZNjbKH42GvcMTJRFxNZc0jUOL/32kVCo8MHWc5l47Exk8l
 o6ZGFFHUVrUwe/cBc8Azmk7IcsI/hAuGJtl1IO3jlKkcJOtp6NqWJO9utOuGsDjFttr16uZW9q7
 dfBhN57F9qpkOyFanMNLuLH+R5gFjQaFLdgz1FD0KP7X5bQhABgS5gEGs8xLe4lUmY/+FJ5uWY2
 +IbPFPIXlMY8OyiWjEBCX0du+0m++nAY1UaqfcEeQ1c=
X-Google-Smtp-Source: AGHT+IGWH7K/pg6IdIZGLLK9MQsx224hUj/lNB9zou8lx+3W74N6jhNX3aMDXXsX7egnp3iPTGz9nw==
X-Received: by 2002:a17:907:7fa4:b0:aa6:715a:75b5 with SMTP id
 a640c23a62f3a-aabf48d52afmr313171666b.46.1734541730425; 
 Wed, 18 Dec 2024 09:08:50 -0800 (PST)
Received: from paolo-laptop-amd.station (mob-109-118-46-116.net.vodafone.it.
 [109.118.46.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aabfbbb7a52sm70403966b.58.2024.12.18.09.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:08:49 -0800 (PST)
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
Subject: [RFC 1/1] target/riscv: use tcg ops generation to emulate whole reg
 rvv loads/stores.
Date: Wed, 18 Dec 2024 17:08:40 +0000
Message-ID: <20241218170840.1090473-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218170840.1090473-1-paolo.savini@embecosm.com>
References: <20241218170840.1090473-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ej1-x62b.google.com
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

This patch aims at emulating the whole register loads and stores through
direct generation of tcg operations rather than through the aid of a helper
function.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 104 +++++++++++++-----------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..63d8b05bf1 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1100,26 +1100,34 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
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
+    TCGv addr;
+    addr = get_address(s, rs1, 0);
+    uint32_t size = s->cfg_ptr->vlenb * nf;
 
-    mark_vs_dirty(s);
-
-    fn(dest, base, tcg_env, desc);
+    TCGv_i128 t16 = tcg_temp_new_i128();
 
+    /*
+     * Load/store minimum vlenb bytes per iteration.
+     * When possible do this atomically.
+     * Update vstart with the number of processed elements.
+     */
+    for (int i=0; i < size; i+=16) {
+        addr = get_address(s, rs1, i);
+        if (is_load) {
+	    tcg_gen_qemu_ld_i128(t16, addr, s->mem_idx,
+		    MO_LE | MO_128 | MO_ATOM_WITHIN16);
+	    tcg_gen_st_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
+	    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 16 >> log2_esz);
+        } else {
+            tcg_gen_ld_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
+            tcg_gen_qemu_st_i128(t16, addr, s->mem_idx,
+		    MO_LE | MO_128 | MO_ATOM_WITHIN16);
+	    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 16 >> log2_esz);
+        }
+    }
     finalize_rvv_inst(s);
     return true;
 }
@@ -1128,42 +1136,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
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


