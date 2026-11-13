Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65D606B37F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvZ-0002w8-LS; Fri, 13 Nov 2026 03:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvW-0002tz-EH
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:30 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvU-0007Qv-Vq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:30 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 46FDC82B;
 Fri, 13 Nov 2026 14:16:27 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 12/26] target/loongarch: add gid management functions
Date: Fri, 13 Nov 2026 16:45:27 +0800
Message-ID: <514c14ec77abae79449ede7b26bb32e9a9ade4e0.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
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

Add get_gid(), get_tgid() and tlb_entry_matches_gid(), to get and use gid in
lvz functions.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h            | 13 +++++++++++++
 target/loongarch/tcg/tlb_helper.c |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 42305e4b05..9987d47734 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -588,6 +588,19 @@ static inline bool will_return_to_guest(CPULoongArchState *env)
     return FIELD_EX64(get_sys(env, VM_LEVEL0)->CSR_GSTAT, CSR_GSTAT, PVM);
 }
 
+static inline uint8_t get_gid(CPULoongArchState *env, int vm_level)
+{
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+
+    if (vm_level) {
+        return FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID);
+    }
+    if (FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID)) {
+        return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);
+    }
+    return 0;
+}
+
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
 {
     return &env->sys_states[0].timer_state;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 33d5e04eb4..178f55a67e 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -34,6 +34,11 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
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
2.56.0


