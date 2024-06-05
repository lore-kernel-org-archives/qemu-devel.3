Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B0DC27C5F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqTk-0008IK-Bc; Wed, 05 Jun 2024 09:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEqTj-0008GA-3T
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEqTh-0006Fb-DQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717593296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzhPwfoH1SErdzaNq4zX0FAoHyesUw7dSQsAWnH09DA=;
 b=OsCCIttCnUpyjaPjI8fOOun45lfbTQ+5ilJRuHDCPKrLAP8MXM3x0RGAq3k0JWMYkmrsm4
 Q+MYitW+4qgIqZoYP+vtacFxH0bgCO3Gw6qd62ah9n/5d8WfCpVmEL9l6GzK/ROfCy5Hhf
 LF4onVypR/cd4krAxhJqe/fcJhijr1c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-vsGxsQoUPgaw-ZwqovnG_w-1; Wed,
 05 Jun 2024 09:14:50 -0400
X-MC-Unique: vsGxsQoUPgaw-ZwqovnG_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB7CB29ABA03;
 Wed,  5 Jun 2024 13:14:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A992166AF7;
 Wed,  5 Jun 2024 13:14:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 58C141800DD4; Wed,  5 Jun 2024 15:14:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Gerd Hoffmann <kraxel@redhat.com>, Anthony PERARD <anthony@xenproject.org>
Subject: [PATCH v3 2/3] ui+display: rename is_placeholder() ->
 surface_is_placeholder()
Date: Wed,  5 Jun 2024 15:14:42 +0200
Message-ID: <20240605131444.797896-3-kraxel@redhat.com>
In-Reply-To: <20240605131444.797896-1-kraxel@redhat.com>
References: <20240605131444.797896-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/surface.h | 2 +-
 ui/console.c         | 2 +-
 ui/sdl2-2d.c         | 2 +-
 ui/sdl2-gl.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 4244e0ca4a32..273bb4769a02 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -50,7 +50,7 @@ static inline int is_buffer_shared(DisplaySurface *surface)
     return !(surface->flags & QEMU_ALLOCATED_FLAG);
 }
 
-static inline int is_placeholder(DisplaySurface *surface)
+static inline int surface_is_placeholder(DisplaySurface *surface)
 {
     return surface->flags & QEMU_PLACEHOLDER_FLAG;
 }
diff --git a/ui/console.c b/ui/console.c
index 1b2cd0c7365d..c2173fc0b1e5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1510,7 +1510,7 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
     assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
-         (surface && !is_buffer_shared(surface) && !is_placeholder(surface))) &&
+         (surface && !is_buffer_shared(surface) && !surface_is_placeholder(surface))) &&
         qemu_console_get_width(s, -1) == width &&
         qemu_console_get_height(s, -1) == height) {
         return;
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 06468cd493ea..73052383c2e0 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -72,7 +72,7 @@ void sdl2_2d_switch(DisplayChangeListener *dcl,
         scon->texture = NULL;
     }
 
-    if (is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
+    if (surface_is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
         sdl2_window_destroy(scon);
         return;
     }
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 28d796607c08..91b7ee2419b7 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -89,7 +89,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
 
     scon->surface = new_surface;
 
-    if (is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
+    if (surface_is_placeholder(new_surface) && qemu_console_get_index(dcl->con)) {
         qemu_gl_fini_shader(scon->gls);
         scon->gls = NULL;
         sdl2_window_destroy(scon);
-- 
2.45.1


