Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B96FCA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSwC-0004Ht-Qr; Tue, 19 Aug 2025 16:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSwA-0004GR-08
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSw8-0006Uy-B5
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755635283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DplX85QpoW+SuKWov80XzPDPNFM5xR6XGp/Y8TOZbJw=;
 b=NGPpartA5Wo65Yxei0liwaGT5LZ4lWJCVpn0P6+pnuyAkRFcttXWo0GUSNkH/iAqJ0qr6n
 Cg7ALmPKGKMbqa7GXVe4Es38bmtMa8YPJFFTdRN8A8ijRc8dBWNAUMeOflGPHK7nxYX9Yh
 OlcBCpcKRKtg0sra8WQwW4mWIi95ZdM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-ZfFpGxuNP1Sy1RtiZ8JEyQ-1; Tue,
 19 Aug 2025 16:28:00 -0400
X-MC-Unique: ZfFpGxuNP1Sy1RtiZ8JEyQ-1
X-Mimecast-MFC-AGG-ID: ZfFpGxuNP1Sy1RtiZ8JEyQ_1755635279
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38F161800359; Tue, 19 Aug 2025 20:27:59 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39D3A19560B0; Tue, 19 Aug 2025 20:27:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/12] util: add support for formatting a workload name in
 messages
Date: Tue, 19 Aug 2025 21:27:05 +0100
Message-ID: <20250819202708.1185594-10-berrange@redhat.com>
In-Reply-To: <20250819202708.1185594-1-berrange@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The error_report function can include the guest name in any
messages it prints. The qemu_log function has no equivalent
behaviour.

This introduces support for a "workload name" in the new
messages API, which in the case of system emulators will
be the guest name. The possibility of defining a workload
name for other binaries is left as an exercise for the
future.

This change has no impact on the output of the error_report
function, but will change the qemu_log function. This can
be easily seen with the 'log' trace backend, and how it is
now more closely matching error_report output.

Before:

  # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
  qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
  qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
  blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

After:

  # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
  blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
  blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
  blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/error-report.h |  3 ---
 include/qemu/message.h      | 14 ++++++++++++--
 system/vl.c                 |  6 ++++--
 util/error-report.c         |  7 -------
 util/message.c              | 19 +++++++++++++++++--
 5 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index c8000778ec..ffc305f828 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -70,7 +70,4 @@ void error_init(const char *argv0);
                               fmt, ##__VA_ARGS__);      \
     })
 
-extern bool error_with_guestname;
-extern const char *error_guest_name;
-
 #endif
diff --git a/include/qemu/message.h b/include/qemu/message.h
index 160bee8417..95fab69424 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -5,9 +5,10 @@
 
 enum QMessageFormatFlags {
     QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
+    QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
 };
 
-/*
+/**
  * qmessage_set_format:
  * @flags: the message information to emit
  *
@@ -16,11 +17,20 @@ enum QMessageFormatFlags {
  */
 void qmessage_set_format(int flags);
 
+/**
+ * qmessage_set_workload_name:
+ * @name: the name of the workload
+ *
+ * Set the workload name, which for a system emulator
+ * will be the guest VM name.
+ */
+void qmessage_set_workload_name(const char *name);
+
 enum QMessageContextFlags {
     QMESSAGE_CONTEXT_SKIP_MONITOR = (1 << 0),
 };
 
-/*
+/**
  * qmessage_context:
  * @flags: the message formatting control flags
  *
diff --git a/system/vl.c b/system/vl.c
index 696dd92669..fee6fdf7b1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -818,7 +818,9 @@ static void configure_msg(QemuOpts *opts)
     if (qemu_opt_get_bool(opts, "timestamp", false)) {
         flags |= QMESSAGE_FORMAT_TIMESTAMP;
     }
-    error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
+    if (qemu_opt_get_bool(opts, "guest-name", false)) {
+        flags |= QMESSAGE_FORMAT_WORKLOAD_NAME;
+    }
     qmessage_set_format(flags);
 }
 
@@ -3520,7 +3522,7 @@ void qemu_init(int argc, char **argv)
                     exit(1);
                 }
                 /* Capture guest name if -msg guest-name is used later */
-                error_guest_name = qemu_opt_get(opts, "guest");
+                qmessage_set_workload_name(qemu_opt_get(opts, "guest"));
                 break;
             case QEMU_OPTION_prom_env:
                 if (nb_prom_envs >= MAX_PROM_ENVS) {
diff --git a/util/error-report.c b/util/error-report.c
index 932af5d9f5..765381dc37 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -25,8 +25,6 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
 
-bool error_with_guestname;
-const char *error_guest_name;
 
 int error_printf(const char *fmt, ...)
 {
@@ -182,11 +180,6 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 
     error_printf("%s", context);
 
-    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur()) {
-        error_printf("%s ", error_guest_name);
-    }
-
     print_loc();
 
     switch (type) {
diff --git a/util/message.c b/util/message.c
index 4c7eeb75e2..1ce3a34928 100644
--- a/util/message.c
+++ b/util/message.c
@@ -6,15 +6,24 @@
 #include "monitor/monitor.h"
 
 static int message_format;
+static char *message_workloadname;
 
 void qmessage_set_format(int flags)
 {
     message_format = flags;
 }
 
+
+void qmessage_set_workload_name(const char *name)
+{
+    message_workloadname = g_strdup(name);
+}
+
+
 char *qmessage_context(int flags)
 {
     g_autofree char *timestr = NULL;
+    const char *wknamestr = NULL;
 
     if ((flags & QMESSAGE_CONTEXT_SKIP_MONITOR) &&
         monitor_cur()) {
@@ -26,7 +35,13 @@ char *qmessage_context(int flags)
         timestr = g_date_time_format_iso8601(dt);
     }
 
-    return g_strdup_printf("%s%s",
+    if (message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) {
+        wknamestr = message_workloadname;
+    }
+
+    return g_strdup_printf("%s%s%s%s",
                            timestr ? timestr : "",
-                           timestr ? " " : "");
+                           timestr ? " " : "",
+                           wknamestr ? wknamestr : "",
+                           wknamestr ? " " : "");
 }
-- 
2.50.1


