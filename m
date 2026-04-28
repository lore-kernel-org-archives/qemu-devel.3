Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FFCFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdaC-0006Oz-4O; Tue, 28 Apr 2026 04:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaA-0006Mz-Ex
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHda8-00063w-SW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/uJgRljr3eM84WgnzZfPw4Lpvi0j0W88Relj5J34U0=;
 b=UjcpiPaRxXanZj7T69Nz1VG4Z82169rbyWFcZnEhFc8sf1rW6Qz33EbAiktqitRZljcc6E
 Xu9FVEM4CgZqETGzqjUX7+/4S71ZR1zCFBpRF7XnjPJeHY2QdzqrqZxWI7VlA6mXIKs0C5
 3QSXIATvPOKC2LCjnes9a9j0A6ais4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-78i04F_ZPlCzkFbShflAsA-1; Tue,
 28 Apr 2026 04:14:10 -0400
X-MC-Unique: 78i04F_ZPlCzkFbShflAsA-1
X-Mimecast-MFC-AGG-ID: 78i04F_ZPlCzkFbShflAsA_1777364049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5A3D18002C6; Tue, 28 Apr 2026 08:14:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4CCB180047F; Tue, 28 Apr 2026 08:14:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 10/15] ui/dbus: fix warning for clients without "Interfaces"
 property
Date: Tue, 28 Apr 2026 12:12:57 +0400
Message-ID: <20260428081303.990973-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The "Interfaces" property is not strictly required. We can just assume
the peer doesn't implement the given interface. Fix warning:
GLib: g_strv_contains: assertion 'strv != NULL' failed

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/dbus-listener.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 37945236e11..e5ce92d1257 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -1026,9 +1026,11 @@ static bool
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


