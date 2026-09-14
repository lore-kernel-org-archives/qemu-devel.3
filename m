Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E81C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CSc-0007H5-Ls; Mon, 14 Sep 2026 15:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CSA-000703-BJ; Mon, 14 Sep 2026 15:34:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS5-0004AC-3m; Mon, 14 Sep 2026 15:34:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJ1Xnk1714381; Mon, 14 Sep 2026 19:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+QdhuJAeFJs5Gb9ay
 rydAYaknSpNNf7R835xFeVmxzE=; b=BNgaNw/RtyoDy1kr/nP6yHwnxed1cLVCP
 ws9wgNW9WmtLnK6K2sbqsi0uF8LiqD41KD1Jad4Pq+8Gxwf+ut6LRTET8BDIKxuX
 S9KxNey0zJDxRVT7tswTd097R7m1IqGrSZtEmrA7gL65nk6tvGiuL9/fkgdzz0pq
 2bextHJm5LOeE8jA4HOE7wF8nyXsO+JaJRJ2qVxdEmwRkEpZti0+yfRkl0SeAEzg
 MWWq7YYkpOBNPDe82L/IlYfItQe+hGYEjhLzDj5Df+sqz7xWvttVzGefeUsTfvst
 QSnyHX1alNQF+P1pIydP86WkoeQbMsq5zim/kCx+YJY/fQL1aJRLw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dugh1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIom8x2752505; Mon, 14 Sep 2026 19:34:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhevyxt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EJYnIm18088628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 19:34:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B7CB58058;
 Mon, 14 Sep 2026 19:34:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1D4E58059;
 Mon, 14 Sep 2026 19:34:47 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.78.15])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 19:34:47 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
Date: Mon, 14 Sep 2026 15:34:34 -0400
Message-ID: <20260914193438.526407-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914193438.526407-1-zycai@linux.ibm.com>
References: <20260914193438.526407-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX9oW9AsWjgRa1
 /SX+whKuKwBM18yxTJPStnft/4B2nWJmsOSLtHVAzWen5pqZ6Tj/dNv4KC3H1kyFy9zkxuJWrE7
 j7/5RPIq67dgIB9ssbqOAbxxOKgLneROmyU13SiJYdzs250bp3tWNX9VYKkqHsH/itYNogVj9Rd
 bCVxn/bJI2AehDPvv1/iT3Q7p9oqKH9b3AIAiEtRmrhmqPEzWgnqwZftry0IBOT9ELtsKJebCiI
 kDGe53VKhzUB+1qRQ4z2eeaLewkha/n3m6SvRycJXfHJSwJxgh5tymA3k/IQXsl65MCf6bsHSi9
 gySN9ssaHQjgMJ/6iLKnu85F/lKrCq72OhBvsJmHdpRqim9PKmHPasRg+ErqzsjZxVzt0sfqfC8
 UHNa7Mdug2L6W3bxW8C9B4kHvDYldvWOhg3W8jQrADxDsLOq8t9lprx8QLz+f6uD5TW+GZW8NrW
 esRAQNQyOamehU6kRSA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa84c5b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=Iu4lfvU6lRjo1WYjJIoA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-ORIG-GUID: lso6K167DLS5f1OKgcE0se-WRr3NtlgP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX1YofO2+mLIVz
 42ZlJKGq8QnXuQwb9iiIzwQbrPU4eoDu02qmcvooF4tlmIoBzfBVCHINE2amMsLVoh2ZZzq2npP
 rb8QbphDSvdyR8i24BLu6OkxNyqNKYk=
X-Proofpoint-GUID: lso6K167DLS5f1OKgcE0se-WRr3NtlgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Enable network booting via virtio-net-pci by implementing PCI transport
support for virtio-net.

This patch also extends endianness handling for virtio PCI ring operations in
little-endian to ensure correct behavior on s390x.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c       |  1 +
 pc-bios/s390-ccw/netmain.c    |  9 +++++++-
 pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
 pc-bios/s390-ccw/virtio-pci.c | 20 +++++++++++++++++
 4 files changed, 62 insertions(+), 9 deletions(-)

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
index ffdf7ba831..48ad6b5da8 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -67,7 +67,22 @@ int virtio_net_init(void *mac_addr)
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
@@ -119,22 +134,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
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
@@ -148,8 +171,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
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
index f501252c81..fd794bad8f 100644
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
@@ -199,6 +203,17 @@ static int virtio_pci_get_blk_config(void)
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
@@ -330,6 +345,7 @@ bool virtio_pci_is_supported(VDev *vdev)
     if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
         switch (vdev->dev_type) {
         case VIRTIO_ID_BLOCK:
+        case VIRTIO_ID_NET:
             return true;
         default:
             return false;
@@ -384,6 +400,10 @@ int virtio_pci_setup(VDev *vdev)
         vdev->cmd_vr_idx = 0;
         virtio_pci_get_blk_config();
         break;
+    case VIRTIO_ID_NET:
+        vdev->nr_vqs = 2;
+        virtio_pci_get_net_config();
+        break;
     default:
         puts("Unsupported virtio device");
         return -ENODEV;
-- 
2.55.0


