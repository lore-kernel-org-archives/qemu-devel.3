Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E59CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFP-0008Ds-6e; Mon, 08 Jun 2026 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFC-0007w2-3I
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUF9-00008P-A2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ciu2JhS6Lc8zBZgiAkP1BQqakwjuRUB6YE6coQ4sf9M=;
 b=QovHKY+O+KZ5RSlMFhLAAuGDkywymPYPHX91PTxkMB19IweFdqmWW3IBTLt+9LGxegxxgP
 tqxyY4B06ShCZkh4NZpYKTsYY78mtHHguRgjtQju5NJ0BXVNABPt1/xPxdBoUbWRqIsMYO
 3BMaPHisNDpSDQMxCp1QmqgcxBK/TAg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-jIe02McgOdK1mdzypzovaQ-1; Mon,
 08 Jun 2026 03:17:50 -0400
X-MC-Unique: jIe02McgOdK1mdzypzovaQ-1
X-Mimecast-MFC-AGG-ID: jIe02McgOdK1mdzypzovaQ_1780903069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A6941956095; Mon,  8 Jun 2026 07:17:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D07E180049F; Mon,  8 Jun 2026 07:17:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:31 +0400
Subject: [PATCH v2 13/33] ui/spice: add cleanup on shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-13-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11842;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UVRFSDBaOWRpiYoDGWbknm14bEgZYMdF7gxQOZ+f6vg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxKpil/c2bo7Cj7YaLllhhEhkjAMtAy2YjcQ
 8Zxq3eDz1GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSgAKCRDa6OEJdZac
 5RGbEAC7MWqD9oSmr2GznDlAaVDDaSa1OH+5QWRmfIsC1TnFtYgbvwHqQ4Vndhg6z/flElsbZI5
 XOxD+VEF62gH9l8BcGNQAxjTH4GX8Dx+6I0LZGcty5zhuGn0fyUXU/bGTsJunSbwnxBAuGJucFF
 uhY8al2whUolGQsgS5OEfiWrP6Aa1gtLOOIeROxFrQOXsArD/dyITNAEb32syEZy9QCOwbfc16u
 iCZROnMU+aOywJIG2OkuAyHB7g5/ZotU18ZLmGg8AadW99AoBpCyNaJZ6APnzPJzE3UdnhPvYsB
 GRtrgPspDkN5Ep4QdDjM9nqpL9OOyuSOETFy1/Rc//IMeFXEDqRYMf/WgzdRVes5jlXFJ1BDAfw
 HbtrjRL2Ezevvp0NzdVpnVacetXvtCee5erAfsLfJdoCPDxgtQaWCllhSA4rcmMIg7/5acL0z74
 a8lEl6vfRT3STrK2XQ3xGDlSgGVGK9M5o8DoJC6lwspXFwulesuEZqAjxfHiqp/KdqiUBb84OKf
 PRaJClU/FUylG8XCTJ2U5UQFkW8xw5OBsqhGb2bwTkQ3NmmStGGTDmUgR6o/LHLt+awm3vWjb9i
 Nrs8BBJIN1jRyWjRONJXQJ34xn7Dpa1RKjynkLZTDCxpg2e43XLMcFAW0RBV05qm7qpyLB8SKP4
 VH1ZdSWi8OATEwg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

SPICE resources were never freed on shutdown. Add per-subsystem
cleanup (display, input, core) and call it from qemu_cleanup().

