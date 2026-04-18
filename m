Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316DEF99C9C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEF9-0006nd-7i; Sat, 18 Apr 2026 18:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEw-0006Or-6G
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:17 -0400
Received: from p-east2-cluster1-host11-snip4-8.eps.apple.com ([57.103.76.51]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEs-0004zY-JF
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:12 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 C70BF1800231; Sat, 18 Apr 2026 22:34:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551648; x=1779143648;
 bh=tT4F++bSuONbY+c7bgtCCb6QKbPZ19v7x1ehrozqyHo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=O8w4/47D4XZskitdcX2YOeuBuQ12/ujwKhcENAlau9q5kOEe89QzGWivavsGd0X8jWc4kVFHyY65OoqGBrHRsWDIGpSXg51tAFkcIUODPKKFr4+vwZMDr4lhJwiCz2C9QNlYHWtwy0ikKJBbLJpXWWw/Tw8vwOjaT2e4t0uqtvxonWkhcvfxNj8evmuKAeMnBZnO1RzUBCynf0vbI4OwsnFoqfNDuumYfrADZRXlU0C00A2e65eRoLl0aAzj0f8wXfKPG1NttPSTiISxW4u5XB1v+m9vxRyDrdlKhwrAmmTUn5svEhJ1WaoN9vi7NhFnzkWjfOpYuB1WFkX+rLSjIA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 A08971800219; Sat, 18 Apr 2026 22:34:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 21/38] target: i386: HLT type that ignores EFLAGS.IF
Date: Sun, 19 Apr 2026 00:33:03 +0200
Message-ID: <20260418223320.51330-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a6BJh7fyF4zeEZ00KtYypgFWOSnNrQyK
X-Proofpoint-ORIG-GUID: a6BJh7fyF4zeEZ00KtYypgFWOSnNrQyK
X-Authority-Info-Out: v=2.4 cv=I+Bohdgg c=1 sm=1 tr=0 ts=69e406df
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZtXhj7NgbhMgH__AbsQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX8cCnHyQ5HXSV
 Pv2GiKFlPk/Vy8eSD+8ZwY8L/6PPm+1VCUXHHCe6oOYdLqRsLuAQicHI7wNpWOspYa4hTRWh3EJ
 PsbTw2E90/PFfLYvgc9jQ7AS8LiCwzDpSfrSRGpGbTWNQq4Dq0sZl78hTlA5yi/S1pX+p/1+3Xe
 prL+mDYsB6jB+3HzsOBSlKB5Gbe3D8XPB3Y6T7JGNpeEDXg5JdiC7z5hZhb35eubryziyWO4n3K
 dr/X2chuD3hnpt/1uRXRjo3aZ9VmIABaCvik7h0//aBN+uhLX83lWpqoKyzS//VOMwd5k+jYOYh
 ra/1Cwk1vWYTaB36yexXsaN4tC85MOwoxRkRSsjI+arUoBzqhFceGAw4SboD3c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=959
 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1030 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.51;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 0000093fa3..b18e40666e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10482,13 +10482,15 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
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


