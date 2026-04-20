Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E5DF5580F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6a-0007K4-0x; Mon, 20 Apr 2026 06:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6Y-0007Jc-Qk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:50 -0400
Received: from p-west3-cluster6-host3-snip4-10.eps.apple.com ([57.103.75.13]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6X-0000fg-BB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:50 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 518AA18000BC; Mon, 20 Apr 2026 10:43:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681828; x=1779273828;
 bh=tT4F++bSuONbY+c7bgtCCb6QKbPZ19v7x1ehrozqyHo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Y5lN968rPsdG4YhoFc9+bJeWXAP8pirP8325pvD6E3skje7SoyXLlzonmF2+I4HKDy5LkcM/CBQWHtPJleSYdLKYrz7S/spuZnZL/arNSc3NKA4CCdxGTn5UB9usHrBJ22IHqbrCdfuD6H6VHBJamaByR/Z74cD9xVI6MaDZarnrY/PdfGlmgywJqa9UhYWYQR0ltJsxuLIwA7DQyb1mEz54O6PcN+7droBlp0lgeFbZ2QF/97JavT5ID+NdD5hheGrJ3/c+69RMPuYkkDm7qLQHiAodEXFCW+uCIlhrGGoDCvKaWRs47W/0lzRcu/GKqqLqlaU1o7a2aIowDzEVvg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 B58E81800468; Mon, 20 Apr 2026 10:43:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 21/38] target: i386: HLT type that ignores EFLAGS.IF
Date: Mon, 20 Apr 2026 12:42:31 +0200
Message-ID: <20260420104248.86702-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BUSIVBVpXyOejyGnf0nikFQ2625_67KS
X-Authority-Info-Out: v=2.4 cv=DICCIiNb c=1 sm=1 tr=0 ts=69e60362
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ZtXhj7NgbhMgH__AbsQA:9
X-Proofpoint-GUID: BUSIVBVpXyOejyGnf0nikFQ2625_67KS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX2YcaoG8wkDlD
 pOJ2Wkw596+tBK9FsCKZXoMkU2AvQzfbgS3yYWv1l9yOpvRAE93K7Cg5+umt0Hry3lD9k037Fkx
 d0C2VTtAVES2d1mWodbBP+5CbgPjn8ogRoy88fZI0Xu9CXJiZ9y5NQAyJ1AYHaOINaNOaCKssLn
 8q1nKVgt80RF8t3y16kbraDF/mIYur+KsAu9BceUuN2kYlVyIWtwR6iSlCO/hvwHNIp99zpSt47
 Dj5O9ugHNtE7aZ41HVc0SFjfhWStyDhn0LgPzPGs95pz0UU8fxAW9Ksj1aqFg3/tbMlH0rPl57V
 9y7IWzDp8MyhtcZKjkDMyiqE6QJcS6KFGbQQXXdD/Y4YKIcO5WSztpn2RyxLy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=958 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1030 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


