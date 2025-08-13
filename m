Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74798CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg3-00037F-Dq; Wed, 13 Aug 2025 12:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfm-0002pC-Vs; Wed, 13 Aug 2025 12:49:59 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfN-0007sY-SQ; Wed, 13 Aug 2025 12:49:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2AAFB81392;
 Wed, 13 Aug 2025 19:49:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-zEYONDc4; Wed, 13 Aug 2025 19:49:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103761;
 bh=Wp+4GceFeTBXu9j82YWHNLbIdiUNa1OHM2J6/qAbIfM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yDnKq5SbtdknzNvdH+vl1dfbw6wNj2qtOHpMuFuKbD0x8LsES4qPZLDeQovwlFv31
 C6OahqMKQDRHOQlSLpnR3/44OXJOsIhHT/3HPfOjytsNJ+tNF2JZ3AeiS+KNms/quq
 lZVW3q8vbm5iZRSIV2t+xsuoWTAioWf4WZRGkLkk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 24/33] chardev-add: support local migration
Date: Wed, 13 Aug 2025 19:48:45 +0300
Message-ID: <20250813164856.950363-25-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This commit introduces a possibility to migrate open chardev
socket fd through migration channel without reconnecting.

For this, user should:
 - enable new migration capability local-char-socket
 - mark the socket by an option support-local-migration=true
 - on target add local-incoming=true option to the socket

Motivation for the API:

1. We don't want to migrate all sockets. For example, QMP-connection is
   bad candidate, as it is separate on source and target. So, we need
   @support-local-migration option to mark sockets, which we want to
   migrate (after this series, we'll want to migrate chardev used to
   connect with vhost-user-server).

2. Still, for remote migration, we can't migrate any sockets, so, we
   need a capability, to enable/disable the whole feature.

3. And finally, we need a sign for the socket to not open a connection
   on initialization, but wait for incoming migration. We can't use
   @support-local-migration option for it, as it may be enabled, but we
   are in incoming-remote migration. Also, we can't rely on the
   migration capability, as user is free to setup capabilities before or
   after chardev creation, and it would be a bad precedent to create
   relations here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-socket.c         | 101 +++++++++++++++++++++++++++++++++-
 include/chardev/char-socket.h |   3 +
 migration/options.c           |   7 +++
 migration/options.h           |   1 +
 qapi/char.json                |  16 +++++-
 qapi/migration.json           |   8 ++-
 stubs/meson.build             |   1 +
 stubs/qemu_file.c             |  15 +++++
 stubs/vmstate.c               |   6 ++
 tests/qtest/meson.build       |   2 +-
 tests/unit/meson.build        |   4 +-
 11 files changed, 158 insertions(+), 6 deletions(-)
 create mode 100644 stubs/qemu_file.c

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1e8313915b..db6616e2f2 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "chardev/char.h"
+#include "qapi-types-char.h"
 #include "io/channel-socket.h"
 #include "io/channel-websock.h"
 #include "qemu/error-report.h"
@@ -34,6 +35,10 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/yank.h"
 #include "trace.h"
+#include "migration/vmstate.h"
+#include "migration/qemu-file.h"
+#include "migration/migration.h"
+#include "hw/vmstate-if.h"
 
 #include "chardev/char-io.h"
 #include "chardev/char-socket.h"
@@ -1118,6 +1123,7 @@ static void char_socket_finalize(Object *obj)
         object_unref(OBJECT(s->tls_creds));
     }
     g_free(s->tls_authz);
+    g_free(s->vmstate_name);
     if (s->registered_yank) {
         /*
          * In the chardev-change special-case, we shouldn't unregister the yank
@@ -1276,8 +1282,15 @@ static int qmp_chardev_open_socket_client(Chardev *chr,
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
+    s->reconnect_time_ms = reconnect_ms;
+
+    if (s->local_incoming) {
+        /* We'll get fd at migreation load. This field works once */
+        s->local_incoming = false;
+        return 0;
+    }
+
     if (reconnect_ms > 0) {
-        s->reconnect_time_ms = reconnect_ms;
         tcp_chr_connect_client_async(chr);
         return 0;
     } else {
@@ -1367,6 +1380,52 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
     return true;
 }
 
