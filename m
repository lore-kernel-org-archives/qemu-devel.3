Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C74CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaky-0004IV-JR; Wed, 20 May 2026 02:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak2-0003aL-DA; Wed, 20 May 2026 02:49:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajw-0001TV-QH; Wed, 20 May 2026 02:49:17 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbc096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=f4nMAQnz85jIi6jdDFcVx4lxK79NORQbClAxHDODkiQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259697; v=1;
 b=RGXSAvTuPvf5H2W5E/0Vc0cdFsbl7fXk0UC8V3c1d7RRZzB/L8GL4lhx4vLJmUAA
 G2iKzeNMUrJWLJhxyN5O5KOCFmZh1hk5hwTLlavjMGSShRjDOFrkg5i4BehV3kOm
 sc5lutMq3LJmG0nyEOaIQLycnEa8aJ+5q5DKTJJM9jnPJCnRAT3xiyFifgyEA3iP
 13sF0J45qp0sxiKmLuAKpk1SfhUziLNOZXI3p6w3L1eHZDsMA4cU606F3AqzT9Tj
 GPsQA/1h6Nfh5DOXGwH7Oc906/YUJI6qigjTm5PxAVR3w6ePQkQTwhVLX620Phc9
 URfOpT4EuRLVoP0OlZPqrw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:58 +0900
Subject: [PATCH v3 15/29] hw/m68k/next-kbd: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-15-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5735;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=iyLiD2EoMRDRtaROtRWs8sE4KAkgfKNGzp5wMpy28GQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpLKcxfQNTz9y7zptG7KwMiFlUvVu0yeRtz4LVnG08
 V1fVSrYUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJG0HkaGq38nPdpR57firNd/
 7Y57v+M/8x84+s16aYzBkh8JShESPxn++2WvkPGZefpxYROnG5+gx1+b1gu/1l29t3Xpb9Zj4WY
 TuAA=
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
 hw/m68k/next-kbd.c | 118 ++++++++++++++++++++++++++---------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 7efbd806b7c8..7be5ab2fb798 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -31,6 +31,7 @@
 #include "qemu/log.h"
 #include "hw/core/sysbus.h"
 #include "hw/m68k/next-cube.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
