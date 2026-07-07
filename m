Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC77C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9xG-0006ys-As; Tue, 07 Jul 2026 13:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9wX-00066D-3f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9wV-0001Px-8u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783446646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23n61GrAfEGCfYIkBBlHO/krCWMAXXK+Kqwhuwne/cA=;
 b=eIVv+cID0tCLF7rtx1dVl3Rcbx8di1XBTlWmwcpToITCVSpLT7xcvQacc/HbdVA7O5bgZ/
 NC/LtdVwuzo+moj6UfOpNzP/oXZB4SBELlRIDTZRhVxytNd0Wc409X/C/gsB6wIlfNKLEA
 9zfXoozBwJB27oZH69RTfCFgIDrx86o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-EV69eHGQMWGi34BRhqaLUw-1; Tue,
 07 Jul 2026 13:50:36 -0400
X-MC-Unique: EV69eHGQMWGi34BRhqaLUw-1
X-Mimecast-MFC-AGG-ID: EV69eHGQMWGi34BRhqaLUw_1783446635
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C8011806CBE; Tue,  7 Jul 2026 17:50:35 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.142])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73A363692B; Tue,  7 Jul 2026 17:50:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PULL 2/4] util/filemonitor-inotify: Use QEMU_LOCK_GUARD()
Date: Tue,  7 Jul 2026 18:50:25 +0100
Message-ID: <20260707175027.3029620-3-berrange@redhat.com>
In-Reply-To: <20260707175027.3029620-1-berrange@redhat.com>
References: <20260707175027.3029620-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Evgeny Kolmakov <randomjack94dev@gmail.com>

Replace manual qemu_mutex_(un)lock() calls with
QEMU_LOCK_GUARD() to remove 'goto cleanup' code

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/filemonitor-inotify.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 7352b9fe53..fe2057f820 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/filemonitor.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockable.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -59,10 +60,9 @@ static void qemu_file_monitor_watch(void *arg)
     int used = 0;
     int len;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
 
     if (mon->fd == -1) {
-        qemu_mutex_unlock(&mon->lock);
         return;
     }
 
@@ -72,11 +72,10 @@ static void qemu_file_monitor_watch(void *arg)
         if (errno != EAGAIN) {
             error_report("Failure monitoring inotify FD '%s',"
                          "disabling events", strerror(errno));
-            goto cleanup;
         }
 
         /* no more events right now */
-        goto cleanup;
+        return;
     }
 
     /* Loop over all events in the buffer */
@@ -151,9 +150,6 @@ static void qemu_file_monitor_watch(void *arg)
             }
         }
     }
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
 }
 
 
@@ -257,9 +253,8 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 {
     QFileMonitorDir *dir;
     QFileMonitorWatch watch;
-    int64_t ret = -1;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
     dir = g_hash_table_lookup(mon->dirs, dirpath);
     if (!dir) {
         int rv = inotify_add_watch(mon->fd, dirpath,
@@ -268,7 +263,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 
         if (rv < 0) {
             error_setg_errno(errp, errno, "Unable to watch '%s'", dirpath);
-            goto cleanup;
+            return -1;
         }
 
         trace_qemu_file_monitor_enable_watch(mon, dirpath, rv);
@@ -297,11 +292,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
                                       filename ? filename : "<none>",
                                       cb, opaque, watch.id);
 
-    ret = watch.id;
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
-    return ret;
+    return watch.id;
 }
 
 
@@ -312,13 +303,13 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
     QFileMonitorDir *dir;
     gsize i;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
 
     trace_qemu_file_monitor_remove_watch(mon, dirpath, id);
 
     dir = g_hash_table_lookup(mon->dirs, dirpath);
     if (!dir) {
-        goto cleanup;
+        return;
     }
 
     for (i = 0; i < dir->watches->len; i++) {
@@ -342,7 +333,4 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
             qemu_set_fd_handler(mon->fd, NULL, NULL, NULL);
         }
     }
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
 }
-- 
2.55.0


