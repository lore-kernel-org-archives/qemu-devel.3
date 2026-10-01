Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25441CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrm-0007e7-10; Thu, 01 Oct 2026 09:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrU-0007bB-Qw
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrT-00064G-0H
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0njDjE2smV1NBkl1OrGDuxIUXpqsDVRQBewzl0VZnzQ=;
 b=V5VX6s9Ubyok0O9DpQIPlwyCmLF8VIKjLfue9Sqy2h9qhj9OMW2+vFtJxjFUpkBauF/Eh8
 xhqHbuFWgOTbVfUYCYBGz0PynkpH4ST/1brnGuFPAQVf08vqQueAbaSXhky8cjnB3eAnQf
 XtElxII3Mmedn86XNc1hkvJS9f3jTSM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-0H0IE2ydPT6k-gsZ-T-lCg-1; Thu,
 01 Oct 2026 09:30:07 -0400
X-MC-Unique: 0H0IE2ydPT6k-gsZ-T-lCg-1
X-Mimecast-MFC-AGG-ID: 0H0IE2ydPT6k-gsZ-T-lCg_1790861406
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 813FD1809CA1; Thu,  1 Oct 2026 13:30:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5619418002B6; Thu,  1 Oct 2026 13:30:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:44 +0400
Subject: [GIT PULL 05/27] hw/usb/dev-smartcard-reader: fix
 dwMaxCCIDMessageLength descriptor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-5-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3474;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/yt+O7FgKskLg67KH9wbm1hQRAAJVhwVUgrJWjmw9CY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHAHV+KOSGNgblDJg9rd6GKY3zjBUuRvtam
 KjwS6h0R4KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5binD/9ljatz6afBjMRjCVid0smdOr4CFFAbeQOF//LekJl6byIhfo56NARbqVxKMx0llu0/e3o
 +ZSF2Ar1fE0IQYYtznQbR+y2J+GMPoe6tUtuxCY2GIVnCTolMlqfrJky3lXVzs4AZ7ckHFygfky
 cVwi0qHtZsnM3ssPAkTK5GNCwVn0mbfOqy4+xDC8yP6+ErRoH8CSaqBa8jRnYvy0fIVSz9UUe7W
 cvry5AJ1msQmNfXi//dRyKRMf7WK/2mDrFYGHrMPd6lEh/zQ0UQmwBm0CLAnezEvPizM9Uxov9O
 WoY3oGyaXtNRIgrlqkIsmck1+jtbsI4LGOpgwWon7CXKQtd0XGQl2m7bMDKYk0gvZKjgXqYhvyh
 JDdtr39un9bCpx9KU/nsgMLeI3DLY74In70hIXP5RwOOC9Rfx1HFXJpHI63l5/XTWR7MXTObrec
 WwBBwtXhElu1ChRfHce5IMZwjc6O+2vq4N+aK8fklhpJ8QvJjNt30S8+I/fey4gbQknWxsrfUOA
 u18nGH0vryWTrmkAoHfhf+w6B4kaPIJ2AuTv8gubKxkYChsx255+VsnRuwdF7nvjKI0blq+4u2u
 ebM1TD24Ivsxn+MyALW7cwVI/tHVj0/rOmfXULu+SAJEcyvBseNPtXmLOZxHY1N4c/GcH2pHEui
 A9Cuuz2WQ9aWCBg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The CCID class descriptor advertises dwMaxCCIDMessageLength = 65554
(the extended-APDU maximum), but bulk-IN storage is only 384 bytes.
Since the device operates at TPDU level, the spec minimum is just
wMaxPacketSize (64 bytes), and the actual limit is the bulk-IN buffer.

Set dwMaxCCIDMessageLength to BULK_IN_BUF_SIZE (384) so the advertised
capability matches the implementation. Guard the change behind a
machine-compat property so older machine types preserve the original
descriptor for guest reproducibility.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 438624ece3d8..b30849d6f769 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -57,6 +57,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
+    { "usb-ccid", "x-accurate-message-length", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 4cb5f6e1a485..c200af41c83d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -314,6 +314,7 @@ struct USBCCIDState {
     uint8_t  powered;
     uint8_t  notify_slot_change;
     uint8_t  debug;
+    bool accurate_message_length;
 };
 
 /*
@@ -326,7 +327,7 @@ struct USBCCIDState {
  *   0dc3:1004 Athena Smartcard Solutions, Inc.
  */
 
-static const uint8_t qemu_ccid_descriptor[] = {
+static uint8_t qemu_ccid_descriptor[] = {
         /* Smart Card Device Class Descriptor */
         0x36,       /* u8  bLength; */
         0x21,       /* u8  bDescriptorType; Functional */
@@ -387,7 +388,10 @@ static const uint8_t qemu_ccid_descriptor[] = {
                      * u32 dwMaxCCIDMessageLength; For extended APDU in
                      * [261 + 10 , 65544 + 10]. Otherwise the minimum is
                      * wMaxPacketSize of the Bulk-OUT endpoint
+                     *
+                     * Corrected to BULK_IN_BUF_SIZE when x-accurate-message-length
                      */
+#define CCID_DESC_OFFSET_DW_MAX_MSG_LEN 44
         0x12, 0x00, 0x01, 0x00,
         0xFF,       /*
                      * u8  bClassGetResponse; Significant only for CCID that
@@ -1333,6 +1337,10 @@ static void ccid_realize(USBDevice *dev, Error **errp)
 {
     USBCCIDState *s = USB_CCID_DEV(dev);
 
+    if (s->accurate_message_length) {
+        stl_le_p(&qemu_ccid_descriptor[CCID_DESC_OFFSET_DW_MAX_MSG_LEN],
+                 BULK_IN_BUF_SIZE);
+    }
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     qbus_init(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev), NULL);
@@ -1449,6 +1457,8 @@ static const VMStateDescription ccid_vmstate = {
 
 static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
+    DEFINE_PROP_BOOL("x-accurate-message-length", USBCCIDState,
+                     accurate_message_length, true),
 };
 
 static void ccid_class_initfn(ObjectClass *klass, const void *data)

-- 
2.56.0.rc0.29.g47ce80527c56


