Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84937F531CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGj-0007OS-FU; Mon, 13 Apr 2026 16:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGd-0007Mc-J4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:23 -0400
Received: from ci-2007f-snip4-1.eps.apple.com ([57.103.88.54]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGb-0007uP-Vq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:23 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 250BB1800147; Mon, 13 Apr 2026 20:52:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113541; x=1778705541;
 bh=LeCfULzXVq8eMeXoD4HoazACVFGuCL5m06fQgObX99k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gzgkuZPTnQ5n6PXJEZE9sp5kL19ZdfGQjSAl3i9gAzu6jSCdnDnKmVN4sFqnhGZC8uC4ASPComF4UalYPOWUUTqm9Z0fJc1g+xcorjFyk4vAH+HRyh4ZCIx4iGImgFXZiP0jnX5HvuX7I+Gs5qwksTs0V4055eSoXuloynnFWSRAWOsX1eDW/jnmG0oQDfaP/DKeRngR8GKv6TY2B128VlmoC9+MEEykCm7Vz3W0Dk3vx+DztSPl1WbgheAUyDHfaIqwxT1r139v8iDktW/G29+F4UNbi4iZGqg0c6X3vYSx64kc4ULwAdSai+bi/98fc37QcDAelyP1wNicaZth1g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 0E1F01800211; Mon, 13 Apr 2026 20:52:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 04/15] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Mon, 13 Apr 2026 22:51:56 +0200
Message-ID: <20260413205208.50643-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bYvnuCF5BLA837qfaaJdOrj9fOb6L6ol
X-Proofpoint-GUID: bYvnuCF5BLA837qfaaJdOrj9fOb6L6ol
X-Authority-Info-Out: v=2.4 cv=QKdlhwLL c=1 sm=1 tr=0 ts=69dd5784
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX3J23nd5bMFi3
 pdKNWQenNvlRzOJZpxjIj+XS9gJ0pfDzkkYaVKMV2KWnkq2bGswoQLRnTjCMru0Gm4dSUnOmdpZ
 db/lVXGzZ3u8lCvGDcgGhnesrz8iVzDDguSEhlWio9sbfAvbSBeGWARy5pydy8f81HcC6dJUHjA
 Sf2uoIkH9gcj+U5sV+RLlxEOJ/MDO0NO01i59xamXbaXGiHg6I3JpgDNx/dyiVd8OzQ8vRMFWtP
 r+KtpxM0DwKonAAVnhrV0GdtTAhvxUmDkGlzC8kPr48dxPt2dUfeWJZDRQNyjhj54IzxA5rWtxh
 NSBrijviEFxBi4bimP0YO12qt2n0RtfylKnZABw1bMwcn4TVmCXMvYotpru1Xk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=710
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0
 bulkscore=0 clxscore=1030 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.88.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


