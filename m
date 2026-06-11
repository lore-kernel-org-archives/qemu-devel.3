Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13434CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLp-0002xe-SD; Thu, 11 Jun 2026 05:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLg-0002nD-5P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLe-0004q0-Il
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0slAZr5wYvHwbne6mZ/zPGy2Lj/fJ6NfvG10inQysxA=;
 b=K5CUgyd1yyQ7M6lQZ+V7IByM6j1lWsne7IJ//6Rz091Mige0S+GlFIjNjar29IyEeSLIYM
 jywkH7hfxJjm9Heoh/Tc7X77rkOOxugNYkbCl0+sgwvy2QgqfkHVAV2YJ5s6a9Ij91EwGv
 BVguvCxddgY/eOBWAF+jX1vCIjsPGO4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-4OFE46a2OiemkWZbqu1srw-1; Thu,
 11 Jun 2026 05:05:11 -0400
X-MC-Unique: 4OFE46a2OiemkWZbqu1srw-1
X-Mimecast-MFC-AGG-ID: 4OFE46a2OiemkWZbqu1srw_1781168710
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 895001955E89; Thu, 11 Jun 2026 09:05:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 894361954B0E; Thu, 11 Jun 2026 09:05:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:32 +0400
Subject: [PATCH v3 17/35] ui/curses: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-17-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CrS76SW/HLMQ3iT1E5F2L0lWK5WfDn5ZaHj1Iew5FR4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnf9yoSDjrQ4SM0UOLWZ8LvR5gsDuonYelbf
 A2zcfDL/u6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53wAKCRDa6OEJdZac
 5bgKD/91LPETvwvTdWqbMIg0W2Sidt4Z1F3MzekuTuo1gerYwgrT5R9Cx8sn+XijOXnbkIDUi0l
 KNwuEDwXU6gmorFRo65j+qunp0sRi0q104vqAK0AmvQh9QgbYntMCW/ZNH5q8Ni6jghTBEp89FD
 BJ6eUGQ5q67rSiuB73jng2sFaTrTdPZ2rYZ75FaRc2R8liTcFVrf9hY4tZw09zslG+Z0K5sKzz6
 aXGZTP6cCWjHsgbSxlc2GVp4EOr5hkxd/XH/GbIayLaYp1SScJkYHh8dX8CIQcbowlkOQLDjK1V
 ewZg8bG824dLy4MnGpKJRSt+xZBvZJpJl6jMw+IKDgV6EMf4eFhd8T6urCEHMeyS4VEW6B539Zr
 yYnhDXhiHmIq0asSzUGmKtPbW1vkpD26lr6+QqDo/2pYNf5M5tHLzY3UOcLFulXQqy6QnZP2CU4
 5asMQx75zXQVXLWKh/luXt0g3HUu/FUAbePNpRF1vUmE2eY4mIZ+jeU8jbL+/4SM5aYRa+znjnN
 5aFD/mE2/RsYlBvpy0Y6gJeNpgJpmZV9odkkM4JoGnaagrsW4CG1E1VkxaTIpm5XvGoIeLdnEml
 sA/RvsmolxH8ToVB90bLEuxND5zW3mc4bD3UFsGCdEkj3shORl1clbDCxgEV/cklnzJysXnGq7/
 x8KoIT/ulZVMfMQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


