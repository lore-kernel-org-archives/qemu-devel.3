Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB2FCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0a-0001Kv-OG; Wed, 24 Jun 2026 07:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0W-0000wI-Pi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0V-0007yC-2I
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmyb6KFsCkWBuywTPOMcVFA3AXFEUfPxKP4tklruzFg=;
 b=dAaMp4r3uH1nm0eJRC3UpyK48pw5+w/aqrcXVX6geTqas3X49K4UUfvkVfrv1ibbKUFATf
 +C0JIgHW958BYIUcqOQ937g6L5SbqyueEsxpWTjXcT2AaLUwvjLpB9dT7Z4UWkYavNQWDJ
 YreWfuKbf6R8tBiqG7PnxH6IjxpgEnI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-BtRfeOcsPyuV_BmjEyGd0g-1; Wed,
 24 Jun 2026 07:43:01 -0400
X-MC-Unique: BtRfeOcsPyuV_BmjEyGd0g-1
X-Mimecast-MFC-AGG-ID: BtRfeOcsPyuV_BmjEyGd0g_1782301380
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 457CE1955F45
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:00 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EA9C30001A7; Wed, 24 Jun 2026 11:42:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:38 +0400
Subject: [GIT PULL 16/35] ui/curses: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-16-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aN0mb2OQEcWE/Db2d8SBNtpCggRhui9wk+Rn2KVoRmE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JnJJu8SnLuYoH1uASlen/nVNlO15FVBKpij
 UE6VhKqMreJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5dknD/4ryVarQs9oMGOFufNxu61jdz2L+6+/Db9e2wCwafWALKhoIHX4CHEKya8t/VH0KkHf62S
 RL5tO87It5jMqXRZg+YxSh7Z6TwhXRfZ6BcNZH7UAxAvRPCxdXbs+/ADNYmKx4ZV58WfJBS/bXj
 UKJwDYd5Ia/ob9Okwxe1NE5lVrgE3V8vY4YG+UGa64u/5O3sf7FueqaEg1m54UyTUkezYPYn+aj
 lQlKNOZWf32sq/VSWyQHdawnZxzf3LTiWGpeMOg27ljlX4MIA6PY4LgPb8lOcBkSThSwbhahQRA
 +zzTcOsQIofqW82Qmz3M3Jr4ZWk9+7rh1Wws4PGNhZZ1dY+2Sk6suUvoHvd+dh+QwXAYOB2TqJP
 K9i/PJ1FElVXhhkLfM9WXphWy21wqQ+vV4X+eOjs93SB78fp7D7G8IbVQawqtOx9sNRu5v28slA
 uNYzJARh7GLp7MnGjHPQU/bQXMACxBmv00joaSOvHNMLsvdat7FashkRPvXXOBxe16glTfdRRP1
 /yIZzOLZsBZ5UhC0RPUVBOMiCYcS5Hl7JDVSi11cBl46Pf16oRMJC2YwJyhtLDQIMOhWZpu1OPN
 QMfOM8VVPatxb4nMcmWcv0/ktSY0/gJrWZ2wqye9LVMyAyDap2zKrvMW2TflcZ1TIMj48jCFr4E
 cm0KOb8Aiq26GEw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace the atexit() handler with a proper cleanup callback. The new
curses_cleanup() unregisters the display listener, destroy & free the
allocated resources.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-16-4656aec3398d@redhat.com>
---
 ui/curses.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 24d3713e57d..4db32b6168d 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -411,11 +411,19 @@ static void curses_refresh(DisplayChangeListener *dcl)
     }
 }
 
-static void curses_atexit(void)
+static void curses_cleanup(void)
 {
+    if (!dcl) {
+        return;
+    }
+
     endwin();
-    g_free(vga_to_curses);
-    g_free(screen);
+    qemu_console_unregister_listener(dcl);
+    g_clear_pointer(&dcl, g_free);
+    g_clear_pointer(&screenpad, delwin);
+    g_clear_pointer(&vga_to_curses, g_free);
+    g_clear_pointer(&screen, g_free);
+    g_clear_pointer(&kbd_layout, kbd_layout_free);
 }
 
 /*
@@ -799,8 +807,6 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
     vga_to_curses = g_new0(cchar_t, 256);
     curses_setup();
     curses_keyboard_setup();
-    atexit(curses_atexit);
-
     curses_winch_init();
 
     dcl = g_new0(DisplayChangeListener, 1);
@@ -812,6 +818,7 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 static QemuDisplay qemu_display_curses = {
     .type       = DISPLAY_TYPE_CURSES,
     .init       = curses_display_init,
+    .cleanup    = curses_cleanup,
 };
 
 static void register_curses(void)

-- 
2.54.0


