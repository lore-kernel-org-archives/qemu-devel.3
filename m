Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5B9D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdP-0002mP-UL; Mon, 15 Dec 2025 17:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdO-0002m4-Qu
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:38 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdM-0002gW-7d
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:37 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DFEF3378B;
 Mon, 15 Dec 2025 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJocILz+uSA9/P/KQL2bGoCUFFMgBjETMhLQ4bdlXMc=;
 b=XU2BOzjB0RmidjLb1pjysH4Kud+BVti1odhTWEb6lVW6UyZvJjVI55HGr4HX5uR3JtufFT
 7t8thGfAaxNKlcXtkxnzdteHRTMkwW/tY07VytqeDIbKRahWG52iGpkH8nkCDBAm/Y0P41
 ivsD22udP07mb904H8vkQsdChQ5wVdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836095;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJocILz+uSA9/P/KQL2bGoCUFFMgBjETMhLQ4bdlXMc=;
 b=ktuqeCN2K45RF0SoihmlrPb3Wgfna5jMWL8Kt/GW87U+eFdDTvYsO8DGCOI8E4lttNxrDT
 hAtaVyRDQWfFMiDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJocILz+uSA9/P/KQL2bGoCUFFMgBjETMhLQ4bdlXMc=;
 b=XU2BOzjB0RmidjLb1pjysH4Kud+BVti1odhTWEb6lVW6UyZvJjVI55HGr4HX5uR3JtufFT
 7t8thGfAaxNKlcXtkxnzdteHRTMkwW/tY07VytqeDIbKRahWG52iGpkH8nkCDBAm/Y0P41
 ivsD22udP07mb904H8vkQsdChQ5wVdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836095;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJocILz+uSA9/P/KQL2bGoCUFFMgBjETMhLQ4bdlXMc=;
 b=ktuqeCN2K45RF0SoihmlrPb3Wgfna5jMWL8Kt/GW87U+eFdDTvYsO8DGCOI8E4lttNxrDT
 hAtaVyRDQWfFMiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87FFC3EA63;
 Mon, 15 Dec 2025 22:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCOBEj2FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 18/51] migration: Cleanup hmp_info_migrate_parameters
Date: Mon, 15 Dec 2025 19:00:04 -0300
Message-ID: <20251215220041.12657-19-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Do a cleanup of hmp_info_migrate_parameters() before adding more lines
into it:

- Make sure every parameter asserts that the has_* field is
  set. qmp_query_migrate_parameters should have set them all. (except
  for block-bitmap-mapping)

- Remove the if (params), qmp_query_migrate_parameters never returns
  NULL.

- Add a macro to encapsulate boilerplate.

- Line breaks for legibility.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 292 ++++++++++++++++++---------------
 1 file changed, 163 insertions(+), 129 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 4f9f5800de..670ddb047b 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -33,6 +33,11 @@
 #include "options.h"
 #include "migration.h"
 
