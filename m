Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19C7C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AFV-0003yM-8R; Thu, 03 Sep 2026 12:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFO-0003vN-0n; Thu, 03 Sep 2026 12:25:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFL-0006X4-8z; Thu, 03 Sep 2026 12:25:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2QUV3425226; Thu, 3 Sep 2026 16:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dpNCyGSCw0ewAR78f
 CbU9g21mjTUTH2g0jsi57myjAY=; b=DtzqYXDNnYAvn20vIayWyf3z/simOZoor
 SvGP3uFbjetVngf8Rf/5XbdYWjiH8zF8COr0+Xj2mRCZQkrr8LV9yVEp9Aja65V0
 o+wZD9NIH8wKEEe0iK2/r7+xdvwsA8cN7It1RG7GBChyA/qNNnvzYYsb/AiTZ1VX
 uSMZYYfJJczbCi4rEFgso1BZaIU3meRE6L885zP7AEvKTL5MoCk8Qw011cnPhHOJ
 xdRmV/KGj/aMZ4r9uaePS6Yz2cOpj9MpoDZlEe8qShvWoybzQd5RE3LQliXdDr+/
 M8p3Q/s1iCVgrTK3HOll0E4SqzFODOkHnG9YwHSpdP+V79qc/Y48w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5wuw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GBgbx002734;
 Thu, 3 Sep 2026 16:25:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyg8bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GOxOB11666114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:24:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D17358053;
 Thu,  3 Sep 2026 16:24:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5EA658043;
 Thu,  3 Sep 2026 16:24:57 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:24:57 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, jdaley@linux.ibm.com,
 pbonzini@redhat.com
