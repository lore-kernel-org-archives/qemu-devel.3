Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0CCF47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCpA-0003xL-Ua; Thu, 05 Mar 2026 12:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCp8-0003pO-Ux
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCp7-0002Fo-Al
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2A27Bn0eymuRNSFalHPR4qUcCIkQEC0ixxoYIziwMo=;
 b=ItShQ80y9nvk0pvbmv5boX2B1AweNCFsrOIhCEgWsQV9UvpUbDKKu4rgo+uh71ZSWthgu3
 Y6bk4uFyrfSBFOeSeliH+JrdGZ0rRnhxeqgC6RxmyYTiAMyfk8x4vDv2R6uWC4xP17D7vx
 7gdR0MwmBLXMs7IHi4WDRUPKnZCPPR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-jQDr4JfEPj6YwiJSHFnBwQ-1; Thu,
 05 Mar 2026 12:49:15 -0500
X-MC-Unique: jQDr4JfEPj6YwiJSHFnBwQ-1
X-Mimecast-MFC-AGG-ID: jQDr4JfEPj6YwiJSHFnBwQ_1772732953
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1FDD19560A5; Thu,  5 Mar 2026 17:49:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05E6F1956095; Thu,  5 Mar 2026 17:49:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PULL 15/27] util: introduce some API docs for logging APIs
Date: Thu,  5 Mar 2026 17:47:31 +0000
Message-ID: <20260305174743.3084606-16-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
References: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is a gotcha with qemu_log() usage in a threaded process.
If fragments of a log message are output via qemu_log() it is
possible for messages from two threads to get mixed up. To
prevent this qemu_log_trylock() should be used, along with
fprintf(f) calls.

This is a subtle problem that needs to be explained in the
API docs to ensure correct usage.

In the Rust code, the log_mask_ln method which is conceptually
equivalent to the C qemu_log() call will unconditionally append
a newline so must only ever be used for complete log messages.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/log-for-trace.h | 17 ++++++++++++++++-
 include/qemu/log.h           | 32 ++++++++++++++++++++++++++++++++
 rust/util/src/log.rs         |  6 ++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

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
index 7effba4da4..b49a1a5fe3 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -41,7 +41,39 @@ bool qemu_log_separate(void);
 
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
+ * The simpler qemu_log() method should normally only
+ * be used to output complete log messages, and not
+ * within scope of a qemu_log_trylock() call.
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
index 0a4bc4249a..1116570790 100644
--- a/rust/util/src/log.rs
+++ b/rust/util/src/log.rs
@@ -135,6 +135,12 @@ fn drop(&mut self) {
 ///     error_address,
 /// );
 /// ```
+///
+/// The `log_mask_ln` macro must only be used for emitting complete
+/// log messages. Where it is required to incrementally output string
+/// fragments to construct a complete message, `LogGuard::new()` must
+/// be directly used in combination with `writeln()` to avoid output
+/// races with other QEMU threads.
 #[macro_export]
 macro_rules! log_mask_ln {
     ($mask:expr, $fmt:tt $($args:tt)*) => {{
-- 
2.53.0


