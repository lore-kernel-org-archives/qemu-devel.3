Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE5CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 20:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQ1N-0000CN-UF; Mon, 14 Jul 2025 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubOX0-0001Mv-KE
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:08:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubOWw-00061I-Kc
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:08:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGv9Dv019054;
 Mon, 14 Jul 2025 19:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=mhrRcNGI
 0gDZ/gk/VphnZlX1PzSw52CrVs8CCFG2lrs=; b=N8fiNVMU/kWYqa4ZPId4QMWV
 WeJmpz/xthTClXkMP/JHGWka0TrzdRzOY4ZPSNV07lKPxaKUSY8QQovYc0RBqGJl
 2EgiQD+6d05qqmyYVMCOjfW5eZNlPdZDI5M9dBwXYqrGAQxXtKtx6y+q938vHnDE
 gs3riOGPM7YM0oYVR+WFtra+1SoYIFaj0dZf4R271W8yaUps+Gh/3G+S+ue2dk21
 CVYvkyPC4J1m8aa8D/b0mVESWSyaKfyE409nZkefe5VANX1aj8TKsvnOhr8WB2M1
 Mnu52WipjeuO0PtsTpy9LbKeyLsm4NZCN/1REdNXGD1xExFSWC8Uk5ZiWHFCPw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1avygp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 19:07:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EIUC4k013741; Mon, 14 Jul 2025 19:07:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58fb7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 19:07:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EJ7wBE032364;
 Mon, 14 Jul 2025 19:07:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58fb7g-1; Mon, 14 Jul 2025 19:07:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH 59/59] vfio: fix sub-page bar after cpr
Date: Mon, 14 Jul 2025 12:07:57 -0700
Message-Id: <1752520077-223287-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEyNCBTYWx0ZWRfX36Ax6vKd25EU
 OWANjBCpkBlid2Ctn1aBeVZ6/3vm8JQtn5rZPih8PkCp/iD8UQ4RKiQ6REb0T6aL5/3yiIZ0Rgs
 4QcFF1IqCmbjH9Vau40KRn6iObeenM4itr/c8/KXpH7+X9YcJ15vJdHugboeuV2WtG5W3dQhvmK
 qwhBIDGeAKf7QjlmMhUtXofDkDWdZS5kGpCed4VTmpbcQK09MBiVe+ExYGIgsMHO30oR48w5PUM
 2bVj+k6jKWjj9pUo/k6lPxRlE6PZiC3JS3e8kjAi6JJg7qhl1LcG375a37v2ifMMdybM13mkMKt
 22hd5+e3bJ+zrVRrAoJ2MBeXKX8yfvfuiWlSZR8JnidNy+UVhCsBLtHX2ZiXuPAMU9DeEAHUIVw
 VKpTUQeOb0c+xrSnlPXsIlSP5xilox46V2JVoEm08WRVJvHmpY8j09cOtVMpYjghNBfDAZoX
X-Proofpoint-GUID: 0rCqLWBwR71PCQFHbBxk8bqHOEkJCtW7
X-Proofpoint-ORIG-GUID: 0rCqLWBwR71PCQFHbBxk8bqHOEkJCtW7
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6875558f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=Dgv3TXsNM4mSNUuXrVQA:9 cc=ntf
 awl=host:12061
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Regions for sub-page BARs are normally mapped here, in response to the
guest writing to PCI config space:

  vfio_pci_write_config()
    pci_default_write_config()
      pci_update_mappings()
        memory_region_add_subregion()
    vfio_sub_page_bar_update_mapping()
      ... vfio_dma_map()

However, after CPR, the guest does not reconfigure the device and the
code path above is not taken.  To fix, in vfio_cpr_pci_post_load, call
vfio_sub_page_bar_update_mapping for each sub-page BAR with a valid
address.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/cpr.c |  2 ++
 hw/vfio/pci.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 495fae7..cb1310d 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -228,6 +228,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
+void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index af0f12a..384b56c 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -116,6 +116,8 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
     PCIDevice *pdev = &vdev->pdev;
     int nr_vectors;
 
+    vfio_sub_page_bar_update_mappings(vdev);
+
     if (msix_enabled(pdev)) {
         vfio_pci_msix_set_notifiers(vdev);
         nr_vectors = vdev->msix->entries;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28..9c616bd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2826,6 +2826,20 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     return ret;
 }
 
+void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    int page_size = qemu_real_host_page_size();
+    int bar;
+
+    for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
+        PCIIORegion *r = &pdev->io_regions[bar];
+        if (r->addr != PCI_BAR_UNMAPPED && r->size > 0 && r->size < page_size) {
+            vfio_sub_page_bar_update_mapping(pdev, bar);
+        }
+    }
+}
+
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
-- 
1.8.3.1


