Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDE4CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzrN-0006Ef-NB; Tue, 09 Sep 2025 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uvzrF-0006Cb-Ce
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uvzr9-00016O-Sl
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757430118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2S910rc+A98q8IsZKat+n6zMcbjMHkRV5qo+ZthnVyQ=;
 b=NAYrdhlTay15L7ConaRyVX7UYweDMnl1WEKSGEJPa+WJYuUK7MgdG5lPg/HSOOVYVMHgp/
 kec+1h9JZg61sbHi3pPV/xRvWQ2naSs+mQwPv+rls4q+v9VZNBF/A8BWW/clgcQ+YBsOPX
 AwieNmCIIgB5QowdLX+K3IZT71XP+mA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-6ygpPTrkNyuLylWskfvH5w-1; Tue,
 09 Sep 2025 11:01:57 -0400
X-MC-Unique: 6ygpPTrkNyuLylWskfvH5w-1
X-Mimecast-MFC-AGG-ID: 6ygpPTrkNyuLylWskfvH5w_1757430116
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39E2C19560A1; Tue,  9 Sep 2025 15:01:56 +0000 (UTC)
Received: from fedora (unknown [10.43.3.85])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 733741800446; Tue,  9 Sep 2025 15:01:54 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] migration: Apply migration specific keep-alive defaults to
 inet socket
Date: Tue,  9 Sep 2025 17:01:24 +0200
Message-ID: <20250909150127.1494626-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Usual system defaults for TCP keep-alive options are too long for
migration workload. On Linux, a TCP connection waits idle for 2 hours
before it starts checking if the connection is not broken.

Now when InetSocketAddress supports keep-alive options [1], this patch
applies migration specific defaults if they are not supplied by the user
or the management software. With these defaults, a migration TCP stream
waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
second interval before considering the connection as broken.

System defaults can be still used by explicitly setting these parameters
to 0.

[1]: 1bd4237cb1 "util/qemu-sockets: Introduce inet socket options
     controlling TCP keep-alive"

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c | 39 +++++++++++++++++++++++++++++++++++++++
 qapi/migration.json   |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..a1f1223946 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -74,6 +74,11 @@
 
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
+#define INET_SOCKET_DEFAULT_KEEP_ALIVE true
+#define INET_SOCKET_DEFAULT_KEEP_ALIVE_COUNT 5
+#define INET_SOCKET_DEFAULT_KEEP_ALIVE_IDLE 60
+#define INET_SOCKET_DEFAULT_KEEP_ALIVE_INTERVAL 30
+
 static NotifierWithReturnList migration_state_notifiers[] = {
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
@@ -718,6 +723,36 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
     return true;
 }
 
+static void migration_address_apply_defaults(MigrationAddress *addr)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_INET) {
+        InetSocketAddress *inet = &addr->u.socket.u.inet;
+        if (!inet->has_keep_alive) {
+            inet->has_keep_alive = true;
+            inet->keep_alive = INET_SOCKET_DEFAULT_KEEP_ALIVE;
+        }
+#ifdef HAVE_TCP_KEEPCNT
+        if (!inet->has_keep_alive_count) {
+            inet->has_keep_alive_count = true;
+            inet->keep_alive_count = INET_SOCKET_DEFAULT_KEEP_ALIVE_COUNT;
+        }
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        if (!inet->has_keep_alive_idle) {
+            inet->has_keep_alive_idle = true;
+            inet->keep_alive_idle = INET_SOCKET_DEFAULT_KEEP_ALIVE_IDLE;
+        }
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        if (!inet->has_keep_alive_interval) {
+            inet->has_keep_alive_interval = true;
+            inet->keep_alive_interval = INET_SOCKET_DEFAULT_KEEP_ALIVE_INTERVAL;
+        }
+#endif
+    }
+}
+
 static bool
 migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
 {
@@ -775,6 +810,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         addr = channel->addr;
     }
 
+    migration_address_apply_defaults(addr);
+
     /* transport mechanism not suitable for migration? */
     if (!migration_transport_compatible(addr, errp)) {
         return;
@@ -2232,6 +2269,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         addr = channel->addr;
     }
 
+    migration_address_apply_defaults(addr);
+
     /* transport mechanism not suitable for migration? */
     if (!migration_transport_compatible(addr, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..68d4acb5db 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1639,6 +1639,12 @@
 #
 # Migration endpoint configuration.
 #
+# If transport is socket of type inet, it has the following defaults:
+# keep-alive: true, keep-alive-count: 5, keep-alive-idle: 60 seconds,
+# keep-alive-interval: 30 seconds.  System defaults can be used by
+# explicitly setting these parameters to 0.  See `InetSocketAddress` for
+# more details.
+#
 # @transport: The migration stream transport mechanism
 #
 # Since: 8.2
-- 
2.51.0


