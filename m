Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58703C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visvM-0004fO-9T; Thu, 22 Jan 2026 06:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1visvC-0004co-8g
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1visv9-0007ZM-LN
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769081535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lT0pSWUKJYeo6Hwxve6QTw6oHsq182bkkFgYYbGD+O0=;
 b=aTbZaIZE10J7MeqLCDRn0bBzuqdaxl25Vlx0HCmmFSBCce3GdSnesytWvmJBv2SDwbsHXz
 OgVtRUgwsiuKz+edfY3rDfAVSG4L+PZE6Klxsu79c6jVIB4ManVi7g0p8jdKQsamEw0oJN
 ipMMSzfPBl0m1DqX34L5XDK+8tkeutM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-8TzF0bhBNUynPRRro2ZlYQ-1; Thu,
 22 Jan 2026 06:32:13 -0500
X-MC-Unique: 8TzF0bhBNUynPRRro2ZlYQ-1
X-Mimecast-MFC-AGG-ID: 8TzF0bhBNUynPRRro2ZlYQ_1769081532
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A879C19775A5; Thu, 22 Jan 2026 11:32:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CA451958DC1; Thu, 22 Jan 2026 11:32:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org
Subject: [PATCH 4/4] ui/dbus: fix pixman cleanup
Date: Thu, 22 Jan 2026 15:31:43 +0400
Message-ID: <20260122113144.2046899-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
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
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Moved pixman_region32_fini() outside the WIN32 block so it's called on
all platforms.

Fixes: commit 7007e98c ("ui/dbus: implement damage regions for GL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 46264839d86..3e2b4adf41f 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -964,15 +964,15 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef WIN32
     g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
-#ifdef CONFIG_PIXMAN
-    pixman_region32_fini(&ddl->gl_damage);
-#endif
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
 #else /* !WIN32 */
     g_clear_object(&ddl->scanout_dmabuf_v2_proxy);
 #endif
+#ifdef CONFIG_PIXMAN
+    pixman_region32_fini(&ddl->gl_damage);
+#endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
 }
-- 
2.52.0


