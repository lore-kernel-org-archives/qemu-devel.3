Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA541C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKna-0002gB-KV; Thu, 21 Mar 2024 11:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rnKnW-0002ek-L3; Thu, 21 Mar 2024 11:57:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rnKnO-0003zR-DB; Thu, 21 Mar 2024 11:57:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42LCmNMA011460; Thu, 21 Mar 2024 15:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=YBpbq+eDeJsGBl0b6Qvkqprtz5A/f7rcY7U4sBsYqDQ=;
 b=k2AFlti4Vre/10uwluJdtRFmZHSL6mf9VQW6xjZh3D73QGVQ7OnLuyRN0qaGBvbcxbXw
 B4IUscr6QOQdXN/xFi2/ESeb5Tu9nZBsXqF/D6cE7P4naFp+4VZJYf2nRb2DkWahAwzK
 SKxusC+Q5wimMlsVcX+L/R7PSKAvFiNQgtg0DRAceu2us26UXoW2XGK8LzV6f2OeeiJY
 t2Dyo3XvF+YMabfutKmN8zgg+iZeMh2I8ZWDKPNUUfPmEtu/0gXUWY1s/GtXX3N6pCxH
 HeKFzUiO3GDNgLo7IlglBWJlZN375nt/P1rocm9Rw7Xsm+GoGTyYUlgOm9rsJSgJ3qzk rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31ttvm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 15:57:24 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42LFqO48006075; Thu, 21 Mar 2024 15:57:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v9q1re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 15:57:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LFsWZK005094;
 Thu, 21 Mar 2024 15:57:23 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-211-118.vpn.oracle.com
 [10.39.211.118])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3ww1v9q1p9-3; Thu, 21 Mar 2024 15:57:23 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 2/8] virtio: Create/destroy/reset VirtQueue In-Order hash table
Date: Thu, 21 Mar 2024 11:57:11 -0400
Message-Id: <20240321155717.1392787-3-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: uFjWnBx8ocfpT_lRkvupUBokq0KDzNBJ
X-Proofpoint-GUID: uFjWnBx8ocfpT_lRkvupUBokq0KDzNBJ
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

Define a GLib hash table (GHashTable) member in a device's VirtQueue
and add its creation, destruction, and reset functions appropriately.
Also define a function to handle the deallocation of InOrderVQElement
values whenever they're removed from the hash table or the hash table
is destroyed. This hash table is to be used when the device is using
the VIRTIO_F_IN_ORDER transport feature.

A VirtQueue's in-order hash table will take in a uint16_t key with a
InOrderVQElement value as its key-value pair.

The hash table will be used as a buffer mechanism for completed,
out-of-order VirtQueueElements until they can be used in the same order
in which they were made available to the device.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..d2afeeb59a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -152,6 +152,9 @@ struct VirtQueue
     EventNotifier host_notifier;
     bool host_notifier_enabled;
     QLIST_ENTRY(VirtQueue) node;
+
+    /* In-Order */
+    GHashTable *in_order_ht;
 };
 
 const char *virtio_device_names[] = {
@@ -2070,6 +2073,16 @@ static enum virtio_device_endian virtio_current_cpu_endian(void)
     }
 }
 
+/* 
+ * Called when an element is removed from the hash table
+ * or when the hash table is destroyed.
+ */
+static void free_in_order_vq_element(gpointer data)
+{
+    InOrderVQElement *elem = (InOrderVQElement *)data;
+    g_free(elem);
+}
+
 static void __virtio_queue_reset(VirtIODevice *vdev, uint32_t i)
 {
     vdev->vq[i].vring.desc = 0;
@@ -2087,6 +2100,9 @@ static void __virtio_queue_reset(VirtIODevice *vdev, uint32_t i)
     vdev->vq[i].notification = true;
     vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
     vdev->vq[i].inuse = 0;
+    if (vdev->vq[i].in_order_ht != NULL) {
+        g_hash_table_remove_all(vdev->vq[i].in_order_ht);
+    }
     virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
 }
 
@@ -2334,6 +2350,13 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
     vdev->vq[i].handle_output = handle_output;
     vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
+    vdev->vq[i].in_order_ht = NULL;
+
+    if (virtio_host_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        vdev->vq[i].in_order_ht =
+            g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+                                  free_in_order_vq_element);
+    }
 
     return &vdev->vq[i];
 }
@@ -2345,6 +2368,10 @@ void virtio_delete_queue(VirtQueue *vq)
     vq->handle_output = NULL;
     g_free(vq->used_elems);
     vq->used_elems = NULL;
+    if (virtio_host_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        g_hash_table_destroy(vq->in_order_ht);
+        vq->in_order_ht = NULL;
+    }
     virtio_virtqueue_reset_region_cache(vq);
 }
 
-- 
2.39.3


