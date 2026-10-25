Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD0606A321
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL24K-0000vJ-0h; Sun, 25 Oct 2026 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23P-0000HC-MF; Sun, 25 Oct 2026 13:30:43 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23N-0007Fd-VV; Sun, 25 Oct 2026 13:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=tjlHXAYu6T2OQDLpLXGFNMgX95x51z0dwpgRMAGDPEA=; b=jo5DYIeXo5CtKPqV0wioV7vlOi
 yPoJe6BWfy0p8rTFsqLWJVKTeEVx8XyQOhpPUr696+A6DyyJxU+e6He/5hn2gdt8bKY00wo6vTOiM
 4P8ZeRIBHxEMMtOKTooR8aq90+37feCR3FlAa4VmLak8oGXqGd/r10b70IDAi1wNdtJbicNYSU7//
 Dq5uwOZAWPF6ypegD9qopHKfhnNla8K+Fi9CRZBXhbuTqjvG2X1QYSUL3TU2a9siVv3Ivhxf9fl8P
 oJUe+aH1TYilHW/ubiofImK0sinIWlMzNU1xgKp70LPTl7lMJDFGd84DoZDLYO/h9F2I6ldudQ+0+
 eFn3wiYw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kh-1e; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-2N; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:24 +0100
Subject: [PATCH v2 08/31] target/rx: add DPFPU conversions DTOI, DTOU and DTOF
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-8-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5605;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=U7cqq6UpxZ0wYslg1hQq8NWb0FvvoCV3wrMHW5fbsaU=;
 b=CgtdfY7xrhjw3AEhY4b8+DvKWQmhpbtPCvZe1CH1YGbkLb0vHkidAUYS/p72uW0svaVT0UQyL
 W9nlBrae9a/D4e2ikHAEmeJRUL2WGX6iBGTv42Kp8DsTDlbwzOvAc4m
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

DTOI/DTOU convert a DR operand to signed/unsigned int32 and DTOF
narrows to single precision; all three write the 32-bit result to the
low half of the destination DR register (the high half is cleared)
and record exceptions in DPSW like the other DP arithmetic.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 18 +++++++++++++++++
 target/rx/helper.h     |  3 +++
 target/rx/insns.decode |  5 +++++
 target/rx/op_helper.c  | 31 +++++++++++++++++++++++++++++
 target/rx/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index a3101ac534..82900774ab 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1273,6 +1273,24 @@ static bool trans_DROUND(DisasContext *ctx, arg_DROUND *a)
     return true;
 }
 
+static bool trans_DTOI(DisasContext *ctx, arg_DTOI *a)
+{
+    prt("dtoi\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DTOU(DisasContext *ctx, arg_DTOU *a)
+{
+    prt("dtou\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DTOF(DisasContext *ctx, arg_DTOF *a)
+{
+    prt("dtof\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 60e8d18288..5e7306d86e 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -23,6 +23,9 @@ DEF_HELPER_2(dabs, f64, env, f64)
 DEF_HELPER_2(dneg, f64, env, f64)
 DEF_HELPER_2(dsqrt, f64, env, f64)
 DEF_HELPER_2(dround, f64, env, f64)
+DEF_HELPER_2(dtoi, i32, env, f64)
+DEF_HELPER_2(dtou, i32, env, f64)
+DEF_HELPER_2(dtof, f32, env, f64)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index a7d66fba67..e1121e950d 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -653,3 +653,8 @@ DNEG		0111 0110 1001 0000 drs:4 1100 drd:4 0010	&drr
 # Unary ops group B (1101): DSQRT, DROUND
 DSQRT		0111 0110 1001 0000 drs:4 1101 drd:4 0000	&drr
 DROUND		0111 0110 1001 0000 drs:4 1101 drd:4 1101	&drr
+# DTOI/DTOU/DTOF convert within the DPFPU: the result lands in a DR register
+# and is moved out to a GPR with DMOV.L DRLn, Rd.
+DTOI		0111 0110 1001 0000 drs:4 1101 drd:4 1000	&drr
+DTOU		0111 0110 1001 0000 drs:4 1101 drd:4 1001	&drr
+DTOF		0111 0110 1001 0000 drs:4 1101 drd:4 1100	&drr
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index da2d71fa32..e684a4bfb9 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -342,6 +342,37 @@ float64 helper_dround(CPURXState *env, float64 t0)
     return ret;
 }
 
+uint32_t helper_dtoi(CPURXState *env, float64 t0)
+{
+    uint32_t ret;
+
+    dp_begin(env);
+    ret = float64_to_int32_round_to_zero(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+uint32_t helper_dtou(CPURXState *env, float64 t0)
+{
+    uint32_t ret;
+
+    dp_begin(env);
+    ret = float64_to_uint32_round_to_zero(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+/* dtof narrows to single precision but is a DPFPU instruction: DPSW. */
+float32 helper_dtof(CPURXState *env, float64 t0)
+{
+    float32 ret;
+
+    dp_begin(env);
+    ret = float64_to_float32(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
 void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9bf70c96c6..d524a29d64 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2085,6 +2085,60 @@ static bool trans_DROUND(DisasContext *ctx, arg_DROUND *a)
     return true;
 }
 
+/*
+ * dtoi / dtou / dtof convert within the DPFPU: the 32-bit result is written
+ * to the low half of the destination DR register, from where DMOV.L moves it
+ * out to a GPR. The high half is cleared.
+ */
+static void dr_write_low32(int n, TCGv_i32 val)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, val);
+    tcg_gen_mov_i64(cpu_dregs[n], t);
+}
+
+/* dtoi DRdrs, DRdrd -- convert double to signed int32 */
+static bool trans_DTOI(DisasContext *ctx, arg_DTOI *a)
+{
+    TCGv_i32 res;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    res = tcg_temp_new_i32();
+    gen_helper_dtoi(res, tcg_env, dr_read(a->drs));
+    dr_write_low32(a->drd, res);
+    return true;
+}
+
+/* dtou DRdrs, DRdrd -- convert double to unsigned int32 */
+static bool trans_DTOU(DisasContext *ctx, arg_DTOU *a)
+{
+    TCGv_i32 res;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    res = tcg_temp_new_i32();
+    gen_helper_dtou(res, tcg_env, dr_read(a->drs));
+    dr_write_low32(a->drd, res);
+    return true;
+}
+
+/* dtof DRdrs, DRdrd -- convert double to float32 */
+static bool trans_DTOF(DisasContext *ctx, arg_DTOF *a)
+{
+    TCGv_i32 res;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    res = tcg_temp_new_i32();
+    gen_helper_dtof(res, tcg_env, dr_read(a->drs));
+    dr_write_low32(a->drd, res);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


