Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B6AC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkc-0002Xz-8g; Tue, 11 Aug 2026 10:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnka-0002Uv-Dh; Tue, 11 Aug 2026 10:46:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkY-0003ff-Iz; Tue, 11 Aug 2026 10:46:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWP9B537270; Tue, 11 Aug 2026 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aRUFxnf4xEDz8RkjY
 lHxhP0Etlur8sVgIvgQtb45lxs=; b=BcOnXFBXiiE4ZR1UEnnRbynAJwcjHYs9m
 dsaZbkyZvUZPZFJivLr8DkGo6Lhyd/1tKM29UoXFewPRkFW10y81EcoCUX1IeWN9
 0ZD89ibfC2xcnET0GbYcmibE28F0jk37oZms8f8G4Bc4Td0m2OObfF63esNVCEms
 durV7wBBJvflqIAOqXSB4Lvo2TcQN9mGOsrGPv7XHAXn66m2j22KOiI9Bk+Lrr/k
 bVUWWdWcbgqWth8jgtNou/L8mOjdtRwkULYfUT0GxZY4lD7Bf0peFRb4aRK9StJg
 OAUJfshS8R1Fs7LGBlCJXH/6IoULVprBpdfXqCKZYm0hHcFvbXIkQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9ng4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfHRa001973;
 Tue, 11 Aug 2026 14:46:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1ga5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEk0fM20775624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EE1958059;
 Tue, 11 Aug 2026 14:46:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8410B58043;
 Tue, 11 Aug 2026 14:46:37 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:37 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 4/8] pc-bios/s390-ccw: Use bus specific IPL_TYPE directly
 for scsi IPL
Date: Tue, 11 Aug 2026 10:46:25 -0400
Message-ID: <20260811144629.866641-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXzJmxBoEaCNkS
 BBnu0OJVqHtKu9IRjM7hFa1WNq34lyYpq34Ff8vHzIpec2tPAnLxNSs+npy3/b2iIG98acnHIhY
 7LEkgwCpo9gP13k0L/HTvr4E0BBekBr733/lQ+V48wgRZ5/Fk8p7ymiO/YrRtpp87bfnRZyKkrZ
 n7xXTGHrs9OJxNeNOZcymwzaSHQ8fkRmRJk+m0d+y4xnGNV2niXuoLJVUWnF48QexlY7xciP7a5
 27wBoOAxKTUs4ZO2acTbr3eCaA3t0NulXhENeVPblAM4ROiTp0oUO3m3veGG1C5qsuYhCFoF34m
 cs+9WKF5Yt/NSNY3NDp1wJGQLj2F0LvWPoGNr4fcDUk9TwsrhqitcRNM4XmZBNSe3YeHTP7tZ2W
 JtVIAgmZc088lQNEy/Lz+iKXjpwB2WlLceUTfDbjReBYyHGankDdZwQILjyoPFayUoA83Z0Ibuz
 XmbPVuFWTn07e0MJraQ==
X-Proofpoint-ORIG-GUID: klI6wTQfOq_L-xekb5gNovhHU3clVKwO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXzAA/9BR0p/Vh
 AUB8iHjptjirFCtpbzmzVWrHxL5HtYxUPOkXE6p7LHE3QOS4CUnXNXV87EXuLUjXuYzN4votqZF
 YblHk5cuuHi3el27uA4OlcdaYMw+TLQ=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b35d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=__HpbD2NEqU3pYqaDEYA:9
X-Proofpoint-GUID: klI6wTQfOq_L-xekb5gNovhHU3clVKwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

From: Jared Rossi <jrossi@linux.ibm.com>

All existing switch cases that handle S390_IPL_TYPE_QEMU_SCSI directly fall
through to S390_IPL_TYPE_CCW.  Rather than always fall through, reassign
vdev->ipl_type to the appropriate bus for the scsi controller and proceed
as usual, where the bus is designated by the "bus" field and set during
the IPLB build.

Because S390_IPL_TYPE_QEMU_SCSI should not appear as an ipl_type once the
device is found, remove that specific case from other existing switches
and allow it to land in the default case, which will generally result
in an immediate error.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c          | 13 ++++++++++---
 pc-bios/s390-ccw/virtio-blkdev.c |  1 -
 pc-bios/s390-ccw/virtio.c        |  5 -----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8bc6e8eaa3..63692260a4 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -257,8 +257,16 @@ static bool find_boot_device(void)
         vdev->selected_scsi_device.channel = iplb.scsi.channel;
         vdev->selected_scsi_device.target = iplb.scsi.target;
         vdev->selected_scsi_device.lun = iplb.scsi.lun;
-        blk_schid.ssid = iplb.scsi.ssid & 0x3;
-        found = find_subch(iplb.scsi.devno);
+        vdev->ipl_type = iplb.scsi.bus;
+        switch (vdev->ipl_type) {
+        case S390_IPL_TYPE_CCW:
+            blk_schid.ssid = iplb.scsi.ssid & 0x3;
+            found = find_subch(iplb.scsi.devno);
+            break;
+        default:
+            puts("Unrecognized SCSI controller");
+            break;
+        }
         break;
      case S390_IPL_TYPE_PCI:
         found = find_fid(iplb.pci.fid);
@@ -342,7 +350,6 @@ static void ipl_pci_device(void)
 static void ipl_boot_device(void)
 {
     switch (virtio_get_device()->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         ipl_ccw_device();
         break;
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 98b6cec3a0..83a1185dd5 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -253,7 +253,6 @@ int virtio_blk_setup_device(VDev *vdev)
     puts("Using virtio-blk.");
 
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_setup(vdev);
     case S390_IPL_TYPE_PCI:
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index a0d249db24..0b33544144 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -61,7 +61,6 @@ char *virtio_get_ring_area(int ring_num)
 int drain_irqs(void)
 {
     switch (vdev.ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return drain_irqs_ccw(vdev.schid);
     default:
@@ -109,7 +108,6 @@ void vring_init(VRing *vr, VqInfo *info)
 bool vring_notify(VRing *vr)
 {
     switch (vdev.ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
@@ -130,7 +128,6 @@ bool vring_notify(VRing *vr)
 bool be_ipl(void)
 {
     switch (virtio_get_device()->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return true;
     case S390_IPL_TYPE_PCI:
@@ -231,7 +228,6 @@ int vring_wait_reply(void)
 int virtio_reset(VDev *vdev)
 {
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_reset(vdev);
     case S390_IPL_TYPE_PCI:
@@ -244,7 +240,6 @@ int virtio_reset(VDev *vdev)
 bool virtio_is_supported(VDev *vdev)
 {
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_is_supported(vdev);
     case S390_IPL_TYPE_PCI:
-- 
2.54.0


