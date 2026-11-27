Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D608606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GT5IsWtf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Pk-0003rL-Ay; Fri, 27 Nov 2026 14:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1O2-0001w2-B7; Fri, 27 Nov 2026 14:13:40 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nz-0007k4-FV; Fri, 27 Nov 2026 14:13:33 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40AE740B0B;
 Fri, 27 Nov 2026 19:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1241B1F00893;
 Fri, 27 Nov 2026 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806810;
 bh=wXRk9ealON7sNtDWqzBA3DTMK8pxgtg5MhZcE1SMGPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GT5IsWtf0xEWwhqFNylA48xHRfC5760EoDQRvN+PWHWsYSblX5N+ohcunukYa02Sv
 ILu8ycoNc2+0M0RlyJLtIcBdhYWzGN2nk53N3t45YrFgwUMe0IA6tJJg3HBGMnnVUv
 M7Jc9iKfOK7ErV/U64oiRN9iBRHC5HMAL8ePGLazEYnhUvUFvKF4pwsN7YoXf3BXHq
 4TbRbqeBWc+tZtnQmJNDUy28WcfLfW6yB49ZymEz51yH/XHJFReUG48xJJL95atl50
 FJQPiQwd0gFJUlgMqbE2Bxioq0jhvLA+bv+5PjWPYepFwyPgLjlOhnV/o50W+XSShe
 X4lJ2pQoa2iww==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 12/13] hw/ide/ahci: check the LBA range of NCQ commands
Date: Fri, 27 Nov 2026 20:12:47 +0100
Message-ID: <20261127191250.3298004-13-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A NCQ command were not range checked before being accepted.

The NCQ command was queued and then failed with EIO by the block layer.

Check the range with ide_sect_range_ok() when the command is accepted,
and abort it there instead of queuing it (ACS-6 7.24.6). Report sense data
LOGICAL BLOCK ADDRESS OUT OF RANGE in the NCQ Command Error log, and
account the request as invalid. Add a test.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci.c           | 44 +++++++++++++++++++++++++---------
 hw/ide/core.c           |  3 +--
 hw/ide/ide-internal.h   |  3 +++
 tests/qtest/ahci-test.c | 52 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index a1fe0cc72d..9f9d2a070d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1219,6 +1219,39 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
         return;
     }
 
+    ncq_tfs->lba = ((uint64_t)ncq_fis->lba5 << 40) |
+                   ((uint64_t)ncq_fis->lba4 << 32) |
+                   ((uint64_t)ncq_fis->lba3 << 24) |
+                   ((uint64_t)ncq_fis->lba2 << 16) |
+                   ((uint64_t)ncq_fis->lba1 << 8) |
+                   (uint64_t)ncq_fis->lba0;
+    ncq_tfs->sector_count = ((ncq_fis->sector_count_high << 8) |
+                             ncq_fis->sector_count_low);
+    if (!ncq_tfs->sector_count) {
+        ncq_tfs->sector_count = 0x10000;
+    }
+
+    /*
+     * A READ or WRITE FPDMA QUEUED beyond the last logical sector is not
+     * queued: the device aborts it when accepting it (ACS-6 7.24.6, table
+     * 398), and then waits for the host to read the NCQ Command Error log
+     * (SATA 3.5a DFPDMAQ12, DFPDMAQ13). Like the non-queued reads and writes
+     * (see ide_sect_range_ok()), it thus never reaches the block layer, so
+     * the rerror/werror policy does not apply to it.
+     */
+    if ((ncq_fis->command == READ_FPDMA_QUEUED ||
+         ncq_fis->command == WRITE_FPDMA_QUEUED) &&
+        !ide_sect_range_ok(&ad->port.ifs[0], ncq_tfs->lba,
+                           ncq_tfs->sector_count)) {
+        block_acct_invalid(blk_get_stats(ad->port.ifs[0].blk),
+                           ncq_fis->command == READ_FPDMA_QUEUED ?
+                           BLOCK_ACCT_READ : BLOCK_ACCT_WRITE);
+        ide_ncq_cmd_error(&ad->port.ifs[0], tag, ncq_tfs->lba,
+                          ncq_tfs->sector_count, SENSE_CODE(LBA_OUT_OF_RANGE));
+        ahci_write_fis_d2h(ad, true);
+        return;
+    }
+
     /*
      * A NCQ command clears the bit in PxCI after the command has been QUEUED
      * successfully (ERROR not set, BUSY and DRQ cleared). A device reports
@@ -1247,12 +1280,6 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
     ncq_tfs->cmd = ncq_fis->command;
     /* SUBCOMMAND field is COUNT bits 12:8, i.e. the low 5 bits of "prio" */
     ncq_tfs->subcmd = ncq_fis->prio & 0x1f;
