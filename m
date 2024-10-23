Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DEFCF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFN-0006Fn-PQ; Wed, 23 Oct 2024 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFC-00069j-0x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFA-0002B0-23
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyLFJBCL8uoxwg18WzHrQmP6RKBqZyA4ytuOh0evTMQ=;
 b=EECDUKDG/XrSPio4Ftz6H6UOlha258KFiD2q1SCYLXJOq6iLQShhkbYOrHUNM3dem+4sli
 4A++bYRrbsWGyOGb/pBJeY12UIDeegMSeRNnHBGMP0JYDq5L+LcZNUd9TQvFuRRYnhcqnT
 59IRZAP4av/V95Nor6HDS7RCFyPDI5g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-rYHG84foPQGwZYNo6chcAA-1; Wed,
 23 Oct 2024 09:17:40 -0400
X-MC-Unique: rYHG84foPQGwZYNo6chcAA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BF1F1955DCF; Wed, 23 Oct 2024 13:17:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E74AE19560AE; Wed, 23 Oct 2024 13:17:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 10/23] pc-bios/s390-ccw: Remove panics from DASD IPL path
Date: Wed, 23 Oct 2024 15:16:57 +0200
Message-ID: <20241023131710.906748-11-thuth@redhat.com>
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

Remove panic-on-error from DASD IPL specific functions so that error recovery
may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-11-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/dasd-ipl.h |  2 +-
 pc-bios/s390-ccw/dasd-ipl.c | 66 ++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
index c394828906..eb1898c84a 100644
--- a/pc-bios/s390-ccw/dasd-ipl.h
+++ b/pc-bios/s390-ccw/dasd-ipl.h
@@ -11,6 +11,6 @@
 #ifndef DASD_IPL_H
 #define DASD_IPL_H
 
-void dasd_ipl(SubChannelId schid, uint16_t cutype);
+int dasd_ipl(SubChannelId schid, uint16_t cutype);
 
 #endif /* DASD_IPL_H */
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
index ae751adec1..babece95ea 100644
--- a/pc-bios/s390-ccw/dasd-ipl.c
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -111,38 +111,29 @@ static void make_readipl(void)
     ccwIplRead->count = 0x18; /* Read 0x18 bytes of data */
 }
 
-static void run_readipl(SubChannelId schid, uint16_t cutype)
+static int run_readipl(SubChannelId schid, uint16_t cutype)
 {
-    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
-        panic("dasd-ipl: Failed to run Read IPL channel program\n");
-    }
+    return do_cio(schid, cutype, 0x00, CCW_FMT0);
 }
 
 /*
  * The architecture states that IPL1 data should consist of a psw followed by
  * format-0 READ and TIC CCWs. Let's sanity check.
  */
-static void check_ipl1(void)
+static bool check_ipl1(void)
 {
     Ccw0 *ccwread = (Ccw0 *)0x08;
     Ccw0 *ccwtic = (Ccw0 *)0x10;
 
-    if (ccwread->cmd_code != CCW_CMD_DASD_READ ||
-        ccwtic->cmd_code != CCW_CMD_TIC) {
-        panic("dasd-ipl: IPL1 data invalid. Is this disk really bootable?\n");
-    }
+    return (ccwread->cmd_code == CCW_CMD_DASD_READ &&
+            ccwtic->cmd_code == CCW_CMD_TIC);
 }
 
-static void check_ipl2(uint32_t ipl2_addr)
+static bool check_ipl2(uint32_t ipl2_addr)
 {
     Ccw0 *ccw = u32toptr(ipl2_addr);
 
-    if (ipl2_addr == 0x00) {
-        panic("IPL2 address invalid. Is this disk really bootable?\n");
-    }
-    if (ccw->cmd_code == 0x00) {
-        panic("IPL2 ccw data invalid. Is this disk really bootable?\n");
-    }
+    return (ipl2_addr != 0x00 && ccw->cmd_code != 0x00);
 }
 
 static uint32_t read_ipl2_addr(void)
@@ -188,52 +179,67 @@ static void ipl1_fixup(void)
     ccwSearchTic->cda = ptr2u32(ccwSearchID);
 }
 
-static void run_ipl1(SubChannelId schid, uint16_t cutype)
+static int run_ipl1(SubChannelId schid, uint16_t cutype)
  {
     uint32_t startAddr = 0x08;
 
-    if (do_cio(schid, cutype, startAddr, CCW_FMT0)) {
-        panic("dasd-ipl: Failed to run IPL1 channel program\n");
-    }
+    return do_cio(schid, cutype, startAddr, CCW_FMT0);
 }
 
-static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
+static int run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
 {
-    if (run_dynamic_ccw_program(schid, cutype, addr)) {
-        panic("dasd-ipl: Failed to run IPL2 channel program\n");
-    }
+    return run_dynamic_ccw_program(schid, cutype, addr);
 }
 
 /*
  * Limitations in vfio-ccw support complicate the IPL process. Details can
  * be found in docs/devel/s390-dasd-ipl.rst
  */
-void dasd_ipl(SubChannelId schid, uint16_t cutype)
+int dasd_ipl(SubChannelId schid, uint16_t cutype)
 {
     PSWLegacy *pswl = (PSWLegacy *) 0x00;
     uint32_t ipl2_addr;
 
     /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
     make_readipl();
-    run_readipl(schid, cutype);
+    if (run_readipl(schid, cutype)) {
+        puts("Failed to run Read IPL channel program");
+        return -EIO;
+    }
+
     ipl2_addr = read_ipl2_addr();
-    check_ipl1();
+
+    if (!check_ipl1()) {
+        puts("IPL1 invalid for DASD-IPL");
+        return -EINVAL;
+    }
 
     /*
      * Fixup IPL1 channel program to account for vfio-ccw limitations, then run
      * it to read IPL2 channel program from boot disk.
      */
     ipl1_fixup();
-    run_ipl1(schid, cutype);
-    check_ipl2(ipl2_addr);
+    if (run_ipl1(schid, cutype)) {
+        puts("Failed to run IPL1 channel program");
+        return -EIO;
+    }
+
+    if (!check_ipl2(ipl2_addr)) {
+        puts("IPL2 invalid for DASD-IPL");
+        return -EINVAL;
+    }
 
     /*
      * Run IPL2 channel program to read operating system code from boot disk
      */
-    run_ipl2(schid, cutype, ipl2_addr);
+    if (run_ipl2(schid, cutype, ipl2_addr)) {
+        puts("Failed to run IPL2 channel program");
+        return -EIO;
+    }
 
     /* Transfer control to the guest operating system */
     pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
     pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
     jump_to_low_kernel();
+    return -1;
 }
-- 
2.47.0


