Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B5ACED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySEx-00032A-8H; Wed, 09 Oct 2024 04:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sySEn-0002v4-Ol
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sySEl-0001LW-QE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728463202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwaHK/7FZjHwmu40oHbMCV+EFf1UdvIeS3hnoy1lHNU=;
 b=arMj7FX0hgzCTsi5WxwXg8sMjXk0NBPlIp6ju57Oo9APKg8dH/QP08qY0+Ne4pm4Au5deG
 chzJz2GmHqomyEKTgm0Ily7VhTszpvM+Jbi9Itjr7i3ojeAfNWv0mX+QUuYXpdRWQlgepI
 tlFRQili6n3kz3nzenOV9/uJH0ntyO4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-9QgfFwaVMnSlDCgAP8NMHQ-1; Wed,
 09 Oct 2024 04:39:58 -0400
X-MC-Unique: 9QgfFwaVMnSlDCgAP8NMHQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B8601985119; Wed,  9 Oct 2024 08:39:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA324300018D; Wed,  9 Oct 2024 08:39:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Octavian Purdila <tavip@google.com>, Paulo Neves <ptsneves@gmail.com>
Subject: [PULL 2/2] chardev: add path option for pty backend
Date: Wed,  9 Oct 2024 12:39:38 +0400
Message-ID: <20241009083938.1504695-3-marcandre.lureau@redhat.com>
In-Reply-To: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
References: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Octavian Purdila <tavip@google.com>

Add path option to the pty char backend which will create a symbolic
link to the given path that points to the allocated PTY.

This avoids having to make QMP or HMP monitor queries to find out what
the new PTY device path is.

Based on patch from Paulo Neves:

https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/

Tested with the following invocations that the link is created and
removed when qemu stops:

  qemu-system-x86_64 -nodefaults -mon chardev=compat_monitor \
  -chardev pty,path=test,id=compat_monitor0

  qemu-system-x86_64 -nodefaults -monitor pty:test

  # check QMP invocation with path set
  qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=on,wait=off
  nc localhost 4444
  > {"execute": "qmp_capabilities"}
  > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
      "type": "pty", "data": {"path": "test" }}}}

  # check QMP invocation with path not set
  qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=on,wait=off
  nc localhost 4444
  > {"execute": "qmp_capabilities"}
  > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
      "type": "pty", "data": {}}}}

Also tested that when a link path is not passed invocations still work, e.g.:

  qemu-system-x86_64 -monitor pty

Co-authored-by: Paulo Neves <ptsneves@gmail.com>
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
[OP: rebase and address original patch review comments]
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240806010735.2450555-1-tavip@google.com>
---
 qapi/char.json     | 27 ++++++++++++++++++++++++++-
 chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
 chardev/char.c     |  5 +++++
 qemu-options.hx    | 33 +++++++++++++++++++++++++++------
 4 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 42eda4f98b..e045354350 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -444,6 +444,20 @@
   'base': 'ChardevCommon',
   'if': 'CONFIG_SPICE_PROTOCOL' }
 
+##
+# @ChardevPty:
+#
+# Configuration info for pty implementation.
+#
+# @path: optional path to create a symbolic link that points to the
+#     allocated PTY
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevPty',
+  'data': { '*path': 'str' },
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevBackendKind:
 #
@@ -655,6 +669,17 @@
 { 'struct': 'ChardevRingbufWrapper',
   'data': { 'data': 'ChardevRingbuf' } }
 
+
+##
+# @ChardevPtyWrapper:
+#
+# @data: Configuration info for pty chardevs
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevPtyWrapper',
+  'data': { 'data': 'ChardevPty' } }
+
 ##
 # @ChardevBackend:
 #
@@ -675,7 +700,7 @@
             'pipe': 'ChardevHostdevWrapper',
             'socket': 'ChardevSocketWrapper',
             'udp': 'ChardevUdpWrapper',
-            'pty': 'ChardevCommonWrapper',
+            'pty': 'ChardevPtyWrapper',
             'null': 'ChardevCommonWrapper',
             'mux': 'ChardevMuxWrapper',
             'msmouse': 'ChardevCommonWrapper',
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cc2f7617fe..cbb21b76ae 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/qemu-print.h"
 
 #include "chardev/char-io.h"
