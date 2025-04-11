Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FBDC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3JrJ-0005B8-9k; Fri, 11 Apr 2025 15:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jqk-0004Wm-8i
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jqf-0006DG-Aq
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C7D71F457;
 Fri, 11 Apr 2025 19:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/m+pXLLfiGaLIZK5bBwSiENXUpk1Dej3SgeSnZkU/8=;
 b=TMreZ2h5fwURomuvQivUjgDYMAfmk2DOg8gSBl/tYnVQBeuFvVbumFsGJdpgGY1ql+7bK1
 +HPTZcHWb6FBNzG2DYOSMw3JdBPhb5ri/OIfLcz9m+Zzxu/EfxgYFKPblwGQo0xsNOmCAK
 BY71zPp3kPF04qCE9WmaeSto9h1VTug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/m+pXLLfiGaLIZK5bBwSiENXUpk1Dej3SgeSnZkU/8=;
 b=L4CmK2vWbJh2MbvgzaYQs/Z1jTFzMmIxi+QfOxKIHsvqvphr6jW4Ljpr+sZvg7NmYq9bXz
 zxu5eAerM0En9WBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TMreZ2h5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L4CmK2vW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/m+pXLLfiGaLIZK5bBwSiENXUpk1Dej3SgeSnZkU/8=;
 b=TMreZ2h5fwURomuvQivUjgDYMAfmk2DOg8gSBl/tYnVQBeuFvVbumFsGJdpgGY1ql+7bK1
 +HPTZcHWb6FBNzG2DYOSMw3JdBPhb5ri/OIfLcz9m+Zzxu/EfxgYFKPblwGQo0xsNOmCAK
 BY71zPp3kPF04qCE9WmaeSto9h1VTug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/m+pXLLfiGaLIZK5bBwSiENXUpk1Dej3SgeSnZkU/8=;
 b=L4CmK2vWbJh2MbvgzaYQs/Z1jTFzMmIxi+QfOxKIHsvqvphr6jW4Ljpr+sZvg7NmYq9bXz
 zxu5eAerM0En9WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 937CB13886;
 Fri, 11 Apr 2025 19:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +KlSFTpq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:15:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 10/13] migration: Replace s->capabilities with s->config
Date: Fri, 11 Apr 2025 16:14:40 -0300
Message-Id: <20250411191443.22565-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C7D71F457
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Continuing with the removal of parameters and capabilities, replace
the internal usage of s->capabilities with MigrationConfig.

