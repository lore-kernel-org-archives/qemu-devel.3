Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2243CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNaa-0002sr-1b; Sat, 30 Aug 2025 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3TM-0005eV-2f
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3TJ-0005wF-SL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptpQoMHLmEj+E1Yc+lwarnrkVCsuSzh+kwgjJksTpG4=;
 b=MBm/a53oN8uhNY3FDMnwgqjfIPW9U6dFRC6x/Qh261xxp54TsmDwhBxHfC8+wO/rZFbq8+
 yhoHlBJ9Mk5/uZo/1MA5zj9I8pCASUOXGOqaIJXKn++I3M7W/uehpv7eebvfgP1J/E1JVy
 UruJMfyKsozNpKivvHV0Nl7GY9iIks4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-9wpQNefVOXi_02z_mgv9kQ-1; Fri,
 29 Aug 2025 14:05:05 -0400
X-MC-Unique: 9wpQNefVOXi_02z_mgv9kQ-1
X-Mimecast-MFC-AGG-ID: 9wpQNefVOXi_02z_mgv9kQ_1756490704
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1CA21800451; Fri, 29 Aug 2025 18:05:03 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 546D019560B4; Fri, 29 Aug 2025 18:04:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/14] util: add support for formatting a program name in
 messages
Date: Fri, 29 Aug 2025 19:03:52 +0100
Message-ID: <20250829180354.2922145-13-berrange@redhat.com>
In-Reply-To: <20250829180354.2922145-1-berrange@redhat.com>
References: <20250829180354.2922145-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/message.h         |  1 +
 system/vl.c                    |  2 +-
 tests/unit/test-error-report.c |  5 +++--
 util/error-report.c            |  4 ----
 util/message.c                 | 15 +++++++++++----
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/qemu/message.h b/include/qemu/message.h
index 95fab69424..4550ce8ed7 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -6,6 +6,7 @@
 enum QMessageFormatFlags {
     QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
     QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
+    QMESSAGE_FORMAT_PROGRAM_NAME = (1 << 2),
 };
 
 /**
diff --git a/system/vl.c b/system/vl.c
index fee6fdf7b1..9030212c50 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -814,7 +814,7 @@ static void realtime_init(void)
 
 static void configure_msg(QemuOpts *opts)
 {
-    int flags = 0;
+    int flags = QMESSAGE_FORMAT_PROGRAM_NAME;
     if (qemu_opt_get_bool(opts, "timestamp", false)) {
         flags |= QMESSAGE_FORMAT_TIMESTAMP;
     }
diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
index 78f8b57660..3987a8ed25 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -48,7 +48,7 @@ test_error_report_loc(void)
     g_test_trap_subprocess(NULL, 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("\
-test-error-report:some-file.c:7717: test error1*\
+test-error-report: some-file.c:7717: test error1*\
 test-error-report: test error2*\
 ");
 }
@@ -91,7 +91,8 @@ static void
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
index 37c803f69f..2e58ee1c50 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -141,10 +141,6 @@ static void print_loc(void)
     int i;
     const char *const *argp;
 
-    if (!monitor_cur() && g_get_prgname()) {
-        error_printf("%s:", g_get_prgname());
-        sep = " ";
-    }
     switch (cur_loc->kind) {
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
diff --git a/util/message.c b/util/message.c
index 0ec9a56d21..cb3ffd6700 100644
--- a/util/message.c
+++ b/util/message.c
@@ -5,7 +5,7 @@
 #include "qemu/message.h"
 #include "monitor/monitor.h"
 
-static int message_format;
+static int message_format = QMESSAGE_FORMAT_PROGRAM_NAME;
 static char *message_workloadname;
 
 void qmessage_set_format(int flags)
@@ -24,6 +24,7 @@ char *qmessage_context(int flags)
 {
     g_autofree char *timestr = NULL;
     const char *wknamestr = NULL;
+    const char *pgnamestr = NULL;
 
     if ((flags & QMESSAGE_CONTEXT_SKIP_MONITOR) &&
         monitor_cur()) {
@@ -39,13 +40,19 @@ char *qmessage_context(int flags)
         wknamestr = message_workloadname;
     }
 
-    if (!timestr && !wknamestr) {
+    if (message_format & QMESSAGE_FORMAT_PROGRAM_NAME) {
+        pgnamestr = g_get_prgname();
+    }
+
+    if (!timestr && !wknamestr && !pgnamestr) {
         return NULL;
     }
 
-    return g_strdup_printf("%s%s%s%s",
+    return g_strdup_printf("%s%s%s%s%s%s",
                            timestr ? timestr : "",
                            timestr ? " " : "",
                            wknamestr ? wknamestr : "",
-                           wknamestr ? " " : "");
+                           wknamestr ? " " : "",
+                           pgnamestr ? pgnamestr : "",
+                           pgnamestr ? ": " : "");
 }
-- 
2.50.1


