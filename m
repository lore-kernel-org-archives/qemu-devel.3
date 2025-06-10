Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F2AC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2kU-0001ov-Bz; Tue, 10 Jun 2025 13:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2kQ-0001nM-H6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:26:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2kO-0002rl-F6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:26:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGN7A0019454;
 Tue, 10 Jun 2025 17:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=qizwWASt
 wZpnK+4Sqf4tNXNQjISpsZo+DmXa7/8Ezho=; b=cBqO6c0SibMY3X/wM7FS9QD/
 vnuI+wWSzchC0ufvQuqIbRp+DuvLFAywt2mJNBL5dGOslvqD+MFtsRcPRuXWDpPc
 eM0EqIOKFXRNGCNaidnUan6INS9TKrlRrAvRBhlxMVsoZpl5/FMhQmVGI2821I97
 5a+mJCDlvxQXxp/tzD3WUFafefwTO1vjIhW+SffSsgkJQdDEQZuhZdPBX7eT7Odt
 9OQN3DPP+3EoHhtm9wXc0s3hFi2JbKe6Zw4oNpklWzp6GiPkg41d3PUYK4CmB3rm
 3Iibm9jQN1DF25++xAawcsWcjglFMgvW4v+1nH63+4AXeLJmJGd2cDzCDU/9ng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vsed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:26:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AH8mDY007679; Tue, 10 Jun 2025 17:26:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8s51n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:26:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AHQiih006021;
 Tue, 10 Jun 2025 17:26:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8s517-1; Tue, 10 Jun 2025 17:26:44 +0000
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
Subject: [PATCH V5.1] pci: skip reset during cpr
Date: Tue, 10 Jun 2025 10:26:43 -0700
Message-Id: <1749576403-25355-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100140
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=68486ad6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=tDKGrQQYyiCnxYLJR1YA:9
X-Proofpoint-ORIG-GUID: b7wpkCgxHvikyEEaECaRl7oKmWtzn5wZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE0MSBTYWx0ZWRfX9K2bse3lTIZw
 i9vtBE5sKtNdpQGiPoGbw8FSho+a9oJJIYAOyFh/aU4wCBYKFyGLIbF0Bg6do3pWJWCCpa14L9H
 lvuLrs6qVGtDntrTw0krichrINTIFEM1kCUYSnId4+uMRf2O0RKMgbyEbodRnFmYzHKFW+szIxv
 IKb0FnDwSRixwTrnS1kCKa7X8yCSp5yD9+ldhkfE9pO9IQHHNUPKmeptiaviMatjusLuhSAqgP2
 vBrezL/Cwvu0Faf7kFc32ATKDsGlYCdsDNWpIVMdOUC4umerK8p0ofsWyHpKuZ17vtAUPF+mgwE
 AKz2c858HxpYWk2kX87Fo+yZcj3iFmElsZDzpWO3I/G/9zwHeqplBpA+sZ4//yme5XgOv3Y0Fwy
 WiMQWzFO4uLnm11vt573y6oOtNwJXrHkrEw2wcJ2LeYDTDG5wwVUXwMNTlgn6daYhGIJ1hNT
X-Proofpoint-GUID: b7wpkCgxHvikyEEaECaRl7oKmWtzn5wZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 hw/pci/pci.c         | 5 +++++
 hw/vfio/pci.c        | 7 +++++++
 include/hw/pci/pci.h | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9b4bf48..c70b5ce 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/cpr.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -537,6 +538,10 @@ static void pci_reset_regions(PCIDevice *dev)
 
 static void pci_do_device_reset(PCIDevice *dev)
 {
+    if ((dev->cap_present & QEMU_PCI_SKIP_RESET_ON_CPR) && cpr_is_incoming()) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b1250d8..4cd92c3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3408,6 +3408,13 @@ static void vfio_instance_init(Object *obj)
     /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
      * line, therefore, no need to wait to realize like other devices */
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+
+    /*
+     * A device that is resuming for cpr is already configured, so do not
+     * reset it during qemu_system_reset prior to cpr load, else interrupts
+     * may be lost.
+     */
+    pci_dev->cap_present |= QEMU_PCI_SKIP_RESET_ON_CPR;
 }
 
 static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 35d59d7..df3cc7b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -222,6 +222,8 @@ enum {
     QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
 #define QEMU_PCI_CAP_PM_BITNR 14
     QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
+#define QEMU_PCI_SKIP_RESET_ON_CPR_BITNR 15
+    QEMU_PCI_SKIP_RESET_ON_CPR = (1 << QEMU_PCI_SKIP_RESET_ON_CPR_BITNR),
 };
 
 typedef struct PCIINTxRoute {
-- 
1.8.3.1


