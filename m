Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785E606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26b-0005HN-Gc; Sun, 25 Oct 2026 13:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24l-0001wG-1c; Sun, 25 Oct 2026 13:32:16 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24g-0007MI-GB; Sun, 25 Oct 2026 13:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=T3W3eyh7wv1wXXkyqKZLn7E3aZ05y3s9/HE+gfgltsc=; b=cWQAhgYy4RIYxZfl+chvIInPuf
 /yLfmwtezRZK2gqK2bTKuMAnKTzmxSzz2JqDeZQRCvR7rGeRqCCB+/bTcfk4RtQVG7KTfacgZ6zMq
 mzvDRacIIABeOMcvrVJYlbBYi5pNeTCZ15ipzhPzKBMjS0KvGt3ucA9k6p9WoKPwoA539wcyjzeoj
 Ld9C4Jf/Ln/XkHx2AxMEcg4Vt5gKRqM0PSa6KbgN9M0FlitJ4PuHfNTqFD9gI0SaFSmhKGp4mV69Z
 GKAvEXlipHqd416ZnDC/pI0Uj0wptWLMnC5tdK2vIeDkFNtLeQdKxfWnUkZs7t6G+zg6jfPNLUfgF
 KLHhOoqw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gP-00097a-10; Sun, 25 Oct 2026 18:06:57 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-0v; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:32 +0100
Subject: [PATCH v2 16/31] target/rx: add RXv3 register bank SAVE and RSTR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-16-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=8538;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=3Z7ShaAclJ+W8SCa92HjjjVPVQRdj0UxkSaTrwM5z4c=;
 b=qp8Ck9MKdf7nD9vP/AE88YgZhSLVLCJ1mUoA27xdOqukD+I4s2dD57hsjH8HadLuYuPORtKi5
 0PII+GNhPJRAYP1pnwj8T/LRNCnNjivVeOczHciuko1k+8P1pqUvtz7
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SAVE copies R1-R15, the USP, the FPSW and the accumulator into a save
register bank and RSTR copies them back; R0 is excluded because the
stack pointer is not banked. The banks are internal CPU state that
only these two instructions can reach, so no memory traffic is
involved. How many banks exist is implementation defined and comes
from RXCPUClass::num_save_banks (16 on the RX72M).

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/cpu.h        | 24 ++++++++++++++++++++
 target/rx/disas.c      | 24 ++++++++++++++++++++
 target/rx/helper.h     |  3 +++
 target/rx/insns.decode | 10 +++++++++
 target/rx/op_helper.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/translate.c  | 42 +++++++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 4c55b0bd7d..0d2ebe1bda 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -116,6 +116,15 @@ enum {
     NUM_DREGS = 16,
     /* RXv3 DPFPU control registers: DPSW, DCMR, DECNT, DEPC. */
     NUM_DCREGS = 4,
+    /*
+     * RXv3 register bank save function. The banks are internal CPU state
+     * reachable only through the SAVE and RSTR instructions, so no memory
+     * layout is involved. How many banks exist is implementation defined,
+     * so the per-model count lives in RXCPUClass::num_save_banks and this
+     * is only the storage ceiling. RX72M/RX72N/RX72T provide 16, selected
+     * by bank numbers 0-15.
+     */
+    RX_MAX_SAVE_BANKS = 16,
 };
 
 #define RX_EXCP_TRAP_COUNT          0x100
@@ -165,6 +174,18 @@ typedef enum RXISAVersion {
     RX_ISA_V3 = 3,
 } RXISAVersion;
 
