Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74085CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1B6-0003tg-TJ; Mon, 03 Nov 2025 15:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Aw-0003lP-WC
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Au-0007hQ-Nc
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762201750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNHZkYLghkWJKpV9IcEk5Jr77yUchR1dS2rgF6gG7fU=;
 b=MhSfa2jPuQmetfr4R/gMZpCfmYKmqH9sfIL9JWeO3SKxQpQ/yS7CW70gb44ak9IKvW54Nk
 2RCHGp6b416nLj8n2R7ojJxmesP5ykWsSteHUHZt3wY/7tF1Lep2oZTSTC8c5T3pTglj1A
 sS0CS4kXMGUDleE5JCtak4QjE41MH+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518--WRJh1mON3evFDGx2Xd5yg-1; Mon,
 03 Nov 2025 15:29:07 -0500
X-MC-Unique: -WRJh1mON3evFDGx2Xd5yg-1
X-Mimecast-MFC-AGG-ID: -WRJh1mON3evFDGx2Xd5yg_1762201745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED626180121B; Mon,  3 Nov 2025 20:29:03 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 686F330002C3; Mon,  3 Nov 2025 20:29:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 5/8] qio: Let listening sockets remember their owning
 QIONetListener
Date: Mon,  3 Nov 2025 14:10:56 -0600
Message-ID: <20251103202849.3687643-15-eblake@redhat.com>
In-Reply-To: <20251103202849.3687643-10-eblake@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make it easier to get from the sioc listening to a single address on
behalf of a NetListener back to its owning object, which will be
beneficial in an upcoming patch that teaches NetListener how to
interact with AioContext.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/io/channel-socket.h | 1 +
 io/channel-socket.c         | 1 +
 io/net-listener.c           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a88cf8b3a9f..eee686f3b4d 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    struct QIONetListener *listener;
 };


diff --git a/io/channel-socket.c b/io/channel-socket.c
index 712b793eaf2..59e929f97c3 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -65,6 +65,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->listener = NULL;

     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
diff --git a/io/net-listener.c b/io/net-listener.c
index e1378b9a612..afdacdd5ff4 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -152,6 +152,7 @@ void qio_net_listener_add(QIONetListener *listener,
     if (listener->name) {
         qio_channel_set_name(QIO_CHANNEL(sioc), listener->name);
     }
+    sioc->listener = listener;

     listener->sioc = g_renew(QIOChannelSocket *, listener->sioc,
                              listener->nsioc + 1);
-- 
2.51.1


