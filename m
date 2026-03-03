Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93B5EDA681
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRL0-0006ph-TH; Tue, 03 Mar 2026 10:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKx-0006jZ-7L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKu-00029v-T5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKT2uXZ9IPbp+nH7ZQ7kgddtWf6rY1l9xOVO64XHbN8=;
 b=E3C2dqkKyaUFZVw6AB93fPng5G9isQoBJUIN0aTzXBCOyBmQH1T88QBAINUTQ3CRkGS+9X
 6r5uAYG/Z0AoR7v39dGn721hmW2OT1maJzQ6buUtc0iqbbhqlHKEbZD3NIG5jqtrwG67ZZ
 ks635fy7Dw2+KhNtJem53/Jpbrj5Cwk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-wlK_-2YaMWSWQlPs9kunWg-1; Tue,
 03 Mar 2026 10:06:58 -0500
X-MC-Unique: wlK_-2YaMWSWQlPs9kunWg-1
X-Mimecast-MFC-AGG-ID: wlK_-2YaMWSWQlPs9kunWg_1772550418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31292195606B
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 15:06:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2667D1800370; Tue,  3 Mar 2026 15:06:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 24/27] util: don't skip error prefixes when QMP is active
Date: Tue,  3 Mar 2026 15:06:01 +0000
Message-ID: <20260303150604.2402872-25-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The vreport() function will print to HMP if available, otherwise
to stderr. In the event that vreport() is called during execution
of a QMP command, it will print to stderr, but mistakenly omit the
message prefixes (timestamp, guest name, program name).

This new usage of monitor_is_cur_qmp() from vreport() requires that
we add a stub to satisfy linking of non-system emulator binaries.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 stubs/monitor-core.c           | 5 +++++
 tests/unit/test-util-sockets.c | 1 +
 util/error-report.c            | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index a7c32297c9..078a5012e9 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
+bool monitor_cur_is_qmp(void)
+{
+    return false;
+}
+
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ee66d727c3..b9f2453e29 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -74,6 +74,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
+bool monitor_cur_is_qmp(void) { abort(); };
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
diff --git a/util/error-report.c b/util/error-report.c
index f666ca4149..6b9e592bc1 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -226,6 +226,14 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     Monitor *cur = monitor_cur();
     gchar *timestr;
 
+    /*
+     * When current monitor is QMP, messages must go to stderr
+     * and have prefixes added
+     */
+    if (monitor_cur_is_qmp()) {
+        cur = NULL;
+    }
+
     if (message_with_timestamp && !cur) {
         timestr = real_time_iso8601();
         fprintf(stderr, "%s ", timestr);
-- 
2.53.0


