Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7146FD0040
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9h-0004C8-Aw; Sat, 28 Feb 2026 16:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9d-0004Aj-J1
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:18 -0500
Received: from qs-2005k-snip4-11.eps.apple.com ([57.103.86.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9c-0002Tf-10
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:17 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 51617180013D; Sat, 28 Feb 2026 21:47:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315233; x=1774907233;
 bh=4n4xIy8i5xV9kHLwKpAQhwfVxRJH3sNm66Cv+vgl914=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YuaT5ygCgean+2UWg47mKBfS0P+RAXSXsNNU8JNNaaIYPMQMw5ylfBKoULRlipESpDiqLXgRgFfBp5FrS+EbjJPkw9eIWw+P4CZhAGi0/EqO5Waa1Nvzna0ZjfJUdkBYBsy17cs6itEGCFKkCSVtJ/hsrnQwPtNAlO7FeJwtpO/dCVqIItuWdm6h9y66E0Hd/AfYlwhSyhUwUmNE3CEadWHJRX7nnDsbKGpNAUJN12XfKoNuAkYCHXJL1tt8cCLEKV95h/ODueEb/6q7ugWe0HTBc8m+3gTAx2R/AxpCpXFlfFAMKiagU8dyuLkKJiKGIue78K+/OoJOufWOi7E/FQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 6D9B71800133; Sat, 28 Feb 2026 21:47:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/8] whpx: i386: move whpx_vcpu_kick_out_of_hlt()
 invocation to interrupt raise time
Date: Sat, 28 Feb 2026 22:46:57 +0100
Message-ID: <20260228214704.19048-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: foUfAYin6i1JFG5tPM5l9Ei3QA42NHFh
X-Proofpoint-GUID: foUfAYin6i1JFG5tPM5l9Ei3QA42NHFh
X-Authority-Info-Out: v=2.4 cv=NoDcssdJ c=1 sm=1 tr=0 ts=69a3625f
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=o8I7T96M5UCSVa1h564A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfXxnJjRW6IWaK5
 JHFJEhuwnxLpMF67MRTiYR/P6oweJB7c8MBdHry2DjDgcL3+9nkIEamhk2PkEQerYomqvoPknVr
 +Zx8MqcG//WI+J7xeXndxONRo3n9VWEKxcoUrSida0HxVpMynUOHHFOxA6Bg5h/twajuxpW5tH/
 wOgn9AbNX7pvn0bwA2EVOpu9m9YVgSZJj8XuAyNCNMDik+xh+8qKu98cObpeL4Z6spQ4oB+5dMn
 zcOxAU6UaRvdLWJ4YXlvb9chM3tyLE40zU6rKuZOKhzeii4rjuoEev3CIMs8dsEXPcT+9EtjAr1
 h2cwObxaTeWmI3xbfAJtuz2miFifkWa+AuKkto5usMsz2UgN8BD6zf3lSw0unU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABIlm5tePjv4X9vt2D+fTviVk+nmZ2x4HMaiXGPvkG1SpCGCnsYmI9uATfxPzc6aKotZQiBOnJKTgaUaqLTScmlFPpFc2pQNPv8sKBYqnjIUH5LBqtZBB/wx4QjB5oaUS5RNQdaeUnDC+B3A9U9GaNli581Qh/Cqugus1kyqIiRpTYSt8HDbQoGFZaVXAMuMthTYXS8Ge2JCpRp0tf26dGeJbHojPwYlkRdNeDIJAlawBUTzhl0ZgjSLaHb6DMwy0LADYJ0s+lFgwh45c1WNcV4/vA4IykgjpjAV3HIdtcza4Hn1PeRUrdcQawiFKHjQAU88i0Qnra0AzH+1cObMy+I4d4gWRlSB2E/02s46tNdAThOlieYJKq8+FDrh67O/GiAn+cDaA5+gvlRa6R/tDzPOlOSgE1v7WwOrpRE6eQnjPTa3VRhvhP4BDOAwpvZ7IdKyzvnODxBWUO02GWy9Pb3psUnGN03/VfNremlswZeFklsBtl46cz7217PLh0wBHf4rTNUfsVzFuqO/kA0LdE9TcGlp338QOcdiamlqWdWOxUdL2UVP2D7efA/bmK6OThrGklLJUA6QdzPoxK1BttB4J5GDmY5j+T6xjcQWUUP4aScoM0LLOTAHeNCvFWQDWVyH2uttYneIDt0eCJmObxAdXpj7rD6g7ZUTehD02NHWRpHlWsmdyDdz5tRSmOIs8S
Received-SPF: pass client-ip=57.103.86.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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

This fixes the sti followed by hlt kvm_unit_tests.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 49 ++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6d2771a98a..90f51fc4dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1308,6 +1308,16 @@ static int whpx_handle_halt(CPUState *cpu)
     return ret;
 }
 
+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
+{
+    WHV_REGISTER_VALUE reg;
+    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
+    if (reg.InternalActivity.HaltSuspend) {
+        reg.InternalActivity.HaltSuspend = 0;
+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
+    }
+}
+
 static void whpx_vcpu_pre_run(CPUState *cpu)
 {
     HRESULT hr;
@@ -1391,6 +1401,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                 .Vector = irq,
             };
             reg_count += 1;
+            /* 
+             * When the Hyper-V APIC is enabled, to get out of HLT we
+             * either have to request an interrupt or manually get it away
+             * from HLT.
+             *
+             * We also manually do inject some interrupts via WHvRegisterPendingEvent
+             * instead of WHVRequestInterrupt, which does not reset the HLT state.
+             */
+            if (whpx_irqchip_in_kernel()) {
+                whpx_vcpu_kick_out_of_hlt(cpu);
+            }
         }
      }
 
@@ -1453,15 +1474,6 @@ static void whpx_vcpu_post_run(CPUState *cpu)
         !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
 }
 
-static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
-{
-    WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
-    if (reg.InternalActivity.HaltSuspend) {
-        reg.InternalActivity.HaltSuspend = 0;
-        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
-    }
-}
 
 static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
@@ -1770,25 +1782,6 @@ int whpx_vcpu_run(CPUState *cpu)
                 cpu->exception_index = EXCP_INTERRUPT;
                 ret = 1;
             }
-            /* 
-             * When the Hyper-V APIC is enabled, to get out of HLT we
-             * either have to request an interrupt or manually get it away
-             * from HLT.
-             *
-             * We also manually do inject some interrupts via WHvRegisterPendingEvent
-             * instead of WHVRequestInterrupt, which does not reset the HLT state.
-             *
-             * However, even with this done, if the guest does an HLT without
-             * interrupts enabled (which the test_sti_inhibit KVM unit test does)
-             * then the guest will stay in HLT forever.
-             *
-             * Keep it this way for now, with perhaps adding a heartbeat later
-             * so that we get the CPU time savings from having Hyper-V handle HLT
-             * instead of going away from it as soon as possible.
-             */
-            if (whpx_irqchip_in_kernel()) {
-                whpx_vcpu_kick_out_of_hlt(cpu);
-            }
             break;
         case WHvRunVpExitReasonX64MsrAccess: {
             WHV_REGISTER_VALUE reg_values[3] = {0};
-- 
2.50.1 (Apple Git-155)


