Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB43C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 11:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjz6P-0000du-Dq; Mon, 17 Feb 2025 06:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tjz67-0000dO-E3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tjz63-0004h2-RE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739790927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZDaAFZjYp6krCLrGEEqbGU8z4vy7L6m7xm4a2izfV/A=;
 b=RSNdn61GFSRfz57Zt6rhuw9A2YHQKHU8y0FYNectdSvPKCKzcKSiZPoBgumSIvbbfTA+Ij
 GFY0kcO/JHzLeGhRb2/ESS8+q0do0W/etanmIMs2GmUAgHXuTjb2SNQqonl7g17t37i24X
 uf5p7P6vxgg5f+vXpoqWlIyN1XdOqKg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357--LOL1UssPDurLgOXyf9UlQ-1; Mon,
 17 Feb 2025 06:15:25 -0500
X-MC-Unique: -LOL1UssPDurLgOXyf9UlQ-1
X-Mimecast-MFC-AGG-ID: -LOL1UssPDurLgOXyf9UlQ_1739790925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4DE019373D9; Mon, 17 Feb 2025 11:15:24 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89F171800360; Mon, 17 Feb 2025 11:15:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/sdl: only compile dmabuf support if CONFIG_GBM
Date: Mon, 17 Feb 2025 15:15:18 +0400
Message-ID: <20250217111518.93617-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fix SDL backend compilation for win32.

Fixes: commit 31287d1af4 ("ui/sdl2: Implement dpy dmabuf functions")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2-gl.c | 2 ++
 ui/sdl2.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 31f8fbe032..6bceeed565 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -251,6 +251,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
     SDL_GL_SwapWindow(scon->real_window);
 }
 
+#ifdef CONFIG_GBM
 void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
                             QemuDmaBuf *dmabuf)
 {
@@ -312,3 +313,4 @@ void sdl2_gl_console_init(struct sdl2_console *scon)
     scon->surface = NULL;
     scon->hidden = hidden;
 }
+#endif /* CONFIG_GBM */
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9439745443..8c9df23343 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -806,9 +806,11 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
     .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
     .dpy_gl_update           = sdl2_gl_scanout_flush,
 
+#ifdef CONFIG_GBM
     .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
     .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
     .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
+#endif
 };
 
 static bool
@@ -939,7 +941,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].kbd = qkbd_state_init(con);
         if (display_opengl) {
             qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
+#ifdef CONFIG_GBM
             sdl2_gl_console_init(&sdl2_console[i]);
+#endif
         }
         register_displaychangelistener(&sdl2_console[i].dcl);
 
-- 
2.47.0


