Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8258BC02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJt7-0004LS-IQ; Sat, 18 Jan 2025 20:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJt5-00048x-9C
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:03 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJt1-0003Hx-RO
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:02 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so4504306a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249238; x=1737854038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88uejHTxMUfNWO2ZqFUoG+1CMbM4VmsqYQ0Rsno50SI=;
 b=fsW/bh9+cnSv3KB9XJsjWX9vsfHQNGNXIbhfu6VVuYx44pTnRzVgHbQ1E3HgaKVsRF
 WdCfUOeFjp0hJcMpy3JYfPOhyQNqB4vBiUjueua+vkJUfamXNsm8st2CXPSGUFxSmyae
 PKjq0Dkizv1FPXKARaeejWozeJ0EUXZjgNnShSzikj6w/MHBrupfqHpH+cEh20FSNWS0
 zOStz6pBDeEaCcAn+Z+yIMfMRRhIR8vIUKziaSd2qb81cqEieUgL2Xdb2RUgrFsbVSN1
 cVGjUEMDJgzxxuI22v7BfPo8SwG5CGICuZ/7VSsCTvMWxxUz+AabgVCM2kDsL+ejSs1Y
 egcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249238; x=1737854038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88uejHTxMUfNWO2ZqFUoG+1CMbM4VmsqYQ0Rsno50SI=;
 b=NHZZAYvWt0BVWre+ylE6dzLw9z4IlCszCUjdHkA4Sd8vOCevaCkQpn79MhbagTroJE
 fh4RcXTDL64FT00Xv1uGW89npN45KyqJChgXajYsEh67U81vtVjkamqEWuOA+2AIVkZE
 4phveifhqIXttnV+sfUqkGWdTYdoZEMGQBsQHosJbQLjqniR+rL9xnqjPfaDr3DcGNsI
 fWBH2ZqNh80R3BOPwUttkaYpjAkmDqmKWP/OdakOQeQnQhZnyXAl9q736m49A9yZlU2p
 P+9ObL21ph6GmfLm+eLBCir7jDXIiIlX8xlOtzmv0Ho0rDXRIMjs0ciS6fHqyjHIwowf
 Uoyw==
X-Gm-Message-State: AOJu0YzfF5BhJZjW2a7V+18g1Oo287gRPTIalChr92/ntHceqkXyuvna
 ZOYMH+e7Ve4MCNvIhsWqDUjbWIRMaU6jMKGltQMdbGwEx0vecEN/PxIVi42s
X-Gm-Gg: ASbGncsXXZuD/WSud+1npHUsSwTjjGjTKJN0cFeLvBmvIvEKhQVDRHWa/1FHcx7qF7r
 bt8gFiFMnqlfzYIgisMaIKBBb3bl3oan+4ywhv3sc2LvFOeChgqJKJ2zP5sN4YcJzSXS1jfh74j
 G+VhLLeyoq+KAimIjnsQ5NcezyedNKWCOM96uvbUEGz9c3Men2qIHmtcJci7fivlKUW50VcyhvX
 k6Md81aAy44b19dx6nY77bXOBCJ4kBmhvc23Nyz7MaSfEn1vuvfW7/Y2WVBUxB9palIJzPP/g7+
 BZowqMX0uLDr5AiUFDesZExR48ZPjxvjHNuQUhWK9hHrhNW1KxKwfeXUAqAgMXlu11rrfSQRsg=
 =
X-Google-Smtp-Source: AGHT+IH+UqLvfmNt5HPoAl4JsbueoWcv/0XpHLeMUfzvGtS6PKmXlLW2iu4l9HhxEJaUj3EOsyp0TQ==
X-Received: by 2002:a17:90b:5145:b0:2ef:33a4:ae6e with SMTP id
 98e67ed59e1d1-2f782c779edmr13959124a91.12.1737249238150; 
 Sat, 18 Jan 2025 17:13:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 23/50] target/riscv: Add Smrnmi mnret instruction
Date: Sun, 19 Jan 2025 11:11:58 +1000
Message-ID: <20250119011225.11452-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

This patch adds a new instruction 'mnret'. 'mnret' is an M-mode-only
instruction that uses the values in `mnepc` and `mnstatus` to return to the
program counter, privilege mode, and virtualization mode of the
interrupted context.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-5-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 ++
 target/riscv/op_helper.c                      | 45 ++++++++++++++++---
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++++++
 4 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..16ea240d26 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e9139ec1b9..942c434c6e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -121,6 +121,9 @@ wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
+# *** NMI ***
+mnret       0111000    00010 00000 000 00000 1110011
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 952ef8b3ec..bb022d89e2 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -328,24 +328,30 @@ target_ulong helper_sret(CPURISCVState *env)
     return retpc;
 }
 
-target_ulong helper_mret(CPURISCVState *env)
+static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
+                                  target_ulong prev_priv)
 {
     if (!(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong retpc = env->mepc;
     if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    uint64_t mstatus = env->mstatus;
-    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-
     if (riscv_cpu_cfg(env)->pmp &&
         !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
+}
+
+target_ulong helper_mret(CPURISCVState *env)
+{
+    target_ulong retpc = env->mepc;
+    uint64_t mstatus = env->mstatus;
+    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+
+    check_ret_from_m_mode(env, retpc, prev_priv);
 
     target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
                              (prev_priv != PRV_M);
@@ -377,6 +383,35 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_mnret(CPURISCVState *env)
+{
+    target_ulong retpc = env->mnepc;
+    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
+    target_ulong prev_virt;
+
+    check_ret_from_m_mode(env, retpc, prev_priv);
+
+    prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
+                (prev_priv != PRV_M);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
+
+    /*
+     * If MNRET changes the privilege mode to a mode
+     * less privileged than M, it also sets mstatus.MPRV to 0.
+     */
+    if (prev_priv < PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
+    }
+
+    if (riscv_has_ext(env, RVH) && prev_virt) {
+        riscv_cpu_swap_hypervisor_regs(env);
+    }
+
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
+
+    return retpc;
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index ecd3b8b2c9..73f940d406 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -18,6 +18,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define REQUIRE_SMRNMI(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_smrnmi) { \
+        return false;                \
+    }                                \
+} while (0)
+
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
     /* always generates U-level ECALL, fixed in do_interrupt handler */
@@ -106,6 +112,20 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    REQUIRE_SMRNMI(ctx);
+    decode_save_opc(ctx, 0);
+    gen_helper_mnret(cpu_pc, tcg_env);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.48.1


