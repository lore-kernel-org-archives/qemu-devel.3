Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD08D3C927
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2KmW-0000Li-9M; Sat, 19 Oct 2024 21:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Km5-0008Ux-Ff; Sat, 19 Oct 2024 21:30:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Km3-0005RM-E4; Sat, 19 Oct 2024 21:30:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JLQxvT008451;
 Sun, 20 Oct 2024 01:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VdrsLLGQBfeXMjBpw
 NW/MVttg8IBmqSrZLc6ds9qbrU=; b=R6JXG/6/RzqAH8w20toHd2UmlbP4Ik1pB
 iT281jDd0k64lJUfEZiiFuNvEKugoDOp/Yff6gMKiaJ7Flniu2A6kRUGcgPIW9Ch
 6JpCSuD7fG+qbh5rT2FFcbzAa2rxWHYR8CdhNkvmnZSerPrNpCjkHSg+UYZmXwY+
 ZFRXwuukrzMo4GCsdhOMDA1RObfet2kxA/AA1/NUYm1KKZxBTpsoD6H193EUp7ne
 dEYJGin4e5E8q0b8KsrET+ml/qQnIO+0WtRIUqDCAC2T59P2bgPxKNrUGkPBA3R0
 2NOdSDGTH86micUCxqy98L/Aoc/bQZ3v8cY54kI1hj1//8FFlgpuw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hm376y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K0bIqZ028885;
 Sun, 20 Oct 2024 01:30:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cqfx84yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1UNTg49414438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6A8658054;
 Sun, 20 Oct 2024 01:30:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 438115805D;
 Sun, 20 Oct 2024 01:30:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:22 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 17/19] pc-bios/s390x: Enable multi-device boot loop
Date: Sat, 19 Oct 2024 21:29:51 -0400
Message-ID: <20241020012953.1380075-18-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YiBcfiRNY6Xv63td80alpiIC9sz4Wu0P
X-Proofpoint-GUID: YiBcfiRNY6Xv63td80alpiIC9sz4Wu0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=957 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Allow attempts to boot from multiple IPL devices. If the first device fails to
IPL, select the pre-built IPLB for the next device in the boot order and attempt
to IPL from it. Continue this process until IPL is successful or there are no
devices left to try.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/iplb.h     | 24 ++++++++++++++++++++
 pc-bios/s390-ccw/jump2ipl.c |  7 +++---
 pc-bios/s390-ccw/main.c     | 45 +++++++++++++++++++++++--------------
 pc-bios/s390-ccw/netmain.c  |  2 +-
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 16643f5879..08f259ff31 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -17,9 +17,11 @@
 #endif
 
 #include <qipl.h>
+#include <string.h>
 
 extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+extern bool have_iplb;
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
@@ -49,4 +51,26 @@ static inline bool set_iplb(IplParameterBlock *iplb)
     return manage_iplb(iplb, false);
 }
 
+/*
+ * The IPL started on the device, but failed in some way.  If the IPLB chain
+ * still has more devices left to try, use the next device in order.
+ */
+static inline bool load_next_iplb(void)
+{
+    IplParameterBlock *next_iplb;
+
+    if (qipl.chain_len < 1) {
+        return false;
+    }
+
+    qipl.index++;
+    next_iplb = (IplParameterBlock *) qipl.next_iplb;
+    memcpy(&iplb, next_iplb, sizeof(IplParameterBlock));
+
+    qipl.chain_len--;
+    qipl.next_iplb = qipl.next_iplb + sizeof(IplParameterBlock);
+
+    return true;
+}
+
 #endif /* IPLB_H */
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 99d18947d1..86321d0f46 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -45,9 +45,10 @@ int jump_to_IPL_code(uint64_t address)
      */
     if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
         iplb.devno = qipl.index;
-        if (!set_iplb(&iplb)) {
-            panic("Failed to set IPLB");
-        }
+    }
+
+    if (have_iplb && !set_iplb(&iplb)) {
+        panic("Failed to set IPLB");
     }
 
     /*
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index ab4709e16e..a4d1c05aac 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -23,7 +23,7 @@ static SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
-static bool have_iplb;
+bool have_iplb;
 static uint16_t cutype;
 LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
 
@@ -55,6 +55,12 @@ void write_iplb_location(void)
     }
 }
 
+static void copy_qipl(void)
+{
+    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
+    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+}
+
 unsigned int get_loadparm_index(void)
 {
     return atoi(loadparm_str);
@@ -152,6 +158,7 @@ static void menu_setup(void)
 
     /* If loadparm was set to any other value, then do not enable menu */
     if (memcmp(loadparm_str, LOADPARM_EMPTY, LOADPARM_LEN) != 0) {
+        menu_set_parms(qipl.qipl_flags & ~BOOT_MENU_FLAG_MASK, 0);
         return;
     }
 
@@ -183,7 +190,6 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
-    have_iplb = store_iplb(&iplb);
 
     if (memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
@@ -191,6 +197,10 @@ static void boot_setup(void)
         sclp_get_loadparm_ascii(loadparm_str);
     }
 
+    if (have_iplb) {
+        menu_setup();
+    }
+
     memcpy(lpmsg + 10, loadparm_str, 8);
     puts(lpmsg);
 
@@ -208,6 +218,7 @@ static bool find_boot_device(void)
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
+        vdev->scsi_device_selected = false;
         debug_print_int("device no. ", iplb.ccw.devno);
         blk_schid.ssid = iplb.ccw.ssid & 0x3;
         debug_print_int("ssid ", blk_schid.ssid);
@@ -231,15 +242,8 @@ static bool find_boot_device(void)
 static int virtio_setup(void)
 {
     VDev *vdev = virtio_get_device();
-    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
     int ret;
 
-    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
-
-    if (have_iplb) {
-        menu_setup();
-    }
-
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
         puts("Network boot device detected");
@@ -271,10 +275,9 @@ static void ipl_boot_device(void)
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
-        if (virtio_setup()) {
-            return;    /* Only returns in case of errors */
+        if (virtio_setup() == 0) {
+            zipl_load();
         }
-        zipl_load();
         break;
     default:
         printf("Attempting to boot from unexpected device type 0x%X\n", cutype);
@@ -307,14 +310,22 @@ static void probe_boot_device(void)
 
 void main(void)
 {
+    copy_qipl();
     sclp_setup();
     css_setup();
-    boot_setup();
-    if (have_iplb && find_boot_device()) {
-        ipl_boot_device();
-    } else {
+    have_iplb = store_iplb(&iplb);
+    if (!have_iplb) {
         probe_boot_device();
     }
 
-    panic("Failed to IPL. Halting...");
+    while (have_iplb) {
+        boot_setup();
+        if (have_iplb && find_boot_device()) {
+            ipl_boot_device();
+        }
+        have_iplb = load_next_iplb();
+    }
+
+    panic("No suitable device for IPL. Halting...");
+
 }
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index d1a6c9a91c..e46e470db4 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -478,7 +478,7 @@ static bool virtio_setup(void)
      */
     enable_mss_facility();
 
-    if (store_iplb(&iplb)) {
+    if (have_iplb || store_iplb(&iplb)) {
         IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
         dev_no = iplb.ccw.devno;
         debug_print_int("device no. ", dev_no);
-- 
2.45.1


