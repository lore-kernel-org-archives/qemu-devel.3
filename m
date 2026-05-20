Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3749ECD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPakh-0003rX-Sm; Wed, 20 May 2026 02:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajz-0003YR-7N; Wed, 20 May 2026 02:49:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajv-0001Oi-SA; Wed, 20 May 2026 02:49:14 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbT096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jgq/x+wxMExI7FtnMbUC3yjBR9oYwGNXyrR5O4d+5h4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259695; v=1;
 b=gTBpOGFje6dbHkEJMs0CpDK/tEvgvVMwHRPpdcEna1pIcrHz9kTvGCVwU1YMBp3Q
 NCXzjvyorm+ZdROfOn/ZSYEL7ADgVJVTqkOYpunor1X3R//pY0p4B8f2haVPMtrt
 hGamhlDs49LHrqbjQ9jjyqTXOrR2LOpXYi/b7mYpYGh2Qvsub6g5dM1Ly3t5U+sD
 SpP3BgMCNg1E+v9ELkpnfhkMIdauLM0e78qw5GVPt/7y+lu74vO1DKJitdQIcnXU
 Ds8DIKiA2WymSiYaVgV3nEmmIsfZc785yM3HCtkEDzudqKyBIEwl3EUxsOh3+f1Z
 1g0c5z1YxIC2JKitXnOrug==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:49 +0900
Subject: [PATCH v3 06/29] ui/console: Add qemu_text_console_put_linux()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-6-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4212;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=3jahZkSDsrfQjdinHFtvW4NVyHmZZ+eju2Mo3RNqPHE=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpEyGrkB0xvel/a6agZp3fqZuCPDla1rqy7pI8snCj
 Ol/HpztKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmIjxCoZ/Gg2lISs0w+u/rf16
 0yLI/OPty0tUywx6d5XNKQ9VuXvoFMM/69Z4k6iLYctni2p1u38LaY1ezqm/uviI5puW6iksdaJ
 cAA==
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

Add a text console helper that accepts Linux input key codes and use it
as the common implementation for qemu_text_console_put_qcode(). This lets
callers that already use Linux key codes avoid converting them back to
QKeyCode.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/console.h |  2 ++
 ui/console.c         | 66 ++++++++++++++++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index cfa940d4c666..691040f5948d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -109,6 +109,8 @@ bool qemu_mouse_set(int index, Error **errp);
 
 void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
 bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
+bool qemu_text_console_put_linux(QemuTextConsole *s, unsigned int lnx,
+                                 bool ctrl);
 void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);
 
 /* consoles */
diff --git a/ui/console.c b/ui/console.c
index eaa410867431..2dcb4660fbf8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "ui/vgafont.h"
 #include "hw/core/qdev.h"
@@ -302,36 +303,57 @@ void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
     qemu_text_console_handle_keysym(s, keysym);
 }
 
-static const int qcode_to_keysym[Q_KEY_CODE__MAX] = {
-    [Q_KEY_CODE_UP]     = QEMU_KEY_UP,
-    [Q_KEY_CODE_DOWN]   = QEMU_KEY_DOWN,
-    [Q_KEY_CODE_RIGHT]  = QEMU_KEY_RIGHT,
-    [Q_KEY_CODE_LEFT]   = QEMU_KEY_LEFT,
-    [Q_KEY_CODE_HOME]   = QEMU_KEY_HOME,
-    [Q_KEY_CODE_END]    = QEMU_KEY_END,
-    [Q_KEY_CODE_PGUP]   = QEMU_KEY_PAGEUP,
-    [Q_KEY_CODE_PGDN]   = QEMU_KEY_PAGEDOWN,
-    [Q_KEY_CODE_DELETE] = QEMU_KEY_DELETE,
-    [Q_KEY_CODE_TAB]    = QEMU_KEY_TAB,
-    [Q_KEY_CODE_BACKSPACE] = QEMU_KEY_BACKSPACE,
+static const int linux_to_keysym[] = {
+    [KEY_UP]     = QEMU_KEY_UP,
+    [KEY_DOWN]   = QEMU_KEY_DOWN,
+    [KEY_RIGHT]  = QEMU_KEY_RIGHT,
+    [KEY_LEFT]   = QEMU_KEY_LEFT,
+    [KEY_HOME]   = QEMU_KEY_HOME,
+    [KEY_END]    = QEMU_KEY_END,
+    [KEY_PAGEUP]   = QEMU_KEY_PAGEUP,
+    [KEY_PAGEDOWN]   = QEMU_KEY_PAGEDOWN,
+    [KEY_DELETE] = QEMU_KEY_DELETE,
+    [KEY_TAB]    = QEMU_KEY_TAB,
+    [KEY_BACKSPACE] = QEMU_KEY_BACKSPACE,
 };
 
-static const int ctrl_qcode_to_keysym[Q_KEY_CODE__MAX] = {
-    [Q_KEY_CODE_UP]     = QEMU_KEY_CTRL_UP,
-    [Q_KEY_CODE_DOWN]   = QEMU_KEY_CTRL_DOWN,
-    [Q_KEY_CODE_RIGHT]  = QEMU_KEY_CTRL_RIGHT,
-    [Q_KEY_CODE_LEFT]   = QEMU_KEY_CTRL_LEFT,
-    [Q_KEY_CODE_HOME]   = QEMU_KEY_CTRL_HOME,
-    [Q_KEY_CODE_END]    = QEMU_KEY_CTRL_END,
-    [Q_KEY_CODE_PGUP]   = QEMU_KEY_CTRL_PAGEUP,
-    [Q_KEY_CODE_PGDN]   = QEMU_KEY_CTRL_PAGEDOWN,
+static const int ctrl_linux_to_keysym[] = {
+    [KEY_UP]     = QEMU_KEY_CTRL_UP,
+    [KEY_DOWN]   = QEMU_KEY_CTRL_DOWN,
+    [KEY_RIGHT]  = QEMU_KEY_CTRL_RIGHT,
+    [KEY_LEFT]   = QEMU_KEY_CTRL_LEFT,
+    [KEY_HOME]   = QEMU_KEY_CTRL_HOME,
+    [KEY_END]    = QEMU_KEY_CTRL_END,
+    [KEY_PAGEUP]   = QEMU_KEY_CTRL_PAGEUP,
+    [KEY_PAGEDOWN]   = QEMU_KEY_CTRL_PAGEDOWN,
 };
 
 bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl)
 {
+    unsigned int lnx = qemu_input_map_qcode_to_linux[qcode];
+    return qemu_text_console_put_linux(s, lnx, ctrl);
+}
+
+bool qemu_text_console_put_linux(QemuTextConsole *s, unsigned int lnx,
+                                 bool ctrl)
+{
+    size_t maplen;
+    const int *map;
     int keysym;
 
-    keysym = ctrl ? ctrl_qcode_to_keysym[qcode] : qcode_to_keysym[qcode];
+    if (ctrl) {
+        maplen = ARRAY_SIZE(ctrl_linux_to_keysym);
+        map = ctrl_linux_to_keysym;
+    } else {
+        maplen = ARRAY_SIZE(linux_to_keysym);
+        map = linux_to_keysym;
+    }
+
+    if (lnx >= maplen) {
+        return false;
+    }
+
+    keysym = map[lnx];
     if (keysym == 0) {
         return false;
     }

-- 
2.54.0


