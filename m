Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E982ECCA472
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5i0Z-0001eV-R5; Mon, 06 Oct 2025 05:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0P-0001TY-4i
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:45 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0N-000410-G8
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:44 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id F1EF760B87
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:59:41 +0200 (CEST)
Received: (qmail 20981 invoked by uid 990); 6 Oct 2025 09:59:41 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:59:39 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 21/25] target/tricore: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:59:16 +0200
Message-ID: <a982656014bcb3470da9efb8dadedb6cc2160a8c.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.988061) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.588061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=sikDKxVdoH/tFrpwzH0GPVt3AT9j5FuE97/PA4t+p6A=;
 b=Xj/Sks4SS5JapuY7jKvgDjjQAryqr5IYrHI+Ps3mgX6WYaTrGqld/pwI6Zk+j/JpQlzvbMViEF
 ZcDftLHxWMP1Xdf+xMue0LhkymgmQpzprIF4OrBY6YRPCvL2DFuofvhsf3cnnXG0kYbIlEmgoUWT
 DOEIJ+FiYEmHN7E558dhw11CF5HmV5GRcAn0lB7CRK5E0sEOgFKrn9XEatcRjkQZ9regYCNVXeks
 IWUFVbBu1pN8ENUQDM0E2W9b0uq+dPRYjBPRzfXBUkoSgJcadiBoTeH8V/mkYkwmUmsJZ9M1ufT5
 id9iuZjM/4J69V7POtj9UrzBeS3L/6e5WiEScJ9pbaHslHDhMhSe+aMaq+2dpPJ4x2ugqlaqz3HZ
 DYQwAR8/dph2epR2h1ywvVQtXH8AjqGdOWOBVNRGhImnsz9m/P0T55zhMSH0LRAqN7MfuBPmbxxd
 ikUgE2/wXV3oVcvD8ojUPaotMpd+jiPz7QRHCPSsKIuWorTOlLudhToa4T/ipiF58bkcrvPLF/BP
 9xyGyy2aV9uY3N9D9SZzR+esdin/qnoiB2Z8dWpbjAzDmM4AWEEDnVIE4Z4Q4aLQEuBJ7w9Ia77O
 4TCWr10UVaBgV9RbcIEmIZBdFltNZAxrfTU/0J0gnoj5JZ/1BnrE5I8aSmnANYM+0bDIzf0vOwKT
 0=
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
2.49.1


