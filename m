Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703E7CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFO-0008BO-0b; Mon, 08 Jun 2026 03:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEy-0007lv-Ia
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEw-0008Sv-Fm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7geeM3/ggP+gaEaRXq42EEqFEldFyKIz6C3vfW23LeU=;
 b=FQrGWu7WHysUkWn1/Fc0lkK9bX4Ymd2TBE44Lz9aAqN+WNXajm1i0d1U+AbVa0FXRcHKGd
 ZhKs3LCOLST8bLayIRb61q6bbFAqT7eP2j48SpMBzKWUdkGGdhtL/EQvyUCVmZEPPcoZOf
 ZscMi2vbzsWE3Gz9wMNGwvdx+AkDFcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-v8dHGZgjNMaK0RWQX2FLqA-1; Mon,
 08 Jun 2026 03:17:40 -0400
X-MC-Unique: v8dHGZgjNMaK0RWQX2FLqA-1
X-Mimecast-MFC-AGG-ID: v8dHGZgjNMaK0RWQX2FLqA_1780903059
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1564118005B6; Mon,  8 Jun 2026 07:17:39 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 896F53008B34; Mon,  8 Jun 2026 07:17:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:29 +0400
Subject: [PATCH v2 11/33] ui/console: init gl_unblock_timer in
 qemu_console_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-11-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=neHQ1EFkjR0lxtkBX3Yq/BzDDhgh8y1ih9uuNPdKdzk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxJwIw+PoPntfF2lBM2o+yL6C3Z8EHQxx+vf
 L33uqLW4l2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSQAKCRDa6OEJdZac
 5TOtD/4yewAuXtVBtv44XYKKKPz1j4Vgu3Z50bhw7JEPCt6KPzlARMm0RgFCwQy8X3fzRCcQTRZ
 Qv8W7y6CKyacFnz5xj9kI6A6xVhG+/1AUwHY/CXW9dcatjN9tHpgFftyKJCALJxbCL2ob4+8TLd
 rBXWzIk8Iv1s2b5GjFysYLv8tWtV4q7741kDFEWxmE3yMupIEigPTS/NRl+wYkyTABM3deGZcta
 lsfC+8I0g9j0MsPE8PSAefoB2zZb3TVPBGUSjSq4K3YuPTMX9ZQq1Un+larDE8qPIvS6QwPHLlM
 bfBYNA2AD9BWxPWO0XijYNxE3SfrO7GtiKjbkVzQEjoNpbk82N6xTVFt92QKBZJF3lG6M7QABPl
 RSRtEA1I/sSU1otfLyggfNv1a7rUo2aphPi3Hi6vmv7Y7aKRps6iDw2j3BuLCh3D9TrL9KEBdgb
 qw0vZGLsCGdzHdbNBhruSfooLlsuQRrfGwyYJSaWKDIcuvp+Um4wLesMIyLbYF6zwwWImyQtXXo
 EkwubNIK1RMHMnKZAGZM0xyYSU0o9viRLbrWGYlJuafBdcjy+nBEKoHFg+dCycGDk16K1YVHbua
 hhm9uooubgK3TdkFjIVLcF6GEisu7PHpHs2C9L7VO5oGsAg+ti6ZcEw5OVu49Lq0YyxAkir8d9e
 XT//ocRJzXUj3sw==
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


