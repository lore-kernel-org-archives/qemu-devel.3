Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0A5F589D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFu1t-0002XE-Nh; Thu, 23 Apr 2026 09:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFu1s-0002X5-He
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFu1q-00073P-Or
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776950617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9AIfZcgXXQjbq18PYldKSWrWx8KBspra8zHKolEm6A=;
 b=Ds4JFsyw36KjAgwJT3qLhO3emVtmR1joEFGv33vLP9b4yyS9WVytx7twPC56ykdMioWGYq
 CaUNE5zJ5hM+oa7Wzesq+vKKkJoCPxsby/uo//A+yJ0bBVHkUqyhc7idDapqN+t+Cbs/Je
 RH3MQE5MQ9acp0wnHT+SvWjC7eXsazA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-F5IUuWpvPpyyLzyQ_5pLxQ-1; Thu,
 23 Apr 2026 09:23:35 -0400
X-MC-Unique: F5IUuWpvPpyyLzyQ_5pLxQ-1
X-Mimecast-MFC-AGG-ID: F5IUuWpvPpyyLzyQ_5pLxQ_1776950615
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC5371800378
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 13:23:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B425A3000709; Thu, 23 Apr 2026 13:23:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/dbus: fix warning for clients without "Interfaces" property
Date: Thu, 23 Apr 2026 17:23:29 +0400
Message-ID: <20260423132329.932887-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The "Interfaces" property is not strictly required. We can just assume
the peer doesn't implement the given interface. Fix warning:
GLib: g_strv_contains: assertion 'strv != NULL' failed

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 40287d1c687..2e2f6ba4183 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -1010,9 +1010,11 @@ static bool
 dbus_display_listener_implements(DBusDisplayListener *ddl, const char *iface)
 {
     QemuDBusDisplay1Listener *l = QEMU_DBUS_DISPLAY1_LISTENER(ddl->proxy);
+    const char * const *interfaces;
     bool implements;
 
-    implements = g_strv_contains(qemu_dbus_display1_listener_get_interfaces(l), iface);
+    interfaces = qemu_dbus_display1_listener_get_interfaces(l);
+    implements = interfaces && g_strv_contains(interfaces, iface);
     if (!implements) {
         g_debug("Display listener does not implement: `%s`", iface);
     }
-- 
2.53.0


