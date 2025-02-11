Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6290C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu9b-0007qU-EE; Tue, 11 Feb 2025 12:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1thszz-00056g-P2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:20:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1thszx-0002Cp-Vt
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:20:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BE2UZA023490;
 Tue, 11 Feb 2025 16:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=i5vMH/K2F3RkNAWQpt2X9Urz9Lfo+j0C/JQ/+pHJW
 +g=; b=LXuHIAl72PEr/S5BPJ9uHdgMyS/w7br0n2L/UXGahhUkCi582VlLmX9ln
 MxsFxGUMrUUHeT6fl4HYTb8ITHNpa9G6TH6fkQkP2nPoYev0y827X9xBmIxxM7OI
 Q4Pz3PlNGw5OWXIPFiqfe8U7rwtEViRY57oon2AiBk2ws9T9e3ytutq7eNQCCybl
 mZkhkUeS1v9P/1IDHiLIDOC0H3GqvXQowaepJ8ElIHbHqk85609Yt3jcXrZs1h9q
 7JHJp8Yn+raw4EKbqZZcMpX3nsFmo6oXFz9RnYvWoRM3h+iFluWWUg50ZLL6/c4e
 /T54wOL4PSKuU/LsvZPwSCt+672mQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qtkac38v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 16:20:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51BCM3fE021672;
 Tue, 11 Feb 2025 16:20:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksm916-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 16:20:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51BGKSDr24838634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 16:20:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A557258062;
 Tue, 11 Feb 2025 16:20:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E7665805A;
 Tue, 11 Feb 2025 16:20:28 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.104.243])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Feb 2025 16:20:28 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH] vdpa: Fix endian bugs in shadow virtqueue
Date: Tue, 11 Feb 2025 10:20:10 -0600
Message-Id: <20250211162010.1478402-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ij2aURy9evwQzm6xMhHl7tMNKse4z5m
X-Proofpoint-ORIG-GUID: 4ij2aURy9evwQzm6xMhHl7tMNKse4z5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=494 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Feb 2025 12:34:14 -0500
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

VDPA didn't work on a big-endian machine due to missing/incorrect
CPU<->LE data format conversions.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 37aca8b431..b3c83f0dfa 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -157,7 +157,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     for (n = 0; n < num; n++) {
         if (more_descs || (n + 1 < num)) {
             descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
-            descs[i].next = cpu_to_le16(svq->desc_next[i]);
+            descs[i].next = svq->desc_next[i];
         } else {
             descs[i].flags = flags;
         }
@@ -165,7 +165,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = cpu_to_le16(svq->desc_next[i]);
+        i = le16_to_cpu(svq->desc_next[i]);
     }
 
     svq->free_head = le16_to_cpu(svq->desc_next[last]);
@@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     smp_mb();
 
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        uint16_t avail_event = *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]);
+        uint16_t avail_event = le16_to_cpu(
+                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
         needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
     } else {
-        needs_kick = !(svq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
+        needs_kick =
+                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
     }
 
     if (!needs_kick) {
@@ -365,7 +367,7 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
         return true;
     }
 
-    svq->shadow_used_idx = cpu_to_le16(*(volatile uint16_t *)used_idx);
+    svq->shadow_used_idx = le16_to_cpu(*(volatile uint16_t *)used_idx);
 
     return svq->last_used_idx != svq->shadow_used_idx;
 }
@@ -383,7 +385,7 @@ static bool vhost_svq_enable_notification(VhostShadowVirtqueue *svq)
 {
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         uint16_t *used_event = (uint16_t *)&svq->vring.avail->ring[svq->vring.num];
-        *used_event = svq->shadow_used_idx;
+        *used_event = cpu_to_le16(svq->shadow_used_idx);
     } else {
         svq->vring.avail->flags &= ~cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
     }
@@ -449,7 +451,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
     num = svq->desc_state[used_elem.id].ndescs;
     svq->desc_state[used_elem.id].ndescs = 0;
     last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
-    svq->desc_next[last_used_chain] = svq->free_head;
+    svq->desc_next[last_used_chain] = cpu_to_le16(svq->free_head);
     svq->free_head = used_elem.id;
     svq->num_free += num;
 
-- 
2.34.1


