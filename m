Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645B606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E07EMSdt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Pb-0003Hq-O2; Fri, 27 Nov 2026 14:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Np-0001qK-Bg; Fri, 27 Nov 2026 14:13:22 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nl-0006tV-1r; Fri, 27 Nov 2026 14:13:21 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C255F41279;
 Fri, 27 Nov 2026 19:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F2F1F00899;
 Fri, 27 Nov 2026 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806795;
 bh=7/d4oXOftvFIEymis9AxaKWSO5atWwQC1FuOYQwdsjg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E07EMSdtyKl36rCtXYacF6pXVoLCBEcI8tmwVNk6LoPnvm7L1DpSLruzjnHGxIR2x
 3WcX8bipuOxUXzWcyYPA6zozpcWo2ou6SD+kCaz+c9Sb082Dw65mRIIbaGy9EclIOD
 EF75m3qacpqVMb19KglllKeKReBKX/wXh4vZz/fwNltXMQ11XgbIMhrACGPWpWlQAi
 Z6EJVEXK4OM//l8wdD7CStfqAhPAUz0wPDcrQRjbKCuDFCJuSOG1xqZYccvnqEdqDq
 MTlzo+vvrQuNPc4X5JxHcLfRC8T1X/g0bK+NgJO9BLvRhdnFFTxk9P7PJZUYZndkg+
 hrR0dx/4pF7xw==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 07/13] hw/ide/ahci: add RECEIVE FPDMA QUEUED support
Date: Fri, 27 Nov 2026 20:12:42 +0100
Message-ID: <20261127191250.3298004-8-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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

The command RECEIVE FPDMA QUEUED allows the device to encapsulate a
non-NCQ command in a the RECEIVE FPDMA QUEUED command.

Add support for subcommand 01h only: the NCQ encapsulation of READ LOG
DMA EXT. It shares the log generation with READ LOG (DMA) EXT, and an
invalid log or subcommand aborts the command.

Add a qtest that reads logs over NCQ, and the libqos support for RECEIVE
FPDMA QUEUED.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci-internal.h    |  4 ++
 hw/ide/ahci.c             | 44 ++++++++++++++++++++++
 hw/ide/core.c             | 39 ++++++++++++++++----
 hw/ide/ide-internal.h     | 10 +++++
 hw/ide/trace-events       |  1 +
 tests/qtest/ahci-test.c   | 77 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/ahci.c | 15 ++++++++
 tests/qtest/libqos/ahci.h | 11 +++++-
 8 files changed, 191 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ahci-internal.h b/hw/ide/ahci-internal.h
index ca11a370c7..5f51341d87 100644
--- a/hw/ide/ahci-internal.h
+++ b/hw/ide/ahci-internal.h
@@ -246,6 +246,9 @@ enum AHCIPortIRQ {
 #define RECEIVE_FPDMA_QUEUED               0x65
 #define SEND_FPDMA_QUEUED                  0x64
 
+/* RECEIVE FPDMA QUEUED subcommands (ACS-6 table 95) */
+#define RECEIVE_FPDMA_READ_LOG_DMA_EXT     0x01
+
 #define NCQ_FIS_FUA_MASK                   0x80
 #define NCQ_FIS_RARC_MASK                  0x01
 
@@ -302,6 +305,7 @@ typedef struct NCQTransferState {
     uint64_t lba;
     uint8_t tag;
     uint8_t cmd;
+    uint8_t subcmd; /* SUBCOMMAND field, for RECEIVE/SEND FPDMA QUEUED */
     uint8_t slot;
     bool used;
     bool halt;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e14b298ea6..21938703da 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1093,6 +1093,43 @@ static int is_ncq(uint8_t ata_cmd)
     }
 }
 
