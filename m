Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E895CCD37B2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcFf-0005Nd-1t; Sat, 09 May 2026 03:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFd-0005N2-8o
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFa-00076C-J0
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFqFOdBPTXj3qPbkJjte8Lp4ALTwKucYG2bEikuwAdg=;
 b=i5M3K3vs9aTQge4ZmP8gDVbm5/Z3OER6hTtGbk/UBXv058jQR9D3ilZFIB3XIaQJVMu+dI
 brq4iJILWCNJg4RkFwfTvtfdbDWE6JNhryAqtgoCMlojfSwwT9GI5R8mEShNN/nBbC9JAn
 dMsmG32zLU1N216p+0EKL+QUZgVeCYk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-1DBTwwf3PdqjakUlt1FbSg-1; Sat,
 09 May 2026 03:37:23 -0400
X-MC-Unique: 1DBTwwf3PdqjakUlt1FbSg-1
X-Mimecast-MFC-AGG-ID: 1DBTwwf3PdqjakUlt1FbSg_1778312243
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A8BB195608A; Sat,  9 May 2026 07:37:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BA931944B22; Sat,  9 May 2026 07:37:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/32] ui/console: add vc encoding=utf8/cp437 option
Date: Sat,  9 May 2026 11:35:56 +0400
Message-ID: <20260509073621.1011778-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Expose a new "encoding" QemuOpt option.

Add the corresponding QAPI type and properties.

This is going to be wired in the following commits.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/char.json         | 30 ++++++++++++++++++++++++++++--
 include/chardev/char.h |  1 +
 chardev/char.c         | 10 ++++++++++
 ui/console-vc.c        | 12 ++++++++++++
 ui/dbus.c              | 13 +++++++++++++
 qemu-options.hx        |  7 +++++--
 6 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index a4abafa6803..aa5ee9ffcd0 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -377,6 +377,24 @@
   'base': 'ChardevCommon',
   'if': 'CONFIG_SPICE' }
 
+##
+# @ChardevVCEncoding:
+#
+# Character encoding expected from the guest on a virtual console.
+#
+# @cp437: CP437 (8-bit Extended ASCII / VGA).  Every byte maps
+#     directly to a glyph; suitable for DOS or other guests that
+#     output raw CP437.
+#
+# @utf8: UTF-8.  Multi-byte sequences are decoded and then mapped
+#     back to CP437 glyphs for display; unmappable codepoints are
+#     shown as '?'.  Suitable for modern Linux guests.
+#
+# Since: 11.1
+##
+{ 'enum': 'ChardevVCEncoding',
+  'data': [ 'cp437', 'utf8' ] }
+
 ##
 # @ChardevDBus:
 #
@@ -384,10 +402,14 @@
 #
 # @name: name of the channel (following docs/spice-port-fqdn.txt)
 #
+# @encoding: character encoding the guest is expected to use
+#     (since 11.1)
+#
 # Since: 7.0
 ##
 { 'struct': 'ChardevDBus',
-  'data': { 'name': 'str' },
+  'data': { 'name': 'str',
+            '*encoding': 'ChardevVCEncoding' },
   'base': 'ChardevCommon',
   'if': 'CONFIG_DBUS_DISPLAY' }
 
@@ -404,6 +426,9 @@
 #
 # @rows: console height, in chars
 #
+# @encoding: character encoding the guest is expected to use
+#     (since 11.1)
+#
 # .. note:: The options are only effective when the VNC or SDL
 #    graphical display backend is active.  They are ignored with the
 #    GTK, Spice, VNC and D-Bus display backends.
@@ -414,7 +439,8 @@
   'data': { '*width': 'int',
             '*height': 'int',
             '*cols': 'int',
-            '*rows': 'int' },
+            '*rows': 'int',
+            '*encoding': 'ChardevVCEncoding' },
   'base': 'ChardevCommon' }
 
 ##
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 51995f06a82..f05e8dba0a9 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -255,6 +255,7 @@ struct ChardevClass {
     bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
     bool supports_yank;
     bool supports_size_opts;
+    bool supports_encoding_opts;
 
     /* parse command line options and populate QAPI @backend */
     void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
diff --git a/chardev/char.c b/chardev/char.c
index 55dce9725e8..ca8b37ed8d7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -650,6 +650,13 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
             return NULL;
         }
     }
