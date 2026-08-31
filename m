Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB16C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14Ry-0002MF-6e; Mon, 31 Aug 2026 12:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Rw-0002GZ-LB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:32 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Ru-0001ZP-AN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:32 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so63549a91.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192089; x=1788796889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4rfb6Jbonhaou1RoYtf8O259hLggyyPStAvNjAohNW8=;
 b=jMdHhjhTR6X0/YVIuckXF/f9PDTgSvkckcnvb1Q4aO9S9PuCxaZCosZteTkYIfai8U
 UHeCdHt0rr+RxdFfMuGNZkukiiqSdefmlbfCuQYZzBbEuJDwSyvg1ZUL1tD5ihQKAeW7
 hA97gAu3HudEVqCJQPtvzh+RgTcjrLd5WX8a37g55vrXBusy+C+yIcpQZ364R9HOMaUC
 cxLvwKfxXUGLKHwrNBHRE5RPOQpLjymX0ktlHPE0znIm1gxYM7VOTkEAvidn64nfCb1Z
 /KYFvybh/I7cijs28ziXZNNj8ZFZUgYWKQTXjp9mfG/vIVm7fjwBwZV2gNittbJigxYz
 cgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192089; x=1788796889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4rfb6Jbonhaou1RoYtf8O259hLggyyPStAvNjAohNW8=;
 b=SVF8qHreU+8193eplvWXo6u9KKwXsUAMPKFolRdGXG4lCZV8+HbQ8tY24DuMok+6Qf
 NzEtoTZfrgyysn1cYsnS4beHnQAgpIjVmlDL/+2m0GISHpeWecDFE3KO7dp181FYmcXj
 VcGAX6Ey5yq8NmmvukwdeXveQrPeGnkX64ZDsz0DGAivZMdbvFGjKvMfFNGZ7YP1K5Y9
 Z/KLa+0lWANFEzHXFAqLJOoeQ3ggOBqQ67/aL9mkySJVPGgzEJG1tydOFodlK11v9YFe
 4GIVToTlSjOkyppq4VYSiIVoOOIPmnSIMz4CwZfPVWWgV/tp23KpZmN7WyJqzQKctX9t
 Ed1A==
X-Gm-Message-State: AFuF++m8M8szhSFUyYZM81D4KreqRedwEWkiU/8U5Cwipt3bcar5QWpl
 nQZ1c9urd/1OtQUDKfS9CNoge3w/8Am5YPe+XQzVkn8ZN1B5RKlbqM5RDkZU4Wrc9L+Xx00z
X-Gm-Gg: AYBFou2fgqds8zZqASs8sMlXMTHtq+p0kSuLJu55c/btRkdOJAj5pNGqkj8OzMrR7cP
 Kay5+ZkhRNHw5LT4Axny4I0ErIV64YE1M5z7rR0Bmy56F3Qw0uFC09uce5VScp4+PwMpX7ny3OV
 PHkukWvWuD9tpB4GgCMO+uENTL1Shb0bylgOjFp57hUdVp3FkS3qnrJ28u8WrKT3j0jgUboBG7k
 MwmFrsKG/N9aFci3xg46x3n026luWhE2px91MATVubNNTeFEh8Mn+CvQBZyxKooS4SPi0bsi6BO
 l+lGkNZDs6p4mIxHZNf+jsQzVa+oZ2kPfdbRdAKrNdBQz4Kq6yrbtkc0wMFUwXmnpyeNdIFAKjC
 Tc2GfMJy8YuTIy3UnIf7QWI1PWIE4xMsozdtCOEH38tGlF5KOq1h4+8IvivcCaBEPc5wghDx2Qp
 o7HiWiAm0piMe07KCNb8CXQ7nML+YJ/mG0GtFpDaZtSUx9xIB2A74j05agclwb+BjX4rUzQAFet
 vDpgLE9
X-Received: by 2002:a17:90b:4a04:b0:398:9beb:a2ba with SMTP id
 98e67ed59e1d1-398da8cc72fmr7852072a91.28.1788192088488; 
 Mon, 31 Aug 2026 09:01:28 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:27 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
Date: Tue,  1 Sep 2026 00:00:27 +0800
Message-ID: <20260831160038.221776-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1033.google.com
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
Management applications therefore cannot use it to determine which
monitors are using the IOThread. Nevertheless, track the monitor
holders so that they follow the same explicit holder and
IOThread reference lifecycle as other AioContext users.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 33 ++++++++++++++++++++++++++++-----
 monitor/qmp.c              |  5 +++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index e0a124a317..74ea15c85f 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -154,6 +154,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMPClass {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6af09f2f6e..9e3b639eff 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -81,6 +81,22 @@ int monitor_device_index;
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
@@ -116,6 +132,8 @@ static void monitor_class_init(ObjectClass *cls, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
 
+    cls->unparent = monitor_unparent;
+
     object_class_property_add_str(cls, "chardev",
                                   monitor_get_chardev_id,
                                   monitor_set_chardev_id);
@@ -575,7 +593,7 @@ void monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -715,7 +733,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -734,11 +751,17 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
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
index aec0315775..de56345456 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -734,7 +734,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -789,7 +790,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 
     /* Synchronize with in-flight iothread callbacks. */
     if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.55.0


