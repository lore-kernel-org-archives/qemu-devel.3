Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441D1C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBkW-0008B2-2S; Wed, 14 May 2025 09:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBht-0004j3-0Q; Wed, 14 May 2025 08:59:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBho-0007vw-MQ; Wed, 14 May 2025 08:59:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F8C9121AEA;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C6A220B858;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 12/34] target/ppc: Big-core scratch register fix
Date: Wed, 14 May 2025 15:57:34 +0300
Message-Id: <20250514125758.92030-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The per-core SCRATCH0-7 registers are shared between big cores, which
was missed in the big-core implementation. It is difficult to model
well with the big-core == 2xPnvCore scheme we moved to, this fix
uses the even PnvCore to store the scrach data.

Also remove a stray log message that came in with the same patch that
introduced patch.

Fixes: c26504afd5f5c ("ppc/pnv: Add a big-core mode that joins two regular cores")
Cc: qemu-stable@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 9808ce6d5cb75a4f9db76a3d9b508560efdf5ac2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b..af20c39a7a 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -321,6 +321,10 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
 
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
     switch (sprc & 0x3e0) {
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
@@ -357,6 +361,10 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     int nr;
 
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
     switch (sprc & 0x3e0) {
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
@@ -367,7 +375,6 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
          * information. Could also dump these upon checkstop.
          */
         nr = (sprc >> 3) & 0x7;
-        qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
         pc->scratch[nr] = val;
         break;
     default:
-- 
2.39.5


