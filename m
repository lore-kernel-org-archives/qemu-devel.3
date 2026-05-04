Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ACCFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1b5-00020h-91; Mon, 04 May 2026 18:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ac-0001ve-3u; Mon, 04 May 2026 18:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1aR-0002r9-6h; Mon, 04 May 2026 18:16:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644EWhv53053960; Mon, 4 May 2026 22:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=thOhMnny1Gz8L+LiP
 iGK1L2LeAATPm/tPxajxHiinu8=; b=EJ36W8E2ZIvzGk3LMcqoBMrNsRf7nLsSW
 kB8JzZK9r/Jc4p601ozv3jJNzrSrddqkiuWG825zqTXvmd5qWFwKH9HRg47ccBys
 zPhl9wMXgO906+RCzoJXhiKD/VT6zCyB5TsfTuDbkylT0jfRF37912mbxrg5Ce7g
 vcbd1JSGT+bxLWGV1+N4mqHXJvMgXvtn5ZR/e24hBsfZu8wXZBM46VudamypF8fv
 Y9c2hPUUGK0FR9GqZL2H8Oh85Tnwb0DKAmuiYLG1vx01iPW2qQLtP9+q5mZHc3XI
 o0CD4lWbv2ymbm2wdgVOPIm2cnPyC/TrPZ5SEi24f7fFhRZ/IdZrA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxgty4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9pd4017840;
 Mon, 4 May 2026 22:16:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjq1cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MFo3r25035270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:15:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E56858059;
 Mon,  4 May 2026 22:16:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85DF958043;
 Mon,  4 May 2026 22:16:17 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:17 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 1/6] s390x: Rename SCSI IPL type to indicate CCW bus
Date: Mon,  4 May 2026 18:16:08 -0400
Message-ID: <20260504221613.826825-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260504221613.826825-1-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfX5VClo8LrL8uN
 CoR7VrzZOVu0UkJHijHjHZBYzQbgln6d14+BesqEdAf7Syj1X/5Kxee6Kmpz0O+MNVP/XbqgwQ2
 tv+NLhKrF2SBxkMIOYq1FMAk32YQeS2pV9QTRNdYjqvgzMqGiGH+g/c+BBGONeIrhS5LY84jy3K
 GLgXzCMoc1c94Rz54ufi5tPae4e7Kdi9ngHhWkH1I3+ULNoU73NfC/nFumDNtnwJDXytHRRU0hG
 n6BCfgRtSYrV29BoabDCJiAePkVXtUXY40RPkdvGvL3O6OkA1YPAOgNC+1tMx5WPiv6rSy4rdCc
 w+Dq3/HtCPR6gIG5FR1rs9hzG0d2u7yMHZ/tYvUfoVWi3dscFdar7Cgbt6q9SCpga2LurgtdhfN
 65oIql+NaVXEVp6xfzb0MLsjw/qyX8JkqWVec1t0NlfqasNkysA2GbzjRoNj44BbQIT2VxgouU3
 fXtML5GIkf2aEOQqaGQ==
X-Proofpoint-ORIG-GUID: CUkOOmMndbUe6zhhnXz9QSwQaYxTw1Lo
X-Proofpoint-GUID: CUkOOmMndbUe6zhhnXz9QSwQaYxTw1Lo
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f91ab4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rdy38TgrvH7PjN8TWAUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040205
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

As IPL support is being added for some PCI devices it is necessary to specify
the bus type of the SCSI controller when booting from a SCSI device.  Therefore
the IPL type S390_IPL_TYPE_QEMU_SCSI is changed to to S390_IPL_TYPE_CCW_SCSI.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c                   | 14 +++++++-------
 hw/s390x/ipl.h                   |  2 +-
 include/hw/s390x/ipl/qipl.h      |  8 ++++----
 pc-bios/s390-ccw/jump2ipl.c      |  4 ++--
 pc-bios/s390-ccw/main.c          | 16 ++++++++--------
 pc-bios/s390-ccw/virtio-blkdev.c |  2 +-
 pc-bios/s390-ccw/virtio.c        | 12 ++++++------
 target/s390x/diag.c              |  2 +-
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 1babcd2b7d..402f5dbd7e 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -315,7 +315,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
             return;
         }
         break;
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
         break;
     default:
         if (current_machine->boot_config.has_menu && current_machine->boot_config.menu) {
@@ -477,12 +477,12 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
-            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
-            iplb->scsi.lun = cpu_to_be32(sd->lun);
-            iplb->scsi.target = cpu_to_be16(sd->id);
-            iplb->scsi.channel = cpu_to_be16(sd->channel);
-            iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
-            iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
+            iplb->pbt = S390_IPL_TYPE_CCW_SCSI;
+            iplb->ccw_scsi.lun = cpu_to_be32(sd->lun);
+            iplb->ccw_scsi.target = cpu_to_be16(sd->id);
+            iplb->ccw_scsi.channel = cpu_to_be16(sd->channel);
+            iplb->ccw_scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->ccw_scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VFIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index fac30763df..5d4c618ecf 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -182,7 +182,7 @@ static inline bool iplb_valid(IplParameterBlock *iplb)
         return len >= S390_IPLB_MIN_CCW_LEN;
     case S390_IPL_TYPE_PCI:
         return len >= S390_IPLB_MIN_PCI_LEN;
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     default:
         return false;
     }
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 8d3c83a80b..67db54c964 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -25,7 +25,7 @@ enum S390IplType {
     S390_IPL_TYPE_CCW = 0x02,
     S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
-    S390_IPL_TYPE_QEMU_SCSI = 0xff
+    S390_IPL_TYPE_CCW_SCSI = 0xff
 };
 typedef enum S390IplType S390IplType;
 
