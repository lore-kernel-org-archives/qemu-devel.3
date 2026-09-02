Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04154C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tG8-0000zc-0W; Wed, 02 Sep 2026 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tG6-0000yk-8g
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tG2-0002PO-HP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1D9721CCB;
 Wed,  2 Sep 2026 22:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN3HZ2mcXSReFVChVzZV2TfNPS8MZAD8+fPNEM7GIb8=;
 b=UBWvEcOEbfI+N5JP43ggI2QBMHMSZJ03uPa4qBlEwDApV5LU6fWJA/fCxMhlEFd7Kvd5bQ
 xz1iMQJn4mt/rrA82aqIDrhNukTqh7C1Z5E2BJEoOON9SF/cPGLz3O27DvbOXvbMw1NSVN
 aJk30iCRS06yMXrGYRyM1pF4FMPvPNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN3HZ2mcXSReFVChVzZV2TfNPS8MZAD8+fPNEM7GIb8=;
 b=wRqiPWwJazOEzY9LoVvvzj4QnRq8qTPJLJB9cW0bg9TG8+elBjnGrNgfSSPCkyRq1FTg7s
 jszNdJEQMyysimCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN3HZ2mcXSReFVChVzZV2TfNPS8MZAD8+fPNEM7GIb8=;
 b=bcp1KamQdwCOsJvKrb8plOxNKtI+ZE/+g7qwcE6E1C+uEqOYtImbXRw/OZ4UnPEEb/pgVa
 PDo6v8bnlhyM2nwrAec8qsRDnPdvSgywfXumyjdQ6a2l4I4I1gFoxKIqBznzfQLBTJXlPO
 IQGV+MFfrhnt7yAYkvwEgp51xp/Vp9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN3HZ2mcXSReFVChVzZV2TfNPS8MZAD8+fPNEM7GIb8=;
 b=Db5mo7dUzHvedVJN0/eMWInMVkmHDY2dCbeML9rPsXebnboGkYq17XjluUcBBLMgHcPGhH
 bWw/OdJKdo3lNsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D0AB13738;
 Wed,  2 Sep 2026 22:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sFSbDzugmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 17/18] migration: Remove s->capabilities
Date: Wed,  2 Sep 2026 19:15:45 -0300
Message-ID: <20260902221547.1812481-18-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c              |  22 +-
 migration/migration.h              |   2 +-
 migration/options.c                | 317 ++++++++++++-----------------
 migration/options.h                |  19 +-
 migration/savevm.c                 |   8 +-
 tests/qtest/migration/misc-tests.c | 141 +++++++++++++
 6 files changed, 284 insertions(+), 225 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c8e7e86ea05..69dd4f3d050 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -255,9 +255,10 @@ static bool
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
@@ -4079,22 +4080,7 @@ static void migration_instance_init(Object *obj)
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
index e47ff4e3d11..e1204b7f0d5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -357,7 +357,7 @@ struct MigrationState {
     /* Timestamp when VM is down (ms) to migrate the last stuff */
     int64_t downtime_start;
     int64_t downtime;
-    bool capabilities[MIGRATION_CAPABILITY__MAX];
+    int64_t expected_downtime;
     int64_t setup_time;
 
     /*
diff --git a/migration/options.c b/migration/options.c
index 7c638e204a1..780693ceed9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -88,9 +88,6 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
-#define DEFINE_PROP_MIG_CAP(name, x)             \
-    DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
-
 const PropertyInfo qdev_prop_StrOrNull;
 #define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
     DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
@@ -198,32 +195,42 @@ const Property migration_properties[] = {
                       parameters.x_rdma_chunk_size,
                       DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
 
-    /* Migration capabilities */
-    DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
-    DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
-    DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
-    DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
-    DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
-    DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
-                        MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
-    DEFINE_PROP_MIG_CAP("postcopy-blocktime",
-                        MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME),
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
+    DEFINE_PROP_BOOL("x-events",
+                     MigrationState, parameters.events, false),
+    DEFINE_PROP_BOOL("x-postcopy-ram",
+                     MigrationState, parameters.postcopy_ram, false),
+    DEFINE_PROP_BOOL("x-postcopy-preempt",
+                     MigrationState, parameters.postcopy_preempt, false),
+    DEFINE_PROP_BOOL("postcopy-blocktime",
+                     MigrationState, parameters.postcopy_blocktime, false),
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
-    DEFINE_PROP_MIG_CAP("x-ignore-shared",
-                        MIGRATION_CAPABILITY_X_IGNORE_SHARED),
+    DEFINE_PROP_BOOL("x-switchover-ack",
+                     MigrationState, parameters.switchover_ack, false),
+    DEFINE_PROP_BOOL("x-dirty-limit",
+                     MigrationState, parameters.dirty_limit, false),
+    DEFINE_PROP_BOOL("mapped-ram",
+                     MigrationState, parameters.mapped_ram, false),
+    DEFINE_PROP_BOOL("x-ignore-shared",
+                     MigrationState, parameters.x_ignore_shared, false),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
@@ -306,7 +313,7 @@ bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
+    return s->parameters.auto_converge;
 }
 
 bool migrate_send_switchover_start(void)
