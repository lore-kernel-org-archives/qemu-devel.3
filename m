Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A41CA0EFA
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 21:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upw6F-0004VK-3l; Sat, 23 Aug 2025 17:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6C-0004Tf-Io
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:32 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw69-000543-MC
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D14F2807CA;
 Sun, 24 Aug 2025 00:48:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a5d::1:36])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Nmd3dr0GuSw0-J7Xc0DHy; Sun, 24 Aug 2025 00:48:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755985706;
 bh=kxovEUtU6YaTA5oc//90u76Nkj25zCDmGOze5dgMzHk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vwswRc2y3/wcTulu+WvG4Mr85aKGJxpr9a5qUTe+bjgAILTkwwMocMDrCha3v1i9m
 M8SKLqzHoaKqVJPutirsrwbO/FmLas5l+U4nGcm3Yrxgg6cu5A4mp8NsBaxPTrGrCa
 Nh25rGcMK4vWsdoMA6/KlipU2ZfCXz4XOwMQf058=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, yc-core@yandex-team.ru
Subject: [RFC 3/7] qapi: add interface for local TAP migration
Date: Sun, 24 Aug 2025 00:48:17 +0300
Message-ID: <20250823214821.48342-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823214821.48342-1-vsementsov@yandex-team.ru>
References: <20250823214821.48342-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

To migrate TAP device (including open fds) locally, user should:

1. enable local-tap migration capability both on source and target
2. use additional local-incoming=true option for tap on target

Why capability is not enough? We need an option to modify early
initialization of TAP, to avoid opening new fds. The capability
may not be set at the moment of netdev initialization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/options.c |  7 +++++++
 migration/options.h |  1 +
 qapi/migration.json |  9 ++++++++-
 qapi/net.json       | 12 +++++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 11b719c81b..fd0cca97b3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -276,6 +276,13 @@ bool migrate_local_vhost_user_blk(void)
     return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK];
 }
 
+bool migrate_local_tap(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_TAP];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 5a40ac073d..aa0ab6a61f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -32,6 +32,7 @@ bool migrate_events(void);
 bool migrate_mapped_ram(void);
 bool migrate_local_char_socket(void);
 bool migrate_local_vhost_user_blk(void);
+bool migrate_local_tap(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index ead7f4d17c..bf554684f4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -529,6 +529,12 @@
 #     For target device also @local-incoming option must be specified
 #     (since 10.2)
 #
+# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
+#     descriptors and TAP-related state are migrated. Only may be
+#     used when migration channel is unix socket. For target device
+#     also @local-incoming option must be specified (since 10.2)
+#     (since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-colo, @x-ignore-shared, @local-char-socket,
@@ -551,7 +557,8 @@
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
            'dirty-limit', 'mapped-ram',
            { 'name': 'local-char-socket', 'features': [ 'unstable' ] },
-           { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] } ] }
+           { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] },
+           { 'name': 'local-tap', 'features': [ 'unstable' ] } ] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..8f53549d58 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -353,6 +353,15 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @local-incoming: Do load open file descriptor for that TAP
+#     on incoming migration. May be used only if QEMU is started
+#     for incoming migration. Will work only together with local-tap
+#     migration capability enabled (default: false) (Since: 10.2)
+#
+# Features:
+#
+# @unstable: Member @local-incoming is experimental
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -371,7 +380,8 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } } }
 
 ##
 # @NetdevSocketOptions:
-- 
2.48.1


