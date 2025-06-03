Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3613CC5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGca-00089P-MS; Mon, 02 Jun 2025 21:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcY-0007ze-RM
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcV-0001bj-IK
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9CB041F461;
 Tue,  3 Jun 2025 01:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5N3NYVPhtMhAUUEJ5cor+FUZmJf9dyM51Q9MLNxrZs=;
 b=dCQ/6LWctnCdUSTsnyO3KCJ85L8sT4x3bjj3ppzaHWZC6P7em1I/13L1z+yd+hhX5FlXwX
 uPOxXzY1oexeRTAJLD2YtgXKPQuGb07VpMHALmLA0v/tYjpzOh9ZdnodV82NTz5Dpm/mRV
 T4zatXYeduT+JaAe+EBTWMdJaPiCUfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5N3NYVPhtMhAUUEJ5cor+FUZmJf9dyM51Q9MLNxrZs=;
 b=VDCsdtS16OaM/vqbyR24qB/HL7mVId0dmxXwpaai2i65PPKRUoMGe+REuZNwR5ndQNAkUH
 ddVFqtNS6igI66Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="dCQ/6LWc";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VDCsdtS1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5N3NYVPhtMhAUUEJ5cor+FUZmJf9dyM51Q9MLNxrZs=;
 b=dCQ/6LWctnCdUSTsnyO3KCJ85L8sT4x3bjj3ppzaHWZC6P7em1I/13L1z+yd+hhX5FlXwX
 uPOxXzY1oexeRTAJLD2YtgXKPQuGb07VpMHALmLA0v/tYjpzOh9ZdnodV82NTz5Dpm/mRV
 T4zatXYeduT+JaAe+EBTWMdJaPiCUfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5N3NYVPhtMhAUUEJ5cor+FUZmJf9dyM51Q9MLNxrZs=;
 b=VDCsdtS16OaM/vqbyR24qB/HL7mVId0dmxXwpaai2i65PPKRUoMGe+REuZNwR5ndQNAkUH
 ddVFqtNS6igI66Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D471213700;
 Tue,  3 Jun 2025 01:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +GaVJCdSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/21] migration: Remove s->capabilities
Date: Mon,  2 Jun 2025 22:38:06 -0300
Message-Id: <20250603013810.4772-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CB041F461
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
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

Last patch added capabilities to s->parameters. Now we can replace all
instances of s->capabilities with s->parameters:

- The -global properties now get set directly in s->parameters.

- Accessors from options.c now read from s->parameters.

- migrate_caps_check() now takes a MigrationParameters object. The
  function is still kept around because migrate-set-capabilities will
  still use it.

- The machinery for background-snapshot compatibility check goes
  away. We can check each capability by name (if s->parameters.cap ...)

- savevm uses the helper functions introduced in the last patch to do
  validation of capabilities found on the migration stream.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  22 +---
 migration/migration.h |   1 -
 migration/options.c   | 285 ++++++++++++++++++------------------------
 migration/options.h   |  20 +--
 migration/savevm.c    |   8 +-
 5 files changed, 133 insertions(+), 203 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index efb1dbb0c4..75c4ec9a95 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -266,9 +266,10 @@ static bool
 migration_capabilities_and_transport_compatible(MigrationAddress *addr,
                                                 Error **errp)
 {
+    MigrationState *s = migrate_get_current();
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        return migrate_rdma_caps_check(migrate_get_current()->capabilities,
-                                       errp);
+        return migrate_rdma_caps_check(&s->parameters, errp);
     }
 
     return true;
