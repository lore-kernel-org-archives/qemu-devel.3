Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B748C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q7G-0000e3-6N; Wed, 09 Sep 2026 17:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q7E-0000d3-Cx
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:46:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q7B-0005Rl-SQ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:46:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 798C31FCD6;
 Wed,  9 Sep 2026 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK20x9B437qCcKHi6lpSXqmLY3Zjg1kMeWo5wS+ZW0o=;
 b=CiBoSBrLezG/HXgCo7x1uXN5Y5vpqdVGyymprNaK3j14tnDoguEsJYxgfDenyaFLHmJVFq
 Z5fVXvBljOkpnYl8EogfId0Rlf0o8afRFmVtyOFPGVNLocbm8WewjUuo+4A3kL1p8AP2bL
 BLstmSnefPSbj5xIHh2cuGsZApL0JiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK20x9B437qCcKHi6lpSXqmLY3Zjg1kMeWo5wS+ZW0o=;
 b=y5BVNqihaFOgFEFs4qMILW/Nvd3sEDuRy+BvrqZ1lPy4WG2yNncKPF+yerw1dUuRJeqglb
 6EkFqwl31e5CyQCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK20x9B437qCcKHi6lpSXqmLY3Zjg1kMeWo5wS+ZW0o=;
 b=Yysl0I7AsIcbshJ76Osn5GNcNpX4EAKF5fqZjHfvfTDqK3mCuvz9w515e+l85X67MTGCOz
 76z7IOY5LLmCTr3/eiu816rmhVmWEFdHG8NDcluy8yRfxxbqukn833mIe0AWi7a1ccgveS
 Rw9CtGKeikb3F9tCx9bHP0I0InfnuaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK20x9B437qCcKHi6lpSXqmLY3Zjg1kMeWo5wS+ZW0o=;
 b=fXE4Ti8uHgGHlZs8FWzHUnwh1gQTz933ADkqT4VmG9tYvVXa9GnbEhD2BSgZiy4VkQ8qCI
 0OTf8YuPSOSjUcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2953137EC;
 Wed,  9 Sep 2026 21:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OH3JJorToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 16/18] migration: Add capabilities into MigrationParameters
Date: Wed,  9 Sep 2026 18:45:06 -0300
Message-ID: <20260909214509.237309-17-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Add capabilities to MigrationParameters. This structure will hold all
migration options. Capabilities will go away in the next patch.

From this point on, both QMP and HMP versions of
migrate-set-parameters and query-migrate-parameters gain the ability
to work with capabilities.

With MigrationParameters now having members for each capability, the
migration capabilities commands (query-migrate-capabilities,
migrate-set-capabilities) will soon be deprecated. Add a set of
helpers to convert between the old MigrationCapability representation
and the new representation as members of MigrationParameters.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |   8 +++
 migration/options.c   |  71 ++++++++++++++++++++++++
 migration/options.h   |   5 ++
 qapi/migration.json   | 124 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 204 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dab282dd2f..c8e7e86ea0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4086,6 +4086,14 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
         return false;
     }
 
+    /*
+     * FIXME: Temporarily while -global capabilties are still using
+     * s->capabilities. Will be gone by the end of the series.
+     */
+    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        migrate_capability_set_compat(&ms->parameters, i, ms->capabilities[i]);
+    }
+
     return migrate_caps_check(old_caps, ms->capabilities, errp);
 }
 
diff --git a/migration/options.c b/migration/options.c
index 188c4ad20b..aff5d8f550 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -775,6 +775,52 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     return true;
 }
 