@@ -165,59 +166,59 @@ static const MemoryRegionOps kbd_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static const int qcode_to_nextkbd_keycode[] = {
-    [Q_KEY_CODE_ESC]           = 0x49,
-    [Q_KEY_CODE_1]             = 0x4a,
-    [Q_KEY_CODE_2]             = 0x4b,
-    [Q_KEY_CODE_3]             = 0x4c,
-    [Q_KEY_CODE_4]             = 0x4d,
-    [Q_KEY_CODE_5]             = 0x50,
-    [Q_KEY_CODE_6]             = 0x4f,
-    [Q_KEY_CODE_7]             = 0x4e,
-    [Q_KEY_CODE_8]             = 0x1e,
-    [Q_KEY_CODE_9]             = 0x1f,
-    [Q_KEY_CODE_0]             = 0x20,
-    [Q_KEY_CODE_MINUS]         = 0x1d,
-    [Q_KEY_CODE_EQUAL]         = 0x1c,
-    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
-
-    [Q_KEY_CODE_Q]             = 0x42,
-    [Q_KEY_CODE_W]             = 0x43,
-    [Q_KEY_CODE_E]             = 0x44,
-    [Q_KEY_CODE_R]             = 0x45,
-    [Q_KEY_CODE_T]             = 0x48,
-    [Q_KEY_CODE_Y]             = 0x47,
-    [Q_KEY_CODE_U]             = 0x46,
-    [Q_KEY_CODE_I]             = 0x06,
-    [Q_KEY_CODE_O]             = 0x07,
-    [Q_KEY_CODE_P]             = 0x08,
-    [Q_KEY_CODE_RET]           = 0x2a,
-    [Q_KEY_CODE_A]             = 0x39,
-    [Q_KEY_CODE_S]             = 0x3a,
-
-    [Q_KEY_CODE_D]             = 0x3b,
-    [Q_KEY_CODE_F]             = 0x3c,
-    [Q_KEY_CODE_G]             = 0x3d,
-    [Q_KEY_CODE_H]             = 0x40,
-    [Q_KEY_CODE_J]             = 0x3f,
-    [Q_KEY_CODE_K]             = 0x3e,
-    [Q_KEY_CODE_L]             = 0x2d,
-    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
-    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
-    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
-    [Q_KEY_CODE_Z]             = 0x31,
-    [Q_KEY_CODE_X]             = 0x32,
-    [Q_KEY_CODE_C]             = 0x33,
-    [Q_KEY_CODE_V]             = 0x34,
-
-    [Q_KEY_CODE_B]             = 0x35,
-    [Q_KEY_CODE_N]             = 0x37,
-    [Q_KEY_CODE_M]             = 0x36,
-    [Q_KEY_CODE_COMMA]         = 0x2e,
-    [Q_KEY_CODE_DOT]           = 0x2f,
-    [Q_KEY_CODE_SLASH]         = 0x30,
-
-    [Q_KEY_CODE_SPC]           = 0x38,
+static const int linux_to_nextkbd_keycode[] = {
+    [KEY_ESC]        = 0x49,
+    [KEY_1]          = 0x4a,
+    [KEY_2]          = 0x4b,
+    [KEY_3]          = 0x4c,
+    [KEY_4]          = 0x4d,
+    [KEY_5]          = 0x50,
+    [KEY_6]          = 0x4f,
+    [KEY_7]          = 0x4e,
+    [KEY_8]          = 0x1e,
+    [KEY_9]          = 0x1f,
+    [KEY_0]          = 0x20,
+    [KEY_MINUS]      = 0x1d,
+    [KEY_EQUAL]      = 0x1c,
+    [KEY_BACKSPACE]  = 0x1b,
+
+    [KEY_Q]          = 0x42,
+    [KEY_W]          = 0x43,
+    [KEY_E]          = 0x44,
+    [KEY_R]          = 0x45,
+    [KEY_T]          = 0x48,
+    [KEY_Y]          = 0x47,
+    [KEY_U]          = 0x46,
+    [KEY_I]          = 0x06,
+    [KEY_O]          = 0x07,
+    [KEY_P]          = 0x08,
+    [KEY_ENTER]      = 0x2a,
+    [KEY_A]          = 0x39,
+    [KEY_S]          = 0x3a,
+
+    [KEY_D]          = 0x3b,
+    [KEY_F]          = 0x3c,
+    [KEY_G]          = 0x3d,
+    [KEY_H]          = 0x40,
+    [KEY_J]          = 0x3f,
+    [KEY_K]          = 0x3e,
+    [KEY_L]          = 0x2d,
+    [KEY_SEMICOLON]  = 0x2c,
+    [KEY_APOSTROPHE] = 0x2b,
+    [KEY_GRAVE]      = 0x26,
+    [KEY_Z]          = 0x31,
+    [KEY_X]          = 0x32,
+    [KEY_C]          = 0x33,
+    [KEY_V]          = 0x34,
+
+    [KEY_B]          = 0x35,
+    [KEY_N]          = 0x37,
+    [KEY_M]          = 0x36,
+    [KEY_COMMA]      = 0x2e,
+    [KEY_DOT]        = 0x2f,
+    [KEY_SLASH]      = 0x30,
+
+    [KEY_SPACE]      = 0x38,
 };
 
 static void nextkbd_put_keycode(NextKBDState *s, int keycode)
@@ -246,15 +247,14 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
                           QemuInputEvent *evt)
 {
     NextKBDState *s = NEXTKBD(dev);
-    int qcode, keycode;
+    int keycode;
 
-    qcode = qemu_input_linux_to_qcode(evt->key.key);
-    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
+    if (evt->key.key >= ARRAY_SIZE(linux_to_nextkbd_keycode)) {
         return;
     }
 
     /* Shift key currently has no keycode, so handle separately */
-    if (qcode == Q_KEY_CODE_SHIFT) {
+    if (evt->key.key == KEY_LEFTSHIFT) {
         if (evt->key.down) {
             s->shift |= KD_LSHIFT;
         } else {
@@ -262,7 +262,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    if (qcode == Q_KEY_CODE_SHIFT_R) {
+    if (evt->key.key == KEY_RIGHTSHIFT) {
         if (evt->key.down) {
             s->shift |= KD_RSHIFT;
         } else {
@@ -270,7 +270,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    keycode = qcode_to_nextkbd_keycode[qcode];
+    keycode = linux_to_nextkbd_keycode[evt->key.key];
     if (!keycode) {
         return;
     }

-- 
2.54.0


