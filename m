Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7B6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraVD-0005ms-5F; Tue, 02 Apr 2024 05:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rraV9-0005lq-IE; Tue, 02 Apr 2024 05:32:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rraV3-0003sh-OI; Tue, 02 Apr 2024 05:32:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C62245B08A;
 Tue,  2 Apr 2024 12:33:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C17A4A9346;
 Tue,  2 Apr 2024 12:31:57 +0300 (MSK)
Received: (nullmailer pid 2931143 invoked by uid 1000);
 Tue, 02 Apr 2024 09:31:57 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Joonas Kankaala <joonas.a.kankaala@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/4] usb-audio: Fix invalid values in AudioControl descriptors
Date: Tue,  2 Apr 2024 12:31:54 +0300
Message-Id: <20240402093157.2931117-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402093157.2931117-1-mjt@tls.msk.ru>
References: <20240402093157.2931117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Joonas Kankaala <joonas.a.kankaala@gmail.com>

This fixes the invalid bInterfaceProtocol value 0x04 in the USB audio
AudioControl descriptors. It should be zero. While Linux and Windows
forgive this error, macOS 14 Sonoma does not. The usb-audio device does
not appear in macOS sound settings even though the device is recognized
and shows up in USB system information. According to the USB audio class
specs 1.0-4.0, valid values are 0x00, 0x20, 0x30 and 0x40. (Note also
that Linux prints the warning "unknown interface protocol 0x4, assuming
v1", but then proceeds as if the value was zero.)

This also fixes the invalid wTotalLength value in the multi-channel
setup AudioControl interface header descriptor (used when multi=on
and out.mixing-engine off). The combined length of all the descriptors
there add up to 0x37, not 0x38. In Linux, "lsusb -D ..." displays
incomplete descriptor information when this length is incorrect.

Signed-off-by: Joonas Kankaala <joonas.a.kankaala@gmail.com>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/dev-audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index d5ac1f8962..1897fff9e6 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -124,7 +124,6 @@ static const USBDescIface desc_iface[] = {
         .bNumEndpoints                 = 0,
         .bInterfaceClass               = USB_CLASS_AUDIO,
         .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
-        .bInterfaceProtocol            = 0x04,
         .iInterface                    = STRING_USBAUDIO_CONTROL,
         .ndesc                         = 4,
         .descs = (USBDescOther[]) {
@@ -282,7 +281,6 @@ static const USBDescIface desc_iface_multi[] = {
         .bNumEndpoints                 = 0,
         .bInterfaceClass               = USB_CLASS_AUDIO,
         .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
-        .bInterfaceProtocol            = 0x04,
         .iInterface                    = STRING_USBAUDIO_CONTROL,
         .ndesc                         = 4,
         .descs = (USBDescOther[]) {
@@ -293,7 +291,7 @@ static const USBDescIface desc_iface_multi[] = {
                     USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
                     DST_AC_HEADER,              /*  u8  bDescriptorSubtype */
                     U16(0x0100),                /* u16  bcdADC */
-                    U16(0x38),                  /* u16  wTotalLength */
+                    U16(0x37),                  /* u16  wTotalLength */
                     0x01,                       /*  u8  bInCollection */
                     0x01,                       /*  u8  baInterfaceNr */
                 }
-- 
2.39.2


