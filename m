Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1FCCEBF63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzDP-0004iP-R4; Thu, 26 Sep 2024 20:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzDO-0004e2-FT; Thu, 26 Sep 2024 20:52:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzDM-0007JA-IS; Thu, 26 Sep 2024 20:52:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QEPgvW014425;
 Fri, 27 Sep 2024 00:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=6e9oPsm8hQZni
 7/OB3ZD4dKfUpHqmOZqsEtdSifYz6Q=; b=q82fseRCPAdNOnhjj912qiqs63Bkb
 U2JQuKj/LUP19BFgs9ylQbTlQQVG2hzBPIjtjV5lQziicPp4VDUvAXjrW8tnsPyg
 6Ra8l3hY0li2Zm9DjHmiwP3mz7smLAitZuZoleRSuwqmGcFmGKtr+aVgMHERvYQM
 QrxcIs/VyS/dBpCBSiuT5vzwS99xwgovUjdBNk14pnUSVySmjVG9gu62nNScoSYh
 lFxU+4m284gZTq/wPzPreSWeJTeFr+OYNcL0BtSuc3I6PL6xiTu2YHGLIqM9v+B/
 pD9Th5aHtGa329ZBAMzi5YypYxGZ2lEztacgDfAnZUDbutiLW1jmI1dpQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pkQQ006877;
 Fri, 27 Sep 2024 00:51:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QLUbsm012521;
 Fri, 27 Sep 2024 00:51:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fqa62k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pjoE40698138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9C1B5805D;
 Fri, 27 Sep 2024 00:51:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7244D58052;
 Fri, 27 Sep 2024 00:51:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:44 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 17/18] pc-bios/s390x: Enable multi-device boot loop
Date: Thu, 26 Sep 2024 20:51:16 -0400
Message-ID: <20240927005117.1679506-18-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UdqBxPRqSw5MsjP2qbjuJthhza6vomRC
X-Proofpoint-GUID: Qhy5XlSIck-Ab6TPJW5JW0dYQh4omiWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=953 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 pc-bios/s390-ccw/iplb.h     | 23 +++++++++++++
 pc-bios/s390-ccw/jump2ipl.c |  7 ++--
 pc-bios/s390-ccw/main.c     | 68 +++++++++++++++----------------------
 pc-bios/s390-ccw/netmain.c  |  3 +-
 4 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 16643f5879..d58fe71974 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -17,6 +17,7 @@
 #endif
 
 #include <qipl.h>
+#include <string.h>
 
 extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
@@ -49,4 +50,26 @@ static inline bool set_iplb(IplParameterBlock *iplb)
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
index bcf0e12f02..afe1888511 100644
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
+    if (!set_iplb(&iplb)) {
+        panic("Failed to set IPLB");
     }
 
     /*
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d7c457e0ed..e38eedd83a 100644
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
+        menu_set_parms(qipl.qipl_flags && ~BOOT_MENU_FLAG_MASK, 0);
         return;
     }
 
@@ -183,7 +190,10 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
-    have_iplb = store_iplb(&iplb);
+
+    if (!have_iplb) {
+        have_iplb = store_iplb(&iplb);
+    }
 
     if (memcmp(iplb.loadparm, "@@@@@@@@", LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
@@ -191,6 +201,10 @@ static void boot_setup(void)
         sclp_get_loadparm_ascii(loadparm_str);
     }
 
+    if (have_iplb) {
+        menu_setup();
+    }
+
     memcpy(lpmsg + 10, loadparm_str, 8);
     puts(lpmsg);
 
@@ -208,6 +222,7 @@ static bool find_boot_device(void)
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
+        vdev->scsi_device_selected = false;
         debug_print_int("device no. ", iplb.ccw.devno);
         blk_schid.ssid = iplb.ccw.ssid & 0x3;
         debug_print_int("ssid ", blk_schid.ssid);
@@ -231,15 +246,8 @@ static bool find_boot_device(void)
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
@@ -281,41 +289,19 @@ static void ipl_boot_device(void)
     }
 }
 
-/*
- * No boot device has been specified, so we have to scan through the
- * channels to find one.
- */
-static void probe_boot_device(void)
-{
-    int ssid, sch_no, ret;
-
-    for (ssid = 0; ssid < 0x3; ssid++) {
-        blk_schid.ssid = ssid;
-        for (sch_no = 0; sch_no < 0x10000; sch_no++) {
-            ret = is_dev_possibly_bootable(-1, sch_no);
-            if (ret < 0) {
-                break;
-            }
-            if (ret == true) {
-                ipl_boot_device(); /* Only returns if unsuccessful */
-                return;
-            }
-        }
-    }
-
-    puts("Could not find a suitable boot device (none specified)");
-}
-
 void main(void)
 {
+    copy_qipl();
     sclp_setup();
     css_setup();
-    boot_setup();
-    if (have_iplb && find_boot_device()) {
-        ipl_boot_device();
-    } else {
-        probe_boot_device();
-    }
+    do {
+        boot_setup();
+        if (have_iplb && find_boot_device()) {
+            ipl_boot_device();
+        }
+        have_iplb = load_next_iplb();
+    } while (have_iplb);
+
+    panic("No suitable device for IPL. Halting...");
 
-    panic("Failed to IPL. Halting...");
 }
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 013f94d932..734e980c6b 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -41,6 +41,7 @@
 #define DEFAULT_TFTP_RETRIES 20
 
 extern char _start[];
+extern bool have_iplb;
 
 #define KERNEL_ADDR             ((void *)0L)
 #define KERNEL_MAX_SIZE         ((long)_start)
@@ -478,7 +479,7 @@ static int virtio_setup(void)
      */
     enable_mss_facility();
 
-    if (store_iplb(&iplb)) {
+    if (have_iplb || store_iplb(&iplb)) {
         if (iplb.pbt != S390_IPL_TYPE_CCW) {
             puts("IPL_TYPE_CCW expected");
         }
-- 
2.45.1


