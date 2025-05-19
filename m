Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AE2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IE-0006uM-Fi; Mon, 19 May 2025 11:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I9-0006s0-4d
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:37 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I6-0005T6-Rh
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:36 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id A4A1E180E8B
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:23 +0200 (CEST)
Received: (qmail 1409 invoked by uid 990); 19 May 2025 15:20:23 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:23 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:45 +0200
Message-ID: <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.998822) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.598822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=5JCAPKLe/6ZLVixYexxl1bNlbmlq04Bh5tEHZjqm5Ms=;
 b=q2F0vpNOVoas/SXNKcp+R+ac2mKmLox5fC2bqTltBjFkgu1Qs4ZZNmDcrmoFNVGyT1iOIUUWev
 uO8ZYHQ5tbnvLVq+0uUdyu2bJBVDrV/Z38oDTMps4Gn+3/eQ5E/vGer0x3JO6fSPP0C2kKJqKOSc
 Nfu4gVUwaKFlJm9IIyUyvBB9FJAUoyPh4Br7rypIgjRVnHCH82PSzBfIRILY3ZuJr+rWVUNPF1ef
 VY1UWjFJmRhTzrW2Cm/ujj52MzBCjESJx15smWQzw+zBYqHu6JcipbvJEJweLXUuiuOE3uSN/I1b
 YDNMRcrQb3m6ANyKUlQ7aA8wFAZaScwQi6BNQ4Awce2nrRMIVJvAd6JkYn9X8GSW0nDs/XCJhcUV
 dHKIrcrjEdCSLX9+EqLjv4tuH9hNYXahWy5Hl5VY5iC/HIXla+hCjPCt4Rv/xSjAYaO5aNPh5ow0
 Tqmjc7W15+oNTGIu8I3NPg9gl+dA8HGEEzCRT2zOwbYjJYPSeX4K2hcA+hIqw73wxAmVqnSXlxXP
 KwyHDicwHBxaj953/Xpw+s/D/l3qJZVgjFjNoTwcFp84J4i/W9w8zduNDoWE63RgSLW8f8oGVRZt
 4oxCYiw6FcjH7x4NxQbVXzmWbXWEtsHvYRR1Pmr8QQH0J5vPksVPGM81hhshvkmiwMnaxO/WPkTE
 M=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.49.0


