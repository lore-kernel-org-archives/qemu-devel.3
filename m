Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF755C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oTI-0007hE-RO; Tue, 30 Apr 2024 10:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oTE-0007bq-7r
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oT9-0000DA-87
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0BE61F7D2;
 Tue, 30 Apr 2024 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0BQW3wq94LF4Ivd4GVGsvQK9iKe++BghvLOQRUmtQ0=;
 b=R0+StfDFUUT7v7vu/m02ftJ5V/rJfr+0iYPOuF8G/oW0aRT88pwB7XQGdRSKlYV2N/2pIY
 DLbReSM+yzsgWmouIrpM+rHxMAnV6/T07y2jg48On1C37J/Y5SwQ5lol7ybrXJiuqLRO+R
 CUa7PLt6lR3tOYabbLkNWolQ+usJ4fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0BQW3wq94LF4Ivd4GVGsvQK9iKe++BghvLOQRUmtQ0=;
 b=p6YjtqF+0YvUl2xWGvn+2ef/0J0d5NkyrksBl+TF+T8esdOF31Em9pJSCVSGVwcfwP9cV9
 t8cmbBB+sIsc8FDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Pei63UKb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4sTsmj2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0BQW3wq94LF4Ivd4GVGsvQK9iKe++BghvLOQRUmtQ0=;
 b=Pei63UKboTZ20KEh+l+gLvJWwvw4UMhNXZzS3wK3lWQ65P5+SPPHgXsPH3P1ofb0ixKJTP
 i2xgMQ8qcEf4Xhi7WqkIoMt4QsM0bx5J81yir9q4Yn/VeKECVwKVrYxrzlbB+VSrevFkIR
 sQovgnZ0SZa3O6DQGTz8MlpUvnHG3cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0BQW3wq94LF4Ivd4GVGsvQK9iKe++BghvLOQRUmtQ0=;
 b=4sTsmj2ZttJOR4gMTED1MndY2QPMiKoZiVMb2LreL5htP8KSGdHey5wJXeiVtn5grdnIQp
 R9E42Syg1wuVoqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70940133A7;
 Tue, 30 Apr 2024 14:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0HMXDgoAMWZjSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Apr 2024 14:28:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 5/6] migration: Remove non-multifd compression
