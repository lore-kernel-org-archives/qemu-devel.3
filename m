Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FFCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWb-0002ME-E9; Thu, 15 Oct 2026 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWZ-0002JH-AV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWX-00045N-4W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzuyrR5dOghgw8SJJA0o5GFJw2MvFnUErv0Wo8Ig0rg=;
 b=D71vBQK9sQ5AI9UDC1fINYVpWPhpBcCCtc0Ke6C8JlV6tcRMZH5S6WK0Fg9yCUYC7TJnTg
 /ffVLOTuDSi1NBbwNwJpbjuq7T6dO9zxkScVJMSD8BY8yOPZNr1gjqobO2Nu/dCM5OkNbx
 7eaQEsATCul56fjvlBeT3dJIb3xEpgo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-R9DTo9RbMOqlyVb-r_PBuw-1; Thu,
 15 Oct 2026 11:21:23 +0000
X-MC-Unique: R9DTo9RbMOqlyVb-r_PBuw-1
X-Mimecast-MFC-AGG-ID: R9DTo9RbMOqlyVb-r_PBuw_1792063282
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97A618011D7; Thu, 15 Oct 2026 11:21:21 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80A101800257; Thu, 15 Oct 2026 11:21:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 08/21] qapi: add 'tldr-dump' command for on-demand data
 recorder output
Date: Thu, 15 Oct 2026 12:20:31 +0100
Message-ID: <20261015112044.1999748-9-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While the data recorder is designed to dump its contents in
response to various signals that result in a QEMU crash, it
is also interesting to explicitly request dump.

This could be simply as an adhoc debugging activity, or could
be in response to a specific event like a guest OS panic
notification.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS           |  1 +
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 qapi/tldr.json        | 28 ++++++++++++++++++++++++++++
 qemu-options.hx       |  2 ++
 util/tldr.c           | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 65 insertions(+)
 create mode 100644 qapi/tldr.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fa68810c1e..54265d987cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4780,3 +4780,4 @@ F: util/tldr.c
 F: util/tldr-internal.h
 F: include/qemu/tldr.h
 F: tests/unit/test-util-tldr.c
+F: qapi/tldr.json
diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0c..f8aecb61284 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -49,6 +49,7 @@ qapi_all_modules = [
   'run-state',
   'sockets',
   'stats',
+  'tldr',
   'trace',
   'transaction',
   'vfio',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b93dd68d94c..b36777970d1 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -76,3 +76,4 @@
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
 { 'include': 'uefi.json' }
+{ 'include': 'tldr.json' }
diff --git a/qapi/tldr.json b/qapi/tldr.json
new file mode 100644
index 00000000000..8e2b7cda324
--- /dev/null
+++ b/qapi/tldr.json
@@ -0,0 +1,28 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# @QTLDRDumpOptions:
+#     Options for `tldr-dump`.
+#
+# @target: the fully qualified file path to dump
+#     the data recorder to
+#
+# Since: 11.2.0
+##
+{ 'struct': 'QTLDRDumpOptions',
+  'data': { 'target': 'str' } }
+
+##
+# @tldr-dump:
+#     Dump the data recorder to a file
+#
+# Since: 11.2.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "tldr-dump", "arguments": { "target": "/tmp/qemu.txt" } }
+#     <- { "return": {} }
+##
+{ 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f63d86b635..5f96257cef0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6692,6 +6692,8 @@ SRST
         recorder will be dumped to the stderr stream. If the
         ``crash-target`` parameter was given, that specifies a fully
         qualified file path to write the dump to instead of stderr.
+        The ``tldr-dump`` QMP command can also be used at any time to
+        save the captured data to an arbitrary file.
 
         The ``tldr-config`` object can be added at initial startup
         or via QMP at runtime. Once created, however, it is not
diff --git a/util/tldr.c b/util/tldr.c
index 13e9881bc9b..ea7c26b8e9b 100644
--- a/util/tldr.c
+++ b/util/tldr.c
@@ -12,6 +12,7 @@
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-tldr.h"
 
 struct QTLDRConfig {
     Object parent;
@@ -436,3 +437,34 @@ qtldr_crash_dump_signal(siginfo_t *si)
         close(fd);
     }
 }
+
+
+/*
+ * WARNING: Code below this marker provides a QMP handler
+ * WARNING: for use in normal execution. It calls into
+ * WARNING: the common crash report outputting APIs, but
+ * WARNING: this specific method is not restricted to async
+ * WARNING: signal safe POSIX functions.
+ */
+
+
+void
+qmp_tldr_dump(const char *target, Error **errp)
+{
+    int fd;
+
+    if (!qatomic_read(&qtldr_active)) {
+        error_setg(errp, "No 'tldr-config' object has been creted");
+        return;
+    }
+
+    fd = qemu_create(target, O_WRONLY | O_TRUNC, 0600, errp);
+    if (fd < 0) {
+        return;
+    }
+
+    qtldr_crash_dump_internal(fd, NULL);
+
+    qemu_fdatasync(fd);
+    close(fd);
+}
-- 
2.56.0


