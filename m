Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB09ED6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8PS6-0003kI-2m; Thu, 02 Apr 2026 17:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS5-0003k9-6P
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:45 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS3-0004au-Jz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A6ABB60123;
 Thu,  2 Apr 2026 21:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E04DC116C6;
 Thu,  2 Apr 2026 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775164775;
 bh=bSL21DMJvdPmisuJ4sR+uubo6LsKzZepTDyv0CmheLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dgAYVc21yM/2Vjc90j9dbQAcYoc1fLCXqQkzFCt296qDhe2Go0aqs8USaGnebPNio
 ynpNo/A7T9a7UCDM631goZ8SsOzdpIaMKYQX1ErQbSbfG/ExO8qx45NqA2m+gqluwU
 V/PbZAtnNluv/ZWQGVeO0CBrQkoABToqBhvY1qfgXhiOKpoiwilUcLqJZ/lYAzhVVE
 D2Ea7z9M+rDtOBrJngc8Vj9N9tsnoZDe2Vx8kRupZzQ8vrqhdvMJQS9AkglcGvYWuh
 crh7pCL48m58VQB7JXVlRn54cKyWrVaH6BXGYLxKQWNZ89CsAezoQ2d8Cblh5AtwkO
 guTavDLZHgn9A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 02 Apr 2026 23:19:17 +0200
Subject: [PATCH 2/5] monitor/qmp: add infrastructure for safe dynamic
 monitor removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-work-qmp-monitor-hotplug-v1-2-6313a5cdd574@kernel.org>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4106; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bSL21DMJvdPmisuJ4sR+uubo6LsKzZepTDyv0CmheLU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSeuxv/foer4afmkxfEPMt39E6PC9TgvHlBZ07SqQKXN
 a7dR9+ndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk/hYjw2G3CWZtnW2CX7LM
 vapdfY1U3x/pD4t3eBmSUHDn67XPtQz/LHwzfi7IfaqYtNZi1Yl3WkKnl0rcP+jTvmj+tmzNNYV
 ZXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extract monitor_qmp_destroy() from the shutdown-time monitor_cleanup()
path to allow destroying a single QMP monitor at runtime without
shutting down the entire dispatcher coroutine.

Export monitor_qmp_cleanup_queue_and_resume() so that monitor-remove
can drain pending requests before destroying the monitor.

Add qmp_dispatcher_current_mon tracking in the dispatcher coroutine to
handle the case where a monitor sends monitor-remove targeting itself.
After dispatching each request, the dispatcher checks the dead flag: if
set, it calls monitor_qmp_destroy() and clears the tracking pointer.

Both the dispatcher yield points and QMP command handlers run under the
BQL, so no additional locking is needed for qmp_dispatcher_current_mon.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 monitor/monitor-internal.h |  3 +++
 monitor/qmp.c              | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 8f5fe7c111..40f76ef5a0 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -181,10 +181,13 @@ void monitor_fdsets_cleanup(void);
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
+void monitor_qmp_destroy(MonitorQMP *mon);
+void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
 Monitor *monitor_find_by_id(const char *id);
+bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *mon);
 
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5fbc7af074..0d393f3c96 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -71,6 +71,13 @@ typedef struct QMPRequest QMPRequest;
 
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
+/*
+ * The monitor currently being serviced by the dispatcher coroutine.
+ * Both the dispatcher and QMP command handlers (monitor-remove) run
+ * under the BQL, so no additional locking is needed.
+ */
+static MonitorQMP *qmp_dispatcher_current_mon;
+
 static bool qmp_oob_enabled(MonitorQMP *mon)
 {
     return mon->capab[QMP_CAPABILITY_OOB];
@@ -98,7 +105,7 @@ static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
     }
 }
 
-static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
+void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
 {
     QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
 
@@ -287,6 +294,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          */
 
         mon = req_obj->mon;
+        qmp_dispatcher_current_mon = mon;
 
         /*
          * We need to resume the monitor if handle_qmp_command()
@@ -347,6 +355,16 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         }
 
         qmp_request_free(req_obj);
+
+        /*
+         * If monitor-remove was called while we were dispatching a
+         * request on this monitor, the monitor was marked dead and
+         * removed from mon_list but destruction was deferred to us.
+         */
+        if (mon->common.dead) {
+            monitor_qmp_destroy(mon);
+        }
+        qmp_dispatcher_current_mon = NULL;
     }
     qatomic_set(&qmp_dispatcher_co, NULL);
 }
@@ -499,6 +517,22 @@ void monitor_data_destroy_qmp(MonitorQMP *mon)
     g_queue_free(mon->qmp_requests);
 }
 
+/*
+ * Destroy a single dynamically-added QMP monitor.
+ * The monitor must already have been removed from mon_list.
+ */
+void monitor_qmp_destroy(MonitorQMP *mon)
+{
+    monitor_flush(&mon->common);
+    monitor_data_destroy(&mon->common);
+    g_free(mon);
+}
+
+bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *mon)
+{
+    return qmp_dispatcher_current_mon == mon;
+}
+
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
     MonitorQMP *mon = opaque;

-- 
2.47.3


