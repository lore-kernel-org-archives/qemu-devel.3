Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470B6CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrba-0000KT-O7; Mon, 04 May 2026 07:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbF-0008NG-GE
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbE-0000w8-2E
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hawV2zHhsLP3IpBpGcaKS5nofkenBW3wvzF/cqta4OE=;
 b=KQSlUy0dVQunrN5cd3nIeC3qb+awXH2+DxLYSvL0F0fppOY+l9Vvu8eg6bfxOGkMWJZDCD
 N1/NzTuq9YVToreQnXdKiZaAy1KlGxqDJrjcZeTTStd09PXL07Tey0xGe9lsAthu5vnyx7
 5Z5FDA6HPcMG6JyoXuurPQYX/HHozYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-4uwF6CMcMQ67mA6abelspg-1; Mon,
 04 May 2026 07:36:29 -0400
X-MC-Unique: 4uwF6CMcMQ67mA6abelspg-1
X-Mimecast-MFC-AGG-ID: 4uwF6CMcMQ67mA6abelspg_1777894589
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8C021956094
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:28 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACF621800480; Mon,  4 May 2026 11:36:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:01 +0400
Subject: [PATCH v2 13/46] io/net-listener: move mutex init to instance_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-13-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 peterx@redhat.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FO0JbNzdhqKOcr/H+UXjPEtyLHouJa/+KfqAHcSin8A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsXDsGstuJZzUMHFI049qftwUp6PKECYBUG
 W8ebphBuiWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5b90D/9igcAOdVBdS2aP/I9NuJ8WCrcCQrf6jeu2mZSQyRH9OYAutk2uhdrvAhhL/Ga5p/vt1ut
 XxmzmVvN+jLZcD68rn5o7z8/KwdpJwOSuVxlPKrt1kpIE4hLW2a3V4SSy4sBC4DtNZGiT8MUiF/
 1ozq4f1vWu079roA0g4CMxdEBuJy8vJ9v1X14m052sCmrV6y4iDV7jN0W8UNrGcYMmtuZRWLCGe
 WWDfgTQ9BkAvhFo5zQcZOgSMJvYg+u3vQcVATkcRQvqFMriHLoWxzmxuktICHyaxKdEltL7maYy
 p9foo2Gnmnkb6MfHxzICON4zhErf/9cUfW6BsD5fsgnOwKQMdGhgpW/ror+uAyWJcY3OU7kO4Zk
 hNbOS5N3JdWNp7NnmVX4n1bD+gaz/aAHR46Owbm/74JAtwbKVsOxZAGOO+tbELSSMUT05NwEMuD
 UsOICv3/qkO8S+BvNyTefJ9ep2+OA+e5bvVs5plm/v8wvXd1Rs0f6JjvtLykReUV88Norl8AFIY
 ACeZHrUlXLdbYwSny0Q6WAwg6vWqdZ2SsUnF5CqO3x5EVTOLAIB+I0kEdJj/wFzR5vWcWgv8ZvG
 6p/IcklxZjf4pxp0LHsabkv6uOwnu+dKyHSqDqkBwz2XVncU8SyXAYGZqotPPzAhpO0i39DById
 7QZb5quy+yCQ/8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QIONetListener mutex is initialized in the convenience
constructor qio_net_listener_new() rather than in an instance_init.
This means a bare object_new(TYPE_QIO_NET_LISTENER) produces an
object with an uninitialized mutex, but instance_finalize
unconditionally calls qemu_mutex_destroy() on it, which aborts.

Move the mutex initialization to a proper instance_init so that init
and finalize are always paired regardless of how the object is
created.

This patch is just added for completeness, but "qio: Fix
qom-list-properties crash on net listener object" from Peter Xu is
basically the same.

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


