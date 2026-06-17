Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650BDCD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8q-0001dN-DK; Wed, 17 Jun 2026 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8n-0001IP-Ns
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8l-0004nd-KI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+xkFvsKcwR1tHw2+3hEmyTvIAhj/EvH/f17YcOm1aY=;
 b=M8M+5qWiy1mCZ8PpG7/yjxSU54vMimACWc97ICrJ/eccoPkDPIfY6JHGbIpKF+cMoMps1P
 hQuoPDJFOyQuyZDTmdNh4As/1/AeMlsTnYxtWEfgFgKgbMRa6GwTx6veUvU6rSiTcsDz07
 nweKxqVVpLFkvKMSpxYb445g3YQ7lyo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-EMjlzKGkN22k5Ajdu_lojg-1; Wed,
 17 Jun 2026 11:25:15 -0400
X-MC-Unique: EMjlzKGkN22k5Ajdu_lojg-1
X-Mimecast-MFC-AGG-ID: EMjlzKGkN22k5Ajdu_lojg_1781709915
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC0418005A3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3075719540CB; Wed, 17 Jun 2026 15:25:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:17 +0400
Subject: [GIT PULL 20/27] ui/spice: switch LED handling to Notifier-based
 input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-20-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AKgoKK/jeW3SCcprkzEbZiHJkHFnV77luQWVh/Clp3Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvp8oht3U4jQSXANGpXFiMqgSZApOo03TQFb
 GAs56DedWqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5VwQD/9ARDRHcgPZfE4tfnKBDwb6Q9uB5Lgw/zJdeKWYgOBF5mAACy4eWhzXbWG9aVyXx1/dek5
 /+l/ZtO/iUJD2enLMV7DT///djrcr5crFMvNVE3b7AU0TCkNExwdEa5EiwoeIV7tnjH/2QnGfDF
 lHnkt/i1k+NpamKGCrcPPctYFi8kFNY2/bF0zZ9agz6TWc3/qK+rripxLLQ8yVkhxPBxav//5Tq
 aWtukqdhDmyMzRdKx5LDzWDk2GD1XjZw+t9qPGCVX1qcJAFXnwA8teU4AWJaEUH/kQ4rek9u655
 cNuPFIl1WA6A0ZJAwQrRv4PEZrOGKs1HN0ns942JfvVBWz/JW7ceAICqf6p0ATLgnSjC1XQKpDe
 TeOOrMnn6azL2+68sJe5aHj0Zkpi5WF4Q4Et/4KK/cwh3yZULwotzE5NRQuXCIbiFlcummcC0ly
 /wFyvsc83vJeynoS8srfpzhD3Y6Wc42nYESFsziwah9aV6tKQF1VwJ2a1dXJro8lOw4El/j6NZN
 ElooY/6kRSrtRiL3WJSX6Mc0UYASMVyJJtT3vv0Hx21HLIbUiGM9OfnSU5PuE+piJjaK8FpNoNb
 AKlzInNMau3fnhJblId5BO0EvyuUgDZehp79/b03pdgq5Iar0qScWII7ICHoEOXG6a05IrbctpI
 WAhtYrIeq056mcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-input.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index f0bb915fd77..845abc7387f 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -33,6 +33,7 @@ typedef struct QemuSpiceKbd {
     int ledstate;
     bool emul0;
     size_t pauseseq;
+    Notifier led_notifier;
 } QemuSpiceKbd;
 
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t frag);
@@ -86,18 +87,20 @@ static uint8_t kbd_get_leds(SpiceKbdInstance *sin)
     return kbd->ledstate;
 }
 
-static void kbd_leds(void *opaque, int ledstate)
+static void kbd_leds(Notifier *notifier, void *data)
 {
-    QemuSpiceKbd *kbd = opaque;
+    QemuSpiceKbd *kbd = container_of(notifier, QemuSpiceKbd, led_notifier);
+    /* spice has no associated console support */
+    uint32_t leds_mask = qemu_input_get_leds_mask(NULL);
 
     kbd->ledstate = 0;
-    if (ledstate & QEMU_SCROLL_LOCK_LED) {
+    if (leds_mask & QEMU_SCROLL_LOCK_LED) {
         kbd->ledstate |= SPICE_KEYBOARD_MODIFIER_FLAGS_SCROLL_LOCK;
     }
-    if (ledstate & QEMU_NUM_LOCK_LED) {
+    if (leds_mask & QEMU_NUM_LOCK_LED) {
         kbd->ledstate |= SPICE_KEYBOARD_MODIFIER_FLAGS_NUM_LOCK;
     }
-    if (ledstate & QEMU_CAPS_LOCK_LED) {
+    if (leds_mask & QEMU_CAPS_LOCK_LED) {
         kbd->ledstate |= SPICE_KEYBOARD_MODIFIER_FLAGS_CAPS_LOCK;
     }
     spice_server_kbd_leds(&kbd->sin, kbd->ledstate);
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


