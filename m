Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A44CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLu-0003A2-4P; Thu, 11 Jun 2026 05:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLo-0002zH-Pb
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLn-00052H-4q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WXhIg19XYA4431BKDjvjcmVSAPWCiVeU7ZNrGEjkog=;
 b=aFD1JaQxzR8jv3q0l+giof/btlldkVJm+BxX6TyamkyvrQ2An7ufFRzwUYlvjT8Aoq6sBu
 vpHic2vu0PYgqQrVswAq1pS3ZmNTDg6rq7Z3vBJSOkMarAZvOOyojWaoeula0tp3WCLHh4
 Rz1CdRgfSv0naBf5mzM612l8o7UKoKA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-RQoECx0KNWG5NrRiONUpOw-1; Thu,
 11 Jun 2026 05:05:17 -0400
X-MC-Unique: RQoECx0KNWG5NrRiONUpOw-1
X-Mimecast-MFC-AGG-ID: RQoECx0KNWG5NrRiONUpOw_1781168715
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B164C180AD60; Thu, 11 Jun 2026 09:05:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61DA72ED4; Thu, 11 Jun 2026 09:05:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:33 +0400
Subject: [PATCH v3 18/35] ui/sdl2: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-18-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnfTLI4HTPi5KG4BZAMG5qZTGeuRVscsqfzc
 OzL10av9TyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53wAKCRDa6OEJdZac
 5VLRD/4hN6ouA39CbUyewopq1AhY/MKBwwnNi6H5/2lGmA/LSLMTU/DqK02rVEt6ppvZXRvJO/+
 YUyDLOTSBUDesZQgEaQvsPoBcPLvdnf5dUSaT4K3Lxy4WvROIGA3esLyj6zyTCDg4vL/IpV0x2h
 wgjMuWx5vzXIVKyq26YMtWYTh3cO1CHqkYzE5pJiTqsoWQCDyXtqAzV6ZdvNm68WEkFhgH9co5P
 jqNExMJgUKHEZvRamQDzkZTQDSiTh1WhpttP4f47dAsiw4kknagDnP75LVusvYTHo3iCJQEtngJ
 uukejRqj9//O5gXnQOuftGnD8+98NCyY95KG/n3nrEwS0f7lddd5x7D42Oxhhxf8DCYPqmt8GPK
 018VsakdX3QH0mNMDLu6NyGGffs5Iq9xiDlhQh/7o+maWHjtqKWuSHhKo7CBgVZcN5nvLJcfVk1
 FZvPTz3A2bnN/IevhLu3z7LX05/yGAX61fMsRSfna/JbGG/KuSenGmdGoMchnsiCeV7HvpqDE86
 Ol9fN0J6cK80/uMfkyXU9iiwhUfOCrvhCtbPcMof01vsNu7pePPKt6KJoW5vffqeorVgSEIwZda
 ryuK45H0+afXx6K1/qH4YA+2j6sik2iVuBIYEND3nwrLO9mWPu9OMcl7npuz30qEJXxqpdBvBbM
 Ah1GsIMeY2iQAfg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


