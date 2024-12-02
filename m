Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9DE69E86
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC53-0005kt-Fp; Mon, 02 Dec 2024 14:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4s-0005iv-Dd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:26 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4q-0001x9-8x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:26 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id BDCEC180BF1
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:13 +0100 (CET)
Received: (qmail 7167 invoked by uid 990); 2 Dec 2024 19:27:13 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:13 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v3 05/11] target/alpha: call plugin trap callbacks
Date: Mon,  2 Dec 2024 20:26:46 +0100
Message-ID: <ac63748891b7bd24b8ccec1d0cfb54986eaf8b3d.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999029) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=tpIDjpcFqj+Wp3kuZs4WF3UD19WsYadFBbweXL6VAzk=;
 b=S/nzySFcp1lYl3EoIp6r5nNpEiGidmumBxgHqHVyKEGQyzdZbEFxe24yZjNHzgTQlyyK5WW08d
 KO8JM6mnZAp2DCyzuXlbi0Yv0lg/vmMtid4mcqCQwlybS+5RE3PKf1o2mTlS8zuynqg80JuxNf5F
 qLL2KJzBCohtsJaoAsu1eQLyYurfu76d05LHDLcAQ1+p0laQJWR5q7ZxhdQCVrWkOYKb0zaf7vqd
 d/lDGFqVmkNZxzKDgzjFBeTybetfuJy1z9C8WkHDivjv94sXXnVdTpMEbQBkdc7XUYG1mE1XJ7Ps
 /VaZiH4yxuUZKJytHCkV+u8s/qVjpeLIZonrf30I0lrx2qvfF9iWuK4LgGAoNbj4fkSmleYhYSqk
 /vfbdQrQEzndveMQHRP/gLCirM7kR704Yhp9VN5GfurPy7B02cioE5k9w9wdbU5GHdyVmNIop2r2
 A1jctISQuKHL4Dt0Hy5TierOCCBu6iCWDBNoWHsXlkf5NU0fYvTfAOmde5qslb4UhYF3/5C/de/e
 m4huXTe0EcV8JKmv7d4PHATzTEl4/oFnf/rsB+yBxX3zPr0WolPdhFW+1c23ZXa6cjxSc4nV2yTT
 jI54DsRhU41JzkNGdiQix+8E2dCfy673SwwY/d646gH4VdsU2wfwLd2gYxVs/Saf2guR9e0gCBqb
 w=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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
---
 target/alpha/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f1000c99f..acc92402af 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -25,6 +25,7 @@
 #include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
+#include "qemu/plugin.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
@@ -326,6 +327,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
@@ -429,6 +431,16 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     /* Switch to PALmode.  */
     env->flags |= ENV_FLAG_PAL_MODE;
+
+    switch (i) {
+    case EXCP_SMP_INTERRUPT:
+    case EXCP_CLK_INTERRUPT:
+    case EXCP_DEV_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc, env->pc);
+        break;
+        qemu_plugin_vcpu_exception_cb(cs, last_pc, env->pc);
+    default:
+    }
 }
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.45.2


