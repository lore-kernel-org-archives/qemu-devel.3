Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8124C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraAT-0004wD-Ap; Wed, 05 Aug 2026 07:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAQ-0004vJ-6I
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAO-0006rv-MB
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUiHw1X97TyqX/bI7AoZTQft5uT6WiNqmfbMb9Gk9HI=;
 b=cR8loqd7YEnnHnU3dNwoGXR8wi6nUcXzl4sCaa7b5Q7XLo3W595bCyVEJ+UuuvHiFWdviw
 yY5kAQkwSYlTWiLCHbufl6ZSWPOaYwHFhAEas9c9PGIxcw7YhOTZWJG7ZzChrHP9rlJx4q
 jrdvu/uAne9FCpc0crcmx65Qvh1+kzI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-H2gyfpgUNfWGVefdIGlVnQ-1; Wed,
 05 Aug 2026 07:52:10 -0400
X-MC-Unique: H2gyfpgUNfWGVefdIGlVnQ-1
X-Mimecast-MFC-AGG-ID: H2gyfpgUNfWGVefdIGlVnQ_1785930729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97ACB1956095; Wed,  5 Aug 2026 11:52:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1C5F180049F; Wed,  5 Aug 2026 11:52:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:55 +0400
Subject: [PATCH 05/27] hw/usb/dev-smartcard-reader: fix
 dwMaxCCIDMessageLength descriptor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-5-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3392;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VJfRZ/vlWPkPw50oUk6mI2+mxcxOC1M0HQBUSmgUKNM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOsgVcrdgwmGf+hKXMpk/V/Gd8djv+IPVCnY
 6d4c/M2yOCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrAAKCRDa6OEJdZac
 5TtcD/4txlfQkNsLUDEa/lckBez4FFio1+QNlhz/5pkyoOE0+sHZONzR5Y5EJsXhpnEyGIj1PDs
 rIZnvhuqw/DsxAwWWSNNmiKQ0hwbKWY6itboAGCAAaXUMWoNrdym+fWyXNUuMABAidX16ujfy2C
 0mDEpSBWwXX0aEZ7v4uvLv1VnXymwEFCMZOdlATuXuctcEdlo3c3ongwV2Yp1bI1GutGWHSxgQa
 t/yK9YkWs9I6aBSLqKlowg5bsio1P9xXk13FBYPvyp8oCZxvSANxMfJBuFqVTeuGeiUp1PRrvVV
 +D/1WCCXpUzh4x1ecYTRciHqIgmNGUBdjndg6/FvWMWTV055n9wfyMvvhVsZ5h3a/pR6GE8NI3w
 fiz2l962WluNE+f8h21EkXHlPu6r1VQh+t3xcFbW1g3j04xzwbPxlTh76dLA7/9rDHS7H/3//xl
 btK1mh71h6nrTSh6n1XroDGWad/TBq68XkRB+lUCyHXgCb2FexM5xQnUqW/NCQtc5axtXtPMazZ
 rbHxSlcGaW6ZINUsK7pVcRDBz7WTItLpywR3deHwOPfwNadq2FzpydEyKdDQMGBu0wM5KFPIDwo
 zHkc/MsTuiYMBQ5A9eK7EFrzOEMMJBSqBZMFrmRrG9RC3P80y6sJLd5x1RcBri9qg9ceo10F7do
 63U0NY7SXW64S7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 73b4d82b4a1d..01e50ebe05e0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -51,6 +51,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
+    { "usb-ccid", "x-accurate-message-length", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 3580465df368..a14062948071 100644
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
@@ -1329,6 +1333,10 @@ static void ccid_realize(USBDevice *dev, Error **errp)
 {
     USBCCIDState *s = USB_CCID_DEV(dev);
 
+    if (s->accurate_message_length) {
+        stl_le_p(&qemu_ccid_descriptor[CCID_DESC_OFFSET_DW_MAX_MSG_LEN],
+                 BULK_IN_BUF_SIZE);
+    }
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     qbus_init(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev), NULL);
@@ -1445,6 +1453,8 @@ static const VMStateDescription ccid_vmstate = {
 
 static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
+    DEFINE_PROP_BOOL("x-accurate-message-length", USBCCIDState,
+                     accurate_message_length, true),
 };
 
 static void ccid_class_initfn(ObjectClass *klass, const void *data)

-- 
2.55.0


