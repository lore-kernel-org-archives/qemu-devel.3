Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56F2C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgaO-0001f6-Bg; Tue, 28 Jan 2025 03:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgYW-0006Kw-6H; Tue, 28 Jan 2025 03:02:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgYS-0002B9-CR; Tue, 28 Jan 2025 03:02:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CBD75E1B5B;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 47A4A1A630E;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 09ACB520AD; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 20/58] target/ppc: Fix THREAD_SIBLING_FOREACH for
 multi-socket
Date: Mon, 27 Jan 2025 23:25:06 +0300
Message-Id: <20250127202547.3723716-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The THREAD_SIBLING_FOREACH macro wasn't excluding threads from other
chips. Add chip_index field to the thread state and add a check for the
new field in the macro.

Fixes: b769d4c8f4c6 ("target/ppc: Add initial flags and helpers for SMT support")
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
[npiggin: set chip_index for spapr too]
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 2fc0a78a57731fda50d5b01e16fd68681900f709)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a30693990b..9441d14bfc 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -317,6 +317,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
+    env->chip_index = pc->chip->chip_id;
+
     if (pc->big_core) {
         /* 2 "small cores" get the same core index for SMT operations */
         env->core_index = core_hwid >> 1;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 56090abcd1..2ada5c9225 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -317,6 +317,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
         return NULL;
     }
 
+    env->chip_index = sc->node_id;
     env->core_index = cc->core_id;
 
     cpu->node_id = sc->node_id;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f7a2da2bbe..4469c15708 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1251,6 +1251,7 @@ struct CPUArchState {
     /* For SMT processors */
     bool has_smt_siblings;
     int core_index;
+    int chip_index;
 
 #if !defined(CONFIG_USER_ONLY)
     /* MMU context, only relevant for full system emulation */
@@ -1409,8 +1410,10 @@ struct CPUArchState {
 
 #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
     CPU_FOREACH(cs_sibling)                                     \
-        if (POWERPC_CPU(cs)->env.core_index ==                  \
-            POWERPC_CPU(cs_sibling)->env.core_index)
+        if ((POWERPC_CPU(cs)->env.chip_index ==                 \
+             POWERPC_CPU(cs_sibling)->env.chip_index) &&        \
+            (POWERPC_CPU(cs)->env.core_index ==                 \
+             POWERPC_CPU(cs_sibling)->env.core_index))
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
 do {                                            \
-- 
2.39.5


