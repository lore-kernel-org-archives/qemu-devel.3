Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6607C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jrg-0005qW-Pc; Fri, 11 Apr 2025 15:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jqt-0004dv-Og
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:48 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jqq-0006HK-LF
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1957821197;
 Fri, 11 Apr 2025 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU+eRkPqVQ3PT79Hg9r6qcE8IGdXjfU30n9ZL+zRtA0=;
 b=Zava9YdVKyeRvG6OeXAkFeFcHdD2Na+n/BruvhWgQ3uAmOt5WdEimULGCLgoMzJ/Y/MdOd
 9Au6L+jDv1bZJJxhAAyzoS+P4WAXodVcM9p1nlz5wPyVBPMT3Fe5UhM8D6tZZIDOIJNpwh
 h1MGaUYMYBJfRwN5d/FRSglU1IP5wVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU+eRkPqVQ3PT79Hg9r6qcE8IGdXjfU30n9ZL+zRtA0=;
 b=dAYH6WDMYrI/Y9RhkQCtF8gIq6QVHxzPcLJy+nBkoTEJQHlprpjJbXQyIz3Uop7OvyPeTz
 /JIozFC+31MJwCBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU+eRkPqVQ3PT79Hg9r6qcE8IGdXjfU30n9ZL+zRtA0=;
 b=Zava9YdVKyeRvG6OeXAkFeFcHdD2Na+n/BruvhWgQ3uAmOt5WdEimULGCLgoMzJ/Y/MdOd
 9Au6L+jDv1bZJJxhAAyzoS+P4WAXodVcM9p1nlz5wPyVBPMT3Fe5UhM8D6tZZIDOIJNpwh
 h1MGaUYMYBJfRwN5d/FRSglU1IP5wVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU+eRkPqVQ3PT79Hg9r6qcE8IGdXjfU30n9ZL+zRtA0=;
 b=dAYH6WDMYrI/Y9RhkQCtF8gIq6QVHxzPcLJy+nBkoTEJQHlprpjJbXQyIz3Uop7OvyPeTz
 /JIozFC+31MJwCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9044B13886;
 Fri, 11 Apr 2025 19:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2C+JFDxq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:15:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 11/13] migration: Merge parameters and capability checks
Date: Fri, 11 Apr 2025 16:14:41 -0300
Message-Id: <20250411191443.22565-12-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Since parameters and capabilities are now stored in the same structure
and both use the same method to validate the input (i.e. copy, set a
temporary, validate the temporary and overwrite), it's possible to use
the same routine for both.

With this all distinction from capabilities and parameters is removed,
except for the user-facing pieces that have to maintain compatibility.

Note that capabilities need to be validated against conflicting
capabilities that are already set and also against capabilities that
the user might have set on the same command. Therefore they cannot
check the has_* fields, otherwise the amount of combinations would be
too large.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |   6 +-
 migration/options.c   | 528 ++++++++++++++++++++++--------------------
 migration/options.h   |   1 -
 3 files changed, 272 insertions(+), 263 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 031e0ade16..55d839abd0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4078,16 +4078,12 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
      */
     migrate_config_init(globals);
 
-    if (!migrate_config_check(globals, errp)) {
-        return false;
-    }
-
     /*
      * After the validation succeeds, there's no need to apply the
      * 'globals' because the values are already in s->config.
      */
 
-    return migrate_caps_check(&ms->config, errp);
+    return migrate_config_check(globals, errp);
 }
 
 static const TypeInfo migration_type = {
diff --git a/migration/options.c b/migration/options.c
index 562f58263f..4e3792dec3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -413,170 +413,6 @@ static bool migrate_incoming_started(void)
     return !!migration_incoming_get_current()->transport_data;
 }
 
