Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13495C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcM-0006ot-43; Mon, 02 Jun 2025 21:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcK-0006jd-8Q
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcI-0001YH-5b
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59F261F394;
 Tue,  3 Jun 2025 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Sqno2A+jYx4k9Arw8UvRW4fu+tVoJPUKAO0Ry/+Ocg=;
 b=nDjw3s0B7N9OsgaSWeOY9qzrkQRO2HEhW+LbnnG0aaX+BPb/uE5jssancyVdkuMkv2Odax
 k2SNze8sN5Y3OHpCdIzZiAYqU5/zsIkGqmx5WdNXb5sLQfBOwwhtsQx+H62M0b8POtOKtj
 nyrKe5tw0UxhNP2dyP8QzL0/PDpjpUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Sqno2A+jYx4k9Arw8UvRW4fu+tVoJPUKAO0Ry/+Ocg=;
 b=azBolPXSExs+lE1pcbRALehXHH0LtvMDpgvT+WyKtgWHDvovGq+OAV0Pf8WLTyUQbXgokU
 ur7OhbIWt2RsqMAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nDjw3s0B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=azBolPXS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Sqno2A+jYx4k9Arw8UvRW4fu+tVoJPUKAO0Ry/+Ocg=;
 b=nDjw3s0B7N9OsgaSWeOY9qzrkQRO2HEhW+LbnnG0aaX+BPb/uE5jssancyVdkuMkv2Odax
 k2SNze8sN5Y3OHpCdIzZiAYqU5/zsIkGqmx5WdNXb5sLQfBOwwhtsQx+H62M0b8POtOKtj
 nyrKe5tw0UxhNP2dyP8QzL0/PDpjpUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Sqno2A+jYx4k9Arw8UvRW4fu+tVoJPUKAO0Ry/+Ocg=;
 b=azBolPXSExs+lE1pcbRALehXHH0LtvMDpgvT+WyKtgWHDvovGq+OAV0Pf8WLTyUQbXgokU
 ur7OhbIWt2RsqMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C063E13700;
 Tue,  3 Jun 2025 01:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2N4PICFSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/21] migration: Cleanup hmp_info_migrate_parameters
Date: Mon,  2 Jun 2025 22:38:03 -0300
Message-Id: <20250603013810.4772-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 59F261F394
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

Do a cleanup of hmp_info_migrate_parameters() before adding more lines
into it:

- Make sure every parameter asserts that the has_* field is
  set. qmp_query_migrate_parameters should have set them all.

- Remove the if (params), qmp_query_migrate_parameters never returns
  NULL.

- Add a macro to encapsulate boilerplate.

- Line breaks for legibility.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 265 ++++++++++++++++++---------------
 1 file changed, 148 insertions(+), 117 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 685c8ebd53..4f68719eda 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -33,6 +33,11 @@
 #include "options.h"
 #include "migration.h"
 
+#define PARAM_INFO(_a, _f, _e, _v) do {                                \
+        assert(_a);                                                     \
+        monitor_printf(mon, _f, MigrationParameter_str(_e), _v);        \
+    } while (0)
+
 static void migration_global_dump(Monitor *mon)
 {
     MigrationState *ms = migrate_get_current();
@@ -243,127 +248,153 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     const BitmapMigrationNodeAliasList *bmnal;
 
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
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
-                       params->tls_creds ? params->tls_creds->u.s : "");
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
-                       params->tls_hostname ? params->tls_hostname->u.s : "");
-        assert(params->has_max_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
-            params->max_bandwidth);
-        assert(params->has_avail_switchover_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
-            params->avail_switchover_bandwidth);
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
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-                       params->tls_authz ? params->tls_authz->u.s : "");
-
-        assert(params->has_block_bitmap_mapping);
-        monitor_printf(mon, "%s:\n",
-                       MigrationParameter_str(
-                           MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
-
-        for (bmnal = params->block_bitmap_mapping;
-             bmnal;
-             bmnal = bmnal->next)
-        {
-            const BitmapMigrationNodeAlias *bmna = bmnal->value;
-            const BitmapMigrationBitmapAliasList *bmbal;
-
-            monitor_printf(mon, "  '%s' -> '%s'\n",
-                           bmna->node_name, bmna->alias);
-
-            for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
-                const BitmapMigrationBitmapAlias *bmba = bmbal->value;
-
-                monitor_printf(mon, "    '%s' -> '%s'\n",
-                               bmba->name, bmba->alias);
-            }
-        }
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
+    PARAM_INFO(params->has_block_bitmap_mapping,
+               "%s:%s\n",
+               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
+               "");
+
+    for (bmnal = params->block_bitmap_mapping; bmnal; bmnal = bmnal->next) {
+        const BitmapMigrationNodeAlias *bmna = bmnal->value;
+        const BitmapMigrationBitmapAliasList *bmbal;
+
+        monitor_printf(mon, "  '%s' -> '%s'\n", bmna->node_name, bmna->alias);
+
+        for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
+            const BitmapMigrationBitmapAlias *bmba = bmbal->value;
+
+            monitor_printf(mon, "    '%s' -> '%s'\n", bmba->name, bmba->alias);
         }
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
     qapi_free_MigrationParameters(params);
 }
 
-- 
2.35.3