+static bool *migrate_capability_get_addr(MigrationParameters *params,
+                                         enum MigrationCapability i)
+{
+    bool *cap_addr[] = {
+        &params->xbzrle, &params->rdma_pin_all,
+        &params->auto_converge, &params->events, &params->postcopy_ram,
+        &params->x_colo, &params->release_ram, &params->return_path,
+        &params->pause_before_switchover, &params->multifd,
+        &params->dirty_bitmaps, &params->postcopy_blocktime,
+        &params->late_block_activate, &params->x_ignore_shared,
+        &params->validate_uuid, &params->background_snapshot,
+        &params->zero_copy_send, &params->postcopy_preempt,
+        &params->switchover_ack, &params->dirty_limit, &params->mapped_ram,
+    };
+
+    assert(i >= 0 && i < MIGRATION_CAPABILITY__MAX);
+    return cap_addr[i];
+}
+
+/* Compatibility for code that reads capabilities in a loop */
+bool migrate_capability_get_compat(MigrationParameters *params, int i)
+{
+    return *(migrate_capability_get_addr(params, i));
+}
+
+/* Compatibility for code that writes capabilities in a loop */
+void migrate_capability_set_compat(MigrationParameters *params, int i, bool val)
+{
+    *(migrate_capability_get_addr(params, i)) = val;
+}
+
+/*
+ * Set capabilities for compatibility with the old
+ * migrate-set-capabilities command.
+ */
+void migrate_capabilities_set_compat(MigrationParameters *params,
+                                     MigrationCapabilityStatusList *caps)
+{
+    MigrationCapabilityStatusList *cap;
+
+    for (cap = caps; cap; cap = cap->next) {
+        migrate_capability_set_compat(params, cap->value->capability,
+                                      cap->value->state);
+    }
+}
+
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL, **tail = &head;
@@ -816,6 +862,8 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     for (cap = params; cap; cap = cap->next) {
         s->capabilities[cap->value->capability] = cap->value->state;
     }
+
+    migrate_capabilities_set_compat(&s->parameters, params);
 }
 
 /* parameters */
@@ -1139,6 +1187,15 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
         &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
+        &p->has_xbzrle, &p->has_rdma_pin_all,
+        &p->has_auto_converge, &p->has_events,
+        &p->has_postcopy_ram, &p->has_x_colo, &p->has_release_ram,
+        &p->has_return_path, &p->has_pause_before_switchover, &p->has_multifd,
+        &p->has_dirty_bitmaps, &p->has_postcopy_blocktime,
+        &p->has_late_block_activate, &p->has_x_ignore_shared,
+        &p->has_validate_uuid, &p->has_background_snapshot,
+        &p->has_zero_copy_send, &p->has_postcopy_preempt,
+        &p->has_switchover_ack, &p->has_dirty_limit, &p->has_mapped_ram,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1414,6 +1471,20 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
     tls_opt_to_str(input->tls_hostname);
     tls_opt_to_str(input->tls_authz);
 
+    /*
+     * FIXME: Temporarily while migrate_caps_check is not
+     * converted to look at s->parameters. Will be gone the end of
+     * the series.
+     */
+    bool new_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
+    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        new_caps[i] = migrate_capability_get_compat(cur, i);
+    }
+    if (!migrate_caps_check(migrate_get_current()->capabilities, new_caps,
+                            errp)) {
+        return;
+    }
+
     /* merge input on top of current */
     if (!migrate_params_merge(cur, input, &new, errp)) {
         return;
diff --git a/migration/options.h b/migration/options.h
index 0d9f88c11e..f7bf56e9ff 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -95,4 +95,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
 bool migrate_params_free(MigrationParameters *params, Error **errp);
 QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp);
+bool migrate_capability_get_compat(MigrationParameters *params, int i);
+void migrate_capability_set_compat(MigrationParameters *params, int i,
+                                   bool val);
+void migrate_capabilities_set_compat(MigrationParameters *params,
+                                     MigrationCapabilityStatusList *caps);
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index b1eaf7b054..5f4ad965d6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -830,7 +830,14 @@
            'zero-page-detection',
            'direct-io',
            { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'xbzrle', 'rdma-pin-all', 'auto-converge', 'events',
+           'postcopy-ram', 'x-colo', 'release-ram', 'return-path',
+           'pause-before-switchover', 'multifd', 'dirty-bitmaps',
+           'postcopy-blocktime', 'late-block-activate', 'x-ignore-shared',
+           'validate-uuid', 'background-snapshot', 'zero-copy-send',
+           'postcopy-preempt', 'switchover-ack', 'dirty-limit',
+           'mapped-ram'] }
 
 ##
 # @migrate-set-parameters:
@@ -1012,10 +1019,98 @@
 #     Must be set to the same value on both source and destination
 #     before migration starts.  (Since 11.1)
 #