-bool migrate_caps_check(MigrationConfig *new, Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    bool postcopy_already_on = s->config.postcopy_ram;
-    ERRP_GUARD();
-
-
-    if (new->zero_blocks) {
-        warn_report("zero-blocks capability is deprecated");
-    }
-
-#ifndef CONFIG_REPLICATION
-    if (new->x_colo) {
-        error_setg(errp, "QEMU compiled without replication module"
-                   " can't enable COLO");
-        error_append_hint(errp, "Please enable replication before COLO.\n");
-        return false;
-    }
-#endif
-
-    if (new->postcopy_ram) {
-        /* This check is reasonably expensive, so only when it's being
-         * set the first time, also it's only the destination that needs
-         * special support.
-         */
-        if (!postcopy_already_on &&
-            runstate_check(RUN_STATE_INMIGRATE) &&
-            !postcopy_ram_supported_by_host(mis, errp)) {
-            error_prepend(errp, "Postcopy is not supported: ");
-            return false;
-        }
-
-        if (new->x_ignore_shared) {
-            error_setg(errp, "Postcopy is not compatible with ignore-shared");
-            return false;
-        }
-
-        if (new->multifd) {
-            error_setg(errp, "Postcopy is not yet compatible with multifd");
-            return false;
-        }
-    }
-
-    if (new->background_snapshot) {
-        WriteTrackingSupport wt_support;
-
-        /*
-         * Check if 'background-snapshot' capability is supported by
-         * host kernel and compatible with guest memory configuration.
-         */
-        wt_support = migrate_query_write_tracking();
-        if (wt_support < WT_SUPPORT_AVAILABLE) {
-            error_setg(errp, "Background-snapshot is not supported by host kernel");
-            return false;
-        }
-        if (wt_support < WT_SUPPORT_COMPATIBLE) {
-            error_setg(errp, "Background-snapshot is not compatible "
-                    "with guest memory configuration");
-            return false;
-        }
-
-        if (new->postcopy_ram ||
-            new->dirty_bitmaps ||
-            new->postcopy_blocktime ||
-            new->late_block_activate ||
-            new->return_path ||
-            new->multifd ||
-            new->pause_before_switchover ||
-            new->auto_converge ||
-            new->release_ram ||
-            new->rdma_pin_all ||
-            new->xbzrle ||
-            new->x_colo ||
-            new->validate_uuid ||
-            new->zero_copy_send) {
-            error_setg(errp,
-                       "Background-snapshot is not compatible with "
-                       "currently set capabilities");
-            return false;
-        }
-    }
-
-#ifdef CONFIG_LINUX
-    if (new->zero_copy_send &&
-        (!new->multifd || new->xbzrle ||
-         migrate_multifd_compression() || migrate_tls())) {
-        error_setg(errp,
-                   "Zero copy only available for non-compressed non-TLS multifd migration");
-        return false;
-    }
-#else
-    if (new->zero_copy_send) {
-        error_setg(errp,
-                   "Zero copy currently only available on Linux");
-        return false;
-    }
-#endif
-
-    if (new->postcopy_preempt) {
-        if (!new->postcopy_ram) {
-            error_setg(errp, "Postcopy preempt requires postcopy-ram");
-            return false;
-        }
-
-        if (migrate_incoming_started()) {
-            error_setg(errp,
-                       "Postcopy preempt must be set before incoming starts");
-            return false;
-        }
-    }
-
-    if (new->multifd) {
-        if (migrate_incoming_started()) {
-            error_setg(errp, "Multifd must be set before incoming starts");
-            return false;
-        }
-    }
-
-    if (new->switchover_ack) {
-        if (!new->return_path) {
-            error_setg(errp, "Capability 'switchover-ack' requires capability "
-                             "'return-path'");
-            return false;
-        }
-    }
-    if (new->dirty_limit) {
-        if (new->auto_converge) {
-            error_setg(errp, "dirty-limit conflicts with auto-converge"
-                       " either of then available currently");
-            return false;
-        }
-
-        if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
-            error_setg(errp, "dirty-limit requires KVM with accelerator"
-                   " property 'dirty-ring-size' set");
-            return false;
-        }
-    }
-
-    if (new->multifd) {
-        if (new->xbzrle) {
-            error_setg(errp, "Multifd is not compatible with xbzrle");
-            return false;
-        }
-    }
-
-    if (new->mapped_ram) {
-        if (new->xbzrle) {
-            error_setg(errp,
-                       "Mapped-ram migration is incompatible with xbzrle");
-            return false;
-        }
-
-        if (new->postcopy_ram) {
-            error_setg(errp,
-                       "Mapped-ram migration is incompatible with postcopy");
-            return false;
-        }
-    }
-
-    return true;
-}
-
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL, **tail = &head;
@@ -594,6 +430,10 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
     return head;
 }
 
+/*
+ * Compatibility for code that accesses capability values by index
+ * (deprecated) instead of accessing the fields by name.
+ */
 static bool *migrate_config_get_cap_addr(MigrationConfig *config, int i)
 {
     bool *cap_addr = NULL;
@@ -672,31 +512,37 @@ static bool *migrate_config_get_cap_addr(MigrationConfig *config, int i)
     return cap_addr;
 }
 
