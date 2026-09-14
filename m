Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BE4C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CSW-0007E3-9u; Mon, 14 Sep 2026 15:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS4-0006yc-UN; Mon, 14 Sep 2026 15:34:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS1-00048e-Qh; Mon, 14 Sep 2026 15:34:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJ1Ygb2739069; Mon, 14 Sep 2026 19:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0ipHUG+aENh9ykJZC
 QoW5mB2rbgFXlUWCWrTNWYqfZM=; b=jCaRYsgGHKcJfCa0s1PuJI9FAPPXpu5Oo
 Po3xljF2/xwvANqkZrMwD2i6CFtKsgHeaiHbjQZOU6P6/+zmvBtMBRvSyr547Sfr
 8+SHYrvvIuis5uSTmRQewJPj10D64cSRjSNpv7J2qnd9tC76yEZRXZIswrXqCO97
 APZg9tpoD+cdZK9OoVhOoxosbfI2CgpNmelBJ+t00Hgrs4p1ibipxB/PNIWmLvAh
 Uph9ig3R+hbYbiJicMwLJMcGaadROBraa/jH+vPUWMAyFafoTkvrwFZSqCXK0lB0
 PkeTwG5bput17s0ffJEqPswaHOmwTbpNBAYCqdCE23jk54Z8tZsVA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hkp50-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIokXB2729126; Mon, 14 Sep 2026 19:34:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jyvuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EJYkQF22020618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 19:34:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1936F58059;
 Mon, 14 Sep 2026 19:34:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2BA5805B;
 Mon, 14 Sep 2026 19:34:44 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.78.15])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 19:34:44 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v3 2/8] pc-bios/s390-ccw: Add dynamic net header size handling
Date: Mon, 14 Sep 2026 15:34:32 -0400
Message-ID: <20260914193438.526407-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914193438.526407-1-zycai@linux.ibm.com>
References: <20260914193438.526407-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfXx5nGbIcKhykH
 YXAozYWvCxoGdwYyBApMoIeBSwwPO21sn06JnVZTFkZVaZvmeC4vNS50VSZHbnFeKh+QpDLTIw0
 wUkk2p32UERUkT/r5J11t5RRNX4WO52iIgKg6ZvsQDhSgRViyIt5NCYUuYz+Lwrw/wyDnbEMFm7
 TvGHgVddSbno1rpCiPxMP/Ipn9oy3XSF0dhaOwA9jq9gWByGam0V2O0hQulUzA27YUIzCnObG+b
 N0+eqf1IYze6bo/4AuTKghKI2sCVx9q85xi/VGsFU/rXp73uJf0WyRaJokWOJ0d6aBfxlY4TDGJ
 hMuhz4p3PtbN+QEtljDijLZZ7gVB5e0SNtMnhVi1W6wwSgjHuidn/nxNIbQkYok0A6b6zmfq5Ay
 EBPIcwzJETQg4XkRZVYawJB/azONrDWCDj/YyVsg71sB6JxMe6z6QvTQ9dZ/Mx45ACh84eOteGB
 TmPrGa0c6U2+alv+vtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX5dhSsK+S8TVC
 QF1LjcVLuwBWWBREBubdgTm4z1Iccq1tjjBW/3E941Nq3oDYryXiBzZRpNBp2vryN/CcAOJswLR
 sQ0rJrPcCWHClIxEWI9Q/dB5YNp66Ok=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa84c58 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=b71jbalOAXEqY8vE3Q8A:9
X-Proofpoint-ORIG-GUID: XULnkh8LF7D1lkigL6IBPC4mrn87R46k
X-Proofpoint-GUID: XULnkh8LF7D1lkigL6IBPC4mrn87R46k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140278
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
the num_buffers field used in VirtIO 1.0.

Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
VirtIO 1.0. This ensures correct packet handling across different
VirtIO configurations.

The VirtioNetHdr and VirtioNetHdrMrgRxbuf structures replicate the
same field layout as struct virtio_net_hdr and struct
virtio_net_hdr_mrg_rxbuf defined in inux/uapi/linux/virtio_net.h.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-net.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index f58f7ffc55..ffdf7ba831 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -20,6 +20,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -43,7 +44,18 @@ struct VirtioNetHdr {
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
@@ -62,12 +74,16 @@ int virtio_net_init(void *mac_addr)
         return -1;
     }
 
+    virtio_net_hdr_size = vdev->guest_features[1] & VIRTIO_F_VERSION_1
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
@@ -77,14 +93,14 @@ int virtio_net_init(void *mac_addr)
 
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
@@ -108,13 +124,13 @@ int recv(int fd, void *buf, int maxlen, int flags)
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


