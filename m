Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85FED148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6W-0006y3-3h; Thu, 08 Jan 2026 02:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6O-0006ji-If
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6M-0006bD-NN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQeg/ax1yqZCNF/kck2njGvRd7LL1zM9VleD8rDKBvQ=;
 b=PHckq3FLK6YqHPh6TWKcBAxpsREfhkhRHCmu+lSppfD1oYF4Jl5k7qsR0Os6aLlATLPbvJ
 sACyL6k2CTxDjj4uccvgbXVY5Gpu6RqA4rvOEfYwyTI/1e1WBfyLI+d8PPAPgAg4+Xcu+j
 cQR5ZBgl0mQLMjBuAbNBY8f219ncgMM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-YvstIR5oNM6emDUB6PUhBQ-1; Thu,
 08 Jan 2026 02:06:30 -0500
X-MC-Unique: YvstIR5oNM6emDUB6PUhBQ-1
X-Mimecast-MFC-AGG-ID: YvstIR5oNM6emDUB6PUhBQ_1767855989
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4204318005AF; Thu,  8 Jan 2026 07:06:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7248819560A7; Thu,  8 Jan 2026 07:06:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0176421E61AA; Thu, 08 Jan 2026 08:06:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL v2 04/17] error: error_free(NULL) is safe,
 drop unnecessary conditionals
Date: Thu,  8 Jan 2026 08:06:12 +0100
Message-ID: <20260108070625.1586474-5-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251119130855.105479-5-armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/acpi/pcihp.c             | 4 +---
 io/channel-websock.c        | 4 +---
 io/task.c                   | 4 +---
 migration/migration.c       | 6 ++----
 tests/unit/test-smp-parse.c | 5 +----
 5 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 4922bbc778..87162ff2c0 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -62,9 +62,7 @@ static int acpi_pcihp_get_bsel(PCIBus *bus)
                                              &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
-        if (local_err) {
-            error_free(local_err);
-        }
+        error_free(local_err);
         return -1;
     } else {
         return bsel;
diff --git a/io/channel-websock.c b/io/channel-websock.c
index cb4dafdebb..d0929ba232 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -932,9 +932,7 @@ static void qio_channel_websock_finalize(Object *obj)
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
     }
-    if (ioc->io_err) {
-        error_free(ioc->io_err);
-    }
+    error_free(ioc->io_err);
     object_unref(OBJECT(ioc->master));
 }
 
diff --git a/io/task.c b/io/task.c
index 451f26f8b4..da79d31782 100644
--- a/io/task.c
+++ b/io/task.c
@@ -91,9 +91,7 @@ static void qio_task_free(QIOTask *task)
     if (task->destroyResult) {
         task->destroyResult(task->result);
     }
-    if (task->err) {
-        error_free(task->err);
-    }
+    error_free(task->err);
     object_unref(task->source);
 
     qemu_mutex_unlock(&task->thread_lock);
diff --git a/migration/migration.c b/migration/migration.c
index 9d1bf5d276..1c34d8d432 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1568,10 +1568,8 @@ bool migrate_has_error(MigrationState *s)
 static void migrate_error_free(MigrationState *s)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
-    if (s->error) {
-        error_free(s->error);
-        s->error = NULL;
-    }
+    error_free(s->error);
+    s->error = NULL;
 }
 
 static void migration_connect_error_propagate(MigrationState *s, Error *error)
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 28ea9158e7..1b6450e7d8 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -875,10 +875,7 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
                config_str, expect_err, output_topo_str);
 
 end:
-    if (err != NULL) {
-        error_free(err);
-    }
-
+    error_free(err);
     abort();
 }
 
-- 
2.52.0


