Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDECCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJXJ-0004fD-3Y; Thu, 15 Oct 2026 07:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXE-0004UM-SR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXD-0004AU-15
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+zhWeQKtUX98A0ZtH2YiRpOcgZq3pNyAaVSkumucB4=;
 b=Yhdn7YIbfsnskmkk45PWQFt0CpeQRpbJY6YEH6tJnJvRzuupQWKs7mA5DJNO7+O6Dat0WI
 IZTTQUGI5RG7IF4NYP1pytxTcthuUZ2Q1k2jVQW9/rEKd4WuibYeBcsaDj0APJJLE+LHnN
 D7YfVgLhzJJcY6eDdWk+WoZwyU8xlQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-wCRrl8GaNjif1atdC9KAXg-1; Thu,
 15 Oct 2026 11:22:03 +0000
X-MC-Unique: wCRrl8GaNjif1atdC9KAXg-1
X-Mimecast-MFC-AGG-ID: wCRrl8GaNjif1atdC9KAXg_1792063321
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A286318007E8; Thu, 15 Oct 2026 11:22:01 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23F891800677; Thu, 15 Oct 2026 11:21:57 +0000 (UTC)
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
Subject: [PATCH 18/21] log: enable directing log messages to data recorder
Date: Thu, 15 Oct 2026 12:20:41 +0100
Message-ID: <20261015112044.1999748-19-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently the log APIs can output messages to stderr, a named
loge file, or discarded to /dev/null.  Introduce a "tldr" log
mask category which causes log messages to be directed to the
data recorder.

This this output is mutually exclusive with file based logging
and only captures single line logs emitted with qemu_log() or
qemu_log_mask(). Log callers using direct FILE* access will be
discarded. This is sufficient for the primary intended use case
which is to collect output from the 'log' trace backend.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/log.h |  1 +
 util/log.c         | 42 +++++++++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index 92956e5d0f5..47d89681d8e 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -38,6 +38,7 @@ bool qemu_log_separate(void);
 #define CPU_LOG_TB_VPU     (1u << 21)
 #define LOG_TB_OP_PLUGIN   (1u << 22)
 #define LOG_INVALID_MEM    (1u << 23)
+#define LOG_TLDR           (1u << 24)
 
 /* Lock/unlock output. */
 
diff --git a/util/log.c b/util/log.c
index 7cffbc1bf89..df7499012f6 100644
--- a/util/log.c
+++ b/util/log.c
@@ -27,6 +27,7 @@
 #include "qemu/thread.h"
 #include "qemu/lockable.h"
 #include "qemu/rcu.h"
+#include "qemu/tldr.h"
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
@@ -172,12 +173,20 @@ void qemu_log_unlock(FILE *logfile)
 
 void qemu_log(const char *fmt, ...)
 {
-    FILE *f = qemu_log_trylock_with_context();
-    if (f) {
-        va_list ap;
-        va_start(ap, fmt);
-        vfprintf(f, fmt, ap);
-        va_end(ap);
+    va_list ap;
+    if (qemu_loglevel & LOG_TLDR) {
+        if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_LOG)) {
+            va_start(ap, fmt);
+            qtldr_msg_record_vprintf(QTLDR_MSG_BUCKET_TYPE_LOG, fmt, ap);
+            va_end(ap);
+        }
+    } else {
+        FILE *f = qemu_log_trylock_with_context();
+        if (f) {
+            va_start(ap, fmt);
+            vfprintf(f, fmt, ap);
+            va_end(ap);
+        }
         qemu_log_unlock(f);
     }
 }
@@ -236,6 +245,7 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
     bool need_to_open_file;
     bool daemonized;
     bool per_thread;
+    bool tldr;
     FILE *logfile;
 
     QEMU_LOCK_GUARD(&global_mutex);
@@ -251,8 +261,20 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
     }
 
     per_thread = log_flags & LOG_PER_THREAD;
+    tldr = log_flags & LOG_TLDR;
 
-    if (changed_name) {
+    if (tldr) {
+        if (filename) {
+            error_setg(errp, "Cannot enable TLDR with a log file");
+            return false;
+        }
+        if (per_thread) {
+            error_setg(errp, "Cannot enable TLDR with per-thread log files");
+            return false;
+        }
+    }
+
+    if (changed_name && !tldr) {
         char *newname = NULL;
 
         /*
@@ -282,7 +304,7 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
         g_free(global_filename);
         global_filename = newname;
         filename = newname;
-    } else {
+    } else if (!tldr) {
         filename = global_filename;
         if (per_thread &&
             valid_filename_template(filename, true, errp) == vft_error) {
@@ -309,7 +331,7 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
          * stderr or to a file (if there is a filename).
          * If per-thread, open the file for each thread in qemu_log_trylock().
          */
-        need_to_open_file = qemu_loglevel && !log_per_thread;
+        need_to_open_file = qemu_loglevel && !log_per_thread && !tldr;
     } else {
         /*
          * If we are daemonized, we will only log if there is a filename.
@@ -531,6 +553,8 @@ const QEMULogItem qemu_log_items[] = {
       "include VPU registers in the 'cpu' logging" },
     { LOG_INVALID_MEM, "invalid_mem",
       "log invalid memory accesses" },
+    { LOG_TLDR, "tldr",
+      "log to QEMU data recorder instead ofa file" },
     { 0, NULL, NULL },
 };
 
-- 
2.56.0


