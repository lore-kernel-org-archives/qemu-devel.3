Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F54C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pRI-0003zp-LY; Thu, 24 Sep 2026 15:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR8-0003xY-EJ; Thu, 24 Sep 2026 15:48:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR6-0008Al-Dd; Thu, 24 Sep 2026 15:48:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5iB33079455; Thu, 24 Sep 2026 19:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mzKTpbOStwy7w+0le
 xLYnJ2mcdK7mf47zYLZG0cUrds=; b=MWtUR7NiDsZ2mOWiU8vRnnsQGq52wmdMW
 8VMJ2SULWgKHWurhs2AcCI4YMhZE8akUv/BBClD1r2rl7n1oW4e4KwXzIQpCHuO9
 CegXq4psiQs1YXhDnFiqkNueAtTSUYndIzngMqZKRhQhJFBm32HS7U5j/L5ahKos
 vVDBzqP0BP8zc7ExKvFim/W6ENottJbgpxuPJM+ZhIpBhvxbu2uhXt3swH3ZP2oe
 zea7B5pSw+VxvfaPTyojomZQZc5EDlBPDdnTvgi9tNzaWxTxqweHsJ0ii5EXRVxD
 NhsqtmNbf7QKVzOYZ5wsnXU+L+3vLvTCT0n3ju7f3g+fgZm6smCTA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2uccm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlYdV2521594; Thu, 24 Sep 2026 19:48:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2ycg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OJm4Jr918238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 19:48:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A2015805B;
 Thu, 24 Sep 2026 19:48:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0F0458059;
 Thu, 24 Sep 2026 19:48:46 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 19:48:46 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v4 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
Date: Thu, 24 Sep 2026 15:48:33 -0400
Message-ID: <20260924194837.80732-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924194837.80732-1-zycai@linux.ibm.com>
References: <20260924194837.80732-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MfPB6tTrkA4mj5zpgFlK2vlhNExGEP8Y
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab57ea2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=Iu4lfvU6lRjo1WYjJIoA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX74NHCWMjxfuk
 LhLC0UQzDOFxQNweOQ0E25kOM7Un5e2U7J+GEPhk31slZbC1KJq5yiSL5jeL61MNy0XNtoqm5WE
 LmriIE49edgu5mSq2cGe8wSu8M5o1xjqpRbw/NOoCgzthzUUFE8gVPhz2qiLRwWz8c0Ds9/z7Hf
 rXKP8yA6CxpuDnRoCAQW9NrtkmLbAo18OPZsMIpHDd5pHs4GliomentDokfkGvzwQYRtu1svtlM
 WNmg+xCUbOJLPgNFdDGV/23KfDv6E8ZkWzaqz4ffRv9HTP31yJgVAtJHUV48779OlKN1s2ihKIH
 PWITpUFFnA46dPqXsJOM+ydIgYqPsTPVzWe7ER6qFEpG3hhIbOSY87UtUojfDCiVy3kPXloTBS9
 rxNzZsuwdR7jnteZr82SCBWovc3rfS6lsSufUdSYxZcGsDD62ohVkRWEIAQFX9aEuCyxO8wr0MV
 /WFUo6XqIMzLuECJh+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX0ftj4wNGyDYb
 LToTacJk6aOpn2nPIY3wVT0l7Ml8sMjYXtAgbL/16tkl4VWdKX/YCoWg2xPQBoH9BP1f9UGQew2
 ndoG0pLaergcXQWDsWAADNeBjg6YOHQ=
X-Proofpoint-GUID: MfPB6tTrkA4mj5zpgFlK2vlhNExGEP8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240080
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
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c       |  2 ++
 pc-bios/s390-ccw/netmain.c    |  8 ++++++-
 pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
 pc-bios/s390-ccw/virtio-pci.c | 18 +++++++++++++++
 4 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d2a2ac3138..b06d67c563 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -342,7 +342,9 @@ static void ipl_pci_device(void)
         return;
     }
 
+    /* net, scsi, and block all intentionally use the same shared boot setup */
     switch (vdev->dev_type) {
+    case VIRTIO_ID_NET:
     case VIRTIO_ID_SCSI:
     case VIRTIO_ID_BLOCK:
         if (virtio_setup() == 0) {
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index bcb62bf6ca..dd02c5c71f 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -498,7 +498,13 @@ int netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    if (!virtio_ccw_net_setup()) {
+    /*
+     * CCW devices require subchannel enumeration here.
+     * PCI devices don't need specific net setup; the virtio-net-pci devices
+     * still follow the regular Virtio, PCI, and generic network setup.
+     */
+    if (virtio_get_device()->ipl_type == S390_IPL_TYPE_CCW &&
+        !virtio_ccw_net_setup()) {
         puts("No valid virtio ccw net device found.");
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 7bb3f8f551..632ce059d6 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -66,7 +66,22 @@ int virtio_net_init(void *mac_addr)
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
@@ -118,22 +133,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
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
@@ -147,8 +170,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
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
index 277c3ea68d..7fb987099d 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -55,6 +55,9 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
     case 0x1048:
     case 0x1004:
         vdev->dev_type = VIRTIO_ID_SCSI;
+    case 0x1041:
+    case 0x1000:
+        vdev->dev_type = VIRTIO_ID_NET;
         break;
     default:
         vdev->dev_type = 0;
@@ -223,6 +226,17 @@ static int virtio_pci_get_scsi_config(void)
     return rc;
 }
 
+static int virtio_pci_get_net_config(void)
+{
+    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
+
+    /*
+     * Byte-swapping is not needed as only the MAC address (byte array)
+     * is used here. Byte-swap if other fields are added.
+     */
+    return vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
+}
+
 static int virtio_pci_negotiate(void)
 {
     int i, rc;
@@ -355,6 +369,7 @@ bool virtio_pci_is_supported(VDev *vdev)
         switch (vdev->dev_type) {
         case VIRTIO_ID_BLOCK:
         case VIRTIO_ID_SCSI:
+        case VIRTIO_ID_NET:
             return true;
         default:
             return false;
@@ -413,6 +428,9 @@ int virtio_pci_setup(VDev *vdev)
         vdev->nr_vqs = 3;
         vdev->cmd_vr_idx = 2;
         virtio_pci_get_scsi_config();
+    case VIRTIO_ID_NET:
+        vdev->nr_vqs = 2;
+        virtio_pci_get_net_config();
         break;
     default:
         puts("Unsupported virtio device");
-- 
2.55.0


