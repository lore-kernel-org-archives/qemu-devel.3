Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C7D2F7E1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 02:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Fvl-0008S5-29; Wed, 16 Oct 2024 22:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1Fvi-0008NZ-6d; Wed, 16 Oct 2024 22:07:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1Fvf-0005el-DC; Wed, 16 Oct 2024 22:07:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GNuZkw028876;
 Thu, 17 Oct 2024 02:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=flllG8Ko4g+qPLOnh
 buCJHUBu8M4x2HTNe6PcxdKSBw=; b=h71pGFFoWxG8EdvNdfRSmv6sbxN8NSB0V
 7Tky0uoKG7F+N1l4sq4yHB6o36C21pMxpX7rTsIHMpx9LapC96oOnKjADGXVW9e6
 1EL4HnpvHw/lK9+QbDEOWZahZ5gWhhLmTzhlLB/qLb7Oq3/ell0mfjcpESS9pjlp
 YPhONCMNAe6LZ6JsIZDocsvV4bzs6W8mTQXEJH1SzqU3CthcXINsCfclWNBzI5AG
 AYWdzzsbufmCVu9qxTWjSaE/B3rJranQcAU0FoX8cdXI2MmV9dKYSZjhH0rGITg/
 ZAWYFRlIeIiHV1nbQo//Vcxtrh7Phbkhb71OnJtYNvaPDKYLPH6yA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqk2gd9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 02:07:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H27qog011470;
 Thu, 17 Oct 2024 02:07:52 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqk2gd9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 02:07:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GMPwCv005286;
 Thu, 17 Oct 2024 01:48:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njc3vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49H1mEVE38601248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 01:48:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4133558056;
 Thu, 17 Oct 2024 01:48:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD62658052;
 Thu, 17 Oct 2024 01:48:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.153.16])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 01:48:13 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v4 17/19] pc-bios/s390x: Enable multi-device boot loop
Date: Wed, 16 Oct 2024 21:47:46 -0400
Message-ID: <20241017014748.829029-18-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017014748.829029-1-jrossi@linux.ibm.com>
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: taVKtaN37ULNxkmYQX114XknEG6g6Abj
X-Proofpoint-ORIG-GUID: GGC0otATvBffKJ25WbwzYoKni9AT1ywC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=965
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170008
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
 pc-bios/s390-ccw/iplb.h     | 23 ++++++++++++++++++++
 pc-bios/s390-ccw/jump2ipl.c |  7 +++---
 pc-bios/s390-ccw/main.c     | 43 +++++++++++++++++++++++--------------
 pc-bios/s390-ccw/netmain.c  |  2 +-
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 81ff9d4497..08f259ff31 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -17,6 +17,7 @@
 #endif
 
 #include <qipl.h>
+#include <string.h>
 
 extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
@@ -50,4 +51,26 @@ static inline bool set_iplb(IplParameterBlock *iplb)
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
index 4bc9ba4f04..6aa44ccd05 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -46,9 +46,10 @@ int jump_to_IPL_code(uint64_t address)
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
index 9770290958..da3394de7c 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
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
+        menu_set_parms(qipl.qipl_flags && ~BOOT_MENU_FLAG_MASK, 0);
         return;
     }
 
@@ -183,7 +190,6 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
-    have_iplb = store_iplb(&iplb);
 
     if (memcmp(iplb.loadparm, "@@@@@@@@", LOADPARM_LEN) != 0) {
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
index 0bb359e09f..d8cf3a0ef3 100644
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


