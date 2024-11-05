Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86EED3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzL-0004kG-Le; Tue, 05 Nov 2024 13:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzK-0004ju-DF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:10 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzI-0004uA-DU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4569621E5F;
 Tue,  5 Nov 2024 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCFGBXeNbli1xV0E1/Pu2ibXHuHwuboSiP51Kabqyq8=;
 b=jKaZUmWBJit/J1aZfVMIuELP7aCVYLWO4ca+va2co0+FFoLDkEv30390wj2DpXXv93hnBW
 8RKWhS8LPYkJMsHkUBPLPMyDdNzJss3I873eP5EVgiZAQzNyKBX2sN6LgyytBEOddRL0U5
 AWNEl1rLFxcqqsYHNNVWijTuXRZ0nUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCFGBXeNbli1xV0E1/Pu2ibXHuHwuboSiP51Kabqyq8=;
 b=OwJ44SNbXWEmKnxdhkHuzgKMPLfG5ekWt4/U73Gocfo8xtuUR6cguWNUvC2vcxZjuBqtGW
 VZ3olM1jB/xp9MBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jKaZUmWB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OwJ44SNb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCFGBXeNbli1xV0E1/Pu2ibXHuHwuboSiP51Kabqyq8=;
 b=jKaZUmWBJit/J1aZfVMIuELP7aCVYLWO4ca+va2co0+FFoLDkEv30390wj2DpXXv93hnBW
 8RKWhS8LPYkJMsHkUBPLPMyDdNzJss3I873eP5EVgiZAQzNyKBX2sN6LgyytBEOddRL0U5
 AWNEl1rLFxcqqsYHNNVWijTuXRZ0nUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCFGBXeNbli1xV0E1/Pu2ibXHuHwuboSiP51Kabqyq8=;
 b=OwJ44SNbXWEmKnxdhkHuzgKMPLfG5ekWt4/U73Gocfo8xtuUR6cguWNUvC2vcxZjuBqtGW
 VZ3olM1jB/xp9MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32DB41394A;
 Tue,  5 Nov 2024 18:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QHmJOkBfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/22] tests/qtest/migration: Rename migration-helpers.c
Date: Tue,  5 Nov 2024 15:08:22 -0300
Message-Id: <20241105180837.5990-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4569621E5F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Rename migration-helpers.c to migration-util.c to make its purpose
more explicit and avoid the "helper" terminology.

Move the file to the qtest/migration/ directory along with the rest of
the migration files.

Merge migration-helpers.h into migration-util.h, we don't need two
separate headers.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                       |  4 +-
 tests/qtest/migration-helpers.h               | 54 --------------
 tests/qtest/migration-test.c                  |  1 -
 tests/qtest/migration/migration-qmp.c         |  1 -
 .../migration-util.c}                         |  4 +-
 tests/qtest/migration/migration-util.h        | 72 ++++++++++++++++++-
 tests/qtest/virtio-net-failover.c             |  1 -
 7 files changed, 75 insertions(+), 62 deletions(-)
 delete mode 100644 tests/qtest/migration-helpers.h
 rename tests/qtest/{migration-helpers.c => migration/migration-util.c} (99%)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 30dff3abe0..d90a5ae944 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -329,9 +329,9 @@ endif
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
 migration_files = [files(
-  'migration-helpers.c',
   'migration/bootfile.c',
   'migration/migration-qmp.c',
+  'migration/migration-util.c',
 )]
 
 if gnutls.found()
