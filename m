Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F22DFD8FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfxg-000061-3O; Thu, 26 Feb 2026 13:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxd-00005M-Vd
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:41 -0500
Received: from ci-2002j-snip4-2.eps.apple.com ([57.103.88.223]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxc-0005av-FU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:41 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPS id
 4F4A01801811; Thu, 26 Feb 2026 18:19:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772129979; x=1774721979;
 bh=7qA4BCLQMN4XS1FXGbMF13eb+LsIV/MEtTwRy2sZzuQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Zq7TNp48IsZuUijwJfRHZrjJR/ToZdUEaKY03FgmhDiX1iTXnkUUwiwSgxiMK8YLwJcIJXxgPH14bu9ULBuqxMlIEl3PGVAh56QR//MHb0k3R1gZ2yahPLFrynGShPCyYjvg5dJHt4bxL6vH2Dczc74IkF/r5nPzc4MpJQ/ZuekpYxVfys6/1FGm6PYtTIrbwStY71kpy3VCYCfCAE/bB3Jd7gP6oBqGJ0Ya44eZVpJDlWhLTjPS0Ortb/DAupNxKmHymaVaM6t9PrnJEdT4FUcdVky104xeEUftlDWv3bCp2eYEuHjHBQJ01llmTdY6WxwUoISRCPM+by/DuMQ7ug==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPSA id
 7900A18000BA; Thu, 26 Feb 2026 18:19:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/3] whpx: x86: kick out of HLT manually when using the
 kernel-irqchip
Date: Thu, 26 Feb 2026 19:19:29 +0100
Message-ID: <20260226181930.53170-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226181930.53170-1-mohamed@unpredictable.fr>
References: <20260226181930.53170-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qlom6O-qW0uBbvC88L4ilTJnHcPeICJ2
X-Proofpoint-ORIG-GUID: Qlom6O-qW0uBbvC88L4ilTJnHcPeICJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2NyBTYWx0ZWRfXyrtgCEj7yAFF
 I6oe4pa9L+jxsP9/iXtgbcd4od5O9vqrwyrbGcpHhvvnLl8cc4F1WExvV135xzFCskzGkkcnBWI
 oSdD//43aPXruxKihia0PlwLu3nAoGetFVsOixI1KDdjMWjh1o3tQJXPrdEV96fkRvCXrImkTa5
 5eiDzJrvQfDEFVvGhx83IxDc18skWdsCxgoltwjl9BMFno4fc0jJZNLqVxsydIl8LJIoVq3VmDD
 XgcDwQ5lZ8MhoteEEQgRfvymhxPzZ0i2mTun4w8YPlyRjTrkTeu7CeMRFc+/4sK1qdpSD3A9VLz
 Dkt3x6/WTJF3anbBqsqUFccHgXcCQdkWbKMGpwOSrKMLnlD1LPWXYxKT3nHQN0=
X-Authority-Info-Out: v=2.4 cv=C7jkCAP+ c=1 sm=1 tr=0 ts=69a08eba
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=fIeqQ3EAThi7b9p0I9QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260167
X-JNJ: AAAAAAABUvHMqQ+uCmRRZ4AlElLHjh8SKqxo6l5m7eqJBCMgVC/bctFYo9Q1kZEyevZIuJJ9+xXYYNl5hVUt2J9rSkwvf2gP5W14gBYvgqfpU0zJc8O6IF3nPOljJWEpzXr1uoy1Rs867h3bDk9JzJuzRatkLgbmsBl9VAP/k9oU8tWLR+9422YMQFmX511fa/FdYcUIeDKxkunSkdNLoXYW1qS/hWINjMYEq1FeZrcWCiO5JatesMdsiei07Q3Cl4cGQlU87qoBUXj30aai9gXnnSQXTosGBlXrixXGGDYuFEvV1pI897a/qAi23Y01P13FAWkOLJ9x68oR9NGSSJZnu0YW1P4VXzcV7kpwoVjx4Qb1t61Ja1wGwRUe/H/Pcy1BCK0j5R+sVYoM0acgokvCnKoceSMGZJauz1M4I3p0p2sQWz0YF5jcClpv4PB/AqTnU/KXMx1emO+YDBmlqvHgXrF1wYRnvTsnlcYQmdTfbvPXs8rsJ56B8o8gp5w9MztWzjirDmE5sCQ6eWhxX24UWCpyawsoHkUZM3TgAb6AST+JMxqWR8h6k6jWDfNe7Zn/cb1HNXHyw4vuglQDYLyUIZFONA1LofenP0aBpFDqtP/DIXm+fGtTP759XWgpAQdCCHvZ4cUu9dOSTIry+ULnqCQKBylT4e3h30198fK7bPAUIisheypXDXXxZJhLthP/TJVligDw81Y=
Received-SPF: pass client-ip=57.103.88.223;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

Otherwise, interrupts processed through the cancel vCPU and inject path will not cause the vCPU to go out of its halt state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bd3a1c49c6..650d65c61e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1475,6 +1475,16 @@ static void whpx_vcpu_post_run(CPUState *cpu)
         !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
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
 static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -1760,6 +1770,25 @@ int whpx_vcpu_run(CPUState *cpu)
                 cpu->exception_index = EXCP_INTERRUPT;
                 ret = 1;
             }
+            /* 
+             * When the Hyper-V APIC is enabled, to get out of HLT we
+             * either have to request an interrupt or manually get it away
+             * from HLT.
+             *
+             * We also manually do inject some interrupts via WHvRegisterPendingEvent
+             * instead of WHVRequestInterrupt, which does not reset the HLT state.
+             *
+             * However, even with this done, if the guest does an HLT without
+             * interrupts enabled (which the test_sti_inhibit KVM unit test does)
+             * then the guest will stay in HLT forever.
+             *
+             * Keep it this way for now, with perhaps adding a heartbeat later
+             * so that we get the CPU time savings from having Hyper-V handle HLT
+             * instead of going away from it as soon as possible.
+             */
+            if (whpx_irqchip_in_kernel()) {
+                whpx_vcpu_kick_out_of_hlt(cpu);
+            }
             break;
         case WHvRunVpExitReasonX64MsrAccess: {
             WHV_REGISTER_VALUE reg_values[3] = {0};
-- 
2.50.1 (Apple Git-155)


