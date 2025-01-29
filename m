Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13CEC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWZ-0004Ti-9v; Wed, 29 Jan 2025 11:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVM-0003GZ-QD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVJ-0005FW-ST
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3A7F1F365;
 Wed, 29 Jan 2025 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ipvpl+UNb2PkRIlqMsvW5r7eEz4gv/kkzRwk4V9F8vU=;
 b=HAhrpyIcQ26+KNH/WP4e6BuN/JEzuFQYwrELSW++331NGDS7dG/LIjY1/J8h1daXAQYYbQ
 fTZJdgWJPxyg0RB80iNX/5hgPyM17DsZ05f/aI10f4LP0sXRrm5AawvV+DhJe7/rE/VtT1
 0sh1FJrGyom919fWkPmmxbtHDBERMv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ipvpl+UNb2PkRIlqMsvW5r7eEz4gv/kkzRwk4V9F8vU=;
 b=JD6xQoq4l8p4L/Q84vrDQXQIHttjysg0WnT8EP++Eah4M4weV4oLWUAAHLYSdE/iLJGmax
 TvwN216bVP+GHYAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ipvpl+UNb2PkRIlqMsvW5r7eEz4gv/kkzRwk4V9F8vU=;
 b=HAhrpyIcQ26+KNH/WP4e6BuN/JEzuFQYwrELSW++331NGDS7dG/LIjY1/J8h1daXAQYYbQ
 fTZJdgWJPxyg0RB80iNX/5hgPyM17DsZ05f/aI10f4LP0sXRrm5AawvV+DhJe7/rE/VtT1
 0sh1FJrGyom919fWkPmmxbtHDBERMv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ipvpl+UNb2PkRIlqMsvW5r7eEz4gv/kkzRwk4V9F8vU=;
 b=JD6xQoq4l8p4L/Q84vrDQXQIHttjysg0WnT8EP++Eah4M4weV4oLWUAAHLYSdE/iLJGmax
 TvwN216bVP+GHYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59789137DB;
 Wed, 29 Jan 2025 16:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIHsBtNQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 08/42] migration: cpr-state
Date: Wed, 29 Jan 2025 13:00:25 -0300
Message-Id: <20250129160059.6987-9-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid];
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

CPR must save state that is needed after QEMU is restarted, when devices
are realized.  Thus the extra state cannot be saved in the migration
channel, as objects must already exist before that channel can be loaded.
Instead, define auxilliary state structures and vmstate descriptions, not
associated with any registered object, and serialize the aux state to a
cpr-specific channel in cpr_state_save.  Deserialize in cpr_state_load
after QEMU restarts, before devices are realized.

Provide accessors for clients to register file descriptors for saving.
The mechanism for passing the fd's to the new process will be specific
to each migration mode, and added in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-8-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h |  25 +++++
 migration/cpr.c         | 198 ++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |   1 +
 migration/migration.c   |   1 +
 migration/trace-events  |   7 ++
 5 files changed, 232 insertions(+)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