Move spice-module.c into libui so the qemu_spice ops table links
with the rest of the UI code. Add an LSan suppression for a known
spice-server leak.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-spice-module.h |  1 +
 include/ui/qemu-spice.h        |  2 ++
 system/runstate.c              |  4 ++++
 ui/spice-core.c                | 25 ++++++++++++++++++--
 ui/spice-display.c             | 52 ++++++++++++++++++++++++++++++++++++++++++
 ui/spice-input.c               | 52 ++++++++++++++++++++++++++++--------------
 ui/spice-module.c              |  5 ++++
 scripts/lsan_suppressions.txt  |  5 ++++
 ui/meson.build                 |  4 ++--
 9 files changed, 129 insertions(+), 21 deletions(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index 072efa0c834..bb0f8437c26 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -26,6 +26,7 @@ typedef struct SpiceInfo SpiceInfo;
 
 struct QemuSpiceOps {
     void (*init)(void);
+    void (*cleanup)(void);
     void (*display_init)(void);
     int (*migrate_info)(const char *h, int p, int t, const char *s);
     int (*set_passwd)(const char *passwd,
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 59a68cd9833..2cdf10f0313 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -27,7 +27,9 @@
 #include "qemu/config-file.h"
 
 void qemu_spice_input_init(void);
+void qemu_spice_input_cleanup(void);
 void qemu_spice_display_init(void);
+void qemu_spice_display_cleanup(void);
 void qemu_spice_display_init_done(void);
 bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
diff --git a/system/runstate.c b/system/runstate.c
index 0e1cb3b4e67..d35fa270bd6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -62,6 +62,7 @@
 #include "system/system.h"
 #include "system/tpm.h"
 #include "ui/console.h"
+#include "ui/qemu-spice-module.h"
 
 #include "trace.h"
 
@@ -1048,6 +1049,9 @@ void qemu_cleanup(int status)
     user_creatable_cleanup();
 #ifdef CONFIG_VNC
     vnc_cleanup();
+#endif
+#ifdef CONFIG_SPICE
+    qemu_spice.cleanup();
 #endif
     /* TODO: unref root container, check all devices are ok */
 }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ef1c00134fa..1d2315f0b63 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -651,12 +651,15 @@ static void vm_change_state_handler(void *opaque, bool running,
     }
 }
 
+static VMChangeStateEntry *vm_change_entry;
+
 void qemu_spice_display_init_done(void)
 {
     if (runstate_is_running()) {
         qemu_spice_display_start();
     }
-    qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
+    vm_change_entry =
+        qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
 }
 
 static void qemu_spice_init(void)
@@ -894,7 +897,8 @@ static int qemu_spice_add_interface(SpiceBaseInstance *sin)
         spice_server = spice_server_new();
         spice_server_set_sasl_appname(spice_server, "qemu");
         spice_server_init(spice_server, &core_interface);
-        qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
+        vm_change_entry =
+            qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
     }
 
     return spice_server_add_interface(spice_server, sin);
@@ -1005,8 +1009,25 @@ int qemu_spice_display_is_running(SimpleSpiceDisplay *ssd)
     return spice_display_is_running;
 }
 
+static void qemu_spice_cleanup(void)
+{
+    if (!spice_server) {
+        return;
+    }
+
+    qemu_spice_display_cleanup();
+    qemu_spice_input_cleanup();
+    migration_remove_notifier(&migration_state);
+    g_clear_pointer(&spice_consoles, g_slist_free);
+    g_clear_pointer(&auth_passwd, g_free);
+    g_clear_pointer(&spice_server, spice_server_destroy);
+    g_clear_pointer(&vm_change_entry, qemu_del_vm_change_state_handler);
+    using_spice = 0;
+}
+
 static struct QemuSpiceOps real_spice_ops = {
     .init         = qemu_spice_init,
+    .cleanup      = qemu_spice_cleanup,
     .display_init = qemu_spice_display_init,
     .migrate_info = qemu_spice_migrate_info,
     .set_passwd   = qemu_spice_set_passwd,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index e3716127203..75c7df7bb5e 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -34,6 +34,8 @@ bool spice_opengl;
 bool spice_remote_client;
 int spice_max_refresh_rate;
 
+static GPtrArray *spice_displays;
+
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
     return r->top == r->bottom || r->left == r->right;
@@ -1421,6 +1423,54 @@ static void qemu_spice_display_init_one(QemuConsole *con)
         qemu_console_set_display_gl_ctx(con, &ssd->dgc);
     }
     qemu_console_register_listener(con, &ssd->dcl, ops);
