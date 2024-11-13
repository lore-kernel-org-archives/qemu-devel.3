Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE56D637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKW-0006UT-TL; Wed, 13 Nov 2024 14:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKV-0006TK-5W
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:07 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKQ-0003AP-L4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8363221109;
 Wed, 13 Nov 2024 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GabKqIOBZe7qh9a/+4DFL9XvcRR4xeG71p4QCqHaSXw=;
 b=FSMDsOwKRVr09gIdi6wAZGrUpiC766OpBetUSIHc0EIioR31F5dF4tS0BN++Kgxkb9xSGG
 f7urhP2B8oJdeaGStc6Rp6cv+thm1O2G7EAfMEMcY6kniluxJYkNTIKfpfOimarcvbHPv2
 Qu3HzOcrcC8MvRJbqbvJiklaoFK+xIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GabKqIOBZe7qh9a/+4DFL9XvcRR4xeG71p4QCqHaSXw=;
 b=gYn1OdKVDMdigwmzZSbIdMTLzNS3LH3iEkpExXUsRlojB85z9coOC+FW17zzyMV0WZ2kOf
 FzzwJvH4qgURglDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GabKqIOBZe7qh9a/+4DFL9XvcRR4xeG71p4QCqHaSXw=;
 b=FSMDsOwKRVr09gIdi6wAZGrUpiC766OpBetUSIHc0EIioR31F5dF4tS0BN++Kgxkb9xSGG
 f7urhP2B8oJdeaGStc6Rp6cv+thm1O2G7EAfMEMcY6kniluxJYkNTIKfpfOimarcvbHPv2
 Qu3HzOcrcC8MvRJbqbvJiklaoFK+xIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GabKqIOBZe7qh9a/+4DFL9XvcRR4xeG71p4QCqHaSXw=;
 b=gYn1OdKVDMdigwmzZSbIdMTLzNS3LH3iEkpExXUsRlojB85z9coOC+FW17zzyMV0WZ2kOf
 FzzwJvH4qgURglDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2548113301;
 Wed, 13 Nov 2024 19:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AJCYNjICNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:46:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 11/22] tests/qtest/migration: Move common test code
Date: Wed, 13 Nov 2024 16:46:19 -0300
Message-Id: <20241113194630.3385-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The migration tests have a set of core infrastructure routines. These
are functions that are called by (almost) all tests and centralize the
common operations of: starting migration on both sides, waiting for
guests to boot, performing guest initialization and teardown, guest
memory validation, etc.

Move this basic framework code (and a few static helpers) into a
separate file. Leave only individual test functions (and their own
static helpers) in migration-test.c.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                |    1 +
 tests/qtest/migration-test.c           | 1140 +-----------------------
 tests/qtest/migration/bootfile.c       |    2 +-
 tests/qtest/migration/bootfile.h       |    2 +-
 tests/qtest/migration/test-framework.c |  969 ++++++++++++++++++++
 tests/qtest/migration/test-framework.h |  216 +++++
 6 files changed, 1201 insertions(+), 1129 deletions(-)
 create mode 100644 tests/qtest/migration/test-framework.c
 create mode 100644 tests/qtest/migration/test-framework.h

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b9f70ac32f..bdb9512510 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -332,6 +332,7 @@ tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
 migration_files = [files(
   'migration/bootfile.c',
+  'migration/test-framework.c',
   'migration/migration-qmp.c',
   'migration/migration-util.c',
 )]
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5e426a8885..8d3b61cf30 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -23,6 +23,7 @@
 #include "ppc-util.h"
 
 #include "migration/bootfile.h"
+#include "migration/test-framework.h"
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
 #ifdef CONFIG_GNUTLS
@@ -32,25 +33,6 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-unsigned start_address;
-unsigned end_address;
-static QTestMigrationState src_state;
-static QTestMigrationState dst_state;
-
-/*
- * An initial 3 MB offset is used as that corresponds
- * to ~1 sec of data transfer with our bandwidth setting.
- */
-#define MAGIC_OFFSET_BASE (3 * 1024 * 1024)
-/*
- * A further 1k is added to ensure we're not a multiple
- * of TEST_MEM_PAGE_SIZE, thus avoid clash with writes
- * from the migration guest workload.
- */
-#define MAGIC_OFFSET_SHUFFLE 1024
-#define MAGIC_OFFSET (MAGIC_OFFSET_BASE + MAGIC_OFFSET_SHUFFLE)
-#define MAGIC_MARKER 0xFEED12345678CAFEULL
-
 /*
  * Dirtylimit stop working if dirty page rate error
  * value less than DIRTYLIMIT_TOLERANCE_RANGE
@@ -59,543 +41,13 @@ static QTestMigrationState dst_state;
 
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
 
-#define QEMU_VM_FILE_MAGIC 0x5145564d
-#define FILE_TEST_FILENAME "migfile"
-#define FILE_TEST_OFFSET 0x1000
-#define FILE_TEST_MARKER 'X'
-#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
-#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
-
-typedef enum PostcopyRecoveryFailStage {
-    /*
-     * "no failure" must be 0 as it's the default.  OTOH, real failure
-     * cases must be >0 to make sure they trigger by a "if" test.
-     */
-    POSTCOPY_FAIL_NONE = 0,
-    POSTCOPY_FAIL_CHANNEL_ESTABLISH,
-    POSTCOPY_FAIL_RECOVERY,
-    POSTCOPY_FAIL_MAX
-} PostcopyRecoveryFailStage;
-
 #if defined(__linux__)
+#include <sys/ioctl.h>
 #include <sys/syscall.h>
 #include <sys/vfs.h>
 #endif
 
 static char *tmpfs;
