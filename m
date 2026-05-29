Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25057CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDs-00021h-Ft; Fri, 29 May 2026 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDq-0001wG-Mh
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDp-0008Ly-AO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7geeM3/ggP+gaEaRXq42EEqFEldFyKIz6C3vfW23LeU=;
 b=XT2cnKQZlZU2bALdd7OsS1lp1I6zwwKcdfNzEli6LDx0U36d0kFDnqs+MJ4h2wiJcUdM3R
 eDRaclYfdynte5KSqoQDhTjKxnY+ih1twPQXvq4P6f6EKxGPoHB+U+QYERlL25L/ad1Vbj
 OspoSpCaLW6Rv7HKvB7ZEk3EOW7PCQY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-_ya0yHxuNEC61wKoZY96_A-1; Fri,
 29 May 2026 07:17:45 -0400
X-MC-Unique: _ya0yHxuNEC61wKoZY96_A-1
X-Mimecast-MFC-AGG-ID: _ya0yHxuNEC61wKoZY96_A_1780053463
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20D661956053; Fri, 29 May 2026 11:17:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9981719560AB; Fri, 29 May 2026 11:17:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:31 +0400
Subject: [PATCH 10/32] ui/console: init gl_unblock_timer in qemu_console_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-10-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=neHQ1EFkjR0lxtkBX3Yq/BzDDhgh8y1ih9uuNPdKdzk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWP8zpX6HgABBmyPuN/Hi+KBKper6zDnK6Yo
 RxDnevrW5aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5R6CD/0QVLAVyqCHIqR143v6YZXJ5k7UH0YjjTL3HIjv/i8amibKN+IBWuGYRpALi7CP7q5Xw/v
 lLXQuIArQS9IGncrRFpaP/tb5XRe5xzT0VOsJJ1vQ0YqewAhLPWMGrZn4yMmC34DXM125yJucfl
 jKDD/ylUrpYq3/2MMlBve+Kc5RZb1ipVYtjeJFHZRke7BfDm3NK2cS6Hwr1kIMbrOaqcdeMnZLq
 Ul4oAAJkCml85LMpX1qHRDytCGBeESk4gXKUTXYcxJKI/yRCUJ2HwUYswDmBXXcx3QTt2/RGhWQ
 LpJyuFl684stWbEVg1D0QQrJEvNjPTeBicjmeM0KpPe2OPPLpaaGnbyzmsBuSx+thtXUeaZXKhR
 t74C5JXeYRRHkz+7am8tGSRSQ0ZJktPSQPESLiOimtkmEJgXLKbMVMu/VkWwAbmOgNpR37hMpbf
 H01NGv2oGbI/wOC4d7ypxOXcubp2m9Q1GPbo/O4G3ysDHsUg2OP98rYXCm+2pPJ2YSFcEh2kxXS
 0TmMJPdsPn5EOgb83+pYQ2do78m/F6cTMq0M5v7knru5odsHXX/1EhwAQFyws/8vnq0tPZ21X6l
 5gWRYB6iGZXB4S5feosS2LRQWoQkLicTWuvwvPYx2+ipDCOITvlFxSbFmMLXMcAwCjWGQnVXlwu
 C68GqEEFiVpYtWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Move gl_unblock_timer allocation from graphic_console_init() to
qemu_console_init(), similar to what was done in commit cfde05d15b
("ui/console: allocate ui_timer in QemuConsole").

This fixes leaking timers on console recycling.

Fixes: a9b1e471e17 ("ui: add a gl-unblock warning timer")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 436444723a5..58f29e82c85 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -433,6 +433,8 @@ qemu_console_init(Object *obj)
     c->window_id = -1;
     c->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
                                dpy_set_ui_info_timer, c);
+    c->gl_unblock_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                       console_hw_gl_unblock_timer, c);
     qemu_console_register(c);
 }
 
@@ -1116,8 +1118,6 @@ QemuConsole *qemu_graphic_console_create(DeviceState *dev, uint32_t head,
 
     surface = qemu_create_placeholder_surface(width, height, noinit);
     qemu_console_set_surface(s, surface);
-    s->gl_unblock_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
-                                       console_hw_gl_unblock_timer, s);
     return s;
 }
 

-- 
2.54.0


