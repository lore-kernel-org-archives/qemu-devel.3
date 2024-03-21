Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8EDCD11C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKnd-0002j1-3e; Thu, 21 Mar 2024 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rnKnY-0002fD-Hq; Thu, 21 Mar 2024 11:57:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rnKnR-00041k-Ka; Thu, 21 Mar 2024 11:57:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42LCmNvw019770; Thu, 21 Mar 2024 15:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=0RgSlsTyJanzxmqU381z1Axh2X0OQKN7rdlzlu7v0Js=;
 b=Y0iWGVnyARJO2fz4CDWtBhIjDjMtX1840Lp9hImTfTe48KY+JA2bYIe0yQKGN4JHFjrX
 +1cYm/SX2rdpuJD242NmFnVIyKvozfBNJxAkhOWIIuosEbkNqbdMCgCNJVXVZsy1IH3z
 uiQP2lE4zAM0hefTNQJhc31AB9QbQh79p3lrWRflJu6tyBjFI68XQSZSw5+KSanS3pUT
 nisQlwVHV6i8tVpXabQ+f9Pcyt6Avogbcn+LRO8TvF6WE3/oeEjQatOhBAEOOLjyEHyz
 aApR/MEXkUQcZoqeUA2Rmw3/x5y61PjJgJ2f2ABAuRXwdL6EGqGqhnGMVu/mFmc1DhMb pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udjrbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 15:57:26 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42LFZ6ka006215; Thu, 21 Mar 2024 15:57:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v9q1s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 15:57:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LFsWZM005094;
 Thu, 21 Mar 2024 15:57:24 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-211-118.vpn.oracle.com
 [10.39.211.118])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3ww1v9q1p9-4; Thu, 21 Mar 2024 15:57:24 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 3/8] virtio: Define order variables
Date: Thu, 21 Mar 2024 11:57:12 -0400
Message-Id: <20240321155717.1392787-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321155717.1392787-1-jonah.palmer@oracle.com>
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210115
X-Proofpoint-GUID: ZhbczsySTRt-976NfNnGQkwi8BxwXLr0
X-Proofpoint-ORIG-GUID: ZhbczsySTRt-976NfNnGQkwi8BxwXLr0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define order variables for their use in a VirtQueue's in-order hash
table. Also initialize current_order variables to 0 when creating or
resetting a VirtQueue. These variables are used when the device has
negotiated the VIRTIO_F_IN_ORDER transport feature.

A VirtQueue's current_order_idx represents the next expected index in
the sequence of VirtQueueElements to be processed (put on the used
ring). The next VirtQueueElement to be processed must match this
sequence number before additional elements can be safely added to the
used ring.

A VirtQueue's current_order_key is essentially a counter whose value is
saved as a key in a VirtQueueElement. After the value has been assigned
to the VirtQueueElement, the counter is incremented. All
VirtQueueElements being used by the device are assigned a key value and
the sequence at which they're assigned must be preserved when the device
puts these elements on the used ring.

A VirtQueueElement's order_key is value of a VirtQueue's
current_order_key at the time of the VirtQueueElement's creation. This
value must match with the VirtQueue's current_order_idx before it's able
to be put on the used ring by the device.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c         | 6 ++++++
 include/hw/virtio/virtio.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d2afeeb59a..40124545d6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -155,6 +155,8 @@ struct VirtQueue
 
     /* In-Order */
     GHashTable *in_order_ht;
+    uint16_t current_order_idx;
+    uint16_t current_order_key;
 };
 
 const char *virtio_device_names[] = {
@@ -2103,6 +2105,8 @@ static void __virtio_queue_reset(VirtIODevice *vdev, uint32_t i)
     if (vdev->vq[i].in_order_ht != NULL) {
         g_hash_table_remove_all(vdev->vq[i].in_order_ht);
     }
+    vdev->vq[i].current_order_idx = 0;
+    vdev->vq[i].current_order_key = 0;
     virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
 }
 
@@ -2357,6 +2361,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
             g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
                                   free_in_order_vq_element);
     }
+    vdev->vq[i].current_order_idx = 0;
+    vdev->vq[i].current_order_key = 0;
 
     return &vdev->vq[i];
 }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8aa435a5e..f83d7e1fee 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -75,6 +75,7 @@ typedef struct VirtQueueElement
     hwaddr *out_addr;
     struct iovec *in_sg;
     struct iovec *out_sg;
+    uint16_t order_key;
 } VirtQueueElement;
 
 typedef struct InOrderVQElement {
-- 
2.39.3


