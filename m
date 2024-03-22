Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFF8C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnb8c-0003jl-H6; Fri, 22 Mar 2024 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnb8a-0003jF-NN
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:24:32 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnb8Z-0006BP-01
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:24:32 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-60fff981e2aso19136117b3.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711099470; x=1711704270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZLHwysM1SOLunsTOPiCHJUq8bBNp1FdzR5sg9NjsiA=;
 b=nWHLp2ckY73YSaBnVHi8bO9abxLdkVMBNIZGXySplB/tLKtXiTqHn/4gGxd+aOb2RJ
 Am8rYoAJYgD/QmKoeXr982SlMviE+/RinNg0RIAlcAI00cIOqWiU0ZaQTcX84Yz2P/mY
 FVG+pw/baVgajtLNKpwBtBxj86Df+ivD+8lV3fieb7j0pmVsdzV5UTw2xxz9Yo+xP6+J
 g1qhjnd73/9siFtiyW9eC3grtIdIeVHBxZIHt/9rdf0ZSh1Q0JKrk4k4Tt9LHWQvY5jf
 L/+1rEpPiPR6w2s55kPdV8SnFlfUyIgAhXWCOlxP3/V/0A9aX2zJ5lZT5TnE/mgkbqSJ
 bZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099470; x=1711704270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZLHwysM1SOLunsTOPiCHJUq8bBNp1FdzR5sg9NjsiA=;
 b=OG5hsQXb3hIbAIRFT3ZtNn/SHlBTuJb/hN5HFbuJMoChDfW9mq9/vPjjpCExoGLdbD
 O0KvpNruvTJ+lrnrDsQOpMg59dsbgPFnRoIsy4pDPawoz6n9d19DLBRV33SJODiyyEm2
 a7hi66Hy77F1JPVgpFc3N7II9kQXaTWork54jFJ5CR8GTmjfLkDqOiasiOSf+YFVpd3I
 ERpU9O0nqZdfuuLo87zVFyIGqaSbHj63ASYPGtMHSq6J0kPjd+YZ6n45Y6ddy/BvgR5b
 e/CcYRpHlvqBB/yaFBx0OK7l8tVaCgOyeNu+Y55XaJIQQxvmYODSAwWA9X1VPJVzfixo
 L3ig==
X-Gm-Message-State: AOJu0Yw9hYDFkzN06YVvOF18/WB85T2AcLevQnfB655C9J2pB+KlcId8
 /s1nCWRXcDEvgQbZAOUfe5JWtMVFI6BFCCjn9nrXjXqWR7Qt+Am3fzHNWVH2WESLBQ==
X-Google-Smtp-Source: AGHT+IF68KOocXaLH0+hKYjPJnHKT+7MM95xdDwd7ik97RMMtCHG84GiF1a27TBF12uxk0JPlS5/qQ==
X-Received: by 2002:a05:6a20:431f:b0:1a3:a1c8:96bf with SMTP id
 h31-20020a056a20431f00b001a3a1c896bfmr1716068pzk.38.1711097628973; 
 Fri, 22 Mar 2024 01:53:48 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/15] target/riscv: always clear vstart for ldst_whole insns
Date: Fri, 22 Mar 2024 18:53:10 +1000
Message-ID: <20240322085319.1758843-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=alistair23@gmail.com; helo=mail-yw1-x112f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 8ff8ac6329 added a conditional to guard the vext_ldst_whole()
helper if vstart >= evl. But by skipping the helper we're also not
setting vstart = 0 at the end of the insns, which is incorrect.

We'll move the conditional to vext_ldst_whole(), following in line with
the removal of all brconds vstart >= vl that the next patch will do. The
idea is to make the helpers responsible for their own vstart management.

Fix ldst_whole isns by:

- remove the brcond that skips the helper if vstart is >= evl;

- vext_ldst_whole() now does an early exit with the same check, where
  evl = (vlenb * nf) >> log2_esz, but the early exit will also clear
  vstart.

The 'width' param is now unneeded in ldst_whole_trans() and is also
removed. It was used for the evl calculation for the brcond and has no
other use now.  The 'width' is reflected in vext_ldst_whole() via
log2_esz, which is encoded by GEN_VEXT_LD_WHOLE() as
"ctzl(sizeof(ETYPE))".

Suggested-by: Max Chou <max.chou@sifive.com>
Fixes: 8ff8ac6329 ("target/riscv: rvv: Add missing early exit condition for whole register load/store")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20240314175704.478276-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c            |  5 +++
 target/riscv/insn_trans/trans_rvv.c.inc | 52 +++++++++++--------------
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bcc553c0e2..1f4c276b21 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -572,6 +572,11 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
 
+    if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
+        env->vstart = 0;
+        return;
+    }
+
     k = env->vstart / max_elems;
     off = env->vstart % max_elems;
 
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 52c26a7834..1366445e1f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1097,13 +1097,9 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
 typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
-                             uint32_t width, gen_helper_ldst_whole *fn,
+                             gen_helper_ldst_whole *fn,
                              DisasContext *s)
 {
-    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
-
     TCGv_ptr dest;
     TCGv base;
     TCGv_i32 desc;
@@ -1120,8 +1116,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
-    gen_set_label(over);
-
     return true;
 }
 
@@ -1129,42 +1123,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
+#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
 {                                                                         \
     if (require_rvv(s) &&                                                 \
         QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
-        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,             \
+        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                    \
                                 gen_helper_##NAME, s);                    \
     }                                                                     \
     return false;                                                         \
 }
 
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
+GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
+GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
+GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
+GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
 
 /*
  *** Vector Integer Arithmetic Instructions
-- 
2.44.0


