Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEEFC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZJN-00036I-Kv; Tue, 30 Jun 2026 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJL-00034z-FD; Tue, 30 Jun 2026 10:19:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJJ-0005Vc-Tb; Tue, 30 Jun 2026 10:19:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIYtJ2171574; Tue, 30 Jun 2026 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3NVBzHrsjcXoL5VrR
 sXbVgS3KofagMRdHGLr2vz295U=; b=DEX0aTl9imoYSx2DVR2qfcZQms1fjqi2B
 3U3sLkUEcPMiYVwgfNlfk7o+O3LDXn04j1sI9SmASEQ2lULOoCUkNkBNW/NqWThF
 /SWBWKshaErFDh+oa/Do8Cv8ZcQhjP5NzPFWxEZQmCBGvCG0y1gqyvSM5th+3Hnr
 Hnhz2oAk0tIQvpZweJ0GwKcwXFR8oBddNnMqeKHKxNPNNsKHfS6nt7MMICXFJ3Hi
 KS5N+grAKigDU4NBidrybj1RxcDNNIn3qw85dUeTf39hqnhgaYoIfeFQYgDD8xor
 S7gOh31/vCW4fEBfvE/R/2p11OX4I3pPYYiZGnQ3FUGA0sfhV9wsg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9xyx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UE4bqI012664;
 Tue, 30 Jun 2026 14:19:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyac8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UEJYh78323850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 14:19:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 207D45805D;
 Tue, 30 Jun 2026 14:19:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F00658053;
 Tue, 30 Jun 2026 14:19:33 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.10.219])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 14:19:32 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v2 4/6] pc-bios/s390-ccw: Verify virtio support when booting
 from virtio PCI device on s390x
Date: Tue, 30 Jun 2026 10:19:15 -0400
Message-ID: <20260630141917.673995-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630141917.673995-1-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX5SgwDJ1uN9F0
 V6j5Ez+yOhH+ACbAMOGeVkN55i6wxd+JdLAlXg7ykZKTV79TLeSJH+CxIJbrOHTCTyGxEVbIF4P
 PaYa0qoYIxvHbP5VBAJ4JXKAyWJrkkEid+w1HyLZrXYs0bInt8WLUGeIKLyPI72cG2xj6Qt/Ye4
 dX3P3CH2zJbVxAb0+nMrKm3CxCIXAnYXYdhaoQnMIEsVRcVwCmypJYoGb+FVTfVjjiu1DbQ8402
 jIdGyk/myq/FXEPRFB7BxCYZ5aXiXIi9y3MiNqKgJPpZcY8MBtrcpvpM5wVctvyS20WwMYu3vXl
 EJe5vS4rvFqen00GlUgJ8eNu4CU+BT60huZjINoRlhQ6oLsuQSQHAvGNvfY3ouMDOSEbgbI9up/
 aBVL4xY/ye3Ny/fBL/J+qWNNHtDxMlJWCDasyP21LRca/C+MjSBvR2Ddpmh4Xo9UqSFcKXKHI3l
 /uCF6InX5aDOopyihMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX/Gvqhynwi1Yt
 Dj0NeLlzzjMiSdAqsvj/TKaNwheaIYKf7biFoRUOteNWmZAuKdmYfwA5HjXAVXC+bNQiieWc+2w
 AG/kJO6OTjC6JeOsYHBvfHC6YlFKJrM=
X-Proofpoint-GUID: hZC4LRS0ZosACCqfxM9BVrKI-9kY3Qts
X-Proofpoint-ORIG-GUID: hZC4LRS0ZosACCqfxM9BVrKI-9kY3Qts
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a43d078 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2yqyArzitvNQz83JccQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300134
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio specification requires that each PCI device has a vendor ID of
0x1af4.  Verify this value before continuing with boot process.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c       |  1 +
 pc-bios/s390-ccw/virtio-pci.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h |  3 +++
 pc-bios/s390-ccw/virtio.c     |  2 ++
 pc-bios/s390-ccw/virtio.h     |  1 +
 5 files changed, 26 insertions(+)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26287cfd81..fb47d29bb1 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -163,6 +163,7 @@ static bool find_fid(uint32_t fid)
     }
 
     vdev->pci_fh = entry.fh;
+    vdev->vendor_id = entry.vendor_id;
     virtio_pci_id2type(vdev, entry.device_id);
 
     return vdev->dev_type != 0;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 2c83ec4f13..f501252c81 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -325,6 +325,20 @@ static int enable_pci_bus_master(void)
     return 0;
 }
 
+bool virtio_pci_is_supported(VDev *vdev)
+{
+    if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
+        switch (vdev->dev_type) {
+        case VIRTIO_ID_BLOCK:
+            return true;
+        default:
+            return false;
+        }
+    }
+
+    return false;
+}
+
 int virtio_pci_setup(VDev *vdev)
 {
     VRing *vr;
@@ -335,6 +349,11 @@ int virtio_pci_setup(VDev *vdev)
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
     vdev->cmd_vr_idx = 0;
 
+    if (!virtio_pci_is_supported(vdev)) {
+        puts("Virtio PCI unsupported for this device ID");
+        return -ENODEV;
+    }
+
     if (virtio_pci_read_pci_cap_config()) {
         puts("Invalid virtio PCI capabilities");
         return -EIO;
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 2494df1619..33b683bd92 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -56,6 +56,8 @@
 
 #define VIRTIO_F_VERSION_1          1   /* Feature bit 32 */
 
+#define PCI_VENDOR_VIRTIO           0x1af4
+
 struct VirtioPciCap {
     uint8_t bar;     /* Which PCIAS it's in */
     uint32_t off;    /* Offset within bar */
@@ -65,6 +67,7 @@ typedef struct VirtioPciCap  VirtioPciCap;
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
 long virtio_pci_notify(VRing *vr);
+bool virtio_pci_is_supported(VDev *vdev);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index df04479aa6..a0d249db24 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -247,6 +247,8 @@ bool virtio_is_supported(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_is_supported(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_is_supported(vdev);
     default:
         return false;
     }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 75ae5bdbc2..aa307025e0 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -259,6 +259,7 @@ struct VDev {
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
     uint32_t pci_fh;
+    uint16_t vendor_id;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
-- 
2.54.0


