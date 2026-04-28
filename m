Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F227FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdZi-00063M-Be; Tue, 28 Apr 2026 04:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZh-00061R-Ff
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZg-00061g-4X
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9L/6AblAev/PwnIAz9/W3QdEbNXJcvSBN0P5+WOqoo=;
 b=idcVJ9LheZQYXdOZXnaDB0LSfqcsO0syEH5d5JGCfID2RHtCISrOocX8ldeGUSL3DhiT0+
 87xpkCt5L3PS0ddRxdQ2IPD5Sd0RwdQtQAEBzYeSf40bbS1N/O+FzaXOgydbnUhupu3R5o
 nGgIrHq6aSxbzl6x4zXKW42SeYCBu/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-9mLba8DTOIqgAZBTzLYJpg-1; Tue,
 28 Apr 2026 04:13:39 -0400
X-MC-Unique: 9mLba8DTOIqgAZBTzLYJpg-1
X-Mimecast-MFC-AGG-ID: 9mLba8DTOIqgAZBTzLYJpg_1777364019
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFC4519560BB; Tue, 28 Apr 2026 08:13:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 807F63000C22; Tue, 28 Apr 2026 08:13:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/15] ui: minor code simplification
Date: Tue, 28 Apr 2026 12:12:52 +0400
Message-ID: <20260428081303.990973-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.53.0


