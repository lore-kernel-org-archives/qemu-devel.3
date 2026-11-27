Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDC606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alUXyH1b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Oi-0002SR-9h; Fri, 27 Nov 2026 14:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Ny-0001up-TA; Fri, 27 Nov 2026 14:13:31 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nw-0007Zu-VQ; Fri, 27 Nov 2026 14:13:30 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74C1161B64;
 Fri, 27 Nov 2026 19:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8C41F0092A;
 Fri, 27 Nov 2026 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806807;
 bh=uH9rO0SpgQ1tyK3SiuL4yZ2fsEwXztY/Qnmg8eVQnvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=alUXyH1boswBgtxwkeTdV2DJ2mKx8vh8BrjRKHo8vA4BLXn/3lZ8HIkIvw6MD0xJp
 CoKjpJHLHq/9fu5pvishiX0T6Evt4sYZni+aEHQyFmBJdPUCsJInDPjdCDuGlFWoUm
 a5U3bGcEGb3d1griMznZ1qlx8JZMmRzLXBZU8bIRqx7VrIUQLnFyMg2dQvFv4QrMDC
 v7YFbC93JM8xrhWkgZmwI6Xh2Gnc0BCS5ayhfGUKMwXrmdpxrhjmkjqwva6lngLX69
 enApZEcni0aHHu0x7vyXRz47b4MafKcKO7/K1a4p8nqhVv9Eb9TOF/G44eQQpE0Sec
 1YOAXqwKaP9Kg==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 11/13] hw/ide: report out-of-range accesses as ILLEGAL REQUEST
Date: Fri, 27 Nov 2026 20:12:46 +0100
Message-ID: <20261127191250.3298004-12-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
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

A non-queued read or write beyond the last logical sector is aborted by
ide_sect_range_ok() before any block I/O is done, without sense data.

Report sense data ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF RANGE
for non-NCQ commands trying to do this. Add a qtest for it.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/core.c           | 22 ++++++++++++++--------
 tests/qtest/ahci-test.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index cc38a3ef65..a8c8a104b6 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -757,8 +757,9 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
     }
 }
 
-static void ide_rw_error(IDEState *s) {
-    ide_abort_command(s);
+static void ide_rw_error(IDEState *s, SCSISense sense)
+{
+    ide_abort_command_with_sense(s, sense);
     ide_bus_set_irq(s->bus);
 }
 
@@ -913,7 +914,7 @@ static void ide_sector_read(IDEState *s)
     trace_ide_sector_read(sector_num, n);
 
     if (!ide_sect_range_ok(s, sector_num, n)) {
-        ide_rw_error(s);
+        ide_rw_error(s, SENSE_CODE(LBA_OUT_OF_RANGE));
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
         return;
     }
@@ -945,14 +946,19 @@ void ide_set_inactive(IDEState *s, bool more)
     ide_cmd_done(s);
 }
 
-void ide_dma_error(IDEState *s)
+static void ide_dma_error_with_sense(IDEState *s, SCSISense sense)
 {
     ide_dma_buf_commit(s, 0);
-    ide_abort_command(s);
+    ide_abort_command_with_sense(s, sense);
     ide_set_inactive(s, false);
     ide_bus_set_irq(s->bus);
 }
 
+void ide_dma_error(IDEState *s)
+{
+    ide_dma_error_with_sense(s, SENSE_CODE(NO_SENSE));
+}
+
 int ide_handle_rw_error(IDEState *s, int error, int op)
 {
     bool is_read = (op & IDE_RETRY_READ) != 0;
@@ -968,7 +974,7 @@ int ide_handle_rw_error(IDEState *s, int error, int op)
         } else if (IS_IDE_RETRY_ATAPI(op)) {
             ide_atapi_io_error(s, -error);
         } else {
-            ide_rw_error(s);
+            ide_rw_error(s, SENSE_CODE(NO_SENSE));
         }
     }
     blk_error_action(s->blk, action, is_read, error);
@@ -1056,7 +1062,7 @@ static void ide_dma_cb(void *opaque, int ret)
 
     if ((s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) &&
         !ide_sect_range_ok(s, sector_num, n)) {
-        ide_dma_error(s);
+        ide_dma_error_with_sense(s, SENSE_CODE(LBA_OUT_OF_RANGE));
         block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
@@ -1206,7 +1212,7 @@ static void ide_sector_write(IDEState *s)
     trace_ide_sector_write(sector_num, n);
 
     if (!ide_sect_range_ok(s, sector_num, n)) {
-        ide_rw_error(s);
+        ide_rw_error(s, SENSE_CODE(LBA_OUT_OF_RANGE));
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
         return;
     }
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index df9295906c..c95a95540d 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1231,6 +1231,24 @@ static uint32_t ahci_sense(AHCIQState *ahci, unsigned px)
     return (fis.lba_lo[2] & 0x0f) << 16 | fis.lba_lo[1] << 8 | fis.lba_lo[0];
 }
 
+/* Issue a 512-byte data-in command at @lba that is expected to be aborted */
+static void ahci_read_expect_abort(AHCIQState *ahci, unsigned px, uint8_t op,
+                                   uint64_t lba)
+{
+    uint64_t ptr = ahci_alloc(ahci, 512);
+    AHCICommand *cmd = ahci_command_create(op);
+
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_set_offset(cmd, lba);
+    ahci_command_expect_error(cmd, ATA_ERR_ABRT);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+}
+
 /**
  * Fragmented DMA test: Perform a standard 4K DMA read/write
  * test, but make sure the physical regions are fragmented to
@@ -2909,6 +2927,19 @@ static void test_sense_data_set_features(void)
     ahci_shutdown(ahci);
 }
 
+static void test_sense_data_lba_range(void)
+{
+    const uint64_t lba = (uint64_t)test_image_size_mb * 1024 * 1024 / 512;
+    unsigned px;
+    AHCIQState *ahci = ahci_boot_with_sense_data(&px);
+
+    ahci_read_expect_abort(ahci, px, CMD_READ_PIO_EXT, lba);
+    g_assert_cmphex(ahci_sense(ahci, px), ==, 0x052100);
+    ahci_read_expect_abort(ahci, px, CMD_READ_DMA_EXT, lba);
+    g_assert_cmphex(ahci_sense(ahci, px), ==, 0x052100);
+    ahci_shutdown(ahci);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch, *base;
@@ -3002,6 +3033,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/io/pio/read_log", test_read_log_pio);
     qtest_add_func("/ahci/io/sense_data/set_features",
                    test_sense_data_set_features);
+    qtest_add_func("/ahci/io/sense_data/lba_range", test_sense_data_lba_range);
 
     for (i = MODE_BEGIN; i < NUM_MODES; i++) {
         for (j = ADDR_MODE_BEGIN; j < NUM_ADDR_MODES; j++) {
-- 
2.56.1


