Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA77BF99C73
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 11:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE4EF-0000Ef-Md; Sat, 18 Apr 2026 07:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wE4EA-0000EU-5P
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 07:52:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wE4E7-0004jR-SY
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 07:52:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c741692db4cso448141a12.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776513158; x=1777117958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aViH8Sa+dRrCP6ce2A729e6K8FtQacwZ96aCuGlKC5c=;
 b=n7izcMiSIA/8kBXxagtjh6SdGKvxNiKlBCTHD2yOScxq9R2LM6ZuOKwZi2Duv1kW1c
 iaxTAtBq8CJW83npRCaT+dbehB7kScNfKUC5MGnJSnlrn0d4zqDJrMr+nv/HCHU7zK4u
 o3Qi1awQpT0lKK7/jcDfpoknJ2hAZiI2MhtrgKneta5+1sfSdJ1uDh3kSXyO0qZlgruH
 ybKVEs9q9fzHFP8tMYo1QJJsVpmntOy9Dt13rVnOniC1hIu0Gzb3yKDOQzdxeg+ilu2p
 8kO8zg9Yywdq54Pvuyorf790mMNHSp1QGlsHYy+MP9RqZ5we5lHHBMAKOzi98I1oXVa9
 LViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776513158; x=1777117958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aViH8Sa+dRrCP6ce2A729e6K8FtQacwZ96aCuGlKC5c=;
 b=mncBoLxv3UsZB9tB1+auueaa0DdfVhsuih2T+yoqbQrTkgUNlXftTRH5xvn2gpAnly
 xYhZvt8S7Iis1sthF0Ryfgxn6QHrFa4+IeJFGMZE/K8mYBGGICxifUBMKhtUP9IYBVeE
 z3yq5XnNZKzNZRYgmCRl+V8zdndhmhU0Y9M9UQi5yq9Ih/6pVaXLBzBi4IREBKCDRnxk
 zyt/DwgB13qgBkAbhahJFyn6oepMYaM0dgv9w4vF6iXRN6lLW9g9O1Xj321C4u8B5fYh
 TJnXYOs7sTau3p52JvFXHuanybvAWHzDJURZLodYVAGI88WRodkdch/vlkCie85SbpSk
 XM+w==
X-Gm-Message-State: AOJu0YzVlrADB9UqBHWXiJlG8EW2IOKFs/Ct+NUk6rAo5hVkJDd4CB53
 HfhQg3I3dJriBOojl8ddQVbA/q0okZATCtMXLWHc+R305qzV0Ev0nezl0fdE5uli
X-Gm-Gg: AeBDietNICju4cCjj1NT2mfsau5Q0lUs7pvwWHVEPybMMj+W9SKZzDFOVTVvDfyfqCU
 Nhg216Hd9PsnuDN6OQsRAKy5NQaRfOiVQSiaQVAtj41hdZT+ucQVYs+q5Lo8S5UDAREfh/WjlNs
 BwaggFghxtBcrt1/4NbAcl0Mc4XX9yNBYLt5gibIVKtJd6IWVjJsM1LVnjQajQFKAZBGYF610ib
 dGnFyhrFaAXjLLumYGZuK6ZPoPj3fKolK+GPERGg9BwIyW/pWmhl1lXEGeSQrnzqnJhuwIU+PPU
 8IJvuQELpLy91A7WKjKoMWskgXfhKvBaitu2w52PpI4y8rAjCH0HpsHmx5DTHARBRu5zNn2vn6N
 WqSYZwpITstKGON5svAdX9wFYtJgqWs6lM5RPcp9B9VRggKDUPIcvFn3+IOmHr0vcZRhmQhM0Yg
 +as063kS0CRfIuzzq62JBmCMQT9VArQ34sI/W6r9e6t/7ci/wwu7VtYv2PstEH1u4OxxNf
