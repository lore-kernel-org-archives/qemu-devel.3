Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CA5CA6017
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0w5-0004jL-Aw; Thu, 08 Oct 2026 23:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vV-0004d4-8q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:42 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vP-0005lQ-4K
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:40 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 9A4CDDFE8;
 Fri, 09 Oct 2026 08:35:30 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH v5 01/23] target/loongarch: select sys state by VM level
Date: Fri,  9 Oct 2026 11:04:57 +0800
Message-ID: <6fb81ac152cf0ee2aef79c1efb50a44f26ca1bcc.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Define VM_LEVEL0 and VM_LEVELS for the available VM levels. Replace
set_sys_state(), which accepted a CPUSysState pointer, with set_sys(),
which selects a state by VM level. There is no function change in this
patch.
---
 target/loongarch/cpu.c | 4 ++--
 target/loongarch/cpu.h | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c2699897..6c6e1d81b8 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -298,7 +298,7 @@ static void loongarch_la464_initfn(Object *obj)
     uint32_t data = 0, field;
     int i;
 
-    set_sys_state(env, &env->sys_states[0]);
+    set_sys(env, VM_LEVEL0);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
@@ -428,7 +428,7 @@ static void loongarch_la132_initfn(Object *obj)
     uint32_t data = 0;
     int i;
 
-    set_sys_state(env, &env->sys_states[0]);
+    set_sys(env, VM_LEVEL0);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c592f69885..391445f614 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -321,6 +321,9 @@ typedef struct CPUTimerState {
     CPUState *cs;
 } CPUTimerState;
 
+#define VM_LEVEL0   0
+#define VM_LEVELS   1
+
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
 #define CPU_MODEL_1C101       "1C101"
@@ -507,9 +510,9 @@ static inline CPUSysState *env_sys(CPULoongArchState *env)
     return env->sys_state;
 }
 
-static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
+static inline void set_sys(CPULoongArchState *env, int vm_level)
 {
-    env->sys_state = sys;
+    env->sys_state = &env->sys_states[vm_level];
 }
 
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
-- 
2.55.0


