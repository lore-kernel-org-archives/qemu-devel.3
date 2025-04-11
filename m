Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D05C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jqt-0004cl-MR; Fri, 11 Apr 2025 15:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqL-0003yH-Tb
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:24 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3JqF-0006AB-E9
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD2F1F453;
 Fri, 11 Apr 2025 19:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/6/Hr6Qzthq8gpYRe2kMn2+wfIBy/9/b9okQW3RkDU=;
 b=ix59tJ3wpxNO6LsOJK5/fcKnTz7YbYAfZ1uBh1MBW4MJ7fiZ7M/UVEbVBMoonwmyctNO6m
 hsUO5xqSfIBlb80+aOwIp1rqrPcFnLD5z2Kmf9OTBKViLv+ZJOP5linYok1TKMyeKSHlcJ
 zHwqh8xm+gQXRM5DopLC6ztZlo8o2Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/6/Hr6Qzthq8gpYRe2kMn2+wfIBy/9/b9okQW3RkDU=;
 b=vTVOHMEuzyg1QEC69hIQYJMCVHCCsYIBMhlBULyio8hMIwvw7/6F/l1SA26/9cIHP2tnqS
 6Hh2nJc/aXKAj/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/6/Hr6Qzthq8gpYRe2kMn2+wfIBy/9/b9okQW3RkDU=;
 b=ix59tJ3wpxNO6LsOJK5/fcKnTz7YbYAfZ1uBh1MBW4MJ7fiZ7M/UVEbVBMoonwmyctNO6m
 hsUO5xqSfIBlb80+aOwIp1rqrPcFnLD5z2Kmf9OTBKViLv+ZJOP5linYok1TKMyeKSHlcJ
 zHwqh8xm+gQXRM5DopLC6ztZlo8o2Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/6/Hr6Qzthq8gpYRe2kMn2+wfIBy/9/b9okQW3RkDU=;
 b=vTVOHMEuzyg1QEC69hIQYJMCVHCCsYIBMhlBULyio8hMIwvw7/6F/l1SA26/9cIHP2tnqS
 6Hh2nJc/aXKAj/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BBE213886;
 Fri, 11 Apr 2025 19:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kKmbBzZq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:15:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 08/13] migration: Replace s->parameters with s->config
Date: Fri, 11 Apr 2025 16:14:38 -0300
Message-Id: <20250411191443.22565-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

The concepts of 'parameters' and 'capabilities' are almost
functionally identical and there is a consensus that their usage is
confusing, particularly when it comes to determine to which category a
new option should belong.

The new MigrationConfig type was introduced to eliminate the
distinction between parameters and capabilities and contains the union
of both groups.

Replace internal usages of MigrationParameters with MigrationConfig.

For the user-facing migrate-set-parameters and
query-migrate-parameters, the old types MigrateSetParameters and
MigrationParameters are still used.

Note that migrate_params_check (now migrate_config_check) will be used
in the future also for capabilities validation and for any future
command that uses MigrationConfig.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  25 ++-
 migration/migration.h |   4 +-
 migration/options.c   | 371 ++++++++++++++++++++----------------------
 migration/options.h   |   8 +-
 migration/ram.c       |   4 +-
 5 files changed, 192 insertions(+), 220 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2c3bb98df8..9324d4f44e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -119,7 +119,7 @@ static void migration_downtime_start(MigrationState *s)
 /*
  * This is unfortunate: incoming migration actually needs the outgoing
  * migration state (MigrationState) to be there too, e.g. to query
- * capabilities, parameters, using locks, setup errors, etc.
+ * options, using locks, setup errors, etc.
  *
  * NOTE: when calling this, making sure current_migration exists and not
  * been freed yet!  Otherwise trying to access the refcount is already
@@ -1664,7 +1664,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 int migration_call_notifiers(MigrationState *s, MigrationEventType type,
                              Error **errp)
 {
-    MigMode mode = s->parameters.mode;
+    MigMode mode = s->config.mode;
     MigrationEvent e;
     int ret;
 
@@ -1735,7 +1735,7 @@ bool migration_thread_is_self(void)
 
 bool migrate_mode_is_cpr(MigrationState *s)
 {
-    MigMode mode = s->parameters.mode;
+    MigMode mode = s->config.mode;
     return mode == MIG_MODE_CPR_REBOOT ||
            mode == MIG_MODE_CPR_TRANSFER;
 }
@@ -1750,9 +1750,8 @@ int migrate_init(MigrationState *s, Error **errp)
     }
 
     /*
-     * Reinitialise all migration state, except
-     * parameters/capabilities that the user set, and
-     * locks.
+     * Reinitialise all migration state, except options that the user
+     * set, and locks.
      */
     s->to_dst_file = NULL;
     s->state = MIGRATION_STATUS_NONE;
