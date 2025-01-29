Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A949C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXO-0005Sr-F7; Wed, 29 Jan 2025 11:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVb-0003Id-I3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVY-0005Id-Vs
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:43 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDBA31F395;
 Wed, 29 Jan 2025 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5PqQG3ivZaD+IVqDP0uxWtBl2ZlVKcGJkc+ngGle/s=;
 b=vlz1tQcwGLhuBhgEZy/9aB8L5IEUUE1VLX7AKPK5nWF+q4u9bD6jDf249dNz66zlBFjMpn
 DojL0pBpr+fTqAzRO4uR5r2CwqpVwh8zaVXYinurycex3foe2pwO9zJs5v5s3COy7CwL0n
 6yyaWapWlvKHcqKYyQEuiNtNF/EMNds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5PqQG3ivZaD+IVqDP0uxWtBl2ZlVKcGJkc+ngGle/s=;
 b=ogB/9fKezc/fJzQcRTM03XXuwESHIA1m2Q2nWRZ+2XsVkQ7V88e4XUc3XntQwecqCYx6ex
 YodWOPPDrszX42Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5PqQG3ivZaD+IVqDP0uxWtBl2ZlVKcGJkc+ngGle/s=;
 b=gdeKEk1l8Ji8n/Gs4IwT/r+7rUEedc8Dwj62CnerUIrMEuxOnzBu8Ai9R+dcSAGzF+5tWs
 L4NmWBPfaSVEdi+RC8A668ulTVFhcG2hU1XDHFsbhPWh4SFmiYmEKguwtf2XQbDul8XaaV
 mHD2zRQtiLE87LE3eARwnhTaWEekqxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5PqQG3ivZaD+IVqDP0uxWtBl2ZlVKcGJkc+ngGle/s=;
 b=rDLQxDOzKJqBf675eYjbaMaRgKDlejJ9VMDIN3P3ctMyUTmOeTjh7u2x/2c3kD+W6EZ2Gg
 Ks2NtA67WeJRTwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95907137DB;
 Wed, 29 Jan 2025 16:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APp8FeFQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 16/42] migration: cpr-transfer save and load
Date: Wed, 29 Jan 2025 13:00:33 -0300
Message-Id: <20250129160059.6987-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Add functions to create a QEMUFile based on a unix URI, for saving or
loading, for use by cpr-transfer mode to preserve CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-16-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h  |  3 ++
 migration/cpr-transfer.c | 71 ++++++++++++++++++++++++++++++++++++++++
 migration/meson.build    |  1 +
 migration/trace-events   |  2 ++
 4 files changed, 77 insertions(+)
 create mode 100644 migration/cpr-transfer.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index d9364f7d1f..c669b8b8a3 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -22,4 +22,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
+
 #endif
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
new file mode 100644
index 0000000000..e1f140359c
--- /dev/null
+++ b/migration/cpr-transfer.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "io/channel-file.h"
+#include "io/channel-socket.h"
+#include "io/net-listener.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/savevm.h"
+#include "migration/qemu-file.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
+{
+    MigrationAddress *addr = channel->addr;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        g_autoptr(QIOChannelSocket) sioc = qio_channel_socket_new();
+        QIOChannel *ioc = QIO_CHANNEL(sioc);
+        SocketAddress *saddr = &addr->u.socket;
+
+        if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
+            return NULL;
+        }
+        trace_cpr_transfer_output(addr->u.socket.u.q_unix.path);
+        qio_channel_set_name(ioc, "cpr-out");
+        return qemu_file_new_output(ioc);
+
+    } else {
+        error_setg(errp, "bad cpr channel address; must be unix");
+        return NULL;
+    }
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    MigrationAddress *addr = channel->addr;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
+        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+
+        g_autoptr(QIOChannelSocket) sioc = NULL;
+        SocketAddress *saddr = &addr->u.socket;
+        g_autoptr(QIONetListener) listener = qio_net_listener_new();
+        QIOChannel *ioc;
+
+        qio_net_listener_set_name(listener, "cpr-socket-listener");
+        if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
+            return NULL;
+        }
+
+        sioc = qio_net_listener_wait_client(listener);
+        ioc = QIO_CHANNEL(sioc);
+        trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
+        qio_channel_set_name(ioc, "cpr-in");
+        return qemu_file_new_input(ioc);
+
+    } else {
+        error_setg(errp, "bad cpr channel socket type; must be unix");
+        return NULL;
+    }
+}
diff --git a/migration/meson.build b/migration/meson.build
index 1eb8c96d23..d3bfe84d62 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -15,6 +15,7 @@ system_ss.add(files(
   'channel.c',
   'channel-block.c',
   'cpr.c',
+  'cpr-transfer.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
diff --git a/migration/trace-events b/migration/trace-events
index abd9cdf2a1..e03a914afb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -350,6 +350,8 @@ cpr_delete_fd(const char *name, int id) "%s, id %d"
 cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
 cpr_state_save(const char *mode) "%s mode"
 cpr_state_load(const char *mode) "%s mode"
+cpr_transfer_input(const char *path) "%s"
+cpr_transfer_output(const char *path) "%s"
 
 # block-dirty-bitmap.c
 send_bitmap_header_enter(void) ""
-- 
2.35.3