new file mode 100644
index 0000000000..d9364f7d1f
--- /dev/null
+++ b/include/migration/cpr.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2021, 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIGRATION_CPR_H
+#define MIGRATION_CPR_H
+
+#include "qapi/qapi-types-migration.h"
+
+#define QEMU_CPR_FILE_MAGIC     0x51435052
+#define QEMU_CPR_FILE_VERSION   0x00000001
+
+void cpr_save_fd(const char *name, int id, int fd);
+void cpr_delete_fd(const char *name, int id);
+int cpr_find_fd(const char *name, int id);
+
+int cpr_state_save(MigrationChannel *channel, Error **errp);
+int cpr_state_load(MigrationChannel *channel, Error **errp);
+void cpr_state_close(void);
+struct QIOChannel *cpr_state_ioc(void);
+
+#endif
diff --git a/migration/cpr.c b/migration/cpr.c
new file mode 100644
index 0000000000..87bcfdb5ff
--- /dev/null
+++ b/migration/cpr.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/misc.h"
+#include "migration/options.h"
+#include "migration/qemu-file.h"
+#include "migration/savevm.h"
+#include "migration/vmstate.h"
+#include "system/runstate.h"
+#include "trace.h"
+
+/*************************************************************************/
+/* cpr state container for all information to be saved. */
+
+typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
+
+typedef struct CprState {
+    CprFdList fds;
+} CprState;
+
+static CprState cpr_state;
+
+/****************************************************************************/
+
+typedef struct CprFd {
+    char *name;
+    unsigned int namelen;
+    int id;
+    int fd;
+    QLIST_ENTRY(CprFd) next;
+} CprFd;
+
+static const VMStateDescription vmstate_cpr_fd = {
+    .name = "cpr fd",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(namelen, CprFd),
+        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
+        VMSTATE_INT32(id, CprFd),
+        VMSTATE_INT32(fd, CprFd),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void cpr_save_fd(const char *name, int id, int fd)
+{
+    CprFd *elem = g_new0(CprFd, 1);
+
+    trace_cpr_save_fd(name, id, fd);
+    elem->name = g_strdup(name);
+    elem->namelen = strlen(name) + 1;
+    elem->id = id;
+    elem->fd = fd;
+    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
+}
+
+static CprFd *find_fd(CprFdList *head, const char *name, int id)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, head, next) {
+        if (!strcmp(elem->name, name) && elem->id == id) {
+            return elem;
+        }
+    }
+    return NULL;
+}
+
+void cpr_delete_fd(const char *name, int id)
+{
+    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+
+    if (elem) {
+        QLIST_REMOVE(elem, next);
+        g_free(elem->name);
+        g_free(elem);
+    }
+
+    trace_cpr_delete_fd(name, id);
+}
+
+int cpr_find_fd(const char *name, int id)
+{
+    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    int fd = elem ? elem->fd : -1;
+
+    trace_cpr_find_fd(name, id, fd);
+    return fd;
+}
+/*************************************************************************/
+#define CPR_STATE "CprState"
+
+static const VMStateDescription vmstate_cpr_state = {
+    .name = CPR_STATE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+/*************************************************************************/
+
+static QEMUFile *cpr_state_file;
+
+QIOChannel *cpr_state_ioc(void)
+{
+    return qemu_file_get_ioc(cpr_state_file);
+}
+
+int cpr_state_save(MigrationChannel *channel, Error **errp)
+{
+    int ret;
+    QEMUFile *f;
+    MigMode mode = migrate_mode();
+
+    trace_cpr_state_save(MigMode_str(mode));
+
+    /* set f based on mode in a later patch in this series */
+    return 0;
+
+    qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
+    qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
+
+    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
+    if (ret) {
+        error_setg(errp, "vmstate_save_state error %d", ret);
+        qemu_fclose(f);
+        return ret;
+    }
+
+    /*
+     * Close the socket only partially so we can later detect when the other
+     * end closes by getting a HUP event.
+     */
+    qemu_fflush(f);
+    qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
+                         NULL);
+    cpr_state_file = f;
+    return 0;
+}
+
+int cpr_state_load(MigrationChannel *channel, Error **errp)
+{
+    int ret;
+    uint32_t v;
+    QEMUFile *f;
+    MigMode mode = 0;
+
+    /* set f and mode based on other parameters later in this patch series */
+    return 0;
+
+    trace_cpr_state_load(MigMode_str(mode));
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_CPR_FILE_MAGIC) {
+        error_setg(errp, "Not a migration stream (bad magic %x)", v);
+        qemu_fclose(f);
+        return -EINVAL;
+    }
+    v = qemu_get_be32(f);
+    if (v != QEMU_CPR_FILE_VERSION) {
+        error_setg(errp, "Unsupported migration stream version %d", v);
+        qemu_fclose(f);
+        return -ENOTSUP;
+    }
+
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    if (ret) {
+        error_setg(errp, "vmstate_load_state error %d", ret);
+        qemu_fclose(f);
+        return ret;
+    }
+
+    /*
+     * Let the caller decide when to close the socket (and generate a HUP event
+     * for the sending side).
+     */
+    cpr_state_file = f;
+
+    return ret;
+}
+
+void cpr_state_close(void)
+{
+    if (cpr_state_file) {
+        qemu_fclose(cpr_state_file);
+        cpr_state_file = NULL;
+    }
+}
diff --git a/migration/meson.build b/migration/meson.build
index dac687ee3a..1eb8c96d23 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -14,6 +14,7 @@ system_ss.add(files(
   'block-active.c',
   'channel.c',
   'channel-block.c',
+  'cpr.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
diff --git a/migration/migration.c b/migration/migration.c
index 2d1da917c7..fce7b22ae8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -27,6 +27,7 @@
 #include "system/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
+#include "migration/cpr.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "migration.h"
diff --git a/migration/trace-events b/migration/trace-events
index b82a1c5e40..4e3061bc55 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -342,6 +342,13 @@ colo_receive_message(const char *msg) "Receive '%s' message"
 # colo-failover.c
 colo_failover_set_state(const char *new_state) "new state %s"
 
+# cpr.c
+cpr_save_fd(const char *name, int id, int fd) "%s, id %d, fd %d"
+cpr_delete_fd(const char *name, int id) "%s, id %d"
+cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
+cpr_state_save(const char *mode) "%s mode"
+cpr_state_load(const char *mode) "%s mode"
+
 # block-dirty-bitmap.c
 send_bitmap_header_enter(void) ""
 send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "flags: 0x%x, start_sector: %" PRIu64 ", nr_sectors: %" PRIu32 ", data_size: %" PRIu64
-- 
2.35.3


