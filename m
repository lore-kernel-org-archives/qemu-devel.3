Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F74CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBW-0007zo-5M; Wed, 10 Sep 2025 14:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBU-0007zT-Aw
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBS-0004j5-Jl
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwEOa+l6LoighEebVVlGwnEROumGJcjNVxWy72+VXdU=;
 b=OvSf3dzuI1+H2wqo3v89mtTUSZ+toVefQGiBbpsYNvOQdkXxFNO+HK7UWBe7z4a743MeLn
 jlQschMT3i2hz7VaHkcNJ9wq6zBdpniZizDZnWZY45FQ/o9sxO6PknfgJx+8FOuBk+vLby
 QkjgQdYr4L2HVnl7wki+dR9JNE7rCzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-kE8yN8t7NvC7FIz4jr1cfQ-1; Wed,
 10 Sep 2025 14:04:39 -0400
X-MC-Unique: kE8yN8t7NvC7FIz4jr1cfQ-1
X-Mimecast-MFC-AGG-ID: kE8yN8t7NvC7FIz4jr1cfQ_1757527478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 024F1180057C; Wed, 10 Sep 2025 18:04:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F39281800446; Wed, 10 Sep 2025 18:04:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 08/20] log: avoid repeated prefix on incremental qemu_log
 calls
Date: Wed, 10 Sep 2025 19:03:45 +0100
Message-ID: <20250910180357.320297-9-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some code makes multiple qemu_log calls to incrementally emit
a single message. Currently timestamps get prepended to all
qemu_log calls, even those continuing a previous incomplete
message.

This changes the qemu_log so it skips adding a new line prefix,
if the previous qemu_log call did NOT end with a newline.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/log.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/log.c b/util/log.c
index abdcb6b311..2642a55c59 100644
--- a/util/log.c
+++ b/util/log.c
@@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
     }
 }
 
+/*
+ * 'true' if the previous log message lacked a trailing '\n',
+ * and thus the subsequent call must skip any prefix
+ */
+static __thread bool incomplete;
+
 void qemu_log(const char *fmt, ...)
 {
     FILE *f;
@@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
      * was emitted if we are delayed acquiring the
      * mutex
      */
-    if (message_with_timestamp) {
+    if (message_with_timestamp && !incomplete) {
         g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
         timestr = g_date_time_format_iso8601(dt);
     }
@@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
         va_start(ap, fmt);
         vfprintf(f, fmt, ap);
         va_end(ap);
+        incomplete = fmt[strlen(fmt) - 1] != '\n';
         qemu_log_unlock(f);
     }
 }
-- 
2.50.1


