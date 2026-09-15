Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FFEC88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GdV-0003lt-2R; Mon, 14 Sep 2026 20:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdR-0003Xh-1k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:53 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdN-0004oh-3t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B3A31FF6B;
 Tue, 15 Sep 2026 00:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DXE/id4ugWtIjlNn1UpgWZV0qHUesD6Nhy/EQlO1CQ=;
 b=SLeihxUKlYsRmRJ2qXR+ocM1fBH3IiywmIPU0QMSUm92pKYi/cPoaJ/MBhMKydS9a1OAJw
 ia9I08XRoMm7brVNDQ4axaZFA0Ii9UhUa4ShGgoLX8wgtknFuKerv200+9iamHf+mR+9DL
 hxsbLgLMaZt28MUYmg2zqwy0vic4VLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DXE/id4ugWtIjlNn1UpgWZV0qHUesD6Nhy/EQlO1CQ=;
 b=zdU/01hAk/ZLw8E2gf6t3wRDzunX2SkBzGX/SGhsevfI2guWM1T8YcG2zX39H3keNqOzUz
 zT3TvtAdu5I66mDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="R/11tr+z";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mo+OwUD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DXE/id4ugWtIjlNn1UpgWZV0qHUesD6Nhy/EQlO1CQ=;
 b=R/11tr+zxzRr0C4BwooG5B8TnA2AZImOMrVrsSxPTc5JDEZlB0j9FmSfVikSxawwtefamo
 3mmitS6+JhS4fxl7m8l1c//aBp4DINBTsgYx952UY2ZUSnk2yMpJfJPJkZNnQhrHXMgyxD
 zmOUz/seHdpgPpqVjA9otNwY6bkWwUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DXE/id4ugWtIjlNn1UpgWZV0qHUesD6Nhy/EQlO1CQ=;
 b=mo+OwUD51MvwurgdO8R0TW14RM7QY+rWpA8JlcER1qwMPFaHD2vT6a2WYjXcBy1vYCYUWa
 KVOG9w+qNzzWezCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 621681388C;
 Tue, 15 Sep 2026 00:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T13
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 12/20] migration: Change HMP 'info migrate_parameters'
 output
Date: Mon, 14 Sep 2026 21:02:00 -0300
Message-ID: <20260915000209.3692668-13-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B3A31FF6B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

The output of 'info migrate_parameters' includes units of measurement
for a few parameters. This is convenient for a user. However, having
the units also means that every parameter must have its own separate
piece of code to handle the formatting.

From a development and maintenance perspective, having a list of
parameters explicitly written in several parts of the code brings
annoyances: conflicts during rebase, extra hits when grepping,
contributors need to mirror a change to various locations, etc.

As the HMP output is not part of any ABI, remove the units from the
output to avoid this requirement of having individualized code for
every parameter. Next patches will take benefit from that and use
generic code to output the parameters values in HMP.

Aside from the units, also remove quotes from around the TLS options
strings as this is inconsistent with all the other strings.

Similarly, change block-bitmap-mapping format to remove the arrows
(->) for the mappings as not all parameters represented as a list have
this semantics. This requires updating one of the iotests.

Before:                                      After:
                     (unchanged entries omitted)
announce-initial: 50 ms                      announce-initial: 50
announce-max: 550 ms                         announce-max: 550
announce-rounds: 5                           announce-rounds: 5
announce-step: 100 ms                        announce-step: 100
tls-creds: ''                                tls-creds:
tls-hostname: ''                             tls-hostname:
tls-authz: ''                                tls-authz:
max-bandwidth: 134217728 bytes/second        max-bandwidth: 134217728
avail-switchover-bandwidth: 0 bytes/second   avail-switchover-bandwidth: 0
max-postcopy-bandwidth: 0 bytes/second       max-postcopy-bandwidth: 0
downtime-limit: 300 ms                       downtime-limit: 300
x-checkpoint-delay: 20000 ms                 x-checkpoint-delay: 20000
xbzrle-cache-size: 67108864 bytes            xbzrle-cache-size: 67108864
x-vcpu-dirty-limit-period: 1000 ms           x-vcpu-dirty-limit-period: 1000
vcpu-dirty-limit: 1 MB/s                     vcpu-dirty-limit: 1
x-rdma-chunk-size: 1048576 bytes             x-rdma-chunk-size: 1048576
block-bitmap-mapping:                        block-bitmap-mapping:
  'node-src' -> 'node-dst'                    bitmaps:
    'bmap0' -> 'bmap0'                        name: bmap0 alias: bmap0
                                              node-name: node-src alias: node-dst

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c     | 79 +++++++++++++++++-------------
 tests/qemu-iotests/300             | 20 +++++---
 tests/qtest/migration/misc-tests.c | 30 ++++++------
 3 files changed, 74 insertions(+), 55 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 67ea2eea15..b3422b848a 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -335,16 +335,16 @@ void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
     params = qmp_query_migrate_parameters(NULL);
 
     if (params) {
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
             params->announce_initial);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
             params->announce_max);
         monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
             params->announce_rounds);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
             params->announce_step);
         assert(params->has_throttle_trigger_threshold);
