Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9223C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQog-0007wM-PN; Tue, 18 Aug 2026 16:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoV-0007u2-Je; Tue, 18 Aug 2026 16:53:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoT-0000hh-T1; Tue, 18 Aug 2026 16:53:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJW5eo1211079; Tue, 18 Aug 2026 20:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0NKFsng+ch+oW3TFO
 U/Z9KKhg92SnP9r8ao6MANvPh4=; b=W2AcWBbwH4F14A5286HAwBtuRnv2fk8PD
 5dcb8GKpDKXBiLv774dIFwhh4rhIq8Lq10vmTqwI/ffWJimJFi+C55vdrlE0Mkr/
 fjSbYXDunHelnKOA6yTLqKm36tQLrqKNE66nOKrOsiva9z0nmcOqrLALgJ9Upa0c
 TzaH+TpQK5kfuUyyeo9TVUCFaK1WfXBfJBfVlKtysGFDruw+0+wX8bYsfS2hbYHX
 lP0FJYTMyikiNvy2jwxJUbbaHlrybNC7d2JWqWMp/ZCXfahFvIRnCSQONqno/rmf
 S8OB35z/9wjy6TJnpI7bqKFQsej6ut9PueJ+lCX5mzxjU9sbQc5DA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3tv9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfSut022733;
 Tue, 18 Aug 2026 20:53:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq5k01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKqs2I28967520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:52:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8783558045;
 Tue, 18 Aug 2026 20:53:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B7D558050;
 Tue, 18 Aug 2026 20:53:32 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:31 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 2/7] pc-bios/s390-ccw: Add dynamic net header size handling
Date: Tue, 18 Aug 2026 16:53:19 -0400
Message-ID: <20260818205324.580199-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1ztNGwop2dRG6RWz10Q2JQ_-ko_-Zw3q
X-Proofpoint-ORIG-GUID: 1ztNGwop2dRG6RWz10Q2JQ_-ko_-Zw3q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX86oUOV+cZd3x
 Qx9px6CaoaKysKxHu35UMgpTyHdBIUBS12gsobHvSTEn7zzdLLTiU2t8CVAwRB3mi3VrE+U5r9+
 6K7EI2S4EP8wUooZBLCVlRgR+Chjgb0=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84c64f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=8MLiPoPOxDt9SxNeCIoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX9He3tQM2bqCq
 s9dv1gAOFawbEVlMnK/3cSlvIddhbNPWVOyWE0NEpBbTkFrZ/uupFkEIohxqxAvX6PneELWzpd9
 4NWU4yaewaCsvKDCa+2Da6iGyRJ4rRTIXutPhD7SDLLHzea/jQjfmgo62hK6RMi5jOtrdgafpjy
 iopaLiD05b9wtRQ3oLNb8HVbMELZ5h/5toCbbMj2Fc1kkksG8gQ/JyXAw6AgGt0TQsw2hXCXul5
 /+FCseLFmmM9cX8lZ6AWtKebQyWGPp9cDxqamgcm25rNDPH44ODJ7iNECaKRm/gZPv3y5xI4BDg
 z/7RTLIyw7A51iA4Mp9Vp1XFJw0/QePzqR13OUizXu4aWnh0WpxClxd5JZ31RTok0yIMtUCHT/e
 KzTYl++NXgDYyYt2qh/uzftqg7v0SkVCycbUZ3nON1+2Kb7rAq5Tj+cZo7NbFTO+Hnm8UuWnkOa
 RUeTBxDcJQnJsqgQnYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 pc-bios/s390-ccw/virtio-net.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 0ee51653ab..3a9ae789cf 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -20,6 +20,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -28,10 +29,15 @@
 #endif
 
 #define VIRTIO_NET_F_MAC_BIT  (1 << 5)
+#define VIRTIO_NET_F_MRG_RXBUF_BIT (1 << 15)
 
 #define VQ_RX 0         /* Receive queue */
 #define VQ_TX 1         /* Transmit queue */
 
+/* Header sizes for different modes */
+#define VIRTIO_NET_HDR_SIZE_LEGACY  10  /* Without num_buffers */
+#define VIRTIO_NET_HDR_SIZE_V1      12  /* With num_buffers */
+
 struct VirtioNetHdr {
     uint8_t flags;
     uint8_t gso_type;
@@ -39,11 +45,12 @@ struct VirtioNetHdr {
     uint16_t gso_size;
     uint16_t csum_start;
     uint16_t csum_offset;
-    /*uint16_t num_buffers;*/ /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
+    uint16_t num_buffers; /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
 };
 typedef struct VirtioNetHdr VirtioNetHdr;
 
 static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
+static int virtio_net_hdr_size;
 
 int virtio_net_init(void *mac_addr)
 {
@@ -62,12 +69,17 @@ int virtio_net_init(void *mac_addr)
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
@@ -82,9 +94,9 @@ int send(int fd, const void *buf, int len, int flags)
     VRing *txvq = &vdev->vrings[VQ_TX];
 
     /* Set up header - we do not use anything special, so simply clear it */
-    memset(&tx_hdr, 0, sizeof(tx_hdr));
+    memset(&tx_hdr, 0, virtio_net_hdr_size);
 
-    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
+    vring_send_buf(txvq, &tx_hdr, virtio_net_hdr_size, VRING_DESC_F_NEXT);
     vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
     while (!vr_poll(txvq)) {
         yield();
@@ -108,13 +120,13 @@ int recv(int fd, void *buf, int maxlen, int flags)
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


