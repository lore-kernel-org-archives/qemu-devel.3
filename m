Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C79FC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjrq-0004Ik-G2; Mon, 06 Jul 2026 10:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjro-00048o-Oz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjrn-0002Br-18
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKaf1G62jkNrohllvF71Q/jzAmAi/tWYP5jrT7rBBJ0=;
 b=HhErrFF7UEj7Lg6BkrR3E3zJeYhHI1RLw1sIKLKhOey4+7kaznrQUAdMWcgrsGLoO1fhfk
 L+wEMIqY0Ku3ArbZO3ZS2XG0JDygVM/tVirTexo90lxlSzRwJdrgdMcS7LFZQFuHVrBdgg
 ddonXB6/0HivXYzFDmL87NvzDfr7Mac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-TDNayGcfPe-tkgnX-KhfOw-1; Mon,
 06 Jul 2026 10:00:06 -0400
X-MC-Unique: TDNayGcfPe-tkgnX-KhfOw-1
X-Mimecast-MFC-AGG-ID: TDNayGcfPe-tkgnX-KhfOw_1783346405
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EDFD18052FE; Mon,  6 Jul 2026 14:00:05 +0000 (UTC)
Received: from berrange.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C37A3000B4D; Mon,  6 Jul 2026 14:00:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v7 24/35] monitor: convert from oneshot BH to persistent BH
Date: Mon,  6 Jul 2026 14:58:12 +0100
Message-ID: <20260706135824.2623960-25-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-1-berrange@redhat.com>
References: <20260706135824.2623960-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
2.55.0


