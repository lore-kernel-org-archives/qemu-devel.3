Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE54C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6Jh-0001jy-6N; Fri, 31 May 2024 13:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6Jf-0001jA-CN
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6Jb-0007Tq-Bz
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b42d1caso18081995ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717177518; x=1717782318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkDPJZZ6oFc98bcOGd+vVk2JDeWVu0QYYXVhgDKykJw=;
 b=LPS9xjJsDGF6ZRK4A7CPWJscSGsDFC2nElheKD4lWJkNOnBlbfMxaTxch+NqUexN3a
 Gn4BQV7aJ5MRXokZAoPSZKDuPfwq++VdBi8wekbPZX7MViXhUrFvyKIap59k80k3fz7F
 LVEJdX8yt3v30+nqbNubGHiVYhWv/z0SfzRUdJeJ56AWB0iFA0RuSRYh86u1Y7qCMqb3
 IcMHfsf7hQrd/dcucQJPA4QB5gLv2YYLmxUAWZ2vrQ0XXkqgRMXkvB1Spvl7cpeB2LQb
 YP6ts/FnkGLRGX0xliRFA3MEC2vwFQdXpeFoPe5Q0PsKfv9j4wWX3TrXAJ5Fhefn8bQB
 xPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177518; x=1717782318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkDPJZZ6oFc98bcOGd+vVk2JDeWVu0QYYXVhgDKykJw=;
 b=TJuDzl/9L7SiTTsUs9pJh3zLJ6EILyJyEu4M2hYN2wUDtYTNWw4FI4qCv/gHF+kqU5
 kk29AItEEoedgKb8b+DIgpCMa16CGidbqdDfTojERPaD3OGZNsYpDYjZy3aBF9EbfueV
 NwxZ4bU6Osw+G8h+flYvHFA3gXFnh5WToSs6CqjDrFrvpPuEzqAEtguPYrlZTMFR2aia
 +/YPtWUmj71q6Jdfuh6iXvVUaSBgCtM3Vkqd0Wqep8r2od//ZdyU/aLIKJ6w/DnbdORq
 tAGXjOsqOjspg3GHw+0TmNr3j/ixMzLy8E9xe+my8KrEG5OpTIKEwmbvwJOvlN1xWryJ
 Y6hQ==
X-Gm-Message-State: AOJu0Yy90rlrbLOMxAxdVtmP7neqU7+nWyytPMf80BZVwriI3DgMoDJA
 NLjpq2ZOniJw5LQfwNx4NrBzIRRTo7YQojLMrwsQ9hxVZQRNxj6aarlH5KIVPTJ/N2V2tC0FJzy
 dJvympPyO+DnpWerpluOjz4+DcohV+uDTBSvrbdPQLt9kGIqrOoJezwy+i3ywe25LAw7v4OMZr4
 1LBMLR2RlJw1zhFmojhI5eC1tSaCI33TUiG/VrqQ==
X-Google-Smtp-Source: AGHT+IEegyQ3zmhFdvdlKucd4ilLr6J2UoyqzrlcipflnsQVvYBqsg/Vu5dgRz2bJTb/6BrdoMmTBg==
X-Received: by 2002:a17:903:32d2:b0:1e5:3c5:55a5 with SMTP id
 d9443c01a7336-1f636fd9da4mr25829665ad.8.1717177517274; 
 Fri, 31 May 2024 10:45:17 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63236ce6dsm19389875ad.95.2024.05.31.10.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:45:17 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 1/6] target/riscv: Separate vector segment ld/st
 instructions
Date: Sat,  1 Jun 2024 01:44:48 +0800
Message-Id: <20240531174504.281461-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531174504.281461-1-max.chou@sifive.com>
References: <20240531174504.281461-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This commit separate the helper function implementations of vector
segment load/store instructions from other vector load/store
instructions.
This can improve performance by avoiding unnecessary segment operation
when NF = 1.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                   |   4 +
 target/riscv/insn32.decode              |  11 ++-
 target/riscv/insn_trans/trans_rvv.c.inc |  61 +++++++++++++++
 target/riscv/vector_helper.c            | 100 +++++++++++++++++++++---
 4 files changed, 164 insertions(+), 12 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a4..aaf68eadfb7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -158,18 +158,22 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
 /* Vector functions */
 DEF_HELPER_3(vsetvl, tl, env, tl, tl)
 DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlsege8_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle64_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle8_v_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlsege8_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle16_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle64_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse8_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vssege8_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse16_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse32_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse64_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse8_v_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vssege8_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse16_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse32_v_mask, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vse64_v_mask, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd1..0712e9f6314 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -77,6 +77,7 @@
 @r2      .......   ..... ..... ... ..... ....... &r2 %rs1 %rd
 @r2_vm_1 ...... . ..... ..... ... ..... ....... &rmr vm=1 %rs2 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
