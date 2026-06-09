Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E3CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYR-0002TO-Ls; Tue, 09 Jun 2026 10:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYQ-0002Oz-2C
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYO-00073X-MQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nNc/INcsPpcggiUKdGL+v67fCZIsx+PXcGTnYiRPMc=;
 b=MA9WTPrOAZQDYVt8bqCKHeArHTX/q9wkMto6nA9/elyMcoiKTzs1qPb/X6HCdaKHnNo0IY
 HvYHokpGH5LHvk+9t8qKFpwUTjHRvndYPWHOEJZ5te28OI1S/2FvSYLz0nSM3cUsuxokjV
 /c9v7rDs+CQu8HnF6UpE6hWk37Ptq+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-gmtiu2lsNriGW_Mf-TamcQ-1; Tue,
 09 Jun 2026 10:35:40 -0400
X-MC-Unique: gmtiu2lsNriGW_Mf-TamcQ-1
X-Mimecast-MFC-AGG-ID: gmtiu2lsNriGW_Mf-TamcQ_1781015740
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3B3F195F16F; Tue,  9 Jun 2026 14:35:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 056E21954102; Tue,  9 Jun 2026 14:35:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:30 +0400
Subject: [PATCH 11/17] hw/input/ps2: use qemu_input_handler_set_led() for
 LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-11-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t0Z9m7c1Hh+44awYmkSHssaygTyzyWH8QlSLYI/LQak=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR4NU/74WlNez1eA5DQ0oRhJUoxNtBWL2ida
 d/MzyaVVvWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeAAKCRDa6OEJdZac
 5bytEACUcw6Vcm/X79cH91QCpNunKyxIXJJaMGYGHelnKx04GZO1NvWx8kdQ6cw0mly6S5Pz7SL
 WizATzWyRLkfERwM8pbgsU9MbZIOYLlw15bM9YRWja3M+QqwwNigN3r3h3lL42KN9a9tIauseZu
 TkN01tqx5AQqeT2vHwc4l7l94iui/KK0LpORR+A6Wy/f7wgQ0YiN8Bp/+wH1OMZAJffGEmAXT2D
 x2OXBbvgfI8gScAlNDY4h221XgVj9jIZL6LbnLRZKXAKbVSQF4t+LAX9DzoeOPpYE9GhtLt49Wk
 YwsB25YRbv5RbwDAMAuarpNwRttgkd3dMFEKXwIbOUPp2KkSCLvDswKt+0txZHMVdd+Ycdwkzvh
 /wE4ZA7OfiH1V3+xUMPQ+ZpA6vh8pRGTSqM7in+q0rjdK+ZDHOUgo4e890OvcF41s8oTHxdGPSq
 JSyjUXCfy33F/1bduOuBuR7uYAM9cJUMB/dv0ta0rgmoi+A7CSjywD+V8LRUQQuff7Mta8Vf2sM
 oscg34SC4NMOUqfCq+zEXMQFOH6FUjpL7ogr9jaSzhpzsKs8Hkp54q0cR1uFLuilGFETqeBEVOu
 EjRkzLt4FyXm7lhhBPHA+0xniu5fqF1TOgEpbTKJCtoA0rGROWNNLBN/hXRJkaxp8oU0JBQau0X
 ZPF8saZuMKiWFZw==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/ps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 97df7a9a43e..7fbee17fbf0 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -577,7 +577,7 @@ static void ps2_set_ledstate(PS2KbdState *s, int ledstate)
 {
     trace_ps2_set_ledstate(s, ledstate);
     s->ledstate = ledstate;
-    kbd_put_ledstate(ledstate);
+    qemu_input_handler_set_led(PS2_DEVICE(s)->hs, ledstate);
 }
 
 static void ps2_reset_keyboard(PS2KbdState *s)
@@ -1108,7 +1108,7 @@ static int ps2_kbd_ledstate_post_load(void *opaque, int version_id)
 {
     PS2KbdState *s = opaque;
 
-    kbd_put_ledstate(s->ledstate);
+    qemu_input_handler_set_led(PS2_DEVICE(s)->hs, s->ledstate);
     return 0;
 }
 

-- 
2.54.0


