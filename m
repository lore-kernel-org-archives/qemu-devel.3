Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48EACF538C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFy-0007YH-8u; Wed, 23 Oct 2024 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFb-0007GZ-Sk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFa-0002EN-42
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=825r/da9W6GGN0H9O12QX0RuyP/yjTEZV3Q5HTxKcWc=;
 b=h/UfHIo/HkWj3O83dEMkE3AuBC7+O4+jWaCf/MxtLf/VSaCOtUkRhqvMnAuQPVzJNYlJAF
 6JtYghbw7G02PSDyveXqg7KeRHpO41Kr6JmB9nPXlPBO2yQt7MJKxjT7nexKqmKw6Q72BF
 SUKuTKlXi4c5uFdSpJ7QhN/jS2oebec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-z8JzvBTMMOGBbIBxtX5JKg-1; Wed,
 23 Oct 2024 09:18:05 -0400
X-MC-Unique: z8JzvBTMMOGBbIBxtX5JKg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C29331936118; Wed, 23 Oct 2024 13:17:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 016BE196584F; Wed, 23 Oct 2024 13:17:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 17/23] pc-bios/s390x: Enable multi-device boot loop
Date: Wed, 23 Oct 2024 15:17:04 +0200
Message-ID: <20241023131710.906748-18-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-18-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.0