+    if (!cc->supports_encoding_opts) {
+        if (qemu_opt_get(opts, "encoding")) {
+            error_setg(errp, "chardev '%s' does not support encoding option",
+                       qemu_opts_id(opts));
+            return NULL;
+        }
+    }
 
     backend = g_new0(ChardevBackend, 1);
     backend->type = CHARDEV_BACKEND_KIND_NULL;
@@ -972,6 +979,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "rows",
             .type = QEMU_OPT_NUMBER,
+        },{
+            .name = "encoding",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "mux",
             .type = QEMU_OPT_BOOL,
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 62a5e3caf57..7bb6a483753 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1211,6 +1211,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     int val;
+    const char *str;
     ChardevVC *vc;
 
     backend->type = CHARDEV_BACKEND_KIND_VC;
@@ -1240,6 +1241,16 @@ static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
         vc->has_rows = true;
         vc->rows = val;
     }
+
+    str = qemu_opt_get(opts, "encoding");
+    if (str) {
+        int cs = qapi_enum_parse(&ChardevVCEncoding_lookup, str, -1, errp);
+        if (cs < 0) {
+            return;
+        }
+        vc->has_encoding = true;
+        vc->encoding = cs;
+    }
 }
 
 static void char_vc_class_init(ObjectClass *oc, const void *data)
@@ -1252,6 +1263,7 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     cc->chr_accept_input = vc_chr_accept_input;
     cc->chr_set_echo = vc_chr_set_echo;
     cc->supports_size_opts = true;
+    cc->supports_encoding_opts = true;
 }
 
 static const TypeInfo char_vc_type_info = {
diff --git a/ui/dbus.c b/ui/dbus.c
index 794b65c4ada..721cc71d39b 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -471,6 +471,8 @@ dbus_vc_parse(QemuOpts *opts, ChardevBackend *backend,
     DBusVCClass *klass = DBUS_VC_CLASS(object_class_by_name(TYPE_CHARDEV_VC));
     const char *name = qemu_opt_get(opts, "name");
     const char *id = qemu_opts_id(opts);
+    const char *str;
+    ChardevDBus *dbus;
 
     if (name == NULL) {
         if (g_str_has_prefix(id, "compat_monitor")) {
@@ -486,6 +488,16 @@ dbus_vc_parse(QemuOpts *opts, ChardevBackend *backend,
     }
 
     klass->parent_parse(opts, backend, errp);
+    dbus = backend->u.dbus.data;
+    str = qemu_opt_get(opts, "encoding");
+    if (str) {
+        int cs = qapi_enum_parse(&ChardevVCEncoding_lookup, str, -1, errp);
+        if (cs < 0) {
+            return;
+        }
+        dbus->has_encoding = true;
+        dbus->encoding = cs;
+    }
 }
 
 static void
@@ -496,6 +508,7 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
 
     klass->parent_parse = cc->chr_parse;
     cc->chr_parse = dbus_vc_parse;
+    cc->supports_encoding_opts = true;
 }
 
 static const TypeInfo dbus_vc_type_info = {
diff --git a/qemu-options.hx b/qemu-options.hx
index e7842b10c8c..5387bcd751b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4053,7 +4053,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "         [,logfile=PATH][,logappend=on|off]\n"
     "-chardev msmouse,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,encoding=ENCODING]\n"
     "-chardev ringbuf,id=id[,size=size][,logfile=PATH][,logappend=on|off]\n"
     "-chardev file,id=id,path=path[,input-path=input-file][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev pipe,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
@@ -4285,7 +4285,7 @@ The available backends are:
     Several frontend devices is not supported. Stacking of multiplexers
     and hub devices is not supported as well.
 
-``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]``
+``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]][,encoding=ENCODING]``
     Connect to a QEMU text console. The implementation and supported feature
     set depend on the selected display backend.
 
@@ -4304,6 +4304,9 @@ The available backends are:
     ``cols`` and ``rows`` specify that the console be sized to fit a
     text console with the given dimensions.
 
+    ``encoding`` specifies the character set expected from the guest:
+    ``utf8`` or ``cp437`` (8-bit Extended ASCII / VGA).
+
 ``-chardev ringbuf,id=id[,size=size]``
     Create a ring buffer with fixed size ``size``. size must be a power
     of two and defaults to ``64K``.
-- 
2.54.0


