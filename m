Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36125606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26Z-00055n-0J; Sun, 25 Oct 2026 13:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25C-0002Lw-0E; Sun, 25 Oct 2026 13:32:41 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25A-0007Nt-92; Sun, 25 Oct 2026 13:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=TY0Jn3aK3Ti5HSMQlldYcdXQ6y1AR8/gUUGr8QWJmNs=; b=kkBoMoFPkPNsp+ydqAVdfay5la
 4mHXvLtMGmSPLUFE1G/BC8XIxme/RS1onNiXHyaxVFOQ7PTm9LYyzV+thYlewlC9HzXAdAF7TvsAD
 oXOCAuowu5AO+8sKNZc6M9GHocj4UjMnFBd1rV0vfXETdi/z+7mxkVqjQeD9AZ6CkuAhSDKCj/dzr
 S7hBCZsCQXaWRacS3hWS9dawawGBEeknIW+a5AheBAVS+gUBduW5UjmZujPMQ093vfpDa98XSQlQb
 p2J19phufdgU0f/gaFRNl6eY/XLKtr+td/HzFd6hyKdgsYRm4kRnjp2HMzwHCpmNlgpFnzhds53P9
 OWYtIapg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gT-00099W-23; Sun, 25 Oct 2026 18:07:01 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-1M; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:34 +0100
Subject: [PATCH v2 18/31] target/rx: add RXv2 accumulator context save/restore
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-18-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5269;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=BCdk7j+5Gvx8i8magLOKhKZfS2VNjWBKQV/wbnEgUL0=;
 b=3fVbqjpMu96IbdvfDW/uJIu8xm86Tr0OaMzD2i2LXK+LUZHV5FzSdCUrnveFlynCP7PiCfp5u
 gHOsy5Gg3YdBiH3Ovl35LFraYiNoQBwGtFafBvsooYx0P22icIUsoBo
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

RXv2 adds ACC1 and 8-bit guard fields to the accumulators, with
instructions to move them for interrupt context save/restore:
MVTACHI/MVTACLO A1, MVTACGU, MVFACHI A1, MVFACLO and MVFACGU. The
moves read the raw, unshifted accumulator values.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/cpu.h        |  2 ++
 target/rx/disas.c      | 36 ++++++++++++++++++++++++++
 target/rx/insns.decode |  8 ++++++
 target/rx/translate.c  | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 0d2ebe1bda..c934ee8005 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -207,6 +207,8 @@ typedef struct CPUArchState {
     uint32_t fintv;
     uint32_t fpsw;
     uint64_t acc;
+    uint64_t acc1;
+    uint32_t acc_guard[2]; /* Sign-extended 8-bit RXv2 guard fields. */
 
     /* RXv3 double-precision FPU (DPFPU) */
     uint64_t dr[NUM_DREGS];     /* DR0-DR15 */
diff --git a/target/rx/disas.c b/target/rx/disas.c
index 924cfdd382..714031eef4 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1077,6 +1077,42 @@ static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
     return true;
 }
 
