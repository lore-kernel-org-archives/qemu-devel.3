Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C69EF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTz-000899-1k; Wed, 04 Mar 2026 08:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmTF-0007Ca-Mu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:41:03 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT7-0005KJ-RP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:57 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-824ac5d28f9so6912338b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631651; x=1773236451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sldBpiO/vTJjGnkQ9fu8n4HA0ecPhur9Ke2QVeCPD0w=;
 b=bybjg6ypPW9vvcqn7RLTIEXhnFJYtfH5ktkOTV2cOM757QFfTDa6DP/5h1sCBwdoDx
 uEeTFg9EnY+xZCIv9CCwJBozlDlTIiYCU4a05sMyK98XWcw1fwev8+xmn5x542j8aAQI
 d4zVzRbsEgzZjHuxit/g3I1+iMGzn8KeWb2MWpklYpbNPJNUH6BEGrr7q/IRNAHsxSp/
 5BO7fdr/z7u623Cy5xVw1WvkqKRi7fA1PhXTj8DCpXplOJwetyRcVqgkCnSmA9lwo+0l
 ENNRIX8b6eo9lCTwqwvLXBEnInzM9vOVFNjN1gskcbEitcgwKP2kYsZ0Iab/DavVCqFb
 Zsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631651; x=1773236451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sldBpiO/vTJjGnkQ9fu8n4HA0ecPhur9Ke2QVeCPD0w=;
 b=j3nsLFBqq0FsLNUzkxSaY+rnmYOe7mUWSUrCxgtEIPhVys13nKW7GtRRsCp9UUrHIW
 cAtSkYUP7qJdTDE3BxhtiwIxyYo4uLbF7j98jWp2yD3tvQp0eptCx+WWOb2ED3R1sbse
 kqZBd6YJa8okOIjBJaNMptJfZo0CpTzkeshfKFfksvne4ujz1qthHJ1wnkiGPCHNUzX2
 hTHJT2uoMF9w/fkD1wP2Tkry7S6uTYeEaLBnVCCdTdQxZUEu151jfwxZOB3oGK0KbD+S
 pKt+3X9sohtC5sjlLUrmaohyJWrxKi9tL8e5jEK0eh600LHzEZcNOtyq6AWmVlkRET0g
 dSrw==
X-Gm-Message-State: AOJu0Yw7TVZU4d8AZeu6WnfvOgCQ4XQxBx7RdC8hi1zVrSVzdVmznOoe
 aBEbp7jd+GUo239CYmn++KwhyJgujZBfnS1mSsTMkcvPpaPA0sUexYnlr9QyZuXHyx9Kx6GskJx
 KJlE2D3Q4zdvVJpAhDg/pn6TzgEsbi+qx6NTIhvIZzRTpaVYZsK4g+zQBl7rR7opaQB5MeiSGzR
 8fnHaHXqth9F2fC5WAC2AxdazBehX8SHU3tb9umhvqXQ==
X-Gm-Gg: ATEYQzy/jkzpT38WQcg5ud+jOKdGmB8HcxrsoE8CA1oqNJlF76oy2aoo0TRkdRaHoHw
 vfL3tiDUauO7HSoo5xCspd51rkDYx2TeAUzz5N7dr7xNLXNcCxfrjpKckLDyGvDf6BKntVClYWe
 VUiJX0E7kTlXkSjRlZfm8uDwx9T9WEwoKFCrcdTAQV63W98Ukc9cfKIzmMId4uP9gEqvPUw7s8I
 ewJbNNQGNU4SNTe5QrSjAc4kEICj9O6IHBQsxGqMuN6sQERcbKMBky536ii4VlqfopaDut9CKIr
 arGV9n5EsKd9fLnXZbktZ9BXrRJ+gPdjPxnfAceEQK5TK7FresGM1ZgPCLQO85JTOS1A9smmyB5
 XI561kAygx4L4pMpSHymXJ2ClLe1PYmRrwVnBkvJitIuN4J5UXMA5RII696sn9fzkWmD+82RP+T
 N6RXTHG+SZ6JW2WijXz5DXtS9XaJci55EffmuSutZzc904w3YzKuZH7ZnY9BiotQkxe0nNOOFjN
 3VkqPz10I/KoEclMN0cGdhcbX8=
