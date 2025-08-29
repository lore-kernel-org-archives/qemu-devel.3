Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5396CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNaQ-00027g-OW; Sat, 30 Aug 2025 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3TQ-0005fz-UC
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3TP-0005yZ-33
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgjbyrOEn0brWKK2GHDnSTslVOsxwhRJLAenTWwHYrA=;
 b=Qs03drpDXG7D7RwO9kjA9RepkN0hCTPIoJpfXs+Jr24vclfEGM3JB8zALepZLQ8x5LiCyw
 J3L6UguOky3W9bGZXixwvWmDdHeNzZ3iaI3O9p/OhVZOAsWU5wsKOv2povBQn2CBS8mIHW
 znCZmuWfHEHVkRS3SuOnC/75eyrEbD0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-IeRTXkO0MCu5zH4c3t5MTQ-1; Fri,
 29 Aug 2025 14:05:10 -0400
X-MC-Unique: IeRTXkO0MCu5zH4c3t5MTQ-1
X-Mimecast-MFC-AGG-ID: IeRTXkO0MCu5zH4c3t5MTQ_1756490709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B6F1180034F; Fri, 29 Aug 2025 18:05:09 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AF5719560B4; Fri, 29 Aug 2025 18:05:04 +0000 (UTC)
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
Subject: [PATCH v2 13/14] util: add support for formatting thread info in
 messages
Date: Fri, 29 Aug 2025 19:03:53 +0100
Message-ID: <20250829180354.2922145-14-berrange@redhat.com>
In-Reply-To: <20250829180354.2922145-1-berrange@redhat.com>
References: <20250829180354.2922145-1-berrange@redhat.com>
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

The message context is now extended to be able to include the
thread ID and thread name, after the program name. On Linux
the thread ID will match the process TID visible in /proc,
while on other platforms it will merely be an integer repr
of the system thread object address/ID.

This changes the output for both error_report and qemu_log,
when running under the system emulators or the QEMU storage
daemon. Other programs omit the thread information since
they are largely single threaded, though potentially it
would be useful to enable in all of them, given that the RCU
thread will always get spawned by a constructor function.

Before:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
  qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x560db818e080 dir=fish
  qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=0x560db818e080 filename=ca-cert.pem path=<none>
  qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

After:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
  qemu-system-x86_64(772366:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x560db818e080 dir=fish
  qemu-system-x86_64(772366:main): qcrypto_tls_creds_get_path TLS creds path creds=0x560db818e080 filename=ca-cert.pem path=<none>
  qemu-system-x86_64(772366:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/message.h               |  1 +
 storage-daemon/qemu-storage-daemon.c |  6 +++++
 system/vl.c                          |  8 +++++--
 tests/qemu-iotests/041               |  2 +-
 tests/qemu-iotests/common.filter     |  2 +-
 util/message.c                       | 33 +++++++++++++++++++---------
 6 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/qemu/message.h b/include/qemu/message.h
index 4550ce8ed7..6dbb068ca9 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -7,6 +7,7 @@ enum QMessageFormatFlags {
     QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
     QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
     QMESSAGE_FORMAT_PROGRAM_NAME = (1 << 2),
+    QMESSAGE_FORMAT_THREAD_INFO = (1 << 3),
 };
 
 /**
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index eb72561358..cc44ed7848 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -47,6 +47,7 @@
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/message.h"
 #include "qemu/help_option.h"
 #include "qemu/job.h"
 #include "qemu/log.h"
@@ -65,6 +66,10 @@ static const char *pid_file;
 static char *pid_file_realpath;
 static volatile bool exit_requested = false;
 
+#define QMESSAGE_FORMAT_DEFAULT \
+    (QMESSAGE_FORMAT_PROGRAM_NAME | \
+     QMESSAGE_FORMAT_THREAD_INFO)
+
 void qemu_system_killed(int signal, pid_t pid)
 {
     exit_requested = true;
@@ -399,6 +404,7 @@ int main(int argc, char *argv[])
 #endif
 
     error_init(argv[0]);
+    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);
     qemu_init_exec_dir(argv[0]);
     os_setup_signal_handling();
 
diff --git a/system/vl.c b/system/vl.c
index 9030212c50..20b655a7bc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -145,6 +145,10 @@
 
 #define MAX_VIRTIO_CONSOLES 1
 
+#define QMESSAGE_FORMAT_DEFAULT \
+    (QMESSAGE_FORMAT_PROGRAM_NAME | \
+     QMESSAGE_FORMAT_THREAD_INFO)
+
 typedef struct BlockdevOptionsQueueEntry {
     BlockdevOptions *bdo;
     Location loc;
@@ -811,10 +815,9 @@ static void realtime_init(void)
     }
 }
 
-
 static void configure_msg(QemuOpts *opts)
 {
-    int flags = QMESSAGE_FORMAT_PROGRAM_NAME;
+    int flags = QMESSAGE_FORMAT_DEFAULT;
     if (qemu_opt_get_bool(opts, "timestamp", false)) {
         flags |= QMESSAGE_FORMAT_TIMESTAMP;
     }
@@ -2888,6 +2891,7 @@ void qemu_init(int argc, char **argv)
     module_call_init(MODULE_INIT_OPTS);
 
     error_init(argv[0]);
+    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);
     qemu_init_exec_dir(argv[0]);
 
     os_setup_limits();
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8452845f44..d9954da42b 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1102,7 +1102,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.vm.shutdown()
         log = iotests.filter_qtest(self.vm.get_log())
         log = re.sub(r'^Formatting.*\n', '', log)
-        log = re.sub(r'^%s: ' % os.path.basename(iotests.qemu_prog), '', log)
+        log = re.sub(r'^%s\(.*\): ' % os.path.basename(iotests.qemu_prog), '', log)
 
         self.assertEqual(log,
                          "Can no longer replace 'img1' by 'repair0', because " +
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 511a55b1e8..ecf74c223e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -81,7 +81,7 @@ _filter_qemu_io()
 # replace occurrences of QEMU_PROG with "qemu"
 _filter_qemu()
 {
-    gsed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG):#\1QEMU_PROG:#" \
+    gsed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG)(.*):#\1QEMU_PROG:#" \
         -e 's#^QEMU [0-9]\+\.[0-9]\+\.[0-9]\+ monitor#QEMU X.Y.Z monitor#' \
         -e $'s#\r##' # QEMU monitor uses \r\n line endings
 }
diff --git a/util/message.c b/util/message.c
index cb3ffd6700..5201ffc569 100644
--- a/util/message.c
+++ b/util/message.c
@@ -44,15 +44,28 @@ char *qmessage_context(int flags)
         pgnamestr = g_get_prgname();
     }
 
-    if (!timestr && !wknamestr && !pgnamestr) {
-        return NULL;
-    }
+    if (message_format & QMESSAGE_FORMAT_THREAD_INFO) {
+        int thid = qemu_get_thread_id();
+        const char *thname = qemu_thread_get_name();
 
-    return g_strdup_printf("%s%s%s%s%s%s",
-                           timestr ? timestr : "",
-                           timestr ? " " : "",
-                           wknamestr ? wknamestr : "",
-                           wknamestr ? " " : "",
-                           pgnamestr ? pgnamestr : "",
-                           pgnamestr ? ": " : "");
+        return g_strdup_printf("%s%s%s%s%s(%d:%s): ",
+                               timestr ? timestr : "",
+                               timestr ? " " : "",
+                               wknamestr ? wknamestr : "",
+                               wknamestr ? " " : "",
+                               pgnamestr ? pgnamestr : "",
+                               thid, thname);
+    } else {
+        if (!timestr && !wknamestr && !pgnamestr) {
+            return NULL;
+        }
+
+        return g_strdup_printf("%s%s%s%s%s%s",
+                               timestr ? timestr : "",
+                               timestr ? " " : "",
+                               wknamestr ? wknamestr : "",
+                               wknamestr ? " " : "",
+                               pgnamestr ? pgnamestr : "",
+                               pgnamestr ? ": " : "");
+    }
 }
-- 
2.50.1


