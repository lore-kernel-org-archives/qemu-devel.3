Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80F0CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbML-0005Z8-Q0; Thu, 11 Jun 2026 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbMK-0005YF-Hz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbMJ-0005Di-5J
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idSfeOkupul6CAnH9YIHT/7fjHiKKtjSvSj+yBGEr9o=;
 b=bv+lupLrR95E4/cY4+IsjqYNQiRPv8adXvZmO2PH6zybE2zNI8xehTmMmMvC3wa6/OiMQ3
 EJ93wk/hyoPvqhdu7jW8AoP2nyoHbaaH9Qku696Z5FJXCUVEJybDRcHsiO/GFSDlU/1rNd
 FcJO7ujHGNDcqgqrGNIk1WG3rmpwB6M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-BKLwRNSGNqiU2uAjI7W4LA-1; Thu,
 11 Jun 2026 05:05:49 -0400
X-MC-Unique: BKLwRNSGNqiU2uAjI7W4LA-1
X-Mimecast-MFC-AGG-ID: BKLwRNSGNqiU2uAjI7W4LA_1781168747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3A881955E7F; Thu, 11 Jun 2026 09:05:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A221D3008B34; Thu, 11 Jun 2026 09:05:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:39 +0400
Subject: [PATCH v3 24/35] ui/console: add console event notifier infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-24-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=y/0JwIQWr7VsppBD/1tHcBRBSRlt5rwMryokCqoziC0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnngtuxqvD9tRaqTMbqqNVpMxtoVRhOW8/jnt
 HSJl03+MACJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54AAKCRDa6OEJdZac
 5Xv5D/9c8UPVVEoOEHHq4d7OGRwdMl+2mAL73W4CYwzCedRtNRu5wnY6DJiZqdhLigErHwWOqXi
 VAo/zzd3tZjLwo7WOdmzZjLNx6l4UR0Fzq/yaDLxD9RMxtTyZN9o28sSuuA1p5R+QFNQesb30bj
 h9TqCeRBZ8lCJ+XhJDxyxSbKmLUE2sA1dQwTR6JiAKza3hY9vREy3NTlh0Su9TbSKdp9PoUvdRP
 hvDc7t4WgJMSWOtnj8+mSAfX6t0/pRMi053YiDaUy6kMxCmCPnxtHOOO/KNkL3ApqM7zoxRGd+1
 HHgs2thCtM6bIFlxMtuoMxwpe51PV996ctbk7ARJLSuO32WYL7Wu2IsD+ocYSVclJxoSECoplOR
 by7EnQk8Cdvh87wlWxdFblTU2Xqe3fP060jolhH/sjfc9j85SuNVxW2W/iU5ncvnpHRZvuVer/7
 xymMLYA0WvvGuD1FtQxxmB3ZOjCEMvYfLhrBS1dxjM5Dc15j1jod1a5PcwVR+9GKHGq5szrQUao
 Aj6EFcDYNYBdx/IKgHee4COASpCl93D1rWOdMKAFiggZCCzzaIb8RlIEGvcZ/kiCQd0hLaLZC6n
 DrzESWA/6uBqcp0hrXGImZFoRQm7oZn0b0OSsnf7pViLl0GihI4bAghUCzPx5VGgQNsMO9To0Qz
 BxRyWIhPjw8vVAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Add a NotifierList to DisplayState so display backends can be notified
when consoles are added or removed at runtime.

No events are fired yet, that follows in the next commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 18 ++++++++++++++++++
 ui/console.c         | 23 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 1c7f7e62c1a..44ebc578651 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -442,6 +442,24 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_cleanup(void);
 void qemu_display_help(void);
 
+/*
+ * Console notifications:
+ * Handlers must be idempotent, it may notify multiple times.
+ */
+typedef enum {
+    QEMU_CONSOLE_ADDED,
+    QEMU_CONSOLE_REMOVED,
+} QemuConsoleEventType;
+
+typedef struct QemuConsoleEvent {
+    QemuConsoleEventType type;
+    QemuConsole *con;
+} QemuConsoleEvent;
+
+void qemu_console_add_notifier(Notifier *notifier);
+void qemu_console_remove_notifier(Notifier *notifier);
+void qemu_console_notify(QemuConsoleEventType type, QemuConsole *con);
+
 /* vnc.c */
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password, Error **errp);
diff --git a/ui/console.c b/ui/console.c
index 1fe3e3a3a6c..76851bc129d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -70,6 +70,7 @@ struct DisplayState {
     bool refreshing;
 
     QLIST_HEAD(, DisplayChangeListener) listeners;
+    NotifierList console_notifiers;
 };
 
 static DisplayState *display_state;
@@ -84,6 +85,16 @@ static bool console_compatible_with(QemuConsole *con,
 static QemuConsole *qemu_graphic_console_lookup_unused(void);
 static void dpy_set_ui_info_timer(void *opaque);
 
+void qemu_console_notify(QemuConsoleEventType type, QemuConsole *con)
+{
+    DisplayState *ds = get_alloc_displaystate();
+    QemuConsoleEvent event = {
+        .type = type,
+        .con = con,
+    };
+    notifier_list_notify(&ds->console_notifiers, &event);
+}
+
 static void gui_update(void *opaque)
 {
     uint64_t interval = GUI_REFRESH_INTERVAL_IDLE;
@@ -1056,10 +1067,22 @@ static DisplayState *get_alloc_displaystate(void)
 {
     if (!display_state) {
         display_state = g_new0(DisplayState, 1);
+        notifier_list_init(&display_state->console_notifiers);
     }
     return display_state;
 }
 
+void qemu_console_add_notifier(Notifier *notifier)
+{
+    DisplayState *ds = get_alloc_displaystate();
+    notifier_list_add(&ds->console_notifiers, notifier);
+}
+
+void qemu_console_remove_notifier(Notifier *notifier)
+{
+    notifier_remove(notifier);
+}
+
 /*
  * Called by main(), after creating QemuConsoles
  * and before initializing ui (sdl/vnc/...).

-- 
2.54.0


