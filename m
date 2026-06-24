Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00BFCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0e-0001sc-Ex; Wed, 24 Jun 2026 07:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0b-0001Xn-W1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0a-00082u-Ai
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqlC+42zhqeavMxeGPBfk4oSuGA+H9bM4iKdmjjAK00=;
 b=fsXwJDi6CDoMukPrZVmIOgqN/Yz+yo4FaMxVQJq9UpFewhwbt2M43lnwZSE+sLshFOd3tf
 5C9BvrcJikFyjL7H5hQwKfLVdkRXlNGPWiLxrDERv+/CqjTQQQse3DGG/rO/AZbVUFDNKw
 4ylbsLd0jVL0GHKzJaWmToNdKea3i0s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-xItnjq6RPciAPrkQJUIUYg-1; Wed,
 24 Jun 2026 07:43:05 -0400
X-MC-Unique: xItnjq6RPciAPrkQJUIUYg-1
X-Mimecast-MFC-AGG-ID: xItnjq6RPciAPrkQJUIUYg_1782301385
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 167EC1801F09
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2924C30001A7; Wed, 24 Jun 2026 11:43:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:39 +0400
Subject: [GIT PULL 17/35] ui/sdl2: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-17-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6KH6pNQc0gVStN1cYPWY3mNbdZp2tOf24qcFW+Wjd2k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jnj5anSkhlL6HKM97uUlLMJ+OdLqJgTib7z
 Y6Mi2JbfbaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5bk/D/9Fl7zMYUgJMKL193xv0K7cqoj55wwrMNAiYS5+3y2jRyl6U1/MuUdAXyOlImGEMULWV6J
 mrGXTjYaPJZ3YbylTuIk0uW+QFdzgOngjrpbdqtXAh2WG2IcinM4AnjhU/Z4zDJuY7KREtnhD6P
 nROi91zxuTL4bG2K3wGe3rKieNpctXR9qG0iFJ/eAkZIYJkRCcdfTDjQQLp41ump8atgt7GeLTz
 Lhy8c7KfRL/NXlBAENFh+tSwajjYUrUiw+ge+slY4/uudZ7WMPplTy/BwH29buOVtoB3/cL1YrY
 a5Ykhl3FcccIOcK6qY1u/Sf4Uo1htfMC8oxPLFKYbE3P1h30taRY9O2ckT9XgVxLsJ8LPF7fSWn
 2f+RzYVB9LGBZrlxXG+z3/+K7t2vpfYv9AOniBu8uD7lKc+ioi+NFSs4rW1A7xZsjAGUKTyeNiH
 jOhiiAIHPA/zZ4zPsClzKNB2XOXkZL4hDajFm1vu0hDMwfE8NLqNIT4EOrfn0hpEyYofRy1BFK+
 sFGUFML+UC86IuOcn4v+VUsNHop9opTggCpGSU5u4UNnN9vhHa3gci4Gw9VAiFklhJbXtzrfOkH
 ktRFX2rMpTl7u/ZHRGdqnO+QbJ/izfXHqWDSrqkWHFhRbF1g2SamhJEHlR6yuBiiECMgEXPxVhv
 oz6zk0Sh+RdC5nQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-17-4656aec3398d@redhat.com>
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


