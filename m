Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8C606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 16:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1WI-0001C3-EU; Sun, 25 Oct 2026 12:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WD-0001Ar-WD; Sun, 25 Oct 2026 12:56:26 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WA-0004bw-Ug; Sun, 25 Oct 2026 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VC/ZqU0P7QaDV+f4WGQC89seHsV5Y73LujJVq8k+ZA0=; b=Zx4MS/4Sdr/w8f2e/KIeX/eIOi
 QJbp5+tjGQpMFPWqPdHdsgmhDp33p9vSlfwf3gTCi3MakWOwDJGSxJERpXLmrR801HP1jyGsxizp8
 6DMFF2/BaGbKysfvI6bzM6crUDs7wqdS1rrl76xbZV8iYJRBF1/93sfE2cJydmoBAQ2dPJZ+CZeaE
 0uQLjO5BfWFsOYCdpxjgTAL1qyy5N3QmXm/DD1kyxi0fgILmm7ilW5BE9rBqev1h6lkCOis78pWrO
 ishB1/rtn7rQd0xIp81UZdddubf1q2Zj9LZb/ReJLvRpSogZCl2RuUshpZLyxqrtkHzDsszdE6NO7
 X6fCskJQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kW-10; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-1h; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:21 +0100
Subject: [PATCH v2 05/31] target/rx: add FTOU and UTOF (RXv2)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-5-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=6460;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=hVDLImuFx2svL6CVfUl4Utv0uEgJoAVX6aSMcV6pXH0=;
 b=pjaUOKQnk90G7W+29grifu3e1CmVvDJEEzhkbGje+K67cGbTDv3pfZzhyO3A2E08tiDCd5V9L
 hS4XMHV4qxbCnGOvCYfbf0Gk1BXSF2sD28ezDovIBKG2VTLaUWC2nW8
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

RXv2 adds the unsigned float conversions FTOU (float to unsigned) and
UTOF (unsigned to float), in register and memory operand forms, and
the unsigned conversion helpers they need. Gate them behind RX_ISA_V2
using require_isa().

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 15 +++++++++++++++
 target/rx/helper.h     |  2 ++
 target/rx/insns.decode |  9 +++++++++
 target/rx/op_helper.c  | 16 ++++++++++++++++
 target/rx/translate.c  | 34 +++++++++++++++++++++++++++++++---
 5 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 0eb2ee6f45..34cfe6f0ec 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1148,6 +1148,14 @@ static bool trans_FTOI(DisasContext *ctx, arg_FTOI *a)
     return true;
 }
 