+@r2_nf_1_vm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm nf=1 %rs1 %rd
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
@@ -349,11 +350,17 @@ hsv_d     0110111  .....   ..... 100 00000 1110011 @r2_s
 
 # *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
 # Vector unit-stride load/store insns.
-vle8_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+{
+  vle8_v     000 000 . 00000 ..... 000 ..... 0000111 @r2_nf_1_vm
+  vlsege8_v  ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+}
 vle16_v    ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
 vle32_v    ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
 vle64_v    ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
-vse8_v     ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+{
+  vse8_v     000 000 . 00000 ..... 000 ..... 0100111 @r2_nf_1_vm
+  vssege8_v  ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+}
 vse16_v    ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vse32_v    ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
 vse64_v    ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3a3896ba06c..1e4fa797a86 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -719,6 +719,40 @@ GEN_VEXT_TRANS(vle16_v, MO_16, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle32_v, MO_32, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle64_v, MO_64, r2nfvm, ld_us_op, ld_us_check)
 
+static bool ld_us_seg_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][4] = {
+        /* masked unit stride load */
+        { gen_helper_vlsege8_v_mask, gen_helper_vle16_v_mask,
+          gen_helper_vle32_v_mask, gen_helper_vle64_v_mask },
+        /* unmasked unit stride load */
+        { gen_helper_vlsege8_v, gen_helper_vle16_v,
+          gen_helper_vle32_v, gen_helper_vle64_v }
+    };
+
+    fn =  fns[a->vm][eew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    /*
+     * Vector load/store instructions have the EEW encoded
+     * directly in the instructions. The maximum vector size is
+     * calculated with EMUL rather than LMUL.
+     */
+    uint8_t emul = vext_get_emul(s, eew);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
+}
+
+GEN_VEXT_TRANS(vlsege8_v,  MO_8,  r2nfvm, ld_us_seg_op, ld_us_check)
+
 static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
@@ -756,6 +790,33 @@ GEN_VEXT_TRANS(vse16_v, MO_16, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse32_v, MO_32, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse64_v, MO_64, r2nfvm, st_us_op, st_us_check)
 
+static bool st_us_seg_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[2][4] = {
+        /* masked unit stride store */
+        { gen_helper_vssege8_v_mask, gen_helper_vse16_v_mask,
+          gen_helper_vse32_v_mask, gen_helper_vse64_v_mask },
+        /* unmasked unit stride store */
+        { gen_helper_vssege8_v, gen_helper_vse16_v,
+          gen_helper_vse32_v, gen_helper_vse64_v }
+    };
+
+    fn =  fns[a->vm][eew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    uint8_t emul = vext_get_emul(s, eew);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
+}
+
+GEN_VEXT_TRANS(vssege8_v,  MO_8,  r2nfvm, st_us_seg_op, st_us_check)
+
 /*
  *** unit stride mask load and store
  */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1b4d5a8e378..440c33c141b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -201,6 +201,32 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
                  uint32_t desc, uint32_t vm,
                  vext_ldst_elem_fn *ldst_elem,
                  uint32_t log2_esz, uintptr_t ra)
+{
+    uint32_t i;
+    uint32_t max_elems = vext_max_elems(desc, log2_esz);
+    uint32_t esz = 1 << log2_esz;
+    uint32_t vma = vext_vma(desc);
+
+    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+        target_ulong addr = base + stride * i;
+        ldst_elem(env, adjust_addr(env, addr), i, vd, ra);
+    }
+    env->vstart = 0;
+
+    vext_set_tail_elems_1s(env->vl, vd, desc, 1, esz, max_elems);
+}
+
+static void
+vext_ldst_stride_segment(void *vd, void *v0, target_ulong base,
+                         target_ulong stride, CPURISCVState *env,
+                         uint32_t desc, uint32_t vm,
+                         vext_ldst_elem_fn *ldst_elem,
+                         uint32_t log2_esz, uintptr_t ra)
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
@@ -236,8 +262,8 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
                   uint32_t desc)                                        \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,      \
