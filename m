Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9F4EEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdY8-0000nF-BF; Thu, 12 Feb 2026 15:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdY6-0000lk-6q; Thu, 12 Feb 2026 15:44:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdY4-0007dw-Bj; Thu, 12 Feb 2026 15:44:29 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CFw5Pc3988415; Thu, 12 Feb 2026 20:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TFR0iZ5PCu1X3gkdq
 GyqKhkaG9vNN6okuQAOj9yj6RU=; b=gfL7FfB+EmKyP5+j9wWzrinBSHUDOtIMU
 0bYC9euU4+G39ODxN/kYULU9YM28/MNAK4QCLe/pNX42sy1P8VxedafLq7bwpDc0
 ibtWUwqLV6N4yhp5jaaOXBItXUmTXbl6nTbcGiWnglJ1ZoLd/Kf/YBiW02CZDtU+
 hztG5y+ikXrBFCaiyqXj36lvE8Ntt4r5XBwheRDmfmdwsfPToLkAlUPRQHPITwwc
 VBBu8zZZ2suzeyuzsGJh7/MsKoTT5ShdRmXtH/QZmEB5HqyQwabT8eoZWjHm5cJe
 EZ0KpmbJm7WN5dF46Qk6c7YyTY0sNC9E6RPhLVQzOoSU3WyfNU9oA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wg4md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CHRXX0019336;
 Thu, 12 Feb 2026 20:44:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxkbyvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKiMhs29033132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 487975804E;
 Thu, 12 Feb 2026 20:44:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F9A58054;
 Thu, 12 Feb 2026 20:44:20 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:20 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 14/30] pc-bios/s390-ccw: Define memory for IPLB and convert
 IPLB to pointers
Date: Thu, 12 Feb 2026 15:43:35 -0500
Message-ID: <20260212204352.1044699-15-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698e3ba8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=_GZQR2ZoBes7ElOevS0A:9
X-Proofpoint-GUID: jCMrH2DYvnO8Jhx-pcuUJHJczXWsjB5p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfXzbpF0AcTsQzW
 q9CIhNPJFmlEWsBhNiSayZFzs5cQ4r7sz8DF0tR1Y9+cdqDli45MSIcnZ8JdnEGAx5cH6Hed4OZ
 jJUMN8bO6UsH21YTlBmGNIN2wCMI24m2vYhn32NFcVYROxx2Scd+7H9OsUOWitxTUHFQVFbgtI6
 s6tZYrkKxsf/rbG8jQK1I7twdbJLvjM5Pq98t9GfUIqu8b5I7oidJzOVHziDzS8DRucVY35Tg8f
 8K4lfA/HwyM8VDJuT5SyEF3NfVNI5Wimy5sc1Pnn2DwWJrez9/KStk9MG87qtmKGIxqoAhfn+Vs
 4eW5IO/C+dccgwAwRQQ+T5F/WwsvfowY8ekLvaVdj8rmpmfQQYE5LVEOrPzkcFp0zV/hSVu9KgZ
 /L0GBh9bKn4m5Ph0XpuLhpWcAILSh1kPKptb459nlw8OMFhbkH6e7YEoyUOILm/dtovici6nSoT
 r7Uq/DUa5n4VxMrNTjA==
X-Proofpoint-ORIG-GUID: jCMrH2DYvnO8Jhx-pcuUJHJczXWsjB5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/hw/s390x/ipl/qipl.h |  6 ++++++
 pc-bios/s390-ccw/iplb.h     |  5 +++--
 pc-bios/s390-ccw/jump2ipl.c |  6 +++---
 pc-bios/s390-ccw/main.c     | 34 +++++++++++++++++++---------------
 pc-bios/s390-ccw/netmain.c  |  8 ++++----
 5 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 0f1f55c428..f5e63a2fdb 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -185,4 +185,10 @@ struct IplInfoReportBlock {
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
index 08f259ff31..fefca65ac6 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -20,8 +20,9 @@
 #include <string.h>
 
 extern QemuIplParameters qipl;
-extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+extern IplParameterBlock *iplb;
 extern bool have_iplb;
+extern IplBlocks ipl_data;
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
@@ -65,7 +66,7 @@ static inline bool load_next_iplb(void)
 
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
index 76bf743900..819f053009 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -22,7 +22,9 @@
 static SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
 QemuIplParameters qipl;
-IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+/* Ensure that IPLB and IIRB are page aligned and sequential in memory */
+IplBlocks ipl_data __attribute__((__aligned__(PAGE_SIZE)));
+IplParameterBlock *iplb;
 bool have_iplb;
 static uint16_t cutype;
 LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
@@ -51,7 +53,7 @@ void write_subsystem_identification(void)
 void write_iplb_location(void)
 {
     if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
-        lowcore->ptr_iplb = ptr2u32(&iplb);
+        lowcore->ptr_iplb = ptr2u32(iplb);
     }
 }
 
@@ -162,7 +164,7 @@ static void menu_setup(void)
         return;
     }
 
-    switch (iplb.pbt) {
+    switch (iplb->pbt) {
     case S390_IPL_TYPE_CCW:
     case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
@@ -191,8 +193,8 @@ static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
 
-    if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
-        ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
+    if (have_iplb && memcmp(iplb->loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
+        ebcdic_to_ascii((char *) iplb->loadparm, loadparm_str, LOADPARM_LEN);
     } else {
         sclp_get_loadparm_ascii(loadparm_str);
     }
@@ -216,21 +218,21 @@ static bool find_boot_device(void)
     VDev *vdev = virtio_get_device();
     bool found = false;
 
-    switch (iplb.pbt) {
+    switch (iplb->pbt) {
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
     default:
         puts("Unsupported IPLB");
@@ -311,10 +313,12 @@ static void probe_boot_device(void)
 
 void main(void)
 {
+    iplb = &ipl_data.iplb;
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
index a9521dff41..457fbc3095 100644
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
2.52.0