+/*
+ * RECEIVE FPDMA QUEUED (ACS-6 7.33) transfers device-generated data to the
+ * host. Only subcommand 01h (the NCQ encapsulation of READ LOG DMA EXT, see
+ * ACS-6 7.26.6) is supported. The log data is generated synchronously into
+ * the I/O buffer and copied into the command's scatter/gather list, so there
+ * is no block backend I/O involved.
+ */
+static void execute_ncq_receive_fpdma_queued(NCQTransferState *ncq_tfs)
+{
+    IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
+
+    switch (ncq_tfs->subcmd) {
+    case RECEIVE_FPDMA_READ_LOG_DMA_EXT: {
+        /* Encapsulated READ LOG DMA EXT inputs (ACS-6 table 87). */
+        uint8_t log_address = ncq_tfs->lba & 0xff;
+        uint16_t page = ((ncq_tfs->lba >> 8) & 0xff) |
+                        (((ncq_tfs->lba >> 32) & 0xff) << 8);
+        int size = ide_read_log(ide_state, log_address, page,
+                                ncq_tfs->sector_count);
+
+        if (size < 0) {
+            ncq_err(ncq_tfs);
+            break;
+        }
+        dma_buf_read(ide_state->io_buffer, size, NULL, &ncq_tfs->sglist,
+                     MEMTXATTRS_UNSPECIFIED);
+        ide_state->status = READY_STAT | SEEK_STAT;
+        break;
+    }
+    default:
+        ncq_err(ncq_tfs);
+        break;
+    }
+
+    ncq_finish(ncq_tfs);
+}
+
 static void execute_ncq_command(NCQTransferState *ncq_tfs)
 {
     AHCIDevice *ad = ncq_tfs->drive;
@@ -1123,6 +1160,11 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
                                        BDRV_SECTOR_SIZE,
                                        ncq_cb, ncq_tfs);
         break;
+    case RECEIVE_FPDMA_QUEUED:
+        trace_execute_ncq_command_receive(ad->hba, port, ncq_tfs->tag,
+                                          ncq_tfs->subcmd);
+        execute_ncq_receive_fpdma_queued(ncq_tfs);
+        break;
     default:
         trace_execute_ncq_command_unsup(ad->hba, port,
                                         ncq_tfs->tag, ncq_tfs->cmd);
@@ -1175,6 +1217,8 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
     ncq_tfs->slot = slot;
     ncq_tfs->cmdh = &((AHCICmdHdr *)ad->lst)[slot];
     ncq_tfs->cmd = ncq_fis->command;
+    /* SUBCOMMAND field is COUNT bits 12:8, i.e. the low 5 bits of "prio" */
+    ncq_tfs->subcmd = ncq_fis->prio & 0x1f;
     ncq_tfs->lba = ((uint64_t)ncq_fis->lba5 << 40) |
                    ((uint64_t)ncq_fis->lba4 << 32) |
                    ((uint64_t)ncq_fis->lba3 << 24) |
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 1304202ea2..0ccac398b2 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -200,6 +200,8 @@ static void ide_identify(IDEState *s)
         put_le16(p + 75, s->ncq_queues - 1);
         /* 15=READ LOG DMA EXT equivalent to READ LOG EXT, 8=NCQ supported */
         put_le16(p + 76, (1 << 15) | (1 << 8));
+        /* 6=SEND AND RECEIVE QUEUED COMMANDS supported (SATA NCQ log 13h) */
+        put_le16(p + 77, (1 << 6));
     }
 
     put_le16(p + 80, 0xf0); /* ata3 -> ata6 supported */
@@ -1839,21 +1841,28 @@ static void ide_fill_identify_device_log(IDEState *s, uint16_t page,
 }
 
 /*
- * Fill the I/O buffer with the General Purpose Logging data requested by a
- * READ LOG EXT / READ LOG DMA EXT command and return the number of bytes to
- * transfer, or a negative value if the command must be aborted (ACS-6 7.25).
+ * Fill the I/O buffer with the General Purpose Logging data selected by
+ * log_address, page and count (the LOG PAGE COUNT, in 512-byte pages) and
+ * return the number of bytes to transfer, or a negative value if the command
+ * must be aborted (ACS-6 7.25). Shared by the READ LOG EXT / READ LOG DMA EXT
+ * commands and by the RECEIVE FPDMA QUEUED NCQ encapsulation (ACS-6 7.26.6).
  */
