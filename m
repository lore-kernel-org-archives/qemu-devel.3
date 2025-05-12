Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A7FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9j-0004Z9-A6; Mon, 12 May 2025 11:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9d-0004R0-7i
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9b-0006g4-Av
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9x3U018773;
 Mon, 12 May 2025 15:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=778VNQ75+iqwWYrLSqFDvCcf6XPHa5OZTYzaoPGVmHE=; b=
 Y46IlM02E+2mUWppNqsm5a3y5wsMvN+mQkG2Rts+g0sHZuM30IDIwMOdyP42F0zO
 kGekrX+nJ2AVtdtOL2t5PHZ3LmNS0CqGJDVJ+wAu3k9zwxeGDukXoZ4DcvEqYBtJ
 iGpDsx7WI1sjMaz7ZntmCG7T9US5n3stYxX5fnwXN9yLeczNip3iAHoHszIorMvm
 LhI+sG0aP0+HXUncoDZA0SHHduzMhK6UdRJE40UIGB2QoXvBwsqzPcpeQ1BJsGVL
 otSKZyg8rvV3PkWg4LS5wBxaq+HX/dnoPKogKJBQqNHuHJN1sjgSDzIRfo+btjHz
 N8F6jvDp+V3aC39QQi83VQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEFRSp002372; Mon, 12 May 2025 15:33:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk56030605;
 Mon, 12 May 2025 15:33:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-15; Mon, 12 May 2025 15:33:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 14/42] pci: skip reset during cpr
Date: Mon, 12 May 2025 08:32:25 -0700
Message-Id: <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwuVtSw0Qu64n
 +nzXp+cKuPxQnwVLO+hVGi25hmECVycRkIGGId9NqrKXxLqHsBuEqohb2HFmZ8sk6qtdkDUhFsP
 zFbTWjJ9cumxlL0rhVZ/EdPoFWsG+qj3DtA+d9jCUCYVzMKMeCQtW/ZNZOHSGByWIUh/sVBYtNN
 grBDJzwaA4IV/OeA4AjgMC9tROXPDE86OypZvFjlNWVU2COd73g7E93gSSI6SOEW7knJ6oYHWPp
 v/CYuwL9TrOrNsu30VBHmh1a24ybhGI6cnfveOip0ZKUoiycWSU620JtLODLkXxHh/+zKi4gVva
 NWayuSg4WvaK2eq8D+sQAsh9xx+EZj9A3RmMWRypKq7u3n1OYOceG5dSTrmZiETbMEsGQ3byYnj
 rJHU4f5eLChhEJtcjNLTfONogRg1CfwoCWdVR3+ykhNa7uyYXrcabREQAV37P03OhYeUNLPz
X-Proofpoint-GUID: Ej-ChlCEN7ELWc0ptEIwyV3T4Swim1GC
X-Proofpoint-ORIG-GUID: Ej-ChlCEN7ELWc0ptEIwyV3T4Swim1GC
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214b2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=PSWsS4S1t34ZyZu6q74A:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Do not reset a vfio-pci device during CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/pci/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fe38c4c..2ba2e0f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -32,6 +32,8 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/cpr.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
 
 static void pci_do_device_reset(PCIDevice *dev)
 {
+    /*
+     * A PCI device that is resuming for cpr is already configured, so do
+     * not reset it here when we are called from qemu_system_reset prior to
+     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
+     * safe to skip this reset for all PCI devices, because vmstate load will
+     * set all fields that would have been set here.
+     */
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
-- 
1.8.3.1