+#define PARAM_INFO(_a, _f, _e, _v) do {                                 \
+        assert(_a);                                                     \
+        monitor_printf(mon, _f, MigrationParameter_str(_e), _v);        \
+    } while (0)
+
 static void migration_global_dump(Monitor *mon)
 {
     MigrationState *ms = migrate_get_current();
@@ -324,140 +329,169 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     MigrationState *s = migrate_get_current();
 
     params = qmp_query_migrate_parameters(NULL);
+    assert(params);
 
-    if (params) {
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
-            params->announce_initial);
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
-            params->announce_max);
-        monitor_printf(mon, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
-            params->announce_rounds);
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
-            params->announce_step);
-        assert(params->has_throttle_trigger_threshold);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
-            params->throttle_trigger_threshold);
-        assert(params->has_cpu_throttle_initial);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
-            params->cpu_throttle_initial);
-        assert(params->has_cpu_throttle_increment);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
-            params->cpu_throttle_increment);
-        assert(params->has_cpu_throttle_tailslow);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
-            params->cpu_throttle_tailslow ? "on" : "off");
-        assert(params->has_max_cpu_throttle);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
-            params->max_cpu_throttle);
-        assert(params->tls_creds);
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
-                       params->tls_creds->u.s);
-        assert(params->tls_hostname);
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
-                       params->tls_hostname->u.s);
-        assert(params->tls_authz);
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-                       params->tls_authz->u.s);
-        assert(params->has_max_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
-            params->max_bandwidth);
-        assert(params->has_avail_switchover_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
-            params->avail_switchover_bandwidth);
-        assert(params->has_max_postcopy_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
-            params->max_postcopy_bandwidth);
-        assert(params->has_downtime_limit);
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
-            params->downtime_limit);
-        assert(params->has_x_checkpoint_delay);
-        monitor_printf(mon, "%s: %u ms\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
-            params->x_checkpoint_delay);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
-            params->multifd_channels);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
-            MultiFDCompression_str(params->multifd_compression));
-        assert(params->has_zero_page_detection);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
-            qapi_enum_lookup(&ZeroPageDetection_lookup,
-                params->zero_page_detection));
-        monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
-            params->xbzrle_cache_size);
-        monitor_printf(mon, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
-            params->max_postcopy_bandwidth);
-
-        if (s->has_block_bitmap_mapping) {
-            const BitmapMigrationNodeAliasList *bmnal;
-
-            monitor_printf(mon, "%s:\n",
-                           MigrationParameter_str(
-                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
-
-            for (bmnal = params->block_bitmap_mapping;
-                 bmnal;
-                 bmnal = bmnal->next)
-            {
-                const BitmapMigrationNodeAlias *bmna = bmnal->value;
-                const BitmapMigrationBitmapAliasList *bmbal;
-
-                monitor_printf(mon, "  '%s' -> '%s'\n",
-                               bmna->node_name, bmna->alias);
-
-                for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
-                    const BitmapMigrationBitmapAlias *bmba = bmbal->value;
-
-                    monitor_printf(mon, "    '%s' -> '%s'\n",
-                                   bmba->name, bmba->alias);
-                }
+    PARAM_INFO(params->has_announce_initial,
+               "%s: %" PRIu64 " ms\n",
+               MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
+               params->announce_initial);
+
+    PARAM_INFO(params->has_announce_max,
+               "%s: %" PRIu64 " ms\n",
+               MIGRATION_PARAMETER_ANNOUNCE_MAX,
+               params->announce_max);
+
+    PARAM_INFO(params->has_announce_rounds,
+               "%s: %" PRIu64 "\n",
+               MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
+               params->announce_rounds);
+
+    PARAM_INFO(params->has_announce_step,
+               "%s: %" PRIu64 " ms\n",
+               MIGRATION_PARAMETER_ANNOUNCE_STEP,
+               params->announce_step);
+
+    PARAM_INFO(params->has_throttle_trigger_threshold,
+               "%s: %u\n",
+               MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
+               params->throttle_trigger_threshold);
+
+    PARAM_INFO(params->has_cpu_throttle_initial,
+               "%s: %u\n",
+               MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
+               params->cpu_throttle_initial);
+
+    PARAM_INFO(params->has_cpu_throttle_increment,
+               "%s: %u\n",
+               MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
+               params->cpu_throttle_increment);
+
+    PARAM_INFO(params->has_cpu_throttle_tailslow,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
+               params->cpu_throttle_tailslow ? "on" : "off");
+
+    PARAM_INFO(params->has_max_cpu_throttle,
+               "%s: %u\n",
+               MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
+               params->max_cpu_throttle);
+
+    PARAM_INFO(params->tls_creds,
+               "%s: '%s'\n",
+               MIGRATION_PARAMETER_TLS_CREDS,
+               params->tls_creds->u.s);
+
+    PARAM_INFO(params->tls_hostname,
+               "%s: '%s'\n",
+               MIGRATION_PARAMETER_TLS_HOSTNAME,
+               params->tls_hostname->u.s);
+
+    PARAM_INFO(params->has_max_bandwidth,
+               "%s: %" PRIu64 " bytes/second\n",
+               MIGRATION_PARAMETER_MAX_BANDWIDTH,
+               params->max_bandwidth);
+
+    PARAM_INFO(params->has_avail_switchover_bandwidth,
+               "%s: %" PRIu64 " bytes/second\n",
+               MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH,
+               params->avail_switchover_bandwidth);
+
+    PARAM_INFO(params->has_downtime_limit,
+               "%s: %" PRIu64 " ms\n",
+               MIGRATION_PARAMETER_DOWNTIME_LIMIT,
+               params->downtime_limit);
+
+    PARAM_INFO(params->has_x_checkpoint_delay,
+               "%s: %u ms\n",
+               MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
+               params->x_checkpoint_delay);
+
+    PARAM_INFO(params->has_multifd_channels,
+               "%s: %u\n",
+               MIGRATION_PARAMETER_MULTIFD_CHANNELS,
+               params->multifd_channels);
+
+    PARAM_INFO(params->has_multifd_compression,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
+               qapi_enum_lookup(&MultiFDCompression_lookup,
+                                params->multifd_compression));
+
+    PARAM_INFO(params->has_zero_page_detection,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_ZERO_PAGE_DETECTION,
+               qapi_enum_lookup(&ZeroPageDetection_lookup,
+                                params->zero_page_detection));
+
+    PARAM_INFO(params->has_xbzrle_cache_size,
+               "%s: %" PRIu64 " bytes\n",
+               MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
+               params->xbzrle_cache_size);
+
+    PARAM_INFO(params->has_max_postcopy_bandwidth,
+               "%s: %" PRIu64 "\n",
+               MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
+               params->max_postcopy_bandwidth);
+
+    PARAM_INFO(params->tls_authz,
+               "%s: '%s'\n",
+               MIGRATION_PARAMETER_TLS_AUTHZ,
+               params->tls_authz->u.s);
+
+    if (s->has_block_bitmap_mapping) {
+        const BitmapMigrationNodeAliasList *bmnal;
+
+        monitor_printf(mon, "%s:\n",
+                       MigrationParameter_str(
+                           MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
+
+        for (bmnal = params->block_bitmap_mapping;
+             bmnal;
+             bmnal = bmnal->next)
+        {
+            const BitmapMigrationNodeAlias *bmna = bmnal->value;
+            const BitmapMigrationBitmapAliasList *bmbal;
+
+            monitor_printf(mon, "  '%s' -> '%s'\n",
+                           bmna->node_name, bmna->alias);
+
+            for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
+                const BitmapMigrationBitmapAlias *bmba = bmbal->value;
+
+                monitor_printf(mon, "    '%s' -> '%s'\n",
+                               bmba->name, bmba->alias);
             }
         }
-
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
-        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
-        params->x_vcpu_dirty_limit_period);
-
-        monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
-            params->vcpu_dirty_limit);
-
-        assert(params->has_mode);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
-            qapi_enum_lookup(&MigMode_lookup, params->mode));
-
-        if (params->has_direct_io) {
-            monitor_printf(mon, "%s: %s\n",
-                           MigrationParameter_str(
-                               MIGRATION_PARAMETER_DIRECT_IO),
-                           params->direct_io ? "on" : "off");
-        }
-
-        assert(params->has_cpr_exec_command);
-        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
 
+    PARAM_INFO(params->has_x_vcpu_dirty_limit_period,
+               "%s: %" PRIu64 " ms\n",
+               MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
+               params->x_vcpu_dirty_limit_period);
+
+    PARAM_INFO(params->has_vcpu_dirty_limit,
+               "%s: %" PRIu64 " MB/s\n",
+               MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
+               params->vcpu_dirty_limit);
+
+    PARAM_INFO(params->has_mode,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_MODE,
+               qapi_enum_lookup(&MigMode_lookup, params->mode));
+
+    PARAM_INFO(params->has_direct_io,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_DIRECT_IO,
+               params->direct_io ? "on" : "off");
+
+    PARAM_INFO(params->has_max_postcopy_bandwidth,
+               "%s: %" PRIu64 "\n",
+               MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
+               params->max_postcopy_bandwidth);
+
+    assert(params->has_cpr_exec_command);
+    monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
+
     qapi_free_MigrationParameters(params);
 }
 
-- 
2.51.0


