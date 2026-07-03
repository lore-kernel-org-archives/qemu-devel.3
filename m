Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB559C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfa-0000Ba-C1; Thu, 02 Jul 2026 22:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfX-00008W-HF; Thu, 02 Jul 2026 22:30:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfV-0003S5-1z; Thu, 02 Jul 2026 22:30:19 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631Iujb1151614; Fri, 3 Jul 2026 02:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=X6HKAkf8RA3YZ51Ru
 q3a0g/ukNaNC9oVnBhA2kpOIww=; b=rf8kOdPw9k6ta11dRmoVJsv9ec14ZpHak
 1PJwZTflRMHs6qrg4u9vPQ2Zx/ouC40NJl1LwxPCVUL+rHV7ltsHuCQRkTOkcrrI
 jyKKcjxBzsKXTUes0Mq8+umnoNf/IurIHsDCUiuD31GNCxiBBrtFczcVZWOiTeAP
 yMx12d+zEIwPOWNnvh0SLXyLkw0SQe1DuO46PdzRE1+D/cfBxrquVRlykKYCgHZA
 RB4irhk9r3wHgvW/hkIVhXSXP4zQ0SvEzr/y+rvENUTslUUWhEsIuG+LSRvXZ0Iw
 xFZl6giVNFQ+wq4Awp/fmnZjLd9/PTyMUp+nQSSqWMfboSNkr1ahw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk4hnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632K3Vh013183;
 Fri, 3 Jul 2026 02:30:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqpywb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632UBfs23790172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CA2658052;
 Fri,  3 Jul 2026 02:30:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 677FC5805A;
 Fri,  3 Jul 2026 02:30:09 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:09 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 16/33] pc-bios/s390-ccw: Define memory for IPLB and
 convert IPLB to pointers
Date: Thu,  2 Jul 2026 22:29:14 -0400
Message-ID: <20260703022933.1805010-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXw12noKB55LHG
 iFqfMooqcYSd5XMI3YGmCbU48MY6/JVmFla87IBUErt1NOWZvaktbfxX0eMpo6baz9OkIa8bRyq
 qLH20hU5QwbYyaKDZp9VbrGEgGUMObAeW8cjG5X7iHVBaWxbtgctoDCMYZmLaNGkuHdYfefTIFf
 W6Umw7tLKfbLUmO+14feT9R1PRWd+ecxvceSMI8NhcHbnxShJ7Y9tsadOSU/z+mgHAWEdaruEP/
 fmJtKY3FTEbMZJjlfEeBqZ6inxddWIGVbe86EXMc8AOPeT3cHn0VLyHPeM9kbVqY5eRLA9+7iFA
 JjKops0K4NAASLcJTkCkGquTL2piwA+kvDDRk3RYvj8Yi0UdmNr8xJvPKf8PIQguMWpn+zbWJY9
 oYIUdmZsVOYzOSXcH1kTLYbHr0+UAVsjG46TDbkfGLmywgUSw0zm39avgx75xRxg5HTDgB8ugBN
 FxqWvmLweepsM4w8PMA==
X-Proofpoint-GUID: IIB9R3uyXrLsZMZhC5ikOhOlkzj_dVUl
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a471eb5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=_GZQR2ZoBes7ElOevS0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX0O8C8cVBFfNd
 DCRGYi6fUHWdVvp+ggFOCseu/yBVipqd+/PHdo3vhb4tPTzjtc9jQLQORq+qTDIJiO9EJ8OQGgh
 ucrLGW6FY0WZf5XUdeyce7EKwgdKdjA=
X-Proofpoint-ORIG-GUID: IIB9R3uyXrLsZMZhC5ikOhOlkzj_dVUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Define a memory space for both IPL Parameter Block (IPLB) and
IPL Information Report Block (IIRB) since IIRB is stored immediately
following IPLB.

Convert IPLB to pointer and it points to the start of the defined memory space.
IIRB points to the end of IPLB.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h |  6 ++++++
 pc-bios/s390-ccw/iplb.h     |  5 +++--
 pc-bios/s390-ccw/jump2ipl.c |  6 +++---
 pc-bios/s390-ccw/main.c     | 34 +++++++++++++++++++---------------
 pc-bios/s390-ccw/netmain.c  |  8 ++++----
 5 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 45d25264f4..9940f1457c 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -208,4 +208,10 @@ struct IplInfoReportBlock {
 };
 typedef struct IplInfoReportBlock IplInfoReportBlock;
 
+struct IplBlocks {
+    IplParameterBlock   iplb;
+    IplInfoReportBlock  iirb;
+};
+typedef struct IplBlocks IplBlocks;
+
 #endif
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 926e8eed5d..c92a3d0f0c 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -20,8 +20,9 @@
 #include <string.h>
 
 extern QemuIplParameters qipl;
-extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+extern IplParameterBlock *iplb;
 extern bool have_iplb;
