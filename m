Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB4CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wboxf-0000ID-6P; Mon, 22 Jun 2026 20:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxc-0000Dg-J2; Mon, 22 Jun 2026 20:25:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxa-0003bL-Np; Mon, 22 Jun 2026 20:25:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJng0c3936483; Tue, 23 Jun 2026 00:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=69RnOsQUdTly/FXF4
 1vQrPFeDbis0AV+JFsSzfKVpcc=; b=B8Y7V679+cOB9IrhpGxTe4AgzAMFyX7gU
 3BiM41moW4LbX7qk2p8ftTnardvpt2B58F0yqm9s+76eud9cYKeEIP0Yxy98xBVL
 sAlYvgiPkRuLucf90CG7dj0TJZp8m8xVmSMD4807jD7bJzZ70P/wu/QWoTh8Zdrk
 Km78UIO5kcDy5YrgrVGihzBSYdct3K/9bsEiT4GRATaAt7RhPdyFRSeakQJZo4V6
 WmPCh0hnBwD5JsJ+ZBjbQAORI7AqrKR318xc7d4W0yDNy5UaZMHciFhwhcxHOyNF
 6lMoHPFz/MVQ3aRxVOBY5nHbmskclb/CCfRJ3GF2isuqL67m9dLRA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gbxce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0JfDX016633;
 Tue, 23 Jun 2026 00:25:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph8nym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0PlpX24117936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:25:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E005658043;
 Tue, 23 Jun 2026 00:25:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5F8A58053;
 Tue, 23 Jun 2026 00:25:45 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.116.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 00:25:45 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH 2/5] pc-bios/s390-ccw: Add per-queue notification offset for
 multi-queue virtio configurations
Date: Mon, 22 Jun 2026 20:25:36 -0400
Message-ID: <20260623002539.126124-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260623002539.126124-1-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iKBjkNpV0mOfgj9AbJQe1yejLOTvLTnF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXwSWx49O85gDV
 qPVtIbeoZwpiPNigmAMucsZyaJS7KEpVuYb9GkVmrKQ1957nPG4UpY4kFssdRSCFlPf8+mE3Tu9
 FisiRftkv0CndewwNucgYL/x36Toqkk=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a39d28d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=J-uy_QIm2an7eANbOmAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXyZ+AQxWP4hSW
 MkIJgi8AF23GRGaRuFgXRPAU8ilvtdar+J92BDtZTTKkgZllecbARCk5/MtMMDxg5UrP7/gtnFw
 vI63ujV2ojA3XRSmLACYqUIiQIQ5DqOSY00PevgH5lfsHTdahMGiEW9IGH5CN3brYS7FZB2v7SW
 /l2vggfN3rulHUKCTDEh2qoxYEHkBj9sWMTHdnElfcCYsIwa5RbkOHfisZy1HW9bq0q8R/doh0W
 7e3rRhtxSAetU7ZChJcPb1vbUbPM5jC7GAKIOGjVWrbHrgNxPiKMio3Esn3Mff5FiNC9p0nbvtj
 96MZ8emBardL8kelkH6j7i9KgUdrwZ67CgXO7ljmgtw+uUkNW+NCCwKg6CglJ6KIuP2B+WK6HM6
 HcX+0nevGZu68FChKMsKV/ZCEW2eb5bkazy/GsRi3uJXvmXHv1eCr9/D0gHt4/OK4Jf6T7Bl5CI
 nFUByhsseex5jA/hsNw==
X-Proofpoint-ORIG-GUID: iKBjkNpV0mOfgj9AbJQe1yejLOTvLTnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

The initial support for virtio-blk-pci IPL devices used a single virt-queue, but
other device types require multiple queues, and for PCI device types this also
requires a per-queue notification offset.

Add a PCI notify field to the VRing struct so that each queue has a unique
notify offset as defined in the virtio spec.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-pci.c | 38 +++++++++++++++++++++--------------
 pc-bios/s390-ccw/virtio-pci.h |  2 +-
 pc-bios/s390-ccw/virtio.c     |  3 ++-
 pc-bios/s390-ccw/virtio.h     |  1 +
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 53bdb52e76..2c83ec4f13 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -21,7 +21,6 @@ VirtioPciCap c_cap; /* Common capabilities  */
 VirtioPciCap d_cap; /* Device capabilities  */
 VirtioPciCap n_cap; /* Notify capabilities  */
 uint32_t notify_mult;
-uint16_t q_notify_offset;
 
 static int virtio_pci_set_status(uint8_t status)
 {
@@ -74,10 +73,10 @@ int virtio_pci_reset(VDev *vdev)
     return 0;
 }
 
-long virtio_pci_notify(int vq_id)
+long virtio_pci_notify(VRing *vr)
 {
-    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
-    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
+    uint32_t offset = n_cap.off + notify_mult * vr->pci_notify;
+    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vr->id);
 }
 
 /*
@@ -301,8 +300,7 @@ static int virtio_pci_read_pci_cap_config(void)
     }
 
     rc = vpci_read_bswap32(pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
-    if (rc || vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar,
-                                &q_notify_offset)) {
+    if (rc) {
         puts("Failed to read notification queue configuration");
         return -EIO;
     }
@@ -332,7 +330,6 @@ int virtio_pci_setup(VDev *vdev)
     VRing *vr;
     int rc;
     uint8_t status;
-    uint16_t vq_size;
     int i = 0;
 
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
@@ -380,28 +377,39 @@ int virtio_pci_setup(VDev *vdev)
         return -EIO;
     }
 
-    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
-        puts("Failed to read virt-queue configuration");
-        return -EIO;
-    }
-
     /* Configure virt-queues for pci */
     for (i = 0; i < vdev->nr_vqs; i++) {
+        uint16_t vq_size;
+        uint16_t vq_notify;
         VqInfo info = {
             .queue = (unsigned long long) virtio_get_ring_area(i),
             .align = KVM_S390_VIRTIO_RING_ALIGN,
             .index = i,
-            .num = vq_size,
+            .num = 0,
         };
 
         vr = &vdev->vrings[i];
-        vring_init(vr, &info);
 
-        if (vpci_set_selected_vq(vr->id)) {
+        if (vpci_set_selected_vq(i)) {
             puts("Failed to set selected virt-queue");
             return -EIO;
         }
 
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
+            printf("Failed to read virt-queue %d size\n", i);
+            return -EIO;
+        }
+
+        info.num = vq_size;
+
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar, &vq_notify)) {
+            printf("Failed to read virt-queue %d notify offset\n", i);
+            return -EIO;
+        }
+
+        vr->pci_notify = vq_notify;
+        vring_init(vr, &info);
+
         rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
         rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
         rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 90d07cb9a7..2494df1619 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -64,7 +64,7 @@ typedef struct VirtioPciCap  VirtioPciCap;
 
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
-long virtio_pci_notify(int vq_id);
+long virtio_pci_notify(VRing *vr);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index a448dc96e2..df04479aa6 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -114,7 +114,8 @@ bool vring_notify(VRing *vr)
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
     case S390_IPL_TYPE_PCI:
-        vr->cookie = virtio_pci_notify(vr->id);
+        vr->cookie = virtio_pci_notify(vr);
+        break;
     default:
         return 1;
     }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index d32a4830ca..75ae5bdbc2 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -107,6 +107,7 @@ struct VRing {
     VRingUsed *used;
     long cookie;
     int id;
+    uint16_t pci_notify;
 };
 typedef struct VRing VRing;
 
-- 
2.54.0