-                     ctzl(sizeof(ETYPE)), GETPC());                     \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, vm,       \
+                             LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());    \
 }
 
 GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)
@@ -251,8 +277,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                   uint32_t desc)                                        \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
-    vext_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,     \
-                     ctzl(sizeof(ETYPE)), GETPC());                     \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, vm,       \
+                             STORE_FN, ctzl(sizeof(ETYPE)), GETPC());   \
 }
 
 GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b)
@@ -269,6 +295,26 @@ static void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, uint32_t evl,
              uintptr_t ra)
+{
+    uint32_t i;
+    uint32_t max_elems = vext_max_elems(desc, log2_esz);
+    uint32_t esz = 1 << log2_esz;
+
+    /* load bytes from guest memory */
+    for (i = env->vstart; i < evl; i++, env->vstart++) {
+        target_ulong addr = base + (i << log2_esz);
+        ldst_elem(env, adjust_addr(env, addr), i, vd, ra);
+    }
+    env->vstart = 0;
+
+    vext_set_tail_elems_1s(evl, vd, desc, 1, esz, max_elems);
+}
+
+/* unmasked unit-stride segment load and store operation */
+static void
+vext_ldst_us_segment(void *vd, target_ulong base, CPURISCVState *env,
+                     uint32_t desc, vext_ldst_elem_fn *ldst_elem,
+                     uint32_t log2_esz, uint32_t evl, uintptr_t ra)
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
@@ -312,10 +358,27 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                  ctzl(sizeof(ETYPE)), env->vl, GETPC());                \
 }
 
+#define GEN_VEXT_LD_US_SEG(NAME, ETYPE, LOAD_FN)                        \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
+                         CPURISCVState *env, uint32_t desc)             \
+{                                                                       \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, false,    \
+                             LOAD_FN, ctzl(sizeof(ETYPE)), GETPC());    \
+}                                                                       \
+                                                                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
+                  CPURISCVState *env, uint32_t desc)                    \
+{                                                                       \
+    vext_ldst_us_segment(vd, base, env, desc, LOAD_FN,                  \
+                         ctzl(sizeof(ETYPE)), env->vl, GETPC());        \
+}
+
 GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b)
-GEN_VEXT_LD_US(vle16_v, int16_t, lde_h)
-GEN_VEXT_LD_US(vle32_v, int32_t, lde_w)
-GEN_VEXT_LD_US(vle64_v, int64_t, lde_d)
+GEN_VEXT_LD_US_SEG(vlsege8_v, int8_t, lde_b)
+GEN_VEXT_LD_US_SEG(vle16_v, int16_t, lde_h)
+GEN_VEXT_LD_US_SEG(vle32_v, int32_t, lde_w)
+GEN_VEXT_LD_US_SEG(vle64_v, int64_t, lde_d)
 
 #define GEN_VEXT_ST_US(NAME, ETYPE, STORE_FN)                            \
 void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
@@ -333,10 +396,27 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
                  ctzl(sizeof(ETYPE)), env->vl, GETPC());                 \
 }
 
+#define GEN_VEXT_ST_US_SEG(NAME, ETYPE, STORE_FN)                        \
+void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,          \
+                         CPURISCVState *env, uint32_t desc)              \
+{                                                                        \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));              \
+    vext_ldst_stride_segment(vd, v0, base, stride, env, desc, false,     \
+                             STORE_FN, ctzl(sizeof(ETYPE)), GETPC());    \
+}                                                                        \
+                                                                         \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                 \
+                  CPURISCVState *env, uint32_t desc)                     \
+{                                                                        \
+    vext_ldst_us_segment(vd, base, env, desc, STORE_FN,                  \
+                         ctzl(sizeof(ETYPE)), env->vl, GETPC());         \
+}
+
 GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b)
-GEN_VEXT_ST_US(vse16_v, int16_t, ste_h)
-GEN_VEXT_ST_US(vse32_v, int32_t, ste_w)
-GEN_VEXT_ST_US(vse64_v, int64_t, ste_d)
+GEN_VEXT_ST_US_SEG(vssege8_v, int8_t, ste_b)
+GEN_VEXT_ST_US_SEG(vse16_v, int16_t, ste_h)
+GEN_VEXT_ST_US_SEG(vse32_v, int32_t, ste_w)
+GEN_VEXT_ST_US_SEG(vse64_v, int64_t, ste_d)
 
 /*
  * unit stride mask load and store, EEW = 1
-- 
2.34.1


