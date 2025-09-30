Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA4CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VDs-0001OM-1O; Tue, 30 Sep 2025 03:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDp-0001O3-EW
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDf-0008R6-Rs
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUCZhYT7Ut50WGVttLzCo+1dLTCeRLI0V8KhJgddVEU=;
 b=DdbuPpWJfmzSFwKVIx71MAbW/oFNbB3DqX3u9r+unxiIvZdhcEN1PY44NQzReRGqTAU/fH
 bR6/fwUBpeb7xLDg9QAmkjqzUzOsyZHhR978AScC1rFHKhlId5L6RvYNIRv9h6/+eGVlfC
 CVFKsgGcjkeI5xgOmC3NPqxvoOZQ8N4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-1X55XWbZMoe4VMsN2mvnWw-1; Tue,
 30 Sep 2025 03:56:12 -0400
X-MC-Unique: 1X55XWbZMoe4VMsN2mvnWw-1
X-Mimecast-MFC-AGG-ID: 1X55XWbZMoe4VMsN2mvnWw_1759218970
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6404D180057D; Tue, 30 Sep 2025 07:56:10 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E82D2195608E; Tue, 30 Sep 2025 07:56:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 richard.henderson@linaro.org, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 1/5] gtk: Skip drawing if console surface is NULL
Date: Tue, 30 Sep 2025 11:55:55 +0400
Message-ID: <20250930075559.133650-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250930075559.133650-1-marcandre.lureau@redhat.com>
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Weifeng Liu <weifeng.liu.z@gmail.com>

In gtk draw/render callbacks, add an early NULL check for the console
surface and skip drawing if it's NULL. Otherwise, attempting to fetch
its width and height crash. This change fixes Coverity CID 1610328.

In practice, this case wouldn't happen at all because we always install
a placeholder surface to the console when there is nothing to display.

Resolves: Coverity CID 1610328
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250714141758.10062-1-weifeng.liu.z@gmail.com>
---
 ui/gtk-egl.c     | 5 +----
 ui/gtk-gl-area.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0b787bea25..ae9239999c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -72,7 +72,7 @@ void gd_egl_draw(VirtualConsole *vc)
 #endif
     int ww, wh, pw, ph, gs;
 
-    if (!vc->gfx.gls) {
+    if (!vc->gfx.gls || !vc->gfx.ds) {
         return;
     }
 
@@ -112,9 +112,6 @@ void gd_egl_draw(VirtualConsole *vc)
         }
 #endif
     } else {
-        if (!vc->gfx.ds) {
-            return;
-        }
         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                        vc->gfx.esurface, vc->gfx.ectx);
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 8151cc413c..05fc38096e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -48,7 +48,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
     int fbw, fbh;
     int wx_offset, wy_offset;
 
-    if (!vc->gfx.gls) {
+    if (!vc->gfx.gls || !vc->gfx.ds) {
         return;
     }
 
@@ -135,9 +135,6 @@ void gd_gl_area_draw(VirtualConsole *vc)
         }
 #endif
     } else {
-        if (!vc->gfx.ds) {
-            return;
-        }
         gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
 
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, pw, ph);
-- 
2.51.0