Date: Tue, 30 Apr 2024 11:27:36 -0300
Message-Id: <20240430142737.29066-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430142737.29066-1-farosas@suse.de>
References: <20240430142737.29066-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FREEMAIL_CC(0.00)[redhat.com,lists.libvirt.org,habkost.net,gmail.com,linaro.org,huawei.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E0BE61F7D2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The 'compress' migration capability enables the old compression code
which has shown issues over the years and is thought to be less stable
and tested than the more recent multifd-based compression. The old
compression code has been deprecated in 8.2 and now is time to remove
it.

Deprecation commit 864128df46 ("migration: Deprecate old compression
method").

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst       |  11 -
 docs/about/removed-features.rst |  55 ++++
 hw/core/machine.c               |   1 -
 migration/meson.build           |   1 -
 migration/migration-hmp-cmds.c  |  47 ---
 migration/migration.c           |  14 -
 migration/migration.h           |   7 -
 migration/options.c             | 164 ----------
 migration/options.h             |   5 -
 migration/qemu-file.c           |  78 -----
 migration/qemu-file.h           |   4 -
 migration/ram-compress.c        | 564 --------------------------------
 migration/ram-compress.h        |  77 -----
 migration/ram.c                 | 154 +--------
 qapi/migration.json             | 112 -------
 tests/qtest/migration-test.c    | 139 --------
 16 files changed, 64 insertions(+), 1369 deletions(-)
 delete mode 100644 migration/ram-compress.c
 delete mode 100644 migration/ram-compress.h

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 3b9b5ba6ef..0fb5c82640 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -464,14 +464,3 @@ both, older and future versions of QEMU.
 The ``blacklist`` config file option has been renamed to ``block-rpcs``
 (to be in sync with the renaming of the corresponding command line
 option).
-
-Migration
----------
-
-old compression method (since 8.2)
-''''''''''''''''''''''''''''''''''
-
-Compression method fails too much.  Too many races.  We are going to
-remove it if nobody fixes it.  For starters, migration-test
-compression tests are disabled because they fail randomly.  If you need
-compression, use multifd compression methods.
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 9e7d8ee4ff..fba0cfb0b0 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -505,6 +505,11 @@ configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
 to ensure that all the topology members described with -smp are greater
 than zero.
 
+``-global migration.decompress-error-check`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Removed along with the ``compression`` migration capability.
+
 User-mode emulator command line arguments
 -----------------------------------------
 
@@ -641,6 +646,31 @@ Block migration has been removed. For a replacement, see "QMP
 invocation for live storage migration with ``blockdev-mirror`` + NBD"
 in docs/interop/live-block-operations.rst.
 
+``migrate-set-parameter`` ``compress-level`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-zlib-level`` or ``multifd-zstd-level`` instead.
+
+``migrate-set-parameter`` ``compress-threads`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-channels`` instead.
+
+``migrate-set-parameter`` ``compress-wait-thread`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Removed with no replacement.
+
+``migrate-set-parameter`` ``decompress-threads`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-channels`` instead.
+
+``migrate-set-capability`` ``compress`` option (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-compression`` instead.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -722,6 +752,31 @@ Block migration has been removed. For a replacement, see "QMP
 invocation for live storage migration with ``blockdev-mirror`` + NBD"
 in docs/interop/live-block-operations.rst.
 
+``migrate_set_parameter`` ``compress-level`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-zlib-level`` or ``multifd-zstd-level`` instead.
+
+``migrate_set_parameter`` ``compress-threads`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-channels`` instead.
+
+``migrate_set_parameter`` ``compress-wait-thread`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Removed with no replacement.
+
+``migrate_set_parameter`` ``decompress-threads`` option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-channels`` instead.
+
+``migrate_set_capability`` ``compress`` option (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``multifd-compression`` instead.
+
 Host Architectures
 ------------------
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0dec48e802..60009c639c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -190,7 +190,6 @@ GlobalProperty hw_compat_3_0[] = {};
 const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
 
 GlobalProperty hw_compat_2_12[] = {
-    { "migration", "decompress-error-check", "off" },
     { "hda-audio", "use-timer", "false" },
     { "cirrus-vga", "global-vmstate", "true" },
     { "VGA", "global-vmstate", "true" },
diff --git a/migration/meson.build b/migration/meson.build
index d7e118f584..8815f80837 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -23,7 +23,6 @@ system_ss.add(files(
   'multifd.c',
   'multifd-zlib.c',
   'multifd-zero-page.c',
-  'ram-compress.c',
   'options.c',
   'postcopy-ram.c',
   'savevm.c',
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8040f1a46f..2499414235 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -46,8 +46,6 @@ static void migration_global_dump(Monitor *mon)
                    ms->send_configuration ? "on" : "off");
     monitor_printf(mon, "send-section-footer: %s\n",
                    ms->send_section_footer ? "on" : "off");
-    monitor_printf(mon, "decompress-error-check: %s\n",
-                   ms->decompress_error_check ? "on" : "off");
     monitor_printf(mon, "clear-bitmap-shift: %u\n",
                    ms->clear_bitmap_shift);
 }
@@ -162,19 +160,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->xbzrle_cache->overflow);
     }
 
-    if (info->compression) {
-        monitor_printf(mon, "compression pages: %" PRIu64 " pages\n",
-                       info->compression->pages);
-        monitor_printf(mon, "compression busy: %" PRIu64 "\n",
-                       info->compression->busy);
-        monitor_printf(mon, "compression busy rate: %0.2f\n",
-                       info->compression->busy_rate);
-        monitor_printf(mon, "compressed size: %" PRIu64 " kbytes\n",
-                       info->compression->compressed_size >> 10);
-        monitor_printf(mon, "compression rate: %0.2f\n",
-                       info->compression->compression_rate);
-    }
-
     if (info->has_cpu_throttle_percentage) {
         monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
                        info->cpu_throttle_percentage);
@@ -263,22 +248,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
             params->announce_step);
-        assert(params->has_compress_level);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
-            params->compress_level);
-        assert(params->has_compress_threads);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_THREADS),
-            params->compress_threads);
-        assert(params->has_compress_wait_thread);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD),
-            params->compress_wait_thread ? "on" : "off");
-        assert(params->has_decompress_threads);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
-            params->decompress_threads);
         assert(params->has_throttle_trigger_threshold);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
@@ -520,22 +489,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     }
 
     switch (val) {
-    case MIGRATION_PARAMETER_COMPRESS_LEVEL:
-        p->has_compress_level = true;
-        visit_type_uint8(v, param, &p->compress_level, &err);
-        break;
-    case MIGRATION_PARAMETER_COMPRESS_THREADS:
-        p->has_compress_threads = true;
-        visit_type_uint8(v, param, &p->compress_threads, &err);
-        break;
-    case MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD:
-        p->has_compress_wait_thread = true;
-        visit_type_bool(v, param, &p->compress_wait_thread, &err);
-        break;
-    case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
-        p->has_decompress_threads = true;
-        visit_type_uint8(v, param, &p->decompress_threads, &err);
-        break;
     case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
         p->has_throttle_trigger_threshold = true;
         visit_type_uint8(v, param, &p->throttle_trigger_threshold, &err);
diff --git a/migration/migration.c b/migration/migration.c
index 26017c9a2c..5dad66b810 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -27,7 +27,6 @@
 #include "sysemu/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
-#include "ram-compress.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "migration.h"
@@ -352,7 +351,6 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     multifd_recv_cleanup();
-    compress_threads_load_cleanup();
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
@@ -645,10 +643,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        if (migrate_compress()) {
-            error_setg(errp, "RDMA and compression can't be used together");
-            return;
-        }
         if (migrate_xbzrle()) {
             error_setg(errp, "RDMA and XBZRLE can't be used together");
             return;
@@ -739,11 +733,6 @@ process_incoming_migration_co(void *opaque)
 
     assert(mis->from_src_file);
 
-    if (compress_threads_load_setup(mis->from_src_file)) {
-        error_report("Failed to setup decompress threads");
-        goto fail;
-    }
-
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
@@ -800,7 +789,6 @@ fail:
     qemu_fclose(mis->from_src_file);
 
     multifd_recv_cleanup();
-    compress_threads_load_cleanup();
 
     exit(EXIT_FAILURE);
 }
@@ -1174,8 +1162,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->xbzrle_cache->overflow = xbzrle_counters.overflow;
     }
 
-    populate_compress(info);
-
     if (cpu_throttle_active()) {
         info->has_cpu_throttle_percentage = true;
         info->cpu_throttle_percentage = cpu_throttle_get_percentage();
diff --git a/migration/migration.h b/migration/migration.h
index 96b0bc323a..73bc02b598 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -389,13 +389,6 @@ struct MigrationState {
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
-    /*
-     * Whether we abort the migration if decompression errors are
-     * detected at the destination. It is left at false for qemu
-     * older than 3.0, since only newer qemu sends streams that
-     * do not trigger spurious decompression errors.
-     */
-    bool decompress_error_check;
     /*
      * This variable only affects behavior when postcopy preempt mode is
      * enabled.
diff --git a/migration/options.c b/migration/options.c
index cc2599ae4a..5ab5b6d85d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -40,13 +40,6 @@
  * for sending the last part */
 #define DEFAULT_MIGRATE_SET_DOWNTIME 300
 
-/* Default compression thread count */
-#define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
-/* Default decompression thread count, usually decompression is at
- * least 4 times as fast as compression.*/
-#define DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT 2
-/*0: means nocompress, 1: best speed, ... 9: best compress ratio */
-#define DEFAULT_MIGRATE_COMPRESS_LEVEL 1
 /* Define default autoconverge cpu throttle migration parameters */
 #define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
@@ -92,8 +85,6 @@ Property migration_properties[] = {
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,
                      send_section_footer, true),
-    DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
-                      decompress_error_check, true),
     DEFINE_PROP_BOOL("multifd-flush-after-each-section", MigrationState,
                       multifd_flush_after_each_section, false),
     DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
@@ -102,17 +93,6 @@ Property migration_properties[] = {
                      preempt_pre_7_2, false),
 
     /* Migration parameters */
-    DEFINE_PROP_UINT8("x-compress-level", MigrationState,
-                      parameters.compress_level,
-                      DEFAULT_MIGRATE_COMPRESS_LEVEL),
-    DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
-                      parameters.compress_threads,
-                      DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
-    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
-                      parameters.compress_wait_thread, true),
-    DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
-                      parameters.decompress_threads,
-                      DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
                       parameters.throttle_trigger_threshold,
                       DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
@@ -188,7 +168,6 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
     DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
     DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
-    DEFINE_PROP_MIG_CAP("x-compress", MIGRATION_CAPABILITY_COMPRESS),
     DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
@@ -231,13 +210,6 @@ bool migrate_colo(void)
     return s->capabilities[MIGRATION_CAPABILITY_X_COLO];
 }
 
-bool migrate_compress(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->capabilities[MIGRATION_CAPABILITY_COMPRESS];
-}
-
 bool migrate_dirty_bitmaps(void)
 {
     MigrationState *s = migrate_get_current();
@@ -451,7 +423,6 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_AUTO_CONVERGE,
     MIGRATION_CAPABILITY_RELEASE_RAM,
     MIGRATION_CAPABILITY_RDMA_PIN_ALL,
-    MIGRATION_CAPABILITY_COMPRESS,
     MIGRATION_CAPABILITY_XBZRLE,
     MIGRATION_CAPABILITY_X_COLO,
     MIGRATION_CAPABILITY_VALIDATE_UUID,
@@ -476,11 +447,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
-        warn_report("old compression method is deprecated;"
-                    " use multifd compression methods instead");
-    }
-
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
@@ -549,7 +515,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
 #ifdef CONFIG_LINUX
     if (new_caps[MIGRATION_CAPABILITY_ZERO_COPY_SEND] &&
         (!new_caps[MIGRATION_CAPABILITY_MULTIFD] ||
-         new_caps[MIGRATION_CAPABILITY_COMPRESS] ||
          new_caps[MIGRATION_CAPABILITY_XBZRLE] ||
          migrate_multifd_compression() ||
          migrate_tls())) {
@@ -571,17 +536,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
 
-        /*
-         * Preempt mode requires urgent pages to be sent in separate
-         * channel, OTOH compression logic will disorder all pages into
-         * different compression channels, which is not compatible with the
-         * preempt assumptions on channel assignments.
-         */
-        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
-            error_setg(errp, "Postcopy preempt not compatible with compress");
-            return false;
-        }
-
         if (migrate_incoming_started()) {
             error_setg(errp,
                        "Postcopy preempt must be set before incoming starts");
@@ -590,10 +544,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
-            error_setg(errp, "Multifd is not compatible with compress");
-            return false;
-        }
         if (migrate_incoming_started()) {
             error_setg(errp, "Multifd must be set before incoming starts");
             return false;
@@ -628,13 +578,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
-    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
-        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
-            error_setg(errp, "Compression is not compatible with xbzrle");
-            return false;
-        }
-    }
-
     if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM]) {
         if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
             error_setg(errp,
@@ -642,12 +585,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
 
-        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
-            error_setg(errp,
-                       "Mapped-ram migration is incompatible with compression");
-            return false;
-        }
-
         if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
             error_setg(errp,
                        "Mapped-ram migration is incompatible with postcopy");
@@ -744,27 +681,6 @@ uint32_t migrate_checkpoint_delay(void)
     return s->parameters.x_checkpoint_delay;
 }
 
-int migrate_compress_level(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.compress_level;
-}
-
-int migrate_compress_threads(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.compress_threads;
-}
-
-int migrate_compress_wait_thread(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.compress_wait_thread;
-}
-
 uint8_t migrate_cpu_throttle_increment(void)
 {
     MigrationState *s = migrate_get_current();
@@ -786,13 +702,6 @@ bool migrate_cpu_throttle_tailslow(void)
     return s->parameters.cpu_throttle_tailslow;
 }
 
-int migrate_decompress_threads(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.decompress_threads;
-}
-
 uint64_t migrate_downtime_limit(void)
 {
     MigrationState *s = migrate_get_current();
@@ -938,14 +847,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
-    params->has_compress_level = true;
-    params->compress_level = s->parameters.compress_level;
-    params->has_compress_threads = true;
-    params->compress_threads = s->parameters.compress_threads;
-    params->has_compress_wait_thread = true;
-    params->compress_wait_thread = s->parameters.compress_wait_thread;
-    params->has_decompress_threads = true;
-    params->decompress_threads = s->parameters.decompress_threads;
     params->has_throttle_trigger_threshold = true;
     params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
     params->has_cpu_throttle_initial = true;
@@ -1014,10 +915,6 @@ void migrate_params_init(MigrationParameters *params)
     params->tls_creds = g_strdup("");
 
     /* Set has_* up only for parameter checks */
-    params->has_compress_level = true;
-    params->has_compress_threads = true;
-    params->has_compress_wait_thread = true;
-    params->has_decompress_threads = true;
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
@@ -1050,27 +947,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
     ERRP_GUARD();
 
-    if (params->has_compress_level &&
-        (params->compress_level > 9)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
-                   "a value between 0 and 9");
-        return false;
-    }
-
-    if (params->has_compress_threads && (params->compress_threads < 1)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "compress_threads",
-                   "a value between 1 and 255");
-        return false;
-    }
-
-    if (params->has_decompress_threads && (params->decompress_threads < 1)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "decompress_threads",
-                   "a value between 1 and 255");
-        return false;
-    }
-
     if (params->has_throttle_trigger_threshold &&
         (params->throttle_trigger_threshold < 1 ||
          params->throttle_trigger_threshold > 100)) {
@@ -1244,22 +1120,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
-    if (params->has_compress_level) {
-        dest->compress_level = params->compress_level;
-    }
-
-    if (params->has_compress_threads) {
-        dest->compress_threads = params->compress_threads;
-    }
-
-    if (params->has_compress_wait_thread) {
-        dest->compress_wait_thread = params->compress_wait_thread;
-    }
-
-    if (params->has_decompress_threads) {
-        dest->decompress_threads = params->decompress_threads;
-    }
-
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
@@ -1364,30 +1224,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
-    if (params->has_compress_level) {
-        warn_report("old compression is deprecated;"
-                    " use multifd compression methods instead");
-        s->parameters.compress_level = params->compress_level;
-    }
-
-    if (params->has_compress_threads) {
-        warn_report("old compression is deprecated;"
-                    " use multifd compression methods instead");
-        s->parameters.compress_threads = params->compress_threads;
-    }
-
-    if (params->has_compress_wait_thread) {
-        warn_report("old compression is deprecated;"
-                    " use multifd compression methods instead");
-        s->parameters.compress_wait_thread = params->compress_wait_thread;
-    }
-
-    if (params->has_decompress_threads) {
-        warn_report("old compression is deprecated;"
-                    " use multifd compression methods instead");
-        s->parameters.decompress_threads = params->decompress_threads;
-    }
-
     if (params->has_throttle_trigger_threshold) {
         s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
diff --git a/migration/options.h b/migration/options.h
index 3c56d70d07..4b21cc2669 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -26,7 +26,6 @@ extern Property migration_properties[];
 
 bool migrate_auto_converge(void);
 bool migrate_colo(void);
-bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
@@ -67,13 +66,9 @@ const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
 uint32_t migrate_checkpoint_delay(void);
-int migrate_compress_level(void);
-int migrate_compress_threads(void);
-int migrate_compress_wait_thread(void);
 uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
-int migrate_decompress_threads(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index a10882d47f..9ccbbb0099 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -778,84 +778,6 @@ uint64_t qemu_get_be64(QEMUFile *f)
     return v;
 }
 
-/* return the size after compression, or negative value on error */
-static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
-                              const uint8_t *source, size_t source_len)
-{
-    int err;
-
-    err = deflateReset(stream);
-    if (err != Z_OK) {
-        return -1;
-    }
-
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
-    stream->next_out = dest;
-
-    err = deflate(stream, Z_FINISH);
-    if (err != Z_STREAM_END) {
-        return -1;
-    }
-
-    return stream->next_out - dest;
-}
-
-/* Compress size bytes of data start at p and store the compressed
- * data to the buffer of f.
- *
- * Since the file is dummy file with empty_ops, return -1 if f has no space to
- * save the compressed data.
- */
-ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
-                                  const uint8_t *p, size_t size)
-{
-    ssize_t blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
-
-    if (blen < compressBound(size)) {
-        return -1;
-    }
-
-    blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
-                              blen, p, size);
-    if (blen < 0) {
-        return -1;
-    }
-
-    qemu_put_be32(f, blen);
-    add_buf_to_iovec(f, blen);
-    return blen + sizeof(int32_t);
-}
-
-/* Put the data in the buffer of f_src to the buffer of f_des, and
- * then reset the buf_index of f_src to 0.
- */
-
-int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src)
-{
-    int len = 0;
-
-    if (f_src->buf_index > 0) {
-        len = f_src->buf_index;
-        qemu_put_buffer(f_des, f_src->buf, f_src->buf_index);
-        f_src->buf_index = 0;
-        f_src->iovcnt = 0;
-    }
-    return len;
-}
-
-/*
- * Check if the writable buffer is empty
- */
-
-bool qemu_file_buffer_empty(QEMUFile *file)
-{
-    assert(qemu_file_is_writable(file));
-
-    return !file->iovcnt;
-}
-
 /*
  * Get a string whose length is determined by a single preceding byte
  * A preallocated 256 byte buffer must be passed in.
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 32fd4a34fd..11c2120edd 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -54,10 +54,6 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
 
 size_t coroutine_mixed_fn qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset);
 size_t coroutine_mixed_fn qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size);
-ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
-                                  const uint8_t *p, size_t size);
-int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src);
-bool qemu_file_buffer_empty(QEMUFile *file);
 
 /*
  * Note that you can only peek continuous bytes from where the current pointer
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
deleted file mode 100644
index fa4388f6a6..0000000000
--- a/migration/ram-compress.c
+++ /dev/null
@@ -1,564 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2011-2015 Red Hat Inc
- *
- * Authors:
- *  Juan Quintela <quintela@redhat.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/cutils.h"
-
-#include "ram-compress.h"
-
-#include "qemu/error-report.h"
-#include "qemu/stats64.h"
-#include "migration.h"
-#include "options.h"
-#include "io/channel-null.h"
-#include "exec/target_page.h"
-#include "exec/ramblock.h"
-#include "ram.h"
-#include "migration-stats.h"
-
-static struct {
-    int64_t pages;
-    int64_t busy;
-    double busy_rate;
-    int64_t compressed_size;
-    double compression_rate;
-    /* compression statistics since the beginning of the period */
-    /* amount of count that no free thread to compress data */
-    uint64_t compress_thread_busy_prev;
-    /* amount bytes after compression */
-    uint64_t compressed_size_prev;
-    /* amount of compressed pages */
-    uint64_t compress_pages_prev;
-} compression_counters;
-
-static CompressParam *comp_param;
-static QemuThread *compress_threads;
-/* comp_done_cond is used to wake up the migration thread when
- * one of the compression threads has finished the compression.
- * comp_done_lock is used to co-work with comp_done_cond.
- */
-static QemuMutex comp_done_lock;
-static QemuCond comp_done_cond;
-
-struct DecompressParam {
-    bool done;
-    bool quit;
-    QemuMutex mutex;
-    QemuCond cond;
-    void *des;
-    uint8_t *compbuf;
-    int len;
-    z_stream stream;
-};
-typedef struct DecompressParam DecompressParam;
-
-static QEMUFile *decomp_file;
-static DecompressParam *decomp_param;
-static QemuThread *decompress_threads;
-static QemuMutex decomp_done_lock;
-static QemuCond decomp_done_cond;
-
-static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
-                                           RAMBlock *block, ram_addr_t offset,
-                                           uint8_t *source_buf);
-
-static void *do_data_compress(void *opaque)
-{
-    CompressParam *param = opaque;
-    RAMBlock *block;
-    ram_addr_t offset;
-    CompressResult result;
-
-    qemu_mutex_lock(&param->mutex);
-    while (!param->quit) {
-        if (param->trigger) {
-            block = param->block;
-            offset = param->offset;
-            param->trigger = false;
-            qemu_mutex_unlock(&param->mutex);
-
-            result = do_compress_ram_page(param->file, &param->stream,
-                                          block, offset, param->originbuf);
-
-            qemu_mutex_lock(&comp_done_lock);
-            param->done = true;
-            param->result = result;
-            qemu_cond_signal(&comp_done_cond);
-            qemu_mutex_unlock(&comp_done_lock);
-
-            qemu_mutex_lock(&param->mutex);
-        } else {
-            qemu_cond_wait(&param->cond, &param->mutex);
-        }
-    }
-    qemu_mutex_unlock(&param->mutex);
-
-    return NULL;
-}
-
-void compress_threads_save_cleanup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_compress() || !comp_param) {
-        return;
-    }
-
-    thread_count = migrate_compress_threads();
-    for (i = 0; i < thread_count; i++) {
-        /*
-         * we use it as a indicator which shows if the thread is
-         * properly init'd or not
-         */
-        if (!comp_param[i].file) {
-            break;
-        }
-
-        qemu_mutex_lock(&comp_param[i].mutex);
-        comp_param[i].quit = true;
-        qemu_cond_signal(&comp_param[i].cond);
-        qemu_mutex_unlock(&comp_param[i].mutex);
-
-        qemu_thread_join(compress_threads + i);
-        qemu_mutex_destroy(&comp_param[i].mutex);
-        qemu_cond_destroy(&comp_param[i].cond);
-        deflateEnd(&comp_param[i].stream);
-        g_free(comp_param[i].originbuf);
-        qemu_fclose(comp_param[i].file);
-        comp_param[i].file = NULL;
-    }
-    qemu_mutex_destroy(&comp_done_lock);
-    qemu_cond_destroy(&comp_done_cond);
-    g_free(compress_threads);
-    g_free(comp_param);
-    compress_threads = NULL;
-    comp_param = NULL;
-}
-
-int compress_threads_save_setup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_compress()) {
-        return 0;
-    }
-    thread_count = migrate_compress_threads();
-    compress_threads = g_new0(QemuThread, thread_count);
-    comp_param = g_new0(CompressParam, thread_count);
-    qemu_cond_init(&comp_done_cond);
-    qemu_mutex_init(&comp_done_lock);
-    for (i = 0; i < thread_count; i++) {
-        comp_param[i].originbuf = g_try_malloc(qemu_target_page_size());
-        if (!comp_param[i].originbuf) {
-            goto exit;
-        }
-
-        if (deflateInit(&comp_param[i].stream,
-                        migrate_compress_level()) != Z_OK) {
-            g_free(comp_param[i].originbuf);
-            goto exit;
-        }
-
-        /* comp_param[i].file is just used as a dummy buffer to save data,
-         * set its ops to empty.
-         */
-        comp_param[i].file = qemu_file_new_output(
-            QIO_CHANNEL(qio_channel_null_new()));
-        comp_param[i].done = true;
-        comp_param[i].quit = false;
-        qemu_mutex_init(&comp_param[i].mutex);
-        qemu_cond_init(&comp_param[i].cond);
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
-    }
-    return 0;
-
-exit:
-    compress_threads_save_cleanup();
-    return -1;
-}
-
-static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
-                                           RAMBlock *block, ram_addr_t offset,
-                                           uint8_t *source_buf)
-{
-    uint8_t *p = block->host + offset;
-    size_t page_size = qemu_target_page_size();
-    int ret;
-
-    assert(qemu_file_buffer_empty(f));
-
-    if (buffer_is_zero(p, page_size)) {
-        return RES_ZEROPAGE;
-    }
-
-    /*
-     * copy it to a internal buffer to avoid it being modified by VM
-     * so that we can catch up the error during compression and
-     * decompression
-     */
-    memcpy(source_buf, p, page_size);
-    ret = qemu_put_compression_data(f, stream, source_buf, page_size);
-    if (ret < 0) {
-        qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
-        error_report("compressed data failed!");
-        qemu_fflush(f);
-        return RES_NONE;
-    }
-    return RES_COMPRESS;
-}
-
-static inline void compress_reset_result(CompressParam *param)
-{
-    param->result = RES_NONE;
-    param->block = NULL;
-    param->offset = 0;
-}
-
-void compress_flush_data(void)
-{
-    int thread_count = migrate_compress_threads();
-
-    if (!migrate_compress()) {
-        return;
-    }
-
-    qemu_mutex_lock(&comp_done_lock);
-    for (int i = 0; i < thread_count; i++) {
-        while (!comp_param[i].done) {
-            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
-        }
-    }
-    qemu_mutex_unlock(&comp_done_lock);
-
-    for (int i = 0; i < thread_count; i++) {
-        qemu_mutex_lock(&comp_param[i].mutex);
-        if (!comp_param[i].quit) {
-            CompressParam *param = &comp_param[i];
-            compress_send_queued_data(param);
-            assert(qemu_file_buffer_empty(param->file));
-            compress_reset_result(param);
-        }
-        qemu_mutex_unlock(&comp_param[i].mutex);
-    }
-}
-
-static inline void set_compress_params(CompressParam *param, RAMBlock *block,
-                                       ram_addr_t offset)
-{
-    param->block = block;
-    param->offset = offset;
-    param->trigger = true;
-}
-
-/*
- * Return true when it compress a page
- */
-bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
-                                     int (send_queued_data(CompressParam *)))
-{
-    int thread_count;
-    bool wait = migrate_compress_wait_thread();
-
-    thread_count = migrate_compress_threads();
-    qemu_mutex_lock(&comp_done_lock);
-
-    while (true) {
-        for (int i = 0; i < thread_count; i++) {
-            if (comp_param[i].done) {
-                CompressParam *param = &comp_param[i];
-                qemu_mutex_lock(&param->mutex);
-                param->done = false;
-                send_queued_data(param);
-                assert(qemu_file_buffer_empty(param->file));
-                compress_reset_result(param);
-                set_compress_params(param, block, offset);
-
-                qemu_cond_signal(&param->cond);
-                qemu_mutex_unlock(&param->mutex);
-                qemu_mutex_unlock(&comp_done_lock);
-                return true;
-            }
-        }
-        if (!wait) {
-            qemu_mutex_unlock(&comp_done_lock);
-            compression_counters.busy++;
-            return false;
-        }
-        /*
-         * wait for a free thread if the user specifies
-         * 'compress-wait-thread', otherwise we will post the page out
-         * in the main thread as normal page.
-         */
-        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
-    }
-}
-
-/* return the size after decompression, or negative value on error */
-static int
-qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
-                     const uint8_t *source, size_t source_len)
-{
-    int err;
-
-    err = inflateReset(stream);
-    if (err != Z_OK) {
-        return -1;
-    }
-
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
-    stream->next_out = dest;
-
-    err = inflate(stream, Z_NO_FLUSH);
-    if (err != Z_STREAM_END) {
-        return -1;
-    }
-
-    return stream->total_out;
-}
-
-static void *do_data_decompress(void *opaque)
-{
-    DecompressParam *param = opaque;
-    unsigned long pagesize;
-    uint8_t *des;
-    int len, ret;
-
-    qemu_mutex_lock(&param->mutex);
-    while (!param->quit) {
-        if (param->des) {
-            des = param->des;
-            len = param->len;
-            param->des = 0;
-            qemu_mutex_unlock(&param->mutex);
-
-            pagesize = qemu_target_page_size();
-
-            ret = qemu_uncompress_data(&param->stream, des, pagesize,
-                                       param->compbuf, len);
-            if (ret < 0 && migrate_get_current()->decompress_error_check) {
-                error_report("decompress data failed");
-                qemu_file_set_error(decomp_file, ret);
-            }
-
-            qemu_mutex_lock(&decomp_done_lock);
-            param->done = true;
-            qemu_cond_signal(&decomp_done_cond);
-            qemu_mutex_unlock(&decomp_done_lock);
-
-            qemu_mutex_lock(&param->mutex);
-        } else {
-            qemu_cond_wait(&param->cond, &param->mutex);
-        }
-    }
-    qemu_mutex_unlock(&param->mutex);
-
-    return NULL;
-}
-
-int wait_for_decompress_done(void)
-{
-    if (!migrate_compress()) {
-        return 0;
-    }
-
-    int thread_count = migrate_decompress_threads();
-    qemu_mutex_lock(&decomp_done_lock);
-    for (int i = 0; i < thread_count; i++) {
-        while (!decomp_param[i].done) {
-            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
-        }
-    }
-    qemu_mutex_unlock(&decomp_done_lock);
-    return qemu_file_get_error(decomp_file);
-}
-
-void compress_threads_load_cleanup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_compress()) {
-        return;
-    }
-    thread_count = migrate_decompress_threads();
-    for (i = 0; i < thread_count; i++) {
-        /*
-         * we use it as a indicator which shows if the thread is
-         * properly init'd or not
-         */
-        if (!decomp_param[i].compbuf) {
-            break;
-        }
-
-        qemu_mutex_lock(&decomp_param[i].mutex);
-        decomp_param[i].quit = true;
-        qemu_cond_signal(&decomp_param[i].cond);
-        qemu_mutex_unlock(&decomp_param[i].mutex);
-    }
-    for (i = 0; i < thread_count; i++) {
-        if (!decomp_param[i].compbuf) {
-            break;
-        }
-
-        qemu_thread_join(decompress_threads + i);
-        qemu_mutex_destroy(&decomp_param[i].mutex);
-        qemu_cond_destroy(&decomp_param[i].cond);
-        inflateEnd(&decomp_param[i].stream);
-        g_free(decomp_param[i].compbuf);
-        decomp_param[i].compbuf = NULL;
-    }
-    g_free(decompress_threads);
-    g_free(decomp_param);
-    decompress_threads = NULL;
-    decomp_param = NULL;
-    decomp_file = NULL;
-}
-
-int compress_threads_load_setup(QEMUFile *f)
-{
-    int i, thread_count;
-
-    if (!migrate_compress()) {
-        return 0;
-    }
-
-    /*
-     * set compression_counters memory to zero for a new migration
-     */
-    memset(&compression_counters, 0, sizeof(compression_counters));
-
-    thread_count = migrate_decompress_threads();
-    decompress_threads = g_new0(QemuThread, thread_count);
-    decomp_param = g_new0(DecompressParam, thread_count);
-    qemu_mutex_init(&decomp_done_lock);
-    qemu_cond_init(&decomp_done_cond);
-    decomp_file = f;
-    for (i = 0; i < thread_count; i++) {
-        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
-            goto exit;
-        }
-
-        size_t compbuf_size = compressBound(qemu_target_page_size());
-        decomp_param[i].compbuf = g_malloc0(compbuf_size);
-        qemu_mutex_init(&decomp_param[i].mutex);
-        qemu_cond_init(&decomp_param[i].cond);
-        decomp_param[i].done = true;
-        decomp_param[i].quit = false;
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
-    }
-    return 0;
-exit:
-    compress_threads_load_cleanup();
-    return -1;
-}
-
-void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
-{
-    int thread_count = migrate_decompress_threads();
-    QEMU_LOCK_GUARD(&decomp_done_lock);
-    while (true) {
-        for (int i = 0; i < thread_count; i++) {
-            if (decomp_param[i].done) {
-                decomp_param[i].done = false;
-                qemu_mutex_lock(&decomp_param[i].mutex);
-                qemu_get_buffer(f, decomp_param[i].compbuf, len);
-                decomp_param[i].des = host;
-                decomp_param[i].len = len;
-                qemu_cond_signal(&decomp_param[i].cond);
-                qemu_mutex_unlock(&decomp_param[i].mutex);
-                return;
-            }
-        }
-        qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
-    }
-}
-
-void populate_compress(MigrationInfo *info)
-{
-    if (!migrate_compress()) {
-        return;
-    }
-    info->compression = g_malloc0(sizeof(*info->compression));
-    info->compression->pages = compression_counters.pages;
-    info->compression->busy = compression_counters.busy;
-    info->compression->busy_rate = compression_counters.busy_rate;
-    info->compression->compressed_size = compression_counters.compressed_size;
-    info->compression->compression_rate = compression_counters.compression_rate;
-}
-
-uint64_t compress_ram_pages(void)
-{
-    return compression_counters.pages;
-}
-
-void update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
-{
-    ram_transferred_add(bytes_xmit);
-
-    if (param->result == RES_ZEROPAGE) {
-        stat64_add(&mig_stats.zero_pages, 1);
-        return;
-    }
-
-    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
-    compression_counters.compressed_size += bytes_xmit - 8;
-    compression_counters.pages++;
-}
-
-void compress_update_rates(uint64_t page_count)
-{
-    if (!migrate_compress()) {
-        return;
-    }
-    compression_counters.busy_rate = (double)(compression_counters.busy -
-            compression_counters.compress_thread_busy_prev) / page_count;
-    compression_counters.compress_thread_busy_prev =
-            compression_counters.busy;
-
-    double compressed_size = compression_counters.compressed_size -
-        compression_counters.compressed_size_prev;
-    if (compressed_size) {
-        double uncompressed_size = (compression_counters.pages -
-                                    compression_counters.compress_pages_prev) *
-            qemu_target_page_size();
-
-        /* Compression-Ratio = Uncompressed-size / Compressed-size */
-        compression_counters.compression_rate =
-            uncompressed_size / compressed_size;
-
-        compression_counters.compress_pages_prev =
-            compression_counters.pages;
-        compression_counters.compressed_size_prev =
-            compression_counters.compressed_size;
-    }
-}
diff --git a/migration/ram-compress.h b/migration/ram-compress.h
deleted file mode 100644
index 0d89a2f55e..0000000000
--- a/migration/ram-compress.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2011-2015 Red Hat Inc
- *
- * Authors:
- *  Juan Quintela <quintela@redhat.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_MIGRATION_COMPRESS_H
-#define QEMU_MIGRATION_COMPRESS_H
-
-#include "qemu-file.h"
-#include "qapi/qapi-types-migration.h"
-
-enum CompressResult {
-    RES_NONE = 0,
-    RES_ZEROPAGE = 1,
-    RES_COMPRESS = 2
-};
-typedef enum CompressResult CompressResult;
-
-struct CompressParam {
-    bool done;
-    bool quit;
-    bool trigger;
-    CompressResult result;
-    QEMUFile *file;
-    QemuMutex mutex;
-    QemuCond cond;
-    RAMBlock *block;
-    ram_addr_t offset;
-
-    /* internally used fields */
-    z_stream stream;
-    uint8_t *originbuf;
-};
-typedef struct CompressParam CompressParam;
-
-void compress_threads_save_cleanup(void);
-int compress_threads_save_setup(void);
-
-bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
-                                      int (send_queued_data(CompressParam *)));
-
-int wait_for_decompress_done(void);
-void compress_threads_load_cleanup(void);
-int compress_threads_load_setup(QEMUFile *f);
-void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
-
-void populate_compress(MigrationInfo *info);
-uint64_t compress_ram_pages(void);
-void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
-void compress_update_rates(uint64_t page_count);
-int compress_send_queued_data(CompressParam *param);
-void compress_flush_data(void);
-
-#endif
diff --git a/migration/ram.c b/migration/ram.c
index 5debb2e455..a2b81002cd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,7 +33,6 @@
 #include "qemu/madvise.h"
 #include "qemu/main-loop.h"
 #include "xbzrle.h"
-#include "ram-compress.h"
 #include "ram.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -77,9 +76,10 @@
  * worked for pages that were filled with the same char.  We switched
  * it to only search for the zero value.  And to avoid confusion with
  * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
- */
-/*
- * RAM_SAVE_FLAG_FULL was obsoleted in 2009, it can be reused now
+ *
+ * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
+ *
+ * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
  */
 #define RAM_SAVE_FLAG_FULL     0x01
 #define RAM_SAVE_FLAG_ZERO     0x02
@@ -89,7 +89,6 @@
 #define RAM_SAVE_FLAG_CONTINUE 0x20
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in rdma.h for RAM_SAVE_FLAG_HOOK */
-#define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 #define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
 /* We can't use any flag that is bigger than 0x200 */
 
@@ -690,8 +689,7 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
     qemu_put_buffer(file, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle += encoded_len + 1 + 2;
     /*
-     * Like compressed_size (please see update_compress_thread_counts),
-     * the xbzrle encoded bytes don't count the 8 byte header with
+     * The xbzrle encoded bytes don't count the 8 byte header with
      * RAM_SAVE_FLAG_CONTINUE.
      */
     xbzrle_counters.bytes += bytes_xbzrle - 8;
@@ -949,7 +947,7 @@ uint64_t ram_get_total_transferred_pages(void)
 {
     return stat64_get(&mig_stats.normal_pages) +
         stat64_get(&mig_stats.zero_pages) +
-        compress_ram_pages() + xbzrle_counters.pages;
+        xbzrle_counters.pages;
 }
 
 static void migration_update_rates(RAMState *rs, int64_t end_time)
@@ -982,7 +980,6 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
         rs->xbzrle_pages_prev = xbzrle_counters.pages;
         rs->xbzrle_bytes_prev = xbzrle_counters.bytes;
     }
-    compress_update_rates(page_count);
 }
 
 /*
@@ -1288,41 +1285,6 @@ static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
     return 1;
 }
 
-int compress_send_queued_data(CompressParam *param)
-{
-    PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_PRECOPY];
-    MigrationState *ms = migrate_get_current();
-    QEMUFile *file = ms->to_dst_file;
-    int len = 0;
-
-    RAMBlock *block = param->block;
-    ram_addr_t offset = param->offset;
-
-    if (param->result == RES_NONE) {
-        return 0;
-    }
-
-    assert(block == pss->last_sent_block);
-
-    if (param->result == RES_ZEROPAGE) {
-        assert(qemu_file_buffer_empty(param->file));
-        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
-        qemu_put_byte(file, 0);
-        len += 1;
-        ram_release_page(block->idstr, offset);
-    } else if (param->result == RES_COMPRESS) {
-        assert(!qemu_file_buffer_empty(param->file));
-        len += save_page_header(pss, file, block,
-                                offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
-        len += qemu_put_qemu_file(file, param->file);
-    } else {
-        abort();
-    }
-
-    update_compress_thread_counts(param, len);
-
-    return len;
-}
 
 #define PAGE_ALL_CLEAN 0
 #define PAGE_TRY_AGAIN 1
@@ -1374,16 +1336,6 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                     qemu_fflush(f);
                 }
             }
-            /*
-             * If memory migration starts over, we will meet a dirtied page
-             * which may still exists in compression threads's ring, so we
-             * should flush the compressed data to make sure the new page
-             * is not overwritten by the old one in the destination.
-             *
-             * Also If xbzrle is on, stop using the data compression at this
-             * point. In theory, xbzrle can do better than compression.
-             */
-            compress_flush_data();
 
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -2034,37 +1986,6 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
     return 0;
 }
 
-/*
- * try to compress the page before posting it out, return true if the page
- * has been properly handled by compression, otherwise needs other
- * paths to handle it
- */
-static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
-                               ram_addr_t offset)
-{
-    if (!migrate_compress()) {
-        return false;
-    }
-
-    /*
-     * When starting the process of a new block, the first page of
-     * the block should be sent out before other pages in the same
-     * block, and all the pages in last block should have been sent
-     * out, keeping this order is important, because the 'cont' flag
-     * is used to avoid resending the block name.
-     *
-     * We post the fist page as normal page as compression will take
-     * much CPU resource.
-     */
-    if (pss->block != pss->last_sent_block) {
-        compress_flush_data();
-        return false;
-    }
-
-    return compress_page_with_multi_thread(pss->block, offset,
-                                           compress_send_queued_data);
-}
-
 /**
  * ram_save_target_page_legacy: save one target page
  *
@@ -2082,10 +2003,6 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return res;
     }
 
-    if (save_compress_page(rs, pss, offset)) {
-        return 1;
-    }
-
     if (save_zero_page(rs, pss, offset)) {
         return 1;
     }
@@ -2470,7 +2387,6 @@ static void ram_save_cleanup(void *opaque)
     ram_bitmaps_destroy();
 
     xbzrle_cleanup();
-    compress_threads_save_cleanup();
     ram_state_cleanup(rsp);
     g_free(migration_ops);
     migration_ops = NULL;
@@ -3089,15 +3005,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
 
-    if (compress_threads_save_setup()) {
-        error_setg(errp, "%s: failed to start compress threads", __func__);
-        return -1;
-    }
-
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp, errp) != 0) {
-            compress_threads_save_cleanup();
             return -1;
         }
     }
@@ -3268,14 +3178,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
                 rs->target_page_count += pages;
 
-                /*
-                 * During postcopy, it is necessary to make sure one whole host
-                 * page is sent in one chunk.
-                 */
-                if (migrate_postcopy_ram()) {
-                    compress_flush_data();
-                }
-
                 /*
                  * we want to check in the 1st loop, just in case it was the 1st
                  * time and we had to sync the dirty bitmap.
@@ -3374,8 +3276,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
-        compress_flush_data();
-
         ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
@@ -3789,7 +3689,6 @@ int ram_load_postcopy(QEMUFile *f, int channel)
         void *place_source = NULL;
         RAMBlock *block = NULL;
         uint8_t ch;
-        int len;
 
         addr = qemu_get_be64(f);
 
@@ -3806,8 +3705,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
         addr &= TARGET_PAGE_MASK;
 
         trace_ram_load_postcopy_loop(channel, (uint64_t)addr, flags);
-        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE)) {
+        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
             block = ram_block_from_stream(mis, f, flags, channel);
             if (!block) {
                 ret = -EINVAL;
@@ -3902,16 +3800,6 @@ int ram_load_postcopy(QEMUFile *f, int channel)
                                          TARGET_PAGE_SIZE);
             }
             break;
-        case RAM_SAVE_FLAG_COMPRESS_PAGE:
-            tmp_page->all_zero = false;
-            len = qemu_get_be32(f);
-            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
-                error_report("Invalid compressed data length: %d", len);
-                ret = -EINVAL;
-                break;
-            }
-            decompress_data_with_multi_threads(f, page_buffer, len);
-            break;
         case RAM_SAVE_FLAG_MULTIFD_FLUSH:
             multifd_recv_sync_main();
             break;
@@ -3929,11 +3817,6 @@ int ram_load_postcopy(QEMUFile *f, int channel)
             break;
         }
 
-        /* Got the whole host page, wait for decompress before placing. */
-        if (place_needed) {
-            ret |= wait_for_decompress_done();
-        }
-
         /* Detect for any possible file errors */
         if (!ret && qemu_file_get_error(f)) {
             ret = qemu_file_get_error(f);
@@ -4238,11 +4121,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
 static int ram_load_precopy(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
-
-    if (!migrate_compress()) {
-        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
-    }
+    int flags = 0, ret = 0, invalid_flags = 0, i = 0;
 
     if (migrate_mapped_ram()) {
         invalid_flags |= (RAM_SAVE_FLAG_HOOK | RAM_SAVE_FLAG_MULTIFD_FLUSH |
@@ -4279,16 +4158,12 @@ static int ram_load_precopy(QEMUFile *f)
         if (flags & invalid_flags) {
             error_report("Unexpected RAM flags: %d", flags & invalid_flags);
 
-            if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
-                error_report("Received an unexpected compressed page");
-            }
-
             ret = -EINVAL;
             break;
         }
 
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
+                     RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(mis, f, flags,
                                                     RAM_CHANNEL_PRECOPY);
 
@@ -4357,16 +4232,6 @@ static int ram_load_precopy(QEMUFile *f)
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
-        case RAM_SAVE_FLAG_COMPRESS_PAGE:
-            len = qemu_get_be32(f);
-            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
-                error_report("Invalid compressed data length: %d", len);
-                ret = -EINVAL;
-                break;
-            }
-            decompress_data_with_multi_threads(f, host, len);
-            break;
-
         case RAM_SAVE_FLAG_XBZRLE:
             if (load_xbzrle(f, addr, host) < 0) {
                 error_report("Failed to decompress XBZRLE page at "
@@ -4408,7 +4273,6 @@ static int ram_load_precopy(QEMUFile *f)
         }
     }
 
-    ret |= wait_for_decompress_done();
     return ret;
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 10e13d0b17..fc4b13050a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -229,10 +229,6 @@
 #     This is only present when the postcopy-blocktime migration
 #     capability is enabled.  (Since 3.0)
 #
-# @compression: migration compression statistics, only returned if
-#     compression feature is on and status is 'active' or 'completed'
-#     (Since 3.1)
-#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -257,13 +253,6 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
-# Features:
-#
-# @deprecated: Member @compression is deprecated because it is
-#     unreliable and untested.  It is recommended to use multifd
-#     migration, which offers an alternative compression
-#     implementation that is reliable and tested.
-#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
@@ -279,7 +268,6 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
-           '*compression': { 'type': 'CompressionStats', 'features': [ 'deprecated' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
@@ -401,14 +389,6 @@
 #     capability on the source VM. The feature is disabled by default.
 #     (since 1.6)
 #
-# @compress: Use multiple compression threads to accelerate live
-#     migration.  This feature can help to reduce the migration
-#     traffic, by sending compressed pages.  Please note that if
-#     compress and xbzrle are both on, compress only takes effect in
-#     the ram bulk stage, after that, it will be disabled and only
-#     xbzrle takes effect, this can help to minimize migration
-#     traffic.  The feature is disabled by default.  (since 2.4)
-#
 # @events: generate events for each migration state change (since 2.4)
 #
 # @auto-converge: If enabled, QEMU will automatically throttle down
@@ -491,18 +471,12 @@
 #
 # Features:
 #
-# @deprecated: Member @compress is deprecated because it is unreliable
-#     and untested.  It is recommended to use multifd migration, which
-#     offers an alternative compression implementation that is
-#     reliable and tested.
-#
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           { 'name': 'compress', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
@@ -562,7 +536,6 @@
 #           {"state": false, "capability": "rdma-pin-all"},
 #           {"state": false, "capability": "auto-converge"},
 #           {"state": false, "capability": "zero-blocks"},
-#           {"state": false, "capability": "compress"},
 #           {"state": true, "capability": "events"},
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
@@ -710,27 +683,6 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU.
-#
-# @compress-threads: Set compression thread count to be used in live
-#     migration, the compression thread count is an integer between 1
-#     and 255.
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: Set decompression thread count to be used in
-#     live migration, the decompression thread count is an integer
-#     between 1 and 255. Usually, decompression is at least 4 times as
-#     fast as compression, so set the decompress-threads to the number
-#     about 1/4 of compress-threads is adequate.
-#
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
 #     percentage.  The default value is 50.  (Since 5.0)
@@ -862,10 +814,6 @@
 #
 # Features:
 #
-# @deprecated: Members @compress-level, @compress-threads,
-#     @decompress-threads and @compress-wait-thread are deprecated
-#     because @compression is deprecated.
-#
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
@@ -874,10 +822,6 @@
 { 'enum': 'MigrationParameter',
   'data': ['announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
-           { 'name': 'compress-level', 'features': [ 'deprecated' ] },
-           { 'name': 'compress-threads', 'features': [ 'deprecated' ] },
-           { 'name': 'decompress-threads', 'features': [ 'deprecated' ] },
-           { 'name': 'compress-wait-thread', 'features': [ 'deprecated' ] },
            'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
@@ -909,27 +853,6 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU.
-#
-# @compress-threads: Set compression thread count to be used in live
-#     migration, the compression thread count is an integer between 1
-#     and 255.
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: Set decompression thread count to be used in
-#     live migration, the decompression thread count is an integer
-#     between 1 and 255. Usually, decompression is at least 4 times as
-#     fast as compression, so set the decompress-threads to the number
-#     about 1/4 of compress-threads is adequate.
-#
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
 #     percentage.  The default value is 50.  (Since 5.0)
@@ -1061,10 +984,6 @@
 #
 # Features:
 #
-# @deprecated: Members @compress-level, @compress-threads,
-#     @decompress-threads and @compress-wait-thread are deprecated
-#     because @compression is deprecated.
-#
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
@@ -1078,14 +997,6 @@
             '*announce-max': 'size',
             '*announce-rounds': 'size',
             '*announce-step': 'size',
-            '*compress-level': { 'type': 'uint8',
-                                 'features': [ 'deprecated' ] },
-            '*compress-threads':  { 'type': 'uint8',
-                                    'features': [ 'deprecated' ] },
-            '*compress-wait-thread':  { 'type': 'bool',
-                                        'features': [ 'deprecated' ] },
-            '*decompress-threads':  { 'type': 'uint8',
-                                      'features': [ 'deprecated' ] },
             '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
@@ -1145,17 +1056,6 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: compression level
-#
-# @compress-threads: compression thread count
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: decompression thread count
-#
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
 #     percentage.  The default value is 50.  (Since 5.0)
@@ -1283,10 +1183,6 @@
 #
 # Features:
 #
-# @deprecated: Members @compress-level, @compress-threads,
-#     @decompress-threads and @compress-wait-thread are deprecated
-#     because @compression is deprecated.
-#
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
@@ -1297,14 +1193,6 @@
             '*announce-max': 'size',
             '*announce-rounds': 'size',
             '*announce-step': 'size',
-            '*compress-level': { 'type': 'uint8',
-                                 'features': [ 'deprecated' ] },
-            '*compress-threads': { 'type': 'uint8',
-                                   'features': [ 'deprecated' ] },
-            '*compress-wait-thread': { 'type': 'bool',
-                                       'features': [ 'deprecated' ] },
-            '*decompress-threads': { 'type': 'uint8',
-                                     'features': [ 'deprecated' ] },
             '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5d6d8cd634..7a1345f80f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -427,38 +427,6 @@ static void migrate_set_parameter_str(QTestState *who, const char *parameter,
     migrate_check_parameter_str(who, parameter, value);
 }
 
-static long long migrate_get_parameter_bool(QTestState *who,
-                                           const char *parameter)
-{
-    QDict *rsp;
-    int result;
-
-    rsp = qtest_qmp_assert_success_ref(
-        who, "{ 'execute': 'query-migrate-parameters' }");
-    result = qdict_get_bool(rsp, parameter);
-    qobject_unref(rsp);
-    return !!result;
-}
-
-static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
-                                        int value)
-{
-    int result;
-
-    result = migrate_get_parameter_bool(who, parameter);
-    g_assert_cmpint(result, ==, value);
-}
-
-static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
-                                      int value)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-set-parameters',"
-                             "'arguments': { %s: %i } }",
-                             parameter, value);
-    migrate_check_parameter_bool(who, parameter, value);
-}
-
 static void migrate_ensure_non_converge(QTestState *who)
 {
     /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
@@ -1240,36 +1208,6 @@ test_migrate_tls_x509_finish(QTestState *from,
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-static void *
-test_migrate_compress_start(QTestState *from,
-                            QTestState *to)
-{
-    migrate_set_parameter_int(from, "compress-level", 1);
-    migrate_set_parameter_int(from, "compress-threads", 4);
-    migrate_set_parameter_bool(from, "compress-wait-thread", true);
-    migrate_set_parameter_int(to, "decompress-threads", 4);
-
-    migrate_set_capability(from, "compress", true);
-    migrate_set_capability(to, "compress", true);
-
-    return NULL;
-}
-
-static void *
-test_migrate_compress_nowait_start(QTestState *from,
-                                   QTestState *to)
-{
-    migrate_set_parameter_int(from, "compress-level", 9);
-    migrate_set_parameter_int(from, "compress-threads", 1);
-    migrate_set_parameter_bool(from, "compress-wait-thread", false);
-    migrate_set_parameter_int(to, "decompress-threads", 1);
-
-    migrate_set_capability(from, "compress", true);
-    migrate_set_capability(to, "compress", true);
-
-    return NULL;
-}
-
 static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     QTestState **to_ptr,
                                     MigrateCommon *args)
@@ -1370,15 +1308,6 @@ static void test_postcopy_suspend(void)
     test_postcopy_common(&args);
 }
 
-static void test_postcopy_compress(void)
-{
-    MigrateCommon args = {
-        .start_hook = test_migrate_compress_start
-    };
-
-    test_postcopy_common(&args);
-}
-
 static void test_postcopy_preempt(void)
 {
     MigrateCommon args = {
@@ -1561,15 +1490,6 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-static void test_postcopy_recovery_compress(void)
-{
-    MigrateCommon args = {
-        .start_hook = test_migrate_compress_start
-    };
-
-    test_postcopy_recovery_common(&args);
-}
-
 #ifndef _WIN32
 static void test_postcopy_recovery_double_fail(void)
 {
@@ -2027,48 +1947,6 @@ static void test_precopy_unix_xbzrle(void)
     test_precopy_common(&args);
 }
 
-static void test_precopy_unix_compress(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = test_migrate_compress_start,
-        /*
-         * Test that no invalid thread state is left over from
-         * the previous iteration.
-         */
-        .iterations = 2,
-        /*
-         * We make sure the compressor can always work well even if guest
-         * memory is changing.  See commit 34ab9e9743 where we used to fix
-         * a bug when only trigger-able with guest memory changing.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_unix_compress_nowait(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = test_migrate_compress_nowait_start,
-        /*
-         * Test that no invalid thread state is left over from
-         * the previous iteration.
-         */
-        .iterations = 2,
-        /* Same reason for the wait version of precopy compress test */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
 static void test_precopy_file(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -3597,12 +3475,6 @@ int main(int argc, char **argv)
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
-        if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-            migration_test_add("/migration/postcopy/compress/plain",
-                               test_postcopy_compress);
-            migration_test_add("/migration/postcopy/recovery/compress/plain",
-                               test_postcopy_recovery_compress);
-        }
 #ifndef _WIN32
         migration_test_add("/migration/postcopy/recovery/double-failures",
                            test_postcopy_recovery_double_fail);
@@ -3623,17 +3495,6 @@ int main(int argc, char **argv)
                        test_precopy_unix_plain);
     migration_test_add("/migration/precopy/unix/xbzrle",
                        test_precopy_unix_xbzrle);
-    /*
-     * Compression fails from time to time.
-     * Put test here but don't enable it until everything is fixed.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/precopy/unix/compress/wait",
-                           test_precopy_unix_compress);
-        migration_test_add("/migration/precopy/unix/compress/nowait",
-                           test_precopy_unix_compress_nowait);
-    }
-
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
-- 
2.35.3