-    ncq_tfs->lba = ((uint64_t)ncq_fis->lba5 << 40) |
-                   ((uint64_t)ncq_fis->lba4 << 32) |
-                   ((uint64_t)ncq_fis->lba3 << 24) |
-                   ((uint64_t)ncq_fis->lba2 << 16) |
-                   ((uint64_t)ncq_fis->lba1 << 8) |
-                   (uint64_t)ncq_fis->lba0;
 
     /*
      * Accepting an NCQ command makes the sense data unavailable, unless it
@@ -1283,11 +1310,6 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
         trace_process_ncq_command_rarc(s, port, tag);
     }
 
-    ncq_tfs->sector_count = ((ncq_fis->sector_count_high << 8) |
-                             ncq_fis->sector_count_low);
-    if (!ncq_tfs->sector_count) {
-        ncq_tfs->sector_count = 0x10000;
-    }
     size = ncq_tfs->sector_count * BDRV_SECTOR_SIZE;
     ahci_populate_sglist(ad, &ncq_tfs->sglist, ncq_tfs->cmdh, size, 0);
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index a8c8a104b6..31bb617390 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -429,8 +429,7 @@ static void ide_set_signature(IDEState *s)
     }
 }
 
-static bool ide_sect_range_ok(IDEState *s,
-                              uint64_t sector, uint64_t nb_sectors)
+bool ide_sect_range_ok(IDEState *s, uint64_t sector, uint64_t nb_sectors)
 {
     uint64_t total_sectors;
 
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index b39b5460c3..2de12c8105 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -465,6 +465,9 @@ int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
 void ide_ncq_cmd_error(IDEState *s, uint8_t tag, uint64_t lba,
                        uint16_t count, SCSISense sense);
 
+/* Whether a command may access nb_sectors sectors from sector */
+bool ide_sect_range_ok(IDEState *s, uint64_t sector, uint64_t nb_sectors);
+
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func);
 bool ide_transfer_start_norecurse(IDEState *s, uint8_t *buf, int size,
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index c95a95540d..06d090cc04 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -2181,6 +2181,57 @@ static void test_sense_data_current_settings(void)
     ahci_shutdown(ahci);
 }
 
+/*
+ * An NCQ command beyond the last logical sector is aborted with ILLEGAL
+ * REQUEST / LOGICAL BLOCK ADDRESS OUT OF RANGE in the NCQ Command Error log,
+ * without reaching the block layer: even with rerror=stop and werror=stop, it
+ * is reported to the guest rather than stopping the VM.
+ */
+static void test_ncq_lba_range(void)
+{
+    const uint64_t lba = mb_to_sectors(test_image_size_mb); /* past the end */
+    const uint8_t cmds[] = { READ_FPDMA_QUEUED, WRITE_FPDMA_QUEUED };
+    AHCIQState *ahci;
+    uint8_t log[512];
+    uint64_t ptr;
+    unsigned px;
+    int i;
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=%s,"
+                                "rerror=stop,werror=stop "
+                                "-M q35 -device ide-hd,drive=drive0",
+                                tmp_path, imgfmt);
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+    ptr = ahci_alloc(ahci, 512);
+    g_assert(ptr);
+
+    for (i = 0; i < ARRAY_SIZE(cmds); i++) {
+        AHCICommand *cmd = ahci_command_create(cmds[i]);
+
+        ahci_command_set_buffer(cmd, ptr);
+        ahci_command_set_size(cmd, 512);
+        ahci_command_set_offset(cmd, lba);
+        ahci_command_expect_error(cmd, ATA_ERR_ABRT);
+        ahci_command_commit(ahci, cmd, px);
+        ahci_command_issue(ahci, cmd);
+        ahci_command_verify(ahci, cmd);
+        ahci_command_free(cmd);
+
+        ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, log, 512, 0x10);
+        g_assert_cmphex(log[3], ==, 0x04);          /* ERROR: ABRT */
+        g_assert_cmphex(log[4] | log[5] << 8 | log[6] << 16 |
+                        (uint64_t)log[8] << 24 | (uint64_t)log[9] << 32 |
+                        (uint64_t)log[10] << 40, ==, lba);
+        g_assert_cmphex(log[14], ==, 0x05);         /* ILLEGAL REQUEST */
+        g_assert_cmphex(log[15], ==, 0x21);         /* LBA OUT OF RANGE */
+        g_assert_cmphex(log[16], ==, 0x00);
+    }
+
+    ahci_free(ahci, ptr);
+    ahci_shutdown(ahci);
+}
+
 static int prepare_iso(size_t size, unsigned char **buf, char **name)
 {
     g_autofree char *cdrom_path = NULL;
@@ -3071,6 +3122,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/io/ncq/sense_data/cmd", test_sense_data_ncq_cmd);
     qtest_add_func("/ahci/io/sense_data/current_settings",
                    test_sense_data_current_settings);
+    qtest_add_func("/ahci/io/ncq/lba_range", test_ncq_lba_range);
     qtest_add_func("/ahci/migrate/ncq/simple", test_migrate_ncq);
     qtest_add_func("/ahci/io/ncq/retry", test_halted_ncq);
     qtest_add_func("/ahci/migrate/ncq/halted", test_migrate_halted_ncq);
-- 
2.56.1


