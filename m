Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE86EF94CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLr-0008NJ-Ol; Wed, 22 Apr 2026 17:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLm-00089m-B0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:14 -0400
Received: from p-east2-cluster1-host5-snip4-10.eps.apple.com ([57.103.76.93]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLk-0007NA-Lf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:14 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 6ED091800227; Wed, 22 Apr 2026 21:43:09 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkAXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894190; x=1779486190;
 bh=9nFB9fdsbicAKGT1x9988h90J9W4/Agy5ocP8yXnAyQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cXNqS4MdcsEou5PVRW7KM2ojkkSWtXg4322MURyGlPBoln9XBjhn6w3qQXL5KWmrxRyCM9d2YSixdUnwcRShuilkQzVlm24x7gBIRFkNAh+AKvSqmJURvkKC+l0tN+CMZTWjt2YL0K9ZxQEJsDxWfZOr5l2wkZQA6oAXvja0jkz3zvs67slb2lG80cWhXtrsx2CthvuPOcnzgBa+9OOY3ikuRyESrgkbekxI9w61uUQzIwlKpPNeN/CsGlb5DSeY8RqffUSxCE1scGjmsErRp0SoLqUgaI7P30ypIzrtL1Ys6BMrDI04YtzLUOd/idMdLWW5pwxRUBC2kmK+tuF/oA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 44DB518000B2; Wed, 22 Apr 2026 21:43:07 +0000 (UTC)
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
Subject: [PATCH v3 21/37] target: i386: HLT type that ignores EFLAGS.IF
Date: Wed, 22 Apr 2026 23:42:09 +0200
Message-ID: <20260422214225.2242-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BHPSpsv3qBW1sJYK9f2_SKrs0OeWjJne
X-Proofpoint-ORIG-GUID: BHPSpsv3qBW1sJYK9f2_SKrs0OeWjJne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX4qudecbySQhS
 QxlYlP1JAKeIKhYUPwqKmAxp/CTEJVo3/IwOsHQkMQ6fy131oe3+/UalulsdRxxdVomaPv9p2jJ
 cWdPJg9yInlqDcUT8DXQ2SDUxv7mrOU2MXnwvk9B4AmYlTpdtcae2KiRzjzVI9Afki2//nfdg1R
 10KeyxmEgq3evLucMBbFfwiGNo4zCNHxixTVgbS+kJLwOdHyLu0vWqm8OfJlL25MibrNEmIY/2t
 1g2gnwH3FvulMYBqqLbqG5BNzNBeMchNTtotcY63XeQ4/TOu97nJTRIHJWMbUcT8rJ8gVND8QgJ
 TLBbdbnwTQi4TemNlIHP+i7WMWg91hVAMzM0QjWrU87LBEthxGh9Tup+tN5msM=
X-Authority-Info-Out: v=2.4 cv=b7e/I9Gx c=1 sm=1 tr=0 ts=69e940ee
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZtXhj7NgbhMgH__AbsQA:9
Received-SPF: pass client-ip=57.103.76.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The TLFS says:

> A partition which possesses the AccessGuestIdleMsr privilege may trigger
> entry into the virtual processor idle sleep state through a read to the
> hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE. The virtual processor will
> be woken when an interrupt arrives, regardless of whether the interrupt
> is enabled on the virtual processor or not.

Meanwhile, Windows 24H2+ calls this MSR anyway without the privilege being set.

Add the infrastructure to support it on the generic QEMU side.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.c | 10 ++++++----
 target/i386/cpu.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a5f1a1a8fd..c9ed9b7580 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10474,13 +10474,15 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
                    (((env->hflags2 & HF2_VINTR_MASK) &&
                      (env->hflags2 & HF2_HIF_MASK)) ||
                     (!(env->hflags2 & HF2_VINTR_MASK) &&
-                     (env->eflags & IF_MASK &&
-                      !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
+                     ((env->eflags & IF_MASK &&
+                      !(env->hflags & HF_INHIBIT_IRQ_MASK))
+                        || env->hflags2 & HF2_HYPERV_HLT_MASK)))) {
             return CPU_INTERRUPT_HARD;
         } else if (env->hflags2 & HF2_VGIF_MASK) {
             if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
-                   (env->eflags & IF_MASK) &&
-                   !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
+                   ((env->eflags & IF_MASK &&
+                      !(env->hflags & HF_INHIBIT_IRQ_MASK))
+                        || env->hflags2 & HF2_HYPERV_HLT_MASK)) {
                         return CPU_INTERRUPT_VIRQ;
             }
         }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c4..67f508dc10 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -225,6 +225,7 @@ typedef enum X86Seg {
 #define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
 #define HF2_IGNNE_SHIFT          7 /* Ignore CR0.NE=0 */
 #define HF2_VGIF_SHIFT           8 /* Can take VIRQ*/
+#define HF2_HYPERV_HLT_SHIFT     9 /* Hyper-V HV_X64_MSR_GUEST_IDLE */
 
 #define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
 #define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
@@ -235,6 +236,7 @@ typedef enum X86Seg {
 #define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
 #define HF2_IGNNE_MASK          (1 << HF2_IGNNE_SHIFT)
 #define HF2_VGIF_MASK           (1 << HF2_VGIF_SHIFT)
+#define HF2_HYPERV_HLT_MASK     (1 << HF2_HYPERV_HLT_SHIFT)
 
 #define CR0_PE_SHIFT 0
 #define CR0_MP_SHIFT 1
-- 
2.50.1 (Apple Git-155)


