Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88DFD6AB1B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 23:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8RlF-0004Gy-Ly; Thu, 02 Apr 2026 19:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlE-0004GO-Bx
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:40 -0400
Received: from p-west2-cluster6-host12-snip4-1.eps.apple.com ([57.103.70.114]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlC-00043L-Ub
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:40 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 DE2B11800158; Thu, 02 Apr 2026 23:47:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775173658; x=1777765658;
 bh=dxwU2KK4kBZj6yIB2Me6WIjXXMiWXgXWeW+KSpWg+FA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W7d7ytGZfmhYFK27rs8lhmnnAo1OwjRXNLQdjJ2nnj46ew/0SvJS2GMqLXI04ZQcUai9K4eY1Xv2iosj8aLOplUfplRAGN0s1ctCFcTGr8QfbtkUn1f4qwy/eGTALo1gT+66nFgOEyHTdz5cPeJ3kzcg0+m3FJnxzQaawSXBcEEfjna+gn8QoZqb40zQGPehgtrN6OscEnwo7Ff+pw+cBznhXhDVNs0i9URJXmbfssyZtjDOu7Kmvift+cFaLOJIPbYvyiqxeQ/7oev7kCDcmKdAa9vjORXy7WiRqzeOH5ckCNM2t2dU5/jJv6afASbsvImo6PrD1dGiUzM7HThnJA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 EC58D1800123; Thu, 02 Apr 2026 23:47:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 4/7] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Fri,  3 Apr 2026 01:47:21 +0200
Message-ID: <20260402234724.88276-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402234724.88276-1-mohamed@unpredictable.fr>
References: <20260402234724.88276-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bljiwPqhZHlYu__AW29RUnMH7XoHKQzw
X-Authority-Info-Out: v=2.4 cv=Nc/rFmD4 c=1 sm=1 tr=0 ts=69cf0019
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMyBTYWx0ZWRfX2CA1OxQcP6sX
 VbgN8v7frhfezGKElxNSbreA3zNdWIcf0KxfCmX7gsR3jUcpXIgP8w+cNzqaMHX8AwPLOh743Se
 BApk2eXP5nYok/mgADihjot4GADCiBWJ9KvMdSvjRyTg2PJBHVP3YT/18tAvjDMpvvTMKbG6gSC
 RWNjRvFjCHf6sVkoNe1/5nrv2zeXiy7qwCe/7WHnSSpLOmSLm48dLRNRFY8y62J+uYmYMtQLeGM
 sWeQUgRKfS9KwHHnO0JNi8w+TcsQIvV31fRSOAf42zE2vpZIs7lBKYfaQH+I12u8fAG88nrKlPt
 dZ+47W6ZClprosQn1K/qFoOqUXrZhUDrSlj5nbGy16atxM8M7yxwXorBpQ6sOw=
X-Proofpoint-ORIG-GUID: bljiwPqhZHlYu__AW29RUnMH7XoHKQzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=734 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020213
Received-SPF: pass client-ip=57.103.70.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
index ee44e4e060..53bf71d926 100644
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
 
     if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
-- 
2.50.1 (Apple Git-155)


