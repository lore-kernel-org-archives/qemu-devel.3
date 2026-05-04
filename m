Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2784CD342F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1b2-000200-48; Mon, 04 May 2026 18:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ac-0001vd-3Y; Mon, 04 May 2026 18:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1aQ-0002rK-Vg; Mon, 04 May 2026 18:16:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644DtBnW2799040; Mon, 4 May 2026 22:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9s1408RELOIbhfnBg
 1uNbnxAyiluQ7ImoKZEZVXoL+0=; b=I82vO8aDBC2EoSfWu4jDgGwUTyedcPb+Y
 ADM8iSj6Tgdk04zFjH+f1dS/mqFTYaYNN8urM2ktrfQwrpSpHLAi1eKafaP5Ja37
 7QLQbRvoTvIQb7V8h+sL6dwezoopNy648OHgQCbRk3NiKZzZn3wzF4aLo7oxN7S7
 BAbxHe3p2WdSUE+TdcUpZQEc6iuZcGrcyi3ph247AxTseaY8M7xiVFh8SsTMusmL
 UnKWnYZiNd9JXVNqC1YGECsDPybmciOOqsad7JvZFDFvUuKGM8o+FW5uHrtjVDU7
 nNOcf36yfggKhynykUl98Su+G+DD0cw16L4DvWle98ItsFK5vjA5w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w68vph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9tR4001293;
 Mon, 4 May 2026 22:16:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y6t41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MGK4R28443382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:16:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA1985805E;
 Mon,  4 May 2026 22:16:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DA9E58055;
 Mon,  4 May 2026 22:16:19 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:19 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 2/5] pc-bios/s390-ccw: Add per-queue notification offset for
 multi-queue virtio configurations
Date: Mon,  4 May 2026 18:16:09 -0400
Message-ID: <20260504221613.826825-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260504221613.826825-1-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f91ab5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_Y7PSZvCIfzLFVzbsK0A:9
X-Proofpoint-ORIG-GUID: aVSR5eUzCySXSXsf25xsUmPM-Ck1_xRG
X-Proofpoint-GUID: aVSR5eUzCySXSXsf25xsUmPM-Ck1_xRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfXxOjmyC/oSJFA
 L0lCNJZJNwXSID+wGWojG7g9AtZ2IXF/8J5J+uyn6EjLemYnp+kMw7bWN56yCWaLT6EEptPDUKo
 jJ1RaIKOkmnrXG7wV8ZTJt14kH4Y+RXdfFsMtNv5FJaYv0QALKZlwbccLIz1On7hLhz50rhGPnd
 asW9xDhIg5JaPrg0KL+oCOQuQebJSxU3zYfL6R0WasK39wDw37MTR6XqWzPDOUfYJVZhCJzWL63
 8cLDihqtDRDJl0hhd1btW5/48YkdO4VKZ9K5AahTBT67cQ/ynMhNi3oapJ1yCYWd5QbdN+vf6cu
 vSqrnc32MEq61ss5esSfdWt8U1w+jaeLFJHOgpEaqngV4FjlJMVFvGniA7E5U/9WTKSi4aP8V3m
 Ruergn8npJG/cdPL1NUopKuWCIcCUTb4nUXei5v4Yhq90kLR1YKYrdX6WB8csfZjsCrAJ9O01RQ
 hYTJSHWaSV3WRxWUzkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Jared Rossi <jrossi@linux.ibm.com>

The initial support for virtio-blk-pci IPL devices used a single virt-queue, but
other device types require multiple queues, and for PCI device types this also
requires a per-queue notification offset.

Add a PCI notify field to the VRing struct so that each queue has a unique
notify offset.  Also re-select the target queue before writing buffers to
ensure the proper queue is active.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio-pci.c | 36 ++++++++++++++++++++++-------------
 pc-bios/s390-ccw/virtio-pci.h |  3 ++-
 pc-bios/s390-ccw/virtio.c     |  4 +++-
 pc-bios/s390-ccw/virtio.h     |  1 +
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 53bdb52e76..736869f4f5 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -74,10 +74,10 @@ int virtio_pci_reset(VDev *vdev)
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
@@ -166,7 +166,7 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
     return 0;
 }
 
-static int vpci_set_selected_vq(uint16_t queue_num)
+int vpci_set_selected_vq(uint16_t queue_num)
 {
     return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SELECT, c_cap.bar, queue_num);
 }
@@ -332,7 +332,6 @@ int virtio_pci_setup(VDev *vdev)
     VRing *vr;
     int rc;
     uint8_t status;
-    uint16_t vq_size;
     int i = 0;
 
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
@@ -380,28 +379,39 @@ int virtio_pci_setup(VDev *vdev)
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
 
+        if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
+            puts("Failed to read virt-queue configuration");
+            return -EIO;
+        }
+
+        info.num = vq_size;
+
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar, &vq_notify)) {
+            puts("Failed to read virt-queue configuration");
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
index 90d07cb9a7..993fc285ac 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -62,9 +62,10 @@ struct VirtioPciCap {
 };
 typedef struct VirtioPciCap  VirtioPciCap;
 
+int vpci_set_selected_vq(uint16_t queue_num);
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
-long virtio_pci_notify(int vq_id);
+long virtio_pci_notify(VRing *vr);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 30e6b2bc16..00850acc2f 100644
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
@@ -154,6 +155,7 @@ static void vr_bswap_descriptor(VRingDesc *desc)
 void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
     if (!be_ipl()) {
+        vpci_set_selected_vq(vr->id);
         vr->avail->idx = bswap16(vr->avail->idx);
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
2.52.0


