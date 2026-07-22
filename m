Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD1AC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWQd-0002Bp-Pu; Wed, 22 Jul 2026 08:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQO-0001YG-50; Wed, 22 Jul 2026 08:51:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQM-0002MC-2v; Wed, 22 Jul 2026 08:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=d5kglI1MqnONfrBHBTIre/pXwXtqFL5heBdzevbDvl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kptRXORfHLCGhvUH8s2lafXeGM95m6ByKjPt3wM7PVItV9YNMzQoLAMlZ2GXSOD/u
 jstXqyYTYDZPv+poyUVlMJUVZ2xR2fMT80tDCDESZX1KJrbCPynSXMOR2T6UMSvXUQ
 WXpuoFugjUyr8LNllU3kiB681iQD/6z5wHiSCWP64WGar4A34HS/RGrQq3wbA0C8iB
 8PZ+3K6CLHl+eG3SGg81msr+4nIW3FQkmIU2rUR8m0ezTb+GUKG3QBmEPKNL2iFrxp
 V9731FLsynxLUxpHEkXl3s6fLEXpC0ftKVxn9ZW81Yaz5iNEpABULdtgibW0Ovnr2K
 RqCNB6XUISr0w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 901FE1C3B32;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D814E3F3782;
 Wed, 22 Jul 2026 15:49:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9B4DC17F39; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 085/127] hw/usb/dev-wacom: Don't write off end of
 buffer
Date: Wed, 22 Jul 2026 15:48:10 +0300
Message-ID: <20260722124859.32371-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
index 14d07e81281..473ea6a0f70 100644
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


