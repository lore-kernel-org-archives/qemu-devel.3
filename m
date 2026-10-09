Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB677CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0x1-0005pY-6u; Thu, 08 Oct 2026 23:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vf-0004ek-Ak
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:00 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0va-0005m1-Jw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:49 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 7E109E003;
 Fri, 09 Oct 2026 08:35:44 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 12/23] target/loongarch: add gid management functions
Date: Fri,  9 Oct 2026 11:05:08 +0800
Message-ID: <250dacc824c93affe3062fc8c232ec1afcd7e6e2.1791514848.git.prcups@krgm.moe>
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

Add get_gid(), get_tgid() and tlb_entry_matches_gid(), to get and use gid in
lvz functions.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h            | 21 +++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 3e3ae2bfa7..a42c5fe170 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -583,6 +583,27 @@ static inline bool will_return_to_guest(CPULoongArchState *env)
     return FIELD_EX64(get_sys(env, VM_LEVEL0)->CSR_GSTAT, CSR_GSTAT, PVM);
 }
 
+static inline uint8_t get_gid(CPULoongArchState *env)
+{
+    return FIELD_EX64(get_sys(env, VM_LEVEL0)->CSR_GSTAT, CSR_GSTAT, GID);
+}
+
+static inline uint8_t get_tgid(CPULoongArchState *env)
+{
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+
+    if (env_vm_level(env) == VM_LEVEL1) {
+        return get_gid(env);
+    }
+
+    if (FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID)) {
+        return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);
+    } else if (will_return_to_guest(env)) {
+        return get_gid(env);
+    }
+    return 0;
+}
+
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
 {
     return &env->sys_states[0].timer_state;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index d1f1d233fd..821aa26328 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -35,6 +35,11 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
     return !global && tlb_asid == asid;
 }
 
+static inline bool tlb_entry_matches_gid(const LoongArchTLB *tlb, uint8_t gid)
+{
+    return FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID) == gid;
+}
+
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
     CPUSysState *sys = env_sys(env);
-- 
2.55.0


