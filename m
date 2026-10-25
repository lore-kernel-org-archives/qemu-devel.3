Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51D606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL24S-0001Ea-EO; Sun, 25 Oct 2026 13:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23t-0000oP-Dz; Sun, 25 Oct 2026 13:31:15 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL23r-0007IS-FF; Sun, 25 Oct 2026 13:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kq4S0CHEh4mR5sHe7MvzD0z+QBUr1Ccb1XT0I1isRM0=; b=YLTKJrqbKjgZTsvY4UUCB3f/Xn
 +xfTP7BqiqIujhUsqcOpE/CweENYnJO+uHXIlFFDJP9+xuN2iiZxnB1Q/kU6eopRUbELYGkK9Jd/Z
 ZOdJpb67ACBKONljn3Jwri33mK2+fCYWsRKDL/zttI9KtLuAbsfoN2os/Tgs6WQOpU4Dg5mUehiUG
 ngV6CU5VB2SL+jeJwYcCxmCebljsMLz+uBxxCzTLq2FFV+D5VAlXkXX0Bw+hju4qvj/vvhlgwKRVD
 vQFlef4xsYQSAXQxv8fTbGEKono8hCNAkOLZrNt8xPnOLsZiZKdYmuD/4KCD31KBic6FYrXB2r9IQ
 CgoEoSJg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kj-1u; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-2b; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:25 +0100
Subject: [PATCH v2 09/31] target/rx: add DPFPU conversions ITOD, UTOD and FTOD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-9-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=5103;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=t1cH/7XKN5UXePdp0hwM0v6QjHKBYUidKT1ocpMSz9s=;
 b=2hV5WeRieGtwGl3iadsfIvqYlJFLOJ/HnoeFq71J1Sv28TQKZ0l96zvsNEJ/ePuGUsEpIJs3t
 DKqkmcIDqDkBhzuLhTONYRHLEwfsZTFCxPp1lEzOw14xn2Igd57fzby
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

ITOD and UTOD convert signed/unsigned int32 to double, and FTOD
widens single to double precision, into a DR register. Like the other
DP arithmetic they run on dp_status and record exceptions in DPSW.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 18 ++++++++++++++++++
 target/rx/helper.h     |  3 +++
 target/rx/insns.decode |  7 +++++++
 target/rx/op_helper.c  | 30 ++++++++++++++++++++++++++++++
 target/rx/translate.c  | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 82900774ab..85de0a0f09 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1291,6 +1291,24 @@ static bool trans_DTOF(DisasContext *ctx, arg_DTOF *a)
     return true;
 }
 
+static bool trans_ITOD(DisasContext *ctx, arg_ITOD *a)
+{
+    prt("itod\tr%d, dr%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_UTOD(DisasContext *ctx, arg_UTOD *a)
+{
+    prt("utod\tr%d, dr%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_FTOD(DisasContext *ctx, arg_FTOD *a)
+{
+    prt("ftod\tr%d, dr%d", a->rs, a->drd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 5e7306d86e..5bf0ed0aa2 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -26,6 +26,9 @@ DEF_HELPER_2(dround, f64, env, f64)
 DEF_HELPER_2(dtoi, i32, env, f64)
 DEF_HELPER_2(dtou, i32, env, f64)
 DEF_HELPER_2(dtof, f32, env, f64)
+DEF_HELPER_2(itod, f64, env, i32)
+DEF_HELPER_2(utod, f64, env, i32)
+DEF_HELPER_2(ftod, f64, env, f32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index e1121e950d..58f8aa6dfd 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -33,6 +33,7 @@
 &drr		drd drs
 &drrr		drd drs1 drs2
 &dcmpd		drs1 drs2 cd
+&idr		rs drd
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -658,3 +659,9 @@ DROUND		0111 0110 1001 0000 drs:4 1101 drd:4 1101	&drr
 DTOI		0111 0110 1001 0000 drs:4 1101 drd:4 1000	&drr
 DTOU		0111 0110 1001 0000 drs:4 1101 drd:4 1001	&drr
 DTOF		0111 0110 1001 0000 drs:4 1101 drd:4 1100	&drr
+
+# GPR/float-to-DR conversions using 0xFD 0x77 prefix
+# Note: 0xFD 0x77 with byte2 in 0x00-0x0F is MVTC_i (li=01); no conflict with 0x8x
+ITOD		1111 1101 0111 0111 1000 rs:4 drd:4 1001	&idr
+FTOD		1111 1101 0111 0111 1000 rs:4 drd:4 1010	&idr
+UTOD		1111 1101 0111 0111 1000 rs:4 drd:4 1101	&idr
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index e684a4bfb9..cd686d8546 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -373,6 +373,36 @@ float32 helper_dtof(CPURXState *env, float64 t0)
     return ret;
 }
 
+float64 helper_itod(CPURXState *env, uint32_t t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = int32_to_float64((int32_t)t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_utod(CPURXState *env, uint32_t t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = uint32_to_float64(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_ftod(CPURXState *env, float32 t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = float32_to_float64(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
 void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index d524a29d64..0bef8f36f8 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2139,6 +2139,42 @@ static bool trans_DTOF(DisasContext *ctx, arg_DTOF *a)
     return true;
 }
 
+/* itod rs, DRdrd -- convert signed int32 to double */
+static bool trans_ITOD(DisasContext *ctx, arg_ITOD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_itod(d, tcg_env, cpu_regs[a->rs]);
+    dr_write(a->drd, d);
+    return true;
+}
+
+/* utod rs, DRdrd -- convert unsigned int32 to double */
+static bool trans_UTOD(DisasContext *ctx, arg_UTOD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_utod(d, tcg_env, cpu_regs[a->rs]);
+    dr_write(a->drd, d);
+    return true;
+}
+
+/* ftod rs, DRdrd -- convert float32 to double */
+static bool trans_FTOD(DisasContext *ctx, arg_FTOD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_ftod(d, tcg_env, cpu_regs[a->rs]);
+    dr_write(a->drd, d);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


