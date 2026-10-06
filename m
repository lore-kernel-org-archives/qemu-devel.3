Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BE8CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLE-0004Fs-2W; Wed, 07 Oct 2026 04:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEK0z-00032W-UF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEK0w-0006AK-TR
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791350182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wUNp40dELhxkrVqCrHeTOnt3HA64O6ujKf9u59tRT3s=;
 b=P0TDDPOHMneIDKJ+cjGfjVHyHV8iTH4TdODpU3E5Ks6Kl7fjus0KCyBjCYpq99kD3wuRO1
 7MvfuSQwQC4XpWkyJCc1RE/eJwsa90gTltytI0REsHz2Qs/wXM7nks1SWsTmajIovJWUqj
 03f8uk7ttv5S7DfRflSCam2WaBu/iFE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Z1_XNN5gPEuYVUZnau7EyQ-1; Tue,
 06 Oct 2026 04:34:57 -0400
X-MC-Unique: Z1_XNN5gPEuYVUZnau7EyQ-1
X-Mimecast-MFC-AGG-ID: Z1_XNN5gPEuYVUZnau7EyQ_1791275696
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AAB5195607F; Tue,  6 Oct 2026 08:34:56 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36067180034F; Tue,  6 Oct 2026 08:34:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/4] io: prevent unbounded read of websocket data from client
Date: Tue,  6 Oct 2026 09:34:49 +0100
Message-ID: <20261006083451.956881-3-berrange@redhat.com>
In-Reply-To: <20261006083451.956881-1-berrange@redhat.com>
References: <20261006083451.956881-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


