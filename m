Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB58DCD4F2C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLxP-0002jf-Ty; Wed, 12 Nov 2025 20:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLx5-0002Zw-QB
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLx4-0005n6-1W
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762996601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLfvNvrQpfiF5UcXJVPO6FfoW+PSZzZibh9xxMoxqTk=;
 b=T1cOrT80ra5Iq/5nqFJeEmi8rq5EfBRrDvPYF7rR4eSYJ4ECdgenl7qoogQyUvNu07L7MF
 OOo3OOuKTEGkxGXRf8eNTHq3tc/pIQzgL+DoX1Hm77mbcRhhPTXkuYtGP+tbm6vB3MCL3x
 aEisHNgtMmOyxPySCpAQCtS2mbFwjv8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-mYlZSSS4P_K7MDvV8YE7VQ-1; Wed,
 12 Nov 2025 20:16:38 -0500
X-MC-Unique: mYlZSSS4P_K7MDvV8YE7VQ-1
X-Mimecast-MFC-AGG-ID: mYlZSSS4P_K7MDvV8YE7VQ_1762996597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CE21195608F; Thu, 13 Nov 2025 01:16:37 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.87])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA2751800965; Thu, 13 Nov 2025 01:16:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, berrange@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH v3 03/13] qio: Unwatch before notify in QIONetListener
Date: Wed, 12 Nov 2025 19:11:28 -0600
Message-ID: <20251113011625.878876-18-eblake@redhat.com>
In-Reply-To: <20251113011625.878876-15-eblake@redhat.com>
References: <20251113011625.878876-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When changing the callback registered with QIONetListener, the code
was calling notify on the old opaque data prior to actually removing
the old GSource objects still pointing to that data.  Similarly,
during finalize, it called notify before tearing down the various
GSource objects tied to the data.

In practice, a grep of the QEMU code base found that every existing
client of QIONetListener passes in a NULL notifier (the opaque data,
if non-NULL, outlives the NetListener and so does not need cleanup
when the NetListener is torn down), so this patch has no impact.  And
even if a caller had passed in a reference-counted object with a
notifier of object_unref but kept its own reference on the data, then
the early notify would merely reduce a refcount from (say) 2 to 1, but
not free the object.  However, it is a latent bug waiting to bite any
future caller that passes in data where the notifier actually frees
the object, because the GSource could then trigger a use-after-free if
it loses the race on a last-minute client connection resulting in the
data being passed to one final use of the async callback.

Better is to delay the notify call until after all GSource that have
been given a copy of the opaque data are torn down.

CC: qemu-stable@nongnu.org
Fixes: 530473924d "io: introduce a network socket listener API", v2.12.0
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v2: new patch, split out from 4/8 to leave that one as just pure
refactoring, and call attention to this being a latent bug fix
---
 io/net-listener.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index 007acbd5b18..d71b65270e0 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -148,13 +148,6 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,

     trace_qio_net_listener_unwatch(listener, listener->io_func,
                                    "set_client_func");
-    if (listener->io_notify) {
-        listener->io_notify(listener->io_data);
-    }
-    listener->io_func = func;
-    listener->io_data = data;
-    listener->io_notify = notify;
-
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -163,6 +156,13 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
         }
     }

+    if (listener->io_notify) {
+        listener->io_notify(listener->io_data);
+    }
+    listener->io_func = func;
+    listener->io_data = data;
+    listener->io_notify = notify;
+
     trace_qio_net_listener_watch(listener, listener->io_func,
                                  "set_client_func");
     if (listener->io_func != NULL) {
@@ -300,10 +300,10 @@ static void qio_net_listener_finalize(Object *obj)
     QIONetListener *listener = QIO_NET_LISTENER(obj);
     size_t i;

+    qio_net_listener_disconnect(listener);
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
-    qio_net_listener_disconnect(listener);

     for (i = 0; i < listener->nsioc; i++) {
         object_unref(OBJECT(listener->sioc[i]));
-- 
2.51.1


