Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC4C9831E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 22:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rxC-0000Rl-Pr; Thu, 24 Sep 2026 18:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx9-0000QE-A9; Thu, 24 Sep 2026 18:30:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx7-0005GE-7x; Thu, 24 Sep 2026 18:30:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5Vn91201917; Thu, 24 Sep 2026 22:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AzO8g3G7d2J5+RCHQ
 z7DuaWf/NBS+CeNBU/Y/7HMVUc=; b=LqjTYE/OX7lt2VPCU1C9MnLFSnWi4u6Em
 DZmYEcqNtWrujXL8iQgVDz4OWRAeqfH/VlFkj9A+kMTdmJ0Ch9GLNoco9BOHFAlL
 oRrTfJ5oPMXUuAYNmrAr8WxF/XEAr83YYyjUeovzkHOZQDITCazTOXTXgNDKw7sj
 jQzkqz36Df6bS/yNGaHi6UyqvO8c4UwHl3RcRB0tLSAvzLkLJDZx7aWZnL2xDNVZ
 qDL3ePYbRDx1kmLEr7Eyb9ULyoukeSc8PYO+dKXgYLfpYib0IeYb0Xz4T5xIh6Lm
 jRO+xaNkvFlO38wiRxVzyC56O2lnKsFlXikfFzu8MMe4HRORCg5pA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske23xr7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:30:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlXfp1233805; Thu, 24 Sep 2026 22:30:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ec7u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:30:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OMU05c52887874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 22:30:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C872558050;
 Thu, 24 Sep 2026 22:30:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D13258045;
 Thu, 24 Sep 2026 22:29:59 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 22:29:59 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v5 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
Date: Thu, 24 Sep 2026 18:29:45 -0400
Message-ID: <20260924222949.147720-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924222949.147720-1-zycai@linux.ibm.com>
References: <20260924222949.147720-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V_t2fCJaeS8SfxjuDMAzBO7hkYgzU1l5
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab5a46b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=Iu4lfvU6lRjo1WYjJIoA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX6/eT0eSwoNv/
 omf7+ScWnMrhHX3CC+G0DrCKPYjSsUZrOG24oyZ4+Up+w5EuK06h7dmM3nOLZveyGwu4KN/TB5g
 dL5BC7zvA+Okrjlf2yNUca10s0k34GE=
X-Proofpoint-GUID: V_t2fCJaeS8SfxjuDMAzBO7hkYgzU1l5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX0E+RimakV6ln
 BGxp6ZHkqTbSlF8FT/5zj7tVDK87a83SU4Q6mGZKvsERuannBWhZwjUC5VeDvbtv1CpYxr5aVPC
 DcITpmsAmVeZCvzSgkIEGWOOWTzC/uN5XNVvQax8b3mo/VHgAO1i3x3X0C6u+ba6QaUftjALWr0
 hxVSyNRimanhB3EoYMFm4smWUfGA0TKpRVYoMbXtbvDTNqeIxyeFZuqes2PhSZ0k8ghNX69A4ie
 pSdrsHQynrvKQaV1mDStKAKdgtT/wOz/Vnf1SypRk1KDa4hqJzyOeO0WVXODqyBOPyA422mHbLX
 U1PpOznu3ZtFBkrnjKfkdHUZAAVIrJone3H/Q4YVdvVgL1WwBGnZFdWKfG6MF6DlTf4iFiDVP/D
 KcntIljLYFjW2pTD7cye7dfZqJ3MloTt8MRXdvgmgfhggf1Pk2ojfHCZ5HqN41lW6Ol0hJECduV
 KFRzQBLU2+sxlrUxZSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240090
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
 pc-bios/s390-ccw/virtio-pci.c | 20 +++++++++++++++++
 4 files changed, 62 insertions(+), 9 deletions(-)

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
index 277c3ea68d..eb47e7c534 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -56,6 +56,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
     case 0x1004:
         vdev->dev_type = VIRTIO_ID_SCSI;
         break;
+    case 0x1041:
+    case 0x1000:
+        vdev->dev_type = VIRTIO_ID_NET;
+        break;
     default:
         vdev->dev_type = 0;
     }
@@ -223,6 +227,17 @@ static int virtio_pci_get_scsi_config(void)
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
@@ -355,6 +370,7 @@ bool virtio_pci_is_supported(VDev *vdev)
         switch (vdev->dev_type) {
         case VIRTIO_ID_BLOCK:
         case VIRTIO_ID_SCSI:
+        case VIRTIO_ID_NET:
             return true;
         default:
             return false;
@@ -414,6 +430,10 @@ int virtio_pci_setup(VDev *vdev)
         vdev->cmd_vr_idx = 2;
         virtio_pci_get_scsi_config();
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


