Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F182FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdZm-000669-D3; Tue, 28 Apr 2026 04:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZl-00065I-3Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZj-00061q-K6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlMDlHyLLl3lxtcJ4Plm3iqjAmK+IozF6Q8bNz/RuwA=;
 b=QMyABl/l/oxWvs6Ent7pFNcPnFj2EL14lANU7gH2rLhQcn06+pKB4Tp+RfKC9sYFYSVYr2
 E7xpOpuM5AX3wRUOmHrWY6CmUViIqFy9g21a/1Oc4XwtSxuEDv4unFUBobu7e34ihTQBVd
 +uv5B0kaHU8hVAzdMGnNtnFr8D1Wkoc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-aWm3J9ctMqyy2vqs8h0j7w-1; Tue,
 28 Apr 2026 04:13:45 -0400
X-MC-Unique: aWm3J9ctMqyy2vqs8h0j7w-1
X-Mimecast-MFC-AGG-ID: aWm3J9ctMqyy2vqs8h0j7w_1777364024
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 806731956095; Tue, 28 Apr 2026 08:13:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C29D196B8FB; Tue, 28 Apr 2026 08:13:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/15] ui: rename init_keyboard_layout->kbd_layout_new()
Date: Tue, 28 Apr 2026 12:12:53 +0400
Message-ID: <20260428081303.990973-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use a more convential name.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/keymaps.h       | 4 ++--
 ui/curses.c        | 4 ++--
 ui/input-barrier.c | 4 ++--
 ui/keymaps.c       | 4 ++--
 ui/vnc.c           | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index e8917e56404..89bfbb2704d 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -52,8 +52,8 @@ typedef struct {
 
 typedef struct kbd_layout_t kbd_layout_t;
 
-kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
-                                   const char *language, Error **errp);
+kbd_layout_t *kbd_layout_new(const name2keysym_t *table,
+                             const char *language, Error **errp);
 void kbd_layout_free(kbd_layout_t *k);
 int keysym2scancode(kbd_layout_t *k, int keysym,
                     QKbdState *kbd, bool down);
diff --git a/ui/curses.c b/ui/curses.c
index 161f78c35c3..af4ccb4227d 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -770,8 +770,8 @@ static void curses_keyboard_setup(void)
         keyboard_layout = "en-us";
 #endif
     if(keyboard_layout) {
-        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
-                                          &error_fatal);
+        kbd_layout = kbd_layout_new(name2keysym, keyboard_layout,
+                                    &error_fatal);
     }
 }
 
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 0a2198ca500..74724be8f45 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -679,8 +679,8 @@ static void input_barrier_instance_init(Object *obj)
     /* always use generic keymaps */
     if (keyboard_layout && !kbd_layout) {
         /* We use X11 key id, so use VNC name2keysym */
-        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
-                                          &error_fatal);
+        kbd_layout = kbd_layout_new(name2keysym, keyboard_layout,
+                                    &error_fatal);
     }
 
     ib->saddr.type = SOCKET_ADDRESS_TYPE_INET;
diff --git a/ui/keymaps.c b/ui/keymaps.c
index d1b3f43dc8a..6822c097be7 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -187,8 +187,8 @@ void kbd_layout_free(kbd_layout_t *k)
     g_free(k);
 }
 
-kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
-                                   const char *language, Error **errp)
+kbd_layout_t *kbd_layout_new(const name2keysym_t *table,
+                             const char *language, Error **errp)
 {
     kbd_layout_t *k;
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 16dbb0cd6c2..c87d1f61a0a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3443,10 +3443,10 @@ void vnc_display_init(const char *id, Error **errp)
 
     if (keyboard_layout) {
         trace_vnc_key_map_init(keyboard_layout);
-        vd->kbd_layout = init_keyboard_layout(name2keysym,
-                                              keyboard_layout, errp);
+        vd->kbd_layout = kbd_layout_new(name2keysym,
+                                        keyboard_layout, errp);
     } else {
-        vd->kbd_layout = init_keyboard_layout(name2keysym, "en-us", errp);
+        vd->kbd_layout = kbd_layout_new(name2keysym, "en-us", errp);
     }
 
     if (!vd->kbd_layout) {
-- 
2.53.0


