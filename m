Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4AAC54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmu-0008S3-98; Sat, 24 May 2025 13:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmd-0008AZ-D4
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmZ-0000iF-B7
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRJ+lxAG6BwZurQNM17kJYNnc6LLjMdGBSuT8AZQBgI=;
 b=HGW81cuRXL89yOkS8V/v0Ycx60JKx+4UoHylexxec6BgXyH55UhVVYtFlF8zerkbStDwwr
 1OCcZEY/ljCbHEOL/CE0a1M0Tt/trg0Y4JntiUPjEGvFwJYu4HTN6g6v6WHkvSqea0bzWT
 3gNuMreTcQkB4KayJ1sve44T9DxXuEk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-TowhQawqMROCceSkYGaJ3g-1; Sat,
 24 May 2025 13:35:36 -0400
X-MC-Unique: TowhQawqMROCceSkYGaJ3g-1
X-Mimecast-MFC-AGG-ID: TowhQawqMROCceSkYGaJ3g_1748108135
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52497195608A
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:35 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F3D730001A1; Sat, 24 May 2025 17:35:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 05/19] ui/clipboard: delay clipboard update when not running
Date: Sat, 24 May 2025 19:34:58 +0200
Message-ID: <20250524173514.317886-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

When VM is paused, we shouldn't notify of clipboard changes, similar to
how input are being treated.

On unsuspend, notify of the current state.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/clipboard.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index f5db60c63d..ec00a0b8ec 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "system/runstate.h"
 #include "ui/clipboard.h"
 #include "trace.h"
 
@@ -7,6 +8,10 @@ static NotifierList clipboard_notifiers =
 
 static QemuClipboardInfo *cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
 
+static VMChangeStateEntry *cb_change_state_entry = NULL;
+
+static bool cb_reset_serial_on_resume = false;
+
 static const VMStateDescription vmstate_cbcontent = {
     .name = "clipboard/content",
     .version_id = 0,
@@ -33,8 +38,32 @@ const VMStateDescription vmstate_cbinfo = {
     }
 };
 
+static void qemu_clipboard_change_state(void *opaque, bool running, RunState state)
+{
+    int i;
+
+    if (!running) {
+        return;
+    }
+
+    if (cb_reset_serial_on_resume) {
+        qemu_clipboard_reset_serial();
+    }
+
+    for (i = 0; i < QEMU_CLIPBOARD_SELECTION__COUNT; i++) {
+        if (cbinfo[i]) {
+            qemu_clipboard_update(cbinfo[i]);
+        }
+    }
+
+}
+
 void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
 {
+    if (cb_change_state_entry == NULL) {
+        cb_change_state_entry = qemu_add_vm_change_state_handler(qemu_clipboard_change_state, NULL);
+    }
+
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
 }
 
@@ -109,7 +138,9 @@ void qemu_clipboard_update(QemuClipboardInfo *info)
         }
     }
 
-    notifier_list_notify(&clipboard_notifiers, &notify);
+    if (runstate_is_running() || runstate_check(RUN_STATE_SUSPENDED)) {
+        notifier_list_notify(&clipboard_notifiers, &notify);
+    }
 
     if (cbinfo[info->selection] != info) {
         qemu_clipboard_info_unref(cbinfo[info->selection]);
@@ -189,7 +220,12 @@ void qemu_clipboard_reset_serial(void)
             info->serial = 0;
         }
     }
-    notifier_list_notify(&clipboard_notifiers, &notify);
+
+    if (runstate_is_running() || runstate_check(RUN_STATE_SUSPENDED)) {
+        notifier_list_notify(&clipboard_notifiers, &notify);
+    } else {
+        cb_reset_serial_on_resume = true;
+    }
 }
 
 void qemu_clipboard_set_data(QemuClipboardPeer *peer,
-- 
2.49.0


