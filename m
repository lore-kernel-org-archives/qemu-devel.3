Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D01606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Hb85iUQs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYs-0008JQ-Pe; Wed, 18 Nov 2026 04:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYi-0008G9-0t; Wed, 18 Nov 2026 04:02:29 -0500
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-000429-4m; Wed, 18 Nov 2026 04:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992517; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=A0/m2QKKaKxovbzQTbRcYg1vI/4ZfgriynYbVmq0CSA=;
 b=Hb85iUQsTsByXI+OVNFT0vJvomU5r8gPGPSbZdwzzSaBCsTBUB0KrYs4FeTuK9QRoAyLJ4DpAS85Z90/9I7/3kuEQUQILjJzTjFcTWrAIbyuu+LDQlNTyCSGOidR8tSgDqSJqjpB7jkrRrwws43Ke2XhZZ4ksQycqOQHjKRxIhw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0Gqhc_1794992516; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0Gqhc_1794992516 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:56 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 18 Nov 2026 17:01:30 +0800
Subject: [PATCH RFC 3/8] target/riscv: Prepare Zl instruction alignment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-zl-master-v1-3-129f85e0f887@linux.alibaba.com>
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=7418;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=jpIMMq63dduIgaH8ws2nd5moybfR2Tw0edZyyB3MQCA=;
 b=blepyQwNB1owm4DucBTK6JoEvxX+1UTH/7oVDaPGkJImT28GWQ+0VE9VXqjpa4cTSjLrkn6Tt
 +iXV2AfdZWQDyOCUetVooZE/yjm1DvFijcaXG2aEygnEBzbmSoHsCm5
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Zl requires IALIGN=16 even when compressed instructions are disabled.
Add an internal ext_zl flag and apply it to jumps, EPC/DPC masking, trap
returns and misa.C writes. Keep compressed instruction decoding under
its existing extension checks.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.h                          | 10 +++++++---
 target/riscv/cpu_cfg_fields.h.inc           |  1 +
 target/riscv/internals.h                    |  4 ++--
 target/riscv/tcg/csr.c                      |  7 +++++--
 target/riscv/tcg/insn_trans/trans_rvi.c.inc |  8 ++------
 target/riscv/tcg/op_helper.c                | 10 ++++------
 target/riscv/tcg/translate.c                |  4 +---
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdbb2b9b56f3d9ad1e8ba18ae2010c7cb..f157a40b019a1bc23408d2a70530d1b58b7278d0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -921,10 +921,14 @@ bool riscv_cpu_eff_priv(CPURISCVState *env, privilege_mode_t *priv, bool *virt)
     return mode_modified;
 }
 
-static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
-                                              uint32_t priv_ver,
-                                              uint32_t misa_ext)
+/* Instruction alignment is independent of compressed instruction decoding. */
+static inline bool riscv_cpu_ialign16(const RISCVCPUConfig *cfg,
+                                    uint32_t priv_ver, uint32_t misa_ext)
 {
+    if (cfg->ext_zl) {
+        return true;
+    }
+
     /* In priv spec version 1.12 or newer, C always implies Zca */
     if (priv_ver >= PRIV_VERSION_1_12_0) {
         return cfg->ext_zca;
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 85fc3ad8bb8ca059b4c391afde2ab14c95018145..30a8d21b7553b7d22b1ca2647dc00789330657f5 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -30,6 +30,7 @@ BOOL_FIELD(ext_zks)
 BOOL_FIELD(ext_zksed)
 BOOL_FIELD(ext_zksh)
 BOOL_FIELD(ext_zkt)
+BOOL_FIELD(ext_zl)
 BOOL_FIELD(ext_zifencei)
 BOOL_FIELD(ext_zicntr)
 BOOL_FIELD(ext_zicsr)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 2d48abeef5dea2cb9d0e97852495fed75d670ae1..4e11888b03e0dcb050426892e1758d733273bf99 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -191,9 +191,9 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
 
     /*
      * When IALIGN=32, both low bits must be zero.
-     * When IALIGN=16 (has C or Zc* extensions), only bit 0 must be zero.
+     * When IALIGN=16 (C, Zc* or Zl fetch), only bit 0 must be zero.
      */
-    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
+    if (cpu->cfg.ext_zl || riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
         cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
         cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
         return ~(target_ulong)1;
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f32f5d0b6cc86eeb530705a8bcad0e6..3972d1f4112f3ad52ae352d4c55a2799aed0c992 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2231,8 +2231,11 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /* drop write if RVC is cleared and next instruction is not aligned */
-    if ((env->misa_ext & RVC) && !(val & RVC) &&
+    /*
+     * Ignore writes that clear C if the next instruction is not 4-byte aligned.
+     * With Zl, IALIGN remains 16 and the write need not be suppressed.
+     */
+    if (!cpu->cfg.ext_zl && (env->misa_ext & RVC) && !(val & RVC) &&
          (get_next_pc(env, ra) & 3) != 0) {
         qemu_log_mask(LOG_GUEST_ERROR, "Unable to write MISA ext value "
                       "0x%x, MISA.C disable failed\n", env->misa_ext);
diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index 4784ea1607e74eb5b0076425a732b5d3817b3482..ba5e274da3b778d564930386471387a36ddd63ce 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -151,9 +151,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         tcg_gen_ext32s_tl(target_pc, target_pc);
     }
 
-    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
-                                    ctx->priv_ver,
-                                    ctx->misa_ext)) {
+    if (!riscv_cpu_ialign16(ctx->cfg_ptr, ctx->priv_ver, ctx->misa_ext)) {
         TCGv t0 = tcg_temp_new();
 
         misaligned = gen_new_label();
@@ -302,9 +300,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 
     gen_set_label(l); /* branch taken */
 
-    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
-                                    ctx->priv_ver,
-                                    ctx->misa_ext) &&
+    if (!riscv_cpu_ialign16(ctx->cfg_ptr, ctx->priv_ver, ctx->misa_ext) &&
         (a->imm & 0x3)) {
         /* misaligned */
         TCGv target_pc = tcg_temp_new();
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f9c79fe6b9006c7667acfda4865ca59fbb970d5d..0dda250203790840e0c0ed20d917eeb645c61a60 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -318,9 +318,8 @@ target_ulong HELPER(sret)(CPURISCVState *env)
     }
 
     target_ulong retpc = env->sepc & get_xepc_mask(env);
-    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
-                                    env->priv_ver,
-                                    env->misa_ext) && (retpc & 0x3)) {
+    if (!riscv_cpu_ialign16(&env_archcpu(env)->cfg, env->priv_ver,
+                          env->misa_ext) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
@@ -395,9 +394,8 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 
-    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
-                                    env->priv_ver,
-                                    env->misa_ext) && (retpc & 0x3)) {
+    if (!riscv_cpu_ialign16(&env_archcpu(env)->cfg, env->priv_ver,
+                          env->misa_ext) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
     }
 
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 79b0f444efbd954c48c14812b0f566ace7830245..51024ee9a37df548ec27587c9b4bb240afd1d5a5 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -630,9 +630,7 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     TCGv succ_pc = dest_gpr(ctx, rd);
 
     /* check misaligned: */
-    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
-                                    ctx->priv_ver,
-                                    ctx->misa_ext)) {
+    if (!riscv_cpu_ialign16(ctx->cfg_ptr, ctx->priv_ver, ctx->misa_ext)) {
         if ((imm & 0x3) != 0) {
             TCGv target_pc = tcg_temp_new();
             gen_pc_plus_diff(target_pc, ctx, imm);

-- 
2.43.0


