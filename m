Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B64C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cxz-00080x-R3; Thu, 02 May 2024 16:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cxy-000805-8u
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cxv-0002r6-9w
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEB8F1FD12;
 Thu,  2 May 2024 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGzYmauf/sll2MNsRE/lccE4m4X55xyUFuuSm2IpTYc=;
 b=Cm1STP/0Goavh9/g/uh0+LgBo7f1fmVmSUsUkQ75PXyKNVI/TdLAM+GFr0PCLxO/+66d8P
 wiCoflCJ0ns8KU2YZLE+VhO9iUno7wHzfmFrUzlP0vPAlZqRii3ySBXVJubTnjpRiR9QHO
 r2AUOQ9F0ZAcHiF4+55HEzULuwDiQ/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGzYmauf/sll2MNsRE/lccE4m4X55xyUFuuSm2IpTYc=;
 b=82BViITRf0KvHTMFhtXUGjwXaB3JK/pPQBLz08zQXUTf/r3d8/+8MxbSIuaNr6H9qxaZiT
 SXvhnzKKsWSVFUAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WvjOeVuS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2RqrgpJ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGzYmauf/sll2MNsRE/lccE4m4X55xyUFuuSm2IpTYc=;
 b=WvjOeVuSLfm8cnSaxZyUphHnv4h3RRGANwnFpKgzzBqw2FEC1vpGXSdfRV2JhZ0nN9E6EB
 kQdhqG8YNV/upaCEo7uLtD7+6d+9ayqVg/3xjKn85lPrxfaZsWZ9Uuv6FEiBQ5FxWMsm6B
 mPP5d1CXHMjO5r3yi6gMVBdxCkD9//8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGzYmauf/sll2MNsRE/lccE4m4X55xyUFuuSm2IpTYc=;
 b=2RqrgpJ0x1cVrhwarqg1UrycW5E04LBlKYSY6gGGtVGzcfLs4c9UYNXr20y956UeeUTMCd
 CxAXJM1NjU9MY6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71DA813957;
 Thu,  2 May 2024 20:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2ARMDkj2M2ZZUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 May 2024 20:23:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 09/13] migration: Remove 'blk/-b' option from migrate commands
Date: Thu,  2 May 2024 17:23:12 -0300
Message-Id: <20240502202316.29924-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240502202316.29924-1-farosas@suse.de>
References: <20240502202316.29924-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CEB8F1FD12
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The block migration is considered obsolete and has been deprecated in
8.2. Remove the migrate command option that enables it. This only
affects the QMP and HMP commands, the feature can still be accessed by
setting the migration 'block' capability. The whole feature will be
removed in a future patch.

Deprecation commit 8846b5bfca ("migration: migrate 'blk' command
option is deprecated.").

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml       |   2 +-
 docs/about/deprecated.rst        |   9 --
 docs/about/removed-features.rst  |  14 +++
 hmp-commands.hx                  |  12 +--
 migration/migration-hmp-cmds.c   |   9 +-
 migration/migration.c            |  31 +------
 migration/migration.h            |   4 -
 migration/options.c              |  14 +--
 migration/options.h              |   2 -
 qapi/migration.json              |   8 --
 tests/qemu-iotests/183           | 147 -------------------------------
 tests/qemu-iotests/183.out       |  66 --------------
 tests/qemu-iotests/common.filter |   7 --
 13 files changed, 25 insertions(+), 300 deletions(-)
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 6394b8f41e..3d975f8c34 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -342,7 +342,7 @@ build-tcg-disabled:
     - cd tests/qemu-iotests/
     - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
             052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
-            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
+            170 171 184 192 194 208 221 226 227 236 253 277 image-fleecing
     - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
             124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
             208 209 216 218 227 234 246 247 248 250 254 255 257 258
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ebe53821ed..d739358bb1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -468,15 +468,6 @@ option).
 Migration
 ---------
 
