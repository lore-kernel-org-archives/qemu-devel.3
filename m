Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD17C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLi-0002OQ-CU; Wed, 22 Jul 2026 08:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLh-0002Nb-9d; Wed, 22 Jul 2026 08:46:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLf-0001bW-Mk; Wed, 22 Jul 2026 08:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=F4ECVAy2vQqPctVilBFqRN1NtbN+afsw1RwjFQnROtI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w8v2BcazxZWw2noGb1iL2CCuelRYv3eALqR+7lZ3NLzIedHUyHpuwhq5niztp1Mym
 REgOUzsyd0s3HQW+mNleJIYqhPXsTv73Burc4nYXXlt8bLgn1RHbQSBPv7XgVXan+1
 sOzpCla58mBZKd26d56XYGN0IOQ8oM5lRI2KGfpZCBLWJbU0SkrM6Mc5W0LVWmecQr
 0j2s61sl2mydZHox3kUG0K+W3rS1HNZ4PaDKvVQGQaT096qWFN/LmP3UBpEuVHmKuq
 Y67QocFs9C4z8ZSS5GEvS2eswqgdYyH0VjwP5dTwkAnuUkFk7AO+pXBPrHXMcUADm0
 pvV0MiqLZFbUw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 451601C3AF9;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D2483F3753;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 40F6A17EDB; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 080/122] hw/usb/dev-wacom: Don't write off end of
 buffer
Date: Wed, 22 Jul 2026 15:45:29 +0300
Message-ID: <20260722124622.31034-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In usb_wacom_handle_data() we allocate a buffer with a size
determined by the transfer size requested by the guest.  We then fill
it in by calling either usb_mouse_poll() or usb_wacom_poll(), both of
which functions take a length and return an actual length, which we
pass to usb_packet_copy().  However, usb_mouse_poll() doesn't check
the buffer size as it fills in the buffer, so if the guest passes an
overly short transfer size then it will write off the end of the
allocated buffer.

Check the length is at least big enough for the minimum 3 byte
packet and return nothing if it is not, as usb_wacom_poll() does.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3672
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260706182034.1003176-1-peter.maydell@linaro.org
(cherry picked from commit 2c6fae7d7da874615d8585f6d2b16ffb673c5c9a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 7177c17f031..9d9fc1eb168 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -252,6 +252,10 @@ static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
     if (s->buttons_state & MOUSE_EVENT_MBUTTON)
         b |= 0x04;
 
+    if (len < 3) {
+        return 0;
+    }
+
     buf[0] = b;
     buf[1] = dx;
     buf[2] = dy;
-- 
2.47.3


