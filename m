Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C52C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2Ie-00076M-9M; Mon, 19 May 2025 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IQ-0006zl-9y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:54 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IN-0005VS-5M
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:53 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 47194180EA6
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:28 +0200 (CEST)
Received: (qmail 1656 invoked by uid 990); 19 May 2025 15:20:28 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:28 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v5 21/25] target/tricore: call plugin trap callbacks
Date: Mon, 19 May 2025 17:20:01 +0200
Message-ID: <8bd3931ba67e8beb420cb198e2eb16b7b1270084.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99107) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=YXMZB8MgiqIetDkdLVgfF/7lrJrc0D6JsYkbzthKZd4=;
 b=QhayD4sfEx0RJmDvE8AzmfQiD1m8pNR2wj2f+xXGwmzP/0NBJcgz3wjap+9ceUKXY80hU0orI7
 8aGngnPLH4pX5u5LjkIm59RlCtvb/e3ULqExdwWT0kBwz//WzY41XOSEi5mQ6ZkVgGEMq+Yeg1fI
 71ugoPU13VzkKnc0thGvIvMFPBLej1snFbjwHHxXTASpa0cXS4C+njmyAWfsQinu92r5QiuttBFx
 R7vCcSXR5LguqOFLYfIGqPMilrSlUHyZfTdyQY96p8u/Hq5xCg0mWNbqSBbns99bdkmbRXNlb6lD
 mY1wd2RULIU+MvgnpQFP7UIHaykXGMKAzejsOuwnOMa+W03XWX9WoPJY+p1XSBIDnr+B/T/P+cd4
 1g7NR6T9vLaUuw61TGEcHmxovLRXxcFOsRo3b9LcrWTlnbyy28d6UQM385R00UOOUDAVe18G6cHx
 86DxRynwb6rMIcXks0vvJUqep1+wg+a5gZPR4ey6FrSTwt+d9S6OmPHe8niMhRZuLXxcp84hRcF5
 /LZCy9BAqthezP4y3q6Uq5S/b5F/UHALdeCj7bYtVCvtNmJ+JxvLJc+J+EN7nLpQKQS+I7P+rUD2
 wyJT8cWzb3UV8yPicRozVA33DsQxxOhEgjB1ZcmzzVSVIdh6KiEaG4uRiD1+hGYXGHRltH9hQZxG
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

This change places an exception hook for TriCore targets. Interrupts are
not implemented for this target and it has no host calls.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/tricore/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 9910c13f4b..9bd6ce55d1 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "qemu/plugin.h"
 #include <zlib.h> /* for crc32 */
 
 
@@ -29,8 +30,11 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
                                    uintptr_t pc, uint32_t fcd_pc)
 {
     CPUState *cs = env_cpu(env);
+    uint64_t last_pc;
+
     /* in case we come from a helper-call we need to restore the PC */
     cpu_restore_state(cs, pc);
+    last_pc = env->PC;
 
     /* Tin is loaded into d[15] */
     env->gpr_d[15] = tin;
@@ -90,6 +94,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     /* Update PC using the trap vector table */
     env->PC = env->BTV | (class << 5);
 
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit(cs);
 }
 
-- 
2.49.0