-``blk`` migrate command option (since 8.2)
-''''''''''''''''''''''''''''''''''''''''''
-
-Use blockdev-mirror with NBD instead.
-
-As an intermediate step the ``blk`` functionality can be achieved by
-setting the ``block`` migration capability to ``true``.  But this
-capability is also deprecated.
-
 block migration (since 8.2)
 '''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 7da4b3df14..a491c66660 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -627,6 +627,13 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate`` command option ``blk`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use blockdev-mirror with NBD instead. See "QMP invocation for live
+storage migration with ``blockdev-mirror`` + NBD" in
+docs/interop/live-block-operations.rst for a detailed explanation.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -694,6 +701,13 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate`` command ``-b`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use blockdev-mirror with NBD instead. See "QMP invocation for live
+storage migration with ``blockdev-mirror`` + NBD" in
+docs/interop/live-block-operations.rst for a detailed explanation.
+
 Host Architectures
 ------------------
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7978302949..ebca2cdced 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -909,21 +909,17 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
-        .params     = "[-d] [-b] [-r] uri",
+        .args_type  = "detach:-d,resume:-r,uri:s",
+        .params     = "[-d] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -b for migration without shared storage with"
-		      " full copy of disk\n\t\t\t -r to resume a paused migration",
+		      "\n\t\t\t -r to resume a paused migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-b]`` *uri*
+``migrate [-d]`` *uri*
   Migrate to *uri* (using -d to not wait for completion).
-
-  ``-b``
-    for migration with full copy of disk
 ERST
 
     {
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8446c0721a..734c1d29ce 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -758,26 +758,19 @@ static void hmp_migrate_status_cb(void *opaque)
 void hmp_migrate(Monitor *mon, const QDict *qdict)
 {
     bool detach = qdict_get_try_bool(qdict, "detach", false);
-    bool blk = qdict_get_try_bool(qdict, "blk", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
     g_autoptr(MigrationChannelList) caps = NULL;
     g_autoptr(MigrationChannel) channel = NULL;
 
-    if (blk) {
-        warn_report("option '-b' is deprecated;"
-                    " use blockdev-mirror with NBD instead");
-    }
-
     if (!migrate_uri_parse(uri, &channel, &err)) {
         hmp_handle_error(mon, err);
         return;
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, !!blk, blk, false, false,
-                true, resume, &err);
+    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 11a13fa20c..91327b98c5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1935,14 +1935,8 @@ bool migration_is_blocked(Error **errp)
 }
 
 /* Returns true if continue to migrate, or false if error detected */
-static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
-                            Error **errp)
+static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
 {
-    if (blk) {
-        warn_report("parameter 'blk' is deprecated;"
-                    " use blockdev-mirror with NBD instead");
-    }
-
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
@@ -2027,22 +2021,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
         }
     }
 
-    if (blk) {
-        if (migrate_colo()) {
-            error_setg(errp, "No disk migration is required in COLO mode");
-            return false;
-        }
-        if (migrate_block()) {
-            error_setg(errp, "Command options are incompatible with "
-                       "current migration capabilities");
-            return false;
-        }
-        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
-            return false;
-        }
-        s->must_remove_block_options = true;
-    }
-
     if (migrate_init(s, errp)) {
         return false;
     }
@@ -2051,9 +2029,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
 }
 
 void qmp_migrate(const char *uri, bool has_channels,
-                 MigrationChannelList *channels, bool has_blk, bool blk,
-                 bool has_detach, bool detach, bool has_resume, bool resume,
-                 Error **errp)
+                 MigrationChannelList *channels, bool has_detach, bool detach,
+                 bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
     Error *local_err = NULL;
@@ -2092,7 +2069,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     resume_requested = has_resume && resume;
-    if (!migrate_prepare(s, has_blk && blk, resume_requested, errp)) {
+    if (!migrate_prepare(s, resume_requested, errp)) {
         /* Error detected, put into errp */
         return;
     }
diff --git a/migration/migration.h b/migration/migration.h
index 95995a818e..d51ae43509 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -379,10 +379,6 @@ struct MigrationState {
     /* mutex to protect errp */
     QemuMutex error_mutex;
 
-    /* Do we have to clean up -b/-i from old migrate parameters */
-    /* This feature is deprecated and will be removed */
-    bool must_remove_block_options;
-
     /*
      * Global switch on whether we need to store the global state
      * during migration.
diff --git a/migration/options.c b/migration/options.c
index 5b16d99bd9..856b2fa33c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -486,8 +486,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
 
 #ifndef CONFIG_LIVE_BLOCK_MIGRATION
     if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
-        error_setg(errp, "QEMU compiled without old-style (blk/-b) "
-                   "block migration");
+        error_setg(errp, "QEMU compiled without old-style block migration");
         error_append_hint(errp, "Use blockdev-mirror with NBD instead.\n");
         return false;
     }
@@ -943,17 +942,6 @@ ZeroPageDetection migrate_zero_page_detection(void)
 
 /* parameters helpers */
 
-void block_cleanup_parameters(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    if (s->must_remove_block_options) {
-        /* setting to false can never fail */
-        migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, false, &error_abort);
-        s->must_remove_block_options = false;
-    }
-}
-
 AnnounceParameters *migrate_announce_params(void)
 {
     static AnnounceParameters ap;
diff --git a/migration/options.h b/migration/options.h
index fa5eb177df..e9cb60444f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -95,6 +95,4 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
-void block_cleanup_parameters(void);
-
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index b7d3ad015a..381b52f680 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1705,18 +1705,11 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
-# @blk: do block migration (full disk copy)
-#
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
 # @resume: resume one paused migration, default "off".  (since 3.0)
 #
-# Features:
-#
-# @deprecated: Member @blk is deprecated.  Use blockdev-mirror with
-#     NBD instead.
-#
 # Since: 0.14
 #
 # Notes:
@@ -1782,7 +1775,6 @@
 { 'command': 'migrate',
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
-           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
deleted file mode 100755
index b85770458e..0000000000
--- a/tests/qemu-iotests/183
+++ /dev/null
@@ -1,147 +0,0 @@
-#!/usr/bin/env bash
-# group: rw migration quick
-#
-# Test old-style block migration (migrate -b)
-#
-# Copyright (C) 2017 Red Hat, Inc.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-
-# creator
-owner=kwolf@redhat.com
-
-seq=`basename $0`
-echo "QA output created by $seq"
-
-status=1 # failure is the default!
-
-MIG_SOCKET="${SOCK_DIR}/migrate"
-
-_cleanup()
-{
-    rm -f "${MIG_SOCKET}"
-    _rm_test_img "${TEST_IMG}.dest"
-    _cleanup_test_img
-    _cleanup_qemu
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.filter
-. ./common.qemu
-
-_supported_os Linux FreeBSD NetBSD
-_supported_fmt qcow2 raw qed quorum
-_supported_proto file fuse
-
-size=64M
-_make_test_img $size
-TEST_IMG="${TEST_IMG}.dest" _make_test_img $size
-
-echo
-echo === Starting VMs ===
-echo
-
-qemu_comm_method="qmp"
-
-_launch_qemu \
-    -drive file="${TEST_IMG}",cache=$CACHEMODE,aio=$AIOMODE,driver=$IMGFMT,id=disk
-src=$QEMU_HANDLE
-_send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
-
-_launch_qemu \
-    -drive file="${TEST_IMG}.dest",cache=$CACHEMODE,aio=$AIOMODE,driver=$IMGFMT,id=disk \
-    -incoming "unix:${MIG_SOCKET}"
-dest=$QEMU_HANDLE
-_send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
-
-echo
-echo === Write something on the source ===
-echo
-
-_send_qemu_cmd $src \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk \"write -P 0x55 0 64k\"' } }" \
-    'return'
-_send_qemu_cmd $src \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk \"read -P 0x55 0 64k\"' } }" \
-    'return'
-
-echo
-echo === Do block migration to destination ===
-echo
-
-reply="$(_send_qemu_cmd $src \
-    "{ 'execute': 'migrate',
-       'arguments': { 'uri': 'unix:${MIG_SOCKET}', 'blk': true } }" \
-    'return\|error' | _filter_migration_block_deprecated)"
-echo "$reply"
-if echo "$reply" | grep "compiled without old-style" > /dev/null; then
-    _notrun "migrate -b support not compiled in"
-fi
-
-timeout_comm=$QEMU_COMM_TIMEOUT
-if [ "${VALGRIND_QEMU}" == "y" ]; then
-    QEMU_COMM_TIMEOUT=4
-else
-    QEMU_COMM_TIMEOUT=0.1
-fi
-qemu_cmd_repeat=50 silent=yes \
-    _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" '"status": "completed"'
-QEMU_COMM_TIMEOUT=$timeout_comm
-_send_qemu_cmd $src "{ 'execute': 'query-status' }" "return"
-
-echo
-echo === Do some I/O on the destination ===
-echo
-
-# It is important that we use the BlockBackend of the guest device here instead
-# of the node name, which would create a new BlockBackend and not test whether
-# the guest has the necessary permissions to access the image now
-silent=yes _send_qemu_cmd $dest "" "100 %"
-_send_qemu_cmd $dest "{ 'execute': 'query-status' }" "return"
-_send_qemu_cmd $dest \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk \"read -P 0x55 0 64k\"' } }" \
-    'return'
-_send_qemu_cmd $dest \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk \"write -P 0x66 1M 64k\"' } }" \
-    'return'
-
-echo
-echo === Shut down and check image ===
-echo
-
-_send_qemu_cmd $src '{"execute":"quit"}' 'return'
-_send_qemu_cmd $dest '{"execute":"quit"}' 'return'
-wait=1 _cleanup_qemu
-
-_check_test_img
-TEST_IMG="${TEST_IMG}.dest" _check_test_img
-
-$QEMU_IO -c 'write -P 0x66 1M 64k' "$TEST_IMG" | _filter_qemu_io
-$QEMU_IMG compare "$TEST_IMG.dest" "$TEST_IMG"
-
-# success, all done
-echo "*** done"
-rm -f $seq.full
-status=0
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
deleted file mode 100644
index 8aef74a25d..0000000000
--- a/tests/qemu-iotests/183.out
+++ /dev/null
@@ -1,66 +0,0 @@
-QA output created by 183
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=IMGFMT size=67108864
-
-=== Starting VMs ===
-
-{ 'execute': 'qmp_capabilities' }
-{"return": {}}
-{ 'execute': 'qmp_capabilities' }
-{"return": {}}
-
-=== Write something on the source ===
-
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk "write -P 0x55 0 64k"' } }
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk "read -P 0x55 0 64k"' } }
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-
-=== Do block migration to destination ===
-
-{ 'execute': 'migrate',
-       'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
-{"return": {}}
-{ 'execute': 'query-status' }
-{"return": {"status": "postmigrate", "running": false}}
-
-=== Do some I/O on the destination ===
-
-{ 'execute': 'query-status' }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
-{"return": {"status": "running", "running": true}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk "read -P 0x55 0 64k"' } }
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk "write -P 0x66 1M 64k"' } }
-wrote 65536/65536 bytes at offset 1048576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-
-=== Shut down and check image ===
-
-{"execute":"quit"}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-{"return": {}}
-{"execute":"quit"}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-{"return": {}}
-No errors were found on the image.
-No errors were found on the image.
-wrote 65536/65536 bytes at offset 1048576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Images are identical.
-*** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 2846c83808..fc3c64bcb8 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -359,12 +359,5 @@ _filter_qcow2_compression_type_bit()
         -e 's/\(incompatible_features.*\), 3\(,.*\)/\1\2/'
 }
 
-# filter warnings caused for block migration deprecation
-_filter_migration_block_deprecated()
-{
-    gsed -e '/warning: parameter .blk. is deprecated; use blockdev-mirror with NBD instead/d' \
-         -e '/warning: block migration is deprecated; use blockdev-mirror with NBD instead/d'
-}
-
 # make sure this script returns success
 true
-- 
2.35.3


