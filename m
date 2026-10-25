Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7D606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL24f-0001di-7D; Sun, 25 Oct 2026 13:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL240-0000u7-Ir; Sun, 25 Oct 2026 13:31:25 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23y-0007JF-N2; Sun, 25 Oct 2026 13:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ME0nR7Q5soKe/Nx62cq3DkAzzDYEueOhKvNOVI+alFw=; b=GBHHALTS7tWCPIrTNoa7yVI3eq
 n8iBGgiS2spGp6A8bCW2e/9DC8uZyXLq08eY0lm/JWvVqiAUZc3HQjZQsdQkzgwwGdV/bVd/lmTxu
 tCgn/V5cmEaV+wAX5LXT7Y+JQv6IHLewr/0WkXmOhjnvysKIkcZWBHnUzX5lWO1rQSYAvXQSPmOUd
 LpJcF5j2v8QPuvsb/FUJuGFjp38w2U2SXbDSvbQrR0uNJpoqkLlBo+RBPsCEkkF4SPfiqUgonbKsm
 9THUtXpFjFDOVKOIni0PW8m3MwH0lAvYxME2McDksHBH5q3sQBgWa3AYF8A+xhdI0d9y5k73bjbUA
 vHH+1TJg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006ke-1Q; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-28; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:23 +0100
Subject: [PATCH v2 07/31] target/rx: add DPFPU unary operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-7-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=6267;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=KJc1Hs4x/W192wbuy77jtbrPo96MgYnfdGE7xVtfDp0=;
 b=MU8EdZvHoYkckYM8gMtFHl8hXwX0AbjFgSM+O2Vot5AOz7VWedSU86O5glK6+lSjcyy1oB5QU
 ZY8c0KmoQGFD4gYdhUxzmsF6HNoJBUlxG1svrX/Rn5EunPS1c2osDdl
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

Add DMOV, DABS, DNEG, DSQRT and DROUND. DABS and DNEG only flip the
sign bit, so they cannot raise an exception and leave the DC* cause
bits alone; the other three run through dp_begin()/update_dpsw() like
the arithmetic operations.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 30 ++++++++++++++++++++++++++
 target/rx/helper.h     |  4 ++++
 target/rx/insns.decode | 10 +++++++++
 target/rx/op_helper.c  | 35 ++++++++++++++++++++++++++++++
 target/rx/translate.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 98882044be..a3101ac534 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1243,6 +1243,36 @@ static bool trans_DCMP(DisasContext *ctx, arg_DCMP *a)
     return true;
 }
 
+static bool trans_DMOV(DisasContext *ctx, arg_DMOV *a)
+{
+    prt("dmov\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DABS(DisasContext *ctx, arg_DABS *a)
+{
+    prt("dabs\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DNEG(DisasContext *ctx, arg_DNEG *a)
+{
+    prt("dneg\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DSQRT(DisasContext *ctx, arg_DSQRT *a)
+{
+    prt("dsqrt\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DROUND(DisasContext *ctx, arg_DROUND *a)
+{
+    prt("dround\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index e39f4b65ae..60e8d18288 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -19,6 +19,10 @@ DEF_HELPER_3(dsub, f64, env, f64, f64)
 DEF_HELPER_3(dmul, f64, env, f64, f64)
 DEF_HELPER_3(ddiv, f64, env, f64, f64)
 DEF_HELPER_4(dcmp, void, env, i32, f64, f64)
+DEF_HELPER_2(dabs, f64, env, f64)
+DEF_HELPER_2(dneg, f64, env, f64)
+DEF_HELPER_2(dsqrt, f64, env, f64)
+DEF_HELPER_2(dround, f64, env, f64)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index e22536a9e0..a7d66fba67 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -30,6 +30,7 @@
 &mr		rs ld mi rs2
 &mcnd		ld sz rd cd
 # RXv3 DPFPU argument types
+&drr		drd drs
 &drrr		drd drs1 drs2
 &dcmpd		drs1 drs2 cd
 ########
@@ -643,3 +644,12 @@ DSUB		0111 0110 1001 0000 drs2:4 0001 drd:4 drs1:4	&drrr
 DMUL		0111 0110 1001 0000 drs2:4 0010 drd:4 drs1:4	&drrr
 DDIV		0111 0110 1001 0000 drs2:4 0101 drd:4 drs1:4	&drrr
 DCMP		0111 0110 1001 0000 drs2:4 1000 cd:4  drs1:4	&dcmpd
+
+# Unary ops group A (1100): DMOV, DABS, DNEG
+DMOV		0111 0110 1001 0000 drs:4 1100 drd:4 0000	&drr
+DABS		0111 0110 1001 0000 drs:4 1100 drd:4 0001	&drr
+DNEG		0111 0110 1001 0000 drs:4 1100 drd:4 0010	&drr
+
+# Unary ops group B (1101): DSQRT, DROUND
+DSQRT		0111 0110 1001 0000 drs:4 1101 drd:4 0000	&drr
+DROUND		0111 0110 1001 0000 drs:4 1101 drd:4 1101	&drr
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 61277b7581..da2d71fa32 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -307,6 +307,41 @@ void helper_dcmp(CPURXState *env, uint32_t cm, float64 src, float64 src2)
     update_dpsw(env);
 }
 
+/*
+ * DABS and DNEG only change the sign bit. They cannot raise an exception,
+ * and are the two DP arithmetic instructions that leave the DC* cause bits
+ * as they were rather than recomputing them.
+ */
+float64 helper_dabs(CPURXState *env, float64 t0)
+{
+    return float64_abs(t0);
+}
+
+float64 helper_dneg(CPURXState *env, float64 t0)
+{
+    return float64_chs(t0);
+}
+
+float64 helper_dsqrt(CPURXState *env, float64 t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = float64_sqrt(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_dround(CPURXState *env, float64 t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = float64_round_to_int(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
 void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 2eb0b7b39e..9bf70c96c6 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2027,6 +2027,64 @@ static bool trans_DCMP(DisasContext *ctx, arg_DCMP *a)
     return true;
 }
 
+static bool trans_DMOV(DisasContext *ctx, arg_DMOV *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    dr_write(a->drd, s);
+    return true;
+}
+
+static bool trans_DABS(DisasContext *ctx, arg_DABS *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dabs(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DNEG(DisasContext *ctx, arg_DNEG *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dneg(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DSQRT(DisasContext *ctx, arg_DSQRT *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dsqrt(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DROUND(DisasContext *ctx, arg_DROUND *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dround(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


