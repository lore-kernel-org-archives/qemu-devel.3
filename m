Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F6CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0xI-0006UT-9c; Thu, 08 Oct 2026 23:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vw-0004hE-8u
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:09 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vu-0005oG-Bv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:08 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id E62E6E001;
 Fri, 09 Oct 2026 08:35:52 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 17/23] target/loongarch: add LVZ migration state
Date: Fri,  9 Oct 2026 11:05:13 +0800
Message-ID: <5cf464e11a8c902b3c87c82b1cdf24fad7ddba69.1791514848.git.prcups@krgm.moe>
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

Migrate the host LVZ controls, guest CSR and TLB banks, and restore the
active VM level, guest timer and interrupt request after loading state.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/machine.c | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 931a5ca5ba..7c14f7d92e 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
 #include "vec.h"
@@ -205,13 +206,115 @@ static const VMStateDescription vmstate_tlb = {
         VMSTATE_END_OF_LIST()
     }
 };
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
 #endif
 
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
@@ -285,6 +388,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_lasx,
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         &vmstate_tlb,
+        &vmstate_lvz,
 #endif
         &vmstate_lbt,
         &vmstate_msgint,
-- 
2.55.0


