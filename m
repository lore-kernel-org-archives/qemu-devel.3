Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD2606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL24T-0001KY-HQ; Sun, 25 Oct 2026 13:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24F-00011t-NF; Sun, 25 Oct 2026 13:31:40 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL24B-0007KH-Tz; Sun, 25 Oct 2026 13:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=TJhWO4twA+q0Mnq7aJRbN28RUXMesXN++2z4xQUh/gs=; b=BEFncQeW+OlvBGK47gLABhfBet
 USgQGVvgEZNWLYUXAwFgFH17D+IOPlXTPC9McqAMfDSBFtayCthgRFOJ2DY5y8Fcgkri5kNYK63oq
 JUN5ftVkll5T9RAoRT+9hO5ZOGPGonuYm6Mdw2iFm0Nz2RIKWP92/YlHDIsQEIMbiq4Qj7+A63g27
 zS5Wglxmr6kPgGF5Oaq6MZpEq/3g87YIFKXOfmKGfHpODD2v9PFZOrjTUqzX9KDvXe4BH7sYH1qZ0
 KYfVBtb7wK9oDHnKbJuinB4Kvc208l2spjzBkBnIfV86SZdDCbBz3ZLO6omMnKy7lZakPXc6duA6G
 H74TB8YQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1fb-0008yw-30; Sun, 25 Oct 2026 18:06:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-33; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:27 +0100
Subject: [PATCH v2 11/31] target/rx: add RXv3 DMOV half transfers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-11-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5611;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=sAMrIHHRa+h0HS7FS3WgGhc0E07+OCrCoDvFa2X40Eg=;
 b=q9s363Ecd6PsSg/64M+z0zheCB38xMFw4RSG6X067CitybUIB5X/SDr9S7i7kC/SsAMv4w6jb
 SoUQUp0SU/uC8oGzoxtM/zT4O4hV5RwFOG/ATJ6dA2Vv+hcVDELbsL+
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the DMOV.L/DMOV.D forms that move data between GPRs and the high
or low 32-bit halves of DR registers: DMOV.L rs/DRLs,rd, DMOV.D rs,DRHd
(which clears the low half, materialising doubles with a zero low
word) and DMOV.L DRLs/DRHs,rd.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 30 +++++++++++++++++++++
 target/rx/insns.decode | 15 +++++++++++
 target/rx/translate.c  | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 5a0d7180b5..20ef165832 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1338,6 +1338,36 @@ static bool trans_DPOPM_l(DisasContext *ctx, arg_DPOPM_l *a)
     return true;
 }
 
+static bool trans_DMOV_rdrl(DisasContext *ctx, arg_DMOV_rdrl *a)
+{
+    prt("dmov.l\tr%d, drl%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DMOV_rdrh(DisasContext *ctx, arg_DMOV_rdrh *a)
+{
+    prt("dmov.l\tr%d, drh%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DMOVD_rdrh(DisasContext *ctx, arg_DMOVD_rdrh *a)
+{
+    prt("dmov.d\tr%d, drh%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DMOV_drlr(DisasContext *ctx, arg_DMOV_drlr *a)
+{
+    prt("dmov.l\tdrl%d, r%d", a->drs, a->rd);
+    return true;
+}
+
+static bool trans_DMOV_drhr(DisasContext *ctx, arg_DMOV_drhr *a)
+{
+    prt("dmov.l\tdrh%d, r%d", a->drs, a->rd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 48325d7ebd..86f726849a 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -36,6 +36,9 @@
 &idr		rs drd
 &dppm		drd rnum
 &dcppm		dcrd rnum
+# RXv3 DPFPU: GPR/control-register/memory/immediate transfers
+&rdrh		rd drs
+&drhr		drd rs
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -674,3 +677,15 @@ DPOPM		0111 0101 1011 1000 drd:4 rnum:4		&dppm
 # DPUSHM.L/DPOPM.L: same, for the DPFPU control registers
 DPUSHM_l	0111 0101 1010 0000 dcrd:4 rnum:4		&dcppm
 DPOPM_l		0111 0101 1010 1000 dcrd:4 rnum:4		&dcppm
+
+########
+# RXv3: remaining DPFPU transfers
+#
+# GPR -> DR half (0xFD 0x77 prefix): byte3 low nibble is the source GPR,
+# byte4 high nibble the destination DR.
+DMOV_rdrl	1111 1101 0111 0111 1000 rs:4 drd:4 0000	&drhr
+DMOV_rdrh	1111 1101 0111 0111 1000 rs:4 drd:4 0010	&drhr
+DMOVD_rdrh	1111 1101 0111 0111 1000 rs:4 drd:4 0011	&drhr
+# DR half -> GPR (0xFD 0x75 prefix): byte3 low nibble is the destination GPR.
+DMOV_drlr	1111 1101 0111 0101 1000 rd:4 drs:4 0000	&rdrh
+DMOV_drhr	1111 1101 0111 0101 1000 rd:4 drs:4 0010	&rdrh
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 33e41ccab3..2c1971b234 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1964,6 +1964,21 @@ static void dr_write(int n, TCGv_i64 val)
     tcg_gen_mov_i64(cpu_dregs[n], val);
 }
 
+/* Write val into the high or low 32-bit half of DRn, preserving the other. */
+static void drh_write(int n, TCGv_i32 val)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, val);
+    tcg_gen_deposit_i64(cpu_dregs[n], cpu_dregs[n], t, 32, 32);
+}
+
+static void drl_write(int n, TCGv_i32 val)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, val);
+    tcg_gen_deposit_i64(cpu_dregs[n], cpu_dregs[n], t, 0, 32);
+}
+
 /* dadd DRdrs1, DRdrd, DRdrs2  (DRdrd = DRdrs1 + DRdrs2) */
 static bool trans_DADD(DisasContext *ctx, arg_DADD *a)
 {
@@ -2250,6 +2265,64 @@ static bool trans_DPOPM_l(DisasContext *ctx, arg_DPOPM_l *a)
     return true;
 }
 
+/* dmov.l rs, DRLd  -- write the low half of DRd, preserving the high half */
+static bool trans_DMOV_rdrl(DisasContext *ctx, arg_DMOV_rdrl *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drl_write(a->drd, cpu_regs[a->rs]);
+    return true;
+}
+
+/* dmov.l rs, DRHd -- write the high half of DRd, preserving the low half */
+static bool trans_DMOV_rdrh(DisasContext *ctx, arg_DMOV_rdrh *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drh_write(a->drd, cpu_regs[a->rs]);
+    return true;
+}
+
+/*
+ * dmov.d rs, DRHd -- write the high half of DRd and clear the low half.
+ * This is the single-instruction way to materialise a double whose low
+ * word is zero, which covers the common literals (1.0, 0.5, 2.0, ...).
+ */
+static bool trans_DMOVD_rdrh(DisasContext *ctx, arg_DMOVD_rdrh *a)
+{
+    TCGv_i64 t;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, cpu_regs[a->rs]);
+    tcg_gen_shli_i64(cpu_dregs[a->drd], t, 32);
+    return true;
+}
+
+/* dmov.l DRLs, rd */
+static bool trans_DMOV_drlr(DisasContext *ctx, arg_DMOV_drlr *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_extrl_i64_i32(cpu_regs[a->rd], cpu_dregs[a->drs]);
+    return true;
+}
+
+/* dmov.l DRHs, rd */
+static bool trans_DMOV_drhr(DisasContext *ctx, arg_DMOV_drhr *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_extrh_i64_i32(cpu_regs[a->rd], cpu_dregs[a->drs]);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


