Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590E2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aJ-0002Tp-Ba; Tue, 07 Jul 2026 07:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a8-0002Nk-JQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a4-00085o-VS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnP0OjG1TUfvou1s1pdSnXAjEZZ8105l2EBnreA/QEw=;
 b=K3P4mmXRJ4V5CitBgHfwVlOfODjG5gb5Xr5V8EWRUGnUYUAzpHJMF7YRlpnGV0HDCIwZM6
 ZC0dV2+PszJqerPXdcpzI+ZZH0/iwDmzd1TRsUBh1guqF08iZanlpf51YPCj96yu3F6SQF
 JvrrhpQdXGlaQ5622UmU9Vpaxxn5Oj0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-opXV4OhkNaG6JE7pP0FLfw-1; Tue,
 07 Jul 2026 07:03:10 -0400
X-MC-Unique: opXV4OhkNaG6JE7pP0FLfw-1
X-Mimecast-MFC-AGG-ID: opXV4OhkNaG6JE7pP0FLfw_1783422189
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16F01954B1E; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5917618005BB; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 024E421E61A9; Tue, 07 Jul 2026 13:03:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 24/35] monitor: convert from oneshot BH to persistent BH
Date: Tue,  7 Jul 2026 13:02:49 +0200
Message-ID: <20260707110300.1918153-25-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Christian Brauner <brauner@kernel.org>

Convert monitor_accept_input from a oneshot BH (aio_bh_schedule_oneshot)
to a persistent BH (aio_bh_new + qemu_bh_schedule).  Oneshot BHs cannot
be cancelled, so monitor_resume() racing with destruction would schedule
a callback against memory that monitor_qmp_destroy() is about to free.
A persistent BH can be deleted during destruction, cancelling any
pending schedule.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[DB: extracted oneshot BH conversion from larger commit]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-25-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor-internal.h |  2 +-
 monitor/monitor.c          | 25 ++++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 012d442a20..a82e1aacb6 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -134,7 +134,7 @@ struct Monitor {
     char *chardev_id;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
-
+    QEMUBH *accept_input_bh;    /* persistent BH for monitor_accept_input */
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f0ca6b04ed..de1f761041 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -83,6 +83,9 @@ static void monitor_finalize(Object *obj)
 {
     Monitor *mon = MONITOR(obj);
 
+    if (mon->accept_input_bh) {
+        qemu_bh_delete(mon->accept_input_bh);
+    }
     g_free(mon->chardev_id);
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
@@ -569,15 +572,7 @@ static void monitor_accept_input(void *opaque)
 void monitor_resume(Monitor *mon)
 {
     if (qatomic_dec_fetch(&mon->suspend_cnt) == 0) {
-        AioContext *ctx;
-
-        if (monitor_requires_iothread(mon)) {
-            ctx = iothread_get_aio_context(mon_iothread);
-        } else {
-            ctx = qemu_get_aio_context();
-        }
-
-        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
+        qemu_bh_schedule(mon->accept_input_bh);
     }
 
     trace_monitor_suspend(mon, -1);
@@ -700,6 +695,7 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
+    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -713,9 +709,16 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
         }
     }
 
-    if (monitor_requires_iothread(mon) && !mon_iothread) {
-        mon_iothread = iothread_create("mon_iothread", &error_abort);
+    if (monitor_requires_iothread(mon)) {
+        if (!mon_iothread) {
+            mon_iothread = iothread_create("mon_iothread", &error_abort);
+        }
+
+        ctx = iothread_get_aio_context(mon_iothread);
+    } else {
+        ctx = qemu_get_aio_context();
     }
+    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
-- 
2.54.0