@@ -4091,22 +4092,7 @@ static void migration_instance_init(Object *obj)
  */
 static bool migration_object_check(MigrationState *ms, Error **errp)
 {
-    /* Assuming all off */
-    bool old_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
-
-    if (!migrate_params_check(&ms->parameters, errp)) {
-        return false;
-    }
-
-    /*
-     * FIXME: Temporarily while -global capabilties are still using
-     * s->capabilities. Will be gone by the end of the series.
-     */
-    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        migrate_capability_set_compat(&ms->parameters, i, ms->capabilities[i]);
-    }
-
-    return migrate_caps_check(old_caps, ms->capabilities, errp);
+    return migrate_params_check(&ms->parameters, errp);
 }
 
 static const TypeInfo migration_type = {
diff --git a/migration/migration.h b/migration/migration.h
index ab797540b0..993d51aedd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -358,7 +358,6 @@ struct MigrationState {
     int64_t downtime_start;
     int64_t downtime;
     int64_t expected_downtime;
-    bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
 
     /*
diff --git a/migration/options.c b/migration/options.c
index 5808bea53f..fa3f7035c8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -85,9 +85,6 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
-#define DEFINE_PROP_MIG_CAP(name, x)             \
-    DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
-
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
@@ -184,30 +181,40 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
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
+                     MigrationState, parameters.xbzrle, false),
+    DEFINE_PROP_BOOL("x-rdma-pin-all",
+                     MigrationState, parameters.rdma_pin_all, false),
+    DEFINE_PROP_BOOL("x-auto-converge",
+                     MigrationState, parameters.auto_converge, false),
+    DEFINE_PROP_BOOL("x-zero-blocks",
+                     MigrationState, parameters.zero_blocks, false),
+    DEFINE_PROP_BOOL("x-events",
+                     MigrationState, parameters.events, false),
+    DEFINE_PROP_BOOL("x-postcopy-ram",
+                     MigrationState, parameters.postcopy_ram, false),
+    DEFINE_PROP_BOOL("x-postcopy-preempt",
+                     MigrationState, parameters.postcopy_preempt, false),
+    DEFINE_PROP_BOOL("x-colo",
+                     MigrationState, parameters.x_colo, false),
+    DEFINE_PROP_BOOL("x-release-ram",
+                     MigrationState, parameters.release_ram, false),
+    DEFINE_PROP_BOOL("x-return-path",
+                     MigrationState, parameters.return_path, false),
+    DEFINE_PROP_BOOL("x-multifd",
+                     MigrationState, parameters.multifd, false),
+    DEFINE_PROP_BOOL("x-background-snapshot",
+                     MigrationState, parameters.background_snapshot, false),
 #ifdef CONFIG_LINUX
-    DEFINE_PROP_MIG_CAP("x-zero-copy-send",
-            MIGRATION_CAPABILITY_ZERO_COPY_SEND),
+    DEFINE_PROP_BOOL("x-zero-copy-send",
+                     MigrationState, parameters.zero_copy_send, false),
 #endif
-    DEFINE_PROP_MIG_CAP("x-switchover-ack",
-                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
-    DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
-    DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
+    DEFINE_PROP_BOOL("x-switchover-ack",
+                     MigrationState, parameters.switchover_ack, false),
+    DEFINE_PROP_BOOL("x-dirty-limit",
+                     MigrationState, parameters.dirty_limit, false),
+    DEFINE_PROP_BOOL("mapped-ram",
+                     MigrationState, parameters.mapped_ram, false),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
@@ -215,7 +222,7 @@ bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
+    return s->parameters.auto_converge;
 }
 
 bool migrate_send_switchover_start(void)
@@ -229,144 +236,142 @@ bool migrate_background_snapshot(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT];
+    return s->parameters.background_snapshot;
 }
 
 bool migrate_colo(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_X_COLO];
+    return s->parameters.x_colo;
 }
 
 bool migrate_dirty_bitmaps(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
+    return s->parameters.dirty_bitmaps;
 }
 
 bool migrate_dirty_limit(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_LIMIT];
+    return s->parameters.dirty_limit;
 }
 
 bool migrate_events(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_EVENTS];
+    return s->parameters.events;
 }
 
 bool migrate_mapped_ram(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
+    return s->parameters.mapped_ram;
 }
 
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_X_IGNORE_SHARED];
+    return s->parameters.x_ignore_shared;
 }
 
 bool migrate_late_block_activate(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE];
+    return s->parameters.late_block_activate;
 }
 
 bool migrate_multifd(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
+    return s->parameters.multifd;
 }
 
 bool migrate_pause_before_switchover(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER];
+    return s->parameters.pause_before_switchover;
 }
 
 bool migrate_postcopy_blocktime(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
+    return s->parameters.postcopy_blocktime;
 }
 
 bool migrate_postcopy_preempt(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT];
+    return s->parameters.postcopy_preempt;
 }
 
 bool migrate_postcopy_ram(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM];
+    return s->parameters.postcopy_ram;
 }
 
 bool migrate_rdma_pin_all(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL];
+    return s->parameters.rdma_pin_all;
 }
 
 bool migrate_release_ram(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
+    return s->parameters.release_ram;
 }
 
 bool migrate_return_path(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
+    return s->parameters.return_path;
 }
 
 bool migrate_switchover_ack(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
+    return s->parameters.switchover_ack;
 }
 
 bool migrate_validate_uuid(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_VALIDATE_UUID];
+    return s->parameters.validate_uuid;
 }
 
 bool migrate_xbzrle(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_XBZRLE];
+    return s->parameters.xbzrle;
 }
 
 bool migrate_zero_copy_send(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_ZERO_COPY_SEND];
+    return s->parameters.zero_copy_send;
 }
 
-/* pseudo capabilities */
-
 bool migrate_multifd_flush_after_each_section(void)
 {
     MigrationState *s = migrate_get_current();
@@ -411,54 +416,22 @@ WriteTrackingSupport migrate_query_write_tracking(void)
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
 
-bool migrate_rdma_caps_check(bool *caps, Error **errp)
+bool migrate_rdma_caps_check(MigrationParameters *params, Error **errp)
 {
-    if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
+    if (params->xbzrle) {
         error_setg(errp, "RDMA and XBZRLE can't be used together");
         return false;
     }
-    if (caps[MIGRATION_CAPABILITY_MULTIFD]) {
+    if (params->multifd) {
         error_setg(errp, "RDMA and multifd can't be used together");
         return false;
     }
-    if (caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+    if (params->postcopy_ram) {
         error_setg(errp, "RDMA and postcopy-ram can't be used together");
         return false;
     }
@@ -466,26 +439,19 @@ bool migrate_rdma_caps_check(bool *caps, Error **errp)
     return true;
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
+bool migrate_caps_check(MigrationParameters *new, Error **errp)
 {
-    ERRP_GUARD();
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
+    bool postcopy_already_on = s->parameters.postcopy_ram;
+    ERRP_GUARD();
 
-    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
+    if (new->zero_blocks) {
         warn_report("zero-blocks capability is deprecated");
     }
 
 #ifndef CONFIG_REPLICATION
-    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+    if (new->x_colo) {
         error_setg(errp, "QEMU compiled without replication module"
                    " can't enable COLO");
         error_append_hint(errp, "Please enable replication before COLO.\n");
@@ -493,27 +459,27 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
+    if (new->background_snapshot) {
         WriteTrackingSupport wt_support;
-        int idx;
+
         /*
          * Check if 'background-snapshot' capability is supported by
          * host kernel and compatible with guest memory configuration.
@@ -529,41 +495,45 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -575,22 +545,22 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+    if (new->multifd) {
         if (!migrate_multifd() && migrate_incoming_started()) {
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
@@ -603,21 +573,21 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -628,7 +598,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
      * On destination side, check the cases that capability is being set
      * after incoming thread has started.
      */
-    if (migrate_rdma() && !migrate_rdma_caps_check(new_caps, errp)) {
+    if (migrate_rdma() && !migrate_rdma_caps_check(new, errp)) {
         return false;
     }
     return true;
@@ -749,39 +719,37 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
         caps = g_malloc0(sizeof(*caps));
         caps->capability = i;
-        caps->state = s->capabilities[i];
+        caps->state = migrate_capability_get_compat(&s->parameters, i);
         QAPI_LIST_APPEND(tail, caps);
     }
 
     return head;
 }
 
-void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
+void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *capabilities,
                                   Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    MigrationCapabilityStatusList *cap;
-    bool new_caps[MIGRATION_CAPABILITY__MAX];
+    g_autoptr(MigrationParameters) params = NULL;
 
     if (migration_is_running() || migration_in_colo_state()) {
         error_setg(errp, "There's a migration process in progress");
         return;
     }
 
-    memcpy(new_caps, s->capabilities, sizeof(new_caps));
-    for (cap = params; cap; cap = cap->next) {
-        new_caps[cap->value->capability] = cap->value->state;
-    }
+    /*
+     * Capabilities validation needs to first copy from s->parameters
+     * in case the incoming capabilities have a capability that
+     * conflicts with another that's already set.
+     */
+    params = QAPI_CLONE(MigrationParameters, &s->parameters);
+    migrate_capabilities_set_compat(params, capabilities);
 
-    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
+    if (!migrate_caps_check(params, errp)) {
         return;
     }
 
-    for (cap = params; cap; cap = cap->next) {
-        s->capabilities[cap->value->capability] = cap->value->state;
-    }
-
-    migrate_capabilities_set_compat(&s->parameters, params);
+    migrate_capabilities_set_compat(&s->parameters, capabilities);
 }
 
 /* parameters */
@@ -842,9 +810,8 @@ bool migrate_direct_io(void)
      * isolated to the main migration thread while multifd channels
      * process the aligned data with O_DIRECT enabled.
      */
-    return s->parameters.direct_io &&
-        s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM] &&
-        s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
+    return s->parameters.direct_io && s->parameters.mapped_ram &&
+        s->parameters.multifd;
 }
 
 uint64_t migrate_downtime_limit(void)
@@ -1301,6 +1268,10 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (!migrate_caps_check(params, errp)) {
+        return false;
+    }
+
     return true;
 }
 
@@ -1366,20 +1337,6 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationParameters *tmp = g_new0(MigrationParameters, 1);
 
-    /*
-     * FIXME: Temporarily while migrate_caps_check is not
-     * converted to look at s->parameters. Will be gone the end of
-     * the series.
-     */
-    MigrationState *s = migrate_get_current();
-    bool new_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
-    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        new_caps[i] = migrate_capability_get_compat(&s->parameters, i);
-    }
-    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
-        return;
-    }
-
     if (!migrate_params_test_apply(params, tmp, errp)) {
         return;
     }
diff --git a/migration/options.h b/migration/options.h
index cac9201a5e..fcfd120cd7 100644
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
@@ -43,22 +41,12 @@ bool migrate_validate_uuid(void);
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
-bool migrate_rdma_caps_check(bool *caps, Error **errp);
-bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
+bool migrate_rdma_caps_check(MigrationParameters *config, Error **errp);
 
 /* parameters */
 
@@ -87,14 +75,12 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
-/* parameters helpers */
-
 bool migrate_params_check(MigrationParameters *params, Error **errp);
-void migrate_params_init(MigrationParameters *params);
 void migrate_tls_opts_free(MigrationParameters *params);
 bool migrate_capability_get_compat(MigrationParameters *params, int i);
 void migrate_capability_set_compat(MigrationParameters *params, int i,
                                    bool val);
 void migrate_capabilities_set_compat(MigrationParameters *params,
                                      MigrationCapabilityStatusList *caps);
+bool migrate_caps_check(MigrationParameters *new, Error **errp);
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 006514c3e3..e052a4ff97 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -291,7 +291,8 @@ static uint32_t get_validatable_capabilities_count(void)
     uint32_t result = 0;
     int i;
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (should_validate_capability(i) && s->capabilities[i]) {
+        if (should_validate_capability(i) &&
+            migrate_capability_get_compat(&s->parameters, i)) {
             result++;
         }
     }
@@ -313,7 +314,8 @@ static int configuration_pre_save(void *opaque)
     state->capabilities = g_renew(MigrationCapability, state->capabilities,
                                   state->caps_count);
     for (i = j = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (should_validate_capability(i) && s->capabilities[i]) {
+        if (should_validate_capability(i) &&
+            migrate_capability_get_compat(&s->parameters, i)) {
             state->capabilities[j++] = i;
         }
     }
@@ -363,7 +365,7 @@ static bool configuration_validate_capabilities(SaveState *state)
             continue;
         }
         source_state = test_bit(i, source_caps_bm);
-        target_state = s->capabilities[i];
+        target_state = migrate_capability_get_compat(&s->parameters, i);
         if (source_state != target_state) {
             error_report("Capability %s is %s, but received capability is %s",
                          MigrationCapability_str(i),
-- 
2.35.3


