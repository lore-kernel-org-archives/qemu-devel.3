Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E42CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAg-0008NT-Tt; Wed, 30 Sep 2026 11:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAd-0008Ir-I2; Wed, 30 Sep 2026 11:24:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAb-000220-GX; Wed, 30 Sep 2026 11:24:35 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5T9i2986169; Wed, 30 Sep 2026 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=c32okVCOkmPAvk2v8
 vHyV1eP/8Mmrj3fceLNVBCS/vg=; b=IWqJ0Ra5198ky/m/KNCBp6yATJ1GvITHS
 hB4nKko7k6v/Em28EMznyvqbYJLF+H4EwHXZu1+QnncnVzc+fGh95UtkzL+8Rd2E
 zzJpv5VtAPXOrJipdUjHTtFfLpXWtxVn+nkjgpYTL0PR+lxgq0VR4TgqLY20ZnjA
 /LlDvdEmk1UoJnkkWlmKBzrNmrYefXjJIFxOUe7vL2HCbY3oFy3AcOV7G+cxG291
 psJYVXItTPGzpPzw4ecfu6J2KGAKzR1dnM7XRjTcPRQ2Di0tMDSu2Yya/p5DUqup
 R2MX/XjbHnAmTy3MsJdGEIuAwKXzCgc+B3bv/pKWUcDd97DZ8C9qA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkd8b2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE365o3605919; Wed, 30 Sep 2026 15:24:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhq2fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOUDQ23593652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0187F58065;
 Wed, 30 Sep 2026 15:24:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 805345805E;
 Wed, 30 Sep 2026 15:24:29 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:29 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 14/23] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
Date: Wed, 30 Sep 2026 11:24:11 -0400
Message-ID: <20260930152420.1956230-15-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w4wfVuonQZGVGiA7ejRECwHCvbrwynZz
X-Proofpoint-GUID: w4wfVuonQZGVGiA7ejRECwHCvbrwynZz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX8lxvg4TJjGfQ
 56Llk4QmuDBIHB2VYgoYe1YsTa8sT/Alj5RloozMKcx4X0oCq8qSJglLVeX7KnjAcoOtY+wpqD5
 sDBaufFc5lVngJRiXeBObFozSfIyqhY=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd29b0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=Iu4lfvU6lRjo1WYjJIoA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX9iAaPMfpYeHE
 RGqHYg++iJmNcsWh2QyY6OjjA7LWx7vMJE18ovluAXWd7jQOM1GwHfzUwFIsBC2E2tmS74BKzUZ
 gI11SeVP4y5FQszbPzLwEbkAAVHkaAxMDPSyuyGeOIxeKiWB+6zK6C5OWvXvHIC+DxWQKoSuNPG
 6l24NY683j/2c1DSM7dhmb7uMO+c0njckaEH5dplfoRqKta5tVb9w0MSa3EWCDqC0qhGmfrslju
 0T5n9lsgTdaTyuI5evHIW6y0pGQjfiPa0BmU/SKOui0DRQA1GUjXS6sfI5XDhq11I4FZCbt+jWd
 MQHMjiKIU0IjW5CsZQAXAG6SdaR1wCPaiVF4qzAVV3bKFsahZY4fQmZEu2XaqYrmoXPi9/oqvgU
 7BUFbWF0KzlcpJt52ndg04XaKED8q2IuunTe9mcCauIFKTCD7nQm2iImB/T7jdvVRDjuFMZdrpB
 f7d3Ot2dtk0rhvAAvXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Enable network booting via virtio-net-pci by implementing PCI transport
support for virtio-net.

This patch also extends endianness handling for virtio PCI ring operations in
little-endian to ensure correct behavior on s390x.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-5-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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


