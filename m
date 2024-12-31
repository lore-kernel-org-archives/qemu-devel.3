Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7719DE77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 03:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSSub-00006G-Bo; Mon, 30 Dec 2024 22:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuY-0008Sg-Ta
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuW-0006DH-Se
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:14 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21670dce0a7so33917015ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1735615631; x=1736220431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PEQzJ8oZ5e8hFBG5uwlKBhVUvvsft5/cB2jIsxTB4k=;
 b=QhFw+CHddiQqN6dYhj7AQYT9/V4BtSZ0MOMYnO3zsUotg8XKCuYllrlwqiqMgIDmlK
 4G1vSp4xzy2vXMrMyjigdmvo9N2TA8mxqu82MxOBETtoMW67iO95hK6wYvwVIlNvXZm7
 tIXGBr8Ne6nACXYv9ao+VXnsU/C1VrSfREmL5jyLj5u7VbE2UWaQPDWBBf/sIndpDTn5
 AkmRdMXOXG3tzoDGKXuU8sbdlBMPJ13NLgVx4TicUnOaLdH+1hGLjJM1fCmaOfeqy23X
 JyBvmkpHZksFMKNTiVr1JyNDyQ/2TApr7l2cmsWpeiewWaMlu1ofGKrY0HCjswBU4r+v
 43Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735615631; x=1736220431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PEQzJ8oZ5e8hFBG5uwlKBhVUvvsft5/cB2jIsxTB4k=;
 b=roaIfl3CEmk2Sy4IGykVOl0XDln3Vc7dBiHwXvsmA9NDMImlWrsfFA28HBHX/o/VNX
 mBlinxfcTQyTjzg14MHr7qQRnNyZqRmfj92l/n0NzzG745+ZmbeiBrtxEyCN1M9fZCRy
 qc9HgnOXW8OBnowZ49kpLAVlVVyvdS1Cw1kbfGD1gaDDPdTNItawy2ixorhfTX+dQ9wp
 KDvzqoc2EJXl8juE1lF9HCf+j11e196xYI0cl6ZudvR5r/z7BxogoHUDzUb6Q+Y0G5Jv
 AjI5IpV/AevZ98eoyV3wvMPwOH7PiZ1t1l0x3AFS+mfzll1fecpsV07rPB8Hb7CIRZhy
 26qw==
X-Gm-Message-State: AOJu0Ywv++y6Jyjp0xlD25g2lj0MAyQUYrWsIAruWf3n64eCk4cCJ6y/
 3hUzjPc89HTcfO1N1g4X1E7hsTeu7YCy0ZIJOvzRpPfKg0IGWCumA9oep1EvCqViJqxnHIRlzCU
 nONxQaah2sftcQARBUB8Ta5wn7oHfwYQUKHOkV00s6GEC4EysIJUWYpm7Z6+lPIPZ0FCH0lYV6a
 rgY0i6+ke5f6GfRvVC5f/rUH/L59PWjr6qVRYehVi1RzZL
X-Gm-Gg: ASbGncuYBceh1+WLsuTKFMLcR+IZjSF61+bAHPTFdew+SJWRC78xOPpWHDCf0YTwQ3I
 NB9ecB4tScCTbkEistWvyxEl+HBBtd0iy9I3xCPUrFL/C7EWCYNSI197KLWTpdZ3o8cCw7ufw9A
 Gp2JCTuYsk25uCsVzrD7e6nsPs8s7LsOE2lXXhzvSzgj37++Hi7QOouqrmlh1i6crXWNWSDbBtF
 6gyZxzjzPOBGLAlXqe1fCyO5dOsEFXmIwRyXo2j3Mk8q4s3Dn34FRZIXEI5+XXE8dUzA99iQD/L
 OSJpnGJEwKdn6Tpf4bCC
X-Google-Smtp-Source: AGHT+IERmm9n6P2m1Q87AVTb7YnLAh/HBJibnhEt+4wCEDZjI0laF78iwme0kwqXyqnzSNn8T//fiQ==
X-Received: by 2002:a05:6a20:c681:b0:1e1:a9dd:5a58 with SMTP id
 adf61e73a8af0-1e5e080dfb8mr57379844637.30.1735615630984; 
 Mon, 30 Dec 2024 19:27:10 -0800 (PST)
Received: from fchang-1826.. (1-169-235-48.dynamic-ip.hinet.net.
 [1.169.235.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-92587c62eacsm291797a12.21.2024.12.30.19.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 19:27:10 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v11 4/6] target/riscv: Add Smrnmi mnret instruction
Date: Tue, 31 Dec 2024 11:26:52 +0800
Message-Id: <20241231032654.133039-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231032654.133039-1-frank.chang@sifive.com>
References: <20241231032654.133039-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

This patch adds a new instruction 'mnret'. 'mnret' is an M-mode-only
instruction that uses the values in `mnepc` and `mnstatus` to return to the
program counter, privilege mode, and virtualization mode of the
interrupted context.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 ++
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++++++
 target/riscv/op_helper.c                      | 45 ++++++++++++++++---
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..63ec53e992 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -321,24 +321,30 @@ target_ulong helper_sret(CPURISCVState *env)
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
@@ -370,6 +376,35 @@ target_ulong helper_mret(CPURISCVState *env)
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
-- 
2.34.1


