Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222B0CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFk-0001By-Ts; Mon, 08 Jun 2026 03:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFi-0000yg-1e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFg-0000O4-B9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M99d8mm/rcGWFplxSkYyDHW5C0as6dK08CNz+VrRrRA=;
 b=L3wLn7dpA8e62RadUWYHtS1eh0GRMHtf82DYIAverMt1COYZ4vNFU6Ls0ONe1A8XxIThZ9
 dViukK7/ag+tIJPCqYSM0knDsCnvFF0tbVDhVHBPZ+Y6oA/ihmXbhG/1F2VLodi5D7FNgB
 JJgh7LMH9VW9KZnlaIJasQIYCFTxrdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-_1xAZlXHPGuOqqdlsJm0eg-1; Mon,
 08 Jun 2026 03:18:23 -0400
X-MC-Unique: _1xAZlXHPGuOqqdlsJm0eg-1
X-Mimecast-MFC-AGG-ID: _1xAZlXHPGuOqqdlsJm0eg_1780903101
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A959A1800361; Mon,  8 Jun 2026 07:18:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 644F619560A2; Mon,  8 Jun 2026 07:18:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:37 +0400
Subject: [PATCH v2 19/33] ui/cocoa: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-19-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=d2sDlDsgKSJ2TB76kf45Z764VuTYl2D5ias8y7XNs1o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxLO5iTHjYPc3hsjQIfqS9TWTXiq9U3KsgOw
 8ucuUAEPLyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSwAKCRDa6OEJdZac
 5R5gD/9cPRFitkTuuKK5j1ofk8ORfVXr1Iy6L3bel94rfOd51I5e313K704qlxC2p/6mO9yZYNu
 GuDF2Pm6eZRAHG7s+fe8OeKt5/JekAGXM86ya7C0eDQFUUTKZmbNu6jP/jQkRy3P2HX1LsxdqVI
 vtymmBmy5d8gn4Ujp5WBvy3MwKTfL9lh+AL13/bBdIoq54Qsj/gtjDW3Zc5fvrTliRZQZZPQeTu
 hsvGcu8ex5j5S36dj165coZEoc7UkmjEfIXZ9qFj5RBKVs4SiYX4EWAx0m61ngkxcDTOOKa/JxR
 uuZJzkYylydRnnNSSQhYUSZrtQxwmD9zr5HfuBgWGlC3lOpBCwsAk8tz1cGS06JFxIQAnhy0igC
 T/R+SJdCcvcs0PRqNA0HfHBfVFDdlOFzCWA0xMV9l320BjmxfYRLpm8+tcjeP5NAUt9xooTVyGP
 ee+GQGsRUnUNVnzwGHIz+ykhqGLvlf3kB0Bj4yoN9j3dK26IS8dlVbKO7Kz/QuMjd84/l7IICet
 KHzhomraVzwHu5U3oRhcuiuEIBz8LeubyL/ZjuI3Up5ianydgdb1kcBscC46b0e9bcR8iZi+ylI
 B0C9rgBOaSdz0zAsGS4MvxcaufrKpwGkdElXy3AyUCSTUW7PHdFsfsS+0OWfdKitrbexhI0k7EJ
 WqYXLeVFD24QgDQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move cbowner release from QemuCocoaAppController -dealloc to
cocoa_display_cleanup(), since cbowner is allocated in
cocoa_display_init() and cleanup is the symmetric teardown path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/cocoa.m | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c5e639ab98d..bd0c5c6ed9e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1331,8 +1331,6 @@ - (void) dealloc
     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
 
     [cocoaView release];
-    [cbowner release];
-    cbowner = nil;
 
     [super dealloc];
 }
@@ -2163,9 +2161,26 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     qemu_main = cocoa_main;
 }
 
+static void cocoa_display_cleanup(void)
+{
+    if (!kbd) {
+        return;
+    }
+
+    qemu_console_unregister_listener(&dcl);
+    g_clear_pointer(&kbd, qkbd_state_free);
+    qemu_remove_mouse_mode_change_notifier(&mouse_mode_change_notifier);
+    qemu_clipboard_peer_unregister(&cbpeer);
+    g_clear_pointer(&cbinfo, qemu_clipboard_info_unref);
+    qemu_event_destroy(&cbevent);
+    [cbowner release];
+    cbowner = nil;
+}
+
 static QemuDisplay qemu_display_cocoa = {
     .type       = DISPLAY_TYPE_COCOA,
     .init       = cocoa_display_init,
+    .cleanup    = cocoa_display_cleanup,
 };
 
 static void register_cocoa(void)

-- 
2.54.0


