Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C9CC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsnF-0001GN-B2; Sat, 24 May 2025 13:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnC-0001AW-HQ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnB-0000lZ-1u
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4G0ur/AkT7SipDaNafCzLmxGscCER56Xdc2UIqquo54=;
 b=WEJd6rOMEu54RIAnSJF51A/hWDAu0khhxBXgtRWhIZh4d+0pV73fW3AErEc/ruVLvMPLB8
 n0CdU+WfFbKMXoA1bV6INtr5iWygiMOYrdNVsvQRj3igZFtmZ3Z4svsEB4FLb21akIWQdi
 8jxNri6yaCsE/JLiA/NpH2UBmjNiYEo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-Tdvc3Q9sPV2PMoAZiXaKog-1; Sat,
 24 May 2025 13:36:13 -0400
X-MC-Unique: Tdvc3Q9sPV2PMoAZiXaKog-1
X-Mimecast-MFC-AGG-ID: Tdvc3Q9sPV2PMoAZiXaKog_1748108172
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D1AE19560BC; Sat, 24 May 2025 17:36:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 390D91800570; Sat, 24 May 2025 17:36:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 16/19] ui/gtk: Don't update scale in fixed scale mode in
 gtk-egl.c
Date: Sat, 24 May 2025 19:35:09 +0200
Message-ID: <20250524173514.317886-17-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Weifeng Liu <weifeng.liu.z@gmail.com>

Scale shouldn't be changed until user explicitly requests it in fixed
scale mode (full-screen=false and free-scale=false). Use function
gd_update_scale to complete scale updating instead.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-7-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk-egl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 947c99334b..f8e4f4bc70 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -95,8 +95,9 @@ void gd_egl_draw(VirtualConsole *vc)
 #endif
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
 
-        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
-        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
+        gd_update_scale(vc, ww, wh,
+                        surface_width(vc->gfx.ds),
+                        surface_height(vc->gfx.ds));
 
         glFlush();
 #ifdef CONFIG_GBM
@@ -122,8 +123,9 @@ void gd_egl_draw(VirtualConsole *vc)
 
         eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 
-        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
-        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
+        gd_update_scale(vc, ww, wh,
+                        surface_width(vc->gfx.ds),
+                        surface_height(vc->gfx.ds));
 
         glFlush();
     }
-- 
2.49.0