@@ -2212,7 +2211,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
+    if (s->config.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
         error_setg(errp, "missing 'cpr' migration channel");
         return;
     }
@@ -2237,7 +2236,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      * in which case the target will not listen for the incoming migration
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
-    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
+    if (s->config.mode == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
                         QAPI_CLONE(MigrationAddress, addr));
 
@@ -4068,21 +4067,21 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
 {
     /* Assuming all off */
     bool old_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
-    g_autoptr(MigrationParameters) globals = NULL;
+    g_autoptr(MigrationConfig) globals = NULL;
 
     /*
      * Copy the values that were already set via qdev properties
      * (-global).
      */
-    globals = QAPI_CLONE(MigrationParameters, &ms->parameters);
+    globals = QAPI_CLONE(MigrationConfig, &ms->config);
 
     /*
-     * Set the has_* fields because migrate_params_check() only
+     * Set the has_* fields because migrate_config_check() only
      * validates new fields.
      */
-    migrate_params_init(globals);
+    migrate_config_init(globals);
 
-    if (!migrate_params_check(globals, errp)) {
+    if (!migrate_config_check(globals, errp)) {
         return false;
     }
 
diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84..8e6aa595b6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -317,9 +317,7 @@ struct MigrationState {
      */
     uint64_t threshold_size;
 
-    /* params from 'migrate-set-parameters' */
-    MigrationParameters parameters;
-
+    MigrationConfig config;
     MigrationStatus state;
 
     /* State related to return path */
diff --git a/migration/options.c b/migration/options.c
index 87599e4fdd..7c41fbbce6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -41,7 +41,7 @@
  * for sending the last part */
 #define DEFAULT_MIGRATE_SET_DOWNTIME 300
 
-/* Define default autoconverge cpu throttle migration parameters */
+/* Define default autoconverge cpu throttle migration options */
 #define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT 10
@@ -72,7 +72,7 @@
 #define DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH 0
 
 /*
- * Parameters for self_announce_delay giving a stream of RARP/ARP
+ * Defaults for self_announce_delay giving a stream of RARP/ARP
  * packets after migration.
  */
 #define DEFAULT_MIGRATE_ANNOUNCE_INITIAL  50
@@ -104,78 +104,77 @@ const Property migration_properties[] = {
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
 
-    /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
-                      parameters.throttle_trigger_threshold,
+                      config.throttle_trigger_threshold,
                       DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
     DEFINE_PROP_UINT8("x-cpu-throttle-initial", MigrationState,
-                      parameters.cpu_throttle_initial,
+                      config.cpu_throttle_initial,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
     DEFINE_PROP_UINT8("x-cpu-throttle-increment", MigrationState,
-                      parameters.cpu_throttle_increment,
+                      config.cpu_throttle_increment,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
     DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
-                      parameters.cpu_throttle_tailslow, false),
+                      config.cpu_throttle_tailslow, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
-                      parameters.max_bandwidth, MAX_THROTTLE),
+                      config.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
-                      parameters.avail_switchover_bandwidth, 0),
+                      config.avail_switchover_bandwidth, 0),
     DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
-                      parameters.downtime_limit,
+                      config.downtime_limit,
                       DEFAULT_MIGRATE_SET_DOWNTIME),
     DEFINE_PROP_UINT32("x-checkpoint-delay", MigrationState,
-                      parameters.x_checkpoint_delay,
+                      config.x_checkpoint_delay,
                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
-                      parameters.multifd_channels,
+                      config.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
     DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression", MigrationState,
-                      parameters.multifd_compression,
+                      config.multifd_compression,
                       DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
-                      parameters.multifd_zlib_level,
+                      config.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
     DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
-                      parameters.multifd_qatzip_level,
+                      config.multifd_qatzip_level,
                       DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
     DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
-                      parameters.multifd_zstd_level,
+                      config.multifd_zstd_level,
                       DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
-                      parameters.xbzrle_cache_size,
+                      config.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
     DEFINE_PROP_SIZE("max-postcopy-bandwidth", MigrationState,
-                      parameters.max_postcopy_bandwidth,
+                      config.max_postcopy_bandwidth,
                       DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH),
     DEFINE_PROP_UINT8("max-cpu-throttle", MigrationState,
-                      parameters.max_cpu_throttle,
+                      config.max_cpu_throttle,
                       DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
     DEFINE_PROP_SIZE("announce-initial", MigrationState,
-                      parameters.announce_initial,
+                      config.announce_initial,
                       DEFAULT_MIGRATE_ANNOUNCE_INITIAL),
     DEFINE_PROP_SIZE("announce-max", MigrationState,
-                      parameters.announce_max,
+                      config.announce_max,
                       DEFAULT_MIGRATE_ANNOUNCE_MAX),
     DEFINE_PROP_SIZE("announce-rounds", MigrationState,
-                      parameters.announce_rounds,
+                      config.announce_rounds,
                       DEFAULT_MIGRATE_ANNOUNCE_ROUNDS),
     DEFINE_PROP_SIZE("announce-step", MigrationState,
-                      parameters.announce_step,
+                      config.announce_step,
                       DEFAULT_MIGRATE_ANNOUNCE_STEP),
-    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
-    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
-    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    DEFINE_PROP_STRING("tls-creds", MigrationState, config.tls_creds),
+    DEFINE_PROP_STRING("tls-hostname", MigrationState, config.tls_hostname),
+    DEFINE_PROP_STRING("tls-authz", MigrationState, config.tls_authz),
     DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
-                       parameters.x_vcpu_dirty_limit_period,
+                       config.x_vcpu_dirty_limit_period,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
     DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
-                       parameters.vcpu_dirty_limit,
+                       config.vcpu_dirty_limit,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
     DEFINE_PROP_MIG_MODE("mode", MigrationState,
-                      parameters.mode,
+                      config.mode,
                       MIG_MODE_NORMAL),
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
-                       parameters.zero_page_detection,
+                       config.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
 
     /* Migration capabilities */
@@ -650,48 +649,46 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     }
 }
 
-/* parameters */
-
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.block_bitmap_mapping;
+    return s->config.block_bitmap_mapping;
 }
 
 bool migrate_has_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.has_block_bitmap_mapping;
