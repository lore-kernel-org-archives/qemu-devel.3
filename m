Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5927FC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4gP-0005gG-9u; Fri, 14 Mar 2025 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4gB-0005dp-Kb
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g7-0005w6-9P
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBloP7009747;
 Fri, 14 Mar 2025 13:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rpWaMipMYDlKwtXl+4qKcREqCJEd9xxu4Vacys2P/jc=; b=
 PhLvJz3Vni6TIpLHf21FWRR2nYog1AJ1N14z7Rcs5aNpf4jlfGVCd67yeNZo6fuE
 LYO7xDrm0fg2YibkagVFjjEt+v7+pnO7XHe/1OqXd/on1O9OXirHj2dcEdpgvmGp
 t6iEm33fxVKuQbo71dM5ZK4DqqrSHCK6XhDrcaw65tDzCy0mT7QmZJhyKlimeIns
 076E/3rMFfUk0MVW/YPKmWqv2ldSn3VKR4DPR+DgXjbvD7nqhONKPjXeMfhDWngb
 E6E8jkdmzJWEoZpV6fJtMynsbls4qBE/BSp/R8z6SmyCjpb8OIdpE87s11O5sCxq
 fr0Er+B5X5UAnGyKsSDJPg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dxcar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52EBA6Mp012293; Fri, 14 Mar 2025 13:02:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn41d4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52ED27RF015104;
 Fri, 14 Mar 2025 13:02:12 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-73-135.usdhcp.oraclecorp.com [10.43.73.135])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45atn41d05-5; Fri, 14 Mar 2025 13:02:11 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowant@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 4/7] vdpa: add listener_registered
Date: Fri, 14 Mar 2025 09:01:51 -0400
Message-ID: <20250314130204.11380-5-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314130204.11380-1-jonah.palmer@oracle.com>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140103
X-Proofpoint-GUID: 3ybyFl4B062erae94xcyz1TOW4RUNqux
X-Proofpoint-ORIG-GUID: 3ybyFl4B062erae94xcyz1TOW4RUNqux
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
index 939a5a28a1..61a0e8fdbd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1381,7 +1381,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
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
@@ -1401,6 +1404,8 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
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