-/* Compatibility for code that reads capabilities in a loop */
 bool migrate_config_get_cap_compat(MigrationConfig *config, int i)
 {
     return *(migrate_config_get_cap_addr(config, i));
 }
 
-/* Compatibility for code that writes capabilities in a loop */
-static void migrate_config_set_cap_compat(MigrationConfig *config, int i,
-                                          bool val)
-{
-    *(migrate_config_get_cap_addr(config, i)) = val;
-}
-
 /*
- * Set capabilities for compatibility with the old
- * migrate-set-capabilities command.
+ * For compatibility with the old migrate-set-capabilities
+ * command. Convert the user-facing MigrationCapabilityStatusList into
+ * the internal representation MigrationConfig.
  */
 static void migrate_config_set_caps_compat(MigrationConfig *config,
-                                           MigrationCapabilityStatusList *caps)
+                                           MigrationCapabilityStatusList *caps,
+                                           bool tmp_config)
 {
     MigrationCapabilityStatusList *cap;
 
+    /*
+     * The value that'll be written to the has_* fields. It should be
+     * 'true' for a temporary config so migrate_config_check() can see
+     * that the value is new. For the permanent config, it must be
+     * 'false' because the has_* fields of s->config are never used.
+     */
+    bool has_field_value = !tmp_config;
+
     for (cap = caps; cap; cap = cap->next) {
-        migrate_config_set_cap_compat(config, cap->value->capability,
-                                      cap->value->state);
+        int i = cap->value->capability;
+        bool val = cap->value->state;
+        bool *cap_addr = migrate_config_get_cap_addr(config, i);
+
+        *cap_addr = val;
+        *(cap_addr - sizeof(bool)) = has_field_value;
     }
 }
 
@@ -717,13 +563,12 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
      * another that's already set.
      */
     new = QAPI_CLONE(MigrationConfig, &s->config);
-    migrate_config_set_caps_compat(new, params);
+    migrate_config_set_caps_compat(new, params, true);
 
-    if (!migrate_caps_check(new, errp)) {
+    if (!migrate_config_check(new, errp)) {
         return;
     }
-
-    migrate_config_set_caps_compat(&s->config, params);
+    migrate_config_set_caps_compat(&s->config, params, false);
 }
 
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void)
@@ -1026,172 +871,192 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     return params;
 }
 
-void migrate_config_init(MigrationConfig *params)
+void migrate_config_init(MigrationConfig *config)
 {
-    /* these should match the parameters in migration_properties */
-    params->has_throttle_trigger_threshold = true;
-    params->has_cpu_throttle_initial = true;
-    params->has_cpu_throttle_increment = true;
-    params->has_cpu_throttle_tailslow = true;
-    params->has_max_bandwidth = true;
-    params->has_downtime_limit = true;
-    params->has_x_checkpoint_delay = true;
-    params->has_multifd_channels = true;
-    params->has_multifd_compression = true;
-    params->has_multifd_zlib_level = true;
-    params->has_multifd_qatzip_level = true;
-    params->has_multifd_zstd_level = true;
-    params->has_xbzrle_cache_size = true;
-    params->has_max_postcopy_bandwidth = true;
-    params->has_max_cpu_throttle = true;
-    params->has_announce_initial = true;
-    params->has_announce_max = true;
-    params->has_announce_rounds = true;
-    params->has_announce_step = true;
-    params->has_x_vcpu_dirty_limit_period = true;
-    params->has_vcpu_dirty_limit = true;
-    params->has_mode = true;
-    params->has_zero_page_detection = true;
-    params->has_direct_io = true;
-    params->has_avail_switchover_bandwidth = true;
-    params->has_block_bitmap_mapping = true;
+    config->has_throttle_trigger_threshold = true;
+    config->has_cpu_throttle_initial = true;
+    config->has_cpu_throttle_increment = true;
+    config->has_cpu_throttle_tailslow = true;
+    config->has_max_bandwidth = true;
+    config->has_downtime_limit = true;
+    config->has_x_checkpoint_delay = true;
+    config->has_multifd_channels = true;
+    config->has_multifd_compression = true;
+    config->has_multifd_zlib_level = true;
+    config->has_multifd_qatzip_level = true;
+    config->has_multifd_zstd_level = true;
+    config->has_xbzrle_cache_size = true;
+    config->has_max_postcopy_bandwidth = true;
+    config->has_max_cpu_throttle = true;
+    config->has_announce_initial = true;
+    config->has_announce_max = true;
+    config->has_announce_rounds = true;
+    config->has_announce_step = true;
+    config->has_x_vcpu_dirty_limit_period = true;
+    config->has_vcpu_dirty_limit = true;
+    config->has_mode = true;
+    config->has_zero_page_detection = true;
+    config->has_direct_io = true;
+    config->has_avail_switchover_bandwidth = true;
+    config->has_block_bitmap_mapping = true;
+
+    config->has_xbzrle = true;
+    config->has_rdma_pin_all = true;
+    config->has_auto_converge = true;
+    config->has_zero_blocks = true;
+    config->has_events = true;
+    config->has_postcopy_ram = true;
+    config->has_postcopy_preempt = true;
+    config->has_x_colo = true;
+    config->has_release_ram = true;
+    config->has_return_path = true;
+    config->has_multifd = true;
+    config->has_background_snapshot = true;
+#ifdef CONFIG_LINUX
+    config->has_zero_copy_send = true;
+#endif
+    config->has_switchover_ack = true;
+    config->has_dirty_limit = true;
+    config->has_mapped_ram = true;
 }
 
 /*
  * Check whether the options are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
  */
