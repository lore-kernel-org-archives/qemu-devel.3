Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B9CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPajd-00030y-Go; Wed, 20 May 2026 02:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajY-0002vY-9X; Wed, 20 May 2026 02:48:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajU-0001O5-FW; Wed, 20 May 2026 02:48:47 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbl096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PeAfTggliYM8PbB3aO65nQeIokDaaWH/ijf6urxywEg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259699; v=1;
 b=hntnl22h97BWd05XgDOGEJzcQWPwPQog/Ap95rwV23jZ1xjJD5oNbMWSIn+x6bKA
 t0QYihon0MEbPQ4vcwoDfF1MGZCRYKlPQ43jIjEQ+Nv78RoodUNF9ZdZCMK4m5jC
 4lQtNB8ZIExS0wBpUnjlqc3v0a9TiajS4zd99wkvO/C2CQBWhNJuRcNj1HwwFCQC
 fVkd7rrc4o173cuSzKXoXAF1iy9XHkWEvprWb8NnlxS9tc3gmH5eos2hxaDLHRfN
 MD/Q7qvMZr+lDXfnS+N6grTtwtK1wlpbRo+WwYKBHB+p1TsWPdV2odYiWh+E1G+F
 xr3WJjliNdpZwuL7H/9IYw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:07 +0900
Subject: [PATCH v3 24/29] ui/sdl2: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-24-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=+hpNcU16QOjJ5NtQGTuv6FqGNScqZe3lgtTDdAn3nRw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpOYyxc2L5/Iza195cp6fpU9vlvOuxUn33inrZJ1bq
 HzxcphwRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwESMmhn+ijlkNVxh5C66Keso
 8X6uZaPX4a//95tWzjsqmqFio8f6gOGfZspkiaAU7wsMotsesop2H+rwvHfsxN+COEu7wIDO5td
 sAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/sdl2-input.c | 18 +++++++++---------
 ui/trace-events |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index fdbdc427dc9e..7bebc3f3e5ce 100644
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
index 237f5a65af23..339a61f34153 100644
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


