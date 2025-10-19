Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D1CCD19F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAVBc-00089G-1l; Sun, 19 Oct 2025 11:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAVBZ-0007uN-V9
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:19:06 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAVBW-0003TZ-Nn
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:19:05 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 2B72A60AB3
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:19:01 +0200 (CEST)
Received: (qmail 25988 invoked by uid 990); 19 Oct 2025 15:19:01 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:18:56 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8 21/25] target/tricore: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:18:40 +0200
Message-ID: <430884d68ff519df486959d78cfceed860400a08.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999616) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=T0TAjJK7IefmZyG4PU/2dpjSPNBiWLvd8mA6hXvwDOo=;
 b=Kvr1KW6WLjZNUoo6DZpVUD7iC5bs8JPowFuMrLsvx6B+/TXR/6E0/pGh7993sjspSJ1StiJAPa
 bte/RmV438vvgQtlinpq3F7hlU1uhWtqTScIKyq1JHTBBv7two9uZKNNHeAUUeMwG61rsIk8vB3K
 PccZHrcpM3NEK2wXvcvCWYLlv3ESTQFBeDjgLRLPJgIFrkSEXQjOwtIgxzvQCdh/UQUo4yWZOTZU
 cM+oO4ealp7Nt9Ix9vU3DKmKp81ijj7rjiPtWjrqGMuS6Zo+lwtvGr+IHNZQho0hObu6J1A4fazY
 ZnSRud6B4tzpCj+kzOywjrNlBQ4lEORCcnE951KqpRtv/pNlbL0ugxsy2ONfV98D9avamvZuNX33
 2d41J/d0Y1l58JBN5SZZmdLOZAIxjfqEiS2KwUfauz/ryPuKgJ6sjb/vt5KFvToUe7C2ZE3phr/o
 9TJBA8HzHIjbxWdxL6p55tjtfuzoZDvllJOvBinr1b90AZ+8JdhM8EcyTPklaCxmqcKhZlHCzrbx
 J7Rh4NybNJUk4w0lW4Oc0QMtX/QwmTKcXqHXgOGW4bztZkHPKAFlHOkFk1Siu4qbd9QM4hF2qCAj
 +NkIX9tlAkcPxoCg8TGxaQnuhRE/VZ7fVTwRDATEkh3qgQOu4Po/dzZP7SNy2CmtZHGtIPuIF6MQ
 4=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

This change places an exception hook for TriCore targets. Interrupts are
not implemented for this target and it has no host calls.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/tricore/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 610f148a23..2c8281a67e 100644
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
2.49.1


