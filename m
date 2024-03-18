Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45541C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 18:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHeP-0002DZ-9A; Mon, 18 Mar 2024 14:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmHeF-0002CD-22
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmHe9-0003jH-EY
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710786220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPwNfk50/41cYcrfUvdjPncJaS8ETLis6wC+xOQh2/E=;
 b=f5XgKD3xSPr841by+ap97nnFyJLlyGAenOiHnVXtoQSeyd1PU8VLy78VjasBtvUi2WpEZC
 Oy01qj1IYSVvY7+wqY7R3jobRwSd4mCndQJDdOIJw/vJeR71g41r+0lVN6h2IJcYbiVhDJ
 65XjL/bxdHAJnxLP9+CXde56XciTk2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-aiGnHB79P7W3Bqp5t6Wrrw-1; Mon, 18 Mar 2024 14:23:38 -0400
X-MC-Unique: aiGnHB79P7W3Bqp5t6Wrrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4896C84AEC8
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 18:23:38 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE2C17A90;
 Mon, 18 Mar 2024 18:23:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/3 for 9.0] chardev: lower priority of the HUP GSource in
 socket chardev
Date: Mon, 18 Mar 2024 18:23:28 +0000
Message-ID: <20240318182330.96738-2-berrange@redhat.com>
In-Reply-To: <20240318182330.96738-1-berrange@redhat.com>
References: <20240318182330.96738-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The socket chardev often has 2 GSource object registered against the
same FD. One is registered all the time and is just intended to handle
POLLHUP events, while the other gets registered & unregistered on the
fly as the frontend is ready to receive more data or not.

It is very common for poll() to signal a POLLHUP event at the same time
as there is pending incoming data from the disconnected client. It is
therefore essential to process incoming data prior to processing HUP.
The problem with having 2 GSource on the same FD is that there is no
guaranteed ordering of execution between them, so the chardev code may
process HUP first and thus discard data.

This failure scenario is non-deterministic but can be seen fairly
reliably by reverting a7077b8e354d90fec26c2921aa2dea85b90dff90, and
then running 'tests/unit/test-char', which will sometimes fail with
missing data.

Ideally QEMU would only have 1 GSource, but that's a complex code
refactoring job. The next best solution is to try to ensure ordering
between the 2 GSource objects. This can be achieved by lowering the
priority of the HUP GSource, so that it is never dispatched if the
main GSource is also ready to dispatch. Counter-intuitively, lowering
the priority of a GSource is done by raising its priority number.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8a0406cc1e..2c4dffc0e6 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -601,6 +601,22 @@ static void update_ioc_handlers(SocketChardev *s)
 
     remove_hup_source(s);
     s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
+    /*
+     * poll() is liable to return POLLHUP even when there is
+     * still incoming data available to read on the FD. If
+     * we have the hup_source at the same priority as the
+     * main io_add_watch_poll GSource, then we might end up
+     * processing the POLLHUP event first, closing the FD,
+     * and as a result silently discard data we should have
+     * read.
+     *
+     * By setting the hup_source to G_PRIORITY_DEFAULT + 1,
+     * we ensure that io_add_watch_poll GSource will always
+     * be dispatched first, thus guaranteeing we will be
+     * able to process all incoming data before closing the
+     * FD
+     */
+    g_source_set_priority(s->hup_source, G_PRIORITY_DEFAULT + 1);
     g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
                           chr, NULL);
     g_source_attach(s->hup_source, chr->gcontext);
-- 
2.43.0


