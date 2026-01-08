Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2EBD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtR8-0004u2-VL; Thu, 08 Jan 2026 12:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtR7-0004nO-4B
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtR5-0006wk-C3
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTVK1LnZ0479/k8qg5JQlYJD3Msw/QWha/Ci92hESJY=;
 b=G1EMQ/ogqa3n++G6g8WMndYCaYrwn9nDSwKv+agqq+aZPLTp0KeEAliMX9qcFm0o5Lw6k1
 I4A+SzSAmEFId5idVGNeZsG9i8J73GYavlYtfgJiuat9LQd1Fwor7ZaDUBVZMvEcB6f3RR
 KMs9VNNnx6CSecWKDebtJLvP2c0RS5Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-JZ8dTHVQNIyQQJzZu1ONEQ-1; Thu,
 08 Jan 2026 12:04:29 -0500
X-MC-Unique: JZ8dTHVQNIyQQJzZu1ONEQ-1
X-Mimecast-MFC-AGG-ID: JZ8dTHVQNIyQQJzZu1ONEQ_1767891865
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1D12180035D; Thu,  8 Jan 2026 17:04:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8080519560A2; Thu,  8 Jan 2026 17:04:21 +0000 (UTC)
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
Subject: [PATCH v5 09/24] util: introduce some API docs for logging APIs
Date: Thu,  8 Jan 2026 17:03:23 +0000
Message-ID: <20260108170338.2693853-10-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is a gotcha with qemu_log() usage in a threaded process.
If fragments of a log message are output via qemu_log() it is
possible for messages from two threads to get mixed up. To
prevent this qemu_log_trylock() should be used, along with
fprintf(f) calls.

This is a subtle problem that needs to be explained in the
API docs to ensure correct usage.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/log-for-trace.h | 17 ++++++++++++++++-
 include/qemu/log.h           | 31 +++++++++++++++++++++++++++++++
 rust/util/src/log.rs         |  6 ++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index f3a8791f1d..6861a1a4b7 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -29,7 +29,22 @@ static inline bool qemu_loglevel_mask(int mask)
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
+ * of text, and thus end with a newline character.
+ *
+ * While it is possible to incrementally output fragments of
+ * a complete line using qemu_log, this is inefficient and
+ * races with other threads. For outputting fragments it is
+ * strongly preferred to use the qemu_log_trylock() method
+ * combined with fprintf().
+ */
 void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
 
 #endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index 7effba4da4..e9d3c6806b 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -41,7 +41,38 @@ bool qemu_log_separate(void);
 
 /* Lock/unlock output. */
 
+/**
+ * Acquires a lock on the current log output stream.
+ * The returned FILE object should be used with the
+ * fprintf() function to output the log message, and
+ * then qemu_log_unlock() called to release the lock.
+ *
+ * The primary use case is to be able to incrementally
+ * output fragments of a complete log message in an
+ * efficient and race free manner.
+ *
+ * The simpler qemu_log() method must only be used
+ * to output complete log messages.
+ *
+ * A typical usage pattern would be
+ *
+ *    FILE *f = qemu_log_trylock()
+ *
+ *    fprintf(f, "Something ");
+ *    fprintf(f, "Something ");
+ *    fprintf(f, "Something ");
+ *    fprintf(f, "The end\n");
+ *
+ *    qemu_log_unlock(f);
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
index 0a4bc4249a..6a3a30d8d8 100644
--- a/rust/util/src/log.rs
+++ b/rust/util/src/log.rs
@@ -134,6 +134,12 @@ fn drop(&mut self) {
 ///     "Address 0x{:x} out of range",
 ///     error_address,
 /// );
+///
+/// The `log_mask_ln` macro should only be used for emitting complete
+/// log messages. Where it is required to incrementally output string
+/// fragments to construct a complete message, `LogGuard::new()` should
+/// be directly used in combination with `writeln()` to avoid output
+/// races with other QEMU threads.
 /// ```
 #[macro_export]
 macro_rules! log_mask_ln {
-- 
2.52.0