+    return s->config.has_block_bitmap_mapping;
 }
 
 uint32_t migrate_checkpoint_delay(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.x_checkpoint_delay;
+    return s->config.x_checkpoint_delay;
 }
 
 uint8_t migrate_cpu_throttle_increment(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.cpu_throttle_increment;
+    return s->config.cpu_throttle_increment;
 }
 
 uint8_t migrate_cpu_throttle_initial(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.cpu_throttle_initial;
+    return s->config.cpu_throttle_initial;
 }
 
 bool migrate_cpu_throttle_tailslow(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.cpu_throttle_tailslow;
+    return s->config.cpu_throttle_tailslow;
 }
 
 bool migrate_direct_io(void)
@@ -708,7 +705,7 @@ bool migrate_direct_io(void)
      * isolated to the main migration thread while multifd channels
      * process the aligned data with O_DIRECT enabled.
      */
-    return s->parameters.direct_io &&
+    return s->config.direct_io &&
         s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM] &&
         s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
@@ -717,35 +714,35 @@ uint64_t migrate_downtime_limit(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.downtime_limit;
+    return s->config.downtime_limit;
 }
 
 uint8_t migrate_max_cpu_throttle(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.max_cpu_throttle;
+    return s->config.max_cpu_throttle;
 }
 
 uint64_t migrate_max_bandwidth(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.max_bandwidth;
+    return s->config.max_bandwidth;
 }
 
 uint64_t migrate_avail_switchover_bandwidth(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.avail_switchover_bandwidth;
+    return s->config.avail_switchover_bandwidth;
 }
 
 uint64_t migrate_max_postcopy_bandwidth(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.max_postcopy_bandwidth;
+    return s->config.max_postcopy_bandwidth;
 }
 
 MigMode migrate_mode(void)
