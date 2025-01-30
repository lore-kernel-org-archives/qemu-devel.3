Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B35C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 16:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdXBW-0002Fa-8a; Thu, 30 Jan 2025 11:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tdXBT-0002Ex-Qv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 11:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tdXBR-00007L-0X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 11:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738253651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UHZJ7i3p4jhNSM4wozKXCWdfHPzwxNE8g1hwB7xBI+8=;
 b=RqZAGcXIWetV5UDtY4XeVXHAWy+AYvIl+0QuD6K1mAiInl232ODdW96dI76WTKyFev/YXA
 l8w5pg8bBVPnxq/1k7/FCCn9sK9vlVrOGlL2kQgFVJDISSs4tLfsnf/gCrVEzkUe+v1Own
 lFJlTvj2Jfsnq/469SKtUYiV8FBeU30=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-lcGMO4VdNDiyuq_G4AVOQQ-1; Thu,
 30 Jan 2025 11:14:07 -0500
X-MC-Unique: lcGMO4VdNDiyuq_G4AVOQQ-1
X-Mimecast-MFC-AGG-ID: lcGMO4VdNDiyuq_G4AVOQQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 930031801F16; Thu, 30 Jan 2025 16:14:06 +0000 (UTC)
Received: from rh-jmarcin.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F18F18008DC; Thu, 30 Jan 2025 16:14:04 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: Add keepalive messages from dst to src during
 postcopy
Date: Thu, 30 Jan 2025 17:11:36 +0100
Message-ID: <20250130161139.548078-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When there are no page requests from the destination side and the
connection breaks, the destination might not be aware of it. This is
the case for example with a TCP connection, which by default remains
open unless it is explicitly closed or the TCP stack fails to
successfully send a packet.

Such situation without any traffic from the destination to the source
side can happen for multiple reasons. For example, if all pages accessed
at idle are already migrated, but there are still non-migrated pages
that are accessed very infrequently, or if the destination QEMU is
started with '-S' option and the management application does not run
the 'cont' QMP command right away.

Due to this, the destination side might not know about the network
failure and stays in the postcopy-active state instead of switching
to the postcopy-paused state, informing the destination management
application about the issue.

This patch resolves this by sending a keepalive message on the return
path to the source if there is no page fault (thus page request message)
in a certain amount of time. This wait time can be configured with new
'postcopy-rp-keepalive-period' migration parameter, by default it is
60000 ms. By setting this parameter to 0, sending keepalive messages
can be disabled completely.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c    | 12 ++++++++++++
 migration/migration.h    |  1 +
 migration/options.c      | 35 +++++++++++++++++++++++++++++++++++
 migration/options.h      |  1 +
 migration/postcopy-ram.c | 15 ++++++++++++++-
 migration/trace-events   |  2 ++
 qapi/migration.json      | 35 ++++++++++++++++++++++++++++++++---
 7 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2d1da917c7..ef049efd0a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -89,6 +89,8 @@ enum mig_rp_message_type {
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
     MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
 
+    MIG_RP_MSG_KEEPALIVE, /* Keepalive message from destination to source */
+
     MIG_RP_MSG_MAX
 };
 
@@ -471,6 +473,12 @@ static int migrate_send_rp_message(MigrationIncomingState *mis,
     return qemu_fflush(mis->to_src_file);
 }
 
+void migrate_send_rp_keepalive(MigrationIncomingState *mis)
+{
+    trace_migrate_send_rp_keepalive();
+    migrate_send_rp_message(mis, MIG_RP_MSG_KEEPALIVE, 0, NULL);
+}
+
 /* Request one page from the source VM at the given start address.
  *   rb: the RAMBlock to request the page in
  *   Start: Address offset within the RB
@@ -2399,6 +2407,10 @@ static void *source_return_path_thread(void *opaque)
             trace_source_return_path_thread_switchover_acked();
             break;
 
+        case MIG_RP_MSG_KEEPALIVE:
+            trace_source_return_path_thread_received_keepalive();
+            break;
+
         default:
             break;
         }
diff --git a/migration/migration.h b/migration/migration.h
index 0df2a187af..4ec7c63fc4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -503,6 +503,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
                           uint32_t value);
 void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
+void migrate_send_rp_keepalive(MigrationIncomingState *mis);
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
                               ram_addr_t start, uint64_t haddr);
 int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
diff --git a/migration/options.c b/migration/options.c
index b8d5300326..4df973467f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -85,6 +85,12 @@
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
+/*
+ * Time in milliseconds for periodic keepalive message from destination to
+ * source during postcopy if there is no other traffic, 0: no keepalive messages
+ */
+#define DEFAULT_MIGRATE_POSTCOPY_RP_KEEPALIVE_PERIOD 60000
+
 const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
