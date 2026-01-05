Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E289DC79FB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpwX-0000VX-BF; Mon, 05 Jan 2026 14:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpw3-00081a-Dr
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpw1-0005cp-91
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7895C3376A;
 Mon,  5 Jan 2026 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoPU6TRM/mLO1xKHhI01CyaBN2OVcc81OyBADxz8Yl0=;
 b=uQgbO4JXJQtL3p1Fu7YaFJGB+9X0AXVbUinra751u+yFgY4qRjTPhNAj9cPLJ/g9yGVyYD
 +KrlzBCJXZu0u7c1Y5ER53aUcpugFoPnIvGwLSOgQ0zoe+oeJv6iWJ8kGQ76miKAGanfz8
 wjHtmOG1BxcWk3jR/RWhxoPrFuXlgyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoPU6TRM/mLO1xKHhI01CyaBN2OVcc81OyBADxz8Yl0=;
 b=p5q6pLy3judEHYFPmJJAoSsY+YA4hA6iMEvA/XQmdnKbcvoIz/xTVDcJUOcbyq3hEek9UX
 dafgwmiZ3LHlgRAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoPU6TRM/mLO1xKHhI01CyaBN2OVcc81OyBADxz8Yl0=;
 b=uQgbO4JXJQtL3p1Fu7YaFJGB+9X0AXVbUinra751u+yFgY4qRjTPhNAj9cPLJ/g9yGVyYD
 +KrlzBCJXZu0u7c1Y5ER53aUcpugFoPnIvGwLSOgQ0zoe+oeJv6iWJ8kGQ76miKAGanfz8
 wjHtmOG1BxcWk3jR/RWhxoPrFuXlgyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoPU6TRM/mLO1xKHhI01CyaBN2OVcc81OyBADxz8Yl0=;
 b=p5q6pLy3judEHYFPmJJAoSsY+YA4hA6iMEvA/XQmdnKbcvoIz/xTVDcJUOcbyq3hEek9UX
 dafgwmiZ3LHlgRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32F4213964;
 Mon,  5 Jan 2026 19:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBcFOewLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 19/25] migration: Move transport connection code into
 channel.c
Date: Mon,  5 Jan 2026 16:06:36 -0300
Message-ID: <20260105190644.14072-20-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the <transport>_connect_incoming|outgoing functions to channel.c.
It leaves migration.c to deal with the established connection only.

(I sorted the includes)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 66 +++++++++++++++++++++++++++++++++++++++----
 migration/channel.h   |  4 +++
 migration/migration.c | 46 ++----------------------------
 3 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index a6608c5f08..1817f88aed 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -12,18 +12,74 @@
 
 #include "qemu/osdep.h"
 #include "channel.h"
-#include "tls.h"
+#include "exec.h"
+#include "fd.h"
+#include "file.h"
+#include "io/channel-socket.h"
+#include "io/channel-tls.h"
 #include "migration.h"
 #include "multifd.h"
-#include "savevm.h"
-#include "trace.h"
 #include "options.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/error.h"
-#include "io/channel-tls.h"
-#include "io/channel-socket.h"
+#include "qemu-file.h"
 #include "qemu/yank.h"
+#include "rdma.h"
+#include "savevm.h"
+#include "socket.h"
+#include "tls.h"
+#include "trace.h"
 #include "yank_functions.h"
 
+void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
+                                Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_connect_outgoing(s, saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_connect_outgoing(s, saddr->u.fd.str, errp);
+        }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_connect_outgoing(s, &addr->u.rdma, errp);
+#endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_connect_outgoing(s, addr->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_connect_outgoing(s, &addr->u.file, errp);
+    } else {
+        error_setg(errp, "uri is not a valid migration protocol");
+    }
+}
+
+void migration_connect_incoming(MigrationAddress *addr, Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_connect_incoming(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_connect_incoming(saddr->u.fd.str, errp);
+        }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_connect_incoming(&addr->u.rdma, errp);
+#endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_connect_incoming(addr->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_connect_incoming(&addr->u.file, errp);
+    } else {
+        error_setg(errp, "unknown migration protocol");
+    }
+}
+
 bool migration_has_main_and_multifd_channels(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
diff --git a/migration/channel.h b/migration/channel.h
index 59d169e095..727eabf16c 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -17,6 +17,7 @@
 #define QEMU_MIGRATION_CHANNEL_H
 
 #include "io/channel.h"
+#include "qapi/qapi-types-migration.h"
 
 /* Migration channel types */
 enum {
@@ -38,4 +39,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
 bool migration_has_main_and_multifd_channels(void);
 bool migration_has_all_channels(void);
 
+void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
+                                Error **errp);
+void migration_connect_incoming(MigrationAddress *addr, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 540b419cda..d9407a47ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -20,13 +20,10 @@
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
 #include "exec.h"
-#include "fd.h"
 #include "file.h"
-#include "socket.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/cpu-throttle.h"
-#include "rdma.h"
 #include "ram.h"
 #include "migration/cpr.h"
 #include "migration/global_state.h"
@@ -783,26 +780,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &addr->u.socket;
-        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_connect_incoming(saddr, errp);
-        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_connect_incoming(saddr->u.fd.str, errp);
-        }
-#ifdef CONFIG_RDMA
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_connect_incoming(&addr->u.rdma, errp);
-#endif
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_connect_incoming(addr->u.exec.args, errp);
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_connect_incoming(&addr->u.file, errp);
-    } else {
-        error_setg(errp, "unknown migration protocol: %s", uri);
-    }
+    migration_connect_incoming(addr, errp);
 
     /* Close cpr socket to tell source that we are listening */
     cpr_state_close();
@@ -2230,31 +2208,11 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
 
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &addr->u.socket;
-        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_connect_outgoing(s, saddr, &local_err);
-        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_connect_outgoing(s, saddr->u.fd.str, &local_err);
-        }
-#ifdef CONFIG_RDMA
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_connect_outgoing(s, &addr->u.rdma, &local_err);
-#endif
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_connect_outgoing(s, addr->u.exec.args, &local_err);
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_connect_outgoing(s, &addr->u.file, &local_err);
-    } else {
-        error_setg(&local_err, "uri is not a valid migration protocol");
-    }
+    migration_connect_outgoing(s, addr, &local_err);
 
     if (local_err) {
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
-        return;
     }
 }
 
-- 
2.51.0


