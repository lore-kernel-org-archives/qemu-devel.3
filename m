Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BE0C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMF-0003gr-DI; Sat, 22 Aug 2026 17:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMD-0003g2-DT
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMB-0000ix-NK
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso2979938b3a.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434466; x=1788039266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHpGhiOPUZ1iwhuBAHzhClfV+0PVtkn7WRLA3fGT3o8=;
 b=SjBNMUh5ERQ1REsQc5ifgct8Y7RTy3NTnF/aPOaxJPtp8KGVbmkinSr1J939QXQcIE
 4kXagoaeU2wtpGKJXNQoBWfPBMFZDmuPQ7+vAMqzjvyMky1RJVwFCh+y2juSFoxCPElq
 MkTlrNF8KV5mqk3ow4nFN7KYjs+XHv+yvGtSW/Ec6IygdO6qLhXJFolxtU2RQCond2Db
 83jndvuuAoeaGPjhd7vgSlVHI6KsVpc/mJhaUO5V7pN0cdriNL7HL1wB6hAPmqJYjW4Q
 jzf88hB51BALuyCdTbkeHxPg25kiBs+jBtSd6xlpj4xHRJBaHXy4//EA9cbgx+53iaMW
 xpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434466; x=1788039266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHpGhiOPUZ1iwhuBAHzhClfV+0PVtkn7WRLA3fGT3o8=;
 b=XcRBtTvIkJEpO6A7psQKMP93jITujRCOdfrBh6BoIEsR6qA+dR64LKBTPwFjj4TRfb
 N8tZG7NimvLx202bFuoNQijGdWPdI94BxZ4ITuCXtggyT+8d52Jr3xsg+hQSgSm+oVdA
 tp2ypHH51PC3HHGQooQ03x5CUAOah4wk6BoOh6nAP5gPK5kfAnelPgI3imEqE2xEkNim
 XvNcjxmuSBFRTlblnoh/pG230UouXPeLJ/JGVySYQ6+hcMv0HIen9z4Frq1w3vpz+aql
 vvW9YMBrzPSQH0vAxNIgPgvlKpXkcBNmxkGtpp/G3YM/vyCoh/6DCB8mGsjTG1O7myqT
 9ixQ==
X-Gm-Message-State: AFuF++nLqSSeTkQHdIndvIgphfwDem5glg7Of8JmVBqRCyjsSPqFHfeO
 KEEdzlicXlLydjbJhR6q8CzdFJ51wrTmXKyTu0hvhxqc6Kii/FLke08/TDptD5ln5Z94GfJX
X-Gm-Gg: AR+sD10UULz9igT2HPTfMTAhuUHMUQ/sQ1+r6VN7O2V++Q904GOZulcgsuvR5q+ne0M
 p17guiK2xEKDxbUxnG1oER07Ir495RujWFW8jf2pOkBu4nVF1Ss0vnhLG16n2fl0xWoeCfvdvWj
 U+Rb5P/YUCOv3xK3xDelW9gwmO6w71Zp6h84ZHY+ADSuGV8fw1oObnP6VYsollVUfkBFCMphZ3n
 8rLiqRlRjj3NT/k+7lbYOftBr6DSjkvXZQ2GDKqSUqHY9w5oJ73Y+k616WoL3t6gdg7AcTKFGBY
 bBz17zpai6ZwRCPLcJc2fjc5P1NzmR2RmGiAFpxyqNFvRyO+9V3Nn6tGdun9WkX7jiJrHbDSuN9
 DC6vmRbG4CbwGvWoo6x0Wb5B1CbO+4U9qMkEiIwsBvegF8CyrSCjusiPVxoaxijiWrtmxZpcD0X
 DJdlKnVHGZhQ6oIx0SNFGWGVjgUyotCJnei+8qs7wNbBO7QpLM/gq7zZhRhS5Oq7zovZEdF/u2w
 UJ/F0v0
X-Received: by 2002:a05:6a20:1605:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3cd3003dc4fmr32540591637.13.1787434466108; 
 Sat, 22 Aug 2026 14:34:26 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:25 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 06/15] monitor: track IOThread users with QOM paths
Date: Sun, 23 Aug 2026 05:33:29 +0800
Message-ID: <20260822213343.661939-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Monitors that require an IOThread share the internal mon_iothread.
Account for each monitor explicitly in IOThread holder tracking, using
the monitor's canonical QOM path to distinguish holders.

Acquire the shared monitor IOThread AioContext once, using the monitor
QOM path as the holder, and reuse the stored context for later
operations.

Release the holder from the Monitor ObjectClass::unparent callback,
while the canonical QOM path is still available. This covers every
object_unparent() path and avoids duplicating the cleanup in
monitor_cleanup() and monitor_qmp_prepare_delete().

The internal mon_iothread remains hidden from query-iothreads, as before.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 33 ++++++++++++++++++++++++++++-----
 monitor/qmp.c              |  5 +++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 23829f32f9..caecceec93 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -153,6 +153,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMPClass {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index ed195fd97b..da6d18f475 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -79,6 +79,22 @@ int monitor_device_index;
 OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
                             { TYPE_USER_CREATABLE }, {});
 
+static void monitor_unparent(Object *obj)
+{
+    Monitor *mon = MONITOR(obj);
+
+    if (mon->ctx && monitor_requires_iothread(mon)) {
+        g_autofree char *path = object_get_canonical_path(obj);
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
+        mon->ctx = NULL;
+    }
+}
+
 static void monitor_finalize(Object *obj)
 {
     Monitor *mon = MONITOR(obj);
@@ -114,6 +130,8 @@ static void monitor_class_init(ObjectClass *cls, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
 
+    cls->unparent = monitor_unparent;
+
     object_class_property_add_str(cls, "chardev",
                                   monitor_get_chardev_id,
                                   monitor_set_chardev_id);
@@ -573,7 +591,7 @@ void monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -713,7 +731,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -732,11 +749,17 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             mon_iothread = iothread_create("mon_iothread", &error_abort);
         }
 
-        ctx = iothread_get_aio_context(mon_iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
     } else {
-        ctx = qemu_get_aio_context();
+        mon->ctx = qemu_get_aio_context();
     }
-    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 338d37cb7e..cf1c8644cd 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -733,7 +733,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -788,7 +789,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 
     /* Synchronize with in-flight iothread callbacks. */
     if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.55.0


