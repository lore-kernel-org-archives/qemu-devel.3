Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691CFC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AFL-0003tj-NU; Thu, 03 Sep 2026 12:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFJ-0003su-U9; Thu, 03 Sep 2026 12:25:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFH-0006Ut-Ct; Thu, 03 Sep 2026 12:25:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G37fV2293550; Thu, 3 Sep 2026 16:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+hMlmJY+J26UFND8N
 nuXaqfbWV3kHEmcb9fqKreviBA=; b=MKpFdB5Zci+1dy2qYl7BXowYnnW4kU7EX
 /m3KTUIk9cMTIeHCIt00eQ8+LVR9F4TQiApjg09gKkgwQ/HsIzvbanFXzCZHNq15
 tTN/AULK4rzK6/MRcKw13FkK5T8CKoy0j7EUVtN3ITUS0BzuKsBEAexvOOLCyxXd
 Ni/ugFYBzm4mgZd/x2EbBo3AuR0aoNXvtMXaM7Tvs9ashI6Mmy+lp3+husWfyvnw
 sC+kaKSEMrLaIX08xFpVO+tNdzCw4/8nWXpGV2+Req7oANXoJ+fjSZqD1qJEHyQj
 xFX2cu77DOwL4Cr9rWzYMzteO5dMdiGQ/VhayndgXpGB66llPnAjw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue5fcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:24:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GBcbx002709;
 Thu, 3 Sep 2026 16:24:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyg8bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:24:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GOuDu27722248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:24:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02B1558043;
 Thu,  3 Sep 2026 16:24:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BE495805D;
 Thu,  3 Sep 2026 16:24:54 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:24:54 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, jdaley@linux.ibm.com,
 pbonzini@redhat.com
Subject: [PATCH v2 2/7] pc-bios/s390-ccw: Add dynamic net header size handling
Date: Thu,  3 Sep 2026 12:24:44 -0400
Message-ID: <20260903162449.2588271-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903162449.2588271-1-zycai@linux.ibm.com>
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -_Y7AkZ6RXtdwV5Y5BXLzz6xx7dMK480
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX72jNzsNVm2RJ
 2LXQYGn9VhNCBVSzbJVpAeSS+7820PZEwJnBS7y8N+VglWCFIUiIKT7CfoGP02knsQK09tUS7ir
 R83GMzT2jxUT64eNnA5XYoVLEwlYa0O6fModLesAlFxBtoWAzXAweFQOqLcPXcTUQDwTEQAEJZG
 JJfLYQ1OR11lCakwggUxRqnuphUmp61cqivDyYD/boOR3cuRBiqo6KolXv4PplrMimDp0Bjf4+6
 t2Luy1N6nDj7m3sgRDy2SrQ+bUUa7zwKFwFd6k/aen058abPZw6yZQw286BgrPj0M1CX32axuQc
 O21g45/BjsxtjhC7+0JfOS4/9XopmMQzgyLra0yLD/Aq8Wleyypy0JpO6Z2rxFLfJy/PLXdVBQf
 rJYcZLmCZDWky22iKo41/5WLGWU513zoHprBHecxjAJgy+eug8QxxWHiqB27w8F7GjdpA1lfN3P
 4xSQlBAkaJHGoxmv51Q==
X-Proofpoint-ORIG-GUID: -_Y7AkZ6RXtdwV5Y5BXLzz6xx7dMK480
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX69QePG3O7mm6
 ruORExGVp5MKfpirm6ERkoJ3TWSrZY2mS0sP20Mpu2s+F0uVXuTiN0VT0ygGewZQPQmiK9f8HWg
 eN9OdjzaHz5cCIbz8bBdNh0bUWJQVhs=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a999f5a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=b71jbalOAXEqY8vE3Q8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The virtio-net device used a fixed header size that did not account for
the num_buffers field used in VirtIO 1.0 or for the mergeable receive
buffers feature.

Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
VirtIO 1.0 or when VIRTIO_NET_F_MRG_RXBUF is enabled. This ensures
correct packet handling across different VirtIO configurations.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-net.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index f58f7ffc55..afa728bc32 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -20,6 +20,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -28,6 +29,7 @@
 #endif
 
 #define VIRTIO_NET_F_MAC_BIT  (1 << 5)
+#define VIRTIO_NET_F_MRG_RXBUF_BIT (1 << 15)
 
 #define VQ_RX 0         /* Receive queue */
 #define VQ_TX 1         /* Transmit queue */
@@ -43,7 +45,18 @@ struct VirtioNetHdr {
 };
 typedef struct VirtioNetHdr VirtioNetHdr;
 
+struct VirtioNetHdrMrgRxbuf {
+    struct VirtioNetHdr hdr;
+    uint16_t num_buffers; /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
+};
+typedef struct VirtioNetHdrMrgRxbuf VirtioNetHdrMrgRxbuf;
+
+/* Header sizes for different modes */
+#define VIRTIO_NET_HDR_SIZE_LEGACY  sizeof(VirtioNetHdr)
+#define VIRTIO_NET_HDR_SIZE_V1      sizeof(VirtioNetHdrMrgRxbuf)
+
 static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
+static int virtio_net_hdr_size;
 
 int virtio_net_init(void *mac_addr)
 {
@@ -62,12 +75,17 @@ int virtio_net_init(void *mac_addr)
         return -1;
     }
 
+    virtio_net_hdr_size = ((vdev->guest_features[1] & VIRTIO_F_VERSION_1) ||
+                           (vdev->guest_features[0] & VIRTIO_NET_F_MRG_RXBUF_BIT))
+                          ? VIRTIO_NET_HDR_SIZE_V1
+                          : VIRTIO_NET_HDR_SIZE_LEGACY;
+
     memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
 
     for (i = 0; i < 64; i++) {
-        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
+        buf = malloc(ETH_MTU_SIZE + virtio_net_hdr_size);
         IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
-        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
+        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + virtio_net_hdr_size,
                        VRING_DESC_F_WRITE);
     }
     vring_notify(rxvq);
@@ -77,14 +95,14 @@ int virtio_net_init(void *mac_addr)
 
 int send(int fd, const void *buf, int len, int flags)
 {
-    VirtioNetHdr tx_hdr;
+    VirtioNetHdrMrgRxbuf tx_hdr;
     VDev *vdev = virtio_get_device();
     VRing *txvq = &vdev->vrings[VQ_TX];
 
     /* Set up header - we do not use anything special, so simply clear it */
     memset(&tx_hdr, 0, sizeof(tx_hdr));
 
-    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
+    vring_send_buf(txvq, &tx_hdr, virtio_net_hdr_size, VRING_DESC_F_NEXT);
     vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
     while (!vr_poll(txvq)) {
         yield();
@@ -108,13 +126,13 @@ int recv(int fd, void *buf, int maxlen, int flags)
         return 0;
     }
 
-    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - sizeof(VirtioNetHdr);
+    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
     if (len > maxlen) {
         puts("virtio-net: Receive buffer too small");
         len = maxlen;
     }
     id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
-    pkt = (uint8_t *)(rxvq->desc[id].addr + sizeof(VirtioNetHdr));
+    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
 
 #if DEBUG_VIRTIO_NET   /* Dump packet */
     int i;
-- 
2.55.0


