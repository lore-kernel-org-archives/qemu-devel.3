Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6EDC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WzA-000511-Jb; Mon, 07 Sep 2026 06:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wym-0004Xb-3K
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wyi-00007k-Ie
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASYz6iulwfFvbmqEMTfqctGI341Oz4dZKbFqz9gwcLM=;
 b=WTfAn9pMGhpX/GhQ0CBq+8SGrvirXWgZY5qKJIRxigZigmM1eHOFbY4/M5+utJhJBf5SRz
 4V6dpAfvRTADNSRgT137MuqA/DJeJZEijS0WDtIExzbnVININ2qkt5nJ6/4i4kNwtnYuTB
 h288MjwvslRUrMTwvD/MhGctXvsSDc8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-Dx8uKVzbOhaih_2hErqRTg-1; Mon,
 07 Sep 2026 06:53:24 -0400
X-MC-Unique: Dx8uKVzbOhaih_2hErqRTg-1
X-Mimecast-MFC-AGG-ID: Dx8uKVzbOhaih_2hErqRTg_1788778403
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D9A119540C6; Mon,  7 Sep 2026 10:53:23 +0000 (UTC)
Received: from berrange.fritz.box (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 030081956042; Mon,  7 Sep 2026 10:53:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PULL v3 04/12] io/channel-socket: do not treat a zero length write
 as an error
Date: Mon,  7 Sep 2026 11:53:02 +0100
Message-ID: <20260907105310.497730-5-berrange@redhat.com>
In-Reply-To: <20260907105310.497730-1-berrange@redhat.com>
References: <20260907105310.497730-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Denis V. Lunev <den@openvz.org>

qio_channel_socket_writev() checks "ret <= 0" after sendmsg(). A zero
length iovec is written successfully and returns 0, so the success
falls into the errno switch, which acts on whatever the last failing
syscall left in errno. A stale EAGAIN turns it into
QIO_CHANNEL_ERR_BLOCK with errp untouched, and a caller which treats
every negative return as fatal then passes a NULL Error to
error_get_pretty(). The websocket handshake does exactly that, so an
unauthenticated client crashes QEMU during the greeting.

Returning 0 is safe for callers which loop until everything is
written. qio_channel_writev_full_all() has no zero progress guard, but
iov_copy() yields no entries for a zero length write, so that loop is
never entered. A connected stream socket returns 0 only when there is
nothing to send.

The WIN32 implementation in the same file uses "ret < 0".

Fixes: CVE-2026-84788
Fixes: 559607ea173a ("io: add QIOChannelSocket class")
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 12773b832c..7920cee639 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -667,7 +667,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
  retry:
     ret = sendmsg(sioc->fd, &msg, sflags);
-    if (ret <= 0) {
+    if (ret < 0) {
         switch (errno) {
         case EAGAIN:
             return QIO_CHANNEL_ERR_BLOCK;
-- 
2.55.0