@@ -41,6 +42,7 @@ struct PtyChardev {
 
     int connected;
     GSource *timer_src;
+    char *path;
 };
 typedef struct PtyChardev PtyChardev;
 
@@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
     Chardev *chr = CHARDEV(obj);
     PtyChardev *s = PTY_CHARDEV(obj);
 
+    /* unlink symlink */
+    if (s->path) {
+        unlink(s->path);
+        g_free(s->path);
+    }
+
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
@@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
     int master_fd, slave_fd;
     char pty_name[PATH_MAX];
     char *name;
+    char *path = backend->u.pty.data->path;
 
     master_fd = qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
@@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
     g_free(name);
     s->timer_src = NULL;
     *be_opened = false;
+
+    /* create symbolic link */
+    if (path) {
+        int res = symlink(pty_name, path);
+
+        if (res != 0) {
+            error_setg_errno(errp, errno, "Failed to create PTY symlink");
+        } else {
+            s->path = g_strdup(path);
+        }
+    }
+}
+
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
+                           Error **errp)
+{
+    const char *path = qemu_opt_get(opts, "path");
+    ChardevPty *pty;
+
+    backend->type = CHARDEV_BACKEND_KIND_PTY;
+    pty = backend->u.pty.data = g_new0(ChardevPty, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevPty_base(pty));
+    pty->path = g_strdup(path);
 }
 
 static void char_pty_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
+    cc->parse = char_pty_parse;
     cc->open = char_pty_open;
     cc->chr_write = char_pty_chr_write;
     cc->chr_update_read_handler = pty_chr_update_read_handler;
diff --git a/chardev/char.c b/chardev/char.c
index 35623c78a3..c0cc52824b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
         qemu_opt_set(opts, "path", p, &error_abort);
         return opts;
     }
+    if (strstart(filename, "pty:", &p)) {
+        qemu_opt_set(opts, "backend", "pty", &error_abort);
+        qemu_opt_set(opts, "path", p, &error_abort);
+        return opts;
+    }
     if (strstart(filename, "tcp:", &p) ||
         strstart(filename, "telnet:", &p) ||
         strstart(filename, "tn3270:", &p) ||
diff --git a/qemu-options.hx b/qemu-options.hx
index 20a1ce0d43..d5afefe5b6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3712,7 +3712,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
 #else
-    "-chardev pty,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #ifdef CONFIG_BRLAPI
@@ -3951,12 +3951,22 @@ The available backends are:
 
     ``path`` specifies the name of the serial device to open.
 
-``-chardev pty,id=id``
-    Create a new pseudo-terminal on the host and connect to it. ``pty``
-    does not take any options.
+``-chardev pty,id=id[,path=path]``
+    Create a new pseudo-terminal on the host and connect to it.
 
     ``pty`` is not available on Windows hosts.
 
+    If ``path`` is specified, QEMU will create a symbolic link at
+    that location which points to the new PTY device.
+
+    This avoids having to make QMP or HMP monitor queries to find out
+    what the new PTY device path is.
+
+    Note that while QEMU will remove the symlink when it exits
+    gracefully, it will not do so in case of crashes or on certain
+    startup errors. It is recommended that the user checks and removes
+    the symlink after QEMU terminates to account for this.
+
 ``-chardev stdio,id=id[,signal=on|off]``
     Connect to standard input and standard output of the QEMU process.
 
@@ -4314,8 +4324,19 @@ SRST
 
             vc:80Cx24C
 
-    ``pty``
-        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
+    ``pty[:path]``
+        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
+
+        If ``path`` is specified, QEMU will create a symbolic link at
+        that location which points to the new PTY device.
+
+        This avoids having to make QMP or HMP monitor queries to find
+        out what the new PTY device path is.
+
+        Note that while QEMU will remove the symlink when it exits
+        gracefully, it will not do so in case of crashes or on certain
+        startup errors. It is recommended that the user checks and
+        removes the symlink after QEMU terminates to account for this.
 
     ``none``
         No device is allocated. Note that for machine types which
-- 
2.47.0