+    g_ptr_array_add(spice_displays, ssd);
+}
+
+void qemu_spice_display_cleanup(void)
+{
+    if (!spice_displays) {
+        return;
+    }
+
+    for (guint i = 0; i < spice_displays->len; i++) {
+        SimpleSpiceDisplay *ssd = g_ptr_array_index(spice_displays, i);
+        SimpleSpiceUpdate *update;
+
+        qemu_console_unregister_listener(&ssd->dcl);
+#ifdef HAVE_SPICE_GL
+        if (spice_opengl) {
+            qemu_console_set_display_gl_ctx(ssd->dcl.con, NULL);
+        }
+#endif
+
+        if (ssd->ds) {
+            qemu_spice_destroy_host_primary(ssd);
+        }
+        qemu_spice_del_memslot(ssd, MEMSLOT_GROUP_HOST, 0);
+        spice_server_remove_interface(&ssd->qxl.base);
+
+        while ((update = QTAILQ_FIRST(&ssd->updates)) != NULL) {
+            QTAILQ_REMOVE(&ssd->updates, update, next);
+            qemu_spice_destroy_update(ssd, update);
+        }
+        g_clear_pointer(&ssd->ptr_define, g_free);
+        g_clear_pointer(&ssd->ptr_move, g_free);
+        g_clear_pointer(&ssd->cursor, cursor_unref);
+        g_clear_pointer(&ssd->surface, pixman_image_unref);
+        g_clear_pointer(&ssd->mirror, pixman_image_unref);
+        g_clear_pointer(&ssd->buf, g_free);
+#ifdef HAVE_SPICE_GL
+        g_clear_pointer(&ssd->gl_unblock_bh, qemu_bh_delete);
+        g_clear_pointer(&ssd->gl_unblock_timer, timer_free);
+        g_clear_pointer(&ssd->gls, qemu_gl_fini_shader);
+        egl_fb_destroy(&ssd->guest_fb);
+        egl_fb_destroy(&ssd->blit_fb);
+        egl_fb_destroy(&ssd->cursor_fb);
+#endif
+        qemu_mutex_destroy(&ssd->lock);
+        g_free(ssd);
+    }
+    g_clear_pointer(&spice_displays, g_ptr_array_unref);
 }
 
 void qemu_spice_display_init(void)
@@ -1431,6 +1481,8 @@ void qemu_spice_display_init(void)
     const char *str;
     int i;
 
+    spice_displays = g_ptr_array_new();
+
     str = qemu_opt_get(opts, "display");
     if (str) {
         int head = qemu_opt_get_number(opts, "head", 0);
diff --git a/ui/spice-input.c b/ui/spice-input.c
index f0bb915fd77..c975c1e2516 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -239,23 +239,41 @@ static void mouse_mode_notifier(Notifier *notifier, void *data)
     pointer->absolute = is_absolute;
 }
 
