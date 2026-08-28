Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198A0C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvKd-0006IN-Db; Fri, 28 Aug 2026 08:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKc-0006E4-8G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKa-0002CJ-CE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgVXjIktWQs+7RIV0i2EECvCzm4GRSpv4wuD81wPrwo=;
 b=d1GEuWdIhQNHnsrEW3V/RdD0FRcfC65lFntraDiEn1d/69IIzCA7mB5Q0PLx8wSe/CZU2r
 QwWtYFt95Tm72H3a51cC9+PTkfDXWwTLwcl0BCXOIxuFJgjCtcSlmHVaV8OXhrPMtW5jdt
 GG1YZtWBZ7f4P5AAMBBKbFtr6KcFb44=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-JOxBt-6lPkSYwPU1zQ8jmQ-1; Fri,
 28 Aug 2026 08:05:08 -0400
X-MC-Unique: JOxBt-6lPkSYwPU1zQ8jmQ-1
X-Mimecast-MFC-AGG-ID: JOxBt-6lPkSYwPU1zQ8jmQ_1787918707
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A485190A08E; Fri, 28 Aug 2026 12:05:07 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 616481803A44; Fri, 28 Aug 2026 12:05:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:05 +0400
Subject: [PATCH v5 08/50] monitor: move HMP-only fields from Monitor to
 MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-8-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5155;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pv7Vg838YUjD9TJrTH+7iMTCzBq9QBVL/1+jvNRYVuE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4mC2ZXD6m7CHmbt9CUJdjWG57HZNzfPxbq
 5XBPCLetS+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5UazEAC3xyubkrOQm6GcQh6Zu7VXcSwf3AAjqVO39i1BcBevMeh6OjrVfDPoGkDmhjMlAvWTmE6
 yKF62lJdieie3f57A2tt43DI+dekPXvbsi6fOVVwY9ZPOqOUgLrjRg+4rG7NRkgr06MlZw4wrhG
 hkKsiB1VQTfo2aeaqpmTfPVRQcrXNNe0SLRnT35E+FPPmEWXK+sywQJiiYUIpUvNcTwHbhj3PIV
 EzdHanFE2a8Gy/Rj2XwMHmN8Jo/QqFDDn1dC+JqMI+byAqPU8qziNa4qlDIH0Vcsi7AsMAncPN/
 qJ45FA4JZvpb9eALUUdYS3RV4B1FnAuYirqya+PxxllPPIFnbV6chBBMGMbwCGuFOQ8ExZBqBpN
 BFif6KVMEr+G7wvp4UaH4GALRu45L6l4cgVQ8+rSbr5JVqNyMITHeKsyWS8e/wZ0sDf8QsIc4dv
 qHcRRNdkb525kNO0tO1NLqYB4n+ClnmnV1boeb9x+5yA4AEm4vCNoMYnvOzKlQksNQERohm6JK6
 kiaI4b7bsfseH3EHBKKWiU/VqqYW9C1yLRcgxX2uZEW8EZ9Jb41v9EiiSkkGtfD4gRRy9lGirrr
 CwVJ7Vvt3rh0CIpq0qPNwzToeGU4KiOwDaMlYpawjooBNJE1UZPKCo0gWfduRWKhVTH6IO5PWle
 M2Ya6Mw3z+cZEGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

mon_cpu_path and reset_seen are only used by HMP monitors; move them
from the base Monitor struct into MonitorHMP to properly encapsulate
HMP-specific state.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