-static char *bootpath;
-
-typedef struct MigrationTestEnv {
-    bool has_kvm;
-    bool has_tcg;
-    bool has_uffd;
-    bool uffd_feature_thread_id;
-    bool has_dirty_ring;
-    bool is_x86;
-    const char *arch;
-    const char *qemu_src;
-    const char *qemu_dst;
-    char *tmpfs;
-} MigrationTestEnv;
-
-
-MigrationTestEnv *migration_get_env(void);
-
-/*
- * Wait for some output in the serial output file,
- * we get an 'A' followed by an endless string of 'B's
- * but on the destination we won't have the A (unless we enabled suspend/resume)
- */
-static void wait_for_serial(const char *side)
-{
-    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
-    FILE *serialfile = fopen(serialpath, "r");
-
-    do {
-        int readvalue = fgetc(serialfile);
-
-        switch (readvalue) {
-        case 'A':
-            /* Fine */
-            break;
-
-        case 'B':
-            /* It's alive! */
-            fclose(serialfile);
-            return;
-
-        case EOF:
-            fseek(serialfile, 0, SEEK_SET);
-            usleep(1000);
-            break;
-
-        default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
-            g_assert_not_reached();
-        }
-    } while (true);
-}
-
-static void check_guests_ram(QTestState *who)
-{
-    /* Our ASM test will have been incrementing one byte from each page from
-     * start_address to < end_address in order. This gives us a constraint
-     * that any page's byte should be equal or less than the previous pages
-     * byte (mod 256); and they should all be equal except for one transition
-     * at the point where we meet the incrementer. (We're running this with
-     * the guest stopped).
-     */
-    unsigned address;
-    uint8_t first_byte;
-    uint8_t last_byte;
-    bool hit_edge = false;
-    int bad = 0;
-
-    qtest_memread(who, start_address, &first_byte, 1);
-    last_byte = first_byte;
-
-    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
-         address += TEST_MEM_PAGE_SIZE)
-    {
-        uint8_t b;
-        qtest_memread(who, address, &b, 1);
-        if (b != last_byte) {
-            if (((b + 1) % 256) == last_byte && !hit_edge) {
-                /* This is OK, the guest stopped at the point of
-                 * incrementing the previous page but didn't get
-                 * to us yet.
-                 */
-                hit_edge = true;
-                last_byte = b;
-            } else {
-                bad++;
-                if (bad <= 10) {
-                    fprintf(stderr, "Memory content inconsistency at %x"
-                            " first_byte = %x last_byte = %x current = %x"
-                            " hit_edge = %x\n",
-                            address, first_byte, last_byte, b, hit_edge);
-                }
-            }
-        }
-    }
-    if (bad >= 10) {
-        fprintf(stderr, "and in another %d pages", bad - 10);
-    }
-    g_assert(bad == 0);
-}
-
-static void cleanup(const char *filename)
-{
-    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, filename);
-
-    unlink(path);
-}
-
-/*
- * Our goal is to ensure that we run a single full migration
- * iteration, and also dirty memory, ensuring that at least
- * one further iteration is required.
- *
- * We can't directly synchronize with the start of a migration
- * so we have to apply some tricks monitoring memory that is
- * transferred.
- *
- * Initially we set the migration bandwidth to an insanely
- * low value, with tiny max downtime too. This basically
- * guarantees migration will never complete.
- *
- * This will result in a test that is unacceptably slow though,
- * so we can't let the entire migration pass run at this speed.
- * Our intent is to let it run just long enough that we can
- * prove data prior to the marker has been transferred *AND*
- * also prove this transferred data is dirty again.
- *
- * Before migration starts, we write a 64-bit magic marker
- * into a fixed location in the src VM RAM.
- *
- * Then watch dst memory until the marker appears. This is
- * proof that start_address -> MAGIC_OFFSET_BASE has been
- * transferred.
- *
- * Finally we go back to the source and read a byte just
- * before the marker until we see it flip in value. This
- * is proof that start_address -> MAGIC_OFFSET_BASE
- * is now dirty again.
- *
- * IOW, we're guaranteed at least a 2nd migration pass
- * at this point.
- *
- * We can now let migration run at full speed to finish
- * the test
- */
-static void migrate_prepare_for_dirty_mem(QTestState *from)
-{
-    /*
-     * The guest workflow iterates from start_address to
-     * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
-     * bytes.
-     *
-     * IOW, if we write to mem at a point which is NOT
-     * a multiple of TEST_MEM_PAGE_SIZE, our write won't
-     * conflict with the migration workflow.
-     *
-     * We put in a marker here, that we'll use to determine
-     * when the data has been transferred to the dst.
-     */
-    qtest_writeq(from, start_address + MAGIC_OFFSET, MAGIC_MARKER);
-}
-
-static void migrate_wait_for_dirty_mem(QTestState *from,
-                                       QTestState *to)
-{
-    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
-    uint64_t marker_address = start_address + MAGIC_OFFSET;
-    uint8_t watch_byte;
-
-    /*
-     * Wait for the MAGIC_MARKER to get transferred, as an
-     * indicator that a migration pass has made some known
-     * amount of progress.
-     */
-    do {
-        usleep(1000 * 10);
-    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
-
-
-    /* If suspended, src only iterates once, and watch_byte may never change */
-    if (src_state.suspend_me) {
-        return;
-    }
-
-    /*
-     * Now ensure that already transferred bytes are
-     * dirty again from the guest workload. Note the
-     * guest byte value will wrap around and by chance
-     * match the original watch_byte. This is harmless
-     * as we'll eventually see a different value if we
-     * keep watching
-     */
-    watch_byte = qtest_readb(from, watch_address);
-    do {
-        usleep(1000 * 10);
-    } while (qtest_readb(from, watch_address) == watch_byte);
-}
-
-typedef struct {
-    /*
-     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
-     * unconditionally, because it means the user would like to be verbose.
-     */
-    bool hide_stderr;
-    bool use_shmem;
-    /* only launch the target process */
-    bool only_target;
-    /* Use dirty ring if true; dirty logging otherwise */
-    bool use_dirty_ring;
-    const char *opts_source;
-    const char *opts_target;
-    /* suspend the src before migrating to dest. */
-    bool suspend_me;
-} MigrateStart;
-
-/*
- * A hook that runs after the src and dst QEMUs have been
- * created, but before the migration is started. This can
- * be used to set migration parameters and capabilities.
- *
- * Returns: NULL, or a pointer to opaque state to be
- *          later passed to the TestMigrateFinishHook
- */
-typedef void * (*TestMigrateStartHook)(QTestState *from,
-                                       QTestState *to);
-
-/*
- * A hook that runs after the migration has finished,
- * regardless of whether it succeeded or failed, but
- * before QEMU has terminated (unless it self-terminated
- * due to migration error)
- *
- * @opaque is a pointer to state previously returned
- * by the TestMigrateStartHook if any, or NULL.
- */
-typedef void (*TestMigrateEndHook)(QTestState *from,
-                                   QTestState *to,
-                                   void *opaque);
-
-typedef struct {
-    /* Optional: fine tune start parameters */
-    MigrateStart start;
-
-    /* Required: the URI for the dst QEMU to listen on */
-    const char *listen_uri;
-
-    /*
-     * Optional: the URI for the src QEMU to connect to
-     * If NULL, then it will query the dst QEMU for its actual
-     * listening address and use that as the connect address.
-     * This allows for dynamically picking a free TCP port.
-     */
-    const char *connect_uri;
-
-    /*
-     * Optional: JSON-formatted list of src QEMU URIs. If a port is
-     * defined as '0' in any QDict key a value of '0' will be
-     * automatically converted to the correct destination port.
-     */
-    const char *connect_channels;
-
-    /* Optional: callback to run at start to set migration parameters */
-    TestMigrateStartHook start_hook;
-    /* Optional: callback to run at finish to cleanup */
-    TestMigrateEndHook end_hook;
-
-    /*
-     * Optional: normally we expect the migration process to complete.
-     *
-     * There can be a variety of reasons and stages in which failure
-     * can happen during tests.
-     *
-     * If a failure is expected to happen at time of establishing
-     * the connection, then MIG_TEST_FAIL will indicate that the dst
-     * QEMU is expected to stay running and accept future migration
-     * connections.
-     *
-     * If a failure is expected to happen while processing the
-     * migration stream, then MIG_TEST_FAIL_DEST_QUIT_ERR will indicate
-     * that the dst QEMU is expected to quit with non-zero exit status
-     */
-    enum {
-        /* This test should succeed, the default */
-        MIG_TEST_SUCCEED = 0,
-        /* This test should fail, dest qemu should keep alive */
-        MIG_TEST_FAIL,
-        /* This test should fail, dest qemu should fail with abnormal status */
-        MIG_TEST_FAIL_DEST_QUIT_ERR,
-        /* The QMP command for this migration should fail with an error */
-        MIG_TEST_QMP_ERROR,
-    } result;
-
-    /*
-     * Optional: set number of migration passes to wait for, if live==true.
-     * If zero, then merely wait for a few MB of dirty data
-     */
-    unsigned int iterations;
-
-    /*
-     * Optional: whether the guest CPUs should be running during a precopy
-     * migration test.  We used to always run with live but it took much
-     * longer so we reduced live tests to only the ones that have solid
-     * reason to be tested live-only.  For each of the new test cases for
-     * precopy please provide justifications to use live explicitly (please
-     * refer to existing ones with live=true), or use live=off by default.
-     */
-    bool live;
-
-    /* Postcopy specific fields */
-    void *postcopy_data;
-    bool postcopy_preempt;
-    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
-} MigrateCommon;
-
-static int migrate_start(QTestState **from, QTestState **to,
-                         const char *uri, MigrateStart *args)
-{
-    g_autofree gchar *arch_source = NULL;
-    g_autofree gchar *arch_target = NULL;
-    /* options for source and target */
-    g_autofree gchar *arch_opts = NULL;
-    g_autofree gchar *cmd_source = NULL;
-    g_autofree gchar *cmd_target = NULL;
-    const gchar *ignore_stderr;
-    g_autofree char *shmem_opts = NULL;
-    g_autofree char *shmem_path = NULL;
-    const char *kvm_opts = NULL;
-    const char *arch = qtest_get_arch();
-    const char *memory_size;
-    const char *machine_alias, *machine_opts = "";
-    g_autofree char *machine = NULL;
-
-    if (args->use_shmem) {
-        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-            g_test_skip("/dev/shm is not supported");
-            return -1;
-        }
-    }
-
-    dst_state = (QTestMigrationState) { };
-    src_state = (QTestMigrationState) { };
-    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
-    src_state.suspend_me = args->suspend_me;
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        memory_size = "150M";
-
-        if (g_str_equal(arch, "i386")) {
-            machine_alias = "pc";
-        } else {
-            machine_alias = "q35";
-        }
-        arch_opts = g_strdup_printf(
-            "-drive if=none,id=d0,file=%s,format=raw "
-            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
-        start_address = X86_TEST_MEM_START;
-        end_address = X86_TEST_MEM_END;
-    } else if (g_str_equal(arch, "s390x")) {
-        memory_size = "128M";
-        machine_alias = "s390-ccw-virtio";
-        arch_opts = g_strdup_printf("-bios %s", bootpath);
-        start_address = S390_TEST_MEM_START;
-        end_address = S390_TEST_MEM_END;
-    } else if (strcmp(arch, "ppc64") == 0) {
-        memory_size = "256M";
-        start_address = PPC_TEST_MEM_START;
-        end_address = PPC_TEST_MEM_END;
-        machine_alias = "pseries";
-        machine_opts = "vsmt=8";
-        arch_opts = g_strdup_printf(
-            "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
-            "-bios %s", bootpath);
-    } else if (strcmp(arch, "aarch64") == 0) {
-        memory_size = "150M";
-        machine_alias = "virt";
-        machine_opts = "gic-version=3";
-        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
-        start_address = ARM_TEST_MEM_START;
-        end_address = ARM_TEST_MEM_END;
-    } else {
-        g_assert_not_reached();
-    }
-
-    if (!getenv("QTEST_LOG") && args->hide_stderr) {
-#ifndef _WIN32
-        ignore_stderr = "2>/dev/null";
-#else
-        /*
-         * On Windows the QEMU executable is created via CreateProcess() and
-         * IO redirection does not work, so don't bother adding IO redirection
-         * to the command line.
-         */
-        ignore_stderr = "";
-#endif
-    } else {
-        ignore_stderr = "";
-    }
-
-    if (args->use_shmem) {
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
-        shmem_opts = g_strdup_printf(
-            "-object memory-backend-file,id=mem0,size=%s"
-            ",mem-path=%s,share=on -numa node,memdev=mem0",
-            memory_size, shmem_path);
-    }
-
-    if (args->use_dirty_ring) {
-        kvm_opts = ",dirty-ring-size=4096";
-    }
-
-    if (!qtest_has_machine(machine_alias)) {
-        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
-        g_test_skip(msg);
-        return -1;
-    }
-
-    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
-                                      QEMU_ENV_DST);
-
-    g_test_message("Using machine type: %s", machine);
-
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
-                                 "-name source,debug-threads=on "
-                                 "-m %s "
-                                 "-serial file:%s/src_serial "
-                                 "%s %s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
-                                 memory_size, tmpfs,
-                                 arch_opts ? arch_opts : "",
-                                 arch_source ? arch_source : "",
-                                 shmem_opts ? shmem_opts : "",
-                                 args->opts_source ? args->opts_source : "",
-                                 ignore_stderr);
-    if (!args->only_target) {
-        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
-        qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_events,
-                                     &src_state);
-    }
-
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
-                                 "-name target,debug-threads=on "
-                                 "-m %s "
-                                 "-serial file:%s/dest_serial "
-                                 "-incoming %s "
-                                 "%s %s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
-                                 memory_size, tmpfs, uri,
-                                 arch_opts ? arch_opts : "",
-                                 arch_target ? arch_target : "",
-                                 shmem_opts ? shmem_opts : "",
-                                 args->opts_target ? args->opts_target : "",
-                                 ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
-    qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_events,
-                                 &dst_state);
-
-    /*
-     * Remove shmem file immediately to avoid memory leak in test failed case.
-     * It's valid because QEMU has already opened this file
-     */
-    if (args->use_shmem) {
-        unlink(shmem_path);
-    }
-
-    /*
-     * Always enable migration events.  Libvirt always uses it, let's try
-     * to mimic as closer as that.
-     */
-    migrate_set_capability(*from, "events", true);
-    migrate_set_capability(*to, "events", true);
-
-    return 0;
-}
-
-static void migrate_end(QTestState *from, QTestState *to, bool test_dest)
-{
-    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
-
-    qtest_quit(from);
-
-    if (test_dest) {
-        qtest_memread(to, start_address, &dest_byte_a, 1);
-
-        /* Destination still running, wait for a byte to change */
-        do {
-            qtest_memread(to, start_address, &dest_byte_b, 1);
-            usleep(1000 * 10);
-        } while (dest_byte_a == dest_byte_b);
-
-        qtest_qmp_assert_success(to, "{ 'execute' : 'stop'}");
-
-        /* With it stopped, check nothing changes */
-        qtest_memread(to, start_address, &dest_byte_c, 1);
-        usleep(1000 * 200);
-        qtest_memread(to, start_address, &dest_byte_d, 1);
-        g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
-
-        check_guests_ram(to);
-    }
-
-    qtest_quit(to);
-
-    cleanup("migsocket");
-    cleanup("src_serial");
-    cleanup("dest_serial");
-    cleanup(FILE_TEST_FILENAME);
-}
 
 #ifdef CONFIG_GNUTLS
 struct TestMigrateTLSPSKData {
@@ -936,92 +388,6 @@ migrate_hook_end_tls_x509(QTestState *from,
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-static int migrate_postcopy_prepare(QTestState **from_ptr,
-                                    QTestState **to_ptr,
-                                    MigrateCommon *args)
-{
-    QTestState *from, *to;
-
-    if (migrate_start(&from, &to, "defer", &args->start)) {
-        return -1;
-    }
-
-    if (args->start_hook) {
-        args->postcopy_data = args->start_hook(from, to);
-    }
-
-    migrate_set_capability(from, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-blocktime", true);
-
-    if (args->postcopy_preempt) {
-        migrate_set_capability(from, "postcopy-preempt", true);
-        migrate_set_capability(to, "postcopy-preempt", true);
-    }
-
-    migrate_ensure_non_converge(from);
-
-    migrate_prepare_for_dirty_mem(from);
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { "
-                             "      'channels': [ { 'channel-type': 'main',"
-                             "      'addr': { 'transport': 'socket',"
-                             "                'type': 'inet',"
-                             "                'host': '127.0.0.1',"
-                             "                'port': '0' } } ] } }");
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-    wait_for_suspend(from, &src_state);
-
-    migrate_qmp(from, to, NULL, NULL, "{}");
-
-    migrate_wait_for_dirty_mem(from, to);
-
-    *from_ptr = from;
-    *to_ptr = to;
-
-    return 0;
-}
-
-static void migrate_postcopy_complete(QTestState *from, QTestState *to,
-                                      MigrateCommon *args)
-{
-    MigrationTestEnv *env = migration_get_env();
-
-    wait_for_migration_complete(from);
-
-    if (args->start.suspend_me) {
-        /* wakeup succeeds only if guest is suspended */
-        qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
-    }
-
-    /* Make sure we get at least one "B" on destination */
-    wait_for_serial("dest_serial");
-
-    if (env->uffd_feature_thread_id) {
-        read_blocktime(to);
-    }
-
-    if (args->end_hook) {
-        args->end_hook(from, to, args->postcopy_data);
-        args->postcopy_data = NULL;
-    }
-
-    migrate_end(from, to, true);
-}
-
-static void test_postcopy_common(MigrateCommon *args)
-{
-    QTestState *from, *to;
-
-    if (migrate_postcopy_prepare(&from, &to, args)) {
-        return;
-    }
-    migrate_postcopy_start(from, to, &src_state);
-    migrate_postcopy_complete(from, to, args);
-}
-
 static void test_postcopy(void)
 {
     MigrateCommon args = { };
@@ -1070,192 +436,6 @@ static void test_postcopy_preempt_tls_psk(void)
 }
 #endif
 
-static void wait_for_postcopy_status(QTestState *one, const char *status)
-{
-    wait_for_migration_status(one, status,
-                              (const char * []) {
-                                  "failed", "active",
-                                  "completed", NULL
-                              });
-}
-
-static void postcopy_recover_fail(QTestState *from, QTestState *to,
-                                  PostcopyRecoveryFailStage stage)
-{
-#ifndef _WIN32
-    bool fail_early = (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH);
-    int ret, pair1[2], pair2[2];
-    char c;
-
-    g_assert(stage > POSTCOPY_FAIL_NONE && stage < POSTCOPY_FAIL_MAX);
-
-    /* Create two unrelated socketpairs */
-    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
-    g_assert_cmpint(ret, ==, 0);
-
-    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
-    g_assert_cmpint(ret, ==, 0);
-
-    /*
-     * Give the guests unpaired ends of the sockets, so they'll all blocked
-     * at reading.  This mimics a wrong channel established.
-     */
-    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    /*
-     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
-     * emulate the 1st byte of a real recovery, but stops from there to
-     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
-     * the recover process on dest QEMU (by triggering the G_IO_IN event).
-     *
-     * NOTE: this trick is not needed on src QEMUs, because src doesn't
-     * rely on an pre-existing G_IO_IN event, so it will always trigger the
-     * upcoming recovery anyway even if it can read nothing.
-     */
-#define QEMU_VM_COMMAND              0x08
-    c = QEMU_VM_COMMAND;
-    ret = send(pair2[1], &c, 1, 0);
-    g_assert_cmpint(ret, ==, 1);
-
-    if (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
-        /*
-         * This will make src QEMU to fail at an early stage when trying to
-         * resume later, where it shouldn't reach RECOVER stage at all.
-         */
-        close(pair1[1]);
-    }
-
-    migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
-
-    /*
-     * Source QEMU has an extra RECOVER_SETUP phase, dest doesn't have it.
-     * Make sure it appears along the way.
-     */
-    migration_event_wait(from, "postcopy-recover-setup");
-
-    if (fail_early) {
-        /*
-         * When fails at reconnection, src QEMU will automatically goes
-         * back to PAUSED state.  Making sure there is an event in this
-         * case: Libvirt relies on this to detect early reconnection
-         * errors.
-         */
-        migration_event_wait(from, "postcopy-paused");
-    } else {
-        /*
-         * We want to test "fail later" at RECOVER stage here.  Make sure
-         * both QEMU instances will go into RECOVER stage first, then test
-         * kicking them out using migrate-pause.
-         *
-         * Explicitly check the RECOVER event on src, that's what Libvirt
-         * relies on, rather than polling.
-         */
-        migration_event_wait(from, "postcopy-recover");
-        wait_for_postcopy_status(from, "postcopy-recover");
-
-        /* Need an explicit kick on src QEMU in this case */
-        migrate_pause(from);
-    }
-
-    /*
-     * For all failure cases, we'll reach such states on both sides now.
-     * Check them.
-     */
-    wait_for_postcopy_status(from, "postcopy-paused");
-    wait_for_postcopy_status(to, "postcopy-recover");
-
-    /*
-     * Kick dest QEMU out too. This is normally not needed in reality
-     * because when the channel is shutdown it should also happen on src.
-     * However here we used separate socket pairs so we need to do that
-     * explicitly.
-     */
-    migrate_pause(to);
-    wait_for_postcopy_status(to, "postcopy-paused");
-
-    close(pair1[0]);
-    close(pair2[0]);
-    close(pair2[1]);
-
-    if (stage != POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
-        close(pair1[1]);
-    }
-#endif
-}
-
-static void test_postcopy_recovery_common(MigrateCommon *args)
-{
-    QTestState *from, *to;
-    g_autofree char *uri = NULL;
-
-    /* Always hide errors for postcopy recover tests since they're expected */
-    args->start.hide_stderr = true;
-
-    if (migrate_postcopy_prepare(&from, &to, args)) {
-        return;
-    }
-
-    /* Turn postcopy speed down, 4K/s is slow enough on any machines */
-    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
-
-    /* Now we start the postcopy */
-    migrate_postcopy_start(from, to, &src_state);
-
-    /*
-     * Wait until postcopy is really started; we can only run the
-     * migrate-pause command during a postcopy
-     */
-    wait_for_migration_status(from, "postcopy-active", NULL);
-
-    /*
-     * Manually stop the postcopy migration. This emulates a network
-     * failure with the migration socket
-     */
-    migrate_pause(from);
-
-    /*
-     * Wait for destination side to reach postcopy-paused state.  The
-     * migrate-recover command can only succeed if destination machine
-     * is in the paused state
-     */
-    wait_for_postcopy_status(to, "postcopy-paused");
-    wait_for_postcopy_status(from, "postcopy-paused");
-
-    if (args->postcopy_recovery_fail_stage) {
-        /*
-         * Test when a wrong socket specified for recover, and then the
-         * ability to kick it out, and continue with a correct socket.
-         */
-        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
-        /* continue with a good recovery */
-    }
-
-    /*
-     * Create a new socket to emulate a new channel that is different
-     * from the broken migration channel; tell the destination to
-     * listen to the new port
-     */
-    uri = g_strdup_printf("unix:%s/migsocket-recover", tmpfs);
-    migrate_recover(to, uri);
-
-    /*
-     * Try to rebuild the migration channel using the resume flag and
-     * the newly created channel
-     */
-    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
-
-    /* Restore the postcopy bandwidth to unlimited */
-    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
-
-    migrate_postcopy_complete(from, to, args);
-}
-
 static void test_postcopy_recovery(void)
 {
     MigrateCommon args = { };
@@ -1383,218 +563,10 @@ static void test_analyze_script(void)
         g_test_fail();
     }
     migrate_end(from, to, false);
-    cleanup("migfile");
+    unlink(file);
 }
 #endif
 
-static void test_precopy_common(MigrateCommon *args)
-{
-    QTestState *from, *to;
-    void *data_hook = NULL;
-
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
-        return;
-    }
-
-    if (args->start_hook) {
-        data_hook = args->start_hook(from, to);
-    }
-
-    /* Wait for the first serial output from the source */
-    if (args->result == MIG_TEST_SUCCEED) {
-        wait_for_serial("src_serial");
-        wait_for_suspend(from, &src_state);
-    }
-
-    if (args->live) {
-        migrate_ensure_non_converge(from);
-        migrate_prepare_for_dirty_mem(from);
-    } else {
-        /*
-         * Testing non-live migration, we allow it to run at
-         * full speed to ensure short test case duration.
-         * For tests expected to fail, we don't need to
-         * change anything.
-         */
-        if (args->result == MIG_TEST_SUCCEED) {
-            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-            wait_for_stop(from, &src_state);
-            migrate_ensure_converge(from);
-        }
-    }
-
-    if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
-        goto finish;
-    }
-
-    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
-
-    if (args->result != MIG_TEST_SUCCEED) {
-        bool allow_active = args->result == MIG_TEST_FAIL;
-        wait_for_migration_fail(from, allow_active);
-
-        if (args->result == MIG_TEST_FAIL_DEST_QUIT_ERR) {
-            qtest_set_expected_status(to, EXIT_FAILURE);
-        }
-    } else {
-        if (args->live) {
-            /*
-             * For initial iteration(s) we must do a full pass,
-             * but for the final iteration, we need only wait
-             * for some dirty mem before switching to converge
-             */
-            while (args->iterations > 1) {
-                wait_for_migration_pass(from, &src_state);
-                args->iterations--;
-            }
-            migrate_wait_for_dirty_mem(from, to);
-
-            migrate_ensure_converge(from);
-
-            /*
-             * We do this first, as it has a timeout to stop us
-             * hanging forever if migration didn't converge
-             */
-            wait_for_migration_complete(from);
-
-            wait_for_stop(from, &src_state);
-
-        } else {
-            wait_for_migration_complete(from);
-            /*
-             * Must wait for dst to finish reading all incoming
-             * data on the socket before issuing 'cont' otherwise
-             * it'll be ignored
-             */
-            wait_for_migration_complete(to);
-
-            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
-        }
-
-        wait_for_resume(to, &dst_state);
-
-        if (args->start.suspend_me) {
-            /* wakeup succeeds only if guest is suspended */
-            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
-        }
-
-        wait_for_serial("dest_serial");
-    }
-
-finish:
-    if (args->end_hook) {
-        args->end_hook(from, to, data_hook);
-    }
-
-    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
-}
-
-static void file_dirty_offset_region(void)
-{
-    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-    size_t size = FILE_TEST_OFFSET;
-    g_autofree char *data = g_new0(char, size);
-
-    memset(data, FILE_TEST_MARKER, size);
-    g_assert(g_file_set_contents(path, data, size, NULL));
-}
-
-static void file_check_offset_region(void)
-{
-    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-    size_t size = FILE_TEST_OFFSET;
-    g_autofree char *expected = g_new0(char, size);
-    g_autofree char *actual = NULL;
-    uint64_t *stream_start;
-
-    /*
-     * Ensure the skipped offset region's data has not been touched
-     * and the migration stream starts at the right place.
-     */
-
-    memset(expected, FILE_TEST_MARKER, size);
-
-    g_assert(g_file_get_contents(path, &actual, NULL, NULL));
-    g_assert(!memcmp(actual, expected, size));
-
-    stream_start = (uint64_t *)(actual + size);
-    g_assert_cmpint(cpu_to_be64(*stream_start) >> 32, ==, QEMU_VM_FILE_MAGIC);
-}
-
-static void test_file_common(MigrateCommon *args, bool stop_src)
-{
-    QTestState *from, *to;
-    void *data_hook = NULL;
-    bool check_offset = false;
-
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
-        return;
-    }
-
-    /*
-     * File migration is never live. We can keep the source VM running
-     * during migration, but the destination will not be running
-     * concurrently.
-     */
-    g_assert_false(args->live);
-
-    if (g_strrstr(args->connect_uri, "offset=")) {
-        check_offset = true;
-        /*
-         * This comes before the start_hook because it's equivalent to
-         * a management application creating the file and writing to
-         * it so hooks should expect the file to be already present.
-         */
-        file_dirty_offset_region();
-    }
-
-    if (args->start_hook) {
-        data_hook = args->start_hook(from, to);
-    }
-
-    migrate_ensure_converge(from);
-    wait_for_serial("src_serial");
-
-    if (stop_src) {
-        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-        wait_for_stop(from, &src_state);
-    }
-
-    if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
-        goto finish;
-    }
-
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
-    wait_for_migration_complete(from);
-
-    /*
-     * We need to wait for the source to finish before starting the
-     * destination.
-     */
-    migrate_incoming_qmp(to, args->connect_uri, "{}");
-    wait_for_migration_complete(to);
-
-    if (stop_src) {
-        qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
-    }
-    wait_for_resume(to, &dst_state);
-
-    wait_for_serial("dest_serial");
-
-    if (check_offset) {
-        file_check_offset_region();
-    }
-
-finish:
-    if (args->end_hook) {
-        args->end_hook(from, to, data_hook);
-    }
-
-    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
-}
-
 static void test_precopy_unix_plain(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -1730,7 +702,7 @@ static void test_ignore_shared(void)
 
     migrate_wait_for_dirty_mem(from, to);
 
-    wait_for_stop(from, &src_state);
+    wait_for_stop(from, get_src());
 
     qtest_qmp_eventwait(to, "RESUME");
 
@@ -2519,7 +1491,7 @@ static void test_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(src_state.stop_seen);
+        g_assert_false(get_src()->stop_seen);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2575,26 +1547,6 @@ static void test_auto_converge(void)
     migrate_end(from, to, true);
 }
 
