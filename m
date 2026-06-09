Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86BECD98C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYo-0004NE-NA; Tue, 09 Jun 2026 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYm-0004B9-9k
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYk-0007UM-KG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjXNi19ZJmavNuiphzSk5VdGv3UJju9zSxL7sC1u9eQ=;
 b=LgYYvXVW5wUSM2aKRF8Kz/olgEORJppufwlPAgq/Ujp34lASA9ABr5kJMptQhJBpla9yFp
 FmbwzJ9IMnkr/L1KtNmdOGAQglBhfUshlKZNY0BpQGjZxQ2fljiXRz15LEERSUotxtDd5z
 D4rUnoQlUqBBG2U4tRpVf4Rkw/8D6b0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-yu02C5j3NIeLyjseaF0Tgw-1; Tue,
 09 Jun 2026 10:36:04 -0400
X-MC-Unique: yu02C5j3NIeLyjseaF0Tgw-1
X-Mimecast-MFC-AGG-ID: yu02C5j3NIeLyjseaF0Tgw_1781015763
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D023195DE73; Tue,  9 Jun 2026 14:36:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70DEB3008B39; Tue,  9 Jun 2026 14:36:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:34 +0400
Subject: [PATCH 15/17] ui/spice: switch LED handling to Notifier-based
 input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-15-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mhLxwyrNkZYzaYRF+D3AbBaHWTrkuxc49OGXzxkMtOY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR5P+3O21DYskjRVNqF5wB0XKEO9FUzx03TU
 AIbpDg+ZgSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeQAKCRDa6OEJdZac
 5SdcD/9xUN5UFnKkBbWBQ82TOhoh9V034daxU5DTpgskekQmeCNvZwdfClDV5LvG3eVX0KiRORw
 Pbsyagop6U9eL69gMIu3f7kKTzSCWVd+/1bXb4DVSkkEYUMlHRp+zeNysU45/LMMgkBZh1XaqdR
 wkhpgmNdAam8r4x64VfCCk2QHgNcL16Imd+tOOxWIacLw5hUefmzfIuT8lCR47HfUqNTNZ0zDIc
 KS4a0ziZN6GgEJ1Jxqh5HNmk9/bv/O2L9cHQ3L8Bf1wuycd+yklR9FMYIxjwLLMk0jdJEu6TFdI
 KWqnnHgrlWRRvapeJoGZk+KbqB3rN5sLFWq3we6khIMVn+oUSICeG5PfTIYK7wAzsFiprvd/1QR
 nykCGiLrez8tOsp1HCVXykQXiPTrnnQ9Ofm+Q0MZlCtR+NbmR3EtXQ2TqTdzq88XPqL38WlfAS3
 DK4G1UAcAe7ttulvpWvKzxLE1oHWNvnpM0EStXqUobbObzaqJ165SoO8PnCyWzZAGtwd6dw12Bx
 GoZiSGwv/vR10gdEM0g4anA3TZl6ydJ36WDpHXQj+Dlgw9WPTFbKm5DDny2Vs6/ugWuCTfxgVHt
 piiEhwL1NBPbVycxMVqB5EQuZWmaIp5uYF088UxGr38X9cbzbvs2+loQ0+QPouHTI7Lvd7D6yfL
 t88ru4CW/e5L3rg==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-input.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index f0bb915fd77..f5329b8aed9 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -33,6 +33,7 @@ typedef struct QemuSpiceKbd {
     int ledstate;
     bool emul0;
     size_t pauseseq;
+    Notifier led_notifier;
 } QemuSpiceKbd;
 
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t frag);
@@ -86,9 +87,11 @@ static uint8_t kbd_get_leds(SpiceKbdInstance *sin)
     return kbd->ledstate;
 }
 
-static void kbd_leds(void *opaque, int ledstate)
+static void kbd_leds(Notifier *notifier, void *data)
 {
-    QemuSpiceKbd *kbd = opaque;
+    QemuSpiceKbd *kbd = container_of(notifier, QemuSpiceKbd, led_notifier);
+    /* spice has no associated console support */
+    int ledstate = qemu_input_get_led(NULL);
 
     kbd->ledstate = 0;
     if (ledstate & QEMU_SCROLL_LOCK_LED) {
@@ -247,7 +250,8 @@ void qemu_spice_input_init(void)
     kbd = g_malloc0(sizeof(*kbd));
     kbd->sin.base.sif = &kbd_interface.base;
     qemu_spice.add_interface(&kbd->sin.base);
-    qemu_add_led_event_handler(kbd_leds, kbd);
+    kbd->led_notifier.notify = kbd_leds;
+    qemu_input_led_notifier_add(&kbd->led_notifier);
 
     pointer = g_malloc0(sizeof(*pointer));
     pointer->mouse.base.sif  = &mouse_interface.base;

-- 
2.54.0