@@ -320,144 +327,142 @@ bool migrate_background_snapshot(void)
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
@@ -509,44 +514,6 @@ WriteTrackingSupport migrate_query_write_tracking(void)
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
-/* Snapshot compatibility check list */
-static const
-INITIALIZE_MIGRATE_CAPS_SET(check_caps_savevm,
-                            MIGRATION_CAPABILITY_MULTIFD,
-);
-
 static bool migrate_incoming_started(void)
 {
     return !!migration_incoming_get_current()->transport_data;
@@ -555,34 +522,28 @@ static bool migrate_incoming_started(void)
 bool migrate_can_snapshot(Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    int i;
 
-    for (i = 0; i < check_caps_savevm.size; i++) {
-        int incomp_cap = check_caps_savevm.caps[i];
-
-        if (s->capabilities[incomp_cap]) {
-            error_setg(errp,
-                       "Snapshots are not compatible with %s",
-                       MigrationCapability_str(incomp_cap));
-            return false;
-        }
+    if (migrate_capability_get_compat(
+            &s->parameters, MIGRATION_CAPABILITY_MULTIFD)) {
+        error_setg(errp,
+                   "Snapshots are not compatible with multifd");
+        return false;
     }
 
     return true;
 }
 
-
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
@@ -590,30 +551,23 @@ bool migrate_rdma_caps_check(bool *caps, Error **errp)
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
 
 #ifdef CONFIG_REPLICATION
-    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
-        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+    if (new->x_colo) {
+        if (!new->return_path) {
             error_setg(errp, "Capability 'x-colo' requires capability "
                              "'return-path'");
             return false;
         }
     }
 #else
-    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+    if (new->x_colo) {
         error_setg(errp, "QEMU compiled without replication module"
                    " can't enable COLO");
         error_append_hint(errp, "Please enable replication before COLO.\n");
@@ -621,27 +575,27 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -657,41 +611,45 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -703,22 +661,22 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -731,30 +689,29 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM] &&
-        new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+    if (new->mapped_ram && new->postcopy_ram) {
+        if (new->multifd) {
             error_setg(errp,
                        "Multifd is not supported with fast snapshot load");
             return false;
         }
 
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT]) {
+        if (new->postcopy_preempt) {
             error_setg(
                 errp,
                 "Postcopy Preempt is incompatible with fast snapshot load");
@@ -772,7 +729,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
      * On destination side, check the cases that capability is being set
      * after incoming thread has started.
      */
-    if (migrate_rdma() && !migrate_rdma_caps_check(new_caps, errp)) {
+    if (migrate_rdma() && !migrate_rdma_caps_check(new, errp)) {
         return false;
     }
     return true;
@@ -890,39 +847,37 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
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
@@ -983,9 +938,8 @@ bool migrate_direct_io(void)
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
@@ -1555,6 +1509,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
          !is_power_of_2(params->x_rdma_chunk_size))) {
         error_setg(errp, "Option x_rdma_chunk_size expects "
                    "a power of 2 in the range 1MiB to 1024MiB");
+    }
+
+    if (!migrate_caps_check(params, errp)) {
         return false;
     }
 
@@ -1578,20 +1535,6 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
     tls_opt_to_str(input->tls_hostname);
     tls_opt_to_str(input->tls_authz);
 
-    /*
-     * FIXME: Temporarily while migrate_caps_check is not
-     * converted to look at s->parameters. Will be gone the end of
-     * the series.
-     */
-    bool new_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
-    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        new_caps[i] = migrate_capability_get_compat(cur, i);
-    }
-    if (!migrate_caps_check(migrate_get_current()->capabilities, new_caps,
-                            errp)) {
-        return;
-    }
-
     /* merge input on top of current */
     if (!migrate_params_merge(cur, input, &new, errp)) {
         return;
diff --git a/migration/options.h b/migration/options.h
index eedd1aa1f93..27a55c36a5f 100644
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
 bool migrate_can_snapshot(Error **errp);
 
 /* parameters */
@@ -89,8 +77,6 @@ uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 uint64_t migrate_rdma_chunk_size(void);
 
-/* parameters helpers */
-
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
 bool migrate_params_free(MigrationParameters *params, Error **errp);
@@ -99,4 +85,5 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
                                    bool val);
 void migrate_capabilities_set_compat(MigrationParameters *params,
                                      MigrationCapabilityStatusList *caps);
+bool migrate_caps_check(MigrationParameters *new, Error **errp);
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 5b0e89ca7c8..c284b76f609 100644
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
@@ -313,7 +314,8 @@ static bool configuration_pre_save(void *opaque, Error **errp)
     state->capabilities = g_renew(MigrationCapability, state->capabilities,
                                   state->caps_count);
     for (i = j = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (should_validate_capability(i) && s->capabilities[i]) {
+        if (should_validate_capability(i) &&
+            migrate_capability_get_compat(&s->parameters, i)) {
             state->capabilities[j++] = i;
         }
     }
@@ -362,7 +364,7 @@ static bool configuration_validate_capabilities(SaveState *state)
             continue;
         }
         source_state = test_bit(i, source_caps_bm);
-        target_state = s->capabilities[i];
+        target_state = migrate_capability_get_compat(&s->parameters, i);
         if (source_state != target_state) {
             error_report("Capability %s is %s, but received capability is %s",
                          MigrationCapability_str(i),
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 34b376562ff..ff11d80f79a 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -53,6 +53,147 @@ HMPTestData test_cases[] = {
     /* bool */
     TEST("cpu-throttle-tailslow", "on", "on"),
     TEST("direct-io", "on", "on"),
+    TEST("events", "on", "on"),
+
+    /* bool, with dependencies */
+
+    /*
+     * background-snapshot:
+     *  rejects dirty-bitmaps
+     *  rejects postcopy-blocktime
+     *  rejects late-block-activate
+     *  rejects multifd
+     *  rejects pause-before-switchover
+     *  rejects auto-converge
+     *  rejects release-ram
+     *  rejects rdma-pin-all
+     *  rejects validate-uuid
+     *  rejects zero-copy-send
+     *  rejects postcopy-ram
+     */
+    TEST("background-snapshot", "on", "on"),
+    TEST("dirty-bitmaps", "on", BG_SNAP_MSG),
+    TEST("postcopy-blocktime", "on", BG_SNAP_MSG),
+    TEST("late-block-activate", "on", BG_SNAP_MSG),
+    TEST("multifd", "on", BG_SNAP_MSG),
+    TEST("pause-before-switchover", "on", BG_SNAP_MSG),
+    TEST("auto-converge", "on", BG_SNAP_MSG),
+    TEST("release-ram", "on", BG_SNAP_MSG),
+    TEST("rdma-pin-all", "on", BG_SNAP_MSG),
+    TEST("validate-uuid", "on", BG_SNAP_MSG),
+    TEST("zero-copy-send", "on", BG_SNAP_MSG),
+    TEST("postcopy-ram", "on", BG_SNAP_MSG),
+    TEST("background-snapshot", "off", "off"),
+
+    TEST("dirty-bitmaps", "on", "on"),
+    TEST("postcopy-blocktime", "on", "on"),
+    TEST("late-block-activate", "on", "on"),
+    TEST("pause-before-switchover", "on", "on"),
+    TEST("auto-converge", "on", "on"),
+    TEST("release-ram", "on", "on"),
+    TEST("rdma-pin-all", "on", "on"),
+    TEST("validate-uuid", "on", "on"),
+
+    /*
+     * postcopy-preempt
+     *  requires postcopy-ram:
+     */
+    TEST("postcopy-preempt", "on",
+         "Error: Postcopy preempt requires postcopy-ram"),
+
+    /*
+     * postcopy-ram:
+     *  required by postcopy-preempt
+     *  rejected by x-ignore-shared
+     *  rejected by background-snapshot
+     *  rejected by mapped-ram
+     */
+    TEST("postcopy-ram", "on", "on"),
+    TEST("postcopy-preempt", "on", "on"),
+    TEST("x-ignore-shared", "on",
+         "Error: Postcopy is not compatible with ignore-shared"),
+    TEST("background-snapshot", "on", BG_SNAP_MSG),
+    TEST("mapped-ram", "on",
+         "Error: Postcopy Preempt is incompatible with fast snapshot load"),
+    TEST("postcopy-ram", "off",
+         "Error: Postcopy preempt requires postcopy-ram"),
+    TEST("postcopy-preempt", "off", "off"),
+    TEST("postcopy-ram", "off", "off"),
+
+    /*
+     * x-ignore-shared:
+     *  rejected by postcopy-ram
+     */
+    TEST("x-ignore-shared", "on", "on"),
+    TEST("postcopy-ram", "on",
+         "Error: Postcopy is not compatible with ignore-shared"),
+    TEST("x-ignore-shared", "off", "off"),
+
+    /*
+     * return-path:
+     *  required by x-colo
+     *  required by switchover-ack
+     *  rejected by background-snapshot
+     */
+    TEST("return-path", "on", "on"),
+    TEST("x-colo", "on", "on"),
+    TEST("switchover-ack", "on", "on"),
+    TEST("background-snapshot", "on", BG_SNAP_MSG),
+
+    TEST("return-path", "off",
+         "Error: Capability 'x-colo' requires capability 'return-path'"),
+    TEST("x-colo", "off", "off"),
+
+    TEST("return-path", "off",
+         "Error: Capability 'switchover-ack' requires capability "
+         "'return-path'"),
+    TEST("switchover-ack", "off", "off"),
+    TEST("return-path", "off", "off"),
+
+    TEST("x-colo", "on",
+         "Error: Capability 'x-colo' requires capability 'return-path'"),
+    TEST("switchover-ack", "on", "Error: Capability 'switchover-ack' requires "
+         "capability 'return-path'"),
+
+    /*
+     * xbzrle:
+     *  rejected by multifd
+     */
+    TEST("xbzrle", "on", "on"),
+    TEST("multifd", "on", "Error: Multifd is not compatible with xbzrle"),
+    TEST("xbzrle", "off", "off"),
+
+    /*
+     * multifd:
+     *  rejected by xbzrle
+     *  required by zero-copy-send
+     */
+    TEST("multifd", "on", "on"),
+    TEST("xbzrle", "on", "Error: Multifd is not compatible with xbzrle"),
+    TEST("zero-copy-send", "on", "on"),
+    TEST("multifd", "off", "Error: Zero copy only available for "
+         "non-compressed non-TLS multifd migration"),
+    TEST("zero-copy-send", "off", "off"),
+    TEST("multifd", "off", "off"),
+
+    /*
+     * auto-converge:
+     *  rejected by dirty-limit
+     */
+    TEST("auto-converge", "on", "on"),
+    TEST("dirty-limit", "on",
+         "Error: dirty-limit conflicts with auto-converge "
+         "either of then available currently"),
+    TEST("auto-converge", "off", "off"),
+
+    /*
+     * dirty-limit:
+     *  rejected by auto-converge
+     *  requires KVM acceleration
+     */
+    TEST("dirty-limit", "on",
+         "Error: dirty-limit requires KVM with accelerator "
+         "property 'dirty-ring-size' set"),
 
     /* uint64_t */
     TEST("announce-initial", "60", "60"),
-- 
2.53.0