+extern IplBlocks ipl_blocks;
 
 static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
 {
@@ -61,7 +62,7 @@ static inline bool load_next_iplb(void)
 
     qipl.index++;
     next_iplb = (IplParameterBlock *) qipl.next_iplb;
-    memcpy(&iplb, next_iplb, sizeof(IplParameterBlock));
+    memcpy(iplb, next_iplb, sizeof(IplParameterBlock));
 
     qipl.chain_len--;
     qipl.next_iplb = qipl.next_iplb + sizeof(IplParameterBlock);
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 86321d0f46..fa2ca5cbe1 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -43,11 +43,11 @@ int jump_to_IPL_code(uint64_t address)
      * The IPLB for QEMU SCSI type devices must be rebuilt during re-ipl. The
      * iplb.devno is set to the boot position of the target SCSI device.
      */
-    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
-        iplb.devno = qipl.index;
+    if (iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {
+        iplb->devno = qipl.index;
     }
 
-    if (have_iplb && !set_iplb(&iplb)) {
+    if (have_iplb && !set_iplb(iplb)) {
         panic("Failed to set IPLB");
     }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26287cfd81..b8f836c682 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -24,7 +24,9 @@
 static SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
 QemuIplParameters qipl;
-IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+/* Ensure that IPLB and IIRB are page aligned and sequential in memory */
+IplBlocks ipl_blocks __attribute__((__aligned__(PAGE_SIZE)));
+IplParameterBlock *iplb;
 bool have_iplb;
 static uint16_t cutype;
 LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
@@ -53,7 +55,7 @@ void write_subsystem_identification(void)
 void write_iplb_location(void)
 {
     if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
-        lowcore->ptr_iplb = ptr2u32(&iplb);
+        lowcore->ptr_iplb = ptr2u32(iplb);
     }
 }
 
@@ -213,14 +215,14 @@ static void boot_setup(void)
     char lpmsg[] = "LOADPARM=[________]\n";
     VDev *vdev = virtio_get_device();
 
-    if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
-        ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
+    if (have_iplb && memcmp(iplb->loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
+        ebcdic_to_ascii((char *) iplb->loadparm, loadparm_str, LOADPARM_LEN);
     } else {
         sclp_get_loadparm_ascii(loadparm_str);
     }
 
     if (have_iplb) {
-        vdev->ipl_type = iplb.pbt;
+        vdev->ipl_type = iplb->pbt;
         menu_setup(vdev);
     } else {
         vdev->ipl_type = QEMU_DEFAULT_IPL;
@@ -244,21 +246,21 @@ static bool find_boot_device(void)
     switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
         vdev->scsi_device_selected = false;
-        debug_print_int("device no. ", iplb.ccw.devno);
-        blk_schid.ssid = iplb.ccw.ssid & 0x3;
+        debug_print_int("device no. ", iplb->ccw.devno);
+        blk_schid.ssid = iplb->ccw.ssid & 0x3;
         debug_print_int("ssid ", blk_schid.ssid);
-        found = find_subch(iplb.ccw.devno);
+        found = find_subch(iplb->ccw.devno);
         break;
     case S390_IPL_TYPE_QEMU_SCSI:
         vdev->scsi_device_selected = true;
-        vdev->selected_scsi_device.channel = iplb.scsi.channel;
-        vdev->selected_scsi_device.target = iplb.scsi.target;
-        vdev->selected_scsi_device.lun = iplb.scsi.lun;
-        blk_schid.ssid = iplb.scsi.ssid & 0x3;
-        found = find_subch(iplb.scsi.devno);
+        vdev->selected_scsi_device.channel = iplb->scsi.channel;
+        vdev->selected_scsi_device.target = iplb->scsi.target;
+        vdev->selected_scsi_device.lun = iplb->scsi.lun;
+        blk_schid.ssid = iplb->scsi.ssid & 0x3;
+        found = find_subch(iplb->scsi.devno);
         break;
      case S390_IPL_TYPE_PCI:
-        found = find_fid(iplb.pci.fid);
+        found = find_fid(iplb->pci.fid);
         break;
     default:
         puts("Unsupported IPLB");
@@ -377,10 +379,12 @@ static void probe_boot_device(void)
 
 void main(void)
 {
+    iplb = &ipl_blocks.iplb;
+
     copy_qipl();
     sclp_setup();
     css_setup();
-    have_iplb = store_iplb(&iplb);
+    have_iplb = store_iplb(iplb);
     if (!have_iplb) {
         boot_setup();
         probe_boot_device();
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 651cedf6ef..9b4dfd4638 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -528,11 +528,11 @@ static bool virtio_setup(void)
      */
     enable_mss_facility();
 
-    if (have_iplb || store_iplb(&iplb)) {
-        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
-        dev_no = iplb.ccw.devno;
+    if (have_iplb || store_iplb(iplb)) {
+        IPL_assert(iplb->pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
+        dev_no = iplb->ccw.devno;
         debug_print_int("device no. ", dev_no);
-        net_schid.ssid = iplb.ccw.ssid & 0x3;
+        net_schid.ssid = iplb->ccw.ssid & 0x3;
         debug_print_int("ssid ", net_schid.ssid);
         found = find_net_dev(&schib, dev_no);
     } else {
-- 
2.54.0