-static void *
-migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                              QTestState *to,
-                                              const char *method)
-{
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
-
-    migrate_set_parameter_str(from, "multifd-compression", method);
-    migrate_set_parameter_str(to, "multifd-compression", method);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
-
-    return NULL;
-}
-
 static void *
 migrate_hook_start_precopy_tcp_multifd(QTestState *from,
                                        QTestState *to)
@@ -3026,7 +1978,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_converge(from);
 
-    wait_for_stop(from, &src_state);
+    wait_for_stop(from, get_src());
     qtest_qmp_eventwait(to2, "RESUME");
 
     wait_for_serial("dest_serial");
@@ -3171,6 +2123,7 @@ static QTestState *dirtylimit_start_vm(void)
 {
     QTestState *vm = NULL;
     g_autofree gchar *cmd = NULL;
+    const char *bootpath;
 
     bootpath = bootfile_create(qtest_get_arch(), tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
@@ -3186,8 +2139,10 @@ static QTestState *dirtylimit_start_vm(void)
 
 static void dirtylimit_stop_vm(QTestState *vm)
 {
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, "vm_serial");
+
     qtest_quit(vm);
-    cleanup("vm_serial");
+    unlink(path);
 }
 
 static void test_vcpu_dirty_limit(void)
@@ -3365,7 +2320,7 @@ static void test_dirty_limit(void)
             read_migrate_property_int(from,
                                       "dirty-limit-throttle-time-per-round");
         usleep(100);
-        g_assert_false(src_state.stop_seen);
+        g_assert_false(get_src()->stop_seen);
     }
 
     /* Now cancel migrate and wait for dirty limit throttle switch off */
