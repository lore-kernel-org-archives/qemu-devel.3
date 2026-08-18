Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FE5C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQok-0007yJ-4F; Tue, 18 Aug 2026 16:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoa-0007v4-Ai; Tue, 18 Aug 2026 16:53:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoY-0000je-5O; Tue, 18 Aug 2026 16:53:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJVsOp3584832; Tue, 18 Aug 2026 20:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ceRnNxcq7t124Yzzu
 80ZDnrF7nMivIqDjsutHQ3GGvc=; b=K/HZiH86Ekg2z/SWiEnjOZ0qSHPK/CHv8
 JMdxO7wKHZ8sQItDGWJDnniry25kp48vXSh+IN95EmpRcIFloXFdVyH89HtrdtL2
 NFH7qAQl6DE1TDVbxVjjq1/c3Qse8twiSfgS3us8aoKvDg+h4W/S4P/3LlhQ0xDz
 5zUUPnJh1SW8EpuDKUBHOPmStMx+T2Nx6YRdlrD7uiIPEhy7OD3Wt7fKjPjAt/Fc
 7Bp0zxj2ThlEpK5veBoOAUsaMquqt4tvRD4MsN70SW5nKw3CKGb+d6gyd4E60Lgs
 gQM9f78UXiBWf7YwHJrHVXmJnmHQ7zf7qVuTxi3Bi/8Fbb3QKnWlg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqtu56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfRv5014379;
 Tue, 18 Aug 2026 20:53:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw5htm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKra2l22610626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB22F58052;
 Tue, 18 Aug 2026 20:53:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E2B558045;
 Tue, 18 Aug 2026 20:53:35 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:35 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
Date: Tue, 18 Aug 2026 16:53:21 -0400
Message-ID: <20260818205324.580199-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX2mqIyKD/l2R1
 QR6X4R2L03fP9z9IfjWXjwjdaQWvGxUZ+dGuUVAB6HMb2Xd3msKfH94vkqFM0BeqFJzt1vEHnWE
 Lu0peSzGm61R3yCrxjybUwnTl5IG9q6avCwLvYNAY/jraf9XURMDtsgr+k6KXhcVecLZSo56WnQ
 mq5fvKlJ42qJSTJrotJzn9/DQyJl9sh1/IXuigjmesRgpkoAteEXdy/FSN3yk9ZVRFnCY5B0ctq
 brggICwwivCN8dK88LC28PM/LLRZjLuO64wqc1tIj2iF6aJTNQHVbrgW0LH3a7gWxmsz/l3HzOZ
 Hlef9q/rSK7vNaTLJ++xXNsxLYerMeaNMKXdej5vrY3Yz8VtBeb8lOE59sjTSRaYezaEcMux2P/
 maCaOVD4PZDHWmk6ocimdCQey794yngwSSMXK1UO6YU231cCjF6ptsEhLMd3d1owHXAyR7W5Vlh
 yta/NRI45jCWcsPJzrw==
X-Proofpoint-ORIG-GUID: PmDhFsBvG4nOjCeUSoxbGp9SCwcLhzlW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX/EPOxHbIVP3+
 P9Q4XvHWZdgDNHg4NAxKHt1/CvSUpNFe5mVbuQ9HSudOLDE0amoGMP1zaFMpFMkrq8Qowl815Wm
 e08RdElpt6awrni91H2yO50ep/dSzps=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84c653 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=Im3OWcnwkaNWJq0cCQkA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-GUID: PmDhFsBvG4nOjCeUSoxbGp9SCwcLhzlW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
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

This patch also adds endianness handling for virtio PCI ring operations in
little-endian to ensure correct behavior on s390x.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c       |  1 +
 pc-bios/s390-ccw/virtio-net.c | 37 +++++++++++++++++++++++-------
 pc-bios/s390-ccw/virtio-pci.c | 43 +++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h |  2 ++
 4 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8bc6e8eaa3..0eeb53a2bf 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -328,6 +328,7 @@ static void ipl_pci_device(void)
     }
 
     switch (vdev->dev_type) {
+    case VIRTIO_ID_NET:
     case VIRTIO_ID_BLOCK:
         if (virtio_setup() == 0) {
             zipl_load(); /* only return on error */
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 3a9ae789cf..209f98a0e3 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -62,7 +62,16 @@ int virtio_net_init(void *mac_addr)
     rx_last_idx = 0;
 
     vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
-    virtio_ccw_setup(vdev);
+    switch (virtio_get_device()->ipl_type) {
+    case S390_IPL_TYPE_CCW:
+        virtio_ccw_setup(vdev);
+        break;
+    case S390_IPL_TYPE_PCI:
+        virtio_pci_setup(vdev);
+        break;
+    default:
+        return -1;
+    }
 
     if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
         puts("virtio-net device does not support the MAC address feature");
@@ -115,22 +124,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
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
@@ -144,8 +161,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
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
@@ -164,6 +183,8 @@ bool virtio_net_setup(void)
     switch (virtio_get_device()->ipl_type) {
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_net_setup();
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_net_setup();
     default:
         return false;
     }
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index f501252c81..c7d62766b8 100644
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
@@ -458,3 +476,28 @@ int virtio_pci_setup_device(void)
 
     return 0;
 }
+
+static bool find_pci_net_dev(void)
+{
+    if (!virtio_is_supported(virtio_get_device())) {
+        return false;
+    }
+
+    if (virtio_get_device_type() != VIRTIO_ID_NET) {
+        return false;
+    }
+
+    return true;
+}
+
+bool virtio_pci_net_setup(void)
+{
+    bool found = false;
+
+    if (have_iplb || store_iplb(&iplb)) {
+        IPL_assert(iplb.pbt == S390_IPL_TYPE_PCI, "IPL_TYPE_PCI expected");
+        found = find_pci_net_dev();
+    }
+
+    return found;
+}
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 33b683bd92..2c3136fd05 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -70,6 +70,8 @@ long virtio_pci_notify(VRing *vr);
 bool virtio_pci_is_supported(VDev *vdev);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
+bool virtio_pci_is_supported(VDev *vdev);
+bool virtio_pci_net_setup(void);
 
 int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
 int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
-- 
2.55.0