Subject: [PATCH v2 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
Date: Thu,  3 Sep 2026 12:24:46 -0400
Message-ID: <20260903162449.2588271-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903162449.2588271-1-zycai@linux.ibm.com>
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a999f5d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=OvO-KZyVvL5PKhO4nh0A:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-GUID: JPSpTxXw6NC7G5GiXD1WcgzzNlaUZ-1y
X-Proofpoint-ORIG-GUID: JPSpTxXw6NC7G5GiXD1WcgzzNlaUZ-1y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX+J3ZZWKEeof3
 grcHvNWwU5Np6t3XFYHXxW5WsAzdb95Q5tRSRoaOHuKjIi6qez0mz4eYnZAjHLX5d8AHrhUshmF
 iQjIDwlAuftiWVPbSTibkcnbKiP+2QY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfXzqnD0NYNY3dS
 1Kc3ineXvJyNkRgrmxoudZoKwNOpur9gRnaRhVvnoeyRZt1MLpTM8Sb6gT0nJ4Xy2qQtL5V7qPa
 5z6wjCyL9b+2ozpRefVeDO9PJDJABRhAx+HDMrGKt80XTHnEO0oLG9oJHqaJK1GC32dvPIuhzyn
 GIhzgXih5fS26RzjMuAqrc1iDAY5FtJaoNH+EW5VEowpa/mEuA0YFuW71TGVxAZJsmNJPx3hMxj
 jb8KxOxgkzYuQOtTNoPHjsaESb+55J63Yp/ZdLF+ViBRcfM3aFZ0VGP0QG1FXX1fw5gio7G6o/d
 wRtkHItgavhVezYtxTFy5LdxKFAOWtV+COhmgridjKXH4XTDtRUAZJZ8rUHIP3DvWD3v9+xCoM+
 MinPCGgoFAOJrWk8zoNi6rX4w45z0D45CABs8h2a/sTu3RHQj31sz3ZZnrl5vNbg38Qz/AFZ++z
 AxSfqshLPck4bRP6/9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030140
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

Enable network booting via virtio-net-pci by implementing PCI transport
support for virtio-net.

This patch also extends endianness handling for virtio PCI ring operations in
little-endian to ensure correct behavior on s390x.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c       |  1 +
 pc-bios/s390-ccw/netmain.c    |  9 +++++++-
 pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
 pc-bios/s390-ccw/virtio-pci.c | 18 +++++++++++++++
 4 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8fc1cbf653..28cab3b411 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -332,6 +332,7 @@ static void ipl_pci_device(void)
     }
 
     switch (vdev->dev_type) {
+    case VIRTIO_ID_NET:
     case VIRTIO_ID_BLOCK:
         if (virtio_setup() == 0) {
             zipl_load(); /* only return on error */
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index bcb62bf6ca..e42e049063 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -498,7 +498,14 @@ int netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    if (!virtio_ccw_net_setup()) {
+    /*
+     * CCW devices require subchannel enumeration here.
+     * PCI devices don't require specific setup: the transport is already
+     * initialized by ipl_pci_device(), and virtio_is_supported() is checked
+     * later in virtio_net_init().
+     */
+    if (virtio_get_device()->ipl_type == S390_IPL_TYPE_CCW &&
+        !virtio_ccw_net_setup()) {
         puts("No valid virtio ccw net device found.");
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index afa728bc32..418759565d 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -68,7 +68,22 @@ int virtio_net_init(void *mac_addr)
     rx_last_idx = 0;
 
     vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
-    virtio_ccw_setup(vdev);
+    switch (virtio_get_device()->ipl_type) {
+    case S390_IPL_TYPE_CCW:
+        if (virtio_ccw_setup(vdev)) {
+            puts("Setup failed for virtio-net-ccw");
+            return -1;
+        }
+        break;
+    case S390_IPL_TYPE_PCI:
+        if (virtio_pci_setup(vdev)) {
+            puts("Setup failed for virtio-net-pci");
+            return -1;
+        }
+        break;
+    default:
+        return -1;
+    }
 
     if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
         puts("virtio-net device does not support the MAC address feature");
@@ -121,22 +136,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
     VRing *rxvq = &vdev->vrings[VQ_RX];
     int len, id;
     uint8_t *pkt;
+    uint16_t rx_used_idx, rx_avail_idx;
+    uint32_t rx_used_len, rx_used_id;
+    uint64_t rx_desc_addr;
 
-    if (rx_last_idx == rxvq->used->idx) {
+    rx_used_idx = virtio_tswap16(rxvq->used->idx);
+    if (rx_last_idx == rx_used_idx) {
         return 0;
     }
 
-    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
+    rx_used_len = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].len);
+    rx_used_id = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].id);
+
+    len = rx_used_len - virtio_net_hdr_size;
     if (len > maxlen) {
         puts("virtio-net: Receive buffer too small");
         len = maxlen;
     }
-    id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
-    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
+    id = rx_used_id % rxvq->num;
+    rx_desc_addr = virtio_tswap64(rxvq->desc[id].addr);
+    pkt = (uint8_t *)(rx_desc_addr + virtio_net_hdr_size);
 
 #if DEBUG_VIRTIO_NET   /* Dump packet */
     int i;
-    printf("\nbuf %p: len=%i\n", (void *)rxvq->desc[id].addr, len);
+    printf("\nbuf %p: len=%i\n", (void *)rx_desc_addr, len);
     for (i = 0; i < 64; i++) {
         printf(" %02x", pkt[i]);
         if ((i % 16) == 15) {
@@ -150,8 +173,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
     memcpy(buf, pkt, len);
 
     /* Mark buffer as available to the host again */
-    rxvq->avail->ring[rxvq->avail->idx % rxvq->num] = id;
-    rxvq->avail->idx = rxvq->avail->idx + 1;
+    rx_avail_idx = virtio_tswap16(rxvq->avail->idx);
+    rxvq->avail->ring[rx_avail_idx % rxvq->num] = virtio_tswap16(id);
+    rx_avail_idx++;
+    rxvq->avail->idx = virtio_tswap16(rx_avail_idx);
     vring_notify(rxvq);
 
     /* Move index to next entry */
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index f501252c81..147a82895f 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
     case 0x1001:
         vdev->dev_type = VIRTIO_ID_BLOCK;
         break;
+    case 0x1041:
+    case 0x1000:
+        vdev->dev_type = VIRTIO_ID_NET;
+        break;
     default:
         vdev->dev_type = 0;
     }
@@ -199,6 +203,14 @@ static int virtio_pci_get_blk_config(void)
     return rc;
 }
 
+static int virtio_pci_get_net_config(void)
+{
+    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
+    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
+
+    return rc;
+}
+
 static int virtio_pci_negotiate(void)
 {
     int i, rc;
@@ -330,6 +342,7 @@ bool virtio_pci_is_supported(VDev *vdev)
     if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
         switch (vdev->dev_type) {
         case VIRTIO_ID_BLOCK:
+        case VIRTIO_ID_NET:
             return true;
         default:
             return false;
@@ -384,6 +397,11 @@ int virtio_pci_setup(VDev *vdev)
         vdev->cmd_vr_idx = 0;
         virtio_pci_get_blk_config();
         break;
+    case VIRTIO_ID_NET:
+        vdev->nr_vqs = 2;
+        vdev->cmd_vr_idx = 0;
+        virtio_pci_get_net_config();
+        break;
     default:
         puts("Unsupported virtio device");
         return -ENODEV;
-- 
2.55.0


