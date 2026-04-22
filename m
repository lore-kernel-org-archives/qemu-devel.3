Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2713DFA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLf-00086D-1D; Wed, 22 Apr 2026 17:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLZ-00083v-Q0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:01 -0400
Received: from p-east2-cluster1-host4-snip4-10.eps.apple.com ([57.103.76.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLY-0007Hh-7a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:01 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 4D58218000A2; Wed, 22 Apr 2026 21:42:54 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloGXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894179; x=1779486179;
 bh=PTJ2O4Ojv4UoqiVrgxlmPkb95gxJ24lLpPPfWfj3pTE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UBBbu64ezrW4xm28OIPiijFWV/efay9SO+d/spZIe5hQ8qvIQmxiDbQu+uXaQ0U47tbeUfmVwr9zHnWrIHiYZ49DfWtTEE8T5B7fAYuFtYYIZMSYuiZCZfuQ0cK3+5VksYF/q7yxiDyf5VmlPQG+FHxV4yAx8S3Z4NpbSziPRRSx0CaRI7xIBKZ3yXw4wCXbum0oCVXSDUOGifCHinaBza1KR/UH9i2kw6Cjr9Jjxx9DJZ7vFQ27hS2s3KfGzQGro/WiCf+vK8NdSqG0WIxtt2Yp+vDjd1DYm9mwwxlCGlcQbyPv74Uj4cNPvJe/xdyr350LfWfAz50FlcWbPg2KPA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 6250E1800216; Wed, 22 Apr 2026 21:42:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 13/37] whpx: i386: interrupt priority support
Date: Wed, 22 Apr 2026 23:42:01 +0200
Message-ID: <20260422214225.2242-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LdGl3CKip8ZBmp7o0_q-RZmnF_WqXqNx
X-Proofpoint-ORIG-GUID: LdGl3CKip8ZBmp7o0_q-RZmnF_WqXqNx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfXz7fAEydlgM13
 ZZt1rvLa3t6qelWKBNTaKAhHFWUoxAO/reMnIJRReWwfcRt2w8D2ST+kXQHDAnbQNB754V6Gv/t
 Q2FTaIQE1ZuYKCH+JWktZEzy4uosHRvgW0YuQ+0MThacD9FslkKJfI9sBGz7t8pxqemP1O2vjRj
 VWvef4jFF6azCQK0igYH+SpOuqCkHMrXn4kpHTnY4BsHUiieAr7v1RQELb+iUZuoBsyHOAVgrkO
 jAQEyC+CPMwAr3RkJXOUVYaaERqFE36isfl5oFKolFe1PLif83QZ+zho5tAgviH/Bbw1jK+suID
 gLhwgP7fSKIjzIx6Je+BrhdIgFbN2vdP5DHM60bM3hwfmsJGRtmT/7paBrC7L8=
X-Authority-Info-Out: v=2.4 cv=b7e/I9Gx c=1 sm=1 tr=0 ts=69e940e1
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NuKELtICf0aykZwt-QIA:9
Received-SPF: pass client-ip=57.103.76.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index cbcf1de7ae..012fa6d021 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1673,6 +1673,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     UINT32 reg_count = 0;
     WHV_REGISTER_VALUE reg_values[3];
     WHV_REGISTER_NAME reg_names[3];
+    int irr = apic_get_highest_priority_irr(x86_cpu->apic_state);
 
     memset(&new_int, 0, sizeof(new_int));
     memset(reg_values, 0, sizeof(reg_values));
@@ -1708,10 +1709,20 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
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
@@ -1768,13 +1779,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
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
@@ -1788,7 +1803,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             reg_names, reg_count, reg_values);
         if (FAILED(hr)) {
             error_report("WHPX: Failed to set interrupt state registers,"
-                         " hr=%08lx", hr);
+                         " hr=%08lx, InterruptPriority=%i", hr, irr >> 4);
         }
     }
 }
@@ -2004,6 +2019,7 @@ int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonX64InterruptWindow:
             vcpu->ready_for_pic_interrupt = 1;
             vcpu->window_registered = 0;
+            vcpu->window_priority = 0;
             ret = 0;
             break;
 
-- 
2.50.1 (Apple Git-155)