+/*
+ * One save register bank, written by SAVE and read back by RSTR. A bank
+ * holds R1-R15 (R0/SP is excluded), the USP, the FPSW and the accumulators.
+ * QEMU models a single accumulator, so only ACC0 is covered here.
+ */
+typedef struct RXSaveBank {
+    uint32_t regs[NUM_REGS];    /* [0] unused: R0 is not banked */
+    uint32_t usp;
+    uint32_t fpsw;
+    uint64_t acc;
+} RXSaveBank;
+
 typedef struct CPUArchState {
     /* CPU registers */
     uint32_t regs[NUM_REGS];    /* general registers */
@@ -191,6 +212,9 @@ typedef struct CPUArchState {
     uint64_t dr[NUM_DREGS];     /* DR0-DR15 */
     uint32_t dcr[NUM_DCREGS];   /* DPSW, DCMR, DECNT, DEPC */
 
+    /* RXv3 register bank save function (SAVE/RSTR) */
+    RXSaveBank bank[RX_MAX_SAVE_BANKS];
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/rx/disas.c b/target/rx/disas.c
index 7d6cad753e..46148c4087 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1495,6 +1495,30 @@ static bool trans_BFMOVZ(DisasContext *ctx, arg_BFMOVZ *a)
     return true;
 }
 
+static bool trans_SAVE_r(DisasContext *ctx, arg_SAVE_r *a)
+{
+    prt("save\tr%d", a->rs);
+    return true;
+}
+
+static bool trans_SAVE_i(DisasContext *ctx, arg_SAVE_i *a)
+{
+    prt("save\t#%d", a->imm);
+    return true;
+}
+
+static bool trans_RSTR_r(DisasContext *ctx, arg_RSTR_r *a)
+{
+    prt("rstr\tr%d", a->rs);
+    return true;
+}
+
+static bool trans_RSTR_i(DisasContext *ctx, arg_RSTR_i *a)
+{
+    prt("rstr\t#%d", a->imm);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 0f05d38182..6c3b81b7ba 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -30,6 +30,9 @@ DEF_HELPER_2(itod, f64, env, i32)
 DEF_HELPER_2(utod, f64, env, i32)
 DEF_HELPER_2(ftod, f64, env, f32)
 DEF_HELPER_3(mvtdc, void, env, i32, i32)
+/* RXv3 register bank save function */
+DEF_HELPER_2(save, void, env, i32)
+DEF_HELPER_2(rstr, void, env, i32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 55c7e3994d..450949a4bc 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -46,6 +46,9 @@
 &dmovld		rs ld
 # RXv3 bit field move
 &bfm		rd rs
+# RXv3 register bank save/restore
+&svr		rs
+&svi		imm
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -720,3 +723,10 @@ DMOV_mld	1111 1100 1100 10 ld:2 rs:4 1000		&dmovld
 # RXv3: bit field move. The 16-bit field descriptor follows the opcode.
 BFMOVZ		1111 1100 0101 1010 rs:4 rd:4			&bfm
 BFMOV		1111 1100 0101 1110 rs:4 rd:4			&bfm
+
+########
+# RXv3: register bank save and restore
+SAVE_r		1111 1101 0111 0110 1100 rs:4 0000 0000		&svr
+RSTR_r		1111 1101 0111 0110 1101 rs:4 0000 0000		&svr
+SAVE_i		1111 1101 0111 0110 1110 0000 imm:8		&svi
+RSTR_i		1111 1101 0111 0110 1111 0000 imm:8		&svi
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 91af7c6685..5694c97286 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -121,6 +121,65 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
     }
 }
 
+/*
+ * RXv3 register bank save function. SAVE copies R1-R15, the USP, the FPSW
+ * and the accumulator into the selected save register bank; RSTR copies them
+ * back. R0 is deliberately excluded: the stack pointer is not banked.
+ *
+ * The banks are internal CPU state that only these two instructions can
+ * reach, so there is no memory layout to model. How many banks a part
+ * provides is implementation defined and comes from the CPU model.
+ */
+static RXSaveBank *rx_save_bank(CPURXState *env, uint32_t bank,
+                                const char *insn)
+{
+    uint32_t n = RX_CPU_GET_CLASS(env_cpu(env))->num_save_banks;
+
+    if (bank >= n) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rx: %s with out of range bank %u (this CPU has %u)\n",
+                      insn, bank, n);
+        return NULL;
+    }
+    return &env->bank[bank];
+}
+
+void helper_save(CPURXState *env, uint32_t bank)
+{
+    RXSaveBank *b = rx_save_bank(env, bank, "save");
+    int i;
+
+    if (!b) {
+        return;
+    }
+    for (i = 1; i < NUM_REGS; i++) {
+        b->regs[i] = env->regs[i];
+    }
+    b->usp = env->psw_u ? env->regs[0] : env->usp;
+    b->fpsw = env->fpsw;
+    b->acc = env->acc;
+}
+
+void helper_rstr(CPURXState *env, uint32_t bank)
+{
+    RXSaveBank *b = rx_save_bank(env, bank, "rstr");
+    int i;
+
+    if (!b) {
+        return;
+    }
+    for (i = 1; i < NUM_REGS; i++) {
+        env->regs[i] = b->regs[i];
+    }
+    if (env->psw_u) {
+        env->regs[0] = b->usp;
+    } else {
+        env->usp = b->usp;
+    }
+    env->fpsw = b->fpsw;
+    env->acc = b->acc;
+}
+
 void helper_set_fpsw(CPURXState *env, uint32_t val)
 {
     static const int roundmode[] = {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index db037634d5..93174f5e1c 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2501,6 +2501,48 @@ static bool trans_BFMOVZ(DisasContext *ctx, arg_BFMOVZ *a)
     return bfmov_common(ctx, a->rd, a->rs, true);
 }
 
+/*
+ * save / rstr -- the RXv3 register bank save function. A bank holds R1-R15,
+ * the USP, the FPSW and the accumulator; the banks are internal CPU state
+ * that nothing but these two instructions can reach, so no memory traffic
+ * is involved.
+ */
+static bool trans_SAVE_i(DisasContext *ctx, arg_SAVE_i *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_save(tcg_env, tcg_constant_i32(a->imm));
+    return true;
+}
+
+static bool trans_SAVE_r(DisasContext *ctx, arg_SAVE_r *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_save(tcg_env, cpu_regs[a->rs]);
+    return true;
+}
+
+static bool trans_RSTR_i(DisasContext *ctx, arg_RSTR_i *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_rstr(tcg_env, tcg_constant_i32(a->imm));
+    return true;
+}
+
+static bool trans_RSTR_r(DisasContext *ctx, arg_RSTR_r *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_rstr(tcg_env, cpu_regs[a->rs]);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


