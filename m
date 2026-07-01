Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3DEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1t8-0003bl-Sy; Wed, 01 Jul 2026 16:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1t2-0003TS-Ap; Wed, 01 Jul 2026 16:50:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1sz-0004KJ-Dk; Wed, 01 Jul 2026 16:50:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GmlMu1455752; Wed, 1 Jul 2026 20:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rHIhs21YxKUUf7jAp
 c7uBL0KiGOWi/SidEL+PlvIWag=; b=AxlgtwiNfQa3KON8PWEDBBCv31QhzxvrB
 fjD8GdCo+NwRs4dLLHkji1BHJFedjK9C2YufgZxcJ6DDNEvvCM4b6hgM9xqvaGSQ
 2oQILvzV7wCnKGQX+p0arKkiui61ck9bzbeA5RA6c9fJVoIW24zCLf1odep6cDRd
 rpfBCl3h1Z/eaT0vL+cMH+QC2n6FnpO6EEfsuY2MPa2v7xcC3ALafAxqa0T8PEcM
 zdQ6sMQzhBGB0XdeOk0xav7WJT9vk9ogm8ybU+woOl83+wv2eq1QtLqD1G50oAe5
 7PUMX9crOOvSKd04Bu4Ftwf6hanJXygaxNV1McdbTu0WzMrTGxEEw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe6q40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KndWI006294;
 Wed, 1 Jul 2026 20:50:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhygu54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KoFjq16515732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:50:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 543C25804E;
 Wed,  1 Jul 2026 20:50:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8537C5803F;
 Wed,  1 Jul 2026 20:50:12 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:50:12 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 16/35] pc-bios/s390-ccw: Define memory for IPLB and
 convert IPLB to pointers
Date: Wed,  1 Jul 2026 16:49:02 -0400
Message-ID: <20260701204922.1320349-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TtqdfzsEB55kAVG2D0palmx-GfiSFCI9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX4NQFkGNFpz2I
 Z0v07PwhG9VBDpd6sprscJw5tmFK9MOnai8uM0dN4x6E4fnENeFE8PxOyCzS/CTrLTMGNWxrUQA
 iG0ENbpuzryZeu1CvuOPCEz3fCpVnEw=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a457d89 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=_GZQR2ZoBes7ElOevS0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXx8XPwBwJ3MOH
 yeOSS3u1rcpfAzwVTcotpylMilSF6irXMHpxJXgQ0JJHQ34eVVVaGEGCXg3v0TBojI1V33znBUA
 WiRAPT9Z1myWqvp8uxC0LTR5Q7j50x82nCBYX75QbOsx3T7bXK4o1rZ8+50r1LzQp9C62CusNcO
 F3QaGWU4cgacm3FycYzrk3jPjstdxjCoOKYZzYnv6PJRbUgNcNcRT9ofsY8/ZWADhYzTjVF7taB
 MIjfXQV52jsiSGNNKe8cZghwZCoC6UtNf7hxDqSW4gnJhszh+MD92I92xO1TeXXGN7lGbewgPkV
 kUoSHLBLTPEq8FkoaCpWRlyeei6bJg2zBrGvtee/uE/K0uGE4jFpNLCRv6A2++Mdv+c9uFCgtio
 9LKSU4Beg9SBvbtQXBNFd/vjR4G/Oo84qUfWachheObZ3RJM88TjIFgiA3Cv9D8eTBXe2qASMGy
 tfQMBztgG0myv0G+nIw==
X-Proofpoint-ORIG-GUID: TtqdfzsEB55kAVG2D0palmx-GfiSFCI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Define a memory space for both IPL Parameter Block (IPLB) and
IPL Information Report Block (IIRB) since IIRB is stored immediately
following IPLB.

Convert IPLB to pointer and it points to the start of the defined memory space.
IIRB points to the end of IPLB.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
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


