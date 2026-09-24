Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946A2C9831E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 22:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rx7-0000PX-O2; Thu, 24 Sep 2026 18:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx4-0000Nh-Vf; Thu, 24 Sep 2026 18:30:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx3-0005ET-1V; Thu, 24 Sep 2026 18:30:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5o7l2914735; Thu, 24 Sep 2026 22:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rK/0SNz/xNRIB8TKT
 K28NP04er4SUxDCeruO5YF/oVE=; b=pMS1HtaG3oa4aGcbjxyFXHJzluAlouR3o
 gE7BRnfJW6I67g0mlGYN2stk3mo/lyZWs8Pawkf2LK2hgs4tnLHsrdda0aZkd+LS
 LCsejjTrGksOoG7lNLZBkpF+izmm6Smockb9NzLa6wuzbTLUJJP2UwoMByjKT6jl
 nsPPyIBCYDlQxUpCwxsdAf13ANldc/uM96r6+ggX7mgWrT3NXdPK7mdoMgkDXFI2
 dgy6eDKl0xVB1+pqgE8BvdsnDnP8REIjlbX2cFBUhipxBY5oUC3UOrg5yuuDx26i
 z0GAuIi+/tov5VJjeOppmS6UVCqkQvLdgw7/DTODd5DTLb4OxgMyA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1u6x3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:29:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlZhM2515991; Thu, 24 Sep 2026 22:29:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8ywa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:29:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OMTvPt25559612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 22:29:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63BF658056;
 Thu, 24 Sep 2026 22:29:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E99F258050;
 Thu, 24 Sep 2026 22:29:55 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 22:29:55 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v5 2/8] pc-bios/s390-ccw: Add dynamic net header size handling
Date: Thu, 24 Sep 2026 18:29:43 -0400
Message-ID: <20260924222949.147720-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924222949.147720-1-zycai@linux.ibm.com>
References: <20260924222949.147720-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MOi0xBmXcam55ZjCTPOLB3sWAz01ykLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX89twY2DBrwYO
 zszmDn96CAmstaTQEMK4CKkMGfoeEgcmWvTwbZlGwDUCTzIgtrPsLOJj4YQ5F0DKK3bXSvAkz/N
 pHKdxsAXRWTKbqjVVi7iz8sjHTRW2QwmDRZTURa5qav/p6Ufm1LB5n82i1zzNbxX5fXZ2Y+7PO4
 bA6ee9cHkRQN8tVauOmpy8eVmmW0Nxd2bXG6AocThYwNE7h3L4th0RwlJVoVYnzfjXGdFs4c0qj
 mOtZq1SCH2z3Ew2Ew/Nj4NtYZ/9NFFZLtQEot0Q+jM/dwKMqVDyXSFRgNIfzgDQqpqlZx8YIfgJ
 MJPGgozITqlkxlE4XSai6bCTAcNySkdbLrX/Y99hLcn+9WrLeYYi/dw/kyC29ad4S2lYm/9B0QX
 FRswXP/QL2kOwGqCmjVv2sXW+wwztYdt/9tuEa1ixrhds14G+cVx6i7atLsA2XEA+cDiKxJ3vPy
 JRA4ge7/J2z2Ky//t6w==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab5a467 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=b71jbalOAXEqY8vE3Q8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfXz4PIvPLyqBLV
 loOtCJJN9X/NsMCBFDggl7w/Bmy4T5zwkGh+z/9FqKCnHzrydx9R+UH3WuGPlRdQ5KWPVeay01e
 rpXz02uhxZdESTa3kUJiQF+0r+7JgYk=
X-Proofpoint-GUID: MOi0xBmXcam55ZjCTPOLB3sWAz01ykLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240090
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
virtio_net_hdr_mrg_rxbuf defined in include/uapi/linux/virtio_net.h.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-net.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index f58f7ffc55..7bb3f8f551 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -20,6 +20,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -39,11 +40,21 @@ struct VirtioNetHdr {
     uint16_t gso_size;
     uint16_t csum_start;
     uint16_t csum_offset;
-    /*uint16_t num_buffers;*/ /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
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
@@ -62,12 +73,16 @@ int virtio_net_init(void *mac_addr)
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
@@ -77,14 +92,14 @@ int virtio_net_init(void *mac_addr)
 
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
@@ -108,13 +123,13 @@ int recv(int fd, void *buf, int maxlen, int flags)
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


