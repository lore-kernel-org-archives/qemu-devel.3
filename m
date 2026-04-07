Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B2FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTo-0004uA-Cn; Tue, 07 Apr 2026 14:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSZ-0003Gt-Rh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:35 -0400
Received: from p-east2-cluster2-host4-snip4-10.eps.apple.com ([57.103.78.123]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA8Bs-0002FH-P2
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:18:10 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 3BA181803F04; Tue, 07 Apr 2026 15:18:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775575088; x=1778167088;
 bh=poibcXPqvaJ8YaZ5/PTr9/BHGmofzQDktL0gBjdI+dM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OAb09oDOCg8kli4moRyDIhfZzOJGg+LCr6apUZGtZX9hZa+Xbx798m62NXdbPHLLCJw+/qPWnYhhfqgEPysaZlMnNu6ncuitPW2CY0MySFuKSEG1EIhxM6xyljARH1GgMRtU+iaZECGH9O+YnljLMSGairAlHwkrn+m0BImoiHmyayFKiGUSL4ByuBEGD79JVfNIs85iR8ly+vGoJ8QqP3diIFejduDWA+3y9MQYmbbkPk7+0NTxX/nr19lzU/V13NZgzSGxqjmoSMYsDnVl5Agdli9gqyuQMNwb7JlU/komPeZuR0FSIgzUjXiotL8dE/fXh07DLhoUcI7vpuqlxg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 ED91618013CE; Tue, 07 Apr 2026 15:17:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v9 13/13] whpx: i386: interrupt priority support
Date: Tue,  7 Apr 2026 17:17:07 +0200
Message-ID: <20260407151707.46536-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407151707.46536-1-mohamed@unpredictable.fr>
References: <20260407151707.46536-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=D9tK6/Rj c=1 sm=1 tr=0 ts=69d5202d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NuKELtICf0aykZwt-QIA:9
X-Proofpoint-ORIG-GUID: Wth6-0DIbkCDXiKnV2jT1R4zQtHZmAUI
X-Proofpoint-GUID: Wth6-0DIbkCDXiKnV2jT1R4zQtHZmAUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX9NTiXMdk2L/C
 ehF21G60Elszc5s7mBcIAvvD8qK92k2DYTjvx5DvNf5OrmhNcjpTSkyuBb40gtZjPYaixJWrPq1
 BNh5wJ6rwlnioUkeFxaEgM+NIfvcfoqxATmYagwrUzqi7WjD1WHtsUE8TleeunUQQ6BrX5KEAC5
 ElKpPlvcrwvNeJTnza/JsnargSVQtreHVbl0TxJnWAhaE4tbhDgICEoR1wtgBT4mgD4yrxyC+fp
 pxObNb1JQLlhj9wAExLsmTlFbuTfAzFA/toYXrFfzssg69JCFG/8/MJr+ODbBqF60DMEiMI0Tzz
 Cv5Htxuc0VMpTUVqnxddlBZWXXE2LAF6IJPnAP/g9324NYAsZwFNZXGwBotf9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 mlxlogscore=657 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070140
Received-SPF: pass client-ip=57.103.78.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement APIC IRR interrupt priorities.

Even with kernel-irqchip=off, Hyper-V is aware of interrupt priorities
and implements CR8/TPR, with the InterruptPriority field being followed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7a31dc6427..8cd81fffee 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1588,6 +1588,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     UINT32 reg_count = 0;
     WHV_REGISTER_VALUE reg_values[3];
     WHV_REGISTER_NAME reg_names[3];
+    int irr = apic_get_highest_priority_irr(x86_cpu->apic_state);
 
     memset(&new_int, 0, sizeof(new_int));
     memset(reg_values, 0, sizeof(reg_values));
@@ -1623,10 +1624,20 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         }
     }
 
+    if (irr == -1) {
+        if (pic_get_output(isa_pic)) {
+            /* In case it's a PIC interrupt */
+            irr = 0;
+        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
+            abort();
+        }
+    }
+
     /* Get pending hard interruption or replay one that was overwritten */
     if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
-            vcpu->interruptable && (env->eflags & IF_MASK)) {
+            vcpu->interruptable && (env->eflags & IF_MASK)
+            && (vcpu->tpr < irr || irr == 0)) {
             assert(!new_int.InterruptionPending);
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
                 cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
@@ -1683,13 +1694,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Update the state of the interrupt delivery notification */
-    if (!vcpu->window_registered &&
+    if ((!vcpu->window_registered ||
+        (vcpu->window_priority < irr && vcpu->window_priority != 0) ||
+        (irr == 0 && vcpu->window_priority != 0)) &&
         cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         reg_values[reg_count].DeliverabilityNotifications =
             (WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER) {
-                .InterruptNotification = 1
+                .InterruptNotification = 1,
+                .InterruptPriority = irr >> 4
             };
         vcpu->window_registered = 1;
+        vcpu->window_priority = irr;
         reg_names[reg_count] = WHvX64RegisterDeliverabilityNotifications;
         reg_count += 1;
     }
@@ -1703,7 +1718,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             reg_names, reg_count, reg_values);
         if (FAILED(hr)) {
             error_report("WHPX: Failed to set interrupt state registers,"
-                         " hr=%08lx", hr);
+                         " hr=%08lx, InterruptPriority=%i", hr, irr >> 4);
         }
     }
 }
@@ -1919,6 +1934,7 @@ int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonX64InterruptWindow:
             vcpu->ready_for_pic_interrupt = 1;
             vcpu->window_registered = 0;
+            vcpu->window_priority = 0;
             ret = 0;
             break;
 
-- 
2.50.1 (Apple Git-155)


