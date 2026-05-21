Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3wF-0008Jh-97; Thu, 21 May 2026 09:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vb-00080e-SS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vZ-0002cK-Ju
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2P4H/6PC/PtAzXZKuJPQilzhN2AYohJ5V5fNf5KF9A=;
 b=AbqdpUsTndOlxQgmT+QM6PSBiXhXBz67lobkXQFSYnYr/qARdzusqdOZ+nfaFgskPhsqNA
 XpfYiqSxt/DN1oxhLwni7d5PN02HBh0c7qk0STHro+e/pBOFMYLFg8tg+PqYrjzwTkEryJ
 GzS6QctpdD3yO54PjNy+JRjYaqbN0uk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-9RxgiOUSP3ihEW4Pak6E3A-1; Thu,
 21 May 2026 09:58:59 -0400
X-MC-Unique: 9RxgiOUSP3ihEW4Pak6E3A-1
X-Mimecast-MFC-AGG-ID: 9RxgiOUSP3ihEW4Pak6E3A_1779371938
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B18718002D7; Thu, 21 May 2026 13:58:58 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A039830001BE; Thu, 21 May 2026 13:58:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 32/38] ui/sdl2: Use Linux key codes
Date: Thu, 21 May 2026 17:55:43 +0400
Message-ID: <20260521135551.1752945-33-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-24-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/sdl2-input.c | 18 +++++++++---------
 ui/trace-events |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index fdbdc427dc9..7bebc3f3e5c 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -24,6 +24,7 @@
 /* Ported SDL 1.2 code to 2.0 by Dave Airlie. */
 
 #include "qemu/osdep.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
@@ -32,28 +33,27 @@
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
 {
-    int qcode;
+    unsigned int lnx;
     QemuConsole *con = scon->dcl.con;
 
-    if (ev->keysym.scancode >= qemu_input_map_usb_to_qcode_len) {
+    if (ev->keysym.scancode >= qemu_input_map_usb_to_linux_len) {
         return;
     }
-    qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
-    trace_sdl2_process_key(ev->keysym.scancode, qcode,
+    lnx = qemu_input_map_usb_to_linux[ev->keysym.scancode];
+    trace_sdl2_process_key(ev->keysym.scancode, lnx,
                            ev->type == SDL_KEYDOWN ? "down" : "up");
-    qkbd_state_key_event(scon->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         ev->type == SDL_KEYDOWN);
+    qkbd_state_key_event(scon->kbd, lnx, ev->type == SDL_KEYDOWN);
 
     if (QEMU_IS_TEXT_CONSOLE(con)) {
         QemuTextConsole *s = QEMU_TEXT_CONSOLE(con);
         bool ctrl = qkbd_state_modifier_get(scon->kbd, QKBD_MOD_CTRL);
         if (ev->type == SDL_KEYDOWN) {
-            switch (qcode) {
-            case Q_KEY_CODE_RET:
+            switch (lnx) {
+            case KEY_ENTER:
                 qemu_text_console_put_keysym(s, '\n');
                 break;
             default:
-                qemu_text_console_put_qcode(s, qcode, ctrl);
+                qemu_text_console_put_linux(s, lnx, ctrl);
                 break;
             }
         }
diff --git a/ui/trace-events b/ui/trace-events
index 237f5a65af2..339a61f3415 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -135,7 +135,7 @@ input_event_mtt(int conidx, const char *axis, int value) "con %d, axis %s, value
 input_event_sync(void) ""
 
 # sdl2-input.c
-sdl2_process_key(int sdl_scancode, int qcode, const char *action) "translated SDL scancode %d to QKeyCode %d (%s)"
+sdl2_process_key(int sdl_scancode, unsigned int lnx, const char *action) "translated SDL scancode %d to Linux scancode %u (%s)"
 
 # spice-display.c
 qemu_spice_add_memslot(int qid, uint32_t slot_id, unsigned long virt_start, unsigned long virt_end, int async) "%d %u: host virt 0x%lx - 0x%lx async=%d"
-- 
2.54.0