To keep compatibility with the special format of the user-facing
migrate-set-capabilities and query-migrate-capabilities, introduce a
few compatibility routines to convert between
MigrationCapabilityStatusList and MigrationConfig.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |   4 +-
 migration/migration.h |   1 -
 migration/options.c   | 361 +++++++++++++++++++++++++-----------------
 migration/options.h   |  16 +-
 migration/savevm.c    |   8 +-
 5 files changed, 227 insertions(+), 163 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8ca1383b46..031e0ade16 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4064,8 +4064,6 @@ static void migration_instance_init(Object *obj)
  */
 static bool migration_object_check(MigrationState *ms, Error **errp)
 {
-    /* Assuming all off */
-    bool old_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
     g_autoptr(MigrationConfig) globals = NULL;
 
     /*
@@ -4089,7 +4087,7 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
      * 'globals' because the values are already in s->config.
      */
 
-    return migrate_caps_check(old_caps, ms->capabilities, errp);
+    return migrate_caps_check(&ms->config, errp);
 }
 
 static const TypeInfo migration_type = {
diff --git a/migration/migration.h b/migration/migration.h
index 8e6aa595b6..c5a7d356e8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -356,7 +356,6 @@ struct MigrationState {
     int64_t downtime_start;
     int64_t downtime;
     int64_t expected_downtime;
-    bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
 
     /*
diff --git a/migration/options.c b/migration/options.c
index 0bdd9e23f6..562f58263f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -80,9 +80,6 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
-#define DEFINE_PROP_MIG_CAP(name, x)             \
-    DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
-
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
@@ -176,30 +173,40 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        config.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
-
-    /* Migration capabilities */
-    DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
-    DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
-    DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
-    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
-    DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
-    DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
-    DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
-                        MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
-    DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
-    DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
-    DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
-    DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
-    DEFINE_PROP_MIG_CAP("x-background-snapshot",
-            MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
+    DEFINE_PROP_BOOL("x-xbzrle",
+                     MigrationState, config.xbzrle, false),
+    DEFINE_PROP_BOOL("x-rdma-pin-all",
+                     MigrationState, config.rdma_pin_all, false),
+    DEFINE_PROP_BOOL("x-auto-converge",
+                     MigrationState, config.auto_converge, false),
+    DEFINE_PROP_BOOL("x-zero-blocks",
+                     MigrationState, config.zero_blocks, false),
+    DEFINE_PROP_BOOL("x-events",
+                     MigrationState, config.events, false),
+    DEFINE_PROP_BOOL("x-postcopy-ram",
+                     MigrationState, config.postcopy_ram, false),
+    DEFINE_PROP_BOOL("x-postcopy-preempt",
+                     MigrationState, config.postcopy_preempt, false),
+    DEFINE_PROP_BOOL("x-colo",
+                     MigrationState, config.x_colo, false),
+    DEFINE_PROP_BOOL("x-release-ram",
+                     MigrationState, config.release_ram, false),
+    DEFINE_PROP_BOOL("x-return-path",
+                     MigrationState, config.return_path, false),
+    DEFINE_PROP_BOOL("x-multifd",
+                     MigrationState, config.multifd, false),
+    DEFINE_PROP_BOOL("x-background-snapshot",
+                     MigrationState, config.background_snapshot, false),
 #ifdef CONFIG_LINUX
-    DEFINE_PROP_MIG_CAP("x-zero-copy-send",
-            MIGRATION_CAPABILITY_ZERO_COPY_SEND),
+    DEFINE_PROP_BOOL("x-zero-copy-send",
+                     MigrationState, config.zero_copy_send, false),
 #endif
-    DEFINE_PROP_MIG_CAP("x-switchover-ack",
-                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
-    DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
-    DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
+    DEFINE_PROP_BOOL("x-switchover-ack",
+                     MigrationState, config.switchover_ack, false),
+    DEFINE_PROP_BOOL("x-dirty-limit",
+                     MigrationState, config.dirty_limit, false),
+    DEFINE_PROP_BOOL("mapped-ram",
+                     MigrationState, config.mapped_ram, false),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
@@ -207,7 +214,7 @@ bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
+    return s->config.auto_converge;
 }
 
 bool migrate_send_switchover_start(void)
@@ -221,144 +228,142 @@ bool migrate_background_snapshot(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT];
+    return s->config.background_snapshot;
 }
 
 bool migrate_colo(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_X_COLO];
+    return s->config.x_colo;
 }
 
 bool migrate_dirty_bitmaps(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
+    return s->config.dirty_bitmaps;
 }
 
 bool migrate_dirty_limit(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_LIMIT];
+    return s->config.dirty_limit;
 }
 
 bool migrate_events(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_EVENTS];
+    return s->config.events;
 }
 
 bool migrate_mapped_ram(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
+    return s->config.mapped_ram;
 }
 
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_X_IGNORE_SHARED];
+    return s->config.x_ignore_shared;
 }
 
 bool migrate_late_block_activate(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE];
+    return s->config.late_block_activate;
 }
 
 bool migrate_multifd(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
+    return s->config.multifd;
 }
 
 bool migrate_pause_before_switchover(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER];
+    return s->config.pause_before_switchover;
 }
 
 bool migrate_postcopy_blocktime(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
+    return s->config.postcopy_blocktime;
 }
 
 bool migrate_postcopy_preempt(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT];
+    return s->config.postcopy_preempt;
 }
 
 bool migrate_postcopy_ram(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM];
