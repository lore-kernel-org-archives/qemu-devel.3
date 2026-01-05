Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577B2C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 01:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcZ4P-0000Bm-Ld; Sun, 04 Jan 2026 20:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4I-00009s-0f
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:07:35 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4D-0003yP-Rq
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:07:33 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7cdf7529bb2so4629026a34.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 17:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1767575248; x=1768180048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UrRTBuXPrWe3CjPaxeAamCWRKdei6KjJCfVz59/7nMw=;
 b=JGUe32bVhDXWVIck0WfOaWaV8SmtRMYl37A1/XFaUkdd+IwZlWrbBBFC1Y/thV1lgc
 1nOXyHz3UyvTDg1rUtivGeq6sqDZ7tUkDzkN5/t1on3TcmMXXp+wZzVKqa5szPsRztCB
 O0/mdjWfLS7A7CQm+5dbX3HWG7HXvOqewDPauLAIDFdsTAFxFGaMs9U5juBJAA4OVJwx
 4PHotE/uDzrthvqJFCwj/iMnyWfu3wmuhTXEc0MFCI/BHQ3YNBhvb/YVNuVk1ftiKB+5
 Oz3nOGTfH5hFuK8mWA6EcrLurzTCzMalS4yxTRzIipIWCzjCcIzIAE3iGwkXVkhTZlmg
 y+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767575248; x=1768180048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrRTBuXPrWe3CjPaxeAamCWRKdei6KjJCfVz59/7nMw=;
 b=QjWV3Zoba4Ese++OoobTBDmDvMsiFPyQxksTUrCwZPB/N3iAelzJkIQwUIzNM9R/R9
 iP7wNXN4YidTjIi26RTT+MxcpIANF0uyoClCej96Mlj1yPOA35qO+L/2u7kEkPlFW9wZ
 aoIjnNYg4auOL9Ia/t6ankTXsy+1YmPpJ4cJUInqli1lVP1hCqS0V1SfgkHwELCMbIO8
 lSlAvihDJEDUTn9BiNzrJL5xyJARyZnV8wttXlyPe6nVoqh3KMGEQanAKjFc4qW0CxOC
 +8wQ/szTIdlBIUpbcaevR4fPsdJdeXLDjgz9V48smphSwVMWBmRfAD5uBKN4aNiye3UT
 SEqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLXvJl5LOXt8P7fVl+rlO2g1IkKy1S0WAn6zU1eo32rENBKsMVdRbggMRCpamB5OGlTPI0E1DrsOpI@nongnu.org
X-Gm-Message-State: AOJu0YwJ/5SpW+4C3VHMZbzXA+dVsJhFIGrVY2x4vNg/xdvw/Rt77Vbo
 iIwuJ1WWGDRPsHoo2UsH89wK98fqC8CjzFqSNvCB29fthPd/JrkuUps8BQiCA52yh10=
X-Gm-Gg: AY/fxX4ZwUb5r2eHw8Sk9lbVCwUOzAV3DF1Wdv3qVpX0VQcbQOi+G+qRPBMCSawPoXt
 DR9cXXBiH9n7wOSznj5iFFzq1NvpZGDse8x4ykHGN9tHNuYhguTDOgOSRLvA05DoZUhnGQM9tYf
 Qyi4RTTPtOWuNIS6SXZknl+wit/q01RHPdCGoKsjm2JmRLQdgo9v2hjrDHxU9+DAeNFeyW1kAFR
 lp8J30vqqtk5YQfxbYd5+kwCZFCuTjijynHlBUJLLFE6RVqlTbyRdXOiTZXcuQhfo5MryVyB32o
 ki4OhkLFHadBS9K8QCT36ZXKl7gFAhdSbSRrzYhtNLwPyvf9dCjuckdztBh9XnLJM0lT6COLtbK
 r8XHYo4tDFHwwiJcuBiXjWwyx7re+u/khL9mEmPwLr+EV8pveKVgi1L1R6GZlkuahSYyw/1alor
 MgB8DvolA+KDFCr6NCRMao3gVvqoLUUFsO1VxCD8AytrAqMdmnPj2WXdQ=
X-Google-Smtp-Source: AGHT+IGcYn8Yb5pLbczr6YwVnRKGieayQqqKtT73KrenrKZCvmCJGbml98sVjCKjeMgcvLJ7XybZAQ==
X-Received: by 2002:a9d:6009:0:b0:7c6:e92f:41df with SMTP id
 46e09a7af769-7cc66a28ba9mr22813240a34.12.1767575248089; 
 Sun, 04 Jan 2026 17:07:28 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cdf600885asm15962364a34.21.2026.01.04.17.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 17:07:26 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/4] target/riscv: rvv: Add mask_reg_full_update option
