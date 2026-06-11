Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F5CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLS-00027j-RF; Thu, 11 Jun 2026 05:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLO-0001N4-D2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLM-0004nQ-W6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InEIGu5JTrAOABwltf0bG4+QBVo09YgqKmwUUPjE9PM=;
 b=L1hLnZJ4Y24OZHi+2P7Yzf5KwcFfLrPBopd/J/7vsf5zRrmMiqfneXdg8N7D0WwuQ5ywzN
 rTDn8QN5WGWnmLujxbDP5yuySShncV1NC5/zTLCEKsJmJ+dtTB+HmZ1fB6dF3wEI2IHR35
 91X2223kKXfQzngeEDdZicl0Fq3vVZ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-ctAovMlnOROnmx1PbDnFVw-1; Thu,
 11 Jun 2026 05:04:51 -0400
X-MC-Unique: ctAovMlnOROnmx1PbDnFVw-1
X-Mimecast-MFC-AGG-ID: ctAovMlnOROnmx1PbDnFVw_1781168689
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3CE51800591; Thu, 11 Jun 2026 09:04:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95D4C1954B0D; Thu, 11 Jun 2026 09:04:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:28 +0400
Subject: [PATCH v3 13/35] ui/console: init gl_unblock_timer in
 qemu_console_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-13-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=75m6XwEI/jEsuPHQxTKVuXwY/0BtApgtkgSd0IkJ6dk=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGoqed6hHsLwGPjrZh6NjzsoCHfrT1tFWSt9mIA/FcURHYuY6
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqKnneAAoJENro4Ql1lpzlEqgP/1Z6
 DCNn1hS1hQr105u3KXotaO2IhvfoOifUi/coCho6u6wCSSNVIc++3cmDUhJN/coc13JbpOQIKMW
 7gPRZV5T8U0a7T7YdOaQp6nuDSM7G2olD2kOSxTqeZntiXHsUJUlesIJv1i0cn/XcX4tA8SKeG4
 hjdRQbYjnYkFloTrufJqkUdOd/FufbdbQWMxWQ3qH6IGmstvrHqWbiqEIxdLGnC9tpgYFZU2j+w
 rKT91p1y/y2/b/uk7jKKcfCdyrIg+E8Z1pOBolsPR7LROSl2aqeZvmhApEApqqIhxU2GpwjzX95
 kKAHgkdPP1F27IyaGExFdiWrTGGnLOG+iBVz39SfX0qM93E+huZJy7GX2GOj/ZXghvyXlUTApYF
 v7EqQSpidZBXKBvSSKLpnPMiba3zxYNthY3qTOVq4MUOYF84XjSfMbGsM1weDFLF1Vn+VFNoFGN
 85cST7ZDJW6SKD3GC+bFWoIkiZRpXaiw0MJp4CaR9vw9OvcQqeGh9G1xwjqfTkDRUJj0xt/sS8S
 qnbc63n7mKFhfrJgaYBJgHG6WTd6zV4UFpCPsZjKioPRvr/IPkxaZzpB+MygAX3GlVGcAFw/jlx
 78XdC/sdeL/uvc81UKMX2NfACenDG4TeBDBrrpDBty6A2OI3BEwIk2cFXb4qsFy87edx8fT8iDm
 F5JU+
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


