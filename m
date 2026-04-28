Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C179FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHk2j-000254-67; Tue, 28 Apr 2026 11:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2g-00024m-PB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2f-0000cH-Ap
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777388884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcpKhY7XLUys4G2b71IeM+bUSCB6UyTf3Ja3T4QV14k=;
 b=BTCpXKvpU6b0i8CSwmbgq5Uw0Sr2o5Di8N4PNU3JYB9OA9atz5amW6R9H/9hpyvQzfdXRA
 lNbTvIAMhIvX9nJJ1bEGJL3B+zysOZUKOygT74ShS46fPmuWwok3TxagM+Uq4CCpXfgwhh
 xmxYvAulxI8pqdYJGRPt36c2jzoWoCU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-3Xp1XgEyOhGZKAgjWJWSDA-1; Tue,
 28 Apr 2026 11:08:02 -0400
X-MC-Unique: 3Xp1XgEyOhGZKAgjWJWSDA-1
X-Mimecast-MFC-AGG-ID: 3Xp1XgEyOhGZKAgjWJWSDA_1777388882
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B55331956052; Tue, 28 Apr 2026 15:08:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45CC819560AB; Tue, 28 Apr 2026 15:07:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 05/15] ui: minor code simplification
Date: Tue, 28 Apr 2026 19:07:15 +0400
Message-ID: <20260428150726.1659814-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
References: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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

Drop memset() usage.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2.c | 8 ++++----
 ui/vnc.c  | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 987ad334bbe..5dd612d9a6a 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -600,10 +600,10 @@ static void handle_windowevent(SDL_Event *ev)
     switch (ev->window.event) {
     case SDL_WINDOWEVENT_RESIZED:
         {
-            QemuUIInfo info;
-            memset(&info, 0, sizeof(info));
-            info.width = ev->window.data1;
-            info.height = ev->window.data2;
+            QemuUIInfo info = {
+                .width = ev->window.data1,
+                .height = ev->window.data2,
+            };
             dpy_set_ui_info(scon->dcl.con, &info, true);
         }
         sdl2_redraw(scon);
diff --git a/ui/vnc.c b/ui/vnc.c
index ad8d58a23d7..16dbb0cd6c2 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "qapi/qapi-events-ui.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
+#include "ui/console.h"
 #include "ui/input.h"
 #include "crypto/hash.h"
 #include "crypto/tlscreds.h"
@@ -2639,10 +2640,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 
         trace_vnc_msg_client_set_desktop_size(vs, vs->ioc, w, h, screens);
         if (dpy_ui_info_supported(vs->vd->dcl.con)) {
-            QemuUIInfo info;
-            memset(&info, 0, sizeof(info));
-            info.width = w;
-            info.height = h;
+            QemuUIInfo info = { .width = w, .height = h };
             dpy_set_ui_info(vs->vd->dcl.con, &info, false);
             vnc_desktop_resize_ext(vs, 4 /* Request forwarded */);
         } else {
-- 
2.54.0


