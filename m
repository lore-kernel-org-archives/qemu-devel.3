Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A66CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB1r-0007Bi-Q5; Sat, 17 Oct 2026 16:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0e-0005uW-MW; Sat, 17 Oct 2026 16:28:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0c-0003x5-Vg; Sat, 17 Oct 2026 16:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268838; bh=b7xkjTBsF9ZvVjOy6rFxJMSpZBaWEGNLu9oZjM3tevg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ik6fUy1k+JXBA6j3lWkEjHz0cOsr6q6fWMjGqdjuJMCJMlbebJwM7PbKA3nJEqDCE
 jVaf7YB3P5skxf2QwRxL8rIlMsn8bmn/ZAczqPc60Vo8g3395cwmucRZUapE5V78T1
 MYg3B3xQAcs5nFCTsHffS96+II6SARC/rH4B5DnBftst66uC/9bdJNtTKwi8KRVxAz
 XogQrp2RFUZ9Ef3Qhp+D9fAPJ42MuBEUYb/22gJf8RH+IZrXNRPIBR5uALitjZ+d8S
 NbJafCWE7wqbhrkDOFD6EwHvfYXLtpoq/8XgldnrGBMmt9hghi/Cvewba+Nf6j0mkh
 G7nCkxeP//UKg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E26271DE74A;
 Sat, 17 Oct 2026 23:27:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 311AB443421;
 Sat, 17 Oct 2026 23:27:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 15/73] hw/usb/dev-smartcard-reader: validate interrupt
 transfer length
Date: Sat, 17 Oct 2026 23:25:33 +0300
Message-ID: <20261017202638.728621-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A guest can submit an interrupt IN transfer shorter than the 2-byte
RDR_to_PC_NotifySlotChange message. usb_packet_copy() asserts that
the packet has enough space, so a zero- or one-byte request triggers
an assertion failure, crashing QEMU.

Check the transfer length before copying and stall the endpoint when
it is too short. The notification is preserved for a subsequent
properly-sized transfer.

Note: a later refactoring patch will switch to usb_packet_size(), but
this patch open-code p->iov.size for consistency with the rest of the
code.

Fixes: CVE-2026-18609
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4128
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 1847dcd96d7dbb7d4478b61e1bd7a5ca563d910c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 964c142d10..bba97a2b19 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1122,6 +1122,10 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
             break;
         case CCID_INT_IN_EP:
             if (s->notify_slot_change) {
+                if (p->iov.size < 2) {
+                    p->status = USB_RET_STALL;
+                    break;
+                }
                 /* page 56, RDR_to_PC_NotifySlotChange */
                 buf[0] = CCID_MESSAGE_TYPE_RDR_to_PC_NotifySlotChange;
                 buf[1] = s->bmSlotICCState;
-- 
2.47.3