@@ -753,7 +750,7 @@ MigMode migrate_mode(void)
     MigMode mode = cpr_get_incoming_mode();
 
     if (mode == MIG_MODE_NONE) {
-        mode = migrate_get_current()->parameters.mode;
+        mode = migrate_get_current()->config.mode;
     }
 
     assert(mode >= 0 && mode < MIG_MODE__MAX);
@@ -764,52 +761,52 @@ int migrate_multifd_channels(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.multifd_channels;
+    return s->config.multifd_channels;
 }
 
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
 
-    assert(s->parameters.multifd_compression < MULTIFD_COMPRESSION__MAX);
-    return s->parameters.multifd_compression;
+    assert(s->config.multifd_compression < MULTIFD_COMPRESSION__MAX);
+    return s->config.multifd_compression;
 }
 
 int migrate_multifd_zlib_level(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.multifd_zlib_level;
+    return s->config.multifd_zlib_level;
 }
 
 int migrate_multifd_qatzip_level(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.multifd_qatzip_level;
+    return s->config.multifd_qatzip_level;
 }
 
 int migrate_multifd_zstd_level(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.multifd_zstd_level;
+    return s->config.multifd_zstd_level;
 }
 
 uint8_t migrate_throttle_trigger_threshold(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.throttle_trigger_threshold;
+    return s->config.throttle_trigger_threshold;
 }
 
 const char *migrate_tls_authz(void)
 {
     MigrationState *s = migrate_get_current();
 
-    if (s->parameters.tls_authz &&
-        *s->parameters.tls_authz) {
-        return s->parameters.tls_authz;
+    if (s->config.tls_authz &&
+        *s->config.tls_authz) {
+        return s->config.tls_authz;
     }
 
     return NULL;
@@ -819,9 +816,9 @@ const char *migrate_tls_creds(void)
 {
     MigrationState *s = migrate_get_current();
 
-    if (s->parameters.tls_creds &&
-        *s->parameters.tls_creds) {
-        return s->parameters.tls_creds;
+    if (s->config.tls_creds &&
+        *s->config.tls_creds) {
+        return s->config.tls_creds;
     }
 
     return NULL;
@@ -831,9 +828,9 @@ const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
 
-    if (s->parameters.tls_hostname &&
-        *s->parameters.tls_hostname) {
-        return s->parameters.tls_hostname;
+    if (s->config.tls_hostname &&
+        *s->config.tls_hostname) {
+        return s->config.tls_hostname;
     }
 
     return NULL;
@@ -848,35 +845,33 @@ uint64_t migrate_vcpu_dirty_limit_period(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.x_vcpu_dirty_limit_period;
+    return s->config.x_vcpu_dirty_limit_period;
 }
 
 uint64_t migrate_xbzrle_cache_size(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.xbzrle_cache_size;
+    return s->config.xbzrle_cache_size;
 }
 
 ZeroPageDetection migrate_zero_page_detection(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.zero_page_detection;
+    return s->config.zero_page_detection;
 }
 
-/* parameters helpers */
-
 AnnounceParameters *migrate_announce_params(void)
 {
     static AnnounceParameters ap;
 
     MigrationState *s = migrate_get_current();
 
-    ap.initial = s->parameters.announce_initial;
-    ap.max = s->parameters.announce_max;
-    ap.rounds = s->parameters.announce_rounds;
-    ap.step = s->parameters.announce_step;
+    ap.initial = s->config.announce_initial;
+    ap.max = s->config.announce_max;
+    ap.rounds = s->config.announce_rounds;
+    ap.step = s->config.announce_step;
 
     return &ap;
 }
@@ -889,74 +884,74 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
     params->has_throttle_trigger_threshold = true;
-    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
+    params->throttle_trigger_threshold = s->config.throttle_trigger_threshold;
     params->has_cpu_throttle_initial = true;
-    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
+    params->cpu_throttle_initial = s->config.cpu_throttle_initial;
     params->has_cpu_throttle_increment = true;
-    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
+    params->cpu_throttle_increment = s->config.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
-    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = g_strdup(s->parameters.tls_creds ?
-                                 s->parameters.tls_creds : "");
-    params->tls_hostname = g_strdup(s->parameters.tls_hostname ?
-                                    s->parameters.tls_hostname : "");
-    params->tls_authz = g_strdup(s->parameters.tls_authz ?
-                                 s->parameters.tls_authz : "");
+    params->cpu_throttle_tailslow = s->config.cpu_throttle_tailslow;
+    params->tls_creds = g_strdup(s->config.tls_creds ?
+                                 s->config.tls_creds : "");
+    params->tls_hostname = g_strdup(s->config.tls_hostname ?
+                                    s->config.tls_hostname : "");
+    params->tls_authz = g_strdup(s->config.tls_authz ?
+                                 s->config.tls_authz : "");
     params->has_max_bandwidth = true;
-    params->max_bandwidth = s->parameters.max_bandwidth;
+    params->max_bandwidth = s->config.max_bandwidth;
     params->has_avail_switchover_bandwidth = true;
-    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
+    params->avail_switchover_bandwidth = s->config.avail_switchover_bandwidth;
     params->has_downtime_limit = true;
-    params->downtime_limit = s->parameters.downtime_limit;
+    params->downtime_limit = s->config.downtime_limit;
     params->has_x_checkpoint_delay = true;
-    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->x_checkpoint_delay = s->config.x_checkpoint_delay;
     params->has_multifd_channels = true;
-    params->multifd_channels = s->parameters.multifd_channels;
+    params->multifd_channels = s->config.multifd_channels;
     params->has_multifd_compression = true;
-    params->multifd_compression = s->parameters.multifd_compression;
+    params->multifd_compression = s->config.multifd_compression;
     params->has_multifd_zlib_level = true;
-    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
+    params->multifd_zlib_level = s->config.multifd_zlib_level;
     params->has_multifd_qatzip_level = true;
-    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
+    params->multifd_qatzip_level = s->config.multifd_qatzip_level;
     params->has_multifd_zstd_level = true;
-    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
+    params->multifd_zstd_level = s->config.multifd_zstd_level;
     params->has_xbzrle_cache_size = true;
-    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    params->xbzrle_cache_size = s->config.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth = true;
-    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
+    params->max_postcopy_bandwidth = s->config.max_postcopy_bandwidth;
     params->has_max_cpu_throttle = true;
-    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
+    params->max_cpu_throttle = s->config.max_cpu_throttle;
     params->has_announce_initial = true;
-    params->announce_initial = s->parameters.announce_initial;
+    params->announce_initial = s->config.announce_initial;
     params->has_announce_max = true;
-    params->announce_max = s->parameters.announce_max;
+    params->announce_max = s->config.announce_max;
     params->has_announce_rounds = true;
-    params->announce_rounds = s->parameters.announce_rounds;
+    params->announce_rounds = s->config.announce_rounds;
     params->has_announce_step = true;
-    params->announce_step = s->parameters.announce_step;
+    params->announce_step = s->config.announce_step;
 
-    if (s->parameters.has_block_bitmap_mapping) {
+    if (s->config.has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
         params->block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       s->parameters.block_bitmap_mapping);
+                       s->config.block_bitmap_mapping);
     }
 
     params->has_x_vcpu_dirty_limit_period = true;
-    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
+    params->x_vcpu_dirty_limit_period = s->config.x_vcpu_dirty_limit_period;
     params->has_vcpu_dirty_limit = true;
-    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
+    params->vcpu_dirty_limit = s->config.vcpu_dirty_limit;
     params->has_mode = true;
-    params->mode = s->parameters.mode;
+    params->mode = s->config.mode;
     params->has_zero_page_detection = true;
-    params->zero_page_detection = s->parameters.zero_page_detection;
+    params->zero_page_detection = s->config.zero_page_detection;
     params->has_direct_io = true;
-    params->direct_io = s->parameters.direct_io;
+    params->direct_io = s->config.direct_io;
 
     return params;
 }
 
-void migrate_params_init(MigrationParameters *params)
+void migrate_config_init(MigrationConfig *params)
 {
     /* these should match the parameters in migration_properties */
     params->has_throttle_trigger_threshold = true;
@@ -988,10 +983,10 @@ void migrate_params_init(MigrationParameters *params)
 }
 
 /*
- * Check whether the parameters are valid. Error will be put into errp
+ * Check whether the options are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
  */
-bool migrate_params_check(MigrationParameters *params, Error **errp)
+bool migrate_config_check(MigrationConfig *params, Error **errp)
 {
     ERRP_GUARD();
 
@@ -1162,7 +1157,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     if (params->has_vcpu_dirty_limit &&
         (params->vcpu_dirty_limit < 1)) {
         error_setg(errp,
-                   "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s");
+                   "Option 'vcpu_dirty_limit' must be greater than 1 MB/s");
         return false;
     }
 
@@ -1176,12 +1171,12 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
 /*
  * Compatibility layer to convert MigrateSetParameters to
- * MigrationParameters. In the existing QMP user interface, the
+ * MigrationConfig. In the existing QMP user interface, the
  * migrate-set-parameters command takes the TLS options as 'StrOrNull'
  * while the query-migrate-parameters command returns the TLS strings
  * as 'str'.
  */
-static void migrate_params_copy_compat(MigrationParameters *dst,
+static void migrate_params_copy_compat(MigrationConfig *dst,
                                        MigrateSetParameters *src)
 {
     /* copy the common elements between the two */
@@ -1215,141 +1210,126 @@ static void migrate_params_copy_compat(MigrationParameters *dst,
     }
 }
 
-static void migrate_params_apply(MigrateSetParameters *params)
+static void migrate_config_apply(MigrationConfig *new)
 {
     MigrationState *s = migrate_get_current();
 
-    if (params->has_throttle_trigger_threshold) {
-        s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
+    if (new->has_throttle_trigger_threshold) {
+        s->config.throttle_trigger_threshold = new->throttle_trigger_threshold;
     }
 
-    if (params->has_cpu_throttle_initial) {
-        s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
+    if (new->has_cpu_throttle_initial) {
+        s->config.cpu_throttle_initial = new->cpu_throttle_initial;
     }
 
-    if (params->has_cpu_throttle_increment) {
-        s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
+    if (new->has_cpu_throttle_increment) {
+        s->config.cpu_throttle_increment = new->cpu_throttle_increment;
     }
 
-    if (params->has_cpu_throttle_tailslow) {
-        s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
+    if (new->has_cpu_throttle_tailslow) {
+        s->config.cpu_throttle_tailslow = new->cpu_throttle_tailslow;
     }
 
-    if (params->tls_creds) {
-        g_free(s->parameters.tls_creds);
-
-        if (params->tls_creds->type == QTYPE_QNULL) {
-            s->parameters.tls_creds = NULL;
-        } else {
-            s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
-        }
+    if (new->tls_creds) {
+        g_free(s->config.tls_creds);
+        s->config.tls_creds = g_strdup(new->tls_creds);
     }
 
-    if (params->tls_hostname) {
-        g_free(s->parameters.tls_hostname);
-
-        if (params->tls_hostname->type == QTYPE_QNULL) {
-            s->parameters.tls_hostname = NULL;
-        } else {
-            s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
-        }
+    if (new->tls_hostname) {
+        g_free(s->config.tls_hostname);
+        s->config.tls_hostname = g_strdup(new->tls_hostname);
     }
 
-    if (params->tls_authz) {
-        g_free(s->parameters.tls_authz);
-
-        if (params->tls_authz->type == QTYPE_QNULL) {
-            s->parameters.tls_authz = NULL;
-        } else {
-            s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
-        }
+    if (new->tls_authz) {
+        g_free(s->config.tls_authz);
+        s->config.tls_authz = g_strdup(new->tls_authz);
     }
 
-    if (params->has_max_bandwidth) {
-        s->parameters.max_bandwidth = params->max_bandwidth;
+    if (new->has_max_bandwidth) {
+        s->config.max_bandwidth = new->max_bandwidth;
     }
 
-    if (params->has_avail_switchover_bandwidth) {
-        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
+    if (new->has_avail_switchover_bandwidth) {
+        s->config.avail_switchover_bandwidth = new->avail_switchover_bandwidth;
     }
 
-    if (params->has_downtime_limit) {
-        s->parameters.downtime_limit = params->downtime_limit;
+    if (new->has_downtime_limit) {
+        s->config.downtime_limit = new->downtime_limit;
     }
 
-    if (params->has_x_checkpoint_delay) {
-        s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
+    if (new->has_x_checkpoint_delay) {
+        s->config.x_checkpoint_delay = new->x_checkpoint_delay;
     }
 
-    if (params->has_multifd_channels) {
-        s->parameters.multifd_channels = params->multifd_channels;
+    if (new->has_multifd_channels) {
+        s->config.multifd_channels = new->multifd_channels;
     }
-    if (params->has_multifd_compression) {
-        s->parameters.multifd_compression = params->multifd_compression;
+    if (new->has_multifd_compression) {
+        s->config.multifd_compression = new->multifd_compression;
     }
-    if (params->has_multifd_qatzip_level) {
-        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
+    if (new->has_multifd_qatzip_level) {
+        s->config.multifd_qatzip_level = new->multifd_qatzip_level;
     }
-    if (params->has_multifd_zlib_level) {
-        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
+    if (new->has_multifd_zlib_level) {
+        s->config.multifd_zlib_level = new->multifd_zlib_level;
     }
-    if (params->has_multifd_zstd_level) {
-        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
+    if (new->has_multifd_zstd_level) {
+        s->config.multifd_zstd_level = new->multifd_zstd_level;
     }
-    if (params->has_xbzrle_cache_size) {
-        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
+    if (new->has_xbzrle_cache_size) {
+        s->config.xbzrle_cache_size = new->xbzrle_cache_size;
     }
-    if (params->has_max_postcopy_bandwidth) {
-        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
+    if (new->has_max_postcopy_bandwidth) {
+        s->config.max_postcopy_bandwidth = new->max_postcopy_bandwidth;
     }
-    if (params->has_max_cpu_throttle) {
-        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
+    if (new->has_max_cpu_throttle) {
+        s->config.max_cpu_throttle = new->max_cpu_throttle;
     }
-    if (params->has_announce_initial) {
-        s->parameters.announce_initial = params->announce_initial;
+    if (new->has_announce_initial) {
+        s->config.announce_initial = new->announce_initial;
     }
-    if (params->has_announce_max) {
-        s->parameters.announce_max = params->announce_max;
+    if (new->has_announce_max) {
+        s->config.announce_max = new->announce_max;
     }
-    if (params->has_announce_rounds) {
-        s->parameters.announce_rounds = params->announce_rounds;
+    if (new->has_announce_rounds) {
+        s->config.announce_rounds = new->announce_rounds;
     }
-    if (params->has_announce_step) {
-        s->parameters.announce_step = params->announce_step;
+    if (new->has_announce_step) {
+        s->config.announce_step = new->announce_step;
     }
 
-    if (params->has_block_bitmap_mapping) {
+    if (new->has_block_bitmap_mapping) {
         qapi_free_BitmapMigrationNodeAliasList(
-            s->parameters.block_bitmap_mapping);
+            s->config.block_bitmap_mapping);
 
-        s->parameters.has_block_bitmap_mapping = true;
-        s->parameters.block_bitmap_mapping =
+        s->config.has_block_bitmap_mapping = true;
+        s->config.block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       params->block_bitmap_mapping);
+                       new->block_bitmap_mapping);
     }
 
-    if (params->has_x_vcpu_dirty_limit_period) {
-        s->parameters.x_vcpu_dirty_limit_period =
-            params->x_vcpu_dirty_limit_period;
+    if (new->has_x_vcpu_dirty_limit_period) {
+        s->config.x_vcpu_dirty_limit_period =
+            new->x_vcpu_dirty_limit_period;
     }
-    if (params->has_vcpu_dirty_limit) {
-        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
+    if (new->has_vcpu_dirty_limit) {
+        s->config.vcpu_dirty_limit = new->vcpu_dirty_limit;
     }
 
-    if (params->has_mode) {
-        s->parameters.mode = params->mode;
+    if (new->has_mode) {
+        s->config.mode = new->mode;
     }
 
-    if (params->has_zero_page_detection) {
-        s->parameters.zero_page_detection = params->zero_page_detection;
+    if (new->has_zero_page_detection) {
+        s->config.zero_page_detection = new->zero_page_detection;
     }
 
-    if (params->has_direct_io) {
-        s->parameters.direct_io = params->direct_io;
+    if (new->has_direct_io) {
+        s->config.direct_io = new->direct_io;
     }
 }
 
-static void migrate_post_update_params(MigrateSetParameters *new, Error **errp)
+static void migrate_post_update_config(MigrationConfig *new, Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1372,20 +1352,19 @@ static void migrate_post_update_params(MigrateSetParameters *new, Error **errp)
             migration_rate_set(new->max_postcopy_bandwidth);
         }
     }
-
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
-    MigrationParameters tmp = {};
+    MigrationConfig tmp = {};
 
     migrate_params_copy_compat(&tmp, params);
 
-    if (!migrate_params_check(&tmp, errp)) {
+    if (!migrate_config_check(&tmp, errp)) {
         /* Invalid parameter */
         return;
     }
 
-    migrate_params_apply(params);
-    migrate_post_update_params(params, errp);
+    migrate_config_apply(&tmp);
+    migrate_post_update_config(&tmp, errp);
 }
diff --git a/migration/options.h b/migration/options.h
index 762be4e641..20fdba4237 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -59,8 +59,6 @@ bool migrate_tls(void);
 
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
 
-/* parameters */
-
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
@@ -86,8 +84,6 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
-/* parameters helpers */
-
-bool migrate_params_check(MigrationParameters *params, Error **errp);
-void migrate_params_init(MigrationParameters *params);
+bool migrate_config_check(MigrationConfig *params, Error **errp);
+void migrate_config_init(MigrationConfig *params);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index e0ba8e0d48..b938bd621e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -973,11 +973,11 @@ static void migration_dirty_limit_guest(void)
      * vcpu-dirty-limit untouched.
      */
     if (dirtylimit_in_service() &&
-        quota_dirtyrate == s->parameters.vcpu_dirty_limit) {
+        quota_dirtyrate == s->config.vcpu_dirty_limit) {
         return;
     }
 
-    quota_dirtyrate = s->parameters.vcpu_dirty_limit;
+    quota_dirtyrate = s->config.vcpu_dirty_limit;
 
     /*
      * Set all vCPU a quota dirtyrate, note that the second
-- 
2.35.3