X-Received: by 2002:a05:6a20:3946:b0:39c:212c:9088 with SMTP id
 adf61e73a8af0-3a08ca6e212mr6253151637.20.1776513158018; 
 Sat, 18 Apr 2026 04:52:38 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797704b575sm3755530a12.29.2026.04.18.04.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 04:52:37 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] chardev/msmouse: save and restore device state for migration
 and savevm
Date: Sat, 18 Apr 2026 18:52:30 +0700
Message-ID: <20260418115230.17809-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=vikingtc4@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

MouseChardev holds state that must survive migration and savevm/loadvm:

  tiocm   - serial line control (RTS/DTR).  When zero the mouse is
            considered powered-off and all input events are silently
            dropped.  Losing this field after migration leaves the
            mouse in a dead state: the guest driver must toggle
            RTS/DTR again to re-detect the mouse, which most drivers
            (Linux sermouse, DOS ctmouse) only do at initialisation.

  axis[]  - accumulated X/Y movement not yet encoded into a packet.

  btns[]  - current button state.

  btnc[]  - per-button change flags used for middle-button tracking.

  outbuf  - Fifo8 of encoded mouse bytes waiting to be delivered to
            the serial port receive FIFO.

Add a VMStateDescription covering all five fields, registering it in
msmouse_chr_open and unregistering it in char_msmouse_finalize.  This
follows the same pattern used by ui/vdagent.c

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1234

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
Steps to reproduce:

* 1. Starting source QEMU under GDB
gdb -q ./qemu-system-x86_64

* Inside GDB:

(gdb) set args -chardev msmouse,id=mouse0 \
  -device isa-serial,chardev=mouse0 \
  - <other_options>

(gdb) break msmouse_input_sync
(gdb) run

* 2. Starting destination QEMU under GDB
gdb -q ./qemu-system-x86_64

* Inside GDB:

(gdb) set args -chardev msmouse,id=mouse0 \
  -S -incoming tcp:0:4444
  -device isa-serial,chardev=mouse0 \
  - <other_options>

(gdb) break msmouse_chr_ioctl
(gdb) run
<waiting for migration>

* 3. Send mouse events to source
{"execute":"qmp_capabilities"}

* Power on the mouse:
{"execute":"human-monitor-command","arguments":{"command-line":"o 0x2fc 0x03"}}

* Inject a movement event with buttons:
{"execute":"input-send-event","arguments":{"events":[{"type":"rel","data":{"axis":"x","value":30}},{"type":"rel","data":{"axis":"y","value":-10}},{"type":"btn","data":{"button":"left","down":true}},{"type":"btn","data":{"button":"middle","down":true}}]}}

Thread 1 "qemu-system-x86" hit Breakpoint 1, msmouse_input_sync (dev=0x555557648a00)
    at ../chardev/msmouse.c:171