-bool migrate_config_check(MigrationConfig *params, Error **errp)
+bool migrate_config_check(MigrationConfig *new, Error **errp)
 {
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    bool old_postcopy_ram = migrate_get_current()->config.postcopy_ram;
     ERRP_GUARD();
 
-    if (params->has_throttle_trigger_threshold &&
-        (params->throttle_trigger_threshold < 1 ||
-         params->throttle_trigger_threshold > 100)) {
+    if (new->has_throttle_trigger_threshold &&
+        (new->throttle_trigger_threshold < 1 ||
+         new->throttle_trigger_threshold > 100)) {
         error_setg(errp, "Option throttle_trigger_threshold expects "
                    "an integer in the range of 1 to 100");
         return false;
     }
 
-    if (params->has_cpu_throttle_initial &&
-        (params->cpu_throttle_initial < 1 ||
-         params->cpu_throttle_initial > 99)) {
+    if (new->has_cpu_throttle_initial &&
+        (new->cpu_throttle_initial < 1 ||
+         new->cpu_throttle_initial > 99)) {
         error_setg(errp, "Option cpu_throttle_initial expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
-    if (params->has_cpu_throttle_increment &&
-        (params->cpu_throttle_increment < 1 ||
-         params->cpu_throttle_increment > 99)) {
+    if (new->has_cpu_throttle_increment &&
+        (new->cpu_throttle_increment < 1 ||
+         new->cpu_throttle_increment > 99)) {
         error_setg(errp, "Option cpu_throttle_increment expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
-    if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
+    if (new->has_max_bandwidth && (new->max_bandwidth > SIZE_MAX)) {
         error_setg(errp, "Option max_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
-    if (params->has_avail_switchover_bandwidth &&
-        (params->avail_switchover_bandwidth > SIZE_MAX)) {
+    if (new->has_avail_switchover_bandwidth &&
+        (new->avail_switchover_bandwidth > SIZE_MAX)) {
         error_setg(errp, "Option avail_switchover_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
-    if (params->has_downtime_limit &&
-        (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
+    if (new->has_downtime_limit &&
+        (new->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
         error_setg(errp, "Option downtime_limit expects "
                    "an integer in the range of 0 to "
                     stringify(MAX_MIGRATE_DOWNTIME)" ms");
         return false;
     }
 
-    if (params->has_multifd_channels && (params->multifd_channels < 1)) {
+    if (new->has_multifd_channels && (new->multifd_channels < 1)) {
         error_setg(errp, "Option multifd_channels expects "
                    "a value between 1 and 255");
         return false;
     }
 
-    if (params->has_multifd_zlib_level &&
-        (params->multifd_zlib_level > 9)) {
+    if (new->has_multifd_zlib_level &&
+        (new->multifd_zlib_level > 9)) {
         error_setg(errp, "Option multifd_zlib_level expects "
                    "a value between 0 and 9");
         return false;
     }
 
-    if (params->has_multifd_qatzip_level &&
-        ((params->multifd_qatzip_level > 9) ||
-        (params->multifd_qatzip_level < 1))) {
+    if (new->has_multifd_qatzip_level &&
+        ((new->multifd_qatzip_level > 9) ||
+        (new->multifd_qatzip_level < 1))) {
         error_setg(errp, "Option multifd_qatzip_level expects "
                    "a value between 1 and 9");
         return false;
     }
 
-    if (params->has_multifd_zstd_level &&
-        (params->multifd_zstd_level > 20)) {
+    if (new->has_multifd_zstd_level &&
+        (new->multifd_zstd_level > 20)) {
         error_setg(errp, "Option multifd_zstd_level expects "
                    "a value between 0 and 20");
         return false;
     }
 
-    if (params->has_xbzrle_cache_size &&
-        (params->xbzrle_cache_size < qemu_target_page_size() ||
-         !is_power_of_2(params->xbzrle_cache_size))) {
+    if (new->has_xbzrle_cache_size &&
+        (new->xbzrle_cache_size < qemu_target_page_size() ||
+         !is_power_of_2(new->xbzrle_cache_size))) {
         error_setg(errp, "Option xbzrle_cache_size expects "
                    "a power of two no less than the target page size");
         return false;
     }
 
-    if (params->has_max_cpu_throttle &&
-        (params->max_cpu_throttle < params->cpu_throttle_initial ||
-         params->max_cpu_throttle > 99)) {
+    if (new->has_max_cpu_throttle &&
+        (new->max_cpu_throttle < new->cpu_throttle_initial ||
+         new->max_cpu_throttle > 99)) {
         error_setg(errp, "max_Option cpu_throttle expects "
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
 
-    if (params->has_announce_initial &&
-        params->announce_initial > 100000) {
+    if (new->has_announce_initial &&
+        new->announce_initial > 100000) {
         error_setg(errp, "Option announce_initial expects "
                    "a value between 0 and 100000");
         return false;
     }
-    if (params->has_announce_max &&
-        params->announce_max > 100000) {
+    if (new->has_announce_max &&
+        new->announce_max > 100000) {
         error_setg(errp, "Option announce_max expects "
                    "a value between 0 and 100000");
         return false;
     }
-    if (params->has_announce_rounds &&
-        params->announce_rounds > 1000) {
+    if (new->has_announce_rounds &&
+        new->announce_rounds > 1000) {
         error_setg(errp, "Option announce_rounds expects "
                    "a value between 0 and 1000");
         return false;
     }
-    if (params->has_announce_step &&
-        (params->announce_step < 1 ||
-        params->announce_step > 10000)) {
+    if (new->has_announce_step &&
+        (new->announce_step < 1 ||
+        new->announce_step > 10000)) {
         error_setg(errp, "Option announce_step expects "
                    "a value between 0 and 10000");
         return false;
     }
 
-    if (params->has_block_bitmap_mapping &&
-        !check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
+    if (new->has_block_bitmap_mapping &&
+        !check_dirty_bitmap_mig_alias_map(new->block_bitmap_mapping, errp)) {
         error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
         return false;
     }
 
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
-        ((params->has_multifd_compression && params->multifd_compression) ||
-         (params->tls_creds && *params->tls_creds))) {
+        ((new->has_multifd_compression && new->multifd_compression) ||
+         (new->tls_creds && *new->tls_creds))) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1205,26 +1070,175 @@ bool migrate_config_check(MigrationConfig *params, Error **errp)
         return false;
     }
 
-    if (params->has_x_vcpu_dirty_limit_period &&
-        (params->x_vcpu_dirty_limit_period < 1 ||
-         params->x_vcpu_dirty_limit_period > 1000)) {
+    if (new->has_x_vcpu_dirty_limit_period &&
+        (new->x_vcpu_dirty_limit_period < 1 ||
+         new->x_vcpu_dirty_limit_period > 1000)) {
         error_setg(errp, "Option x-vcpu-dirty-limit-period expects "
                    "a value between 1 and 1000");
         return false;
     }
 
-    if (params->has_vcpu_dirty_limit &&
-        (params->vcpu_dirty_limit < 1)) {
+    if (new->has_vcpu_dirty_limit &&
+        (new->vcpu_dirty_limit < 1)) {
         error_setg(errp,
                    "Option 'vcpu_dirty_limit' must be greater than 1 MB/s");
         return false;
     }
 
-    if (params->has_direct_io && params->direct_io && !qemu_has_direct_io()) {
+    if (new->has_direct_io && new->direct_io && !qemu_has_direct_io()) {
         error_setg(errp, "No build-time support for direct-io");
         return false;
     }
 
+    if (new->zero_blocks) {
+        warn_report("zero-blocks capability is deprecated");
+    }
+
+#ifndef CONFIG_REPLICATION
+    if (new->x_colo) {
+        error_setg(errp, "QEMU compiled without replication module"
+                   " can't enable COLO");
+        error_append_hint(errp, "Please enable replication before COLO.\n");
+        return false;
+    }
+#endif
+
+    if (new->postcopy_ram) {
+        /* This check is reasonably expensive, so only when it's being
+         * set the first time, also it's only the destination that needs
+         * special support.
+         */
+        if (!old_postcopy_ram && runstate_check(RUN_STATE_INMIGRATE) &&
+            !postcopy_ram_supported_by_host(mis, errp)) {
+            error_prepend(errp, "Postcopy is not supported: ");
+            return false;
+        }
+
+        if (new->x_ignore_shared) {
+            error_setg(errp, "Postcopy is not compatible with ignore-shared");
+            return false;
+        }
+
+        if (new->multifd) {
+            error_setg(errp, "Postcopy is not yet compatible with multifd");
+            return false;
+        }
+    }
+
+    if (new->background_snapshot) {
+        WriteTrackingSupport wt_support;
+
+        /*
+         * Check if 'background-snapshot' capability is supported by
+         * host kernel and compatible with guest memory configuration.
+         */
+        wt_support = migrate_query_write_tracking();
+        if (wt_support < WT_SUPPORT_AVAILABLE) {
+            error_setg(errp, "Background-snapshot is not supported by host kernel");
+            return false;
+        }
+        if (wt_support < WT_SUPPORT_COMPATIBLE) {
+            error_setg(errp, "Background-snapshot is not compatible "
+                    "with guest memory configuration");
+            return false;
+        }
+
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
+        }
+    }
+
+    if (new->zero_copy_send) {
+#ifdef CONFIG_LINUX
+        if (!new->multifd || new->xbzrle ||
+            migrate_multifd_compression() || migrate_tls()) {
+            error_setg(errp,
+                       "Zero copy only available for non-compressed non-TLS multifd migration");
+            return false;
+        }
+#else
+        error_setg(errp,
+                   "Zero copy currently only available on Linux");
+        return false;
+#endif
+    }
+
+    if (new->postcopy_preempt) {
+        if (!new->postcopy_ram) {
+            error_setg(errp, "Postcopy preempt requires postcopy-ram");
+            return false;
+        }
+
+        if (migrate_incoming_started()) {
+            error_setg(errp,
+                       "Postcopy preempt must be set before incoming starts");
+            return false;
+        }
+    }
+
+    if (new->multifd) {
+        if (migrate_incoming_started()) {
+            error_setg(errp, "Multifd must be set before incoming starts");
+            return false;
+        }
+
+        if (new->xbzrle) {
+            error_setg(errp, "Multifd is not compatible with xbzrle");
+            return false;
+        }
+    }
+
+    if (new->switchover_ack) {
+        if (!new->return_path) {
+            error_setg(errp, "Capability 'switchover-ack' requires capability "
+                             "'return-path'");
+            return false;
+        }
+    }
+    if (new->dirty_limit) {
+        if (new->auto_converge) {
+            error_setg(errp, "dirty-limit conflicts with auto-converge"
+                       " either of then available currently");
+            return false;
+        }
+
+        if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
+            error_setg(errp, "dirty-limit requires KVM with accelerator"
+                   " property 'dirty-ring-size' set");
+            return false;
+        }
+    }
+
+    if (new->mapped_ram) {
+        if (new->xbzrle) {
+            error_setg(errp,
+                       "Mapped-ram migration is incompatible with xbzrle");
+            return false;
+        }
+
+        if (new->postcopy_ram) {
+            error_setg(errp,
+                       "Mapped-ram migration is incompatible with postcopy");
+            return false;
+        }
+    }
+
     return true;
 }
 
diff --git a/migration/options.h b/migration/options.h
index 6455bce985..61ee854bb0 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -46,7 +46,6 @@ bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
 
-
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
-- 
2.35.3


