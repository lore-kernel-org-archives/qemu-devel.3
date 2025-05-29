Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380E7C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisg-0004Hw-LM; Thu, 29 May 2025 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisJ-00047w-BH
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisF-0000EE-LI
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsX4009722;
 Thu, 29 May 2025 19:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2ergnAunI4HAB4N5IhTwA128a/uJCVyv1HGEgg0EGEM=; b=
 mpjR3tvdas39z1a3zx1ba4OM0096/F0/sPg206i8aGCg7URfXRl92JUmYOWzCb45
 pEqaMzivWJZnd7UUkZQE5YeEEHBBJFwv3aZr6r50lpcvBHmdeJtoQWujxiJImZ8l
 7O1n+cK1/NfsuoU2AAQhlbEnfbuRuW+Xi/wHk1TwWRBYfoyNmeqUtkbCUILG2mXw
 zkRwaPJZsthUMQz1BaVionLADsbLpCvS9YevDZXi+GKD+1CWZOzMq8BNq3Mk+4pL
 Wq1yNpayBj1790FetI9wxQwHiGmVd/tOT/OPhh6+vpHuIzCq67uU0oPCIVc0VZ2z
 V2bwh3WYO69i3xqtJRqXAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THgu8K020363; Thu, 29 May 2025 19:24:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRJ022158;
 Thu, 29 May 2025 19:24:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-17; Thu, 29 May 2025 19:24:53 +0000
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
Subject: [PATCH V4 16/43] pci: skip reset during cpr
Date: Thu, 29 May 2025 12:24:12 -0700
Message-Id: <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: q6_F938Qc9iCsODVGOVaSY_nWfbvZZ8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXwGmuHA0VUa4G
 B2nGt/0SFQc40hD5SEXskmdf1Umt32onywPIx84Dl6qyecRlZBr8lGT6nbZjHUxk0SX63MWYOYm
 Qc0vqI+SYRh/UPzeRVsjB/7J2kTNJUPI/OmhlJePjOo5XyA8J75sdWNF7s6llgT78c3eYp8gwOK
 q8Nm6hBHeS98rL3NOmXqhNArHeiCv1dIQdgvyJbfpr0kBmmhw1/sIgwLPm+amFy1PqucYf6GW0b
 SQY73EDRBZ2Z18iyYCup7h2rNqmf0bNLH6sylQki3LEgUys1dxxhoQxMd4Vxo1p9uNoUqGGKlQS
 vh+rH1ER/Z1TUzKJ4v7gSxsZ7NlS38yukizSnWDzS2RMGg15LjP/B5d/PyZtfzmb6Hn0sxpEyDF
 +FzcZ1DOEek33mlQ7sdSHksUXyummHZGXb+47FrZpnHsykXl4pb0Nv8rZc2x8hNL1E5mm0Jb
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b487 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=9sbxz00wAFZublB0PowA:9
X-Proofpoint-ORIG-GUID: q6_F938Qc9iCsODVGOVaSY_nWfbvZZ8L
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
 include/hw/pci/pci_device.h | 3 +++
 hw/pci/pci.c                | 5 +++++
 hw/vfio/pci.c               | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index e41d95b..b481c5d 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -181,6 +181,9 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /* CPR */
+    bool skip_reset_on_cpr;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510..21eb11c 100644
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
@@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
 
 static void pci_do_device_reset(PCIDevice *dev)
 {
+    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7d3b9ff..56e7fdd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3402,6 +3402,13 @@ static void vfio_instance_init(Object *obj)
     /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
      * line, therefore, no need to wait to realize like other devices */
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+
+    /*
+     * A device that is resuming for cpr is already configured, so do not
+     * reset it during qemu_system_reset prior to cpr load, else interrupts
+     * may be lost.
+     */
+    pci_dev->skip_reset_on_cpr = true;
 }
 
 static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
-- 
1.8.3.1