+static int char_socket_save(QEMUFile *f, void *opaque, size_t size,
+                           const VMStateField *field, JSONWriter *vmdesc)
+{
+    SocketChardev *s = opaque;
+
+    warn_report("%s", __func__);
+    return qemu_file_put_fd(f, s->sioc->fd);
+}
+
+static int char_socket_load(QEMUFile *f, void *opaque, size_t size,
+                           const VMStateField *field)
+{
+    Chardev *chr = opaque;
+
+    int fd = qemu_file_get_fd(f);
+    warn_report("%s %d", __func__, fd);
+    if (fd < 0) {
+        return fd;
+    }
+    return tcp_chr_add_client(chr, fd);
+}
+
+static bool char_socket_needed(void *opaque)
+{
+    SocketChardev *s = opaque;
+
+    return !!s->vmstate_name;
+}
+
+const VMStateDescription vmstate_char_socket = {
+    .name = "char_socket",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = char_socket_needed,
+    .fields = (VMStateField[]) {
+        {
+            .name = "fd",
+            .info = &(const VMStateInfo) {
+                .name = "fd",
+                .get = char_socket_load,
+                .put = char_socket_save,
+            },
+        },
+        VMSTATE_END_OF_LIST()
+    },
+};
 
 static void qmp_chardev_open_socket(Chardev *chr,
                                     ChardevBackend *backend,
@@ -1381,14 +1440,36 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
+    bool support_local_mig = sock->has_support_local_migration
+                                 ? sock->support_local_migration
+                                 : false;
+    bool local_incoming = sock->local_incoming;
     int64_t reconnect_ms = 0;
     SocketAddress *addr;
 
+    if (support_local_mig && is_listen) {
+        error_setg(errp,
+                   "local migration is not supported for listening sockets");
+        return;
+    }
+
+    if (support_local_mig && !(chr->label && chr->label[0])) {
+        error_setg(errp,
+                   "local migration is not supported for unnamed chardevs");
+        return;
+    }
+
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
     s->is_tn3270 = is_tn3270;
     s->is_websock = is_websock;
     s->do_nodelay = do_nodelay;
+    s->local_incoming = local_incoming;
+
+    if (support_local_mig) {
+        s->vmstate_name = g_strdup_printf("__yc-chardev-%s", chr->label);
+    }
+
     if (sock->tls_creds) {
         Object *creds;
         creds = object_resolve_path_component(
@@ -1448,6 +1529,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     update_disconnected_filename(s);
 
     if (s->is_listen) {
+        assert(!s->vmstate_name);
         if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
                                            is_waitconnect, errp) < 0) {
             return;
@@ -1463,6 +1545,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
             return;
         }
     }
+
+    vmstate_register(VMSTATE_IF(s), -1, &vmstate_char_socket, s);
 }
 
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
@@ -1581,9 +1665,20 @@ char_socket_get_connected(Object *obj, Error **errp)
     return s->state == TCP_CHARDEV_STATE_CONNECTED;
 }
 
+static char *
+char_socket_if_get_id(VMStateIf *obj)
+{
+    SocketChardev *s = SOCKET_CHARDEV(obj);
+
+    return s->vmstate_name;
+}
+
 static void char_socket_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
+    VMStateIfClass *vc = VMSTATE_IF_CLASS(oc);
+
+    vc->get_id = char_socket_if_get_id;
 
     cc->supports_yank = true;
 
@@ -1613,6 +1708,10 @@ static const TypeInfo char_socket_type_info = {
     .instance_size = sizeof(SocketChardev),
     .instance_finalize = char_socket_finalize,
     .class_init = char_socket_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_VMSTATE_IF },
+        { }
+    }
 };
 
 static void register_types(void)
diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
index d6d13ad37f..69b9609215 100644
--- a/include/chardev/char-socket.h
+++ b/include/chardev/char-socket.h
@@ -78,6 +78,9 @@ struct SocketChardev {
     bool connect_err_reported;
 
     QIOTask *connect_task;
+
+    char *vmstate_name;
+    bool local_incoming;
 };
 typedef struct SocketChardev SocketChardev;
 
