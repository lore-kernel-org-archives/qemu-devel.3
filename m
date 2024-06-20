Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKM1x-00005J-OB; Thu, 20 Jun 2024 13:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sKM1S-0007yv-3m; Thu, 20 Jun 2024 13:56:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sKM1Q-0005Xc-5i; Thu, 20 Jun 2024 13:56:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHB9EW023427;
 Thu, 20 Jun 2024 17:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=DndsFHsHR7J6NPY3U3Rb2ZgwIcGLUjnmM0lSV80Nlg4=; b=
 kRYyahRdF8UateiGg9pDE1ktiIsrXGiLw+WZ4U7A2GCzNvLdKShJymkJ6cAfL0ka
 NnE/KK8oF/qQw6mn6kp8CJFxc8gfk6lsiRi3nKuhnoRSpH/6ja8VNsDnsc7YVrrY
 xlndWs3nONMlGgaXyDfqL5QrTMxnERht4/vB2dqwMfXagGltTe0t21kZFYKOmRwe
 Qq+JfFkYox3MMd7Qk9uMxPUnqcc/v8QMI43nPSwhIBajd4nlXyk3CYeRAeG1dgQj
 choaV1oDxGu20+2tz0CMozpvICgcOMLOVBEwUUiQTP61dLkUQjd2+VG7qytF7ypv
 SQR06kqaJTChoAVa/Zl5NA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrktr2vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2024 17:56:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45KHDrMH012893; Thu, 20 Jun 2024 17:56:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yvrn3hnq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2024 17:56:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45KHuF0p018715;
 Thu, 20 Jun 2024 17:56:22 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-208-85.vpn.oracle.com
 [10.39.208.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3yvrn3hnjv-4; Thu, 20 Jun 2024 17:56:21 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 3/6] virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER
 support
Date: Thu, 20 Jun 2024 13:56:07 -0400
Message-ID: <20240620175612.2381019-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175612.2381019-1-jonah.palmer@oracle.com>
References: <20240620175612.2381019-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200129
X-Proofpoint-GUID: _-eXCp0qLDT_wyHm5Pvj21ccKOcet7QX
X-Proofpoint-ORIG-GUID: _-eXCp0qLDT_wyHm5Pvj21ccKOcet7QX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add VIRTIO_F_IN_ORDER feature support for the virtqueue_fill operation.

The goal of the virtqueue_ordered_fill operation when the
VIRTIO_F_IN_ORDER feature has been negotiated is to search for this
now-used element, set its length, and mark the element as filled in
the VirtQueue's used_elems array.

By marking the element as filled, it will indicate that this element has
been processed and is ready to be flushed, so long as the element is
in-order.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9cbf75f021..e1dfec4655 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -873,6 +873,46 @@ static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
     vq->used_elems[idx].ndescs = elem->ndescs;
 }
 
+static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
+                                   unsigned int len)
+{
+    unsigned int i, steps, max_steps;
+
+    i = vq->used_idx;
+    steps = 0;
+    /*
+     * We shouldn't need to increase 'i' by more than the distance
+     * between used_idx and last_avail_idx.
+     */
+    max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
+
+    /* Search for element in vq->used_elems */
+    while (steps <= max_steps) {
+        /* Found element, set length and mark as filled */
+        if (vq->used_elems[i].index == elem->index) {
+            vq->used_elems[i].len = len;
+            vq->used_elems[i].in_order_filled = true;
+            break;
+        }
+
+        i += vq->used_elems[i].ndescs;
+        steps += vq->used_elems[i].ndescs;
+
+        if (i >= vq->vring.num) {
+            i -= vq->vring.num;
+        }
+    }
+
+    /*
+     * We should be able to find a matching VirtQueueElement in
+     * used_elems. If we don't, this is an error.
+     */
+    if (steps >= max_steps) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s cannot fill buffer id %u\n",
+                      __func__, vdev->name, elem->index);
+    }
+}
+
 static void virtqueue_packed_fill_desc(VirtQueue *vq,
                                        const VirtQueueElement *elem,
                                        unsigned int idx,
@@ -923,7 +963,9 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
         return;
     }
 
-    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        virtqueue_ordered_fill(vq, elem, len);
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
         virtqueue_packed_fill(vq, elem, len, idx);
     } else {
         virtqueue_split_fill(vq, elem, len, idx);
-- 
2.43.0


