Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A0C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXj-0004Ps-No; Tue, 25 Aug 2026 15:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXh-0004PB-Mn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXf-0003ur-2O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJQnMGT3qPvOFeMDZSH+QYBFaicXbP9+52KZazx/GNM=;
 b=BqqgedndZhsGSVSl5KCt7r+Lfzy4Es1B4S5yOOy60Pw43qGyeRVlsIeUTqJQl+DcIh2twj
 Neu9J8+yvukB0IHuta0SzAOihuVCzg2Vrr6ijKAYpmScr+o9ZCijhBFstoyKpXsU06hfB7
 oRJ0d5F/OuaZkj2pmOX28A9TRz7BSMw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-M7Tt8VRkMp6u_Zz3kGL2gw-1; Tue,
 25 Aug 2026 15:10:36 -0400
X-MC-Unique: M7Tt8VRkMp6u_Zz3kGL2gw-1
X-Mimecast-MFC-AGG-ID: M7Tt8VRkMp6u_Zz3kGL2gw_1787685035
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CEA4180ABF2; Tue, 25 Aug 2026 19:10:35 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D9111955F0C; Tue, 25 Aug 2026 19:10:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:15 +0400
Subject: [PATCH v4 08/49] monitor: move HMP-only fields from Monitor to
 MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-8-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5135;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wkR8gnQD/9TIbnh3sLfGrwv66uEiNuUKUoUzahWjols=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHW9bgozZOKp658cep5S+/NfAISYTuSvzkh
 NkkKi260a6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5RnfEACgOPNYrywtU0V/PgMB1PvpluQageznAjjGEo3qpfrdyOAWqS7WYkaDi+DP5NCtqzW/yuF
 AjrxjeTzUNydEnBqzBwksoaRmXErinBrcj+uUjqWtdyVXrYxvRGAB+0AyDvA8cyZ1ZWbDb0eHg3
 4vCaBmZHZ/uY4P+OwnP/kbktDm8IefMiQ8BacS+PE+uVPgiVH0xHESZEWGLlW6GLQPk8POGWjS5
 8+BS3Tm4xCnzAMcajLyMfOC0OsGuT5yVXyqQmEL/WJoft5W1qeBaWsoaUEPyKhP73+1gB5L2mlm
 QWS/NrPe5laRVTMNM4Pn/+m/CQSsSpgRxrFOf40dW02hUxzEPchZRwx/Tn2d4SFrKIL0aw7WJGP
 AiEpw+dzOg38EWTza31t+yyPQZKajFivQVwqRk13c7XqtI+THKSNnYwT1EUH4SPMlEoMYLsBea1
 5IPDptbuTJRfLJqfcdU4Inzw+cMKp+iHFyL2AOjVvM3m5oHm0OtatBTsvt3czKmrjDcR0HBC2jz
 67Zi4MhWhsLxHp8Me8784vqrfOUYYcJyr+zqNMGuars0j61TXqCX1iquTi8WAf/Llv7Izp3wlNO
 NTN+m7+znIr9BhuwR+cDEOe1OTLQH+z6b5r8EGM6yZXcMW4UZQkIiQMGJwt2tBsB384j6T8lWDZ
 z8IINld/7m99KdA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

mon_cpu_path and reset_seen are only used by HMP monitors; move them
from the base Monitor struct into MonitorHMP to properly encapsulate
HMP-specific state.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/hmp-cmds.c         | 16 +++++++++-------
 monitor/hmp.c              |  9 +++++----
 monitor/monitor-internal.h |  4 ++--
 monitor/monitor.c          |  1 -
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 6b1114fdaf13..6718fec97047 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
 {
+    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
     CPUState *cpu;
 
     cpu = qemu_get_cpu(cpu_index);
     if (cpu == NULL) {
         return -1;
     }
-    g_free(mon->mon_cpu_path);
-    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    g_free(hmp_mon->mon_cpu_path);
+    hmp_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
 /* Callers must hold BQL. */
 static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
 {
+    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
     CPUState *cpu = NULL;
 
-    if (mon->mon_cpu_path) {
-        cpu = (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
+    if (hmp_mon->mon_cpu_path) {
+        cpu = (CPUState *) object_resolve_path_type(hmp_mon->mon_cpu_path,
                                                     TYPE_CPU, NULL);
         if (!cpu) {
-            g_free(mon->mon_cpu_path);
-            mon->mon_cpu_path = NULL;
+            g_free(hmp_mon->mon_cpu_path);
+            hmp_mon->mon_cpu_path = NULL;
         }
     }
-    if (!mon->mon_cpu_path) {
+    if (!hmp_mon->mon_cpu_path) {
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


