Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E96CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSwO-0004fQ-2j; Tue, 19 Aug 2025 16:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSwL-0004Tn-Rv
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSwK-0006WW-2a
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755635295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tunfKSVqIdprqXspYXZV5VxsMbsXr/axCQHjX1xu1EA=;
 b=esX15x5O3ZHrKjLw4BQ1D521fSw9wU10bT+juK33K1IVdTC+Iyk1pHi0Cwv+psyoOLz3eJ
 obW4wENrbWkmmdK0USGPa7ZixjK4+lFV+GnxTxu2YowD211ejaZJ/yyQ0zTHU/pM/NJcs1
 MCsUls4Y20K0h3VbsLq/kKIGmLixR68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-AWYl-TJcNbOno4M5iMR_2w-1; Tue,
 19 Aug 2025 16:28:11 -0400
X-MC-Unique: AWYl-TJcNbOno4M5iMR_2w-1
X-Mimecast-MFC-AGG-ID: AWYl-TJcNbOno4M5iMR_2w_1755635290
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86D8218002CB; Tue, 19 Aug 2025 20:28:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1918D19560B0; Tue, 19 Aug 2025 20:28:04 +0000 (UTC)
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
Subject: [PATCH 11/12] util: add support for formatting thread info in messages
Date: Tue, 19 Aug 2025 21:27:07 +0100
Message-ID: <20250819202708.1185594-12-berrange@redhat.com>
In-Reply-To: <20250819202708.1185594-1-berrange@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
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
 storage-daemon/qemu-storage-daemon.c |  6 ++++++
 system/vl.c                          |  8 ++++++--
 tests/qemu-iotests/041               |  2 +-
 tests/qemu-iotests/common.filter     |  2 +-
 util/message.c                       | 27 ++++++++++++++++++++-------
 6 files changed, 35 insertions(+), 11 deletions(-)

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
index f1c4f92e7b..300dc10a4f 100644
--- a/util/message.c
+++ b/util/message.c
@@ -44,11 +44,24 @@ char *qmessage_context(int flags)
         pgnamestr = g_get_prgname();
     }
 
-    return g_strdup_printf("%s%s%s%s%s%s",
-                           timestr ? timestr : "",
-                           timestr ? " " : "",
-                           wknamestr ? wknamestr : "",
-                           wknamestr ? " " : "",
-                           pgnamestr ? pgnamestr : "",
-                           pgnamestr ? ": " : "");
+    if (message_format & QMESSAGE_FORMAT_THREAD_INFO) {
+        uint64_t thid = qemu_thread_get_id();
+        const char *thname = qemu_thread_get_name();
+
+        return g_strdup_printf("%s%s%s%s%s(%" PRIu64 ":%s): ",
+                               timestr ? timestr : "",
+                               timestr ? " " : "",
+                               wknamestr ? wknamestr : "",
+                               wknamestr ? " " : "",
+                               pgnamestr ? pgnamestr : "",
+                               thid, thname);
+    } else {
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


