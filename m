Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6080CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB4s-0004SY-TV; Sat, 17 Oct 2026 16:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3A-00030O-Ln; Sat, 17 Oct 2026 16:30:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB38-0004Pu-R0; Sat, 17 Oct 2026 16:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268866; bh=nwB1xdWBMGqqpv7SNHt7/wunBA6PBNFhA4PvMJQvvQ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T8MudmmTli/0n4SlndRIaAQniURKOKdQ4rQbQVFt+ovFZK3L99cjiPcraILClULGO
 U++77UqueYgMEGSMVdbC+dXV5l3sGqGXlZ/zoCKCWZXcWpRBhCRQTIDgopDAIcz4Z/
 iRqJrR4htwTpNCL0hPbq0LzPX4xZGvseSQFKW3v9maEQ0yBhgFbl3WiOp/DTOB2RB3
 gnao0ZsLisau1ga6EGdVts7tEBVjCEck62LRT+MntXO+lN8RsXb6ZDoTNBg1fgrWRD
 sFPsfc+yavy7B0ML1rS+pVuougY5qIVGj0jA3//ofANRL8otAKLpD38kgPYT5lKTdE
 BSllfr5V0PTbg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 52F151DE766;
 Sat, 17 Oct 2026 23:27:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CDB644343A;
 Sat, 17 Oct 2026 23:27:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 40/73] io: prevent unbounded read of websocket data
 from client
Date: Sat, 17 Oct 2026 23:25:58 +0300
Message-ID: <20261017202638.728621-40-mjt@tls.msk.ru>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The QIOChannelWebsock class wraps an underlying QIOChannel instance,
providing a websocket server handshake and packet encoding/decoding.

When a watch is added to QIOChannelWebsock, this in turn creates a watch
on the underlying QIOChannel that is always monitoring G_IO_IN, as long
as the 'encinput' buffer has space.

When this watch fires, it reads data off the wire into 'encinput' and
then decodes as much of 'encinput' as possible into the 'rawinput'
buffer.

The qio_channel_websock_set_watch method checks to see that 'encinput'
does not exceed a max limit, but fails to check that 'rawinput' size.
Since any data read into 'encinput', can usually be immediately decoded
into 'rawinput', the 'encinput' size check is largely a no-op, and so
'rawinput' will grow without bound.

This is readily seen with the chardev socket backend if enabling
websockets, connecting a client that sends data, while not running any
guest OS to consume data from the chardev via a virtual serial port.

The qio_channel_websock_read_wire() method will also unconditionally
read more data into 'encinput' if it has less than 4k present, which
is then decoded into 'rawinput'.

IOW, if qio_channel_websock_read_wire() is triggered for lots of small
reads, it will be reading and decoding more data to 'rawinput' than is
consumed. Skip reading more data if 'rawinput' is already at its max
size.

Reported-by: Aisle Research
Fixes: CVE-2026-101291
Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 4668899d66159dd611cd6432f880d9610ce12771)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 461abcae48..646cd45be2 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -970,7 +970,8 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
 {
     ssize_t ret;
 
-    if (ioc->encinput.offset < 4096) {
+    if (ioc->encinput.offset < 4096 &&
+        ioc->rawinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
         size_t want = 4096 - ioc->encinput.offset;
 
         buffer_reserve(&ioc->encinput, want);
@@ -1091,6 +1092,7 @@ static void qio_channel_websock_set_watch(QIOChannelWebsock *ioc)
         cond |= G_IO_OUT;
     }
     if (ioc->encinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER &&
+        ioc->rawinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER &&
         !ioc->io_eof) {
         cond |= G_IO_IN;
     }
-- 
2.47.3


