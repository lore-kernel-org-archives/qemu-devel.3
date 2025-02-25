Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A121C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 01:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmk3x-0007EU-1R; Mon, 24 Feb 2025 20:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1tmk3v-0007Dw-HJ; Mon, 24 Feb 2025 20:48:43 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1tmk3t-0003mI-A4; Mon, 24 Feb 2025 20:48:43 -0500
DKIM-Signature: a=rsa-sha256; bh=TOkqf+2c+ZTgv85DXJaT5IhKf1HzuAnouJZhNQHkqaE=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1740448117; v=1;
 b=R5vC2OsafHYY1rnDZh5N8ZfDpE6nP8EEbhcCu0bR6JxCNkqyj6A9dRsULiDHfrx5gV9Rk/2s
 yPPM+IA4KXaJPIskwlQAFPNq5h7HUGfVX6+PfvsqK5DFebmUZEQkHULf1DXJ8668p3kXsugpeNI
 hXvwbT1cJzkJLtxP8aNwRvX83jgH1plH7rOKZA6B7sqCSp1ScCQ15A0edCGjvXvnXLoL0x6c40c
 9AZVehv02fsF2dl6iIT/FSgtrCkZM9bwLsF3H3hwebp7HSYXQSGYNJ7odGz4rYNHHGFj5E+LKqp
 T4AMiZxUwwZW/i9HSzNXwRcMReeXLGLhHIkzZ1BuBRj0A==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id D68B72033F;
 Tue, 25 Feb 2025 01:48:37 +0000 (UTC)
From: ~yuming <yuming@git.sr.ht>
Date: Tue, 25 Feb 2025 09:36:11 +0800
Subject: [PATCH qemu] target/riscv: Only check ext_zca for 16-bit aligned PC.
Message-ID: <174044811783.27139.4910941776283875756-0@git.sr.ht>
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
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Since C always implies Zca, Zca is always enabled when 16-bit
insructions are supported. we can only check ext_zca to allow
16-bit aligned PC addresses.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 5 ++---
 target/riscv/op_helper.c                | 4 ++--
 target/riscv/translate.c                | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_tran=
s/trans_rvi.c.inc
index 96c218a9d7..e5965201a7 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -106,7 +106,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         tcg_gen_ext32s_tl(target_pc, target_pc);
     }
=20
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
+    if (!ctx->cfg_ptr->ext_zca) {
         TCGv t0 =3D tcg_temp_new();
=20
         misaligned =3D gen_new_label();
@@ -236,8 +236,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCo=
nd cond)
=20
     gen_set_label(l); /* branch taken */
=20
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
-        (a->imm & 0x3)) {
+    if (!ctx->cfg_ptr->ext_zca && (a->imm & 0x3)) {
         /* misaligned */
         TCGv target_pc =3D tcg_temp_new();
         gen_pc_plus_diff(target_pc, ctx, a->imm);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index ce1256f439..68882136d7 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -276,7 +276,7 @@ target_ulong helper_sret(CPURISCVState *env)
     }
=20
     target_ulong retpc =3D env->sepc;
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+    if (!env_archcpu(env)->cfg.ext_zca && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
@@ -349,7 +349,7 @@ static void check_ret_from_m_mode(CPURISCVState *env, tar=
get_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+    if (!env_archcpu(env)->cfg.ext_zca && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 698b74f7a8..34eeed50be 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -566,7 +566,7 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulo=
ng imm)
     TCGv succ_pc =3D dest_gpr(ctx, rd);
=20
     /* check misaligned: */
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
+    if (!ctx->cfg_ptr->ext_zca) {
         if ((imm & 0x3) !=3D 0) {
             TCGv target_pc =3D tcg_temp_new();
             gen_pc_plus_diff(target_pc, ctx, imm);
--=20
2.45.3

