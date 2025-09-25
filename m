Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ADECAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ia0-0002wM-LT; Thu, 25 Sep 2025 05:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iZY-0002La-6I
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iZE-0001rB-DQ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss2EscY3N3RFq85ydr0fm+jVUf1+/tbyts1gDknbeM0=;
 b=QyoPvYiywKwh5eOZBNgwuRknKAS1JV0K3DoQyfsMyTmtvPofX0zM3grUcx6COafLHFZnhM
 jJlQg7rQgDmIef70rz3I033u7UVpORNsewqD9vpSS4WmolO9JduDPdf6kqhElXwKjbYYHZ
 zO8IKgYExnMO39+ysieb7EYFOuqKLGk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-Y-zSNa7SPvC8RKhUIRzx-g-1; Thu,
 25 Sep 2025 05:46:58 -0400
X-MC-Unique: Y-zSNa7SPvC8RKhUIRzx-g-1
X-Mimecast-MFC-AGG-ID: Y-zSNa7SPvC8RKhUIRzx-g_1758793617
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C8A818002BB; Thu, 25 Sep 2025 09:46:57 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FBBD300021A; Thu, 25 Sep 2025 09:46:51 +0000 (UTC)
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
Subject: [PATCH v4 22/23] util: add support for formatting thread info in
 messages
Date: Thu, 25 Sep 2025 10:44:40 +0100
Message-ID: <20250925094441.1651372-23-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
  qemu-system-x86_64: (772366:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x560db818e080 dir=fish
  qemu-system-x86_64: (772366:main): qcrypto_tls_creds_get_path TLS creds path creds=0x560db818e080 filename=ca-cert.pem path=<none>
  qemu-system-x86_64: (772366:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/message.h               | 1 +
 storage-daemon/qemu-storage-daemon.c | 6 ++++++
 system/vl.c                          | 8 ++++++--
 tests/qemu-iotests/041               | 2 +-
 tests/qemu-iotests/common.filter     | 2 +-
 util/message.c                       | 7 +++++++
 6 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/qemu/message.h b/include/qemu/message.h
index b8518d06be..2cc092c993 100644
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
index 0ac1b11caf..fb8cc41876 100644
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
@@ -812,10 +816,9 @@ static void realtime_init(void)
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
@@ -2889,6 +2892,7 @@ void qemu_init(int argc, char **argv)
     module_call_init(MODULE_INIT_OPTS);
 
     error_init(argv[0]);
+    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);
     qemu_init_exec_dir(argv[0]);
 
     os_setup_limits();
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8452845f44..dc2666afe7 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1102,7 +1102,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.vm.shutdown()
         log = iotests.filter_qtest(self.vm.get_log())
         log = re.sub(r'^Formatting.*\n', '', log)
-        log = re.sub(r'^%s: ' % os.path.basename(iotests.qemu_prog), '', log)
+        log = re.sub(r'^%s: \(\d+:\w+\): ' % os.path.basename(iotests.qemu_prog), '', log)
 
         self.assertEqual(log,
                          "Can no longer replace 'img1' by 'repair0', because " +
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 511a55b1e8..84f352d30b 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -81,7 +81,7 @@ _filter_qemu_io()
 # replace occurrences of QEMU_PROG with "qemu"
 _filter_qemu()
 {
-    gsed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG):#\1QEMU_PROG:#" \
+    gsed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG): ([0-9]\+:[-_a-zA-Z]\+):#\1QEMU_PROG:#" \
         -e 's#^QEMU [0-9]\+\.[0-9]\+\.[0-9]\+ monitor#QEMU X.Y.Z monitor#' \
         -e $'s#\r##' # QEMU monitor uses \r\n line endings
 }
diff --git a/util/message.c b/util/message.c
index 1db9254733..814ca0316e 100644
--- a/util/message.c
+++ b/util/message.c
@@ -37,4 +37,11 @@ void qmessage_context_print(FILE *fp)
             fprintf(fp, "%s: ", pgnamestr);
         }
     }
+
+    if (message_format & QMESSAGE_FORMAT_THREAD_INFO) {
+        int thid = qemu_get_thread_id();
+        const char *thname = qemu_thread_get_name();
+
+        fprintf(fp, "(%d:%s): ", thid, thname);
+    }
 }
-- 
2.50.1