+# @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
+#     Encoding).  This feature allows us to minimize migration traffic
+#     for certain work loads, by sending compressed difference of the
+#     pages
+#
+# @rdma-pin-all: Controls whether or not the entire VM memory
+#     footprint is mlock()'d on demand or all at once.  Refer to
+#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
+#
+# @events: generate events for each migration state change (since 2.4)
+#
+# @auto-converge: If enabled, QEMU will automatically throttle down
+#     the guest to speed up convergence of RAM migration.  (since 1.6)
+#
+# @postcopy-ram: Start executing on the migration target before all of
+#     RAM has been migrated, pulling the remaining pages along as
+#     needed.  The capacity must have the same setting on both source
+#     and target or migration will not even start.  **Note:** if the
+#     migration fails during postcopy the VM will fail.  (since 2.6)
+#
+# @x-colo: If enabled, migration will never end, and the state of the
+#     VM on the primary side will be migrated continuously to the VM
+#     on secondary side, this process is called COarse-Grain LOck
+#     Stepping (COLO) for Non-stop Service.  (since 2.8)
+#
+# @release-ram: if enabled, QEMU will free the migrated ram pages on
+#     the source during postcopy-ram migration.  (since 2.9)
+#
+# @return-path: If enabled, migration will use the return path even
+#     for precopy.  (since 2.10)
+#
+# @pause-before-switchover: Pause outgoing migration before
+#     serialising device state and before disabling block IO
+#     (since 2.11)
+#
+# @multifd: Use more than one fd for migration (since 4.0)
+#
+# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
+#     (since 2.12)
+#
+# @postcopy-blocktime: Calculate downtime for postcopy live migration
+#     (since 3.0)
+#
+# @late-block-activate: If enabled, the destination will not activate
+#     block devices (and thus take locks) immediately at the end of
+#     migration.  (since 3.0)
+#
+# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
+#     that is accessible on the destination machine.  (since 4.0)
+#
+# @validate-uuid: Send the UUID of the source to allow the destination
+#     to ensure it is the same.  (since 4.2)
+#
+# @background-snapshot: If enabled, the migration stream will be a
+#     snapshot of the VM exactly at the point when the migration
+#     procedure starts.  The VM RAM is saved with running VM.
+#     (since 6.0)
+#
+# @zero-copy-send: Controls behavior on sending memory pages on
+#     migration.  When true, enables a zero-copy mechanism for sending
+#     memory pages, if host supports it.  Requires that QEMU be
+#     permitted to use locked memory for guest RAM pages.  (since 7.1)
+#
+# @postcopy-preempt: If enabled, the migration process will allow
+#     postcopy requests to preempt precopy stream, so postcopy
+#     requests will be handled faster.  This is a performance feature
+#     and should not affect the correctness of postcopy migration.
+#     (since 7.1)
+#
+# @switchover-ack: If enabled, migration will not stop the source VM
+#     and complete the migration until the destination has
+#     acknowledged that it is OK to switch over.  The acknowledgement
+#     may depend, for example, on some device's data being loaded in
+#     the destination before doing switchover.  This can reduce
+#     downtime if devices that support this capability are present.
+#     Capability @return-path must be enabled to use it.  (since 8.1)
+#
+# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
+#     keep their dirty page rate within @vcpu-dirty-limit.  This can
+#     improve responsiveness of large guests during live migration,
+#     and can result in more stable read performance.  Requires KVM
+#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
+#
+# @mapped-ram: Migrate using fixed offsets in the migration file for
+#     each RAM page.  Requires a migration URI that supports seeking,
+#     such as a file.  (since 9.0)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size,
+#     @x-vcpu-dirty-limit-period, @x-colo, @x-ignore-shared and are
+#     experimental.
 #
 # Since: 2.4
 ##
@@ -1053,7 +1148,28 @@
             '*direct-io': 'bool',
             '*x-rdma-chunk-size': { 'type': 'uint64',
                                     'features': [ 'unstable' ] },
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*xbzrle': 'bool',
+            '*rdma-pin-all': 'bool',
+            '*auto-converge': 'bool',
+            '*events': 'bool',
+            '*postcopy-ram': 'bool',
+            '*x-colo': { 'type': 'bool', 'features': [ 'unstable' ] },
+            '*release-ram': 'bool',
+            '*return-path': 'bool',
+            '*pause-before-switchover': 'bool',
+            '*multifd': 'bool',
+            '*dirty-bitmaps': 'bool',
+            '*postcopy-blocktime': 'bool',
+            '*late-block-activate': 'bool',
+            '*x-ignore-shared': { 'type': 'bool', 'features': [ 'unstable' ] },
+            '*validate-uuid': 'bool',
+            '*background-snapshot': 'bool',
+            '*zero-copy-send': 'bool',
+            '*postcopy-preempt': 'bool',
+            '*switchover-ack': 'bool',
+            '*dirty-limit': 'bool',
+            '*mapped-ram': 'bool' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.53.0


