Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61652CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvEP-0004Me-2R; Fri, 29 May 2026 07:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEM-0004H0-7P
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvEK-0008Ol-Ng
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WXhIg19XYA4431BKDjvjcmVSAPWCiVeU7ZNrGEjkog=;
 b=TVmkFw4sFwp6L5LtRXlzYlkUSrtXjSlRFIfoNyVJdPYm+rXqI1dJkACocEyo/2LRsEXnD3
 5U/aItgp20hL0LFHcr8P6F0gN0V0aD9+rR5ZwV2AQxSLQpO+gzzH1dyIR++PVdc983lPn/
 oLT2JRQCsQHJNalDaXjtt23B9qs3lhg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-BaFwf2flMjSDrkPiUd3OwQ-1; Fri,
 29 May 2026 07:18:14 -0400
X-MC-Unique: BaFwf2flMjSDrkPiUd3OwQ-1
X-Mimecast-MFC-AGG-ID: BaFwf2flMjSDrkPiUd3OwQ_1780053493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECC751800596; Fri, 29 May 2026 11:18:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD0EE30001BB; Fri, 29 May 2026 11:18:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:36 +0400
Subject: [PATCH 15/32] ui/sdl2: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-15-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SWP3H5Ca5KhdDjJmOi5TL9GzYnm/xCZHZJpowaDC8dc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPy05pDIEkBStG5SjwiHyJmzHe/iS4EidfW
 E7AwgQMfdKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5V/UD/96/8aou+paBn9WgVCjqdSX16kN8NOQw9Ufb1sScT2fHogOoKPmgoaHDZhYUuchgSC0p8n
 j8cOzuj4M6e5YDtNDVhc2FMRiJHd/W1zsIYvKVEBGyEbhydobldo8Ru8SES12YODO2AfubI0nBN
 HZfMMTtj7gICuzBy9YrKkQwrp2WgLugxmqFSVkJ96wNVWKIfPbmipVFRm8jZ4nPU2c1U5B4WlZ4
 9NU4CWpog3PYRwenhUD6u7qoZzybyIC+eqh8pB9asv3n9f04+B8GAfm6Z4ol3Zcef77QEeJL51l
 phM9uLzd0wrKTOgVMHxBlfHRIh5cRWfcS/YVjmK2bHTjJmhzzmJu21imXVFb0a626Pq3Kzx5F4K
 EfWsQAwWkoGWdby7jyprDp7oMIBsZCdApTSxiKqTPMDWyaJUTeBQ9PPaP8PDOsyPsn5W7ILEu9N
 YquniZO7oiNUUnq3UaCprh24Hphzk70G9vzQiucoKfMHREBkxq5RjbgjFnjYxFsHgtEbbmar1ea
 +tDRbtQ0IK/r9Gjz/hYu08JB38xzE7kRnOsAgS7kUe6ped5XQ1klYCoyWsRMmMiEdfd5QaUIcc2
 L/Ve9eC+jMXIni8l/9cdMNMyvo1c6CeIZDZhS/98BL2nwkHtkQxG838NabE6k0TYkKMXMd60taZ
 8kHAbhA2pab6xHA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Replace the atexit() handler with a proper cleanup callback. Extend
sdl_cleanup() to unregister display listeners, free keyboard state,
destroy windows, and clean up all cursor resources.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4fcdbd79d3c..6adcbdb5af9 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -788,9 +788,25 @@ static void sdl_mouse_define(DisplayChangeListener *dcl,
 
 static void sdl_cleanup(void)
 {
-    if (guest_sprite) {
-        SDL_FreeCursor(guest_sprite);
+    int i;
+
+    if (!sdl2_console) {
+        return;
     }
+
+    qemu_remove_mouse_mode_change_notifier(&mouse_mode_notifier);
+
+    for (i = 0; i < sdl2_num_outputs; i++) {
+        qemu_console_unregister_listener(&sdl2_console[i].dcl);
+        qkbd_state_free(sdl2_console[i].kbd);
+        sdl2_window_destroy(&sdl2_console[i]);
+    }
+    g_clear_pointer(&sdl2_console, g_free);
+    sdl2_num_outputs = 0;
+
+    g_clear_pointer(&guest_sprite, SDL_FreeCursor);
+    g_clear_pointer(&guest_sprite_surface, SDL_FreeSurface);
+    g_clear_pointer(&sdl_cursor_hidden, SDL_FreeCursor);
     SDL_QuitSubSystem(SDL_INIT_VIDEO);
 }
 
@@ -995,8 +1011,6 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl_grab_start(&sdl2_console[0]);
     }
 
-    atexit(sdl_cleanup);
-
     /* SDL's event polling (in dpy_refresh) must happen on the main thread. */
     qemu_main = NULL;
 }
@@ -1005,6 +1019,7 @@ static QemuDisplay qemu_display_sdl2 = {
     .type       = DISPLAY_TYPE_SDL,
     .early_init = sdl2_display_early_init,
     .init       = sdl2_display_init,
+    .cleanup    = sdl_cleanup,
 };
 
 static void register_sdl1(void)

-- 
2.54.0


