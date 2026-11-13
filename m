Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79C606A8AB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvU-0002t4-I2; Fri, 13 Nov 2026 03:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvT-0002sG-2j
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:27 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvR-0007Rg-F0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:26 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 56849850;
 Fri, 13 Nov 2026 14:16:23 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 09/26] target/loongarch: handle return to guest in ertn
Date: Fri, 13 Nov 2026 16:45:24 +0800
Message-ID: <dedfe51ae262ec81ab7b04a2ac5e5671f179b049.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add will_return_to_guest() function, and handle process of return to guest at
end of helper_ertn().

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h           |  8 ++++++++
 target/loongarch/tcg/op_helper.c | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c1a59882f7..3c21b7633e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -578,6 +578,14 @@ static inline void trigger_vm_exit(CPULoongArchState *env)
     env->vm_exit = true;
 }
 
+static inline bool will_return_to_guest(CPULoongArchState *env)
+{
+    if (!cpu_has_lvz(env) || env_vm_level(env) == VM_LEVEL1) {
+        return false;
+    }
+    return FIELD_EX64(get_sys(env, VM_LEVEL0)->CSR_GSTAT, CSR_GSTAT, PVM);
+}
+
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
 {
     return &env->sys_states[0].timer_state;
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f8a91bed5d..7b77ac49a6 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -12,6 +12,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "internals.h"
+#include "qemu/main-loop.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 #include "cpu-csr.h"
@@ -110,6 +111,8 @@ void HELPER(ertn)(CPULoongArchState *env)
 {
     uint64_t csr_pplv, csr_pie;
     CPUSysState *sys = env_sys(env);
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+    CPUSysState *guest = get_sys(env, VM_LEVEL1);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_pplv = FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
@@ -133,6 +136,17 @@ void HELPER(ertn)(CPULoongArchState *env)
     sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, csr_pie);
 
     env->lladdr = 1;
+    if (will_return_to_guest(env)) {
+        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 1);
+        set_sys(env, VM_LEVEL1);
+        bql_lock();
+        if (FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS)) {
+            cpu_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
+        } else {
+            cpu_reset_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
+        }
+        bql_unlock();
+    }
 }
 
 void HELPER(idle)(CPULoongArchState *env)
-- 
2.56.0