Date: Mon,  5 Jan 2026 01:05:54 +0000
Message-Id: <20260105010557.318635-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Implementations can optionally write all bits of a mask production
instruction, regardless of VL/SEW/LMUL configuration:

  Furthermore, for mask-logical instructions and vmsbf.m, vmsif.m, vmsof.m
  mask-manipulation instructions, any element in the tail of the result can
  be written with the value the mask-producing operation would have
  calculated with vl=VLEN, SEW=8, and LMUL=8 (i.e., all bits of the mask
  register can be overwritten).

Add mask_reg_full_update to cover this.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
I just picked the next free bit for MASK_REG_FULL_UPDATE, I presume that is
correct.

 target/riscv/cpu.c                      | 2 ++
 target/riscv/cpu_cfg_fields.h.inc       | 1 +
 target/riscv/insn_trans/trans_rvv.c.inc | 4 ++++
 target/riscv/internals.h                | 1 +
 target/riscv/translate.c                | 2 ++
 target/riscv/vector_internals.h         | 5 +++++
 6 files changed, 15 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2bd07a2f2b..671891f2a4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2688,6 +2688,8 @@ static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
     DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
     DEFINE_PROP_BOOL("rvv_vsetvl_x0_vill", RISCVCPU, cfg.rvv_vsetvl_x0_vill, false),
+    DEFINE_PROP_BOOL("rvv_mask_reg_full_update", RISCVCPU,
+                     cfg.rvv_mask_reg_full_update, false),
 
     /*
      * write_misa() is marked as experimental for now so mark
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 4c17f99dfd..abe27e985e 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -117,6 +117,7 @@ BOOL_FIELD(rvv_ta_all_1s)
 BOOL_FIELD(rvv_ma_all_1s)
 BOOL_FIELD(rvv_vl_half_avl)
 BOOL_FIELD(rvv_vsetvl_x0_vill)
+BOOL_FIELD(rvv_mask_reg_full_update)
 /* Named features  */
 BOOL_FIELD(ext_svade)
 BOOL_FIELD(ext_zic64b)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index ef659f55fe..91e905caf7 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3288,6 +3288,8 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         data =                                                     \
             FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);\
+        data = FIELD_DP32(data, VDATA, MASK_REG_FULL_UPDATE,       \
+                          s->cfg_mask_reg_full_update);            \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), tcg_env,           \
@@ -3387,6 +3389,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         data =                                                     \
             FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);\
         data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
+        data = FIELD_DP32(data, VDATA, MASK_REG_FULL_UPDATE,       \
+                          s->cfg_mask_reg_full_update);            \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
                            vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
                            tcg_env, s->cfg_ptr->vlenb,             \
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 172296f12e..a58c6caa69 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -70,6 +70,7 @@ FIELD(VDATA, VTA_ALL_1S, 5, 1)
 FIELD(VDATA, VMA, 6, 1)
 FIELD(VDATA, NF, 7, 4)
 FIELD(VDATA, WD, 7, 1)
+FIELD(VDATA, MASK_REG_FULL_UPDATE, 11, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h(uint64_t frs1);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..4f88e59182 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -101,6 +101,7 @@ typedef struct DisasContext {
     bool cfg_vta_all_1s;
     bool vstart_eq_zero;
     bool vl_eq_vlmax;
+    bool cfg_mask_reg_full_update;
     CPUState *cs;
     TCGv zero;
     /* actual address width */
@@ -1314,6 +1315,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vta = FIELD_EX32(tb_flags, TB_FLAGS, VTA) && cpu->cfg.rvv_ta_all_1s;
     ctx->vma = FIELD_EX32(tb_flags, TB_FLAGS, VMA) && cpu->cfg.rvv_ma_all_1s;
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
+    ctx->cfg_mask_reg_full_update = cpu->cfg.rvv_mask_reg_full_update;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 8eee7e5c31..383224341a 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -94,6 +94,11 @@ static inline uint32_t vext_vta_all_1s(uint32_t desc)
     return FIELD_EX32(simd_data(desc), VDATA, VTA_ALL_1S);
 }
 
+static inline uint32_t vext_mask_reg_full_update(uint32_t desc)
+{
+    return FIELD_EX32(simd_data(desc), VDATA, MASK_REG_FULL_UPDATE);
+}
+
 /*
  * Earlier designs (pre-0.9) had a varying number of bits
  * per mask value (MLEN). In the 0.9 design, MLEN=1.
-- 
2.34.1


