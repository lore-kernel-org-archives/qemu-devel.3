Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3652DD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtSB-0007lY-LM; Thu, 08 Jan 2026 12:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtRu-0007QW-Q6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtRs-0007L8-NS
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxpePEWBvXPkX77Bstam66E8lwSkyfI4Rjt1/RzQqkk=;
 b=TdFc5UpOH5kxoKTdR1lQ+xN8CSiVRwZ1kWKQWMZySIOawAegiVeDGJXYUTh4hJoa5jeE5D
 Oq2dHuwl/NZj2FkZccWzVORAByadV2NGL3SmO/mkbmIj/Sbvv2Hq3iCuSVnAWQ4HKGFLjR
 W3Grs/cIsoqhb7gc4o583N+s76PStgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-D9h-JefPNdSU-3rALDKXIg-1; Thu,
 08 Jan 2026 12:05:20 -0500
X-MC-Unique: D9h-JefPNdSU-3rALDKXIg-1
X-Mimecast-MFC-AGG-ID: D9h-JefPNdSU-3rALDKXIg_1767891918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720DB1956059; Thu,  8 Jan 2026 17:05:18 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B13619560B4; Thu,  8 Jan 2026 17:05:14 +0000 (UTC)
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
Subject: [PATCH v5 21/24] util: add support for formatting a workload name in
 messages
Date: Thu,  8 Jan 2026 17:03:35 +0000
Message-ID: <20260108170338.2693853-22-berrange@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/error-report.h |  3 ---
 include/qemu/message.h      | 10 ++++++++++
 system/vl.c                 |  6 ++++--
 util/error-report.c         |  7 -------
 util/message.c              | 12 ++++++++++++
 5 files changed, 26 insertions(+), 12 deletions(-)

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
index 0a06421f77..cfc3c92648 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -5,6 +5,7 @@
 
 enum QMessageFormatFlags {
     QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
+    QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
 };
 
 /**
@@ -16,6 +17,15 @@ enum QMessageFormatFlags {
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
 /**
  * qmessage_context_print:
  * @fp: file to emit the prefix on
diff --git a/system/vl.c b/system/vl.c
index 75e2fd310d..5f3b5436a6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -823,7 +823,9 @@ static void configure_msg(QemuOpts *opts)
     if (qemu_opt_get_bool(opts, "timestamp", false)) {
         flags |= QMESSAGE_FORMAT_TIMESTAMP;
     }
-    error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
+    if (qemu_opt_get_bool(opts, "guest-name", false)) {
+        flags |= QMESSAGE_FORMAT_WORKLOAD_NAME;
+    }
     qmessage_set_format(flags);
 }
 
@@ -3526,7 +3528,7 @@ void qemu_init(int argc, char **argv)
                     exit(1);
                 }
                 /* Capture guest name if -msg guest-name is used later */
-                error_guest_name = qemu_opt_get(opts, "guest");
+                qmessage_set_workload_name(qemu_opt_get(opts, "guest"));
                 break;
             case QEMU_OPTION_prom_env:
                 if (nb_prom_envs >= MAX_PROM_ENVS) {
diff --git a/util/error-report.c b/util/error-report.c
index 0c39857fc5..313c2d6055 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -25,8 +25,6 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
 
-bool error_with_guestname;
-const char *error_guest_name;
 
 /*
  * Print to current monitor if we have one, else to stderr.
@@ -222,11 +220,6 @@ static void vreport(report_type type, const char *fmt, va_list ap)
         qmessage_context_print(stderr);
     }
 
-    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !cur) {
-        fprintf(stderr, "%s ", error_guest_name);
-    }
-
     print_loc(cur);
 
     switch (type) {
diff --git a/util/message.c b/util/message.c
index 99a403f9d0..fb2c947153 100644
--- a/util/message.c
+++ b/util/message.c
@@ -6,12 +6,18 @@
 #include "monitor/monitor.h"
 
 static int message_format;
+static char *message_workloadname;
 
 void qmessage_set_format(int flags)
 {
     message_format = flags;
 }
 
+void qmessage_set_workload_name(const char *name)
+{
+    message_workloadname = g_strdup(name);
+}
+
 void qmessage_context_print(FILE *fp)
 {
     if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
@@ -20,4 +26,10 @@ void qmessage_context_print(FILE *fp)
         fputs(timestr, fp);
         fputc(' ', fp);
     }
+
+    if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
+        message_workloadname) {
+        fputs(message_workloadname, fp);
+        fputc(' ', fp);
+    }
 }
-- 
2.52.0


