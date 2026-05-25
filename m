Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5352CCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 06:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wROv4-0004nG-Vz; Mon, 25 May 2026 02:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROtO-0002mG-NW
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROtL-0001Fj-79
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779690862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0KRCbh+DuowVvjWgeRAQvhYdmF0tf77Yft4EyxaRRo=;
 b=aNDrMUFlYzfi3lsjFmGhfg6+K+4w76Pas3yOy9qnVdsnsm9EAaRX+ygO2o3BMUTMmgnLLj
 7RbJbLknIFDSTy78cHf0wtFNYR0w78Xys6+kmNnwMtPZMsLew44k/EEausWrSc2fP42u6G
 nlfl8XEFBsHZKTc+prU5ivMbsw5iVLM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-npzeTzTbMmiPXR5Bja2g8w-1; Mon,
 25 May 2026 02:34:17 -0400
X-MC-Unique: npzeTzTbMmiPXR5Bja2g8w-1
X-Mimecast-MFC-AGG-ID: npzeTzTbMmiPXR5Bja2g8w_1779690856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7ACD19560B2; Mon, 25 May 2026 06:34:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BA771800576; Mon, 25 May 2026 06:34:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 14/38] ui/console: Add qemu_text_console_put_linux()
Date: Mon, 25 May 2026 10:31:57 +0400
Message-ID: <20260525063223.1409791-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
References: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Add a text console helper that accepts Linux input key codes and use it
as the common implementation for qemu_text_console_put_qcode(). This lets
callers that already use Linux key codes avoid converting them back to
QKeyCode.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-6-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/console.h |  2 ++
 ui/console.c         | 66 +++++++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index cfa940d4c66..691040f5948 100644
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
index eaa41086743..2dcb4660fbf 100644
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


