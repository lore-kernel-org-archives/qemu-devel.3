Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29939CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHe-0003RL-9o; Mon, 11 May 2026 10:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG4-0000Ps-KK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFz-0007Ce-V7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so39835625ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508307; x=1779113107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgP4NvXflcioWVWaM/x7kgPS9jjy07btsZQtNOLI1OY=;
 b=TtwxvkVv3raIBrpnYiMDdFEueNEH4IOUldM79hi6rZfndl4ELbuMOzewpeH1q4+Nco
 05wRyIqxTriVXAnOH1DODvdHahSP5SzFG1wSfapNKPjHWnjnkXfSpizUoZd3PZQ3UNO9
 X5mrBmWEFosfM4kz/z9xpShyeBQie1kfXvFC0q2a31sLdfkZT0tV6TYuR+OCxflDoOFo
 53kJCeqR5LTV6sbPeIFpcLJrzwzz49PiTtbf2364QCdJynVQsrvG3AEFJyfKZFsE/nnw
 GVmn5Q5EcHQ4aut0cPs5oSfKn4SXL0hFmmdbs5HVokUmn611pWW0v2IUVzgY8e+JF6bS
 tpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508307; x=1779113107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GgP4NvXflcioWVWaM/x7kgPS9jjy07btsZQtNOLI1OY=;
 b=me22qEMGEYCStoa+9DTrpH0JDesoXV2p6JdfLfyLlHTX9nB7H27X314PZ7S10iUHxi
 JZWCRMMaFLvxx4EcVbg6yo/xYGXfSMViiO5JpLY0k4BwtWtx87mNgDwubg+EDrgki+2B
 FURHeMdsIngZlzpVpeWyYoNPo9sTTIWT7Ae04b4Q327/Tjq/dJ6moE02Eik750FohpQ4
 m3g+YCof39QbuZ9ndapVi/aOabAqecfJplXG2EPaT6gYFsvLbZMSyh0AAsXRsSbD61G3
 IUDSFN4MQZ1VI50fy0QgoodI7hOEKqHfqpu/ipsgi/a2BLe+3peV2NjhWyG4MWfklxoz
 kZkg==
X-Gm-Message-State: AOJu0YyH1hWAIvt1Ry/TCDoVQM/gk/+TJZ6diz4XPhR8Hk5A7/K/tH2+
 +Eg3cHDnP8sHr43uMzIHo8iqHPLHAKjvNv/Gc0yGdIpGEfAom//qUxYAfpY5NEAyRRM=
X-Gm-Gg: Acq92OEKe3WnTtZp0KoKvohUtQ6apxghe8FU+FGySZdvhgQyG5Ig72GtzFKNMvKfsJm
 oveqgQfkPDLYprAKRUk0mGZ3HlVeDz6cXDUTDIvwxqcHQ108D7q1MYn+sLXmtUsNZHIdUGhvvTq
 U0HOKu3dKMAs+NLZii57Sy3P4vu90vRfaQc0wy9WOYxcfeIrUriAdEjzm3flqx+9P6P3GdsyZBA
 gShHvOfOzHbVCAK+b/tjzR2XDINwjvmEvFmtv9Xo6cYu1k2G6yBHIGm82PgodGFesiSdCKfGMif
 yIEPvWkhr6QnyNcFlZzLdlRMPol/JnfZR9C4e7ADa/R7cTtLYTfwzrmeGP5cTKx8gwYdUnrD6Lc
 lQHdwej9IeIpqZ2TqHesqHW8sRuGu763sBaNwpOd2kT+IvHuNnmTBwPaMgx5bsqzzijK3+UqMje
 aBFoNMp4Y8Hb/s2iBYvQanpb6PNdQVJfZNUEHsvqlCq1Ug0WVwrHEHlvn7
X-Received: by 2002:a17:902:b585:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2ba7a323e95mr186909865ad.39.1778508305836; 
 Mon, 11 May 2026 07:05:05 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:05 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 06/14] monitor: Update tracking iothread users with holder
 name
Date: Mon, 11 May 2026 22:04:08 +0800
Message-ID: <20260511140416.28271-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the Monitor struct is not a QOM Object, we cannot use
object_get_canonical_path(). Instead, this patch uses the monitor's
name (or a default type-based name) as the holder identifier like QOM
Object.

Because Daniel Berrangé's "[PATCH RFC 00/17] monitor: turn QMP and HMP into
QOM objects" under review, when that series gets merged, the kind monitor
can go away. Current patch assume the monitor already been a QOM Object
in IOthread. Will keep looking at Daniel Berrangé's patch about monitor
QOM in case any future changes needed here.

Cache the AioContext in the Monitor struct to avoid repeated calls to
iothread_get_aio_context() and ensure symmetrical ref/unref during
monitor lifecycle.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 24 ++++++++++++++++++++++--
 monitor/qmp.c              |  3 ++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a5c4aba306..3e2c141c27 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -125,6 +125,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMP {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..b6efe776d6 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
         AioContext *ctx;
 
         if (mon->use_io_thread) {
-            ctx = iothread_get_aio_context(mon_iothread);
+            ctx = mon->ctx;
         } else {
             ctx = qemu_get_aio_context();
         }
@@ -612,6 +612,18 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
+        /*
+         * Because of current Monitor is not a QOM Object,
+         * so using OBJECT(mon) is undefined behavior and may crash.
+         * Try using a hard-coded future implementation of the qom path instead.
+         * (Like the name of the "mon_iothread").
+         * long-term solution would be making Monitor QOM, after that change
+         * here to:
+         * g_autofree path = object_get_canonical_path(OBJECT(mon));
+         */
+        g_autofree char *path = g_strdup(is_qmp ? "/monitor/qmp_mon0" :
+                                                  "/monitor/hmp_mon0");
+        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, path);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
@@ -631,6 +643,14 @@ void monitor_data_destroy(Monitor *mon)
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->ctx && mon_iothread) {
+        g_autofree char *path = g_strdup(monitor_is_qmp(mon) ?
+                                        "/monitor/qmp_mon0" :
+                                        "/monitor/hmp_mon0");
+        iothread_put_aio_context(mon_iothread, path);
+        mon->ctx = NULL;
+    }
 }
 
 void monitor_cleanup(void)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..8e4a775fac 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -549,7 +549,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        Monitor *mon_p = &mon->common;
+        aio_bh_schedule_oneshot(mon_p->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-- 
2.49.0


