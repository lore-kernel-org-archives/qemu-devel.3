Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3099CC6B00
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8AgW-0002T0-VF; Thu, 02 Apr 2026 01:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgU-0002PU-MO
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:38 -0400
Received: from qs-2007c-snip4-2.eps.apple.com ([57.103.84.153]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgT-0004w9-1p
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:38 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 772E01800362; Thu, 02 Apr 2026 05:33:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775108016; x=1777700016;
 bh=p8Ht1Vtnjq43JgQ012CwajYz46XQWZEmBTZmC9qxFcc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JaNJcyDjFgJx/vS4HiQE8DJ+sxzr+NeUNdM5NMf4i3uWgsmie0DAi1ymB3FUV04/hAeWJbw63qc7MIQNVMrZrYgBhW+HRjEp+1HA9j8GvusMRmuhheXU6g3UMzdt/j/OzMH1XsmLTJXLAkaKDATV2sM2gL40l9E6/6MGjI2WORnFqSaVdjQQp+7oToE5bGJKErNa9nry9rVcomI61QaljE65L1ntCDTLyZRjm44fVnX3EG8KlfUiJq6VZspZat3jSx8F1EcRiUZsI589z8t0h/BbUID6AywNX+rZzBFD1pq9eUkyG42xcRzv5f6p9DoIJ3DFPb/lP0n1vPNLgMWVUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 23BE4180014F; Thu, 02 Apr 2026 05:33:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 4/4] whpx: i386: disable TbFlushHypercalls for emulated LAPIC
Date: Thu,  2 Apr 2026 07:33:26 +0200
Message-ID: <20260402053326.23402-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402053326.23402-1-mohamed@unpredictable.fr>
References: <20260402053326.23402-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9_gExml200nmPLFrxirgFaEf07HJay3J
X-Authority-Info-Out: v=2.4 cv=JJA2csKb c=1 sm=1 tr=0 ts=69cdffaf
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-ORIG-GUID: 9_gExml200nmPLFrxirgFaEf07HJay3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NyBTYWx0ZWRfX+WGPm+KSTZL9
 S6HYTYTLGNMhOfroysvl0FUhim+zyXSUnEyqzXIn0OQqGWKgicQ0pmt191WVgm5xCFop0R7vFbc
 ueQzY2vD/8WrmLlEj8wmGIpPGnJ8zlEpq5KIk8i4BfDDf8qcUMIEAIcfSTh1WjztzHOnzvm6CkK
 YNHqBf/YdZetzr1aaa6OfaUcHJS/1Fp0cKG/QOU30deBfZZTxOxUlJzJjrZ2gkyH6kvUNLUyCLi
 0EcWDI6ZwBSPliVQdS65+RKbpgsRwOVCPE/LXc9KCbTUF0xIDe07mye+Ci78cUhKPNgWr8If11T
 WxSMOkXROGuS5C4Dru8PWJMheQ9iRROAAJ4MJvqyTTtB1ZX9Oq9AhNFC5uEDVQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734
 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1030 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020047
Received-SPF: pass client-ip=57.103.84.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

AccessHypercallRegs was present twice so clean that up.

Remove TbFlushHypercalls (and its extended Gva range sub-feature)
from the user-mode LAPIC case as it behaves oddly there.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ad5ec3e700..b29f8d43c9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2477,10 +2477,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
-    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
-    synthetic_features.Bank0.TbFlushHypercalls = 1;
 
     if (whpx_irqchip_in_kernel()) {
         synthetic_features.Bank0.AccessSynicRegs = 1;
@@ -2488,6 +2485,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
 
     if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
-- 
2.50.1 (Apple Git-155)


