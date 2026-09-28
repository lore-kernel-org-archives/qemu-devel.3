Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA7DCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB6X-0007d3-Ni; Mon, 28 Sep 2026 09:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBB6V-0007bn-I7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBB6U-0004y1-2I
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vITxYFWJKcwLIcezk1q88fwRpGQ293Arl1D9+nVbELw=;
 b=eQVMzb7KBHeJTDznEqHH+ZQJwjNFnZJjNDk3YfMGrbl5eaJPrn4p7MLLQzquf0+CtncS74
 iu9vFNyfOHtQ2FhIAdK9WlofHs3rWiPoRt4LpsfLXczQBwgR6P/CWYL6webnQBvTRA6boX
 hgEuUS+OqjNz4ws+1XU5d0gxQAD8YIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-txNC8mhZPH-ApfVmU6UmEw-1; Mon,
 28 Sep 2026 09:09:07 -0400
X-MC-Unique: txNC8mhZPH-ApfVmU6UmEw-1
X-Mimecast-MFC-AGG-ID: txNC8mhZPH-ApfVmU6UmEw_1790600946
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B291B1933B47
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 13:09:06 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACF9E1956045; Mon, 28 Sep 2026 13:09:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] io: prevent unbounded read of websocket data from client
Date: Mon, 28 Sep 2026 14:09:04 +0100
Message-ID: <20260928130904.3921495-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 461abcae487..646cd45be2a 100644
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
2.55.0


