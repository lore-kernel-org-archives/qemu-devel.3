Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F88C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2T3w-0002v6-9K; Fri, 04 Sep 2026 08:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2T3u-0002uZ-8h
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2T3s-0001Rg-KK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788525026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ues8sr577m5tJH9JutdfSBIdkDiCIfjnhBvovBD09Wk=;
 b=ZJY4z3autx1Ng5BN4oZ8HdF7FA2u5p627FiS+warcNGAqTLDZjyeyTOmjj0+N4Gu37vbot
 +Kg00b+18xmAGrBjcrz1Hc2AmCku36qdljcsSBoK/s72tJ5XpDp7ZyDTFG8w3QNbvzENjH
 Ugv3DVfjuDD4hg4Y+yJxC0QP5mz/yw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-WrrBZrCyMAayHyA7yOeADg-1; Fri,
 04 Sep 2026 08:30:25 -0400
X-MC-Unique: WrrBZrCyMAayHyA7yOeADg-1
X-Mimecast-MFC-AGG-ID: WrrBZrCyMAayHyA7yOeADg_1788525024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7021B1955BEE; Fri,  4 Sep 2026 12:30:24 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30B061955F10; Fri,  4 Sep 2026 12:30:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2] ui/dbus: fix cursor race, copy cursor data
Date: Fri,  4 Sep 2026 16:30:20 +0400
Message-ID: <20260904123020.3108205-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Eliminates the undefined behavior where virtio-gpu's memcpy() overwrites
the buffer that an in-flight gvariant still references. Fixes the data
race where the GDBus worker thread calls cursor_unref() concurrently
with main thread.

Fixes: 142ca628a733 ("ui: add a D-Bus display backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 2e2f6ba4183a..a916479044ea 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -899,13 +899,11 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
 
     ddl_discard_cursor_messages(ddl);
 
-    v_data = g_variant_new_from_data(
-        G_VARIANT_TYPE("ay"),
+    v_data = g_variant_new_fixed_array(
+        G_VARIANT_TYPE_BYTE,
         c->data,
         c->width * c->height * 4,
-        TRUE,
-        (GDestroyNotify)cursor_unref,
-        cursor_ref(c));
+        1);
 
     qemu_dbus_display1_listener_call_cursor_define(
         ddl->proxy,
-- 
2.55.0.543.g5ebe2ebe4ea8


