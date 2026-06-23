Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53521CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpr-0004bP-Tx; Tue, 23 Jun 2026 03:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpq-0004SH-JB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpo-0008F1-W9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YU1H8GerhQVJe1FDeVzbXbc36iomtcVm20kGBrbfSSI=;
 b=XzHmuuzuRZufudBKEr3CmOK4UO9VnXGW+3ViLlqh7S7ZBDXWnrBu8b+mkcJCoh7bSQ9c+x
 uwuhAkwCXKt4AUxMVlH/WmBDB9a+T2HEOZEqPyw+4TxHtEXvxHEEUMQkIpCa9E2DqXdYrt
 Fj44sYtzR7EqtJbsGbE4b8ZXbyxcn98=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-wAvyjjaNPfWYptHhLcX6IA-1; Tue,
 23 Jun 2026 03:46:11 -0400
X-MC-Unique: wAvyjjaNPfWYptHhLcX6IA-1
X-Mimecast-MFC-AGG-ID: wAvyjjaNPfWYptHhLcX6IA_1782200770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52E8B1800598; Tue, 23 Jun 2026 07:46:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18BAB1800347; Tue, 23 Jun 2026 07:46:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:32 +0400
Subject: [PATCH v4 17/34] ui/sdl2: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-17-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
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
 bh=7LHDaJJk+7ITAySyDwrMeiayBnDzHyMzfjsfmWGNmHE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjld3NaOpBx8B7MTqtmfMZFYt2uH0QFIxkW9l
 WuF3O1Y4SqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5ZWqEACV6EEHDBdOl/efp0hsNUwMKmf1iz35c6bKlxv1Fwb6YddcrTkZXitdzIIXmg4yPjP3bfF
 Jacrg5bYS8lNzfHpiMGUSjoc6zMLir6ln6Dh1uTGXYblTpMCGajlb08ivVClelJ0AGUJzBzuNqH
 Wc1RvwpV5zPdihwjvL15nEH1lr9mwSYs20iOfWhTrSwXYXqgq3O5FZqNzevOgtU+WLwfQ2WWv9I
 AiTqzP9VTtdWibUONwGfAAIicA9lm5pQcQTpQQfV52Bnx0K6iOq3caZCPUDVrdonBH87/ADs+cK
 dAxa4FATmjc+acFp0xxI/4mHx904U3GSyOr4L7Ol+z9NYLR7f/yNsL4tNH4epaYja/En/mslCI6
 yTW/pcDd4GdZXzPlpz10E61AL0thTSyNgrrTlfPdCAWpiBH9Nyb5nQ+BHyyakZ334D9BzIqscj8
 xbP4XB2bLXRUYlSsozLgBjDNRQzuCPHuFir+UUnt+kYGd5AiX83BOKiaOi+ahTpzakasSEGqhv+
 whRr5fTfQh6HSo0jXHrY8zMVsB6Bf/p+VXJ509Rua1uWtzvj2rD7pTeTAK4VRR8LGIYjMqfuPB/
 StvaEZWnY+xpdB2sSwx0di468fD3QVsi5c0+AH8+aNnBhH/a0GmgPGr61uv/5o7xb6K9f2W4/Bd
 ggfH62yAViZoFIA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace the atexit() handler with a proper cleanup callback. Extend
sdl_cleanup() to unregister display listeners, free keyboard state,
destroy windows, and clean up all cursor resources.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index c75f750e00e..1c97d23a47c 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -790,9 +790,25 @@ static void sdl_mouse_define(DisplayChangeListener *dcl,
 
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
 
@@ -998,8 +1014,6 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl_grab_start(&sdl2_console[0]);
     }
 
-    atexit(sdl_cleanup);
-
     /* SDL's event polling (in dpy_refresh) must happen on the main thread. */
     qemu_main = NULL;
 }
@@ -1008,6 +1022,7 @@ static QemuDisplay qemu_display_sdl2 = {
     .type       = DISPLAY_TYPE_SDL,
     .early_init = sdl2_display_early_init,
     .init       = sdl2_display_init,
+    .cleanup    = sdl_cleanup,
 };
 
 static void register_sdl1(void)

-- 
2.54.0