@@ -345,7 +345,7 @@ endif
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-  'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
+  'dbus-vmstate-test': files('migration/migration-qmp.c', 'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
deleted file mode 100644
index 2cb1f78d9e..0000000000
--- a/tests/qtest/migration-helpers.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * QTest migration helpers
- *
- * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
- *   based on the vhost-user-test.c that is:
- *      Copyright (c) 2014 Virtual Open Systems Sarl.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef MIGRATION_HELPERS_H
-#define MIGRATION_HELPERS_H
-
-#include "libqtest.h"
-
-typedef struct QTestMigrationState {
-    bool stop_seen;
-    bool resume_seen;
-    bool suspend_seen;
-    bool suspend_me;
-} QTestMigrationState;
-
-bool migrate_watch_for_events(QTestState *who, const char *name,
-                              QDict *event, void *opaque);
-
-QDict *migrate_query(QTestState *who);
-QDict *migrate_query_not_failed(QTestState *who);
-
-void wait_for_migration_status(QTestState *who,
-                               const char *goal, const char **ungoals);
-
-void wait_for_migration_complete(QTestState *who);
-
-void wait_for_migration_fail(QTestState *from, bool allow_active);
-
-char *find_common_machine_version(const char *mtype, const char *var1,
-                                  const char *var2);
-char *resolve_machine_version(const char *alias, const char *var1,
-                              const char *var2);
-#ifdef O_DIRECT
-bool probe_o_direct_support(const char *tmpfs);
-#else
-static inline bool probe_o_direct_support(const char *tmpfs)
-{
-    return false;
-}
-#endif
-void migration_test_add(const char *path, void (*fn)(void));
-char *migrate_get_connect_uri(QTestState *who);
-void migrate_set_ports(QTestState *to, QList *channel_list);
-
-#endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f55423467d..308a50a988 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -22,7 +22,6 @@
 #include "crypto/tlscredspsk.h"
 #include "ppc-util.h"
 
-#include "migration-helpers.h"
 #include "migration/bootfile.h"
 #include "migration/migration-util.h"
 #ifdef CONFIG_GNUTLS
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 89e069e96b..ddd1aeddaf 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "migration-helpers.h"
 #include "migration-util.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration/migration-util.c
similarity index 99%
rename from tests/qtest/migration-helpers.c
rename to tests/qtest/migration/migration-util.c
index 218ee4e59f..8a974ded22 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration/migration-util.c
@@ -1,5 +1,5 @@
 /*
- * QTest migration helpers
+ * QTest migration utilities
  *
  * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
  *   based on the vhost-user-test.c that is:
@@ -19,8 +19,8 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 
-#include "migration-helpers.h"
 #include "migration/bootfile.h"
+#include "migration/migration-util.h"
 
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index e73fa5a70c..d75c5db5f3 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -1,7 +1,77 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QTest migration helpers
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
 #ifndef MIGRATION_UTIL_H
 #define MIGRATION_UTIL_H
 
+#include "libqtest.h"
+
+#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
+#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+
+typedef struct QTestMigrationState {
+    bool stop_seen;
+    bool resume_seen;
+    bool suspend_seen;
+    bool suspend_me;
+} QTestMigrationState;
+
+typedef struct MigrationTestEnv {
+    bool has_kvm;
+    bool has_tcg;
+    bool has_uffd;
+    bool has_dirty_ring;
+    bool is_x86;
+    const char *arch;
+    const char *qemu_src;
+    const char *qemu_dst;
+    char *tmpfs;
+} MigrationTestEnv;
+
+/* migration-util.c */
+
+void migration_env_init(MigrationTestEnv *env);
+int migration_env_clean(MigrationTestEnv *env);
+
+bool migrate_watch_for_events(QTestState *who, const char *name,
+                              QDict *event, void *opaque);
+
+QDict *migrate_query(QTestState *who);
+QDict *migrate_query_not_failed(QTestState *who);
+
+void wait_for_migration_status(QTestState *who,
+                               const char *goal, const char **ungoals);
+
+void wait_for_migration_complete(QTestState *who);
+
+void wait_for_migration_fail(QTestState *from, bool allow_active);
+
+char *find_common_machine_version(const char *mtype, const char *var1,
+                                  const char *var2);
+char *resolve_machine_version(const char *alias, const char *var1,
+                              const char *var2);
+#ifdef O_DIRECT
+bool probe_o_direct_support(const char *tmpfs);
+#else
+static inline bool probe_o_direct_support(const char *tmpfs)
+{
+    return false;
+}
+#endif
+void migration_test_add(const char *path, void (*fn)(void));
+char *migrate_get_connect_uri(QTestState *who);
+void migrate_set_ports(QTestState *to, QList *channel_list);
+
+
 /* migration-qmp.c */
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index a1c2c70c3a..99c540b76e 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -11,7 +11,6 @@
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
-#include "migration-helpers.h"
 #include "migration/migration-util.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
-- 
2.35.3