+    return s->config.postcopy_ram;
 }
 
 bool migrate_rdma_pin_all(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL];
+    return s->config.rdma_pin_all;
 }
 
 bool migrate_release_ram(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
+    return s->config.release_ram;
 }
 
 bool migrate_return_path(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
+    return s->config.return_path;
 }
 
 bool migrate_switchover_ack(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
+    return s->config.switchover_ack;
 }
 
 bool migrate_validate_uuid(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_VALIDATE_UUID];
+    return s->config.validate_uuid;
 }
 
 bool migrate_xbzrle(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_XBZRLE];
+    return s->config.xbzrle;
 }
 
 bool migrate_zero_copy_send(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_ZERO_COPY_SEND];
+    return s->config.zero_copy_send;
 }
 
-/* pseudo capabilities */
-
 bool migrate_multifd_flush_after_each_section(void)
 {
     MigrationState *s = migrate_get_current();
@@ -403,63 +408,25 @@ WriteTrackingSupport migrate_query_write_tracking(void)
     return WT_SUPPORT_COMPATIBLE;
 }
 
-/* Migration capabilities set */
-struct MigrateCapsSet {
-    int size;                       /* Capability set size */
-    MigrationCapability caps[];     /* Variadic array of capabilities */
-};
-typedef struct MigrateCapsSet MigrateCapsSet;
-
-/* Define and initialize MigrateCapsSet */
-#define INITIALIZE_MIGRATE_CAPS_SET(_name, ...)   \
-    MigrateCapsSet _name = {    \
-        .size = sizeof((int []) { __VA_ARGS__ }) / sizeof(int), \
-        .caps = { __VA_ARGS__ } \
-    }
-
-/* Background-snapshot compatibility check list */
-static const
-INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
-    MIGRATION_CAPABILITY_POSTCOPY_RAM,
-    MIGRATION_CAPABILITY_DIRTY_BITMAPS,
-    MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME,
-    MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
-    MIGRATION_CAPABILITY_RETURN_PATH,
-    MIGRATION_CAPABILITY_MULTIFD,
-    MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
-    MIGRATION_CAPABILITY_AUTO_CONVERGE,
-    MIGRATION_CAPABILITY_RELEASE_RAM,
-    MIGRATION_CAPABILITY_RDMA_PIN_ALL,
-    MIGRATION_CAPABILITY_XBZRLE,
-    MIGRATION_CAPABILITY_X_COLO,
-    MIGRATION_CAPABILITY_VALIDATE_UUID,
-    MIGRATION_CAPABILITY_ZERO_COPY_SEND);
-
 static bool migrate_incoming_started(void)
 {
     return !!migration_incoming_get_current()->transport_data;
 }
 