-static int ide_read_log(IDEState *s)
+int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
+                 uint32_t count)
 {
-    uint8_t log_address = s->sector;
-    uint16_t page = s->lcyl | ((uint16_t)s->hob_lcyl << 8);
-    uint32_t count = s->nsector; /* LOG PAGE COUNT, in 512-byte pages */
     uint16_t log_size;
 
     switch (log_address) {
     case IDE_GPL_LOG_DIRECTORY:
         log_size = 1;
         break;
+    case IDE_GPL_LOG_NCQ_SEND_RECV:
+        /* Only meaningful for devices that support the NCQ feature set. */
+        if (!s->ncq_queues) {
+            return -1;
+        }
+        log_size = 1;
+        break;
     case IDE_GPL_LOG_IDENTIFY_DEVICE:
         log_size = IDE_GPL_LOG_IDENTIFY_DEVICE_LEN;
         break;
@@ -1881,6 +1890,19 @@ static int ide_read_log(IDEState *s)
         /* word N: number of log pages at log address N */
         put_le16((uint16_t *)s->io_buffer + IDE_GPL_LOG_IDENTIFY_DEVICE,
                  IDE_GPL_LOG_IDENTIFY_DEVICE_LEN);
+        if (s->ncq_queues) {
+            put_le16((uint16_t *)s->io_buffer + IDE_GPL_LOG_NCQ_SEND_RECV, 1);
+        }
+        break;
+    case IDE_GPL_LOG_NCQ_SEND_RECV:
+        /* SATA NCQ Send and Receive log (ACS-6 9.19) */
+        memset(s->io_buffer, 0, count * 512);
+        /*
+         * "Supports Read Log" DWord (offset 8): advertise READ LOG DMA EXT as
+         * RECEIVE FPDMA QUEUED subcommand 01h. Bit 0 = QUEUED READ LOG DMA EXT
+         * SUPPORTED, bit 1 = SEQUENTIAL QUEUED READ LOG DMA EXT SUPPORTED.
+         */
+        stl_le_p(s->io_buffer + 8, (1 << 1) | (1 << 0));
         break;
     case IDE_GPL_LOG_IDENTIFY_DEVICE:
         ide_fill_identify_device_log(s, page, count);
@@ -1907,7 +1929,8 @@ static bool cmd_read_log(IDEState *s, uint8_t cmd)
     trace_ide_read_log(s, s->sector, s->lcyl | ((uint16_t)s->hob_lcyl << 8),
                        s->nsector, dma ? "dma" : "pio");
 
-    size = ide_read_log(s);
+    size = ide_read_log(s, s->sector, s->lcyl | ((uint16_t)s->hob_lcyl << 8),
+                        s->nsector);
     if (size < 0) {
         ide_abort_command(s);
         return true;
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 8da6d72450..382e2a4915 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -212,6 +212,7 @@
  * READ LOG EXT / READ LOG DMA EXT (see ACS-6 9.1 table 222).
  */
 #define IDE_GPL_LOG_DIRECTORY           0x00 /* General Purpose Log Directory */
+#define IDE_GPL_LOG_NCQ_SEND_RECV       0x13 /* SATA NCQ Send and Receive log */
 #define IDE_GPL_LOG_IDENTIFY_DEVICE     0x30 /* IDENTIFY DEVICE data log */
 
 /*
@@ -445,6 +446,15 @@ void ide_bus_register_restart_cb(IDEBus *bus);
 
 void ide_bus_exec_cmd(IDEBus *bus, uint32_t val);
 
+/*
+ * Fill the IDEState I/O buffer with a General Purpose Logging log page.
+ * Returns the number of bytes generated, or a negative value if the request
+ * is invalid. Shared between the READ LOG (DMA) EXT commands and the
+ * RECEIVE FPDMA QUEUED NCQ encapsulation.
+ */
+int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
+                 uint32_t count);
+
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func);
 bool ide_transfer_start_norecurse(IDEState *s, uint8_t *buf, int size,
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 102f39436c..8b98b11d23 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -98,6 +98,7 @@ ahci_populate_sglist_bad_offset(void *s, int port, int off_idx, int64_t off_pos)
 ncq_finish(void *s, int port, uint8_t tag) "ahci(%p)[%d][tag:%d]: NCQ transfer finished"
 execute_ncq_command_read(void *s, int port, uint8_t tag, int count, int64_t lba) "ahci(%p)[%d][tag:%d]: NCQ reading %d sectors from LBA %"PRId64
 execute_ncq_command_write(void *s, int port, uint8_t tag, int count, int64_t lba) "ahci(%p)[%d][tag:%d]: NCQ writing %d sectors to LBA %"PRId64
+execute_ncq_command_receive(void *s, int port, uint8_t tag, uint8_t subcmd) "ahci(%p)[%d][tag:%d]: NCQ RECEIVE FPDMA QUEUED subcommand 0x%02x"
 execute_ncq_command_unsup(void *s, int port, uint8_t tag, uint8_t cmd) "ahci(%p)[%d][tag:%d]: error: unsupported NCQ command (0x%02x) received"
 process_ncq_command_mismatch(void *s, int port, uint8_t tag, uint8_t slot) "ahci(%p)[%d][tag:%d]: Warning: NCQ slot (%d) did not match the given tag"
 process_ncq_command_aux(void *s, int port, uint8_t tag) "ahci(%p)[%d][tag:%d]: Warn: Attempt to use NCQ auxiliary fields"
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index ba9ea5c435..5e924010f0 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1805,6 +1805,82 @@ static void test_ncq_simple(void)
     ahci_shutdown(ahci);
 }
 
+/*
+ * Read one 512-byte General Purpose Logging log page into @buffer using
+ * RECEIVE FPDMA QUEUED subcommand 01h (the NCQ encapsulation of
+ * READ LOG DMA EXT).
+ */
+static void ahci_ncq_read_log(AHCIQState *ahci, uint8_t port, uint8_t log,
+                              uint16_t page, void *buffer)
+{
+    AHCICommand *cmd;
+    uint64_t ptr;
+    uint64_t lba = log | ((uint64_t)(page & 0xff) << 8) |
+                   ((uint64_t)(page >> 8) << 32);
+
+    ptr = ahci_alloc(ahci, 512);
+    g_assert(ptr);
+    qtest_memset(ahci->parent->qts, ptr, 0x00, 512);
+
+    cmd = ahci_command_create(RECEIVE_FPDMA_QUEUED);
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_set_offset(cmd, lba);
+    ahci_command_set_ncq_subcmd(cmd, NCQ_RECEIVE_READ_LOG_DMA_EXT);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue(ahci, cmd);
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+
+    qtest_bufread(ahci->parent->qts, ptr, buffer, 512);
+    ahci_free(ahci, ptr);
+}
+
+static void test_ncq_read_log(void)
+{
+    AHCIQState *ahci;
+    uint16_t id[256];
+    uint16_t dir[256];
+    uint16_t page[256];
+    uint8_t *page8 = (uint8_t *)page;
+    unsigned px;
+
+    ahci = ahci_boot_and_enable(NULL);
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+
+    /* Fetch IDENTIFY DEVICE data (PIO) to compare against the log copy. */
+    ahci_io(ahci, px, CMD_IDENTIFY, &id, 512, 0);
+    /* word 77 bit 6: SEND AND RECEIVE QUEUED COMMANDS supported */
+    g_assert_cmphex(le16_to_cpu(id[77]) & (1 << 6), ==, (1 << 6));
+
+    /* General Purpose Log Directory (log 00h) over NCQ. */
+    ahci_ncq_read_log(ahci, px, 0x00, 0, dir);
+    g_assert_cmphex(le16_to_cpu(dir[0]), ==, 0x0001); /* GPL version */
+    g_assert_cmphex(le16_to_cpu(dir[0x13]), ==, 1);   /* NCQ Send/Recv log */
+    g_assert_cmphex(le16_to_cpu(dir[0x30]), ==, 9);   /* IDENTIFY log size */
+
+    /* SATA NCQ Send and Receive log (log 13h). */
+    ahci_ncq_read_log(ahci, px, 0x13, 0, page);
+    /*
+     * "Supports Read Log" DWord (offset 8): bit 0 QUEUED READ LOG DMA EXT and
+     * bit 1 SEQUENTIAL QUEUED READ LOG DMA EXT (subcommand 01h).
+     */
+    g_assert_cmpuint(page8[8] | (page8[9] << 8) | (page8[10] << 16) |
+                     ((uint32_t)page8[11] << 24), ==, 0x3);
+
+    /* IDENTIFY DEVICE data log (log 30h) page 0: list of supported pages. */
+    ahci_ncq_read_log(ahci, px, 0x30, 0, page);
+    g_assert_cmphex(le16_to_cpu(page[0]), ==, 0x0001); /* REVISION NUMBER */
+    g_assert_cmpint(page8[8], ==, 8);                  /* number of entries */
+
+    /* IDENTIFY DEVICE data log (log 30h) page 1: copy of IDENTIFY data. */
+    ahci_ncq_read_log(ahci, px, 0x30, 1, page);
+    g_assert_cmphex(memcmp(page, id, 512), ==, 0);
+
+    ahci_shutdown(ahci);
+}
+
 static int prepare_iso(size_t size, unsigned char **buf, char **name)
 {
     g_autofree char *cdrom_path = NULL;
@@ -2662,6 +2738,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/reset/pending_callback", test_reset_pending_callback);
 
     qtest_add_func("/ahci/io/ncq/simple", test_ncq_simple);
+    qtest_add_func("/ahci/io/ncq/read_log", test_ncq_read_log);
     qtest_add_func("/ahci/migrate/ncq/simple", test_migrate_ncq);
     qtest_add_func("/ahci/io/ncq/retry", test_halted_ncq);
     qtest_add_func("/ahci/migrate/ncq/halted", test_migrate_halted_ncq);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index e64fcade36..d50ff4767b 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -75,6 +75,8 @@ AHCICommandProp ahci_command_properties[] = {
                                  .lba48 = true, .read = true, .ncq = true },
     { .cmd = WRITE_FPDMA_QUEUED, .data = true,  .dma = true,
                                  .lba48 = true, .write = true, .ncq = true },
+    { .cmd = RECEIVE_FPDMA_QUEUED, .data = true, .dma = true,
+                                 .lba48 = true, .read = true, .ncq = true },
     { .cmd = CMD_READ_MAX,       .lba28 = true },
     { .cmd = CMD_READ_MAX_EXT,   .lba48 = true },
     { .cmd = CMD_FLUSH_CACHE,    .data = false },
@@ -1204,6 +1206,19 @@ void ahci_command_set_count(AHCICommand *cmd, uint16_t count)
     cmd->fis.count = count;
 }
 
+/*
+ * Set the SUBCOMMAND field (COUNT bits 12:8) of an NCQ command, e.g. the
+ * RECEIVE FPDMA QUEUED subcommand. It occupies the low 5 bits of the "prio"
+ * (COUNT 15:8) byte.
+ */
+void ahci_command_set_ncq_subcmd(AHCICommand *cmd, uint8_t subcmd)
+{
+    NCQFIS *nfis = (NCQFIS *)&(cmd->fis);
+
+    g_assert(cmd->props->ncq);
+    nfis->prio = (nfis->prio & ~0x1f) | (subcmd & 0x1f);
+}
+
 void ahci_command_expect_error(AHCICommand *cmd, uint8_t err)
 {
     cmd->interrupts |= AHCI_PX_IS_TFES;
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 9c4195eee9..9b40eabe35 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -285,8 +285,14 @@ enum {
     CMD_PACKET         = 0xA0,
     CMD_PACKET_ID      = 0xA1,
     /* NCQ */
-    READ_FPDMA_QUEUED  = 0x60,
-    WRITE_FPDMA_QUEUED = 0x61,
+    READ_FPDMA_QUEUED    = 0x60,
+    WRITE_FPDMA_QUEUED   = 0x61,
+    RECEIVE_FPDMA_QUEUED = 0x65,
+};
+
+/* RECEIVE FPDMA QUEUED subcommands */
+enum {
+    NCQ_RECEIVE_READ_LOG_DMA_EXT = 0x01,
 };
 
 /* ATAPI Commands */
@@ -647,6 +653,7 @@ void ahci_command_set_prd_size(AHCICommand *cmd, unsigned prd_size);
 void ahci_command_set_sizes(AHCICommand *cmd, uint64_t xbytes,
                             unsigned prd_size);
 void ahci_command_set_count(AHCICommand *cmd, uint16_t count);
+void ahci_command_set_ncq_subcmd(AHCICommand *cmd, uint8_t subcmd);
 void ahci_command_expect_error(AHCICommand *cmd, uint8_t err);
 void ahci_command_set_acmd(AHCICommand *cmd, void *acmd);
 void ahci_command_enable_atapi_dma(AHCICommand *cmd);
-- 
2.56.1


