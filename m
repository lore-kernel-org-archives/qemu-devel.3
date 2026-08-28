Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0DEC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03PH-0005MR-NR; Fri, 28 Aug 2026 16:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PG-0005HS-R3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PE-00083L-Oi
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4vRxHw1f7w9+JM1uvJJ31mv7W/rLbq3B/JcPH5Qy+A=;
 b=H+62i8ADJjcOaYng++yE5KCPe5i1U5VP/WHDBGL/MLlKrTe38npJhgoKtRj/F6Snacvacu
 yY/USnUou5IA8yaYEXuUyLu6/tUrYxyDIprL4Hgjweoc/vorfiNUMbYO5YEokX/gbkop4Q
 pivwuWAkIX002+Rd4je7iVPvPJwKo7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-p2cruWQ0OZWusd2KYuLwMQ-1; Fri,
 28 Aug 2026 16:42:30 -0400
X-MC-Unique: p2cruWQ0OZWusd2KYuLwMQ-1
X-Mimecast-MFC-AGG-ID: p2cruWQ0OZWusd2KYuLwMQ_1787949749
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4B42186A704; Fri, 28 Aug 2026 20:42:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C566E7DB; Fri, 28 Aug 2026 20:42:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:47 +0400
Subject: [GIT PULL 08/50] monitor: move HMP-only fields from Monitor to
 MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-8-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5220;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eRw064TvaxJ/wCeq9d5NMAjc/qrQbnLW4m+gAGzVtxg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKTw/j2Dn8mzMxy2GxwXPhem3bLGybbfRlf+
 vFp5kPycS6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5apSD/4lTjCk/hxVC66Ri76mcQglFkZ457LhhQF2XODAK7kD87rjNVoYV1lplxoLdrMDKy5PjF2
 +sGbbyg791j0/Am0u2Pnl+nOl1STxP8qTUxULjF2RhS3ChKWsXDj3hpgsqy/+p3LsCAR2mNyu6k
 cqKzTfh6HyScsOgqDJaPcw7InAiFPgKCUOfEEWsGS+5QYPr+3pequSKyrUht90fGGzV7uZxnqRN
 kk3LRql5JCVbYh2W/fHB4D/ycJ3tKO7wF8GNYpr2eTWkrRLMZEvGTdsSI7Z8ncpfkoknBclrZUz
 fyyTBLCRt9oGDc+dS4rVw/C6parpzMLSDvwSISyR1N2X3kfQDAqa15xBmzJXlCrk189wjlQeX2P
 zAEeRlPNsEaQXktu9tvhUHRgLygLYgwFhP1qWmbLKASMOYnK0MvjzlhbICthBQ7Xbeya5KZ+/6Z
 1p1MvBVBfwatDJCXDMh5Lni6Mq+YlufYMe/uQ/heFGETYoV0UuSNEGzZwN1rkLwFUCaoJELZNl5
 wH8G1sKSgc9VhhlEqcB3V8L/WCE0n5opSZMJNvajKBsvQKke28TN40xyXiaxjoJC9qm6jDfxpl+
 A+4NtlBGAbuC4EUQrgzBd7rZftWkJnA6zjgA0xd+2FPa9ELs2NU+0ejuU2fE2hM/sciWQlY2bYj
 OTZ9G7WQJ6JKHcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

mon_cpu_path and reset_seen are only used by HMP monitors; move them
from the base Monitor struct into MonitorHMP to properly encapsulate
HMP-specific state.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-8-9227de146347@redhat.com>
---
 monitor/hmp-cmds.c         | 16 +++++++++-------
 monitor/hmp.c              |  9 +++++----
 monitor/monitor-internal.h |  4 ++--
 monitor/monitor.c          |  1 -
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 6b1114fdaf13..7c3fedb91936 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
 {
+    MonitorHMP *hmp = MONITOR_HMP(mon);
     CPUState *cpu;
 
     cpu = qemu_get_cpu(cpu_index);
     if (cpu == NULL) {
         return -1;
     }
-    g_free(mon->mon_cpu_path);
-    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    g_free(hmp->mon_cpu_path);
+    hmp->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
 /* Callers must hold BQL. */
 static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
 {
+    MonitorHMP *hmp = MONITOR_HMP(mon);
     CPUState *cpu = NULL;
 
-    if (mon->mon_cpu_path) {
-        cpu = (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
+    if (hmp->mon_cpu_path) {
+        cpu = (CPUState *) object_resolve_path_type(hmp->mon_cpu_path,
                                                     TYPE_CPU, NULL);
         if (!cpu) {
-            g_free(mon->mon_cpu_path);
-            mon->mon_cpu_path = NULL;
+            g_free(hmp->mon_cpu_path);
+            hmp->mon_cpu_path = NULL;
         }
     }
-    if (!mon->mon_cpu_path) {
+    if (!hmp->mon_cpu_path) {
         if (!first_cpu) {
             return NULL;
         }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 22b1972d346a..8134dfaad4bb 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -50,6 +50,7 @@ OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
 static void monitor_hmp_finalize(Object *obj)
 {
     MonitorHMP *hmp = MONITOR_HMP(obj);
+    g_free(hmp->mon_cpu_path);
     if (hmp->rs) {
         readline_free(hmp->rs);
     }
@@ -112,8 +113,8 @@ int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
 static void monitor_hmp_accept_input(Monitor *mon)
 {
     qemu_mutex_lock(&mon->mon_lock);
-    if (mon->reset_seen) {
-        MonitorHMP *hmp = MONITOR_HMP(mon);
+    MonitorHMP *hmp = MONITOR_HMP(mon);
+    if (hmp->reset_seen) {
         assert(hmp->rs);
         readline_restart(hmp->rs);
         qemu_chr_fe_accept_input(&mon->chr);
@@ -1556,7 +1557,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_MUX_OUT:
         qemu_mutex_lock(&mon->mon_lock);
         if (!mon->mux_out) {
-            if (mon->reset_seen && !mon->suspend_cnt) {
+            if (hmp->reset_seen && !mon->suspend_cnt) {
                 monitor_puts_locked(mon, "\n");
             } else {
                 monitor_flush_locked(mon);
@@ -1573,7 +1574,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
         monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
                        "information\n", QEMU_VERSION);
         qemu_mutex_lock(&mon->mon_lock);
-        mon->reset_seen = 1;
+        hmp->reset_seen = 1;
         if (!mon->mux_out && hmp->use_readline) {
             /* Suspend-resume forces the prompt to be printed.  */
             monitor_suspend(mon);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index e0a124a317a5..fdeeeb853636 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -137,7 +137,6 @@ struct Monitor {
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     QEMUBH *accept_input_bh;    /* persistent BH for monitor_accept_input */
-    char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
     /*
@@ -153,7 +152,6 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
-    int reset_seen;
 };
 
 struct MonitorHMPClass {
@@ -170,6 +168,8 @@ struct MonitorHMP {
      * These members can be safely accessed without locks.
      */
     ReadLineState *rs;
+    char *mon_cpu_path;
+    int reset_seen;
 };
 
 struct MonitorQMPClass {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6af09f2f6eac..6d6ffbb0f78a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -89,7 +89,6 @@ static void monitor_finalize(Object *obj)
         qemu_bh_delete(mon->accept_input_bh);
     }
     g_free(mon->chardev_id);
-    g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);

-- 
2.55.0.543.g5ebe2ebe4ea8


