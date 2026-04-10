Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C91F459EF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEMi-00049v-9T; Fri, 10 Apr 2026 12:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMW-00042L-6o
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMT-0006Qp-I6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvSkhUVa0BQXOqBV5xKSGKJv0S+rk4U3SVFX6QIUiAQ=;
 b=WMHXtbkYvWr55dkjfSSB7J0914j/hdd2gZrTWtZNlF5pPCHDsqQLzXhFuE3hZpY0sTaBnI
 Ix2VOM1xqi5foDKUXh2HfsnXm7fYmJcqRZTnb13RWCWD1MuZ7j7w0hR6U8/webcYikFhDj
 dSJ49yFUbjrO2T74LFBfAPSRkcLRll4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-_APAEGAtPRirmIKqEcObPw-1; Fri,
 10 Apr 2026 12:05:33 -0400
X-MC-Unique: _APAEGAtPRirmIKqEcObPw-1
X-Mimecast-MFC-AGG-ID: _APAEGAtPRirmIKqEcObPw_1775837130
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F981800361; Fri, 10 Apr 2026 16:05:30 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 752FB195608E; Fri, 10 Apr 2026 16:05:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 07/17] monitor: use class methods for monitor_vprintf
Date: Fri, 10 Apr 2026 17:04:48 +0100
Message-ID: <20260410160458.3778874-8-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This removes the need for using monitor_is_qmp() to check the
subclass type, which is an anti-pattern.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              | 12 ++++++++++++
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 11 ++++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 833de0eee8..3fe6f5715a 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -50,14 +50,26 @@ static void monitor_hmp_finalize(Object *obj)
     readline_free(mon->rs);
 }
 
+int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
+    G_GNUC_PRINTF(2, 0);
+
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
+    MonitorClass *moncls = MONITOR_CLASS(cls);
+
+    moncls->vprintf = monitor_hmp_vprintf;
 }
 
 static void monitor_hmp_init(Object *obj)
 {
 }
 
+int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
+    return monitor_puts(mon, buf);
+}
+
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 5bfe3b7325..3f05c46e88 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -95,6 +95,9 @@ typedef struct HMPCommand {
 
 struct MonitorClass {
     ObjectClass parent_class;
+
+    int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
+        G_GNUC_PRINTF(2, 0);
 };
 
 struct Monitor {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f6c90145f6..b51046c0c9 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -243,21 +243,18 @@ int monitor_puts(Monitor *mon, const char *str)
 
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
-    char *buf;
-    int n;
+    MonitorClass *moncls;
 
     if (!mon) {
         return -1;
     }
 
-    if (monitor_is_qmp(mon)) {
+    moncls = MONITOR_GET_CLASS(mon);
+    if (!moncls->vprintf) {
         return -1;
     }
 
-    buf = g_strdup_vprintf(fmt, ap);
-    n = monitor_puts(mon, buf);
-    g_free(buf);
-    return n;
+    return moncls->vprintf(mon, fmt, ap);
 }
 
 int monitor_printf(Monitor *mon, const char *fmt, ...)
-- 
2.53.0


