Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A28C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s34-0005SL-T8; Tue, 14 May 2024 09:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2t-0004pf-7y
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2r-0002Mu-Jw
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFogub3OVYdJX3l7+D7iwhDxOA51U84fg5/9lya0u8k=;
 b=HianDDVhsB4P/L+iaSEKoMxqeIGFTESAIF3bMOITLF9iO7ENms8ANyfpxa67dPv+lFNF3b
 RoExOd8S8AShLjT0/9JoZ3nSkLH3Inw9faFsgOXfveT0/uhf6WlXSEb6RrHI1OAtks2dzE
 QFXHdWpkVR/LQjIH/2czEerJnVTBZe4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-pu04bBQfOeCmmJgmxgO-ug-1; Tue,
 14 May 2024 09:18:12 -0400
X-MC-Unique: pu04bBQfOeCmmJgmxgO-ug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EA143C0009B;
 Tue, 14 May 2024 13:18:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0E640105A;
 Tue, 14 May 2024 13:18:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, hikalium <hikalium@hikalium.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 09/11] ui/gtk: Add gd_motion_event trace event
Date: Tue, 14 May 2024 17:17:23 +0400
Message-ID: <20240514131725.931234-10-marcandre.lureau@redhat.com>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: hikalium <hikalium@hikalium.com>

Add gd_motion_event trace event for making it easy to debug
gd_motion_event related issues.

Signed-off-by: hikalium <hikalium@hikalium.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240512111435.30121-2-hikalium@hikalium.com>
---
 ui/gtk.c        | 2 ++
 ui/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 3a6832eb1b..7ce73b0798 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -915,6 +915,8 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     x = (motion->x - mx) / vc->gfx.scale_x * ws;
     y = (motion->y - my) / vc->gfx.scale_y * ws;
 
+    trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x, y);
+
     if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
         if (x < 0 || y < 0 ||
             x >= surface_width(vc->gfx.ds) ||
diff --git a/ui/trace-events b/ui/trace-events
index e6a2894303..69ff22955d 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -28,6 +28,7 @@ gd_ungrab(const char *tab, const char *device) "tab=%s, dev=%s"
 gd_keymap_windowing(const char *name) "backend=%s"
 gd_gl_area_create_context(void *ctx, int major, int minor) "ctx=%p, major=%d, minor=%d"
 gd_gl_area_destroy_context(void *ctx, void *current_ctx) "ctx=%p, current_ctx=%p"
+gd_motion_event(int ww, int wh, int ws, int x, int y) "ww=%d, wh=%d, ws=%d, x=%d, y=%d"
 
 # vnc-auth-sasl.c
 # vnc-auth-vencrypt.c
-- 
2.41.0.28.gd7d8841f67


