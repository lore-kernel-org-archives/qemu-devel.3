Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FFDCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpQ-0002zT-3S; Tue, 23 Jun 2026 03:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpP-0002xC-D1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpO-0008CL-1c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InEIGu5JTrAOABwltf0bG4+QBVo09YgqKmwUUPjE9PM=;
 b=fSz0537HreaHxUZ/0KF1iHJ8uKQdrMpEhWbhiGlKlMYlxmWS2yPQ+eqAaSw2HeW3xrsj+f
 dQbO4Qy+TmsePrH3OwWAvmwwa0dK5S9tWQl6SRqRui/KSlbX64pH6W6RvqI6xM9XQQGFAB
 sebPKOBPkFSiy7kdbEQshSyNZAmJFAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-ub33XMKvM-CE3r7acsUjyQ-1; Tue,
 23 Jun 2026 03:45:45 -0400
X-MC-Unique: ub33XMKvM-CE3r7acsUjyQ-1
X-Mimecast-MFC-AGG-ID: ub33XMKvM-CE3r7acsUjyQ_1782200744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85984180025A; Tue, 23 Jun 2026 07:45:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94CF3195608C; Tue, 23 Jun 2026 07:45:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:27 +0400
Subject: [PATCH v4 12/34] ui/console: init gl_unblock_timer in
 qemu_console_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-12-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=75m6XwEI/jEsuPHQxTKVuXwY/0BtApgtkgSd0IkJ6dk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldXVSrwagWVGQFp7z1xNMpbvr36yLDEwxmt
 Rgk1uh34AuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5R40D/9HKRs+79LLrD93fReqqhLNkMQgtP5pp94IHeXZffpt6jh8+dEUf3RqP2vhMTiPY+GsH1o
 1klycaUI+F0WXnw7CALEp9nTEocbhz2rVZJ/FWeI6GgGaY5xcomeWSgpkrYCaAKzlA8/lu0hADU
 QG86aC+5Ieuje9P5OVjYD9NB83A6gAgAfnO9rC1jCRiB+YTuZnnDP6Ysamo3OeMVKti0COM5yxk
 0nHVB41YdsuwFMkMbzwfmKGqNInwYsQ0199YFChh1RXBvw+BUjK6dawpdSZOQhDG0iht10FjTk7
 JDvokJdPseSiGgPHrFxHJcIyHtnc+avAE33cHQ/uEy/NY0T6E20Vdqj0JGGwke4bN7nFMHIbI8B
 gOZuP2yO1JJrteJWwpRNpf3ZJtWsnGW54dw+T8JD28L0QWQp2OkggX1mFT1hjFKUqlu3WoModwt
 +SCF3FOgKEMexcvaiGrU7HGRmpLGQ5yvjodvh13dGVEub3U2ecV7TVwBcTdZMOuEiFtNtuo9/Qb
 0oRxGf07MNECxhQC6QcsgHKt7lDFrwCP/90yFKGJptk5aWRpyrHkhujSJsP/FuvwfaPVXewqnw1
 dzxEg1COb0e6UTg1fdeTpFRDRBhMcf2pUGi8/8Wqx5lFgpZfv0AJ1Ouh4ZZb1DMs1fIOIabUSsY
 sSTYU98s/UNrjFw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Move gl_unblock_timer allocation from graphic_console_init() to
qemu_console_init(), similar to what was done in commit cfde05d15b
("ui/console: allocate ui_timer in QemuConsole").

This fixes leaking timers on console recycling.

Fixes: a9b1e471e17 ("ui: add a gl-unblock warning timer")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