@@ -172,6 +178,9 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_UINT32("postcopy-rp-keepalive-period", MigrationState,
+                       parameters.postcopy_rp_keepalive_period,
+                       DEFAULT_MIGRATE_POSTCOPY_RP_KEEPALIVE_PERIOD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -837,6 +846,13 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+uint32_t migrate_postcopy_rp_keepalive_period(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.postcopy_rp_keepalive_period;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
@@ -922,6 +938,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->has_postcopy_rp_keepalive_period = true;
+    params->postcopy_rp_keepalive_period = s->parameters.postcopy_rp_keepalive_period;
 
     return params;
 }
@@ -956,6 +974,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->has_postcopy_rp_keepalive_period = true;
 }
 
 /*
@@ -1142,6 +1161,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_postcopy_rp_keepalive_period &&
+        params->postcopy_rp_keepalive_period > INT_MAX) {
+        error_setg(errp,
+                   "Parameter 'postcopy-rp-keepalive-period' must be less than %d",
+                   INT_MAX);
+        return false;
+    }
+
     return true;
 }
 
@@ -1255,6 +1282,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_postcopy_rp_keepalive_period) {
+        dest->postcopy_rp_keepalive_period = params->postcopy_rp_keepalive_period;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1387,6 +1418,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+
+    if (params->has_postcopy_rp_keepalive_period) {
+        s->parameters.postcopy_rp_keepalive_period = params->postcopy_rp_keepalive_period;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 762be4e641..c941806413 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -85,6 +85,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+uint32_t migrate_postcopy_rp_keepalive_period(void);
 
 /* parameters helpers */
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6a6da6ba7f..26db4e2d22 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -960,6 +960,10 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb = NULL;
+    int poll_timeout = migrate_postcopy_rp_keepalive_period();
+    if (poll_timeout == 0) {
+        poll_timeout = -1; /* wait forever with no keepalive messages */
+    }
 
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
@@ -995,7 +999,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
          * an eventfd
          */
 
-        poll_result = poll(pfd, pfd_len, -1 /* Wait forever */);
+        poll_result = poll(pfd, pfd_len, poll_timeout);
         if (poll_result == -1) {
             error_report("%s: userfault poll: %s", __func__, strerror(errno));
             break;
@@ -1010,6 +1014,15 @@ static void *postcopy_ram_fault_thread(void *opaque)
             postcopy_pause_fault_thread(mis);
         }
 
+        if (poll_result == 0) {
+            /*
+             * No page to request, send at least a keepalive message to check
+             * that the connection is not broken.
+             */
+            migrate_send_rp_keepalive(mis);
+            continue;
+        }
+
         if (pfd[1].revents) {
             uint64_t tmp64 = 0;
 
diff --git a/migration/trace-events b/migration/trace-events
index b82a1c5e40..64ffbc271f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -161,6 +161,7 @@ migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending
 migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
+migrate_send_rp_keepalive(void) ""
 migration_completion_file_err(void) ""
 migration_completion_vm_stop(int ret) "ret %d"
 migration_completion_postcopy_end(void) ""
@@ -188,6 +189,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
+source_return_path_thread_received_keepalive(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
diff --git a/qapi/migration.json b/qapi/migration.json
index a605dc26db..b4553aedfc 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -844,6 +844,15 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
+#     request message is sent from the destination side to the source side, a
+#     keepalive message is sent instead.  Allows the destination to detect
+#     network failure that would not be detected otherwise in case there is no
+#     other communication to the source side (no page requests).  Should be less
+#     than platform INT_MAX, 0 means no keepalive will be sent.
+#     Default is 60000 ms.
+#     (Since 9.3)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -870,7 +879,7 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io', 'postcopy-rp-keepalive-period'] }
 
 ##
 # @MigrateSetParameters:
@@ -1025,6 +1034,15 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
+#     request message is sent from the destination side to the source side, a
+#     keepalive message is sent instead.  Allows the destination to detect
+#     network failure that would not be detected otherwise in case there is no
+#     other communication to the source side (no page requests).  Should be less
+#     than platform INT_MAX, 0 means no keepalive will be sent.
+#     Default is 60000 ms.
+#     (Since 9.3)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1066,7 +1084,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*postcopy-rp-keepalive-period': 'uint32' } }
 
 ##
 # @migrate-set-parameters:
@@ -1235,6 +1254,15 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
+#     request message is sent from the destination side to the source side, a
+#     keepalive message is sent instead.  Allows the destination to detect
+#     network failure that would not be detected otherwise in case there is no
+#     other communication to the source side (no page requests).  Should be less
+#     than platform INT_MAX, 0 means no keepalive will be sent.
+#     Default is 60000 ms.
+#     (Since 9.3)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1273,7 +1301,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*postcopy-rp-keepalive-period': 'uint32' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.48.1


