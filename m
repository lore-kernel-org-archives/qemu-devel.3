Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F1606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL22w-0008Gv-9F; Sun, 25 Oct 2026 13:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22d-0008BK-2L; Sun, 25 Oct 2026 13:29:58 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22Z-0006zX-Gp; Sun, 25 Oct 2026 13:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9UGUkbKNVrH/rmS+Xc8Oz1VnzStcXAXi+tszUyI2HHs=; b=YGzndGf9q6VfWOGP1fdjcsbYqt
 TeB3yDdQpsqxHb4ar7iuYf3zaIHsV8N98YVPeUfZtO8iy7xm13JOC2WvR/fTerRmFYd1+rA0LC/og
 98vee3N/H9wJwTkjIBEwDcrsHpNe+9uM6LCl1YbL/yIbr++eH8w6MDX+HE2mErLEYyVMmxLXaP8Nx
 eWsKm9YvKWyn5bUGgGUvxksDH/GAWZi5jsC+FMx+u0IH6lKYfMO3UluSYgSxCoPure1djgxQehOY9
 qDj5qvIsRGA7E1Kyh4iie2ZzBvSz1OQSNGKvm0NMudcpLzdZnusLgl2V2O6dROrxAg7lg9ZINqjA5
 9Yq1p0Og==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gQ-000989-2M; Sun, 25 Oct 2026 18:06:58 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-02; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:28 +0100
Subject: [PATCH v2 12/31] target/rx: add DPFPU control register transfers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-12-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5813;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=1YKjCyKi5TbpEYvrRx9sd+cEDiizcEBEeID6ciAy27k=;
 b=YQI1ZuukjPIRnB+EslTfpKWNxLQPX2JtdcLc/N53Erep7ngU+3KWwgomlElQ43PcIxsigcGcd
 8c1DLzWo2b4DbgwYMPOKUQ6vjJgjaoFin/bR2v3AXFpVvy2A8ViA8jb
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

Add MVFDC and MVTDC to move DPFPU control registers (DPSW, DCMR,
DECNT, DEPC) to and from GPRs, and MVFDR to move the DCMP result
(DCMR.RES) into PSW.Z so it can be branched on. MVTDC is not a plain
register write: the DC* cause bits in DPSW clear on a written 0 and
keep their value on a written 1, DFS is a read-only summary, DCMR
holds only RES, and DEPC is read-only.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 18 ++++++++++++++++++
 target/rx/helper.h     |  1 +
 target/rx/insns.decode |  7 +++++++
 target/rx/op_helper.c  | 31 +++++++++++++++++++++++++++++++
 target/rx/translate.c  | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 20ef165832..062d8c2d6b 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1368,6 +1368,24 @@ static bool trans_DMOV_drhr(DisasContext *ctx, arg_DMOV_drhr *a)
     return true;
 }
 
