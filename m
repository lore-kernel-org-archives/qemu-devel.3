Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30C7F99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEEj-0006J1-De; Sat, 18 Apr 2026 18:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEb-0006DW-GH
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:53 -0400
Received: from p-east2-cluster3-host3-snip4-10.eps.apple.com ([57.103.77.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEZ-0004ur-FZ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:53 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 3EE59180022A; Sat, 18 Apr 2026 22:33:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551630; x=1779143630;
 bh=3V2AbGdIbRhzhb8qduzZPT33vmWH+5zkQKA9bxE3tcA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LdBrrHUjaQM7p7X9Njp30ae8XCY9L/x4Bnt2kOyKWuyxe504h4O0brOtZ5Dbm3F/WXFNKcoMIm2Ir6HmgJqvN1gdOYh9PD31PSDb8mAQC3QZdCKOzY/T1XutsC8oyRzlaaZ8LMcWBSuL+xIatsX4Fx46JjJpgji+MZl7Og72zOxWNvRts95u9J0VEPCC3zg9As4WmEniGXqk7lap6mYbhgsuhWzdbYy8CMuOQ3lCv5m3V8NyjyEc0DW5c4nUCf10DJu/DlocLEm0hZhPfSi47sy9MSJNk+gEeLjg+IDdd2PIENBHMBbL3jmQ8zamqYlZ7fVQpV5qgrijq4ha43IDEA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 28D261800200; Sat, 18 Apr 2026 22:33:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 13/38] whpx: i386: interrupt priority support
Date: Sun, 19 Apr 2026 00:32:55 +0200
Message-ID: <20260418223320.51330-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6keKHzrZYixi3iuVNBkbZ6sWg-pcv3S4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfXx0LDJau9D5WO
 jVm8pd8vuxc1TbQ0X2x3eS4kBsQ4AD0pLv3ZKaWRfuUhudlBFCaopHmRUJPvZqqC0mUWjTB4b01
 Cl1+HW38zsHM3fmhgqZTEqLxofE4EFSi8xhoT3DZAdE424JH3XppJfInIZNXcj4f/V9c4IXc5eH
 n351NrTSjC5bPrmSNivtyr0Fci5a+dpo1DBF0dNaNWzfBKvVwhqZUVtVG8kk+/61rrGYviTAo4D
 P1uo3hbiGSdba4I/XQQVAdGg3Nnujp5lVyG1NLxp/AUK1KMerl6oULdxfj9IC+he+nw2CU2RK6N
 wFmaVzjZFXTEpvT1AWLyCj0AucTMzEQqcalZ/BkRFtwVNwKLAppoEi5RbRv7/I=
X-Authority-Info-Out: v=2.4 cv=GplPO01C c=1 sm=1 tr=0 ts=69e406ce
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NuKELtICf0aykZwt-QIA:9
X-Proofpoint-ORIG-GUID: 6keKHzrZYixi3iuVNBkbZ6sWg-pcv3S4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1030 mlxlogscore=686 spamscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
index d38b83d274..930731e4bf 100644
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
+        if (isa_pic != NULL && pic_get_output(isa_pic)) {
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


