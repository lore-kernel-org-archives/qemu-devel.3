Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B020CDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrV1-0007wm-NA; Thu, 25 Jun 2026 17:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUz-0007kh-2G
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUw-0003cM-H9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMyb34RvpzoZGbFF9JAsKhfXa/yG+uXFI7y0vzHVKyw=;
 b=gDuXywyqu0njuBoldlWojXhpFSy8VpvAdVGyZxTsVoAEAVIaDhYFJABeP7nGzKJPOcvuMd
 Kyix4/xFdwkgJZwhicKruaf3l/CT+1sSausAyiaLzpFgUXQ7mDaRk5BBVygYTo6VIoFkc8
 pEFHRW6APhQdArXE+zNlBdXjYSWeiCw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-E59a4dRsNLKQ2KXIDvtFfg-1; Thu,
 25 Jun 2026 17:20:27 -0400
X-MC-Unique: E59a4dRsNLKQ2KXIDvtFfg-1
X-Mimecast-MFC-AGG-ID: E59a4dRsNLKQ2KXIDvtFfg_1782422427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E66EA1800639; Thu, 25 Jun 2026 21:20:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1210195608D; Thu, 25 Jun 2026 21:20:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:11 +0400
Subject: [PATCH v2 10/39] monitor: move HMP-only fields from Monitor to
 MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-10-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5734;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4vPwJLShkp9ORZeOYZ/tYvZiuQ1L55Jxsk+IAj+rfxY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcfoRmpHQYbJkZfFddv8K1vq0Pj0ljy6TmW
 PDQQNASA8WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5dZ0EACAnK9r7vHy346uLb4vBkWVgfx4Yjp82aq7gxvtm42rMUBnezHQl7EqD3vzmCiGVQ0xej+
 /bFts7SAd84d4HZzwDAaGoUU2mYnu77q43vrtH3GrEHlGun1AqQEzeYNDT0G4TIFEOHUyYnCjZp
 IMRAvM30WVBUtMSsnRnlxkx7F50pFCtN7wlz0i+f1bmDnDfJnrd+F5p+f0Nt8havxhS0PdcP7I5
 7GrER6k3W5DVK3cP8bUh02FyHWa4TWqUnX8GxzUgqyjBFysQ8I/LviDOIXISyI79LT9blZpFUHU
 3VGy+NXkvZ6QGXphU0iRTaG3Hes2qg/okh/K0ChM7HqfjjLnazbs3IEJeMRnabzKtsAyJSOshe8
 V2KlCsy/AFfmrg5j0rCwYu2R9tga2/6+X6pG37cBYLnEALdX2MubArCX9oDzVSahAExAPOTUlhq
 aGmRYR9/xjoKBbudGHhesoqHKYFTbdYaXgHjIIRH0IBMjrz1BWub3xtEZrA8CaDidiC570lEDPf
 UVD7NM2Ah7zLLzH5Zqx824NorE0yhvf+EOoXK39ERXL85krLNzaoHlN54GU2u1B8O3lcXb9fNfN
 zQLXWQmRbz6cykdWKR1YEevk8prCgywD0mezI0tvIWEjZdsH9sygRrslS31cg0nB2Xpln+JARpb
 4fGNKThLD68HShg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor-internal.h |  4 ++--
 monitor/hmp-cmds.c         | 17 ++++++++++-------
 monitor/hmp.c              |  5 +++--
 monitor/monitor.c          | 16 +++++++++++-----
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a5c4aba306e..e071ad3e2e8 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -108,7 +108,6 @@ struct Monitor {
     bool skip_flush;
     bool use_io_thread;
 
-    char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
     /*
@@ -124,7 +123,6 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
-    int reset_seen;
 };
 
 struct MonitorHMP {
@@ -138,6 +136,8 @@ struct MonitorHMP {
      * These members can be safely accessed without locks.
      */
     ReadLineState *rs;
+    char *mon_cpu_path;
+    int reset_seen;
 };
 
 typedef struct {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 521ab8a641c..e7a02b1fddb 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -496,31 +496,34 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
 {
+    assert(!monitor_is_qmp(mon));
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
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
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
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
index cc4390486e1..de8804af51a 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1453,6 +1453,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
 static void monitor_event(void *opaque, QEMUChrEvent event)
 {
     Monitor *mon = opaque;
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
 
     switch (event) {
     case CHR_EVENT_MUX_IN:
@@ -1467,7 +1468,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_MUX_OUT:
         qemu_mutex_lock(&mon->mon_lock);
         if (!mon->mux_out) {
-            if (mon->reset_seen && !mon->suspend_cnt) {
+            if (hmp_mon->reset_seen && !mon->suspend_cnt) {
                 monitor_puts_locked(mon, "\n");
             } else {
                 monitor_flush_locked(mon);
@@ -1482,7 +1483,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
         monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
                        "information\n", QEMU_VERSION);
         qemu_mutex_lock(&mon->mon_lock);
-        mon->reset_seen = 1;
+        hmp_mon->reset_seen = 1;
         if (!mon->mux_out) {
             /* Suspend-resume forces the prompt to be printed.  */
             monitor_suspend(mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed6124..2dec0e299af 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -541,12 +541,17 @@ static void monitor_accept_input(void *opaque)
     Monitor *mon = opaque;
 
     qemu_mutex_lock(&mon->mon_lock);
-    if (!monitor_is_qmp(mon) && mon->reset_seen) {
+    if (!monitor_is_qmp(mon)) {
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
         assert(hmp_mon->rs);
-        readline_restart(hmp_mon->rs);
+        bool reset_seen = hmp_mon->reset_seen;
+        if (reset_seen) {
+            readline_restart(hmp_mon->rs);
+        }
         qemu_mutex_unlock(&mon->mon_lock);
-        readline_show_prompt(hmp_mon->rs);
+        if (reset_seen) {
+            readline_show_prompt(hmp_mon->rs);
+        }
     } else {
         qemu_mutex_unlock(&mon->mon_lock);
     }
@@ -622,12 +627,13 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 
 void monitor_data_destroy(Monitor *mon)
 {
-    g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
         monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     } else {
-        readline_free(container_of(mon, MonitorHMP, common)->rs);
+        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
+        readline_free(hmp_mon->rs);
+        g_free(hmp_mon->mon_cpu_path);
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);

-- 
2.54.0


