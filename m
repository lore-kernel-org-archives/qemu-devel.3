Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4CEC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQHF-0003vF-5Y; Mon, 14 Jul 2025 16:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubOk8-0008CH-Ac
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:21:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubOk5-00080i-0C
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:21:40 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGoGQ4026735;
 Mon, 14 Jul 2025 19:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=mhrRcNGI
 0gDZ/gk/VphnZlX1PzSw52CrVs8CCFG2lrs=; b=bSmAkg5VCRoQg9QV2VkUgFZZ
 NUmKFq4ZrEEGItB0+4i0GkeARg5B+LdrKO1zfYtFxK/G/+e4xbkAyLSrKLdQWEHx
 +HrG88EYVzQHmG2LAa1Gi0CgQUBWIpdXObK7uOwCHp4x/n/GE23TxE/X2HdtmJdj
 AaBBPze6C5TRj7BKTmKP4oxe4yUkmHnbMzG9Ooakj9W8vYqhhdHhj+70w6YuoIdr
 bZvms6Uz4x0RvxU3m3/Pd1Vm9DPUmhFuSSxO5zK5pMWHQjF7vXz/wn7vKpzYo6PU
 MkQcv1pqvIZ8RsgauC5lASQBjyu2smuv5GUg4C7sMa2PiVj5zPaD1oFA9F1fxA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf5d8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 19:21:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EHhCUQ010901; Mon, 14 Jul 2025 19:21:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58ymjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 19:21:31 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EJLVFJ008168;
 Mon, 14 Jul 2025 19:21:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58ymj8-1; Mon, 14 Jul 2025 19:21:31 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1] vfio: fix sub-page bar after cpr
Date: Mon, 14 Jul 2025 12:21:30 -0700
Message-Id: <1752520890-223356-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140126
X-Proofpoint-GUID: vEJRLgXMIESLI3XyTuRFD0-S9Fj3U6N9
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687558bc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=Dgv3TXsNM4mSNUuXrVQA:9 cc=ntf
 awl=host:12062
X-Proofpoint-ORIG-GUID: vEJRLgXMIESLI3XyTuRFD0-S9Fj3U6N9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEyNiBTYWx0ZWRfX4xglSp810Emw
 okbgMWozNiOal0uqZNsQ0sjC+XKPFN7sDz7LnPrRKjleV6XUQifuaEZc3j2rdvriDe5W3DDidcv
 k3ikdcggOe+hJOPiM9CYlQSv6SIJbQJbLayYu+Ahsf56EONo98ry4JWCY0aaEdVeO/NS87erUFw
 rSFVeqERclpQVdTsuFrbtqOaLGSJuhbkRCZLx9gH+bmPYOPeY7nUbe4CS7FKMFmDEHJzKWjs4rQ
 sRAXiwdlE9Z2YlknDNOLYnrQoR72+AmH8Vgmp0SV8bOtBKSsmEXEcj+Nu0uDcv3atARKVEIg4X6
 MaRaaJWGiqmJhAqjpeRwAXJak1zR03MuxPM2zeFNClodEiTyzSXVoKuI4QfF7iWG+wXsu/OTU6N
 7PvtvEWxq2ACq3/77YrF0gvBsEnm91kDhpbwTCxG5n59ekubVonNVPS7Z1z/15z0vBzJjZ6g
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


