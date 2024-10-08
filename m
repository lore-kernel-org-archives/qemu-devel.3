Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA1CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyq3-0004Ec-GI; Mon, 07 Oct 2024 21:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypw-0004Ai-Ts; Mon, 07 Oct 2024 21:16:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypt-0008MQ-7m; Mon, 07 Oct 2024 21:16:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980Oilw001965;
 Tue, 8 Oct 2024 01:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=euZloCm8a9GNE
 nfWZUg21vqw3h2rtbaczDvWkSYKM/w=; b=kKIdnzoeWgWbODQgz50+cEVCrdRgA
 KAA6UM23YB4P8l1K1ZBuYyksgJ8fMU2f8jMcqsa5xyYRICnReopIloJ+gNwjRjAp
 24TiqeNQcdz7AilUSyJcQM03NSFT5ax1jo5wVZ6LEQmNcWU+ehq78jOyTbDkh4O6
 6uChX4UbWuF/92mAG/Jem5HM6SICvXdHTTBxxt36eBfa3sAGP2vCFJPDWdwoNqGp
 jcxSEdRDzvNJRlfwn4+e3gHF3i7703p2PVmsQ32eW/wQKDfypCygGdXDwJXHZOQ6
 FQ/t9OqpgJyXIXDpXlVfaUJLqEW68fSzohIoKgip/VpDeEq/EjaBP+a+Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GLrh001051;
 Tue, 8 Oct 2024 01:16:21 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49813fBp013790;
 Tue, 8 Oct 2024 01:16:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss1r47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981GJMs7340562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05BCE58055;
 Tue,  8 Oct 2024 01:16:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D08C58043;
 Tue,  8 Oct 2024 01:16:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:18 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 17/19] pc-bios/s390x: Enable multi-device boot loop
Date: Mon,  7 Oct 2024 21:15:50 -0400
Message-ID: <20241008011552.2645520-18-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ni67osOLnUd0oGxsjCI28xfB1UeGE7_f
X-Proofpoint-GUID: cSwvwVh7_f_h9EELESTof0nsz0yqkxIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 pc-bios/s390-ccw/iplb.h     | 23 ++++++++++++++++++
 pc-bios/s390-ccw/jump2ipl.c |  7 +++---
 pc-bios/s390-ccw/main.c     | 47 ++++++++++++++++++++++---------------
 pc-bios/s390-ccw/netmain.c  |  3 ++-
 4 files changed, 57 insertions(+), 23 deletions(-)
---
 pc-bios/s390-ccw/iplb.h     | 23 ++++++++++++++++++
 pc-bios/s390-ccw/jump2ipl.c |  7 +++---
 pc-bios/s390-ccw/main.c     | 47 ++++++++++++++++++++++---------------
 pc-bios/s390-ccw/netmain.c  |  3 ++-
 4 files changed, 57 insertions(+), 23 deletions(-)

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
index 711a69a206..a3e5d55499 100644
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
index d7c457e0ed..1b05174ace 100644
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
@@ -271,11 +275,9 @@ static void ipl_boot_device(void)
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
-        if (virtio_setup()) {
-            return;    /* Only returns in case of errors */
+        if (virtio_setup() == 0) {
+            zipl_load();
         }
-        zipl_load();
-        break;
     default:
         printf("Attempting to boot from unexpected device type 0x%X", cutype);
     }
@@ -298,7 +300,6 @@ static void probe_boot_device(void)
             }
             if (ret == true) {
                 ipl_boot_device(); /* Only returns if unsuccessful */
-                return;
             }
         }
     }
@@ -308,14 +309,22 @@ static void probe_boot_device(void)
 
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
index 0c2329c752..5e62ea2724 100644
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
         IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
         dev_no = iplb.ccw.devno;
         debug_print_int("device no. ", dev_no);
-- 
2.45.1


