Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D416C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsc1h-0002sO-En; Thu, 13 Mar 2025 02:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1tsc1W-0002mD-C5; Thu, 13 Mar 2025 02:26:30 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1tsc1T-0001ax-Pg; Thu, 13 Mar 2025 02:26:30 -0400
DKIM-Signature: a=rsa-sha256; bh=5K8H/jmxlUo60aQoSRUOvnKC4+aTfzW8n2yRmbXamYQ=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1741847182; v=1;
 b=pgoqDePVdomwOkV0vKtx5HMxeXhPtDNT3nkMbPaT+nF5ElfEShIZZHMXZXSFMnNUpy5RPI71
 Y0bdLqP/yNRiQEetNMW4MyFFvT2nOUOdZ0vithcPXomyO+6WpbI/+MBfz316lQiYg4mvlluXjGH
 0LV9HeP3HMklGtdkohqVIEVItq4T0ABI5kFvxziYtljO8bPVF7S0L/wITQWduPn99Q+ZNzBc7Nb
 Fv0Wv1hjtQ/vb/9pc+gYp3QkiR7xOzseisMKa7KsuNKjUBLz4Og7T0l13DkM5VGEwJ8kqsYJjLD
 NSU1OAdEQZwwjRRREnYHC8/SwNBCPK9aElMoVdxzWyFDA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id AE363206AE;
 Thu, 13 Mar 2025 06:26:22 +0000 (UTC)
From: ~yuming <yuming@git.sr.ht>
Date: Thu, 13 Mar 2025 14:07:58 +0800
Subject: [PATCH qemu] target/riscv: Add check for 16-bit aligned PC for
 different priv versions.
Message-ID: <174184718265.10540.10120024221661781046-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, yumin686@andestech.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~yuming <yumin686@andestech.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yu-Ming Chang <yumin686@andestech.com>

For privilege version 1.12 or newer, C always implies Zca. We can only
check ext_zca to allow 16-bit aligned PC addresses. For older privilege
versions, we only check C.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
---
 target/riscv/cpu.h                      | 12 ++++++++++++
 target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
 target/riscv/op_helper.c                |  8 ++++++--
 target/riscv/translate.c                |  4 +++-
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7de19b4183..51e49e03de 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -765,6 +765,18 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 }
 #endif
=20
+static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
+                                              target_long priv_ver,
+                                              uint32_t misa_ext)
+{
+    /* In priv spec version 1.12 or newer, C always implies Zca */
+    if (priv_ver >=3D PRIV_VERSION_1_12_0) {
+        return cfg->ext_zca;
+    } else {
+        return misa_ext & RVC;
+    }
+}
+
 /*
  * Encode LMUL to lmul as follows:
  *     LMUL    vlmul    lmul
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_tran=
s/trans_rvi.c.inc
index b55f56a5eb..b9c7160468 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -151,7 +151,9 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         tcg_gen_ext32s_tl(target_pc, target_pc);
     }
=20
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
+    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
+                                    ctx->priv_ver,
+                                    ctx->misa_ext)) {
         TCGv t0 =3D tcg_temp_new();
=20
         misaligned =3D gen_new_label();
@@ -300,7 +302,9 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCo=
nd cond)
=20
     gen_set_label(l); /* branch taken */
=20
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
+    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
+                                    ctx->priv_ver,
+                                    ctx->misa_ext) &&
         (a->imm & 0x3)) {
         /* misaligned */
         TCGv target_pc =3D tcg_temp_new();
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 0d4220ba93..72dc48e58d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -279,7 +279,9 @@ target_ulong helper_sret(CPURISCVState *env)
     }
=20
     target_ulong retpc =3D env->sepc;
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
+                                    env->priv_ver,
+                                    env->misa_ext) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
@@ -357,7 +359,9 @@ static void check_ret_from_m_mode(CPURISCVState *env, tar=
get_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
+                                    env->priv_ver,
+                                    env->misa_ext) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index eaa5d86eae..d6651f244f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -606,7 +606,9 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulo=
ng imm)
     TCGv succ_pc =3D dest_gpr(ctx, rd);
=20
     /* check misaligned: */
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
+    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
+                                    ctx->priv_ver,
+                                    ctx->misa_ext)) {
         if ((imm & 0x3) !=3D 0) {
             TCGv target_pc =3D tcg_temp_new();
             gen_pc_plus_diff(target_pc, ctx, imm);
--=20
2.45.3

