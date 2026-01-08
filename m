Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E86D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtSE-000811-7I; Thu, 08 Jan 2026 12:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtS2-0007ZP-Ho
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtS0-0007MX-K9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hs7w5e8PYkWEToas8zAGloctBGVW9BJyZ/k9qigqvuY=;
 b=jKa8ppb4HNK4t2pNpM19uFFyxSHcEsebgwRB/CJMA7nuxci07zJXR1ljkuSezjAV6eTYxn
 XxifYrxMj/rdZXXyYNOQJpsQB4jJVyyy4eVlf8zKDhqac0VILBiw25XAncMqjFwZ5qq+YJ
 6/zVW86zJRz6biwTeOxbMlVkJBHbh7o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-XMtLEhKDOjOfc2P8lVtwiw-1; Thu,
 08 Jan 2026 12:05:25 -0500
X-MC-Unique: XMtLEhKDOjOfc2P8lVtwiw-1
X-Mimecast-MFC-AGG-ID: XMtLEhKDOjOfc2P8lVtwiw_1767891922
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB6C21956050; Thu,  8 Jan 2026 17:05:22 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB24E19560A2; Thu,  8 Jan 2026 17:05:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 22/24] util: add support for formatting a program name in
 messages
Date: Thu,  8 Jan 2026 17:03:36 +0000
Message-ID: <20260108170338.2693853-23-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The error_report function can include the program name in any
messages it prints. The qemu_log function has no equivalent
behaviour.

This introduces support for a "program name" in the new
messages API, which will be included by default for all
binaries.

This change tweaks the output of the error_report function,
adding a space between the program name and the location
info. The qemu_log function will gain the program name. This
can be easily seen with the 'log' trace backend, and how it
is now more closely matching error_report output.

Before:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
  qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5584e13937f0 dir=fish
  qcrypto_tls_creds_get_path TLS creds path creds=0x5584e13937f0 filename=ca-cert.pem path=<none>
  qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

After:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
  qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5584e13937f0 dir=fish
  qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=0x5584e13937f0 filename=ca-cert.pem path=<none>
  qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

When adding this the '-msg program-name=on|off' option is
introduced, so that the program name (which is enabled by
default) can be supressed if desired. This could be useful
if '-msg guest-name=on' is being used as a more informative
identifier.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/message.h         |  1 +
 qemu-options.hx                |  9 +++++++--
 system/vl.c                    | 11 ++++++++++-
 tests/unit/test-error-report.c |  5 +++--
 util/error-report.c            |  4 ----
 util/message.c                 | 10 +++++++++-
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/qemu/message.h b/include/qemu/message.h
index cfc3c92648..b8518d06be 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -6,6 +6,7 @@
 enum QMessageFormatFlags {
     QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
     QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
+    QMESSAGE_FORMAT_PROGRAM_NAME = (1 << 2),
 };
 
 /**
diff --git a/qemu-options.hx b/qemu-options.hx
index e8057fdcc9..e58b55d1f7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5515,13 +5515,15 @@ ERST
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg [timestamp=on|off][,guest-name=on|off]\n"
+    "     [,program-name=on|off]\n"
     "                control error message format\n"
     "                timestamp=on enables timestamps (default: off)\n"
     "                guest-name=on enables guest name prefix but only if\n"
-    "                              -name guest option is set (default: off)\n",
+    "                              -name guest option is set (default: off)\n"
+    "                program-name=off disables program name prefix (default: on)\n",
     QEMU_ARCH_ALL)
 SRST
-``-msg [timestamp=on|off][,guest-name=on|off]``
+``-msg [timestamp=on|off][,guest-name=on|off][,program-name=on|off]``
     Control error message format.
 
     ``timestamp=on|off``
@@ -5530,6 +5532,9 @@ SRST
     ``guest-name=on|off``
         Prefix messages with guest name but only if -name guest option is set
         otherwise the option is ignored. Default is off.
+
+    ``program-name=on|off``
+        Prefix messages with the program name. Default is on.
 ERST
 
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
diff --git a/system/vl.c b/system/vl.c
index 5f3b5436a6..503b0dcc24 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -381,6 +381,12 @@ static QemuOptsList qemu_msg_opts = {
             .help = "Prepends guest name for error messages but only if "
                     "-name guest is set otherwise option is ignored\n",
         },
+        {
+            .name = "program-name",
+            .type = QEMU_OPT_BOOL,
+            .help = "Prepends program name for error messages (enabled "
+                    "by default)\n",
+        },
         { /* end of list */ }
     },
 };
@@ -819,13 +825,16 @@ static void realtime_init(void)
 
 static void configure_msg(QemuOpts *opts)
 {
-    int flags = 0;
+    int flags = QMESSAGE_FORMAT_PROGRAM_NAME;
     if (qemu_opt_get_bool(opts, "timestamp", false)) {
         flags |= QMESSAGE_FORMAT_TIMESTAMP;
     }
     if (qemu_opt_get_bool(opts, "guest-name", false)) {
         flags |= QMESSAGE_FORMAT_WORKLOAD_NAME;
     }
+    if (!qemu_opt_get_bool(opts, "program-name", true)) {
+        flags &= ~QMESSAGE_FORMAT_PROGRAM_NAME;
+    }
     qmessage_set_format(flags);
 }
 
diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
index 9c63019694..714eafc51e 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -47,7 +47,7 @@ test_error_report_loc(void)
     g_test_trap_subprocess(NULL, 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("\
-test-error-report:some-file.c:7717: test error1*\
+test-error-report: some-file.c:7717: test error1*\
 test-error-report: test error2*\
 ");
 }
@@ -90,7 +90,8 @@ static void
 test_error_report_timestamp(void)
 {
     if (g_test_subprocess()) {
-        qmessage_set_format(QMESSAGE_FORMAT_TIMESTAMP);
+        qmessage_set_format(QMESSAGE_FORMAT_TIMESTAMP |
+                            QMESSAGE_FORMAT_PROGRAM_NAME);
         warn_report("warn");
         error_report("err");
         return;
diff --git a/util/error-report.c b/util/error-report.c
index 313c2d6055..4c82d10a36 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -176,10 +176,6 @@ static void print_loc(Monitor *cur)
     int i;
     const char *const *argp;
 
-    if (!cur && g_get_prgname()) {
-        fprintf(stderr, "%s:", g_get_prgname());
-        sep = " ";
-    }
     switch (cur_loc->kind) {
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
diff --git a/util/message.c b/util/message.c
index fb2c947153..dd01bf7462 100644
--- a/util/message.c
+++ b/util/message.c
@@ -5,7 +5,7 @@
 #include "qemu/message.h"
 #include "monitor/monitor.h"
 
-static int message_format;
+static int message_format = QMESSAGE_FORMAT_PROGRAM_NAME;
 static char *message_workloadname;
 
 void qmessage_set_format(int flags)
@@ -32,4 +32,12 @@ void qmessage_context_print(FILE *fp)
         fputs(message_workloadname, fp);
         fputc(' ', fp);
     }
+
+    if (message_format & QMESSAGE_FORMAT_PROGRAM_NAME) {
+        const char *pgnamestr = g_get_prgname();
+        if (pgnamestr) {
+            fputs(pgnamestr, fp);
+            fputs(": ", fp);
+        }
+    }
 }
-- 
2.52.0


