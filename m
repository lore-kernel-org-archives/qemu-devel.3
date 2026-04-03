Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340ACD730A2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 05:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8XEJ-0004Fv-T5; Fri, 03 Apr 2026 01:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8XEI-0004FS-99
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 01:38:02 -0400
Received: from qs-2001j-snip4-11.eps.apple.com ([57.103.87.103]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8XEG-00089d-SB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 01:38:01 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 F1F9E180015D; Fri, 03 Apr 2026 05:37:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775194680; x=1777786680;
 bh=LeCfULzXVq8eMeXoD4HoazACVFGuCL5m06fQgObX99k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=c9DD0jM92oWOAp9lzgLePizgiiUQT6JBr0AlUCXUecpbKn0YPXnL9bPZgmcxMKkEtD6G9ff4Sn4BbVWrHM8B24HybW533VdMin0R281hXDPrk46OIbuCVSWZZEy82kUFjDilc7Pb8SoEs2npVR8czLn0tCcLKlwXzEcV+AZdKijwAcXck4FYmIK4giy/59YNkCACPgZhDN729MJKF09+9CyNlJVDvi4JQIwOh4mEYkS/KDoJmIUozJ8t5u5auXUIsuHxWzS1qvOOWoiiFEp2n6ebVSm38Vcn/9nDTCpfELDZoMZcptePe0GeMyLfvd/DaGoSAE8+RlJ5YJs8yahseg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 471F11800151; Fri, 03 Apr 2026 05:37:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v4 4/7] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Fri,  3 Apr 2026 07:37:45 +0200
Message-ID: <20260403053748.78831-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403053748.78831-1-mohamed@unpredictable.fr>
References: <20260403053748.78831-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3l6habb5X4joWJnYWIsEMrlzgw6NFJYN
X-Authority-Info-Out: v=2.4 cv=etDSD4pX c=1 sm=1 tr=0 ts=69cf5236
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA0NyBTYWx0ZWRfXzCPzK3IdGZ8F
 +a8I4+c/5gGfDOrxlwFBNrkLp5YdASB2cS5Ta5pLyyJLk15HYr0clWBjTTg9tNxYJHqYSmLRCBH
 uSwSbNq91uV68j+OXG1zfeZi1Caw0dVyEo6Lh8IZCmlwctGdjwehyvcEO6qKoEfsrjN36Zl6ZMB
 /Ltad7kGd8X5rvCSqpe8oS5YUWA5NIeidVoqdulCG/I/h13vF7wnTBw64GPwnZCw5HRq4ZFSQ0S
 gl5AHNayXhvmDXv+4x6+ASAU38z22v79S03wKi1ztGA3AeJuq55q0rYEIaTyIYq07ArbTnCObpe
 qsJDZWqUKvW9TK59Gb5UzwZceX808rvwKmnzttKIcCILem3mJtZsX6xalxkaxM=
X-Proofpoint-GUID: 3l6habb5X4joWJnYWIsEMrlzgw6NFJYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=709 suspectscore=0 clxscore=1030 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030047
Received-SPF: pass client-ip=57.103.87.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


