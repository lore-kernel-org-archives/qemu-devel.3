Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9C3E8536F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fST-0005AY-0A; Fri, 03 Apr 2026 10:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSP-0005A0-Mm
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:09 -0400
Received: from p-east2-cluster2-host10-snip4-3.eps.apple.com ([57.103.78.76]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSN-0000Al-7E
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:09 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 A49DD18002C1; Fri, 03 Apr 2026 14:25:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775226306; x=1777818306;
 bh=LeCfULzXVq8eMeXoD4HoazACVFGuCL5m06fQgObX99k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Syl9uRLHFIiWmkuGhySqeBIY4i+EwbOItIqDtRtoWOYPsEC8/EQJ5JXTbg1t/Jd+aWCEdRNmtgkjP2YtIrT7grU/0/IGbIiMftg7Py+P1xJTOxrZm6c2XJ9ZojNc8HebkZ7o29f7oh0vgR3OvcZ74+zED1affIIsZ71yeegRi7zL4k2g5iW7SVo6/D83VGUUi4QI2l/awWBv/Wo5/kXKKmT+137EUfZZlGGxKgj4OsEh8foufec2oKBp2GU/G9TcWjDPXRzS21TCRRFS1+AAY2KUXVAhGnqsR446nVJw0j4l9Xp7MejhOOZZQ2DfqAExevksRirMO7V1bWIZXCOjsg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 D9F1B1800109; Fri, 03 Apr 2026 14:24:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v5 4/9] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Fri,  3 Apr 2026 16:24:41 +0200
Message-ID: <20260403142446.36964-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403142446.36964-1-mohamed@unpredictable.fr>
References: <20260403142446.36964-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0iWYz5P1hBZLeCuhGuf3mYT5-LoEc7Z_
X-Proofpoint-GUID: 0iWYz5P1hBZLeCuhGuf3mYT5-LoEc7Z_
X-Authority-Info-Out: v=2.4 cv=fuDRpV4f c=1 sm=1 tr=0 ts=69cfcdc0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyOCBTYWx0ZWRfX1Y2OBg9ZY8Y5
 CMpYyCtz29EvVt/bSNt+2t3sgoBfsdhgsxB6wJAOX0r9DH0oscH2DdIalRQClh+F12AtKl0AWLl
 LeUdXF175n4RGG0UQCQfyP7qJu87I6Ddm9CEXHtkwxOvRbNyL5a2TfEtDzcxSCNg7aiCVkwXr19
 036Zl2bn0iguc46L5lMnvBUg+sY8/tMpvL2D1gbwKsfNm6WmoStc9iFui1qBaZxKUQBgP7ortL7
 54RXeD0YFD8KYyI5vD0+ckpnY6ZNmImamT0xuE/xSAPZK1kwE77jNVvcMdgDUAk9JqlqvFMlYYC
 bB0QeyXTLmXI41g/+Y5ClhEIqoIu6IGUc60jivnKDbhP0Yezy2IpGOKDWLkJKU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=709
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030128
Received-SPF: pass client-ip=57.103.78.76;
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


