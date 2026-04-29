Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39817FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4P-0003WM-4N; Wed, 29 Apr 2026 17:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4M-0003Vd-Rq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4K-0003EY-RH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOr5ZL7bHRKd8fAlE/hxuW/GBXSIWog+NxkF9A50Knk=;
 b=UVy3Y1RaMun9rFKNOJtjJF3xVtkDJDPewdD/pkusjP1ju/RTGC2jU1o3bLQZ5X58MBX9vL
 3DseK6z8EskjZTG/52p43dbGtlQ3r6i+LoqHP2ywEjxNDpa96PaA87bJXeeoEarhfL2xL0
 lsKQ2rBYEpK8I5cGU0/UedA7kXyLyUU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-hqAMBod7PvOZbYgooL0sVA-1; Wed,
 29 Apr 2026 17:03:38 -0400
X-MC-Unique: hqAMBod7PvOZbYgooL0sVA-1
X-Mimecast-MFC-AGG-ID: hqAMBod7PvOZbYgooL0sVA_1777496617
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BDEB1800366
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:03:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE350300019F; Wed, 29 Apr 2026 21:03:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:37 +0400
Subject: [PATCH v3 04/26] ui/console: default vc encoding to cp437 for
 machine < 11.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-4-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6927;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QReFTyG+sKmftwnoD428OyLIJhjEp+YtsXRj2SNT6aw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILC+QFxP9v1wHNLcMQja/O3xPIpBQaBTdem
 EZpDR/J9pOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5UFuEACfiBbvgfObJ3KBPIt1rBrK39CxH/hyLv5FBojhBh/GXLSuI+y3ktRMqm0YBS26wVv6b+F
 cF6juhUNXgKK5h4GL8yES/kmpFOi8nO0mqp+23KaEQzdrcM6KEGKcw6kf0Pc8ZGF/ARN9EgJJBb
 DlAFq5Hbw8NC8hcOCGG5jN0oJ/WlL7Gmc2tsdFJoLAeZrbfO851UNgSg2EcwN3UGVDRrzvuFK6N
 PEgLNT1RYUaO68RtfE0Du7sxB4pdbl9/iD+1b+cJ1rFUG4ydDWc1zxLCLZnEyK8rAS5cpqmE3qJ
 v3YrR5d0+7pedPIfCN3Cf5JhpROFk0JyF/S+3ydFHISyGqSfQrnS9n51tOJxb+ti7EO+Xrn0jWZ
 x/+7GxPXI1D6kdJ6IUsqzSzsX62VlkZdAXTKzbKhkXb717irEuvFtrE6gOKhIN+6FUY+Ifn6aiw
 9PTxOkUSsAc5UzBEF1yFg6pDiz77nVK79q+gOV62Q54NUqKJAWKKCRJPj+HUwBTY38W6sFtJB9v
 QaJaje3vHUpqi6J50FdWfNLRtP3S/7OUUMosqWcb/pQxZA0hJobgS8EtvUUVdiuwvm/rVo8iyzH
 wqVdPbJodScds9lpklgUAN6PT3LV53EUtEC1eGns9RLfivpFtOrjfC7kx4+/d3aCVSAL54ByJAa
 DrhZ4O+JEVMOgGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add a QOM "encoding" enum property to some chardev-vc backends
(console-vc & dbus - gtk and spice don't make use of it) so that the
machine compat mechanism can override the default. For machine versions
prior to 11.1, the charset defaults to cp437 (raw 8-bit VGA) instead of
utf8, preserving the historical behaviour.

The following commits are going to wire this to VT100 emulation code and
an extra exported D-Bus property.

Note that GTK libvte uses utf8 unconditionally, and Spice doesn't have a
way to set the encoding, and typically just use libvte in client too.

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