@@ -99,7 +99,7 @@ struct IplBlockFcp {
 } QEMU_PACKED;
 typedef struct IplBlockFcp IplBlockFcp;
 
-struct IplBlockQemuScsi {
+struct IplBlockCcwScsi {
     uint32_t lun;
     uint16_t target;
     uint16_t channel;
@@ -107,7 +107,7 @@ struct IplBlockQemuScsi {
     uint8_t  ssid;
     uint16_t devno;
 } QEMU_PACKED;
-typedef struct IplBlockQemuScsi IplBlockQemuScsi;
+typedef struct IplBlockCcwScsi IplBlockCcwScsi;
 
 struct IplBlockPci {
     uint32_t reserved0[76];
@@ -131,7 +131,7 @@ union IplParameterBlock {
             IplBlockCcw ccw;
             IplBlockFcp fcp;
             IPLBlockPV pv;
-            IplBlockQemuScsi scsi;
+            IplBlockCcwScsi ccw_scsi;
             IplBlockPci pci;
         };
     } QEMU_PACKED;
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 86321d0f46..f8f6b21327 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -40,10 +40,10 @@ int jump_to_IPL_code(uint64_t address)
     write_iplb_location();
 
     /*
-     * The IPLB for QEMU SCSI type devices must be rebuilt during re-ipl. The
+     * The IPLB for SCSI type devices must be rebuilt during re-ipl. The
      * iplb.devno is set to the boot position of the target SCSI device.
      */
-    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
+    if (iplb.pbt == S390_IPL_TYPE_CCW_SCSI) {
         iplb.devno = qipl.index;
     }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26287cfd81..1a9579beab 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -183,7 +183,7 @@ static void menu_setup(VDev *vdev)
 
     switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
         /* fall through */
@@ -249,13 +249,13 @@ static bool find_boot_device(void)
         debug_print_int("ssid ", blk_schid.ssid);
         found = find_subch(iplb.ccw.devno);
         break;
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
         vdev->scsi_device_selected = true;
-        vdev->selected_scsi_device.channel = iplb.scsi.channel;
-        vdev->selected_scsi_device.target = iplb.scsi.target;
-        vdev->selected_scsi_device.lun = iplb.scsi.lun;
-        blk_schid.ssid = iplb.scsi.ssid & 0x3;
-        found = find_subch(iplb.scsi.devno);
+        vdev->selected_scsi_device.channel = iplb.ccw_scsi.channel;
+        vdev->selected_scsi_device.target = iplb.ccw_scsi.target;
+        vdev->selected_scsi_device.lun = iplb.ccw_scsi.lun;
+        blk_schid.ssid = iplb.ccw_scsi.ssid & 0x3;
+        found = find_subch(iplb.ccw_scsi.devno);
         break;
      case S390_IPL_TYPE_PCI:
         found = find_fid(iplb.pci.fid);
@@ -339,7 +339,7 @@ static void ipl_pci_device(void)
 static void ipl_boot_device(void)
 {
     switch (virtio_get_device()->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         ipl_ccw_device();
         break;
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 98b6cec3a0..40631e0c0f 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -253,7 +253,7 @@ int virtio_blk_setup_device(VDev *vdev)
     puts("Using virtio-blk.");
 
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_setup(vdev);
     case S390_IPL_TYPE_PCI:
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 390b55c7b9..30e6b2bc16 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -61,7 +61,7 @@ char *virtio_get_ring_area(int ring_num)
 int drain_irqs(void)
 {
     switch (vdev.ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return drain_irqs_ccw(vdev.schid);
     default:
@@ -72,7 +72,7 @@ int drain_irqs(void)
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 {
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_run(vdev, vqid, cmd);
     default:
@@ -109,7 +109,7 @@ void vring_init(VRing *vr, VqInfo *info)
 bool vring_notify(VRing *vr)
 {
     switch (vdev.ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
@@ -129,7 +129,7 @@ bool vring_notify(VRing *vr)
 bool be_ipl(void)
 {
     switch (virtio_get_device()->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return true;
     case S390_IPL_TYPE_PCI:
@@ -230,7 +230,7 @@ int vring_wait_reply(void)
 int virtio_reset(VDev *vdev)
 {
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_reset(vdev);
     case S390_IPL_TYPE_PCI:
@@ -243,7 +243,7 @@ int virtio_reset(VDev *vdev)
 bool virtio_is_supported(VDev *vdev)
 {
     switch (vdev->ipl_type) {
-    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_is_supported(vdev);
     default:
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133e..06bdb2bbc8 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -133,7 +133,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
-            if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {
+            if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_CCW_SCSI) {
                 s390_rebuild_iplb(iplb->devno, iplb);
                 s390_ipl_update_diag308(iplb);
                 env->regs[r1 + 1] = DIAG_308_RC_OK;
-- 
2.52.0


