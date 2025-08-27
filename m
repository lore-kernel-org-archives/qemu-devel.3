Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E51CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHge-0002dQ-H9; Wed, 27 Aug 2025 11:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgc-0002be-I7; Wed, 27 Aug 2025 11:03:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHga-0004nh-KG; Wed, 27 Aug 2025 11:03:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC94914C52F;
 Wed, 27 Aug 2025 18:02:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A8F5B269837;
 Wed, 27 Aug 2025 18:03:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 07/59] target/mips: Only update MVPControl.EVP bit if
 executed by master VPE
Date: Wed, 27 Aug 2025 18:02:12 +0300
Message-ID: <20250827150323.2694101-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

According to the 'MIPS MT Application-Speciﬁc Extension' manual:

  If the VPE executing the instruction is not a Master VPE,
  with the MVP bit of the VPEConf0 register set, the EVP bit
  is unchanged by the instruction.

Modify the DVPE/EVPE opcodes to only update the MVPControl.EVP bit
if executed on a master VPE.

Cc: qemu-stable@nongnu.org
Reported-by: Hansni Bu
Buglink: https://bugs.launchpad.net/qemu/+bug/1926277
Fixes: f249412c749 ("mips: Add MT halting and waking of VPEs")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <20210427133343.159718-1-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit e895095c78ab877d40df2dd31ee79d85757d963b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 78e422b0ca..97b7fb5e67 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -1561,12 +1561,14 @@ target_ulong helper_dvpe(CPUMIPSState *env)
     CPUState *other_cs = first_cpu;
     target_ulong prev = env->mvp->CP0_MVPControl;
 
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
-        /* Turn off all VPEs except the one executing the dvpe.  */
-        if (&other_cpu->env != env) {
-            other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
-            mips_vpe_sleep(other_cpu);
+    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
+        CPU_FOREACH(other_cs) {
+            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+            /* Turn off all VPEs except the one executing the dvpe.  */
+            if (&other_cpu->env != env) {
+                other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
+                mips_vpe_sleep(other_cpu);
+            }
         }
     }
     return prev;
@@ -1577,15 +1579,17 @@ target_ulong helper_evpe(CPUMIPSState *env)
     CPUState *other_cs = first_cpu;
     target_ulong prev = env->mvp->CP0_MVPControl;
 
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
+        CPU_FOREACH(other_cs) {
+            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
 
-        if (&other_cpu->env != env
-            /* If the VPE is WFI, don't disturb its sleep.  */
-            && !mips_vpe_is_wfi(other_cpu)) {
-            /* Enable the VPE.  */
-            other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
-            mips_vpe_wake(other_cpu); /* And wake it up.  */
+            if (&other_cpu->env != env
+                /* If the VPE is WFI, don't disturb its sleep.  */
+                && !mips_vpe_is_wfi(other_cpu)) {
+                /* Enable the VPE.  */
+                other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
+                mips_vpe_wake(other_cpu); /* And wake it up.  */
+            }
         }
     }
     return prev;
-- 
2.47.2