@@ -3378,7 +2333,7 @@ static void test_dirty_limit(void)
             read_migrate_property_int(from,
                                       "dirty-limit-throttle-time-per-round");
         usleep(100);
-        g_assert_false(src_state.stop_seen);
+        g_assert_false(get_src()->stop_seen);
     } while (throttle_us_per_full != 0 && --max_try_count);
 
     /* Assert dirty limit is not in service */
@@ -3408,7 +2363,7 @@ static void test_dirty_limit(void)
             read_migrate_property_int(from,
                                       "dirty-limit-throttle-time-per-round");
         usleep(100);
-        g_assert_false(src_state.stop_seen);
+        g_assert_false(get_src()->stop_seen);
     }
 
     /*
@@ -3441,75 +2396,6 @@ static void test_dirty_limit(void)
     migrate_end(from, to, true);
 }
 
-MigrationTestEnv *migration_get_env(void)
-{
-    static MigrationTestEnv *env;
-    g_autoptr(GError) err = NULL;
-
-    if (env) {
-        return env;
-    }
-
-    env = g_new0(MigrationTestEnv, 1);
-    env->qemu_src = getenv(QEMU_ENV_SRC);
-    env->qemu_dst = getenv(QEMU_ENV_DST);
-
-    /*
-     * The default QTEST_QEMU_BINARY must always be provided because
-     * that is what helpers use to query the accel type and
-     * architecture.
-     */
-    if (env->qemu_src && env->qemu_dst) {
-        g_test_message("Only one of %s, %s is allowed",
-                       QEMU_ENV_SRC, QEMU_ENV_DST);
-        exit(1);
-    }
-
-    env->has_kvm = qtest_has_accel("kvm");
-    env->has_tcg = qtest_has_accel("tcg");
-
-    if (!env->has_tcg && !env->has_kvm) {
-        g_test_skip("No KVM or TCG accelerator available");
-        return env;
-    }
-
-    env->has_dirty_ring = kvm_dirty_ring_supported();
-    env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
-    env->arch = qtest_get_arch();
-    env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
-
-    env->tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
-    if (!env->tmpfs) {
-        g_test_message("Can't create temporary directory in %s: %s",
-                       g_get_tmp_dir(), err->message);
-    }
-    g_assert(env->tmpfs);
-
-    return env;
-}
-
-static int migration_env_clean(MigrationTestEnv *env)
-{
-    char *tmpfs;
-    int ret = 0;
-
-    if (!env) {
-        return ret;
-    }
-
-    bootfile_delete();
-
-    tmpfs = env->tmpfs;
-    ret = rmdir(tmpfs);
-    if (ret != 0) {
-        g_test_message("unable to rmdir: path (%s): %s",
-                       tmpfs, strerror(errno));
-    }
-    g_free(tmpfs);
-
-    return ret;
-}
-
 int main(int argc, char **argv)
 {
     MigrationTestEnv *env;
diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index 8f75f64093..fac059d11d 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -34,7 +34,7 @@ void bootfile_delete(void)
     bootpath = NULL;
 }
 
