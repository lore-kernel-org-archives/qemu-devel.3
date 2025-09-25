Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4CBCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iYM-000196-RJ; Thu, 25 Sep 2025 05:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYJ-00018i-AM
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXt-0001bS-H9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvkLe5PlKeo0HdSyG7FFTgKImW+3jifmX4pZMoyAdkQ=;
 b=NWYnNPN0WD2rotL+XpIkdCuBIZ8H2QOFW7W9flIvSWUBM42MNptBu7E7t+gcKitwBn/Ws2
 ni7CLQw/joxQLWLqXKqYY3osUpHfnoWumUf0p2+gNRxqgun2he3Pl0scGv7BE6zZ/GaVaL
 9DxF6ULK6TGUphcm3iWG7+qYF6hohfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-tUPuQASIN2CtD6daej_t6g-1; Thu,
 25 Sep 2025 05:45:43 -0400
X-MC-Unique: tUPuQASIN2CtD6daej_t6g-1
X-Mimecast-MFC-AGG-ID: tUPuQASIN2CtD6daej_t6g_1758793542
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECA18195605B; Thu, 25 Sep 2025 09:45:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACEE830002D1; Thu, 25 Sep 2025 09:45:36 +0000 (UTC)
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
Subject: [PATCH v4 09/23] util: introduce some API docs for logging APIs
Date: Thu, 25 Sep 2025 10:44:27 +0100
Message-ID: <20250925094441.1651372-10-berrange@redhat.com>
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

This addresses two key gotchas with the logging APIs:

 * Safely outputting a single line of text using
   multiple qemu_log() calls requires use of the
   qemu_log_trylock/unlock functions to avoid
   interleaving between threads

 * Directly outputting to the FILE object returned
   by qemu_log_trylock() must be discouraged because
   it prevents the inclusion of configured log message
   prefixes.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/log-for-trace.h | 35 ++++++++++++++++++++++++++++++++++-
 include/qemu/log.h           | 26 ++++++++++++++++++++++++++
 rust/util/src/log.rs         |  7 +++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index d47c9cd446..4e05b2e26f 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -29,7 +29,40 @@ static inline bool qemu_loglevel_mask(int mask)
     return (qemu_loglevel & mask) != 0;
 }
 
-/* main logging function */
+/**
+ * qemu_log: report a log message
+ * @fmt: the format string for the message
+ * @...: the format string arguments
+ *
+ * This will emit a log message to the current output stream.
+ *
+ * The @fmt string should normally represent a complete line
+ * of text, ending with a newline character.
+ *
+ * If intending to call this function multiple times to
+ * incrementally construct a line of text, locking must
+ * be used to ensure that output from different threads
+ * is not interleaved.
+ *
+ * This is achieved by calling qemu_log_trylock() before
+ * starting the log line; calling qemu_log() multiple
+ * times with the last call having a newline at the end
+ * of @fmt; finishing with a call to qemu_log_unlock().
+ *
+ * The FILE object returned by qemu_log_trylock() does
+ * not need to be used for outputting text directly,
+ * it is merely used to associate the lock.
+ *
+ *    FILE *f = qemu_log_trylock()
+ *
+ *    qemu_log("Something");
+ *    qemu_log("Something");
+ *    qemu_log("Something");
+ *    qemu_log("The end\n");
+ *
+ *    qemu_log_unlock(f);
+ *
+ */
 void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
 
 #endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index aae72985f0..867fe327e4 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -41,7 +41,33 @@ bool qemu_log_separate(void);
 
 /* Lock/unlock output. */
 
+/**
+ * Acquires a lock on the current log output stream.
+ * The returned FILE object must be passed to
+ * qemu_log_unlock() to later release the lock.
+ *
+ * This should be used to protect a sequence of calls
+ * to qemu_log(), if they are being used to incrementally
+ * output a single line of text. For qemu_log() calls which
+ * output a complete line of text it is not required to
+ * take explicit locks.
+ *
+ * The returned FILE object may be used to directly
+ * output log messages, however, doing so will prevent
+ * the inclusion of configured log message prefixes.
+ * It is thus recommended that this be used sparingly,
+ * only in cases where it is required to dump large
+ * data volumes. Use of qemu_log() is preferred for
+ * most output tasks.
+ *
+ * Returns: the current FILE if available, NULL on error
+ */
 FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
+
+/**
+ * Releases the lock on the log output, previously
+ * acquired by qemu_log_trylock().
+ */
 void qemu_log_unlock(FILE *fd);
 
 /* Logging functions: */
diff --git a/rust/util/src/log.rs b/rust/util/src/log.rs
index af9a3e9123..eaf493f0df 100644
--- a/rust/util/src/log.rs
+++ b/rust/util/src/log.rs
@@ -55,6 +55,13 @@ impl LogGuard {
     ///     writeln!(log, "test");
     /// }
     /// ```
+    ///
+    /// Note that directly writing to the log output will prevent the
+    /// inclusion of configured log prefixes. It is thus recommended
+    /// that this be used sparingly, only in cases where it is required
+    /// to dump large data volumes. Use of [`log_mask_ln!()`](crate::log_mask_ln)
+    /// macro() is preferred for most output tasks.
+
     pub fn new() -> Option<Self> {
         let f = unsafe { bindings::qemu_log_trylock() }.cast();
         NonNull::new(f).map(Self)
-- 
2.50.1


