Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D7F55808
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm7G-0000U0-2w; Mon, 20 Apr 2026 06:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm7D-00009u-Io
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:31 -0400
Received: from p-west3-cluster4-host12-snip4-4.eps.apple.com ([57.103.74.225]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm7C-0000pA-4Z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:31 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 291ED18000BC; Mon, 20 Apr 2026 10:44:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681869; x=1779273869;
 bh=H5E2yg8wjRMIBLHacxbEUpLeU4XPrgmC3oFHhxyAG2I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bnPyKZktpJ7aSKDPdE01Ol97vUYQ8MSVkEEuwt2UO9l3ytpSmCb71bjcbZMGHH7BLJOfgZ63W+03tCJlq4Zwm2pRTh7ddJYre1D3g3UpQMsM7u3YvuvkBSdpwr6LJEBCsMSjc2HNSo0ea6BmJ7OQMMh5N9NmRgKJ0NEoHZz+9fvcq/BR6O6QU1aUdtRR9Q74ze6YVFR4daMrnkmklWfgmYmlEtmKI0Jw0OQgVXOeBzFsDXz+86O7iCyXlekjzee0GBTuKKYkxv5NiFeecyeO5jZNIuvrsmXUvd8DTqGkIYPzejBKM/C6Pk2mVV5sVWPoO7JL1Z5FpMpVZcPnymG2bA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 6340E1800475; Mon, 20 Apr 2026 10:44:23 +0000 (UTC)
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
Subject: [PATCH v2 37/38] whpx: i386: intercept CPUID 0xD too
Date: Mon, 20 Apr 2026 12:42:47 +0200
Message-ID: <20260420104248.86702-38-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX2APGd6PVC26J
 y6B4RWCkdJeCjB968ajh4ar/8MttcBEfx4+vWRwMs41502+vMHeVzVLdYbeic40YDOVyJ3U6zeU
 e/nyy8AicXJE8pjSmmGHTsyV7mDHMYVha5Ysm8npqrdxwTFzMWDf15PmuFSDW77zt0DSKzWFQuw
 6F4TcjQ0LGDv/GnNuN5yeyksqNJgXmZriBoBNPyoY4O6DYeoBPHPj3aUuu+B/YP90cOAVxwd4Z1
 sUptHL/NFRaekDZ9WqmpMsytVkH3pCF6lRhDUcwnp/SAa6cZPA2Uq8GKP2YQXWxRNzb+29z9/FE
 SqUpD4RCOGrMRQ7JMCV+dX/NFOwUFeIgBCGe2O82PwgOUlAiaErjRynttbxgMc=
X-Authority-Info-Out: v=2.4 cv=RoLI7SmK c=1 sm=1 tr=0 ts=69e6038b
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7r31mvdhAh4OVJ8YR2QA:9
X-Proofpoint-ORIG-GUID: tvBvNp-TfAhgrBY-IOsOkoDTPNgQUMal
X-Proofpoint-GUID: tvBvNp-TfAhgrBY-IOsOkoDTPNgQUMal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=869 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.225;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

To have a more accurate CPU model.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bda8c484e2..26647671f4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2568,6 +2568,14 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
+            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                }
+            }
+
             /* OSXSAVE is dynamic. Do this instead of syncing CR4 */
             if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
                 if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
@@ -2869,7 +2877,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
-    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0x14, 0x24, 0x29, 0x1E,
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0xd, 0x14, 0x24, 0x29, 0x1E,
         0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
-- 
2.50.1 (Apple Git-155)