-char *bootfile_create(const char *arch, char *dir, bool suspend_me)
+char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
 {
     unsigned char *content;
     size_t len;
diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 4f5099d765..6d6a67386e 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -34,6 +34,6 @@
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
 void bootfile_delete(void);
-char *bootfile_create(const char *arch, char *dir, bool suspend_me);
+char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
 
 #endif /* BOOTFILE_H */
diff --git a/tests/qtest/migration/test-framework.c b/tests/qtest/migration/test-framework.c
new file mode 100644
index 0000000000..3b9ca6c133
--- /dev/null
+++ b/tests/qtest/migration/test-framework.c
@@ -0,0 +1,969 @@
+/*
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "chardev/char.h"
+#include "crypto/tlscredspsk.h"
+#include "libqtest.h"
+#include "migration/bootfile.h"
+#include "migration/test-framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+#include "ppc-util.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/range.h"
+#include "qemu/sockets.h"
+
+
+#define QEMU_VM_FILE_MAGIC 0x5145564d
+
+unsigned start_address;
+unsigned end_address;
+static QTestMigrationState src_state;
+static QTestMigrationState dst_state;
+static char *tmpfs;
+
+/*
+ * An initial 3 MB offset is used as that corresponds
+ * to ~1 sec of data transfer with our bandwidth setting.
+ */
+#define MAGIC_OFFSET_BASE (3 * 1024 * 1024)
+/*
+ * A further 1k is added to ensure we're not a multiple
+ * of TEST_MEM_PAGE_SIZE, thus avoid clash with writes
+ * from the migration guest workload.
+ */
+#define MAGIC_OFFSET_SHUFFLE 1024
+#define MAGIC_OFFSET (MAGIC_OFFSET_BASE + MAGIC_OFFSET_SHUFFLE)
+#define MAGIC_MARKER 0xFEED12345678CAFEULL
+
+
+/*
+ * Wait for some output in the serial output file,
+ * we get an 'A' followed by an endless string of 'B's
+ * but on the destination we won't have the A (unless we enabled suspend/resume)
+ */
+void wait_for_serial(const char *side)
+{
+    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
+    FILE *serialfile = fopen(serialpath, "r");
+
+    do {
+        int readvalue = fgetc(serialfile);
+
+        switch (readvalue) {
+        case 'A':
+            /* Fine */
+            break;
+
+        case 'B':
+            /* It's alive! */
+            fclose(serialfile);
+            return;
+
+        case EOF:
+            fseek(serialfile, 0, SEEK_SET);
+            usleep(1000);
+            break;
+
+        default:
+            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            g_assert_not_reached();
+        }
+    } while (true);
+}
+
+void migrate_prepare_for_dirty_mem(QTestState *from)
+{
+    /*
+     * The guest workflow iterates from start_address to
+     * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
+     * bytes.
+     *
+     * IOW, if we write to mem at a point which is NOT
+     * a multiple of TEST_MEM_PAGE_SIZE, our write won't
+     * conflict with the migration workflow.
+     *
+     * We put in a marker here, that we'll use to determine
+     * when the data has been transferred to the dst.
+     */
+    qtest_writeq(from, start_address + MAGIC_OFFSET, MAGIC_MARKER);
+}
+
+void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to)
+{
+    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
+    uint64_t marker_address = start_address + MAGIC_OFFSET;
+    uint8_t watch_byte;
+
+    /*
+     * Wait for the MAGIC_MARKER to get transferred, as an
+     * indicator that a migration pass has made some known
+     * amount of progress.
+     */
+    do {
+        usleep(1000 * 10);
+    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
+
+
+    /* If suspended, src only iterates once, and watch_byte may never change */
+    if (src_state.suspend_me) {
+        return;
+    }
+
+    /*
+     * Now ensure that already transferred bytes are
+     * dirty again from the guest workload. Note the
+     * guest byte value will wrap around and by chance
+     * match the original watch_byte. This is harmless
+     * as we'll eventually see a different value if we
+     * keep watching
+     */
+    watch_byte = qtest_readb(from, watch_address);
+    do {
+        usleep(1000 * 10);
+    } while (qtest_readb(from, watch_address) == watch_byte);
+}
+
+static void check_guests_ram(QTestState *who)
+{
+    /*
+     * Our ASM test will have been incrementing one byte from each page from
+     * start_address to < end_address in order. This gives us a constraint
+     * that any page's byte should be equal or less than the previous pages
+     * byte (mod 256); and they should all be equal except for one transition
+     * at the point where we meet the incrementer. (We're running this with
+     * the guest stopped).
+     */
+    unsigned address;
+    uint8_t first_byte;
+    uint8_t last_byte;
+    bool hit_edge = false;
+    int bad = 0;
+
+    qtest_memread(who, start_address, &first_byte, 1);
+    last_byte = first_byte;
+
+    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
+         address += TEST_MEM_PAGE_SIZE)
+    {
+        uint8_t b;
+        qtest_memread(who, address, &b, 1);
+        if (b != last_byte) {
+            if (((b + 1) % 256) == last_byte && !hit_edge) {
+                /*
+                 * This is OK, the guest stopped at the point of
+                 * incrementing the previous page but didn't get
+                 * to us yet.
+                 */
+                hit_edge = true;
+                last_byte = b;
+            } else {
+                bad++;
+                if (bad <= 10) {
+                    fprintf(stderr, "Memory content inconsistency at %x"
+                            " first_byte = %x last_byte = %x current = %x"
+                            " hit_edge = %x\n",
+                            address, first_byte, last_byte, b, hit_edge);
+                }
+            }
+        }
+    }
+    if (bad >= 10) {
+        fprintf(stderr, "and in another %d pages", bad - 10);
+    }
+    g_assert(bad == 0);
+}
+
+static void cleanup(const char *filename)
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, filename);
+
+    unlink(path);
+}
+
+int migrate_start(QTestState **from, QTestState **to, const char *uri,
+                  MigrateStart *args)
+{
+    g_autofree gchar *arch_source = NULL;
+    g_autofree gchar *arch_target = NULL;
+    /* options for source and target */
+    g_autofree gchar *arch_opts = NULL;
+    g_autofree gchar *cmd_source = NULL;
+    g_autofree gchar *cmd_target = NULL;
+    const gchar *ignore_stderr;
+    g_autofree char *shmem_opts = NULL;
+    g_autofree char *shmem_path = NULL;
+    const char *kvm_opts = NULL;
+    const char *arch = qtest_get_arch();
+    const char *memory_size;
+    const char *machine_alias, *machine_opts = "";
+    g_autofree char *machine = NULL;
+    const char *bootpath;
+
+    if (args->use_shmem) {
+        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
+            g_test_skip("/dev/shm is not supported");
+            return -1;
+        }
+    }
+
+    dst_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState) { };
+    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
+    src_state.suspend_me = args->suspend_me;
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        memory_size = "150M";
+
+        if (g_str_equal(arch, "i386")) {
+            machine_alias = "pc";
+        } else {
+            machine_alias = "q35";
+        }
+        arch_opts = g_strdup_printf(
+            "-drive if=none,id=d0,file=%s,format=raw "
+            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
+        start_address = X86_TEST_MEM_START;
+        end_address = X86_TEST_MEM_END;
+    } else if (g_str_equal(arch, "s390x")) {
+        memory_size = "128M";
+        machine_alias = "s390-ccw-virtio";
+        arch_opts = g_strdup_printf("-bios %s", bootpath);
+        start_address = S390_TEST_MEM_START;
+        end_address = S390_TEST_MEM_END;
+    } else if (strcmp(arch, "ppc64") == 0) {
+        memory_size = "256M";
+        start_address = PPC_TEST_MEM_START;
+        end_address = PPC_TEST_MEM_END;
+        machine_alias = "pseries";
+        machine_opts = "vsmt=8";
+        arch_opts = g_strdup_printf(
+            "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
+            "-bios %s", bootpath);
+    } else if (strcmp(arch, "aarch64") == 0) {
+        memory_size = "150M";
+        machine_alias = "virt";
+        machine_opts = "gic-version=3";
+        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
+        start_address = ARM_TEST_MEM_START;
+        end_address = ARM_TEST_MEM_END;
+    } else {
+        g_assert_not_reached();
+    }
+
+    if (!getenv("QTEST_LOG") && args->hide_stderr) {
+#ifndef _WIN32
+        ignore_stderr = "2>/dev/null";
+#else
+        /*
+         * On Windows the QEMU executable is created via CreateProcess() and
+         * IO redirection does not work, so don't bother adding IO redirection
+         * to the command line.
+         */
+        ignore_stderr = "";
+#endif
+    } else {
+        ignore_stderr = "";
+    }
+
+    if (args->use_shmem) {
+        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
+        shmem_opts = g_strdup_printf(
+            "-object memory-backend-file,id=mem0,size=%s"
+            ",mem-path=%s,share=on -numa node,memdev=mem0",
+            memory_size, shmem_path);
+    }
+
+    if (args->use_dirty_ring) {
+        kvm_opts = ",dirty-ring-size=4096";
+    }
+
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_test_skip(msg);
+        return -1;
+    }
+
+    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
+                                      QEMU_ENV_DST);
+
+    g_test_message("Using machine type: %s", machine);
+
+    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
+                                 "-machine %s,%s "
+                                 "-name source,debug-threads=on "
+                                 "-m %s "
+                                 "-serial file:%s/src_serial "
+                                 "%s %s %s %s %s",
+                                 kvm_opts ? kvm_opts : "",
+                                 machine, machine_opts,
+                                 memory_size, tmpfs,
+                                 arch_opts ? arch_opts : "",
+                                 arch_source ? arch_source : "",
+                                 shmem_opts ? shmem_opts : "",
+                                 args->opts_source ? args->opts_source : "",
+                                 ignore_stderr);
+    if (!args->only_target) {
+        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
+        qtest_qmp_set_event_callback(*from,
+                                     migrate_watch_for_events,
+                                     &src_state);
+    }
+
+    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
+                                 "-machine %s,%s "
+                                 "-name target,debug-threads=on "
+                                 "-m %s "
+                                 "-serial file:%s/dest_serial "
+                                 "-incoming %s "
+                                 "%s %s %s %s %s",
+                                 kvm_opts ? kvm_opts : "",
+                                 machine, machine_opts,
+                                 memory_size, tmpfs, uri,
+                                 arch_opts ? arch_opts : "",
+                                 arch_target ? arch_target : "",
+                                 shmem_opts ? shmem_opts : "",
+                                 args->opts_target ? args->opts_target : "",
+                                 ignore_stderr);
+    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
+    qtest_qmp_set_event_callback(*to,
+                                 migrate_watch_for_events,
+                                 &dst_state);
+
+    /*
+     * Remove shmem file immediately to avoid memory leak in test failed case.
+     * It's valid because QEMU has already opened this file
+     */
+    if (args->use_shmem) {
+        unlink(shmem_path);
+    }
+
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(*from, "events", true);
+    migrate_set_capability(*to, "events", true);
+
+    return 0;
+}
+
+void migrate_end(QTestState *from, QTestState *to, bool test_dest)
+{
+    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
+
+    qtest_quit(from);
+
+    if (test_dest) {
+        qtest_memread(to, start_address, &dest_byte_a, 1);
+
+        /* Destination still running, wait for a byte to change */
+        do {
+            qtest_memread(to, start_address, &dest_byte_b, 1);
+            usleep(1000 * 10);
+        } while (dest_byte_a == dest_byte_b);
+
+        qtest_qmp_assert_success(to, "{ 'execute' : 'stop'}");
+
+        /* With it stopped, check nothing changes */
+        qtest_memread(to, start_address, &dest_byte_c, 1);
+        usleep(1000 * 200);
+        qtest_memread(to, start_address, &dest_byte_d, 1);
+        g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+
+        check_guests_ram(to);
+    }
+
+    qtest_quit(to);
+
+    cleanup("migsocket");
+    cleanup("src_serial");
+    cleanup("dest_serial");
+    cleanup(FILE_TEST_FILENAME);
+}
+
+static int migrate_postcopy_prepare(QTestState **from_ptr,
+                                    QTestState **to_ptr,
+                                    MigrateCommon *args)
+{
+    QTestState *from, *to;
+
+    if (migrate_start(&from, &to, "defer", &args->start)) {
+        return -1;
+    }
+
+    if (args->start_hook) {
+        args->postcopy_data = args->start_hook(from, to);
+    }
+
+    migrate_set_capability(from, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-blocktime", true);
+
+    if (args->postcopy_preempt) {
+        migrate_set_capability(from, "postcopy-preempt", true);
+        migrate_set_capability(to, "postcopy-preempt", true);
+    }
+
+    migrate_ensure_non_converge(from);
+
+    migrate_prepare_for_dirty_mem(from);
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { "
+                             "      'channels': [ { 'channel-type': 'main',"
+                             "      'addr': { 'transport': 'socket',"
+                             "                'type': 'inet',"
+                             "                'host': '127.0.0.1',"
+                             "                'port': '0' } } ] } }");
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+    wait_for_suspend(from, &src_state);
+
+    migrate_qmp(from, to, NULL, NULL, "{}");
+
+    migrate_wait_for_dirty_mem(from, to);
+
+    *from_ptr = from;
+    *to_ptr = to;
+
+    return 0;
+}
+
+static void migrate_postcopy_complete(QTestState *from, QTestState *to,
+                                      MigrateCommon *args)
+{
+    MigrationTestEnv *env = migration_get_env();
+
+    wait_for_migration_complete(from);
+
+    if (args->start.suspend_me) {
+        /* wakeup succeeds only if guest is suspended */
+        qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+    }
+
+    /* Make sure we get at least one "B" on destination */
+    wait_for_serial("dest_serial");
+
+    if (env->uffd_feature_thread_id) {
+        read_blocktime(to);
+    }
+
+    if (args->end_hook) {
+        args->end_hook(from, to, args->postcopy_data);
+        args->postcopy_data = NULL;
+    }
+
+    migrate_end(from, to, true);
+}
+
+void test_postcopy_common(MigrateCommon *args)
+{
+    QTestState *from, *to;
+
+    if (migrate_postcopy_prepare(&from, &to, args)) {
+        return;
+    }
+    migrate_postcopy_start(from, to, &src_state);
+    migrate_postcopy_complete(from, to, args);
+}
+
+static void wait_for_postcopy_status(QTestState *one, const char *status)
+{
+    wait_for_migration_status(one, status,
+                              (const char * []) {
+                                  "failed", "active",
+                                  "completed", NULL
+                              });
+}
+
+static void postcopy_recover_fail(QTestState *from, QTestState *to,
+                                  PostcopyRecoveryFailStage stage)
+{
+#ifndef _WIN32
+    bool fail_early = (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH);
+    int ret, pair1[2], pair2[2];
+    char c;
+
+    g_assert(stage > POSTCOPY_FAIL_NONE && stage < POSTCOPY_FAIL_MAX);
+
+    /* Create two unrelated socketpairs */
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
+    g_assert_cmpint(ret, ==, 0);
+
+    /*
+     * Give the guests unpaired ends of the sockets, so they'll all blocked
+     * at reading.  This mimics a wrong channel established.
+     */
+    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    /*
+     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
+     * emulate the 1st byte of a real recovery, but stops from there to
+     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
+     * the recover process on dest QEMU (by triggering the G_IO_IN event).
+     *
+     * NOTE: this trick is not needed on src QEMUs, because src doesn't
+     * rely on an pre-existing G_IO_IN event, so it will always trigger the
+     * upcoming recovery anyway even if it can read nothing.
+     */
+#define QEMU_VM_COMMAND              0x08
+    c = QEMU_VM_COMMAND;
+    ret = send(pair2[1], &c, 1, 0);
+    g_assert_cmpint(ret, ==, 1);
+
+    if (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
+        /*
+         * This will make src QEMU to fail at an early stage when trying to
+         * resume later, where it shouldn't reach RECOVER stage at all.
+         */
+        close(pair1[1]);
+    }
+
+    migrate_recover(to, "fd:fd-mig");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
+
+    /*
+     * Source QEMU has an extra RECOVER_SETUP phase, dest doesn't have it.
+     * Make sure it appears along the way.
+     */
+    migration_event_wait(from, "postcopy-recover-setup");
+
+    if (fail_early) {
+        /*
+         * When fails at reconnection, src QEMU will automatically goes
+         * back to PAUSED state.  Making sure there is an event in this
+         * case: Libvirt relies on this to detect early reconnection
+         * errors.
+         */
+        migration_event_wait(from, "postcopy-paused");
+    } else {
+        /*
+         * We want to test "fail later" at RECOVER stage here.  Make sure
+         * both QEMU instances will go into RECOVER stage first, then test
+         * kicking them out using migrate-pause.
+         *
+         * Explicitly check the RECOVER event on src, that's what Libvirt
+         * relies on, rather than polling.
+         */
+        migration_event_wait(from, "postcopy-recover");
+        wait_for_postcopy_status(from, "postcopy-recover");
+
+        /* Need an explicit kick on src QEMU in this case */
+        migrate_pause(from);
+    }
+
+    /*
+     * For all failure cases, we'll reach such states on both sides now.
+     * Check them.
+     */
+    wait_for_postcopy_status(from, "postcopy-paused");
+    wait_for_postcopy_status(to, "postcopy-recover");
+
+    /*
+     * Kick dest QEMU out too. This is normally not needed in reality
+     * because when the channel is shutdown it should also happen on src.
+     * However here we used separate socket pairs so we need to do that
+     * explicitly.
+     */
+    migrate_pause(to);
+    wait_for_postcopy_status(to, "postcopy-paused");
+
+    close(pair1[0]);
+    close(pair2[0]);
+    close(pair2[1]);
+
+    if (stage != POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
+        close(pair1[1]);
+    }
+#endif
+}
+
+void test_postcopy_recovery_common(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    g_autofree char *uri = NULL;
+
+    /* Always hide errors for postcopy recover tests since they're expected */
+    args->start.hide_stderr = true;
+
+    if (migrate_postcopy_prepare(&from, &to, args)) {
+        return;
+    }
+
+    /* Turn postcopy speed down, 4K/s is slow enough on any machines */
+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
+
+    /* Now we start the postcopy */
+    migrate_postcopy_start(from, to, &src_state);
+
+    /*
+     * Wait until postcopy is really started; we can only run the
+     * migrate-pause command during a postcopy
+     */
+    wait_for_migration_status(from, "postcopy-active", NULL);
+
+    /*
+     * Manually stop the postcopy migration. This emulates a network
+     * failure with the migration socket
+     */
+    migrate_pause(from);
+
+    /*
+     * Wait for destination side to reach postcopy-paused state.  The
+     * migrate-recover command can only succeed if destination machine
+     * is in the paused state
+     */
+    wait_for_postcopy_status(to, "postcopy-paused");
+    wait_for_postcopy_status(from, "postcopy-paused");
+
+    if (args->postcopy_recovery_fail_stage) {
+        /*
+         * Test when a wrong socket specified for recover, and then the
+         * ability to kick it out, and continue with a correct socket.
+         */
+        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
+        /* continue with a good recovery */
+    }
+
+    /*
+     * Create a new socket to emulate a new channel that is different
+     * from the broken migration channel; tell the destination to
+     * listen to the new port
+     */
+    uri = g_strdup_printf("unix:%s/migsocket-recover", tmpfs);
+    migrate_recover(to, uri);
+
+    /*
+     * Try to rebuild the migration channel using the resume flag and
+     * the newly created channel
+     */
+    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
+
+    /* Restore the postcopy bandwidth to unlimited */
+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
+
+    migrate_postcopy_complete(from, to, args);
+}
+
+void test_precopy_common(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    void *data_hook = NULL;
+
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    if (args->start_hook) {
+        data_hook = args->start_hook(from, to);
+    }
+
+    /* Wait for the first serial output from the source */
+    if (args->result == MIG_TEST_SUCCEED) {
+        wait_for_serial("src_serial");
+        wait_for_suspend(from, &src_state);
+    }
+
+    if (args->live) {
+        migrate_ensure_non_converge(from);
+        migrate_prepare_for_dirty_mem(from);
+    } else {
+        /*
+         * Testing non-live migration, we allow it to run at
+         * full speed to ensure short test case duration.
+         * For tests expected to fail, we don't need to
+         * change anything.
+         */
+        if (args->result == MIG_TEST_SUCCEED) {
+            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+            wait_for_stop(from, &src_state);
+            migrate_ensure_converge(from);
+        }
+    }
+
+    if (args->result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+        goto finish;
+    }
+
+    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
+
+    if (args->result != MIG_TEST_SUCCEED) {
+        bool allow_active = args->result == MIG_TEST_FAIL;
+        wait_for_migration_fail(from, allow_active);
+
+        if (args->result == MIG_TEST_FAIL_DEST_QUIT_ERR) {
+            qtest_set_expected_status(to, EXIT_FAILURE);
+        }
+    } else {
+        if (args->live) {
+            /*
+             * For initial iteration(s) we must do a full pass,
+             * but for the final iteration, we need only wait
+             * for some dirty mem before switching to converge
+             */
+            while (args->iterations > 1) {
+                wait_for_migration_pass(from, &src_state);
+                args->iterations--;
+            }
+            migrate_wait_for_dirty_mem(from, to);
+
+            migrate_ensure_converge(from);
+
+            /*
+             * We do this first, as it has a timeout to stop us
+             * hanging forever if migration didn't converge
+             */
+            wait_for_migration_complete(from);
+
+            wait_for_stop(from, &src_state);
+
+        } else {
+            wait_for_migration_complete(from);
+            /*
+             * Must wait for dst to finish reading all incoming
+             * data on the socket before issuing 'cont' otherwise
+             * it'll be ignored
+             */
+            wait_for_migration_complete(to);
+
+            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+        }
+
+        wait_for_resume(to, &dst_state);
+
+        if (args->start.suspend_me) {
+            /* wakeup succeeds only if guest is suspended */
+            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+        }
+
+        wait_for_serial("dest_serial");
+    }
+
+finish:
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
+    }
+
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+}
+
+static void file_dirty_offset_region(void)
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    size_t size = FILE_TEST_OFFSET;
+    g_autofree char *data = g_new0(char, size);
+
+    memset(data, FILE_TEST_MARKER, size);
+    g_assert(g_file_set_contents(path, data, size, NULL));
+}
+
+static void file_check_offset_region(void)
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    size_t size = FILE_TEST_OFFSET;
+    g_autofree char *expected = g_new0(char, size);
+    g_autofree char *actual = NULL;
+    uint64_t *stream_start;
+
+    /*
+     * Ensure the skipped offset region's data has not been touched
+     * and the migration stream starts at the right place.
+     */
+
+    memset(expected, FILE_TEST_MARKER, size);
+
+    g_assert(g_file_get_contents(path, &actual, NULL, NULL));
+    g_assert(!memcmp(actual, expected, size));
+
+    stream_start = (uint64_t *)(actual + size);
+    g_assert_cmpint(cpu_to_be64(*stream_start) >> 32, ==, QEMU_VM_FILE_MAGIC);
+}
+
+void test_file_common(MigrateCommon *args, bool stop_src)
+{
+    QTestState *from, *to;
+    void *data_hook = NULL;
+    bool check_offset = false;
+
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /*
+     * File migration is never live. We can keep the source VM running
+     * during migration, but the destination will not be running
+     * concurrently.
+     */
+    g_assert_false(args->live);
+
+    if (g_strrstr(args->connect_uri, "offset=")) {
+        check_offset = true;
+        /*
+         * This comes before the start_hook because it's equivalent to
+         * a management application creating the file and writing to
+         * it so hooks should expect the file to be already present.
+         */
+        file_dirty_offset_region();
+    }
+
+    if (args->start_hook) {
+        data_hook = args->start_hook(from, to);
+    }
+
+    migrate_ensure_converge(from);
+    wait_for_serial("src_serial");
+
+    if (stop_src) {
+        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+        wait_for_stop(from, &src_state);
+    }
+
+    if (args->result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
+        goto finish;
+    }
+
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    /*
+     * We need to wait for the source to finish before starting the
+     * destination.
+     */
+    migrate_incoming_qmp(to, args->connect_uri, "{}");
+    wait_for_migration_complete(to);
+
+    if (stop_src) {
+        qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+    }
+    wait_for_resume(to, &dst_state);
+
+    wait_for_serial("dest_serial");
+
+    if (check_offset) {
+        file_check_offset_region();
+    }
+
+finish:
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
+    }
+
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+}
+
+void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
+                                                    QTestState *to,
+                                                    const char *method)
+{
+    migrate_set_parameter_int(from, "multifd-channels", 16);
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_parameter_str(from, "multifd-compression", method);
+    migrate_set_parameter_str(to, "multifd-compression", method);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    /* Start incoming migration from the 1st socket */
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+
+    return NULL;
+}
+
+QTestMigrationState *get_src(void)
+{
+    return &src_state;
+}
+
+MigrationTestEnv *migration_get_env(void)
+{
+    static MigrationTestEnv *env;
+    g_autoptr(GError) err = NULL;
+
+    if (env) {
+        return env;
+    }
+
+    env = g_new0(MigrationTestEnv, 1);
+    env->qemu_src = getenv(QEMU_ENV_SRC);
+    env->qemu_dst = getenv(QEMU_ENV_DST);
+
+    /*
+     * The default QTEST_QEMU_BINARY must always be provided because
+     * that is what helpers use to query the accel type and
+     * architecture.
+     */
+    if (env->qemu_src && env->qemu_dst) {
+        g_test_message("Only one of %s, %s is allowed",
+                       QEMU_ENV_SRC, QEMU_ENV_DST);
+        exit(1);
+    }
+
+    env->has_kvm = qtest_has_accel("kvm");
+    env->has_tcg = qtest_has_accel("tcg");
+
+    if (!env->has_tcg && !env->has_kvm) {
+        g_test_skip("No KVM or TCG accelerator available");
+        return env;
+    }
+
+    env->has_dirty_ring = kvm_dirty_ring_supported();
+    env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
+    env->arch = qtest_get_arch();
+    env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
+
+    env->tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
+    if (!env->tmpfs) {
+        g_test_message("Can't create temporary directory in %s: %s",
+                       g_get_tmp_dir(), err->message);
+    }
+    g_assert(env->tmpfs);
+
+    tmpfs = env->tmpfs;
+
+    return env;
+}
+
+int migration_env_clean(MigrationTestEnv *env)
+{
+    char *tmpfs;
+    int ret = 0;
+
+    if (!env) {
+        return ret;
+    }
+
+    bootfile_delete();
+
+    tmpfs = env->tmpfs;
+    ret = rmdir(tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s",
+                       tmpfs, strerror(errno));
+    }
+    g_free(tmpfs);
+
+    return ret;
+}
diff --git a/tests/qtest/migration/test-framework.h b/tests/qtest/migration/test-framework.h
new file mode 100644
index 0000000000..121078cf4f
--- /dev/null
+++ b/tests/qtest/migration/test-framework.h
@@ -0,0 +1,216 @@
+/*
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef TEST_FRAMEWORK_H
+#define TEST_FRAMEWORK_H
+
+#define FILE_TEST_FILENAME "migfile"
+#define FILE_TEST_OFFSET 0x1000
+#define FILE_TEST_MARKER 'X'
+
+typedef struct MigrationTestEnv {
+    bool has_kvm;
+    bool has_tcg;
+    bool has_uffd;
+    bool uffd_feature_thread_id;
+    bool has_dirty_ring;
+    bool is_x86;
+    const char *arch;
+    const char *qemu_src;
+    const char *qemu_dst;
+    char *tmpfs;
+} MigrationTestEnv;
+
+MigrationTestEnv *migration_get_env(void);
+int migration_env_clean(MigrationTestEnv *env);
+
+/*
+ * A hook that runs after the src and dst QEMUs have been
+ * created, but before the migration is started. This can
+ * be used to set migration parameters and capabilities.
+ *
+ * Returns: NULL, or a pointer to opaque state to be
+ *          later passed to the TestMigrateEndHook
+ */
+typedef void * (*TestMigrateStartHook)(QTestState *from,
+                                       QTestState *to);
+
+/*
+ * A hook that runs after the migration has finished,
+ * regardless of whether it succeeded or failed, but
+ * before QEMU has terminated (unless it self-terminated
+ * due to migration error)
+ *
+ * @opaque is a pointer to state previously returned
+ * by the TestMigrateStartHook if any, or NULL.
+ */
+typedef void (*TestMigrateEndHook)(QTestState *from,
+                                   QTestState *to,
+                                   void *opaque);
+
+/*
+ * Our goal is to ensure that we run a single full migration
+ * iteration, and also dirty memory, ensuring that at least
+ * one further iteration is required.
+ *
+ * We can't directly synchronize with the start of a migration
+ * so we have to apply some tricks monitoring memory that is
+ * transferred.
+ *
+ * Initially we set the migration bandwidth to an insanely
+ * low value, with tiny max downtime too. This basically
+ * guarantees migration will never complete.
+ *
+ * This will result in a test that is unacceptably slow though,
+ * so we can't let the entire migration pass run at this speed.
+ * Our intent is to let it run just long enough that we can
+ * prove data prior to the marker has been transferred *AND*
+ * also prove this transferred data is dirty again.
+ *
+ * Before migration starts, we write a 64-bit magic marker
+ * into a fixed location in the src VM RAM.
+ *
+ * Then watch dst memory until the marker appears. This is
+ * proof that start_address -> MAGIC_OFFSET_BASE has been
+ * transferred.
+ *
+ * Finally we go back to the source and read a byte just
+ * before the marker until we see it flip in value. This
+ * is proof that start_address -> MAGIC_OFFSET_BASE
+ * is now dirty again.
+ *
+ * IOW, we're guaranteed at least a 2nd migration pass
+ * at this point.
+ *
+ * We can now let migration run at full speed to finish
+ * the test
+ */
+typedef struct {
+    /*
+     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
+     * unconditionally, because it means the user would like to be verbose.
+     */
+    bool hide_stderr;
+    bool use_shmem;
+    /* only launch the target process */
+    bool only_target;
+    /* Use dirty ring if true; dirty logging otherwise */
+    bool use_dirty_ring;
+    const char *opts_source;
+    const char *opts_target;
+    /* suspend the src before migrating to dest. */
+    bool suspend_me;
+} MigrateStart;
+
+typedef enum PostcopyRecoveryFailStage {
+    /*
+     * "no failure" must be 0 as it's the default.  OTOH, real failure
+     * cases must be >0 to make sure they trigger by a "if" test.
+     */
+    POSTCOPY_FAIL_NONE = 0,
+    POSTCOPY_FAIL_CHANNEL_ESTABLISH,
+    POSTCOPY_FAIL_RECOVERY,
+    POSTCOPY_FAIL_MAX
+} PostcopyRecoveryFailStage;
+
+typedef struct {
+    /* Optional: fine tune start parameters */
+    MigrateStart start;
+
+    /* Required: the URI for the dst QEMU to listen on */
+    const char *listen_uri;
+
+    /*
+     * Optional: the URI for the src QEMU to connect to
+     * If NULL, then it will query the dst QEMU for its actual
+     * listening address and use that as the connect address.
+     * This allows for dynamically picking a free TCP port.
+     */
+    const char *connect_uri;
+
+    /*
+     * Optional: JSON-formatted list of src QEMU URIs. If a port is
+     * defined as '0' in any QDict key a value of '0' will be
+     * automatically converted to the correct destination port.
+     */
+    const char *connect_channels;
+
+    /* Optional: callback to run at start to set migration parameters */
+    TestMigrateStartHook start_hook;
+    /* Optional: callback to run at finish to cleanup */
+    TestMigrateEndHook end_hook;
+
+    /*
+     * Optional: normally we expect the migration process to complete.
+     *
+     * There can be a variety of reasons and stages in which failure
+     * can happen during tests.
+     *
+     * If a failure is expected to happen at time of establishing
+     * the connection, then MIG_TEST_FAIL will indicate that the dst
+     * QEMU is expected to stay running and accept future migration
+     * connections.
+     *
+     * If a failure is expected to happen while processing the
+     * migration stream, then MIG_TEST_FAIL_DEST_QUIT_ERR will indicate
+     * that the dst QEMU is expected to quit with non-zero exit status
+     */
+    enum {
+        /* This test should succeed, the default */
+        MIG_TEST_SUCCEED = 0,
+        /* This test should fail, dest qemu should keep alive */
+        MIG_TEST_FAIL,
+        /* This test should fail, dest qemu should fail with abnormal status */
+        MIG_TEST_FAIL_DEST_QUIT_ERR,
+        /* The QMP command for this migration should fail with an error */
+        MIG_TEST_QMP_ERROR,
+    } result;
+
+    /*
+     * Optional: set number of migration passes to wait for, if live==true.
+     * If zero, then merely wait for a few MB of dirty data
+     */
+    unsigned int iterations;
+
+    /*
+     * Optional: whether the guest CPUs should be running during a precopy
+     * migration test.  We used to always run with live but it took much
+     * longer so we reduced live tests to only the ones that have solid
+     * reason to be tested live-only.  For each of the new test cases for
+     * precopy please provide justifications to use live explicitly (please
+     * refer to existing ones with live=true), or use live=off by default.
+     */
+    bool live;
+
+    /* Postcopy specific fields */
+    void *postcopy_data;
+    bool postcopy_preempt;
+    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
+} MigrateCommon;
+
+void wait_for_serial(const char *side);
+void migrate_prepare_for_dirty_mem(QTestState *from);
+void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
+int migrate_start(QTestState **from, QTestState **to, const char *uri,
+                  MigrateStart *args);
+void migrate_end(QTestState *from, QTestState *to, bool test_dest);
+
+void test_postcopy_common(MigrateCommon *args);
+void test_postcopy_recovery_common(MigrateCommon *args);
+void test_precopy_common(MigrateCommon *args);
+void test_file_common(MigrateCommon *args, bool stop_src);
+void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
+                                                    QTestState *to,
+                                                    const char *method);
+
+typedef struct QTestMigrationState QTestMigrationState;
+QTestMigrationState *get_src(void);
+
+#endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


