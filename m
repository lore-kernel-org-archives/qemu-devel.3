Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F453CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZS-0002IZ-Pc; Thu, 25 Sep 2025 05:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iZP-0002Dv-Qv
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iZ6-0001qb-FZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZnC6QiBd1lbYvGRWS1LNh6guPnvUdl77jy61phbsAI=;
 b=DW8+Z9pIO2g0Gea95dzdEIGQZ0eAlSBrlWaZE5/GWU5a1WTS65RJ9XV9AadiRclgbDw1Hi
 g3YtbMXZQpUKz/itNW2pLwGgXyyRm0lTZR8K3d6NWQZ90Zs//2nLJIsOfZ7vI+UobvOtdU
 F3o9Wvxp+U6cLWdfZrvd/wByLRr39RA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-EHxMsjApNcy_vYIeoM-fMA-1; Thu,
 25 Sep 2025 05:46:53 -0400
X-MC-Unique: EHxMsjApNcy_vYIeoM-fMA-1
X-Mimecast-MFC-AGG-ID: EHxMsjApNcy_vYIeoM-fMA_1758793611
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACBE21800299; Thu, 25 Sep 2025 09:46:51 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D4EA300021A; Thu, 25 Sep 2025 09:46:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 21/23] util: add support for formatting a program name in
 messages
Date: Thu, 25 Sep 2025 10:44:39 +0100
Message-ID: <20250925094441.1651372-22-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/message.h         | 1 +
 system/vl.c                    | 2 +-
 tests/unit/test-error-report.c | 5 +++--
 util/error-report.c            | 4 ----
 util/message.c                 | 9 ++++++++-
 5 files changed, 13 insertions(+), 8 deletions(-)

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
diff --git a/system/vl.c b/system/vl.c
index 56829880f6..0ac1b11caf 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -815,7 +815,7 @@ static void realtime_init(void)
 
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
index edb04585aa..b010f97bda 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -176,10 +176,6 @@ static void print_loc(Monitor *cur)
     int i;
     const char *const *argp;
 
-    if (!cur && g_get_prgname()) {
-        error_printf_mon(NULL, "%s:", g_get_prgname());
-        sep = " ";
-    }
     switch (cur_loc->kind) {
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
diff --git a/util/message.c b/util/message.c
index a91c008e08..1db9254733 100644
--- a/util/message.c
+++ b/util/message.c
@@ -5,7 +5,7 @@
 #include "qemu/message.h"
 #include "monitor/monitor.h"
 
-static int message_format;
+static int message_format = QMESSAGE_FORMAT_PROGRAM_NAME;
 static char *message_workloadname;
 
 void qmessage_set_format(int flags)
@@ -30,4 +30,11 @@ void qmessage_context_print(FILE *fp)
         message_workloadname) {
         fprintf(fp, "%s ", message_workloadname);
     }
+
+    if (message_format & QMESSAGE_FORMAT_PROGRAM_NAME) {
+        const char *pgnamestr = g_get_prgname();
+        if (pgnamestr) {
+            fprintf(fp, "%s: ", pgnamestr);
+        }
+    }
 }
-- 
2.50.1


