Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD782C982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKK-0006OA-Rp; Mon, 21 Sep 2026 16:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKC-0006Cc-JX; Mon, 21 Sep 2026 16:09:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKA-0005PA-GZ; Mon, 21 Sep 2026 16:09:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Yom703543; Mon, 21 Sep 2026 20:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8f67zb8Ln5umEixsm
 ylUBWTEtbHQlAuJGdPD9CvQhmc=; b=QSDoN1hmuBFRW4buviUtY6l3dqbo3TRb+
 6MuKQRk/srNv2xWcO2YtT3wcNBg4ZVupeTFd/MujkzJhr2/d5ZbsDddhHkcYDqUV
 NITwuESaYLtBCap5XGQzowjcWdHZ2mAGXA0Aw8TbVzrglijoaxQWx1/M3wQTAnr1
 VL4TbnS2Ld1WjSw9mm44IKkMYt0J/h7FmgS/PKznKLZQhQu/7dQuFTvLcd/dog8B
 6L3/pJnM+bPm1f6NM2E/ZTDsnReZlWT3bGeai7+CBuMF0N5EsHsEGcivif+m8kgf
 AldFunb+1SqiYnu6mZPEUXNoiQ4qmAMyRxvyB5iCYU3yALVmd0tyg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqa9e1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJGO1i167243; Mon, 21 Sep 2026 20:08:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk9f17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8lpQ24904430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A2058059;
 Mon, 21 Sep 2026 20:08:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F349C58055;
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 26/33] pc-bios/s390-ccw: Use bus specific IPL_TYPE directly for
 scsi IPL
Date: Mon, 21 Sep 2026 16:08:23 -0400
Message-ID: <20260921200830.1302919-27-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab18ed1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9ItSZUHxVnaaG6JHy3sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX2fcOf0s54nZl
 21T82+OKkNe2fT3xvNy7uQTGLxEm1k+SXrrlGP4MbU8v5pqF6EbPPXqfQovb4DuuWq+BpExC4X0
 L5s2sKnLHupTYuQDxiqpdeVFFgWtAvzo/gGfZv32+b6psovyFwY9dVwp57bRrf2pRkP6y+O2QiE
 c57yBL7jUtcWHu6cQXauF/hf9ngB02xxC5uliPc2BGoVqAsWPmDhrc/F//B/tjXi0UMS1b+Z/kY
 hhO9dZw37HG4kUAgdEbLPUyWgUXhEblBoE+/OeXslPwposOn0aR7HYLTbxsyX6iMBCde64dZAOc
 IsL0ncnRw+yX64EyixnBXS2TFS2UKOnx1oh/HxXIE61z8xv2qHlRVu7D60WxbG4jolu0Op2dNwm
 y7sul9x9vxDVB5EyjsxI8zktrnT5eI2EES1Ip5rwszI6xSQH7betTqLjNEMKvnid9ccEdQO0mxw
 6nB5oDxY18W2LmoNn+A==
X-Proofpoint-ORIG-GUID: E0Cy-jUCr_PMYiH-XFGcYXUbXvX3VKIp
X-Proofpoint-GUID: E0Cy-jUCr_PMYiH-XFGcYXUbXvX3VKIp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX/+n+45RR3lUm
 z1r5x/RE7/wh0kOwicQWbfMAR8voS8v7gXxs0+ft/M4yiBYQRpORinqBYZ2RiEGxWpDv8j7ftAT
 IaYNSg6BrCUVyDD/xPb/UjlehfChH0U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
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

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-4-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c          | 13 ++++++++++---
 pc-bios/s390-ccw/virtio-blkdev.c |  1 -
 pc-bios/s390-ccw/virtio.c        |  5 -----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8fc1cbf653..6ab2b8f75b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -261,8 +261,16 @@ static bool find_boot_device(void)
         vdev->selected_scsi_device.channel = iplb->scsi.channel;
         vdev->selected_scsi_device.target = iplb->scsi.target;
         vdev->selected_scsi_device.lun = iplb->scsi.lun;
-        blk_schid.ssid = iplb->scsi.ssid & 0x3;
-        found = find_subch(iplb->scsi.devno);
+        vdev->ipl_type = iplb->scsi.bus;
+        switch (vdev->ipl_type) {
+        case S390_IPL_TYPE_CCW:
+            blk_schid.ssid = iplb->scsi.ssid & 0x3;
+            found = find_subch(iplb->scsi.devno);
+            break;
+        default:
+            puts("Unrecognized SCSI controller");
+            break;
+        }
         break;
      case S390_IPL_TYPE_PCI:
         found = find_fid(iplb->pci.fid);
@@ -346,7 +354,6 @@ static void ipl_pci_device(void)
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
2.55.0