diff --git a/migration/options.c b/migration/options.c
index 4e923a2e07..dffb6910f4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -262,6 +262,13 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_local_char_socket(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_CHAR_SOCKET];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..40971f0aa0 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -30,6 +30,7 @@ bool migrate_colo(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
+bool migrate_local_char_socket(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/qapi/char.json b/qapi/char.json
index f0a53f742c..5b535c196a 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -280,11 +280,23 @@
 #     mutually exclusive with @reconnect.
 #     (default: 0) (Since: 9.2)
 #
+# @support-local-migration: The socket open file descriptor will
+#     migrate if this field is true and local-char-socket migration
+#     capability enabled (default: false) (Since: 10.2)
+#
+# @local-incoming: Do load open file descriptor for the socket
+#     on incoming migration. May be used only if QEMU is started
+#     for incoming migration and only together with local-char-socket
+#     migration capability (default: false) (Since: 10.2)
+#
 # Features:
 #
 # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
 #     instead.
 #
+# @unstable: Members @support-local-migration and @local-incoming
+#            are experimental
+#
 # Since: 1.4
 ##
 { 'struct': 'ChardevSocket',
@@ -298,7 +310,9 @@
             '*tn3270': 'bool',
             '*websocket': 'bool',
             '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
-            '*reconnect-ms': 'int' },
+            '*reconnect-ms': 'int',
+            '*support-local-migration': { 'type': 'bool', 'features': [ 'unstable' ] },
+            '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } },
   'base': 'ChardevCommon' }
 
 ##
diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..4f282d168e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -517,6 +517,11 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @local-char-socket: Migrate socket chardevs open file descriptors.
+#     Only may be used when migration channel is unix socket. Only
+#     involves socket chardevs with "support-local-migration" option
+#     enabled.  (since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -536,7 +541,8 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram',
+           { 'name': 'local-char-socket', 'features': [ 'unstable' ] } ] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e685..7855483639 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -50,6 +50,7 @@ if have_block or have_user
   stub_ss.add(files('qtest.c'))
   stub_ss.add(files('vm-stop.c'))
   stub_ss.add(files('vmstate.c'))
+  stub_ss.add(files('qemu_file.c'))
 endif
 
 if have_user
diff --git a/stubs/qemu_file.c b/stubs/qemu_file.c
new file mode 100644
index 0000000000..854d4c13cd
--- /dev/null
+++ b/stubs/qemu_file.c
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "migration/qemu-file.h"
+
+
+int qemu_file_get_fd(QEMUFile *f)
+{
+    return -1;
+}
+
+int qemu_file_put_fd(QEMUFile *f, int fd)
+{
+    return -1;
+}
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index c190762d7c..f345edf3c9 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -2,6 +2,7 @@
 #include "migration/vmstate.h"
 #include "qapi/qapi-types-migration.h"
 #include "migration/client-options.h"
+#include "migration/options.h"
 
 int vmstate_register_with_alias_id(VMStateIf *obj,
                                    uint32_t instance_id,
@@ -28,3 +29,8 @@ MigMode migrate_mode(void)
 {
     return MIG_MODE_NORMAL;
 }
+
+bool migrate_local_char_socket(void)
+{
+    return false;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..8be0c1dc7c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -381,7 +381,7 @@ qtests = {
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
-  'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
+  'qos-test': [chardev, io, qos_test_ss.apply({}).sources(), '../../hw/core/vmstate-if.c'],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..b96f4dcabe 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -139,7 +139,7 @@ if have_system
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
     'test-vmstate': [migration, io],
-    'test-yank': ['socket-helpers.c', qom, io, chardev]
+    'test-yank': ['socket-helpers.c', qom, io, chardev, '../../hw/core/vmstate-if.c']
   }
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
@@ -151,7 +151,7 @@ if have_system
   if not get_option('tsan')
     if host_os != 'windows'
         tests += {
-          'test-char': ['socket-helpers.c', qom, io, chardev]
+          'test-char': ['socket-helpers.c', qom, io, chardev, '../../hw/core/vmstate-if.c']
         }
     endif
 
-- 
2.48.1


