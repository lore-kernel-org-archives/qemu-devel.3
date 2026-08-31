Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9528C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180c-0000LG-JK; Mon, 31 Aug 2026 15:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180a-0000Jc-S5; Mon, 31 Aug 2026 15:49:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180Z-0002c1-1u; Mon, 31 Aug 2026 15:49:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIViua3108131; Mon, 31 Aug 2026 19:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Sx8cXbsbymOHX3RVC
 SyPfl5bosBMw6kYOtcDbmgyj6o=; b=fbxqyVq7KokjZq03pY6Lu8r2Tl51PtgeT
 7obJWZtP41Nv5JVRmaf5eNWQtqqzo2Kou6i2khi7vLhHGyUbjtiTUF1cz3bUdmsC
 M/uymOGi1iqXZdnouTrKmzbHs21D+kw8r2LoKS6CVka7i1lokjKPI0eB3IDgIeEe
 yg6Adv+ql5znGQQGIZgQQSyI0gC+mgUvRyEWSc4iFEwowq+nGs8GJNSubuWxwMCO
 zNK49Nu42JuOfjJrpu13YFzcHskkBjj2Lu9Nr04Tw1Q18WX5gBWfC+t5iHFOee80
 OqZFnjacwbtxHq00Xw9cTGHg83k04lc8JBvOVvRNxPs8gcbyrUjBw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54kgu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfOTI012875;
 Mon, 31 Aug 2026 19:49:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vyunw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnQm852560280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC7958056;
 Mon, 31 Aug 2026 19:49:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC02258052;
 Mon, 31 Aug 2026 19:49:25 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:25 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 3/8] pc-bios/s390-ccw: Use bus specific IPL_TYPE directly
 for scsi IPL
Date: Mon, 31 Aug 2026 15:49:14 -0400
Message-ID: <20260831194919.3830270-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX3u/ZIhgfZGSk
 Ysc0CAn08NWBz2ZTdIvmltBV+dqrWl+q0w8iQj343uSffvDr7ULaCY8uvPrPkw+xcCK+035Q0t5
 E8F29+zBliBx/BWq1jEgD4zt1NHuf7Z3DrFlsp7xc8mttjhBLVbRLdgtG4yviTKTZ90ea1Phbly
 egFM2trztVTN+m1ZXyK7uUIzT2TeokVKIR/7RAft1wPAvn1o+iQosflq97rfpraO1kjjF4AxaZk
 UmYmMIJDvykngzHteLLsf5s4hft1F31SL97E2jxRMs49B+8tRNTIrqR5vZcXunC1IbjTm/oiXnn
 xjuY0xj4BfpCUmaMemZzQj7LV6ynS6pXvLB9KLl77ZKxAXAsebI0/h+2CC6eP0JAuAbfnMqcgBB
 h9up6x9r5LORbVN4N9+zGIxKWU06NwCGqD5DY3LZNMO5BjQKk6YKPP4oo7ii/k0ZyhFGcmRbuXk
 vPYlcvXTYFy/PTym54Q==
X-Proofpoint-ORIG-GUID: isEJFh8IRyyhPxrASoUHhHK8kHGeNw8Z
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95dac8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=__HpbD2NEqU3pYqaDEYA:9
X-Proofpoint-GUID: isEJFh8IRyyhPxrASoUHhHK8kHGeNw8Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX8I+8p583AGNq
 7rTM47qMR67s5OCLwreujVJQLySItgm7sAtWOXMGSjztD2APl61IjJjcRno2UbYSrC7c8NsqLLs
 cv9JdWIwWw59pQtacGigcgRaHt49ILY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310169
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

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
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
2.54.0


