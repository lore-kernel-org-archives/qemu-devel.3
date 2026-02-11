Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0839EB271F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqC7s-00005H-9o; Wed, 11 Feb 2026 10:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC7g-0007I3-EI
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:27:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC7c-00065K-Bs
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ids8ssbjyqIGdjv1hvc90z9LCMXzQg8S2+lPCiRENwA=;
 b=OMnx2xnCLYF7s7VrESJRTU8Iu1GVUquFx0AtqFD1oAFElGEcBbF9LJ0ROs+KMxBieVTEc4
 6UakDlJghViJl4ey9+74+WQXz4TYsDQV3rONLaqeYFVzG7AFJxs0Ym1CFy4K1ts/Ey+X8q
 YG6HWzPh/wvvqFysjYcoJlvOALRo3YA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Y2Wf5-4YO6e9Q_Wy8Qnv-g-1; Wed,
 11 Feb 2026 10:27:14 -0500
X-MC-Unique: Y2Wf5-4YO6e9Q_Wy8Qnv-g-1
X-Mimecast-MFC-AGG-ID: Y2Wf5-4YO6e9Q_Wy8Qnv-g_1770823630
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15D1D19560B2; Wed, 11 Feb 2026 15:27:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 485AE30001A8; Wed, 11 Feb 2026 15:27:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 20/27] util: don't skip error prefixes when QMP is active
Date: Wed, 11 Feb 2026 15:25:01 +0000
Message-ID: <20260211152508.732487-21-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-1-berrange@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index b34a2bc7bc..052f0f68b8 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -227,6 +227,14 @@ static void vreport(report_type type, const char *fmt, va_list ap)
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


