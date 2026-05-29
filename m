Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605E7CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4r1-0003Vc-Dg; Fri, 29 May 2026 17:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qN-0003Kj-Uo
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qK-0002ua-Qy
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-835386ff122so14141223b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090451; x=1780695251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nS1LvrZ7n9H4oE7uk6w8jMnvHpLvuOluAYzP0hc31/8=;
 b=eYUGgB7oJ/iTqEzJrgIsqV4n5J8ACrUnM0y4CaJaEkUQnQ4FRZcyY68s0XO7oPpyvR
 MdzCEPsSVRGfdi0euebdLG+mKnmViIFKm1u0dv1hkDzMiQl0wAPdf8RSNl22SDMgcvAo
 4OxnUj8P3EGq1O+4xX2peybZgrpSnZc47gMTCe46kDhKYhQrRUUpP8bBkxleI9qYEszW
 eEluJXjfdVWMMonrEg9EcKoDfDAFBT+9QUrZcR5Nos/iwBlXc3snhgo/RYNsOZrfne73
 TyIrkKmAjv/820aoKCWYi5Kj/ZXbLQah8OFwqHFr9UrOr2QDh0Aw6f4RNj8xm+evCczx
 OQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090451; x=1780695251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nS1LvrZ7n9H4oE7uk6w8jMnvHpLvuOluAYzP0hc31/8=;
 b=U/frzoLDmrWo4XtZ1mRCudN2W4wn5IIXD6g1dgywBfohLRqvCh/UDk/cxxbFGquoAc
 s13QB11gAg6p4c96ubwrKu/+jcN/0rop04HxtMjWbi8Una4IMSg+0lfGe4qwMRda26sU
 KBfoXPfGAVFo96cm9WY2Qd49dbE8bHM6pGl+OBM37j6HH5IXimFOB4xOuCHfAafPwhtv
 gd9V50fg29OFYDR2fYkrcgS9VO4Cq2CTzCp2B0BIWhtL2NGfxIXowS7i+iLHbd/zSgXL
 n1Gv0o636VbzqB4wa75OaMOUrVFYrQgIbJdo6yL08rmL2tjeygyic94fmB5QS1ZRCjsq
 mgnw==
X-Gm-Message-State: AOJu0YyRrnN9NwO5JXVn6jgWdVVfPQdSj2s2yjXXhpkqFAj3suALY8tm
 CxwR59p2e6rE7K51PQhMSL/OloMZq9tzGehQRPg0bOfWTbX7RmY3o0vSEODjjdcup/Y=
X-Gm-Gg: Acq92OFTmnU7okrg4Mkc9/bLHWyg5tbz3HxEjMe/jofLKmHP+Fcf7Sqvik8Q671jpQk
 3VifCfVTMlHMBfmL3591N3i/5OrGYOe2aTIOYR6URW6OkXsrb0zXPbS4UTWTCvg3XxkJ743FFZ4
 P9hu0HGoAShTAAUZsjesBCmlIhTJHs6wM1fejeOoMJoozkAKIfDCga1Htv3Rox4Bzm3zcf9x7Pw
 iVL9T6vWR5R1GMqQ3tH1ziJGAxWE474Wh3RJPeFOznXjaJ9yg+nQ0ifTnF6BfQ9b003Z/X2kdyg
 +4GOi0OLW+9cQq/vUtp109WSj9i+MttVIqlxB24DC4kIn93tg7welvuKZOYyRK31mnNFTJpcR7i
 rZBu7YWDFTGJeezDlDLFoaxf8PodIn0GLRoMUEZnpLRxSc1CHuNVumgDQ7g5hm6xm0An6M8gB+P
 AcPZuJJIyTQP6Ey557cjPtlC+9ERWvKe9XNYa1y9Vqs+qEXS0CRDHxpYLaA/12ec4=
X-Received: by 2002:a05:6a00:8e09:b0:841:a0c8:71af with SMTP id
 d2e1a72fcca58-8422543d739mr1156867b3a.30.1780090451554; 
 Fri, 29 May 2026 14:34:11 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:11 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 07/15] monitor: Update tracking iothread users with holder
Date: Sat, 30 May 2026 05:33:13 +0800
Message-ID: <20260529213321.96271-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x431.google.com
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

Based on monitor ID tracking iothread users with holder.
Introduce the AioContext in the Monitor struct to avoid repeated calls to
iothread_get_aio_context() and ensure symmetrical ref/unref during
monitor lifecycle.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 20 ++++++++++++++++++--
 monitor/qmp.c              |  3 ++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 2060311b03..92d7630921 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -127,6 +127,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMP {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index dafb4ad8b0..7eec6f967d 100644
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
@@ -612,6 +612,12 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
+
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
+            .u.monitor_name.monitor_name = (char *)mon->id,
+        };
+        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &holder);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
@@ -631,6 +637,16 @@ void monitor_data_destroy(Monitor *mon)
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->ctx && mon_iothread) {
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
+            .u.monitor_name.monitor_name = (char *)mon->id,
+        };
+
+        iothread_put_aio_context(mon_iothread, &holder);
+        mon->ctx = NULL;
+    }
 }
 
 void monitor_cleanup(void)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index b210850a15..b67674aef3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -565,7 +565,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
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