+/* ftou dsp[rs], rd */
+/* ftou rs, rd */
+static bool trans_FTOU(DisasContext *ctx, arg_FTOU *a)
+{
+    prt_ldmi(ctx, "ftou", a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
 /* fmul #imm, rd */
 static bool trans_FMUL_ir(DisasContext *ctx, arg_FMUL_ir *a)
 {
@@ -1194,6 +1202,13 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
     return true;
 }
 
+/* utof dsp[rs], rd */
+static bool trans_UTOF(DisasContext *ctx, arg_UTOF *a)
+{
+    prt_ldmi(ctx, "utof", a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 13f019ff81..63cfe48e6b 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -9,8 +9,10 @@ DEF_HELPER_3(rx_fmul, f32, env, f32, f32)
 DEF_HELPER_3(rx_fdiv, f32, env, f32, f32)
 DEF_HELPER_3(rx_fcmp, void, env, f32, f32)
 DEF_HELPER_2(ftoi, i32, env, f32)
+DEF_HELPER_2(ftou, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
+DEF_HELPER_2(utof, f32, env, i32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index ca9334b37a..e9ace9624c 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -285,6 +285,10 @@ FSUB_mr		1111 1100 1000 00.. .... ....		@b3_rd_ld_ul
 # FTOI dsp[rs], rd
 FTOI		1111 1100 1001 01.. .... ....		@b3_rd_ld_ul
 
+# FTOU rs, rd  (RXv2)
+# FTOU dsp[rs], rd  (RXv2)
+FTOU		1111 1100 1010 01.. .... ....		@b3_rd_ld_ul
+
 # INT #uimm8
 INT		0111 0101 0110 0000 imm:8
 
@@ -294,6 +298,11 @@ ITOF		1111 1100 0100 01.. .... ....		@b3_rd_ld_ub
 # ITOF dsp[rs], rd
 ITOF		0000 0110 ..10 00.. 0001 0001 .... ....	@b4_rd_ldmi
 
+# UTOF rs, rd  (RXv2)
+UTOF		1111 1100 0101 01.. .... ....		@b3_rd_ld_ub
+# UTOF dsp[rs], rd  (RXv2)
+UTOF		0000 0110 ..10 00.. 0001 0101 .... ....	@b4_rd_ldmi
+
 # JMP rs
 JMP		0111 1111 0000 rs:4			&jreg
 # JSR rs
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 06841088ac..114cc235f3 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -180,6 +180,14 @@ uint32_t helper_ftoi(CPURXState *env, float32 t0)
     return ret;
 }
 
+uint32_t helper_ftou(CPURXState *env, float32 t0)
+{
+    uint32_t ret;
+    ret = float32_to_uint32_round_to_zero(t0, &env->fp_status);
+    update_fpsw(env, ret, GETPC());
+    return ret;
+}
+
 uint32_t helper_round(CPURXState *env, float32 t0)
 {
     uint32_t ret;
@@ -196,6 +204,14 @@ float32 helper_itof(CPURXState *env, uint32_t t0)
     return ret;
 }
 
+float32 helper_utof(CPURXState *env, uint32_t t0)
+{
+    float32 ret;
+    ret = uint32_to_float32(t0, &env->fp_status);
+    update_fpsw(env, ret, GETPC());
+    return ret;
+}
+
 /* string operations */
 void helper_scmpu(CPURXState *env)
 {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index b4e105fb8b..43fd88b15d 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -40,6 +40,17 @@ typedef struct DisasContext {
     RXISAVersion isa_version;
 } DisasContext;
 
+/*
+ * Instructions introduced after RXv1 are only valid on CPU models that
+ * implement the corresponding revision. Returning false from a trans_
+ * handler makes decode() fail, which raises an illegal instruction
+ * exception exactly as an unknown encoding would.
+ */
+static bool require_isa(DisasContext *ctx, RXISAVersion version)
+{
+    return ctx->isa_version >= version;
+}
+
 typedef struct DisasCompare {
     TCGv_i32 value;
     TCGv_i32 temp;
@@ -1873,10 +1884,13 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
         return true;                                                    \
     }
 
-#define FCONVOP(name, op)                                       \
+#define FCONVOP(name, op, isa)                                  \
     static bool trans_##name(DisasContext *ctx, arg_##name * a) \
     {                                                           \
         TCGv_i32 val, mem;                                      \
+        if (!require_isa(ctx, isa)) {                           \
+            return false;                                       \
+        }                                                       \
         mem = tcg_temp_new_i32();                               \
         val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);    \
         gen_helper_##op(cpu_regs[a->rd], tcg_env, val);         \
@@ -1907,8 +1921,9 @@ static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
     return true;
 }
 
-FCONVOP(FTOI, ftoi)
-FCONVOP(ROUND, round)
+FCONVOP(FTOI, ftoi, RX_ISA_V1)
+FCONVOP(FTOU, ftou, RX_ISA_V2)
+FCONVOP(ROUND, round, RX_ISA_V1)
 
 /* itof rs, rd */
 /* itof dsp[rs], rd */
@@ -1921,6 +1936,19 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
     return true;
 }
 
+/* utof dsp[rs], rd  (RXv2) */
+static bool trans_UTOF(DisasContext *ctx, arg_UTOF * a)
+{
+    TCGv_i32 val, mem;
+    if (!require_isa(ctx, RX_ISA_V2)) {
+        return false;
+    }
+    mem = tcg_temp_new_i32();
+    val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
+    gen_helper_utof(cpu_regs[a->rd], tcg_env, val);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


