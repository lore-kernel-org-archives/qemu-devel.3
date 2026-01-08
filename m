Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E453D1D483
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtRA-000556-D2; Thu, 08 Jan 2026 12:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtR8-0004rx-Kw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtR6-0006x1-6J
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxGVmRFJHg5nVJLz1ZBLMXtrHWLvPyZOpW/EMNXCgvE=;
 b=C+HzvvqXjXqpXpz8NKqNV8f1yAz0W9Dcl4JfdR+ty2PeFHWgsxHZyjlbCBIruRqSewJjGm
 Qe82pP63c7wAiOmdxMkXCnKqhOI8UqX71BXsK4CQ027eY1Ycjd9zmS3heWtcswsXCOB8ps
 162SNQPtgmZN7GiGplYKNgrOM1FTOGE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-7Dq-fzMjNdiY-xTC6wq9gg-1; Thu,
 08 Jan 2026 12:04:31 -0500
X-MC-Unique: 7Dq-fzMjNdiY-xTC6wq9gg-1
X-Mimecast-MFC-AGG-ID: 7Dq-fzMjNdiY-xTC6wq9gg_1767891870
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 118C719560A5; Thu,  8 Jan 2026 17:04:30 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C79B19560A2; Thu,  8 Jan 2026 17:04:25 +0000 (UTC)
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
Subject: [PATCH v5 10/24] util: avoid repeated prefix on incremental qemu_log
 calls
Date: Thu,  8 Jan 2026 17:03:24 +0000
Message-ID: <20260108170338.2693853-11-berrange@redhat.com>
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

There are three general patterns to QEMU log output

 1. Single complete message calls

      qemu_log("Some message\n");

 2. Direct use of fprintf

      FILE *f = qemu_log_trylock()
      fprintf(f, "...");
      fprintf(f, "...");
      fprintf(f, "...\n");
      qemu_log_unlock(f)

 3. Mixed use of qemu_log_trylock/qemu_log()

      FILE *f = qemu_log_trylock()
      qemu_log("....");
      qemu_log("....");
      qemu_log("....\n");
      qemu_log_unlock(f)

When message prefixes are enabled, the timestamp will be
unconditionally emitted for all qemu_log() calls. This
works fine in the 1st case, and has no effect in the 2nd
case. In the 3rd case, however, we get the timestamp
printed over & over in each fragment.

One can suggest that pattern (3) is pointless as it is
functionally identical to (2) but with extra indirection
and overhead. None the less we have a fair bit of code
that does this.

The qemu_log() call itself is nothing more than a wrapper
which does pattern (2) with a single fprintf() call.

One might question whether (2) should include the message
prefix in the same way that (1), but there are scenarios
where this could be inappropriate / unhelpful such as the
CPU register dumps or linux-user strace output.

This patch fixes the problem in pattern (3) by keeping
track of the call depth of qemu_log_trylock() and then
only emitting the the prefix when the starting depth
was zero. In doing this qemu_log_trylock_context() is
also introduced as a variant of qemu_log_trylock()
that emits the prefix. Callers doing to batch output
can thus choose whether a prefix is appropriate or
not.

Fixes: 012842c07552 (log: make '-msg timestamp=on' apply to all qemu_log usage)
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/log.h |  7 +++++++
 util/log.c         | 49 ++++++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index e9d3c6806b..95f417c2b7 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -69,6 +69,13 @@ bool qemu_log_separate(void);
  */
 FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
 
+/**
+ * As qemu_log_trylock(), but will also print the message
+ * context, if any is configured and this caused the
+ * acquisition of the FILE lock
+ */
+FILE *qemu_log_trylock_context(void) G_GNUC_WARN_UNUSED_RESULT;
+
 /**
  * Releases the lock on the log output, previously
  * acquired by qemu_log_trylock().
diff --git a/util/log.c b/util/log.c
index c44d66b5ce..2ce7286f31 100644
--- a/util/log.c
+++ b/util/log.c
@@ -127,13 +127,39 @@ static FILE *qemu_log_trylock_with_err(Error **errp)
     return logfile;
 }
 
+/*
+ * Zero if there's been no opening qemu_log_trylock call,
+ * indicating the need for message context to be emitted
+ *
+ * Non-zero if we're in the middle of printing a message,
+ * possibly over multiple lines and must skip further
+ * message context
+ */
+static __thread uint log_depth;
+
 FILE *qemu_log_trylock(void)
 {
-    return qemu_log_trylock_with_err(NULL);
+    FILE *f = qemu_log_trylock_with_err(NULL);
+    log_depth++;
+    return f;
+}
+
+FILE *qemu_log_trylock_context(void)
+{
+    FILE *f = qemu_log_trylock();
+    if (log_depth == 1 && message_with_timestamp) {
+        g_autofree const char *timestr = NULL;
+        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+        timestr = g_date_time_format_iso8601(dt);
+        fprintf(f, "%s ", timestr);
+    }
+    return f;
 }
 
 void qemu_log_unlock(FILE *logfile)
 {
+    assert(log_depth);
+    log_depth--;
     if (logfile) {
         fflush(logfile);
         qemu_funlockfile(logfile);
@@ -145,28 +171,9 @@ void qemu_log_unlock(FILE *logfile)
 
 void qemu_log(const char *fmt, ...)
 {
-    FILE *f;
-    g_autofree const char *timestr = NULL;
-
-    /*
-     * Prepare the timestamp *outside* the logging
-     * lock so it better reflects when the message
-     * was emitted if we are delayed acquiring the
-     * mutex
-     */
-    if (message_with_timestamp) {
-        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-        timestr = g_date_time_format_iso8601(dt);
-    }
-
-    f = qemu_log_trylock();
+    FILE *f = qemu_log_trylock_context();
     if (f) {
         va_list ap;
-
-        if (timestr) {
-            fprintf(f, "%s ", timestr);
-        }
-
         va_start(ap, fmt);
         vfprintf(f, fmt, ap);
         va_end(ap);
-- 
2.52.0


