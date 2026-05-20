Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5306DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoom-0007J7-70; Wed, 20 May 2026 17:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPook-00079M-Ps
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooj-0004Kd-5b
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NV2lxj+kSafDI+Xt+W9HA0PH51XxNna6tbCIetfdZS8=;
 b=XzWg14bkg25OAQL75hmNBPGObEgJVtn2G6phvVySU7KkmoxwsU4+iuxQRzsGaDDXXb3De/
 dleFED+lurE8yl/i3BNo+OB8WZbaVWCAkX4OZHfAtLkMkm6IUyQo3sSuJMWUSfbi1ZKC2/
 mmWW0dnKP9Z4TLjnXJZn5rh43/LjN8Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-_WMrpovWOVe_Y1ANGGeDtg-1; Wed,
 20 May 2026 17:51:03 -0400
X-MC-Unique: _WMrpovWOVe_Y1ANGGeDtg-1
X-Mimecast-MFC-AGG-ID: _WMrpovWOVe_Y1ANGGeDtg_1779313862
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437A11956048
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 453D31956053; Wed, 20 May 2026 21:51:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:10 +0400
Subject: [PATCH 09/40] monitor: move HMP-only fields from Monitor to MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-9-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YgaR6uo3LHWF8Lt96k+ghSBepcAnzNcI9602SPUCXeY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCFW3Xdz9JH9xqc4wVAp2zyuMZZinhfsqIm
 UpN/yY6elWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5dTQD/9DgGIap7UrZzasCqvwn1HvRehz2tG5bk975juHcA6geajKXXdKLz+iKqYOysVbpwNVNBD
 hQLcZho2uOr8DeL4lOd0MyYd+R3OSNoHg6810na/dtZdHwNw0pUsQInKCzr5ykCwRPGymJ50cMw
 HRtvGZ9N3vc+1y590SwKbGdfWKGwyB4eb8thq35S3Z776RexDKhzK89AJYAxo+ZhscjyqWAQ+Ct
 rexOMLUdTb/s05sGsz9NtRK+TmhK3Ycicpfrc/FWNzDOt+2XehLcjLpYWk5IpZn3rNtQGXWXtty
 ZGt5jX8C6EA36aehgU7Y5bRd13n//UVviw3TYxOgShZeHRGvk02dMx7tk04qut51L2b0P7FvJaE
 9dZed29oWQafQYuFHk3Ktz4EtRoiKsVGcfVbIhDURItMa9v7UhIfHuEy8LTD31cvSxO6+O8UDFT
 1lmc1alNOAkJCUeakjY6ujlIqWCIzemG8c+1b8Aec19gPgjqBnG3i2x3OckiSyybW75TWjUJcUj
 hlTYe0a6q4pqGp2hoQIC7leQCXXNZFXyV2z8r+bOi3kMUnQK/qdM4+M7tdF31BL/yKqw8cEs5lV
 pQaSgiSKWBxNaAlYxRXkJMo6uLDbxF3tawjmiO/ypoad+X1Axwnq4QQ9h6o3YkK5Fa0jDSPephd
 2njMlGxJ9vDLikQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


