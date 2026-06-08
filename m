Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C669CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFP-0008DX-3j; Mon, 08 Jun 2026 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFN-00089P-Fa
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFL-0000Ej-5E
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0slAZr5wYvHwbne6mZ/zPGy2Lj/fJ6NfvG10inQysxA=;
 b=fmXxnk3dL4/7AtrmEcOb53xhLl4K5YYpkUaSDMavO0Q8sFCXEYaqHo9OjBsvh/AqXJ6FgI
 cIa1OcJx/Ct9nBPGVhXFOr6NblsxYz2befRU5E6wcT1/bRdZwIvs3wac5xYCttsptCEXu3
 K0g3cF/w5zD6KdxsoY4V96GF1c2Uuy4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-kDuN8hUsN2aTLmKXkOeTPw-1; Mon,
 08 Jun 2026 03:18:02 -0400
X-MC-Unique: kDuN8hUsN2aTLmKXkOeTPw-1
X-Mimecast-MFC-AGG-ID: kDuN8hUsN2aTLmKXkOeTPw_1780903081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A92CB1955F1F; Mon,  8 Jun 2026 07:18:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E24B3008B34; Mon,  8 Jun 2026 07:17:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:33 +0400
Subject: [PATCH v2 15/33] ui/curses: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-15-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CrS76SW/HLMQ3iT1E5F2L0lWK5WfDn5ZaHj1Iew5FR4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxKqzDCFR+lBmUTVzOV1fiWY3Y5y0nuE2tnM
 n0mVGBrY7iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSgAKCRDa6OEJdZac
 5TIeD/9/ybLA6EdImr+O6P274nBoiTlfrW1ouyF22rA0sEd8Lb0GI6zPZxXVBdKq5k5aU0HhypS
 gRxc8JwuuAJJHvmiYvfjOwSejPuokmeDJik5NtcW6M4BmCMb/cCcTBMHH5pO32mFKQkejWlK3bE
 5r9sBmTRZh8PPPAL75ZVEAOtK9u6MD5bEwY+dPk4cMw5m7V/J+cEIBaMRalrw8nEnEOgLO+HmaY
 kYmSmTW8jn0ME2/beq4uu/9CCntbppZxABaANRf0o5Y7P0/sjcgWYrwOYX5Q6rBiMJpGgR9BPDh
 3bK4RVKY/fjeAlyq8wLEPs8kNxtIuJGKpiXqTut2wjnPVpQih0NyoG+ZLEs3GESC4wnHQUQad1c
 dgU8ajC39QJGKc5cOVM1u8n5yRUSWk3Km0dYnaBqG/bM943JR6lPqR8Z18yB16wJuvngJGmMBJ+
 8nSoG6k+iGA1BUWgjdPuTVczlLeKXv54z1OyqtGqRTt6hiBiXyPDxHqdU6mQA5jD8d5KZ3cX/p0
 38BeCyYx/vHiXMopPMKccUXVt77O1xra8Bv6XjXVHWrdop5RCAi2Le82Z81YW82bw3CpDpZlM7T
 fZxBje6sbQHOyoHhb8ojToiYJXiubeYpDPKDalR8E4dCOwl7GVbLhm3t2s002OvExRK8sTqGBcU
 oIHWABRdLnf80oQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


