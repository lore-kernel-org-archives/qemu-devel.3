Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53216C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFy-0000wN-IC; Wed, 02 Sep 2026 18:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFx-0000wD-RW
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFv-0002OX-A0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:33 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4C491F8B4;
 Wed,  2 Sep 2026 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH3MKb5YzB+rnU9zEsOyvTRfO2RczCCPz4ovZI8ofyM=;
 b=eKIdj8wWbISTgg1Atl3B2A75nlqDT7PXLE0FhjE4OGHD4otdKHJ/tr1jjo+fBweDGvjqrM
 0kUfDUTeS13WOnzpD65WgGBKfI4gaXtSj6t+o/eg5fGpOkGXNyQ3sB74sSJHTXDSMyhg1N
 pDzud7wH6lsWpDJDVP5nJ5XJVhwbYas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH3MKb5YzB+rnU9zEsOyvTRfO2RczCCPz4ovZI8ofyM=;
 b=MF4XtYPrTVWUVDcmkPsHT+5p4+mBXAG/PxN4Ld2oBxkOSY8MTy0S5m8pRv2P8ELNFEuWvz
 U4ACcH4vYUERCgCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH3MKb5YzB+rnU9zEsOyvTRfO2RczCCPz4ovZI8ofyM=;
 b=AG1Qg0aFTJNThmw0y4HPJTnIJ+jAYySY3T3WDNws/JVg6IDKVPJgpjf18DyKA3R1rsdvNR
 yfZEb8KQ9oA7UJr/n8+QqlruCY5rYW4q2FtHHxg9HUL3V4eVMfZ7RIBPpnkHH32lAuk40G
 if/cXEXfAmn3+kJV+0ib/WA/TV7s2VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH3MKb5YzB+rnU9zEsOyvTRfO2RczCCPz4ovZI8ofyM=;
 b=a29u1p1BP37NfRxXVPKSQT1T1o/t959+6H1PAfpj4lMjuZTDJN7Ra549Q0LOZaa3AELVLO
 zVWEPaiYI+bccpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F98613874;
 Wed,  2 Sep 2026 22:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABBOODOgmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 12/18] migration: Change HMP 'info migrate_parameters' output
Date: Wed,  2 Sep 2026 19:15:40 -0300
Message-ID: <20260902221547.1812481-13-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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
for a few parameters. This is convenient for a user. It also requires
every parameter to be individually listed in the
hmp_migrate_set_parameter() function, which in turn requires the
MigrationParameter (singular) enum to exist. While the latter is not
bothersome at all, the former is.

From a development and maintenance perspective, having a list of
parameters explicitly written in several parts of the code brings
several annoyances: conflicts during rebase, multiple extra hits when
grepping, requires contributors to search for every location a change
needs to be mirrored to, etc.

Remove the units from the output so we can write this code in a more
convenient way. The HMP output is not part of any ABI.

Also remove quotes from around the TLS options strings as this is
inconsistent with all the other strings.

Change block-bitmap-mapping format to a single line. This requires
updating one of the iotests to match.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c     | 70 +++++++++++++++++-------------
 tests/qemu-iotests/300             | 20 ++++++---
 tests/qtest/migration/misc-tests.c | 30 ++++++-------
 3 files changed, 69 insertions(+), 51 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 220ac28b5e3..089c6d4ff46 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -336,16 +336,16 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     params = qmp_query_migrate_parameters(NULL);
 
     if (params) {
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
             params->announce_initial);
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
             params->announce_max);
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
             params->announce_rounds);
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
             params->announce_step);
         assert(params->has_throttle_trigger_threshold);
@@ -369,35 +369,35 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
             params->max_cpu_throttle);
         assert(params->tls_creds);
-        monitor_printf(mon, "%s: '%s'\n",
+        monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
                        params->tls_creds->u.s);
         assert(params->tls_hostname);
-        monitor_printf(mon, "%s: '%s'\n",
+        monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
                        params->tls_hostname->u.s);
         assert(params->tls_authz);
