Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD9CD37B2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcFj-0005oR-QW; Sat, 09 May 2026 03:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFi-0005dy-43
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFg-000772-5v
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54iThH2Cm0QinJj4SluTXmSoZWdMrvyznhXb0YHV5TA=;
 b=UBrf/Q1sTY7+Nmv+PJZBKwSTi+Vm4sWESQQt/z/sFgH2zZvZVbW2ZqjR/ZGUi6qPHoO6cL
 y/kqSMi+d3hvfnRCe8799qvB4TtsJByZJRbRaJZ1cpEg9DYbYW7slqjffMCLz51PZWbuDI
 GhEwyYa5EdEJZJsiK0vCHN+xZ+QTKEU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167--O5VmqnYNVCzqSBRNIuP8w-1; Sat,
 09 May 2026 03:37:29 -0400
X-MC-Unique: -O5VmqnYNVCzqSBRNIuP8w-1
X-Mimecast-MFC-AGG-ID: -O5VmqnYNVCzqSBRNIuP8w_1778312248
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57C16195608C; Sat,  9 May 2026 07:37:28 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B24F3002D30; Sat,  9 May 2026 07:37:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/32] ui/console: default vc encoding to cp437 for machine <
 11.1
Date: Sat,  9 May 2026 11:35:57 +0400
Message-ID: <20260509073621.1011778-12-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a QOM "encoding" enum property to some chardev-vc backends
(console-vc & dbus - gtk and spice don't make use of it) so that the
machine compat mechanism can override the default. For machine versions
prior to 11.1, the charset defaults to cp437 (raw 8-bit VGA) instead of
utf8, preserving the historical behaviour.

The following commits are going to wire this to VT100 emulation code and
an extra exported D-Bus property.

Note that GTK libvte uses utf8 unconditionally, and Spice doesn't have a
way to set the encoding, and typically just use libvte in client too.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char.h | 19 +++++++++++++++++++
 hw/core/machine.c      |  4 +++-
 ui/console-vc.c        | 18 ++++++++++++++++++
 ui/dbus.c              | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index f05e8dba0a9..7377d8e60a0 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -332,4 +332,23 @@ void resume_mux_open(void);
 char *qemu_chr_get_pty_name(Chardev *chr);
 char *qemu_chr_get_filename(Chardev *chr);
 
+#define CHARDEV_VC_ENCODING_PROPERTY_DEFINE(cast_func)          \
+static int get_encoding(Object *obj, Error **errp)              \
+{                                                               \
+    return cast_func(obj)->encoding;                            \
+}                                                               \
+                                                                \
+static void set_encoding(Object *obj, int value, Error **errp)  \
+{                                                               \
+    cast_func(obj)->encoding = value;                           \
+}
+
+static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
+    int (*get)(Object *, Error **),
+    void (*set)(Object *, int, Error **))
+{
+    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
+                                   &ChardevVCEncoding_lookup, get, set);
+}
+
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b661fd36ae..63baff859f3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,7 +39,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_11_0[] = {};
+GlobalProperty hw_compat_11_0[] = {
+    { "chardev-vc", "encoding", "cp437" },
+};
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
 GlobalProperty hw_compat_10_2[] = {
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 7bb6a483753..fd7e6fb7b06 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -9,6 +9,7 @@
 #include "qemu/fifo8.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
+#include "qom/compat-properties.h"
 #include "ui/console.h"
 #include "ui/vgafont.h"
 
@@ -109,6 +110,7 @@ struct VCChardev {
     TextAttributes t_attrib; /* currently active text attributes */
     TextAttributes t_attrib_saved;
     int x_saved, y_saved;
+    ChardevVCEncoding encoding;
 };
 typedef struct VCChardev VCChardev;
 
@@ -1189,6 +1191,9 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     s->chr = chr;
     drv->console = s;
+    if (vc->has_encoding) {
+        drv->encoding = vc->encoding;
+    }
 
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
@@ -1253,6 +1258,8 @@ static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
     }
 }
 
+CHARDEV_VC_ENCODING_PROPERTY_DEFINE(VC_CHARDEV)
+
 static void char_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -1264,12 +1271,23 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     cc->chr_set_echo = vc_chr_set_echo;
     cc->supports_size_opts = true;
     cc->supports_encoding_opts = true;
+
+    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+}
+
+static void char_vc_init(Object *obj)
+{
+    VCChardev *vc = VC_CHARDEV(obj);
+
+    vc->encoding = CHARDEV_VC_ENCODING_UTF8;
 }
 
 static const TypeInfo char_vc_type_info = {
     .name = TYPE_CHARDEV_VC,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
+    .instance_init = char_vc_init,
+    .instance_post_init = object_apply_compat_props,
     .class_init = char_vc_class_init,
 };
 
diff --git a/ui/dbus.c b/ui/dbus.c
index 721cc71d39b..59b73e0aa94 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -28,6 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qom/object_interfaces.h"
+#include "qapi-types-char.h"
 #include "system/system.h"
 #include "ui/dbus-module.h"
 #ifdef CONFIG_OPENGL
@@ -455,12 +456,20 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
 
 #define TYPE_CHARDEV_VC "chardev-vc"
 
+typedef struct DBusVCChardev {
+    DBusChardev parent;
+
+    ChardevVCEncoding encoding;
+} DBusVCChardev;
+
 typedef struct DBusVCClass {
     DBusChardevClass parent_class;
 
     void (*parent_parse)(QemuOpts *opts, ChardevBackend *b, Error **errp);
 } DBusVCClass;
 
+DECLARE_INSTANCE_CHECKER(DBusVCChardev, DBUS_VC_CHARDEV,
+                         TYPE_CHARDEV_VC)
 DECLARE_CLASS_CHECKERS(DBusVCClass, DBUS_VC,
                        TYPE_CHARDEV_VC)
 
@@ -500,6 +509,23 @@ dbus_vc_parse(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
+CHARDEV_VC_ENCODING_PROPERTY_DEFINE(DBUS_VC_CHARDEV)
+
+static bool
+dbus_vc_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+{
+    DBusVCChardev *vc = DBUS_VC_CHARDEV(chr);
+    ChardevClass *parent =
+        CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_DBUS));
+    ChardevDBus *be = backend->u.dbus.data;
+
+    if (be->has_encoding) {
+        vc->encoding = be->encoding;
+    }
+
+    return parent->chr_open(chr, backend, errp);
+}
+
 static void
 dbus_vc_class_init(ObjectClass *oc, const void *data)
 {
@@ -508,12 +534,26 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
 
     klass->parent_parse = cc->chr_parse;
     cc->chr_parse = dbus_vc_parse;
+    cc->chr_open = dbus_vc_open;
     cc->supports_encoding_opts = true;
+
+    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+}
+
+static void
+dbus_vc_init(Object *obj)
+{
+    DBusVCChardev *vc = DBUS_VC_CHARDEV(obj);
+
+    vc->encoding = CHARDEV_VC_ENCODING_UTF8;
 }
 
 static const TypeInfo dbus_vc_type_info = {
     .name = TYPE_CHARDEV_VC,
     .parent = TYPE_CHARDEV_DBUS,
+    .instance_size = sizeof(DBusVCChardev),
+    .instance_init = dbus_vc_init,
+    .instance_post_init = object_apply_compat_props,
     .class_size = sizeof(DBusVCClass),
     .class_init = dbus_vc_class_init,
 };
-- 
2.54.0


