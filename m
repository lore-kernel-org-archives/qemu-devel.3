Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6EDCA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGry-0003T5-Jt; Thu, 04 Sep 2025 16:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrv-0003Rg-JT
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:43 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrr-0000iS-P1
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:43 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id C214160BFC
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:20 +0200 (CEST)
Received: (qmail 32578 invoked by uid 990); 4 Sep 2025 20:47:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:20 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 05/25] target/alpha: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:42 +0200
Message-ID: <f70dfda88f5061e70a8f727031844918d30896ac.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.997587) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.597587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=NQdS6b7lSZHjuzHV/xnNiUQELPfMS5Qhlg2RCswDKUA=;
 b=wG0b7mo26FlJpnGblmTXt3v1+9IeMzN6KgMeBONME1fuzYCV5vNGVmowG/4Ae625Pep4afThtm
 2ipIGiweGr4ah7VJZUxQtCBBolm5rj370DAy9dbsnP2HhlMWGkxedNJEV9BR2EXx7Ac+2mJkArWi
 tBF9bABwDWirp2Ys1W7zrGAt8FcHFEdbYR8hjlpZj4tnCq9na+kFZ4V4ThyOgKcjOk21XS7VP7yY
 8OaEOl3ldivfUwXBjBOpIGdfZbvOmCylKToC5bfGe91hh6Z3UPLx8fmE5bsFmA1rdzDttyejJ5Fw
 lHNYoFsSeLrjurSYkSQUSQoYR4cLhrN2o0Qr6k611XhmRc5/e91QvvlxkN2E2QXFS6DH9pfw+uQf
 TplenyKZ0JKqHblgzCrfcwd0VjycxhXT0yIHa48Df/JbVB/bGdeKOBp6kfRWWYysR8rMVCXO8E7u
 KYPwUFUCd90BsHzTu8SJ3P1Cuk0xtSl0WyssVhWgxFzXetAjpVaBvbjt9QQOPJ+QGJSBrT5aMCpK
 82GmGA5kcqZk1JzQdJiJs2fXzAWxXH8hRPFp0dWU8I92xiRmKtYuGfrqzFgE3Sb1o7E/9X0WShyM
 MiCmkG0bAHlTGsGbbJx3Y6K1ITgZPs0GIIZXkdhcXFP2dPFxUvh3sccexWGZwp7q6d2vUWDJ/xyn
 0=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Alpha targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/alpha/helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 096eac3445..a9af52a928 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "qemu/plugin.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
@@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
@@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     /* Switch to PALmode.  */
     env->flags |= ENV_FLAG_PAL_MODE;
+
+    switch (i) {
+    case EXCP_SMP_INTERRUPT:
+    case EXCP_CLK_INTERRUPT:
+    case EXCP_DEV_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
 }
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.49.1