-        monitor_printf(mon, "%s: '%s'\n",
+        monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
                        params->tls_authz->u.s);
         assert(params->has_max_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
         assert(params->has_avail_switchover_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
             params->avail_switchover_bandwidth);
         assert(params->has_max_postcopy_bandwidth);
-        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
         assert(params->has_downtime_limit);
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
-        monitor_printf(mon, "%s: %u ms\n",
+        monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
         monitor_printf(mon, "%s: %u\n",
@@ -411,41 +411,51 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
             qapi_enum_lookup(&ZeroPageDetection_lookup,
                 params->zero_page_detection));
-        monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
 
         if (s->has_block_bitmap_mapping) {
-            const BitmapMigrationNodeAliasList *bmnal;
+            BitmapMigrationNodeAliasList *nal;
+            BitmapMigrationNodeAlias *na;
+            BitmapMigrationBitmapAliasList *bal;
+            BitmapMigrationBitmapAlias *ba;
+            BitmapMigrationBitmapAliasTransform *bat;
 
-            monitor_printf(mon, "%s:\n",
+            monitor_printf(mon, "%s:",
                            MigrationParameter_str(
                                MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
 
-            for (bmnal = params->block_bitmap_mapping;
-                 bmnal;
-                 bmnal = bmnal->next)
+            for (nal = params->block_bitmap_mapping; nal; nal = nal->next)
             {
-                const BitmapMigrationNodeAlias *bmna = bmnal->value;
-                const BitmapMigrationBitmapAliasList *bmbal;
+                na = nal->value;
+                monitor_printf(mon, " bitmaps:");
+                for (bal = na->bitmaps; bal; bal = bal->next) {
+                    ba = bal->value;
+                    bat = ba->transform;
 
-                monitor_printf(mon, "  '%s' -> '%s'\n",
-                               bmna->node_name, bmna->alias);
-
-                for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
-                    const BitmapMigrationBitmapAlias *bmba = bmbal->value;
-
-                    monitor_printf(mon, "    '%s' -> '%s'\n",
-                                   bmba->name, bmba->alias);
+                    monitor_printf(mon, " name: %s", ba->name);
+                    if (bat && bat->has_persistent) {
+                        if (bat->persistent) {
+                            monitor_printf(mon, " persistent: on");
+                        } else {
+                            monitor_printf(mon, " persistent: off");
+                        }
+                    }
+                    monitor_printf(mon, " alias: %s", ba->alias);
                 }
+                monitor_printf(mon, " node-name: %s alias: %s",
+                               na->node_name, na->alias);
             }
+
+            monitor_printf(mon, "\n");
         }
 
-        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
         MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
         params->x_vcpu_dirty_limit_period);
 
-        monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
             params->vcpu_dirty_limit);
 
@@ -462,7 +472,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         }
 
         if (params->has_x_rdma_chunk_size) {
-            monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
+            monitor_printf(mon, "%s: %" PRIu64 "\n",
                            MigrationParameter_str(
                                MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
                            params->x_rdma_chunk_size);
diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index e46616d7b19..03248f4474b 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -147,8 +147,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
             result = vm.qmp('human-monitor-command',
                             command_line='info migrate_parameters')
-
-            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
+            m = re.search(r'^block-bitmap-mapping:(.*)\r\n',
                           result['return'], flags=re.MULTILINE)
             hmp_mapping = m.group(0).replace('\r', '') if m else None
 
@@ -158,15 +157,24 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
     @staticmethod
     def to_hmp_mapping(mapping: BlockBitmapMapping) -> str:
-        result = 'block-bitmap-mapping:\n'
+        result = 'block-bitmap-mapping:'
 
         for node in mapping:
-            result += f"  '{node['node-name']}' -> '{node['alias']}'\n"
-
             assert isinstance(node['bitmaps'], list)
+            result += ' bitmaps:'
             for bitmap in node['bitmaps']:
-                result += f"    '{bitmap['name']}' -> '{bitmap['alias']}'\n"
+                result += f" name: {bitmap['name']}"
+                if 'transform' in bitmap:
+                    if 'persistent' in bitmap['transform']:
+                        if bitmap['transform']['persistent']:
+                            result += " persistent: on"
+                        else:
+                            result += " persistent: off"
+                result += f" alias: {bitmap['alias']}"
 
+            result += f" node-name: {node['node-name']} alias: {node['alias']}"
+
+        result += '\n'
         return result
 
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index ba8183978b3..34b376562ff 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -55,21 +55,21 @@ HMPTestData test_cases[] = {
     TEST("direct-io", "on", "on"),
 
     /* uint64_t */
-    TEST("announce-initial", "60", "60 ms"),
-    TEST("announce-max", "600", "600 ms"),
+    TEST("announce-initial", "60", "60"),
+    TEST("announce-max", "600", "600"),
     TEST("announce-rounds", "6", "6"),
-    TEST("announce-step", "15", "15 ms"),
-    TEST("downtime-limit", "400", "400 ms"),
-    TEST("avail-switchover-bandwidth", "2097152", "2199023255552 bytes/second"),
-    TEST("max-bandwidth", "9876543", "10356305952768 bytes/second"),
-    TEST("max-postcopy-bandwidth", "1048576", "1048576 bytes/second"),
-    TEST("vcpu-dirty-limit", "20", "20 MB/s"),
-    TEST("x-rdma-chunk-size", "1048576", "1048576 bytes"),
-    TEST("x-vcpu-dirty-limit-period", "750", "750 ms"),
-    TEST("xbzrle-cache-size", "67108864", "67108864 bytes"),
+    TEST("announce-step", "15", "15"),
+    TEST("downtime-limit", "400", "400"),
+    TEST("avail-switchover-bandwidth", "2097152", "2199023255552"),
+    TEST("max-bandwidth", "9876543", "10356305952768"),
+    TEST("max-postcopy-bandwidth", "1048576", "1048576"),
+    TEST("vcpu-dirty-limit", "20", "20"),
+    TEST("x-rdma-chunk-size", "1048576", "1048576"),
+    TEST("x-vcpu-dirty-limit-period", "750", "750"),
+    TEST("xbzrle-cache-size", "67108864", "67108864"),
 
     /* uint32_t */
-    TEST("x-checkpoint-delay", "5000", "5000 ms"),
+    TEST("x-checkpoint-delay", "5000", "5000"),
 
     /* uint8_t */
     TEST("cpu-throttle-increment", "15", "15"),
@@ -82,9 +82,9 @@ HMPTestData test_cases[] = {
     TEST("mode", "cpr-exec", "cpr-exec"),
     TEST("multifd-compression", "zlib", "zlib"),
     TEST("zero-page-detection", "none", "none"),
-    TEST("tls-authz", "my_authz", "'my_authz'"),
-    TEST("tls-creds", "null", "'null'"),
-    TEST("tls-hostname", "localhost", "'localhost'"),
+    TEST("tls-authz", "my_authz", "my_authz"),
+    TEST("tls-creds", "null", "null"),
+    TEST("tls-hostname", "localhost", "localhost"),
     TEST("cpr-exec-command", "/bin/true foobar", "/bin/true foobar"),
 
     /* can be set but are currently missing in the query output */
-- 
2.53.0