171	    MouseChardev *mouse = MOUSE_CHARDEV(dev);
(gdb) next
172	    Chardev *chr = CHARDEV(dev);
(gdb) next
175	    if (!MSMOUSE_PWR(mouse->tiocm)) {
(gdb) print mouse->tiocm
$17 = 6
(gdb) print mouse->axis[1]
$18 = -10
(gdb) print mouse->axis[0]
$19 = 30
(gdb) print mouse->btns[0]
$20 = true
(gdb)  print mouse->btns[2]
$21 = false
(gdb) print mouse->btnc[0]
$22 = true
(gdb)  print mouse->btnc[2]
$23 = false
(gdb) print mouse->outbuf 
$24 = {data = 0x5555578bbdf0 "M3\b\001$1-5\020\020\020\021<<-/53%<<1%-5", capacity = 64, 
  head = 1, num = 55}
(gdb) continue

* 4. Start migration until completed

{"execute":"migrate","arguments":{"uri":"tcp:127.0.0.1:4444"}}

* 5. Verify mouse data on dest

* As-is:
Thread 1 "qemu-system-x86" hit Breakpoint 1, msmouse_chr_ioctl (chr=0x555557648ad0, 
    cmd=1, arg=0x7ffff415ba80) at ../chardev/msmouse.c:182
182	{
(gdb) next
183	    MouseChardev *mouse = MOUSE_CHARDEV(chr);
(gdb) next
184	    int c, i, j;
(gdb) print ((MouseChardev *)chr)->tiocm
$1 = 0
(gdb) print ((MouseChardev *)chr)->axis[0]
$2 = 0
(gdb) print ((MouseChardev *)chr)->axis[1]
$3 = 0
(gdb) print ((MouseChardev *)chr)->btns[0]
$4 = false
(gdb) print ((MouseChardev *)chr)->btns[2]
$5 = false
(gdb) print ((MouseChardev *)chr)->btnc[0]
$6 = false
(gdb) print ((MouseChardev *)chr)->btnc[2]
$7 = false
(gdb) print ((MouseChardev *)chr)->outbuf
$8 = {data = 0x5555578bbf60 "\273xUU\005", capacity = 64, head = 0, num = 0}
(gdb) 

* To-be:
Thread 1 "qemu-system-x86" hit Breakpoint 1, msmouse_chr_ioctl (chr=0x555557648ad0, 
    cmd=1, arg=0x7ffff415ba80) at ../chardev/msmouse.c:197
197    {
(gdb) next
198        MouseChardev *mouse = MOUSE_CHARDEV(chr);
(gdb) next
199        int c, i, j;
(gdb) print ((MouseChardev *)chr)->tiocm
$1 = 6
(gdb) print ((MouseChardev *)chr)->axis[0]
$2 = 0
(gdb) print ((MouseChardev *)chr)->axis[1]
$3 = 0
(gdb) print ((MouseChardev *)chr)->btns[0]
$4 = true
(gdb) print ((MouseChardev *)chr)->btns[2]
$5 = false
(gdb) print ((MouseChardev *)chr)->btnc[0]
$6 = true
(gdb) print ((MouseChardev *)chr)->btnc[2]
$7 = false
(gdb) print ((MouseChardev *)chr)->outbuf
$8 = {data = 0x5555578bbf60 "M3\b\001$1-5\020\020\020\021<<-/53%<<1%-5", capacity = 64, 
  head = 1, num = 59}

 chardev/msmouse.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 365f04546e..e991135be9 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -30,6 +30,7 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "qom/object.h"
+#include "migration/vmstate.h"
 
 #define MSMOUSE_LO6(n)  ((n) & 0x3f)
 #define MSMOUSE_HI2(n)  (((n) & 0xc0) >> 6)
@@ -70,6 +71,20 @@ typedef struct MouseChardev MouseChardev;
 DECLARE_INSTANCE_CHECKER(MouseChardev, MOUSE_CHARDEV,
                          TYPE_CHARDEV_MSMOUSE)
 
+static const VMStateDescription vmstate_msmouse = {
+    .name = "msmouse",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(tiocm, MouseChardev),
+        VMSTATE_INT32_ARRAY(axis, MouseChardev, INPUT_AXIS__MAX),
+        VMSTATE_BOOL_ARRAY(btns, MouseChardev, INPUT_BUTTON__MAX),
+        VMSTATE_BOOL_ARRAY(btnc, MouseChardev, INPUT_BUTTON__MAX),
+        VMSTATE_FIFO8(outbuf, MouseChardev),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void msmouse_chr_accept_input(Chardev *chr)
 {
     MouseChardev *mouse = MOUSE_CHARDEV(chr);
@@ -247,6 +262,7 @@ static void char_msmouse_finalize(Object *obj)
 {
     MouseChardev *mouse = MOUSE_CHARDEV(obj);
 
+    vmstate_unregister(NULL, &vmstate_msmouse, mouse);
     if (mouse->hs) {
         qemu_input_handler_unregister(mouse->hs);
     }
@@ -263,6 +279,7 @@ static bool msmouse_chr_open(Chardev *chr,
                                             &msmouse_handler);
     mouse->tiocm = 0;
     fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
+    vmstate_register_any(NULL, &vmstate_msmouse, mouse);
 
     /* Never send CHR_EVENT_OPENED */
     return true;
-- 
2.43.0


