Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176F606A33A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmw0-0003Ac-4e; Fri, 13 Nov 2026 03:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvg-0002zo-BA
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:40 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmve-0007QN-FJ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:40 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id EA7F882B;
 Fri, 13 Nov 2026 14:16:36 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 19/26] target/loongarch: add LVZ migration state
Date: Fri, 13 Nov 2026 16:45:34 +0800
Message-ID: <97749e38af511e28277e784125b2b159a8e50320.1794558695.git.prcups@krgm.moe>
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

Migrate the host LVZ controls, guest CSR and TLB banks, and restore the
active VM level, guest timer and interrupt request after loading state.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/machine.c | 139 +++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4acab2a4a3..10dfdbd202 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
 #include "vec.h"
@@ -175,11 +176,145 @@ static const VMStateDescription vmstate_pmu = {
     },
 };
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+static bool tlb_needed(void *opaque)
+{
+    return tcg_enabled();
+}
+
+/* TLB state */
+static const VMStateDescription vmstate_tlb_entry = {
+    .name = "cpu/tlb_entry",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
+        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
+        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_tlb = {
+    .name = "cpu/tlb",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = tlb_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
+                             0, vmstate_tlb_entry, LoongArchTLB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_lvz_sys = {
+    .name = "cpu/lvz-sys",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(CSR_CRMD, CPUSysState),
+        VMSTATE_UINT64(CSR_PRMD, CPUSysState),
+        VMSTATE_UINT64(CSR_EUEN, CPUSysState),
+        VMSTATE_UINT64(CSR_MISC, CPUSysState),
+        VMSTATE_UINT64(CSR_ECFG, CPUSysState),
+        VMSTATE_UINT64(CSR_ESTAT, CPUSysState),
+        VMSTATE_UINT64(CSR_ERA, CPUSysState),
+        VMSTATE_UINT64(CSR_BADV, CPUSysState),
+        VMSTATE_UINT64(CSR_BADI, CPUSysState),
+        VMSTATE_UINT64(CSR_EENTRY, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBIDX, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBEHI, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBELO0, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBELO1, CPUSysState),
+        VMSTATE_UINT64(CSR_ASID, CPUSysState),
+        VMSTATE_UINT64(CSR_PGDL, CPUSysState),
+        VMSTATE_UINT64(CSR_PGDH, CPUSysState),
+        VMSTATE_UINT64(CSR_PGD, CPUSysState),
+        VMSTATE_UINT64(CSR_PWCL, CPUSysState),
+        VMSTATE_UINT64(CSR_PWCH, CPUSysState),
+        VMSTATE_UINT64(CSR_STLBPS, CPUSysState),
+        VMSTATE_UINT64(CSR_RVACFG, CPUSysState),
+        VMSTATE_UINT64(CSR_CPUID, CPUSysState),
+        VMSTATE_UINT64(CSR_PRCFG1, CPUSysState),
+        VMSTATE_UINT64(CSR_PRCFG2, CPUSysState),
+        VMSTATE_UINT64(CSR_PRCFG3, CPUSysState),
+        VMSTATE_UINT64_ARRAY(CSR_SAVE, CPUSysState, 16),
+        VMSTATE_UINT64(CSR_TID, CPUSysState),
+        VMSTATE_UINT64(CSR_TCFG, CPUSysState),
+        VMSTATE_UINT64(CSR_TVAL, CPUSysState),
+        VMSTATE_UINT64(CSR_CNTC, CPUSysState),
+        VMSTATE_UINT64(CSR_TICLR, CPUSysState),
+        VMSTATE_UINT64(CSR_LLBCTL, CPUSysState),
+        VMSTATE_UINT64(CSR_IMPCTL1, CPUSysState),
+        VMSTATE_UINT64(CSR_IMPCTL2, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRENTRY, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRBADV, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRERA, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRSAVE, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRELO0, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRELO1, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBREHI, CPUSysState),
+        VMSTATE_UINT64(CSR_TLBRPRMD, CPUSysState),
+        VMSTATE_UINT64(CSR_MERRCTL, CPUSysState),
+        VMSTATE_UINT64(CSR_MERRINFO1, CPUSysState),
+        VMSTATE_UINT64(CSR_MERRINFO2, CPUSysState),
+        VMSTATE_UINT64(CSR_MERRENTRY, CPUSysState),
+        VMSTATE_UINT64(CSR_MERRERA, CPUSysState),
+        VMSTATE_UINT64(CSR_MERRSAVE, CPUSysState),
+        VMSTATE_UINT64(CSR_CTAG, CPUSysState),
+        VMSTATE_UINT64_ARRAY(CSR_DMW, CPUSysState, 4),
+        VMSTATE_UINT64(CSR_DBG, CPUSysState),
+        VMSTATE_UINT64(CSR_DERA, CPUSysState),
+        VMSTATE_UINT64(CSR_DSAVE, CPUSysState),
+        VMSTATE_UINT64(CSR_GSTAT, CPUSysState),
+        VMSTATE_UINT64(CSR_GCFG, CPUSysState),
+        VMSTATE_UINT64(CSR_GINTC, CPUSysState),
+        VMSTATE_UINT64(CSR_GCNTC, CPUSysState),
+        VMSTATE_UINT64(CSR_GTLBC, CPUSysState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool lvz_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+    return FIELD_EX64(cpu->env.cpucfg[2], CPUCFG2, LVZ);
+}
+
+static const VMStateDescription vmstate_lvz = {
+    .name = "cpu/lvz",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = lvz_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.sys_states[0].CSR_GSTAT, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_GCFG, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_GINTC, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_GCNTC, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_GTLBC, LoongArchCPU),
+        VMSTATE_STRUCT(env.sys_states[1], LoongArchCPU, 0,
+                       vmstate_lvz_sys, CPUSysState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+#endif
+
+static int loongarch_cpu_post_load(void *opaque, int version_id)
+{
+    LoongArchCPU *cpu = opaque;
+    CPULoongArchState *env = &cpu->env;
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+    bool guest = FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, VM);
+    set_sys(env, guest);
+    return 0;
+}
+
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
     .version_id = 4,
     .minimum_version_id = 4,
+    .post_load = loongarch_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINT64(env.pc, LoongArchCPU),
@@ -251,6 +386,10 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_fpu,
         &vmstate_lsx,
         &vmstate_lasx,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        &vmstate_tlb,
+        &vmstate_lvz,
+#endif
         &vmstate_lbt,
         &vmstate_msgint,
         &vmstate_pmu,
-- 
2.56.0


