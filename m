Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC18CD4855
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8K-0001n4-7q; Mon, 11 May 2026 16:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8I-0001kX-IQ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8G-0001qI-UA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DVIqgt4ZxibSTGq0lCCHRhM1b3/sOlzkp6SNbD+lxU=;
 b=IS9Bl9hc4s0pZ4ycV17OG4do68uywuCyE7NI/lHO+czsyk7YyrBE9v6Qkibs6/eZ4QRS/y
 28WaK/iJ15RIUN+FVnG489ONDP0zwXThQspoEsuXibKZYSnW8mQi4hdQspWRm2kkkI3osH
 DVGRDDaByrped8CthTqtCqAu5X0ouCQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-qZgkE65hM3GRmOhr-ev7Gg-1; Mon,
 11 May 2026 16:21:38 -0400
X-MC-Unique: qZgkE65hM3GRmOhr-ev7Gg-1
X-Mimecast-MFC-AGG-ID: qZgkE65hM3GRmOhr-ev7Gg_1778530897
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADD46195609D
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:21:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67D3118004A3; Mon, 11 May 2026 20:21:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/24] io/net-listener: move mutex init to instance_init
Date: Tue, 12 May 2026 00:20:50 +0400
Message-ID: <20260511202111.3091440-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QIONetListener mutex is initialized in the convenience
constructor qio_net_listener_new() rather than in an instance_init.
This means a bare object_new(TYPE_QIO_NET_LISTENER) produces an
object with an uninitialized mutex, but instance_finalize
unconditionally calls qemu_mutex_destroy() on it, which aborts.

Move the mutex initialization to a proper instance_init so that init
and finalize are always paired regardless of how the object is
created.

Fixes: 9d86181874a ("qio: Protect NetListener callback with mutex")
Cc: peterx@redhat.com
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 io/net-listener.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index 9410d72da9c..1fd0f6cb5ab 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -38,7 +38,6 @@ QIONetListener *qio_net_listener_new(void)
     QIONetListener *listener;
 
     listener = QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
-    qemu_mutex_init(&listener->lock);
     return listener;
 }
 
@@ -440,6 +439,13 @@ qio_net_listener_get_local_address(QIONetListener *listener, size_t n,
     return qio_channel_socket_get_local_address(sioc, errp);
 }
 
+static void qio_net_listener_instance_init(Object *obj)
+{
+    QIONetListener *listener = QIO_NET_LISTENER(obj);
+
+    qemu_mutex_init(&listener->lock);
+}
+
 static void qio_net_listener_finalize(Object *obj)
 {
     QIONetListener *listener = QIO_NET_LISTENER(obj);
@@ -463,6 +469,7 @@ static const TypeInfo qio_net_listener_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_QIO_NET_LISTENER,
     .instance_size = sizeof(QIONetListener),
+    .instance_init = qio_net_listener_instance_init,
     .instance_finalize = qio_net_listener_finalize,
 };
 
-- 
2.54.0