+static QemuSpiceKbd *spice_kbd;
+static QemuSpicePointer *spice_pointer;
+static QEMUPutLEDEntry *spice_led;
+
 void qemu_spice_input_init(void)
 {
-    QemuSpiceKbd *kbd;
-    QemuSpicePointer *pointer;
-
-    kbd = g_malloc0(sizeof(*kbd));
-    kbd->sin.base.sif = &kbd_interface.base;
-    qemu_spice.add_interface(&kbd->sin.base);
-    qemu_add_led_event_handler(kbd_leds, kbd);
-
-    pointer = g_malloc0(sizeof(*pointer));
-    pointer->mouse.base.sif  = &mouse_interface.base;
-    pointer->tablet.base.sif = &tablet_interface.base;
-    qemu_spice.add_interface(&pointer->mouse.base);
-
-    pointer->absolute = false;
-    pointer->mouse_mode.notify = mouse_mode_notifier;
-    qemu_add_mouse_mode_change_notifier(&pointer->mouse_mode);
-    mouse_mode_notifier(&pointer->mouse_mode, NULL);
+    spice_kbd = g_new0(QemuSpiceKbd, 1);
+    spice_kbd->sin.base.sif = &kbd_interface.base;
+    qemu_spice.add_interface(&spice_kbd->sin.base);
+    spice_led = qemu_add_led_event_handler(kbd_leds, spice_kbd);
+
+    spice_pointer = g_new0(QemuSpicePointer, 1);
+    spice_pointer->mouse.base.sif  = &mouse_interface.base;
+    spice_pointer->tablet.base.sif = &tablet_interface.base;
+    qemu_spice.add_interface(&spice_pointer->mouse.base);
+
+    spice_pointer->absolute = false;
+    spice_pointer->mouse_mode.notify = mouse_mode_notifier;
+    qemu_add_mouse_mode_change_notifier(&spice_pointer->mouse_mode);
+    mouse_mode_notifier(&spice_pointer->mouse_mode, NULL);
+}
+
+void qemu_spice_input_cleanup(void)
+{
+    g_clear_pointer(&spice_led, qemu_remove_led_event_handler);
+    if (spice_pointer) {
+        qemu_remove_mouse_mode_change_notifier(&spice_pointer->mouse_mode);
+        if (spice_pointer->absolute) {
+            spice_server_remove_interface(&spice_pointer->tablet.base);
+        }
+        spice_server_remove_interface(&spice_pointer->mouse.base);
+        g_clear_pointer(&spice_pointer, g_free);
+    }
+    if (spice_kbd) {
+        spice_server_remove_interface(&spice_kbd->sin.base);
+        g_clear_pointer(&spice_kbd, g_free);
+    }
 }
diff --git a/ui/spice-module.c b/ui/spice-module.c
index 7651c85885f..1961060d128 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -62,6 +62,10 @@ static int qemu_spice_display_add_client_stub(int csock, int skipauth,
     return -1;
 }
 
+static void qemu_spice_cleanup_stub(void)
+{
+}
+
 struct QemuSpiceOps qemu_spice = {
     .init         = qemu_spice_init_stub,
     .display_init = qemu_spice_display_init_stub,
@@ -69,6 +73,7 @@ struct QemuSpiceOps qemu_spice = {
     .set_passwd   = qemu_spice_set_passwd_stub,
     .set_pw_expire = qemu_spice_set_pw_expire_stub,
     .display_add_client = qemu_spice_display_add_client_stub,
+    .cleanup = qemu_spice_cleanup_stub,
 };
 
 #ifdef CONFIG_SPICE
diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index f3b827facff..2dd6581a650 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -20,3 +20,8 @@ leak:libfontconfig.so
 # https://github.com/GNOME/glib/blob/main/tools/glib.supp
 # This avoids false positive leak reports for the qga-ssh-test.
 leak:g_set_user_dirs
+
+# spice_server_add_interface allocates internal channel data that
+# spice_server_destroy does not free
+# https://gitlab.freedesktop.org/spice/spice/-/merge_requests/246
+leak:spice_server_add_interface
diff --git a/ui/meson.build b/ui/meson.build
index bb01f0728e2..ca903581abd 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -42,13 +42,14 @@ libui_sources = files(
     'kbd-state.c',
     'keymaps.c',
     'qemu-pixman.c',
+    'spice-module.c',
     'vgafont.c',
   )
 if pixman.found()
   libui_sources += files('cp437.c', 'vt100.c')
 endif
 libui = static_library('qemuui', libui_sources + genh,
-  dependencies: [pixman],
+  dependencies: [pixman, spice_headers],
   build_by_default: false)
 ui = declare_dependency(objects: libui.extract_all_objects(recursive: false), dependencies: [pixman])
 system_ss.add(png)
@@ -65,7 +66,6 @@ system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('con
 if dbus_display
   system_ss.add(files('dbus-module.c'))
 endif
-system_ss.add([spice_headers, files('spice-module.c')])
 system_ss.add(when: spice_protocol, if_true: files('vdagent.c'))
 
 if host_os == 'linux'

-- 
2.54.0


