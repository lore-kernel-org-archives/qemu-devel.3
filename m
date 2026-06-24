Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D693CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0E-0008Ox-8j; Wed, 24 Jun 2026 07:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0B-0008L3-Rk
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0A-0007lF-12
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQkpf4P397cicQNR4KAc7gU/YnRyu/Sm57F4vFtWlgo=;
 b=ZWd9qfIuTE/jFu+mzi3S1QboNvkXRYRlfG3mMnTfFpw1g4Aaz1XQAVyX0oY4xl2dtNMvkF
 OKr4thtTVrEtzMytbci6V0LRVG0J/BGhiSVaZZZxtw//oxvIOkUGVDp5WH1owLdcnU3piP
 Wc5AEZklaEVqT7OJkyH0bX5q30hq9lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-bJNCbIsoP2itFwx22E-HIQ-1; Wed,
 24 Jun 2026 07:42:39 -0400
X-MC-Unique: bJNCbIsoP2itFwx22E-HIQ-1
X-Mimecast-MFC-AGG-ID: bJNCbIsoP2itFwx22E-HIQ_1782301358
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2DE3180266F
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64BDE3000B54; Wed, 24 Jun 2026 11:42:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:34 +0400
Subject: [GIT PULL 12/35] ui/console: init gl_unblock_timer in
 qemu_console_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-12-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b2hte6KMtSmaFkBeRy7byqPcrxx3sJr5w/kurrPnHO0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jnu+2iDBzm6FnauG/lMTEBMfOqzuBso184J
 qTNBRVM+9uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5YpUD/9yqDXJLRRWMfuRsvcdsMaEBxv0VNCaqCmryEM0o0JWAYxYv786w+plTud1CPQr8g0O55E
 iw/7h8hamV1WMPxPir7yyAyzqL/ItZ+G4PDSyeU//H33c07Ld6X1BxRNwewXYTL2EMTPTa/9R3k
 J4aCGZDEDBYYM5+mrrT8XWa3GbpKewqMAGluwOnH14Xsd0CHkXyBdJ5CKLQ9XQRr6IZ8xro1NWt
 Ry7nXhch2+CiOu0oPwwn/Zo4OkJ75w2lyjSJhcoQEtbkc0gBJYfVuna5IxtWixLV9VlUn4jOvpG
 crUJ1rQoh++fqLeB4f4ZArHGCOeWaOKNc53ddqlkV/3oJ8B/M/QyDatuJZtBUvFOvBdEBgLnaMt
 0ZM+AtfNnIY0jS6fLPzrxj4AIdzxMqlOQf8wA/bSIHTHMHn/51C0KZSoZY1662ZrQI7oAwqU/3A
 yrc2Sjb6YE306fhZi6HIYqaCW6o6HUaWFgI2u5TX2Suk6kyxWbbgjIqaXFBZWJuufo29RwTSOF8
 lmLWojnbUOsnOi5jk/9BdAIzNb0GEa4NP0Ho9ghIJfPKBBhSlICqSUsdZDursjuJRAZx3BBpIjT
 HpJMAr0hiUlTj7Ro4jg8I27aRUIUek+Ju5PdAIj0LlvOuki93hdJyXIt5Ou3PZHpcyZN0O36rsX
 iEyagOdkdUTpxGQ==
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-12-4656aec3398d@redhat.com>
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


