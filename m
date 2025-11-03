Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E40CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1B9-00040k-5l; Mon, 03 Nov 2025 15:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1B1-0003om-Be
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Ax-0007id-Ik
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762201754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dCZJR2rhySQFOC9g1lQvWQEzMYUr96iWq8xrKN5xFU=;
 b=ga6nuqiqVz1zvNIteVKi6pe8MZXRTbSmM5qQ592C0OfzPDMyPlhXkWiv4CETcfBKcgcKyS
 oQyHQVrOE82ejHsEACutF7kZXunBqCANcjvP9q55Rqs0ZQUWi0iOq9i2Pi/Wk5Ijx2zzTn
 006wyqnPR7uTJFSjwI4FTmZ2T8hu16I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-jUV4eXSHOGW-3S-xPM_YyQ-1; Mon,
 03 Nov 2025 15:29:08 -0500
X-MC-Unique: jUV4eXSHOGW-3S-xPM_YyQ-1
X-Mimecast-MFC-AGG-ID: jUV4eXSHOGW-3S-xPM_YyQ_1762201747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4CA91855168; Mon,  3 Nov 2025 20:29:05 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65CDD3000233; Mon,  3 Nov 2025 20:29:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 6/8] qio: Hoist ref of listener outside loop
Date: Mon,  3 Nov 2025 14:10:57 -0600
Message-ID: <20251103202849.3687643-16-eblake@redhat.com>
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

The point of QIONetListener is to allow a server to listen to more
than one socket address at a time, and respond to clients in a
first-come-first-serve order across any of those addresses.  While
some servers (like NBD) really do want to serve multiple simultaneous
clients, many other servers only care about the first client to
connect, and will immediately deregister the callback, possibly by
dropping their reference to the QIONetListener.  The existing code
ensures that all other pending callbacks remain safe once the first
callback drops the listener, by adding an extra reference to the
listener for each GSource created, where those references pair to the
eventual teardown of each GSource after a given callbacks has been
serviced or aborted.  But it is equally acceptable to hoist the
reference to the listener outside the loop - as long as there is a
callback function registered, it is sufficient to have a single
reference live for the entire array of sioc, rather than one reference
per sioc in the array.

Hoisting the reference like this will make it easier for an upcoming
patch to still ensure the listener cannot be prematurely garbage
collected during the user's callback, even when the callback no longer
uses a per-sioc GSource.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/net-listener.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index afdacdd5ff4..ce29bf3c993 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -118,12 +118,14 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
     }

     trace_qio_net_listener_watch_enabled(listener, listener->io_func, caller);
-    for ( ; i < listener->nsioc; i++) {
+    if (i == 0) {
         object_ref(OBJECT(listener));
+    }
+    for ( ; i < listener->nsioc; i++) {
         listener->io_source[i] = qio_channel_add_watch_source(
             QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
             qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref, listener->context);
+            listener, NULL, listener->context);
     }
 }

@@ -144,6 +146,7 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
             listener->io_source[i] = NULL;
         }
     }
+    object_unref(OBJECT(listener));
 }

 void qio_net_listener_add(QIONetListener *listener,
-- 
2.51.1