@@ -368,35 +368,35 @@ void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
             params->max_cpu_throttle);
         assert(params->tls_creds);
-        monitor_hmp_printf(hmp, "%s: '%s'\n",
+        monitor_hmp_printf(hmp, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
                        params->tls_creds->u.s);
         assert(params->tls_hostname);
-        monitor_hmp_printf(hmp, "%s: '%s'\n",
+        monitor_hmp_printf(hmp, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
                        params->tls_hostname->u.s);
         assert(params->tls_authz);
-        monitor_hmp_printf(hmp, "%s: '%s'\n",
+        monitor_hmp_printf(hmp, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
                        params->tls_authz->u.s);
         assert(params->has_max_bandwidth);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes/second\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
         assert(params->has_avail_switchover_bandwidth);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes/second\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
             params->avail_switchover_bandwidth);
         assert(params->has_max_postcopy_bandwidth);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes/second\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
         assert(params->has_downtime_limit);
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
-        monitor_hmp_printf(hmp, "%s: %u ms\n",
+        monitor_hmp_printf(hmp, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
         monitor_hmp_printf(hmp, "%s: %u\n",
@@ -410,41 +410,52 @@ void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
             qapi_enum_lookup(&ZeroPageDetection_lookup,
                 params->zero_page_detection));
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
 
         if (s->has_block_bitmap_mapping) {
-            const BitmapMigrationNodeAliasList *bmnal;
+            BitmapMigrationNodeAliasList *nal;
+            BitmapMigrationNodeAlias *na;
+            BitmapMigrationBitmapAliasList *bal;
+            BitmapMigrationBitmapAlias *ba;
+            BitmapMigrationBitmapAliasTransform *bat;
 
             monitor_hmp_printf(hmp, "%s:\n",
-                               MigrationParameter_str(
-                                   MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
 
-            for (bmnal = params->block_bitmap_mapping;
-                 bmnal;
-                 bmnal = bmnal->next)
+            for (nal = params->block_bitmap_mapping; nal; nal = nal->next)
             {
-                const BitmapMigrationNodeAlias *bmna = bmnal->value;
-                const BitmapMigrationBitmapAliasList *bmbal;
+                na = nal->value;
+                monitor_hmp_printf(hmp, " bitmaps:\n");
+                for (bal = na->bitmaps; bal; bal = bal->next) {
+                    ba = bal->value;
+                    bat = ba->transform;
 
-                monitor_hmp_printf(hmp, "  '%s' -> '%s'\n",
-                                   bmna->node_name, bmna->alias);
-
-                for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
-                    const BitmapMigrationBitmapAlias *bmba = bmbal->value;
-
-                    monitor_hmp_printf(hmp, "    '%s' -> '%s'\n",
-                                       bmba->name, bmba->alias);
+                    monitor_hmp_printf(hmp, " name: %s", ba->name);
+                    if (bat && bat->has_persistent) {
+                        monitor_hmp_printf(hmp, " transform:");
+                        if (bat->persistent) {
+                            monitor_hmp_printf(hmp, " persistent: on");
+                        } else {
+                            monitor_hmp_printf(hmp, " persistent: off");
+                        }
+                    }
+                    monitor_hmp_printf(hmp, " alias: %s\n", ba->alias);
                 }
+                monitor_hmp_printf(hmp, " node-name: %s alias: %s\n",
+                                   na->node_name, na->alias);
             }
+
+            monitor_hmp_printf(hmp, "\n");
         }
 
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
         MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
         params->x_vcpu_dirty_limit_period);
 
-        monitor_hmp_printf(hmp, "%s: %" PRIu64 " MB/s\n",
+        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
             params->vcpu_dirty_limit);
 
@@ -461,10 +472,10 @@ void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
         }
 
         if (params->has_x_rdma_chunk_size) {
-            monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes\n",
-                               MigrationParameter_str(
-                                   MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
-                               params->x_rdma_chunk_size);
+            monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
+                           params->x_rdma_chunk_size);
         }
 
         assert(params->has_cpr_exec_command);
diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index df2ba32632..7b97eef1fd 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -147,11 +147,9 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
             result = vm.qmp('human-monitor-command',
                             command_line='info migrate_parameters')
-
-            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
+            m = re.search(r'^block-bitmap-mapping:\r\n( .*\r\n)*',
                           result['return'], flags=re.MULTILINE)
             hmp_mapping = m.group(0).replace('\r', '') if m else None
-
             self.assertEqual(hmp_mapping, self.to_hmp_mapping(mapping))
         else:
             self.assert_qmp(result, 'error/desc', error)
@@ -161,11 +159,21 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         result = 'block-bitmap-mapping:\n'
 
         for node in mapping:
-            result += f"  '{node['node-name']}' -> '{node['alias']}'\n"
-
             assert isinstance(node['bitmaps'], list)
+            result += ' bitmaps:\n'
             for bitmap in node['bitmaps']:
-                result += f"    '{bitmap['name']}' -> '{bitmap['alias']}'\n"
+                result += f" name: {bitmap['name']}"
+                if 'transform' in bitmap:
+                    result += " transform:"
+                    if 'persistent' in bitmap['transform']:
+                        if bitmap['transform']['persistent']:
+                            result += " persistent: on"
+                        else:
+                            result += " persistent: off"
+                result += f" alias: {bitmap['alias']}\n"
+
+            result += f" node-name: {node['node-name']} alias: {node['alias']}"
+            result += '\n'
 
         return result
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index f70d35c658..182a8518a9 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -156,21 +156,21 @@ static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
         TEST("local", "on", "on"),
 
         /* uint64_t */
-        TEST("announce-initial", "60", "60 ms"),
-        TEST("announce-max", "600", "600 ms"),
+        TEST("announce-initial", "60", "60"),
+        TEST("announce-max", "600", "600"),
         TEST("announce-rounds", "6", "6"),
-        TEST("announce-step", "15", "15 ms"),
-        TEST("downtime-limit", "400", "400 ms"),
-        TEST("avail-switchover-bandwidth", "2097152", "2097152 bytes/second"),
-        TEST("max-bandwidth", "9876543", "9876543 bytes/second"),
-        TEST("max-postcopy-bandwidth", "1048576", "1048576 bytes/second"),
-        TEST("vcpu-dirty-limit", "20", "20 MB/s"),
-        TEST("x-rdma-chunk-size", "1048576", "1048576 bytes"),
-        TEST("x-vcpu-dirty-limit-period", "750", "750 ms"),
-        TEST("xbzrle-cache-size", "67108864", "67108864 bytes"),
+        TEST("announce-step", "15", "15"),
+        TEST("downtime-limit", "400", "400"),
+        TEST("avail-switchover-bandwidth", "2097152", "2097152"),
+        TEST("max-bandwidth", "9876543", "9876543"),
+        TEST("max-postcopy-bandwidth", "1048576", "1048576"),
+        TEST("vcpu-dirty-limit", "20", "20"),
+        TEST("x-rdma-chunk-size", "1048576", "1048576"),
+        TEST("x-vcpu-dirty-limit-period", "750", "750"),
+        TEST("xbzrle-cache-size", "67108864", "67108864"),
 
         /* uint32_t */
-        TEST("x-checkpoint-delay", "5000", "5000 ms"),
+        TEST("x-checkpoint-delay", "5000", "5000"),
 
         /* uint8_t */
         TEST("cpu-throttle-increment", "15", "15"),
@@ -183,9 +183,9 @@ static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
         TEST("mode", "cpr-exec", "cpr-exec"),
         TEST("multifd-compression", "zlib", "zlib"),
         TEST("zero-page-detection", "none", "none"),
-        TEST("tls-authz", "my_authz", "'my_authz'"),
-        TEST("tls-creds", "null", "'null'"),
-        TEST("tls-hostname", "localhost", "'localhost'"),
+        TEST("tls-authz", "my_authz", "my_authz"),
+        TEST("tls-creds", "null", "null"),
+        TEST("tls-hostname", "localhost", "localhost"),
         TEST("cpr-exec-command", "/bin/true foobar", "/bin/true foobar"),
 
         /* can be set but are currently missing in the query output */
-- 
2.53.0


