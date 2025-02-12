Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A4C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFvx-0004Of-DO; Wed, 12 Feb 2025 11:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiFvr-0004NX-10
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:49:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiFvp-0004RD-7c
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:49:50 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CBQgH9013867;
 Wed, 12 Feb 2025 16:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=kAw+mTasQsiVtApU5TkW6YM2hvy+ebRCq1yUN4WdW
 L0=; b=KYQBIerQ6bieEUahh0QR7slOPZQXaE9b2QptOb0cEetDCOeCxwBuhm40a
 nASabAHxlMsfMg5eVk9PaT9OjKEvQzeNjr0aSzGj/oLA5VK+AOPTiHq89dk3qmi7
 Of+spOZGyeSs3UNT5Lmitaut19gdwflE1AjMJJ1NcVcNQesKXpDeDNbt5VHYDqeO
 cNtqcs5iwyTWCc9xVB49v0VHYEA/M6YhdTgHCAzevHq5sRxW6FpJy9RqKIpOt5Mq
 rGAWhiZ0nX/A3B9SGLVeCUCoJetZ8ItAvLAwm6veufSrL7XJnJBSuLqWC2yRI0O7
 jUEsRDohQNGwsvt807+ltWpHj63Xg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rjfyv7ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 16:49:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFi4FS000914;
 Wed, 12 Feb 2025 16:49:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkn9uhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 16:49:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51CGnjqq19071738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 16:49:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2B295805C;
 Wed, 12 Feb 2025 16:49:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB9B35805E;
 Wed, 12 Feb 2025 16:49:44 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.104.243])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Feb 2025 16:49:44 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
Date: Wed, 12 Feb 2025 10:49:23 -0600
Message-Id: <20250212164923.1971538-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2EIMEAPs2Bm85WTD_hNtlwtZ3JsZT-A
X-Proofpoint-ORIG-GUID: B2EIMEAPs2Bm85WTD_hNtlwtZ3JsZT-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=574
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VDPA didn't work on a big-endian machine due to missing/incorrect
CPU<->LE data format conversions.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
Changes in v2: Change desc_next[] from LE format to "CPU".

 hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 37aca8b431..4af0d7c669 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -165,10 +165,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = cpu_to_le16(svq->desc_next[i]);
+        i = svq->desc_next[i];
     }
 
-    svq->free_head = le16_to_cpu(svq->desc_next[last]);
+    svq->free_head = svq->desc_next[last];
     return true;
 }
 
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
@@ -408,7 +410,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
     for (uint16_t j = 0; j < (num - 1); ++j) {
-        i = le16_to_cpu(svq->desc_next[i]);
+        i = svq->desc_next[i];
     }
 
     return i;
@@ -683,7 +685,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     svq->desc_next = g_new0(uint16_t, svq->vring.num);
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
-        svq->desc_next[i] = cpu_to_le16(i + 1);
+        svq->desc_next[i] = i + 1;
     }
 }
 
-- 
2.34.1


