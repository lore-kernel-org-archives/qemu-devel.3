Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83821D29FF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0Hq-0005zu-W6; Wed, 14 Jan 2026 07:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0HX-0005sy-He
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0HR-0002DA-EM
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768394839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxpmqsakgJ0BYcMpa+6PbTMXSVujm+9u46ujIPqDxsc=;
 b=QdV+gkx5EWJ09p/ACHny5NNM6GvbfjXZAR5A95Da2QoFDtRs/xWv1cb4w/sfTkMzF/3tqv
 Y6vaEN2vaJxC2vmV611TUZui4XmXMN1Vrw1Vi/5aaLQlRchg0YOR78oUZdtMfK0enSsGHl
 wsR+7z3x3GzkwELP0fs9JiiPzXnvPO4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-zjrGWvqZNvqYbAJvaWwq5A-1; Wed,
 14 Jan 2026 07:47:17 -0500
X-MC-Unique: zjrGWvqZNvqYbAJvaWwq5A-1
X-Mimecast-MFC-AGG-ID: zjrGWvqZNvqYbAJvaWwq5A_1768394837
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B6E419560B4; Wed, 14 Jan 2026 12:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40E05180066A; Wed, 14 Jan 2026 12:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C7B621E692F; Wed, 14 Jan 2026 13:47:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	dave@treblig.org
Subject: [PATCH 1/3] error: Fix "to current monitor if we have one" comments
Date: Wed, 14 Jan 2026 13:47:11 +0100
Message-ID: <20260114124713.3308719-2-armbru@redhat.com>
In-Reply-To: <20260114124713.3308719-1-armbru@redhat.com>
References: <20260114124713.3308719-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

A number of print functions are documented to print to "current
monitor if we have one, else stderr".  Wrong, they print to the
current monitor only when it's HMP.  This is the case since commit
4ad417baa43 (error: Print error_report() to stderr if using qmp).

Fix the comments to say "current HMP monitor if we have one".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h |  3 ++-
 monitor/monitor.c    |  2 +-
 util/error-report.c  | 26 ++++++++++++++++----------
 util/qemu-print.c    |  4 ++--
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 2356b84bb3..d1d37fc656 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -64,7 +64,8 @@
  *
  * = Reporting and destroying errors =
  *
- * Report an error to the current monitor if we have one, else stderr:
+ * Report an error to the current HMP monitor if we have one, else
+ * stderr:
  *     error_report_err(err);
  * This frees the error object.
  *
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1273eb7260..c42d9fad58 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -269,7 +269,7 @@ void monitor_printc(Monitor *mon, int c)
 }
 
 /*
- * Print to current monitor if we have one, else to stderr.
+ * Print to current HMP monitor if we have one, else to stderr.
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..f051f29b2d 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -136,7 +136,8 @@ void loc_set_file(const char *fname, int lno)
 }
 
 /*
- * Print current location to current monitor if we have one, else to stderr.
+ * Print current location to current HMP monitor if we have one, else
+ * to stderr.
  */
 static void print_loc(void)
 {
@@ -177,7 +178,8 @@ real_time_iso8601(void)
 }
 
 /*
- * Print a message to current monitor if we have one, else to stderr.
+ * Print a message to current HMP monitor if we have one, else to
+ * stderr.
  * @report_type is the type of message: error, warning or informational.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
@@ -217,7 +219,8 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 }
 
 /*
- * Print an error message to current monitor if we have one, else to stderr.
+ * Print an error message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -229,7 +232,8 @@ void error_vreport(const char *fmt, va_list ap)
 }
 
 /*
- * Print a warning message to current monitor if we have one, else to stderr.
+ * Print a warning message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -240,8 +244,8 @@ void warn_vreport(const char *fmt, va_list ap)
 }
 
 /*
- * Print an information message to current monitor if we have one, else to
- * stderr.
+ * Print an information message to current HMP monitor if we have one,
+ * else to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -252,7 +256,8 @@ void info_vreport(const char *fmt, va_list ap)
 }
 
 /*
- * Print an error message to current monitor if we have one, else to stderr.
+ * Print an error message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like sprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -268,7 +273,8 @@ void error_report(const char *fmt, ...)
 }
 
 /*
- * Print a warning message to current monitor if we have one, else to stderr.
+ * Print a warning message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -283,8 +289,8 @@ void warn_report(const char *fmt, ...)
 }
 
 /*
- * Print an information message to current monitor if we have one, else to
- * stderr.
+ * Print an information message to current HMP monitor if we have one,
+ * else to stderr.
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
diff --git a/util/qemu-print.c b/util/qemu-print.c
index 69ba612f56..4a30cd1a8e 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -16,7 +16,7 @@
 
 /*
  * Print like vprintf().
- * Print to current monitor if we have one, else to stdout.
+ * Print to current HMP monitor if we have one, else to stdout.
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
@@ -29,7 +29,7 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
 /*
  * Print like printf().
- * Print to current monitor if we have one, else to stdout.
+ * Print to current HMP monitor if we have one, else to stdout.
  */
 int qemu_printf(const char *fmt, ...)
 {
-- 
2.52.0