+static bool trans_MVTACHI_A1(DisasContext *ctx, arg_MVTACHI_A1 *a)
+{
+    prt("mvtachi\tr%d, a%d", a->r, 1);
+    return true;
+}
+
+static bool trans_MVTACLO_A1(DisasContext *ctx, arg_MVTACLO_A1 *a)
+{
+    prt("mvtaclo\tr%d, a%d", a->r, 1);
+    return true;
+}
+
+static bool trans_MVTACGU(DisasContext *ctx, arg_MVTACGU *a)
+{
+    prt("mvtacgu\tr%d, a%d", a->r, a->a);
+    return true;
+}
+
+static bool trans_MVFACHI_A1(DisasContext *ctx, arg_MVFACHI_A1 *a)
+{
+    prt("mvfachi\t#0, a%d, r%d", 1, a->r);
+    return true;
+}
+
+static bool trans_MVFACLO(DisasContext *ctx, arg_MVFACLO *a)
+{
+    prt("mvfaclo\t#0, a%d, r%d", a->a, a->r);
+    return true;
+}
+
+static bool trans_MVFACGU(DisasContext *ctx, arg_MVFACGU *a)
+{
+    prt("mvfacgu\t#0, a%d, r%d", a->a, a->r);
+    return true;
+}
+
 /* racw #imm */
 static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 {
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 4ac849d32a..bdb2e11ec0 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -734,3 +734,11 @@ RSTR_i		1111 1101 0111 0110 1111 0000 imm:8		&svi
 ########
 # RXv3: three-operand XOR
 XOR_rrr		1111 1111 0110 .... .... ....		@b3_rd_rs_rs2
+
+# RXv2 accumulator context save/restore (unshifted reads).
+MVTACHI_A1 1111 1101 0001 0111 1000 r:4
+MVTACLO_A1 1111 1101 0001 0111 1001 r:4
+MVTACGU 1111 1101 0001 0111 a:1 011 r:4
+MVFACHI_A1 1111 1101 0001 1111 1000 r:4
+MVFACLO 1111 1101 0001 1111 a:1 001 r:4
+MVFACGU 1111 1101 0001 1111 a:1 011 r:4
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 7b5f74fb5e..027495d4fc 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1833,6 +1833,76 @@ static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
     return true;
 }
 
+/* RXv2 accumulator moves used by interrupt context save/restore. */
+static bool rx_acc_move(DisasContext *ctx, int reg, int acc,
+                        int part, bool write)
+{
+    TCGv_i64 value;
+    int offset;
+
+    if (!require_isa(ctx, RX_ISA_V2)) {
+        return false;
+    }
+    if (part == 2) {
+        offset = offsetof(CPURXState, acc_guard) + acc * sizeof(uint32_t);
+        if (write) {
+            TCGv_i32 guard = tcg_temp_new_i32();
+            tcg_gen_ext8s_i32(guard, cpu_regs[reg]);
+            tcg_gen_st_i32(guard, tcg_env, offset);
+        } else {
+            tcg_gen_ld_i32(cpu_regs[reg], tcg_env, offset);
+        }
+        return true;
+    }
+    value = acc ? tcg_temp_new_i64() : cpu_acc;
+    if (acc) {
+        tcg_gen_ld_i64(value, tcg_env, offsetof(CPURXState, acc1));
+    }
+    if (write) {
+        TCGv_i64 src = tcg_temp_new_i64();
+        tcg_gen_extu_i32_i64(src, cpu_regs[reg]);
+        tcg_gen_deposit_i64(value, value, src, part * 32, 32);
+        if (acc) {
+            tcg_gen_st_i64(value, tcg_env, offsetof(CPURXState, acc1));
+        }
+    } else if (part) {
+        tcg_gen_extrh_i64_i32(cpu_regs[reg], value);
+    } else {
+        tcg_gen_extrl_i64_i32(cpu_regs[reg], value);
+    }
+    return true;
+}
+
+static bool trans_MVTACHI_A1(DisasContext *ctx, arg_MVTACHI_A1 *a)
+{
+    return rx_acc_move(ctx, a->r, 1, 1, true);
+}
+
+static bool trans_MVTACLO_A1(DisasContext *ctx, arg_MVTACLO_A1 *a)
+{
+    return rx_acc_move(ctx, a->r, 1, 0, true);
+}
+
+static bool trans_MVTACGU(DisasContext *ctx, arg_MVTACGU *a)
+{
+    return rx_acc_move(ctx, a->r, a->a, 2, true);
+}
+
+static bool trans_MVFACHI_A1(DisasContext *ctx, arg_MVFACHI_A1 *a)
+{
+    return rx_acc_move(ctx, a->r, 1, 1, false);
+}
+
+static bool trans_MVFACLO(DisasContext *ctx, arg_MVFACLO *a)
+{
+    return rx_acc_move(ctx, a->r, a->a, 0, false);
+}
+
+static bool trans_MVFACGU(DisasContext *ctx, arg_MVFACGU *a)
+{
+    return rx_acc_move(ctx, a->r, a->a, 2, false);
+}
+
 /* racw #imm */
 static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 {

-- 
2.53.0


