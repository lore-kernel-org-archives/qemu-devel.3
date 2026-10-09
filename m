Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E447CA6017
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wg-0005Iy-Aa; Thu, 08 Oct 2026 23:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vY-0004dn-UA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:44 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vW-0005m7-7k
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:43 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id B888DE002;
 Fri, 09 Oct 2026 08:35:40 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 09/23] target/loongarch: handle return to guest in ertn
Date: Fri,  9 Oct 2026 11:05:05 +0800
Message-ID: <f2982a8b0d887feb316e0969326de19634336aa4.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add will_return_to_guest() function, and handle process of return to guest at
end of helper_ertn().

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h           |  8 ++++++++
 target/loongarch/tcg/op_helper.c | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ba28d80272..891eea47bd 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -573,6 +573,14 @@ static inline void trigger_vm_exit(CPULoongArchState *env)
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
index f98fe4d4a1..3035dfa08d 100644
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
@@ -90,6 +91,8 @@ void helper_ertn(CPULoongArchState *env)
 {
     uint64_t csr_pplv, csr_pie;
     CPUSysState *sys = env_sys(env);
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+    CPUSysState *guest = get_sys(env, VM_LEVEL1);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_pplv = FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
@@ -113,6 +116,17 @@ void helper_ertn(CPULoongArchState *env)
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
 
 void helper_idle(CPULoongArchState *env)
-- 
2.55.0


