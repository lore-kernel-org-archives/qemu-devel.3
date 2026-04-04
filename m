Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F080BE88D7A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 04:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8sUs-0006hG-Oz; Sat, 04 Apr 2026 00:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUp-0006er-RY
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:32 -0400
Received: from p-east2-cluster5-host11-snip4-1.eps.apple.com ([57.103.79.64]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUm-00064O-PL
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 2B969180015F; Sat, 04 Apr 2026 04:20:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775276426; x=1777868426;
 bh=LeCfULzXVq8eMeXoD4HoazACVFGuCL5m06fQgObX99k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IKKYy645q8Zk5KO28AblWY4SSx2B3NFJ8uP+bxRfvc5/k2zrYZpKV2zHBb3KXtSVTSzy2ULnz1UUaaH3iGmgo8+yuRWlE7jn1YnO5I1JTjhSV3XRFxjTdN7Ek4Agw0c9pWwbfbGpgycMcNPLVKOu+MCW0UWDQK6w2315UEP53LtcPX43YsKNTrGoyGwFIk/EFfgNaVkdlHPgBAF/fu59xeqYy50wgRsMuSJgu0fRwfb7IEiBc522FuxFIBkrHnnoVU8OnAX7aIukbal6lczOFmkhdUE32/PW3ua3zyWQHSqTe5mcfTxcUlxIaB/IHjHik3BobOqCAs+B1XZC4AvcHw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 670351800175; Sat, 04 Apr 2026 04:20:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 04/11] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Sat,  4 Apr 2026 06:20:08 +0200
Message-ID: <20260404042015.86580-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260404042015.86580-1-mohamed@unpredictable.fr>
References: <20260404042015.86580-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NWaw5v4TaIOGCHjE7yyR0VUQfiIO6bSh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAzNCBTYWx0ZWRfXw5WebQ7oK/B0
 mURcO3fjiT5U2GjKgtd/XqHpjt8De+ZNLixVgcW/0p2VvC+3SLZue13vELu9ZYfWGHwrO+cqjlT
 hxe9we73UUWnCGw1nJsmQmmSNkk1CQJN1kUNyFtqT0ykjrvib+Qx1wLSJH1BAw+Zxo0FmxZYoBe
 05hYMlMecsUrh7xTzPdPNF+ma9gklGgrrjIjRpc3YrIl9uoPdHzHSWuYuv3iSzLp7yFY45c8EFm
 hwhbbfxfHMRWrCZtVYaNVJ8QlQxGgsS8XQDcXpmQbJV26Oy5gPg8GVtZF0fqZLQn70KZXk5czmk
 W1Xd+5ZVmu1wQPQE+VVUSCTgpFJKUBvb1+RNjwLOd6iMa/7UM/H319kjKmiki0=
X-Proofpoint-GUID: NWaw5v4TaIOGCHjE7yyR0VUQfiIO6bSh
X-Authority-Info-Out: v=2.4 cv=cc7fb3DM c=1 sm=1 tr=0 ts=69d09189
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=709
 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1030 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604040034
Received-SPF: pass client-ip=57.103.79.64;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

AccessHypercallRegs was present twice so clean that up.

Remove TbFlushHypercalls (and its extended Gva range sub-feature)
from the user-mode LAPIC case as it behaves oddly there.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2d527b90dd..0908dfd134 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2489,10 +2489,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
-    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
-    synthetic_features.Bank0.TbFlushHypercalls = 1;
 
     if (whpx_irqchip_in_kernel()) {
         synthetic_features.Bank0.AccessSynicRegs = 1;
@@ -2500,6 +2497,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        /*
+         * These technically work without the Hyper-V LAPIC
+         * but behave oddly for multi-core VMs.
+         */
+        synthetic_features.Bank0.TbFlushHypercalls = 1;
+        synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
-- 
2.50.1 (Apple Git-155)