-/**
- * @migration_caps_check - check capability compatibility
- *
- * @old_caps: old capability list
- * @new_caps: new capability list
- * @errp: set *errp if the check failed, with reason
- *
- * Returns true if check passed, otherwise false.
- */
-bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
+bool migrate_caps_check(MigrationConfig *new, Error **errp)
 {
-    ERRP_GUARD();
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
+    bool postcopy_already_on = s->config.postcopy_ram;
+    ERRP_GUARD();
 
-    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
+
+    if (new->zero_blocks) {
         warn_report("zero-blocks capability is deprecated");
     }
 
 #ifndef CONFIG_REPLICATION
-    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+    if (new->x_colo) {
         error_setg(errp, "QEMU compiled without replication module"
                    " can't enable COLO");
         error_append_hint(errp, "Please enable replication before COLO.\n");
@@ -467,32 +434,32 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 #endif
 
-    if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+    if (new->postcopy_ram) {
         /* This check is reasonably expensive, so only when it's being
          * set the first time, also it's only the destination that needs
          * special support.
          */
-        if (!old_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] &&
+        if (!postcopy_already_on &&
             runstate_check(RUN_STATE_INMIGRATE) &&
             !postcopy_ram_supported_by_host(mis, errp)) {
             error_prepend(errp, "Postcopy is not supported: ");
             return false;
         }
 
-        if (new_caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED]) {
+        if (new->x_ignore_shared) {
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
 
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        if (new->multifd) {
             error_setg(errp, "Postcopy is not yet compatible with multifd");
             return false;
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
+    if (new->background_snapshot) {
         WriteTrackingSupport wt_support;
-        int idx;
+
         /*
          * Check if 'background-snapshot' capability is supported by
          * host kernel and compatible with guest memory configuration.
@@ -508,41 +475,45 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
 
-        /*
-         * Check if there are any migration capabilities
-         * incompatible with 'background-snapshot'.
-         */
-        for (idx = 0; idx < check_caps_background_snapshot.size; idx++) {
-            int incomp_cap = check_caps_background_snapshot.caps[idx];
-            if (new_caps[incomp_cap]) {
-                error_setg(errp,
-                        "Background-snapshot is not compatible with %s",
-                        MigrationCapability_str(incomp_cap));
-                return false;
-            }
+        if (new->postcopy_ram ||
+            new->dirty_bitmaps ||
+            new->postcopy_blocktime ||
+            new->late_block_activate ||
+            new->return_path ||
+            new->multifd ||
+            new->pause_before_switchover ||
+            new->auto_converge ||
+            new->release_ram ||
+            new->rdma_pin_all ||
+            new->xbzrle ||
+            new->x_colo ||
+            new->validate_uuid ||
+            new->zero_copy_send) {
+            error_setg(errp,
+                       "Background-snapshot is not compatible with "
+                       "currently set capabilities");
+            return false;
         }
     }
 
 #ifdef CONFIG_LINUX
-    if (new_caps[MIGRATION_CAPABILITY_ZERO_COPY_SEND] &&
-        (!new_caps[MIGRATION_CAPABILITY_MULTIFD] ||
-         new_caps[MIGRATION_CAPABILITY_XBZRLE] ||
-         migrate_multifd_compression() ||
-         migrate_tls())) {
+    if (new->zero_copy_send &&
+        (!new->multifd || new->xbzrle ||
+         migrate_multifd_compression() || migrate_tls())) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
     }
 #else
-    if (new_caps[MIGRATION_CAPABILITY_ZERO_COPY_SEND]) {
+    if (new->zero_copy_send) {
         error_setg(errp,
                    "Zero copy currently only available on Linux");
         return false;
     }
 #endif
 
-    if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT]) {
-        if (!new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+    if (new->postcopy_preempt) {
+        if (!new->postcopy_ram) {
             error_setg(errp, "Postcopy preempt requires postcopy-ram");
             return false;
         }
@@ -554,22 +525,22 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+    if (new->multifd) {
         if (migrate_incoming_started()) {
             error_setg(errp, "Multifd must be set before incoming starts");
             return false;
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK]) {
-        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+    if (new->switchover_ack) {
+        if (!new->return_path) {
             error_setg(errp, "Capability 'switchover-ack' requires capability "
                              "'return-path'");
             return false;
         }
     }
-    if (new_caps[MIGRATION_CAPABILITY_DIRTY_LIMIT]) {
-        if (new_caps[MIGRATION_CAPABILITY_AUTO_CONVERGE]) {
+    if (new->dirty_limit) {
+        if (new->auto_converge) {
             error_setg(errp, "dirty-limit conflicts with auto-converge"
                        " either of then available currently");
             return false;
@@ -582,21 +553,21 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
+    if (new->multifd) {
+        if (new->xbzrle) {
             error_setg(errp, "Multifd is not compatible with xbzrle");
             return false;
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM]) {
-        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
+    if (new->mapped_ram) {
+        if (new->xbzrle) {
             error_setg(errp,
                        "Mapped-ram migration is incompatible with xbzrle");
             return false;
         }
 
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        if (new->postcopy_ram) {
             error_setg(errp,
                        "Mapped-ram migration is incompatible with postcopy");
             return false;
@@ -616,37 +587,143 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
         caps = g_malloc0(sizeof(*caps));
         caps->capability = i;
-        caps->state = s->capabilities[i];
+        caps->state = migrate_config_get_cap_compat(&s->config, i);
         QAPI_LIST_APPEND(tail, caps);
     }
 
     return head;
 }
 
+static bool *migrate_config_get_cap_addr(MigrationConfig *config, int i)
+{
+    bool *cap_addr = NULL;
+
+    switch (i) {
+    case MIGRATION_CAPABILITY_XBZRLE:
+        cap_addr = &config->xbzrle;
+        break;
+    case MIGRATION_CAPABILITY_RDMA_PIN_ALL:
+        cap_addr = &config->rdma_pin_all;
+        break;
+    case MIGRATION_CAPABILITY_AUTO_CONVERGE:
+        cap_addr = &config->auto_converge;
+        break;
+    case MIGRATION_CAPABILITY_ZERO_BLOCKS:
+        cap_addr = &config->zero_blocks;
+        break;
+    case MIGRATION_CAPABILITY_EVENTS:
+        cap_addr = &config->events;
+        break;
+    case MIGRATION_CAPABILITY_POSTCOPY_RAM:
+        cap_addr = &config->postcopy_ram;
+        break;
+    case MIGRATION_CAPABILITY_X_COLO:
+        cap_addr = &config->x_colo;
+        break;
+    case MIGRATION_CAPABILITY_RELEASE_RAM:
+        cap_addr = &config->release_ram;
+        break;
+    case MIGRATION_CAPABILITY_RETURN_PATH:
+        cap_addr = &config->return_path;
+        break;
+    case MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER:
+        cap_addr = &config->pause_before_switchover;
+        break;
+    case MIGRATION_CAPABILITY_MULTIFD:
+        cap_addr = &config->multifd;
+        break;
+    case MIGRATION_CAPABILITY_DIRTY_BITMAPS:
+        cap_addr = &config->dirty_bitmaps;
+        break;
+    case MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME:
+        cap_addr = &config->postcopy_blocktime;
+        break;
+    case MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE:
+        cap_addr = &config->late_block_activate;
+        break;
+    case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+        cap_addr = &config->x_ignore_shared;
+        break;
+    case MIGRATION_CAPABILITY_VALIDATE_UUID:
+        cap_addr = &config->validate_uuid;
+        break;
+    case MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT:
+        cap_addr = &config->background_snapshot;
+        break;
+    case MIGRATION_CAPABILITY_ZERO_COPY_SEND:
+        cap_addr = &config->zero_copy_send;
+        break;
+    case MIGRATION_CAPABILITY_POSTCOPY_PREEMPT:
+        cap_addr = &config->postcopy_preempt;
+        break;
+    case MIGRATION_CAPABILITY_SWITCHOVER_ACK:
+        cap_addr = &config->switchover_ack;
+        break;
+    case MIGRATION_CAPABILITY_DIRTY_LIMIT:
+        cap_addr = &config->dirty_limit;
+        break;
+    case MIGRATION_CAPABILITY_MAPPED_RAM:
+        cap_addr = &config->mapped_ram;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return cap_addr;
+}
+
+/* Compatibility for code that reads capabilities in a loop */
+bool migrate_config_get_cap_compat(MigrationConfig *config, int i)
+{
+    return *(migrate_config_get_cap_addr(config, i));
+}
+
+/* Compatibility for code that writes capabilities in a loop */
+static void migrate_config_set_cap_compat(MigrationConfig *config, int i,
+                                          bool val)
+{
+    *(migrate_config_get_cap_addr(config, i)) = val;
+}
+
+/*
+ * Set capabilities for compatibility with the old
+ * migrate-set-capabilities command.
+ */
+static void migrate_config_set_caps_compat(MigrationConfig *config,
+                                           MigrationCapabilityStatusList *caps)
+{
+    MigrationCapabilityStatusList *cap;
+
+    for (cap = caps; cap; cap = cap->next) {
+        migrate_config_set_cap_compat(config, cap->value->capability,
+                                      cap->value->state);
+    }
+}
+
 void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
                                   Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    MigrationCapabilityStatusList *cap;
-    bool new_caps[MIGRATION_CAPABILITY__MAX];
+    g_autoptr(MigrationConfig) new = NULL;
 
     if (migration_is_running() || migration_in_colo_state()) {
         error_setg(errp, "There's a migration process in progress");
         return;
     }
 
-    memcpy(new_caps, s->capabilities, sizeof(new_caps));
-    for (cap = params; cap; cap = cap->next) {
-        new_caps[cap->value->capability] = cap->value->state;
-    }
+    /*
+     * Capabilities validation needs to first copy from s->config in
+     * case the incoming config has a capability that conflicts with
+     * another that's already set.
+     */
+    new = QAPI_CLONE(MigrationConfig, &s->config);
+    migrate_config_set_caps_compat(new, params);
 
-    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
+    if (!migrate_caps_check(new, errp)) {
         return;
     }
 
-    for (cap = params; cap; cap = cap->next) {
-        s->capabilities[cap->value->capability] = cap->value->state;
-    }
+    migrate_config_set_caps_compat(&s->config, params);
 }
 
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void)
@@ -705,9 +782,7 @@ bool migrate_direct_io(void)
      * isolated to the main migration thread while multifd channels
      * process the aligned data with O_DIRECT enabled.
      */
-    return s->config.direct_io &&
-        s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM] &&
-        s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
+    return s->config.direct_io && s->config.mapped_ram && s->config.multifd;
 }
 
 uint64_t migrate_downtime_limit(void)
diff --git a/migration/options.h b/migration/options.h
index 20fdba4237..6455bce985 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -1,5 +1,5 @@
 /*
- * QEMU migration capabilities
+ * QEMU migration options
  *
  * Copyright (c) 2012-2023 Red Hat Inc
  *
@@ -23,8 +23,6 @@
 extern const Property migration_properties[];
 extern const size_t migration_properties_count;
 
-/* capabilities */
-
 bool migrate_auto_converge(void);
 bool migrate_colo(void);
 bool migrate_dirty_bitmaps(void);
@@ -43,21 +41,11 @@ bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_copy_send(void);
 
-/*
- * pseudo capabilities
- *
- * These are functions that are used in a similar way to capabilities
- * check, but they are not a capability.
- */
-
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
 
-/* capabilities helpers */
-
-bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
 
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
@@ -86,4 +74,6 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_config_check(MigrationConfig *params, Error **errp);
 void migrate_config_init(MigrationConfig *params);
+bool migrate_config_get_cap_compat(MigrationConfig *config, int i);
+bool migrate_caps_check(MigrationConfig *new, Error **errp);
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..c81cbc3ee7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -290,7 +290,8 @@ static uint32_t get_validatable_capabilities_count(void)
     uint32_t result = 0;
     int i;
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (should_validate_capability(i) && s->capabilities[i]) {
+        if (should_validate_capability(i) &&
+            migrate_config_get_cap_compat(&s->config, i)) {
             result++;
         }
     }
@@ -312,7 +313,8 @@ static int configuration_pre_save(void *opaque)
     state->capabilities = g_renew(MigrationCapability, state->capabilities,
                                   state->caps_count);
     for (i = j = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (should_validate_capability(i) && s->capabilities[i]) {
+        if (should_validate_capability(i) &&
+            migrate_config_get_cap_compat(&s->config, i)) {
             state->capabilities[j++] = i;
         }
     }
@@ -362,7 +364,7 @@ static bool configuration_validate_capabilities(SaveState *state)
             continue;
         }
         source_state = test_bit(i, source_caps_bm);
-        target_state = s->capabilities[i];
+        target_state = migrate_config_get_cap_compat(&s->config, i);
         if (source_state != target_state) {
             error_report("Capability %s is %s, but received capability is %s",
                          MigrationCapability_str(i),
-- 
2.35.3


