Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E917C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 14:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Jps-0000yQ-GS; Sat, 29 Aug 2026 10:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x0Jpq-0000xw-JZ
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 10:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x0Jpo-0003yR-BQ
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 10:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788012902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5MeeeDTacSpu27Iq1eZBWJAfOaWwmn/9mODx1GaTsuA=;
 b=OL39VH3tYXQAbHc4txh132KwkuZcrcxfssmBa7F2WbEvHO1rdKTylCqeFbxo/DzYFZR9yI
 wGaYT+NMPXAuTlk6wHtbMPWYabzpvwbjNfUgFfbtA4zo4bLjcIG+gMrdfoIChkTbTT/QBW
 XRp+U+vffnOv8x1dosLhN5E3m9dr2SM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-sTC2PIYZMHifnEHMackO_g-1; Sat,
 29 Aug 2026 10:15:00 -0400
X-MC-Unique: sTC2PIYZMHifnEHMackO_g-1
X-Mimecast-MFC-AGG-ID: sTC2PIYZMHifnEHMackO_g_1788012899
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D45A1956096; Sat, 29 Aug 2026 14:14:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 553021803A40; Sat, 29 Aug 2026 14:14:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/dbus: fix cursor race, copy cursor data
Date: Sat, 29 Aug 2026 18:14:47 +0400
Message-ID: <20260829141447.1677081-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Eleminates the undefined behavior where virtio-gpu's memcpy() overwrites
the buffer that an in-flight gvariant still references. Fixes the data
race where the GDBus worker thread calls cursor_unref() concurrently
with main thread.

Fixes: 142ca628a733 ("ui: add a D-Bus display backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 2e2f6ba4183a..aca802cb11cb 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -896,16 +896,18 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
     GVariant *v_data = NULL;
+    size_t size = c->width * c->height * 4;
+    void *copy = g_memdup2(c->data, size);
 
     ddl_discard_cursor_messages(ddl);
 
     v_data = g_variant_new_from_data(
         G_VARIANT_TYPE("ay"),
-        c->data,
-        c->width * c->height * 4,
+        copy,
+        size,
         TRUE,
-        (GDestroyNotify)cursor_unref,
-        cursor_ref(c));
+        g_free,
+        copy);
 
     qemu_dbus_display1_listener_call_cursor_define(
         ddl->proxy,
-- 
2.55.0.543.g5ebe2ebe4ea8