+static bool trans_MVFDC(DisasContext *ctx, arg_MVFDC *a)
+{
+    prt("mvfdc\t%s, r%d", dcrname[a->dcrs & 3], a->rd);
+    return true;
+}
+
+static bool trans_MVTDC(DisasContext *ctx, arg_MVTDC *a)
+{
+    prt("mvtdc\tr%d, %s", a->rs, dcrname[a->dcrd & 3]);
+    return true;
+}
+
+static bool trans_MVFDR(DisasContext *ctx, arg_MVFDR *a)
+{
+    prt("mvfdr");
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 5bf0ed0aa2..0f05d38182 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -29,6 +29,7 @@ DEF_HELPER_2(dtof, f32, env, f64)
 DEF_HELPER_2(itod, f64, env, i32)
 DEF_HELPER_2(utod, f64, env, i32)
 DEF_HELPER_2(ftod, f64, env, f32)
+DEF_HELPER_3(mvtdc, void, env, i32, i32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 86f726849a..b3406f1cbf 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -39,6 +39,8 @@
 # RXv3 DPFPU: GPR/control-register/memory/immediate transfers
 &rdrh		rd drs
 &drhr		drd rs
+&rdcr		rd dcrs
+&dcrr		dcrd rs
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -689,3 +691,8 @@ DMOVD_rdrh	1111 1101 0111 0111 1000 rs:4 drd:4 0011	&drhr
 # DR half -> GPR (0xFD 0x75 prefix): byte3 low nibble is the destination GPR.
 DMOV_drlr	1111 1101 0111 0101 1000 rd:4 drs:4 0000	&rdrh
 DMOV_drhr	1111 1101 0111 0101 1000 rd:4 drs:4 0010	&rdrh
+
+# DPFPU control register transfers
+MVFDC		1111 1101 0111 0101 1000 rd:4 dcrs:4 0100	&rdcr
+MVTDC		1111 1101 0111 0111 1000 rs:4 dcrd:4 0100	&dcrr
+MVFDR		0111 0101 1001 0000 0001 1011
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index cd686d8546..91af7c6685 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -403,6 +403,37 @@ float64 helper_ftod(CPURXState *env, float32 t0)
     return ret;
 }
 
+/*
+ * mvtdc rs, DCRd. Not a plain register write: the DC* cause bits in DPSW
+ * clear on a written 0 and keep their value on a written 1, DFS is a
+ * read-only summary, DCMR holds only RES, and DEPC is read-only.
+ */
+void helper_mvtdc(CPURXState *env, uint32_t reg, uint32_t val)
+{
+    uint32_t old, dpsw;
+
+    switch (reg) {
+    case RX_DCR_DPSW:
+        old = env->dcr[RX_DCR_DPSW];
+        dpsw = val & RX_DPSW_WRITE_MASK;
+        dpsw = (dpsw & ~RX_DPSW_CAUSE_MASK)
+             | (old & val & RX_DPSW_CAUSE_MASK);
+        dpsw = FIELD_DP32(dpsw, DPSW, DFS,
+                          FIELD_EX32(dpsw, DPSW, FLAGS) != 0);
+        env->dcr[RX_DCR_DPSW] = dpsw;
+        break;
+    case RX_DCR_DCMR:
+        env->dcr[RX_DCR_DCMR] = val & RX_DCMR_WRITE_MASK;
+        break;
+    case RX_DCR_DECNT:
+        env->dcr[RX_DCR_DECNT] = val & (R_DECNT_EHM_MASK | R_DECNT_EHS_MASK);
+        break;
+    default:
+        /* DEPC is read-only. */
+        break;
+    }
+}
+
 void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 2c1971b234..ad59fe2861 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2323,6 +2323,44 @@ static bool trans_DMOV_drhr(DisasContext *ctx, arg_DMOV_drhr *a)
     return true;
 }
 
+/* mvfdc DCRs, rd */
+static bool trans_MVFDC(DisasContext *ctx, arg_MVFDC *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_mov_i32(cpu_regs[a->rd], cpu_dcregs[a->dcrs]);
+    return true;
+}
+
+/* mvtdc rs, DCRd -- see helper_mvtdc for the per-register write rules */
+static bool trans_MVTDC(DisasContext *ctx, arg_MVTDC *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_mvtdc(tcg_env, tcg_constant_i32(a->dcrd), cpu_regs[a->rs]);
+    return true;
+}
+
+/*
+ * mvfdr -- Z = DCMR.RES. Moves the result of the last DCMP into the PSW Z
+ * flag so it can be branched on; no other flag and no DPSW bit changes.
+ *
+ * psw_z holds the inverse of the architectural Z flag (Z is set when psw_z
+ * reads zero), so the RES bit is inverted on the way in.
+ */
+static bool trans_MVFDR(DisasContext *ctx, arg_MVFDR *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_extract_i32(cpu_psw_z, cpu_dcregs[RX_DCR_DCMR],
+                        RX_DCMR_RES_BIT, 1);
+    tcg_gen_xori_i32(cpu_psw_z, cpu_psw_z, 1);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