X-Received: by 2002:a05:6a00:4f86:b0:827:300d:52c9 with SMTP id
 d2e1a72fcca58-82972cd4028mr2297359b3a.54.1772631651078; 
 Wed, 04 Mar 2026 05:40:51 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:50 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 12/14] target/riscv: rvv: Add vfext.vf2 instruction for
 Zvfofp4min extension
Date: Wed,  4 Mar 2026 21:40:04 +0800
Message-ID: <20260304134006.2908449-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42a.google.com
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

The vfext.vf2 instruction converts a vector of OCP FP4 E2M1
floating-point numbers to a vector of OFP FP8 E4M3 floating-points
numbers.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      |  3 ++
 target/riscv/insn32.decode                 |  3 ++
 target/riscv/insn_trans/trans_rvofp4.c.inc | 43 ++++++++++++++++++++++
 target/riscv/translate.c                   |  1 +
 target/riscv/vector_helper.c               | 33 +++++++++++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 356c24d9fb..162303fb6c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1259,6 +1259,9 @@ DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
 
+/* OFP4 function */
+DEF_HELPER_5(vfext_vf2, void, ptr, ptr, ptr, env, i32)
+
 /* Vector crypto functions */
 DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f2b413c7d4..c58223ebd8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -754,6 +754,9 @@ vsext_vf2       010010 . ..... 00111 010 ..... 1010111 @r2_vm
 vsext_vf4       010010 . ..... 00101 010 ..... 1010111 @r2_vm
 vsext_vf8       010010 . ..... 00011 010 ..... 1010111 @r2_vm
 
+# Zvfofp4min Extension
+vfext_vf2       010010 . ..... 10110 010 ..... 1010111 @r2_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm11
 vsetivli        11 .......... ..... 111 ..... 1010111  @r2_zimm10
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvofp4.c.inc b/target/riscv/insn_trans/trans_rvofp4.c.inc
new file mode 100644
index 0000000000..0fb5d7d534
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvofp4.c.inc
@@ -0,0 +1,43 @@
+/*
+ * RISC-V translation routines for the OFP4 Standard Extensions.
+ *
+ * Copyright (C) 2025 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+static bool vext_zvfofp4min_check(DisasContext *s, arg_rmr *a)
+{
+    return s->cfg_ptr->ext_zvfofp4min &&
+           (s->sew == MO_8) &&
+           vext_check_altfmt(s, -1) &&
+           (s->lmul >= -2) &&
+           require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (a->rd != a->rs2) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul - 1) &&
+           require_vm(a->vm, a->rd) &&
+           require_noover(a->rd, s->lmul, a->rs2, s->lmul - 1);
+}
+
+static bool trans_vfext_vf2(DisasContext *s, arg_rmr *a)
+{
+    if (vext_zvfofp4min_check(s, a)) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs2), tcg_env,
+                           s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, data,
+                           gen_helper_vfext_vf2);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0c546a3aff..4311b388cb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1221,6 +1221,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "insn_trans/trans_rvofp8.c.inc"
+#include "insn_trans/trans_rvofp4.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e7b187a57d..86a174ed9d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5131,6 +5131,7 @@ RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
 GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
 GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
 
+/* Zvfofp4min: vfext.vf2 - OFP4 E2M1 to OFP8 E4M3 conversion */
 /*
  * Vector Reduction Operations
  */
@@ -5930,3 +5931,35 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+
+void HELPER(vfext_vf2)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                       uint32_t desc)
+{
+    float_status fp_status = env->fp_status;
+    uint32_t vl = env->vl;
+    uint32_t vm = vext_vm(desc);
+    uint32_t esz = sizeof(uint8_t);
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vma = vext_vma(desc);
+    uint32_t i;
+
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
+    for (i = env->vstart; i < vl; ++i) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+
+        uint8_t input = *((uint8_t *)vs2 + H1((i % 2 ? i - 1 : i) / 2));
+        input = (i % 2) ? ((input >> 4) & 0xf) : (input & 0xf);
+        *((uint8_t *)vd + H1(i)) = float4_e2m1_to_float8_e4m3(input,
+                                                              &fp_status);
+    }
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+}
-- 
2.52.0


