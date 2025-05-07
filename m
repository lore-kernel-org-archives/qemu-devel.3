Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C61C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjni-0001yz-09; Wed, 07 May 2025 14:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnf-0001y5-Fc
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnd-0004rt-Nf
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ILesQ019152;
 Wed, 7 May 2025 18:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=inSdFHTZqll/ELRTFQFvLQ6JO6NAa9LRNkPEELZwvm0=; b=
 aUo1zM2FSKQl9G1KsP4uJcg0A8hzBVqu6IcQoHG0+cLn/0/JlBtK44T2ffWkj39i
 Gveyvc/cOkL/DWvU4N/bjA8NW94Fam/Pb2oGmaNr5KBnE6pjHjkfIG/BI8T9vywo
 cci33dXedItdeHbX/QwgsbOIPxumZYBfntKPslnlSZPlGmbUV1hLpV3d45eIYSOV
 ZcuovU18lYwLhCyp8xswt7DOLufNZwBgCrtzQFENpPEln9fom0GjlP6K2SlPAqhU
 E5gNJ/Bb81fmf7jKs51+UrvVzUDwclvKSw7noxGnpW/4tfV+OpaIHGQsKkmqgxb/
 mOyTm888w3/JqvREuTRqdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcqrg23w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547HEpCG036077; Wed, 7 May 2025 18:47:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhddg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:16 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3j3029452;
 Wed, 7 May 2025 18:47:16 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-5; Wed, 07 May 2025 18:47:15 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 4/7] vdpa: add listener_registered
Date: Wed,  7 May 2025 14:46:44 -0400
Message-ID: <20250507184647.15580-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-GUID: ZDLnhhriTdObhfa0G0kiOTuKlbBMD8D7
X-Authority-Analysis: v=2.4 cv=aJHwqa9m c=1 sm=1 tr=0 ts=681baab5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=A0p2AJybNqWLN923ewAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZDLnhhriTdObhfa0G0kiOTuKlbBMD8D7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfXy/oGI1dO/We6
 UnpfrlnwfgzhdcQTf240gP4dZxTHoHI6dH2JDFrgitFhIByG182XPJGwj6Hhp7iDuDuwRPdEk4E
 pRvpzVZB/H+ARi60GhXHyF2BysFbdwCynhvkZGfXYkjO3x/hsX4+8SDEcg7NWyU8QQV2Y+Ydv4q
 si+h9v9S85p1o56/Ll9ynVTEaKqBT3CUqB5a2vhMR57gh3xkkHIQJAsQkvtuh0QE9BxKOwHgLCR
 ZVRtMD+TbyJBHglv9EHHa3OQJ17L0Jic3EhULzUIU+1fEF8xb5yN7B9FkJOOvmhqn3fNupIQuo3
 aiBp8PTI6xwXF+BpxZ493Cv1RsstFt6Vno2OSnu4UI+obbqKKpy/9TBxBkrRFM0UcdHc1PRiI2v
 B3HPYU8F2TM5XuuMMU3YCyGT4hO1/I5xb1oS/dGzicIrtUaHVMl+SfXw16u6n+CfwkKS+ebD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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

From: Eugenio Pérez <eperezma@redhat.com>

Check if the listener has been registered or not, so it needs to be
registered again at start.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-vdpa.c         | 7 ++++++-
 include/hw/virtio/vhost-vdpa.h | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e9826ede2c..450f68f117 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1379,7 +1379,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
-        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+        if (!v->shared->listener_registered) {
+            memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+            v->shared->listener_registered = true;
+        }
 
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
@@ -1399,6 +1402,8 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
     memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
+
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 0a9575b469..221840987e 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -51,6 +51,12 @@ typedef struct vhost_vdpa_shared {
 
     bool iotlb_batch_begin_sent;
 
+    /*
+     * The memory listener has been registered, so DMA maps have been sent to
+     * the device.
+     */
+    bool listener_registered;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 
-- 
2.43.5


