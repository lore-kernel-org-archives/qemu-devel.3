Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968D606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1XAu+Ru
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Oc-0002F7-0O; Fri, 27 Nov 2026 14:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Ni-0001nZ-4H; Fri, 27 Nov 2026 14:13:15 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nf-0006T2-Dr; Fri, 27 Nov 2026 14:13:13 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6054361364;
 Fri, 27 Nov 2026 19:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996F81F00897;
 Fri, 27 Nov 2026 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806789;
 bh=I66ZUzIQuqcrXx7SqYgs1MhOeg24vg65RHc3fAuZ9x8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A1XAu+Ruhf5m7EyPL/mhydO31oMJNfo7I2Z0JO3pVw1WjVAZVeICKA/u1ipG/hIwo
 gv6JsMMNICl87IRQ5tY89jE3x2plBp/OUECThjtAvm8bMFUQNqWGA5Q2qc/ZR3jLca
 D0m/UKuSFckvCOy21CDREFmlo7wh/wjjDHS52+BRP5FgV9RQH3nQIgj25wB4EjutAu
 VkL5+4NLhVmbwWWOum+ioVEOqodcKJ1dJDiFOmbovpCa5gb+cshKD3i7cZ0nZi2OPn
 8YT6twKrl3Wpn+3No/ldUhYuSpUc70MecpbDCV366bUFMvZlKeNq6yLpYM2I9jMayO
 RWM7lIjPJcKRw==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 05/13] hw/ide: add General Purpose Logging (GPL) feature set
 support
Date: Fri, 27 Nov 2026 20:12:40 +0100
Message-ID: <20261127191250.3298004-6-cassel@kernel.org>
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

Implement the General Purpose Logging feature set (ACS-6 4.11).

Commands READ LOG EXT (PIO) and READ LOG DMA EXT (DMA) are implemented.
WRITE LOG EXT and WRITE LOG DMA EXT are not implemented.
(E.g. Linux never writes to any log.)

In this base commit, the only log implemented is the General Purpose Log
Directory (00h), which lists no other log yet.

As with NCQ, only a disk behind AHCI exposes this feature set.
On other controllers, a disk neither advertises it nor accepts the new
commands, i.e. they work as before. The main reason to add GPL support
is to add the NCQ Command Error log, the SATA NCQ Send and Receive log,
the Serial ATA page of the IDENTIFY DEVICE data log, and RECEIVE FPDMA
QUEUED. Neither of these features/logs makes sense for non-NCQ devices.

Add qtests that read the log directory over AHCI, with PIO and DMA, and
check that an IDE disk does not advertise the feature set.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/core.c             | 134 ++++++++++++++++++++++++++++++++++----
 hw/ide/ide-internal.h     |  10 ++-
 hw/ide/trace-events       |   1 +
 include/hw/ide/ide-dev.h  |   1 +
 tests/qtest/ahci-test.c   |  51 +++++++++++++++
 tests/qtest/ide-test.c    |   3 +
 tests/qtest/libqos/ahci.c |   4 ++
 tests/qtest/libqos/ahci.h |   2 +
 8 files changed, 192 insertions(+), 14 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 7e3f882969..d09b0fa736 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -68,7 +68,8 @@ const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT] = {
     [IDE_DMA_READ] = "DMA READ",
     [IDE_DMA_WRITE] = "DMA WRITE",
     [IDE_DMA_TRIM] = "DMA TRIM",
-    [IDE_DMA_ATAPI] = "DMA ATAPI"
+    [IDE_DMA_ATAPI] = "DMA ATAPI",
+    [IDE_DMA_READ_LOG] = "DMA READ LOG"
 };
 
 static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
@@ -150,6 +151,7 @@ static void ide_identify(IDEState *s)
 {
     uint16_t *p;
     IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
+    uint16_t gpl = s->ncq_queues ? 1 << 5 : 0;
 
     p = (uint16_t *)s->identify_data;
     if (s->identify_set) {
@@ -196,8 +198,8 @@ static void ide_identify(IDEState *s)
 
     if (s->ncq_queues) {
         put_le16(p + 75, s->ncq_queues - 1);
-        /* NCQ supported */
-        put_le16(p + 76, (1 << 8));
+        /* 15=READ LOG DMA EXT equivalent to READ LOG EXT, 8=NCQ supported */
+        put_le16(p + 76, (1 << 15) | (1 << 8));
     }
 
     put_le16(p + 80, 0xf0); /* ata3 -> ata6 supported */
@@ -206,20 +208,21 @@ static void ide_identify(IDEState *s)
     put_le16(p + 82, (1 << 14) | (1 << 5) | 1);
     /* 13=flush_cache_ext,12=flush_cache,10=lba48 */
     put_le16(p + 83, (1 << 14) | (1 << 13) | (1 <<12) | (1 << 10));
-    /* 14=set to 1, 8=has WWN, 1=SMART self test, 0=SMART error logging */
+    /* 14=set to 1, 8=has WWN, 5=GPL, 1=SMART self test, 0=SMART error log */
     if (s->wwn) {
-        put_le16(p + 84, (1 << 14) | (1 << 8) | 0);
+        put_le16(p + 84, (1 << 14) | (1 << 8) | gpl | 0);
     } else {
-        put_le16(p + 84, (1 << 14) | 0);
+        put_le16(p + 84, (1 << 14) | gpl | 0);
     }
     put_le16(p + 85, ide_identify_word85(s));
-    /* 13=flush_cache_ext,12=flush_cache,10=lba48 */
-    put_le16(p + 86, (1 << 13) | (1 <<12) | (1 << 10));
-    /* 14=set to 1, 8=has WWN, 1=SMART self test, 0=SMART error logging */
+    /* 15=words 119-120 valid,13=flush_cache_ext,12=flush_cache,10=lba48 */
+    put_le16(p + 86, (s->ncq_queues ? 1 << 15 : 0) |
+             (1 << 13) | (1 << 12) | (1 << 10));
+    /* 14=set to 1, 8=has WWN, 5=GPL, 1=SMART self test, 0=SMART error log */
     if (s->wwn) {
-        put_le16(p + 87, (1 << 14) | (1 << 8) | 0);
+        put_le16(p + 87, (1 << 14) | (1 << 8) | gpl | 0);
     } else {
-        put_le16(p + 87, (1 << 14) | 0);
+        put_le16(p + 87, (1 << 14) | gpl | 0);
     }
     put_le16(p + 88, 0x3f | (1 << 13)); /* udma5 set and supported */
     put_le16(p + 93, 1 | (1 << 14) | 0x2000);
@@ -237,6 +240,15 @@ static void ide_identify(IDEState *s)
         put_le16(p + 110, s->wwn >> 16);
         put_le16(p + 111, s->wwn);
     }
+    if (s->ncq_queues) {
+        /*
+         * 14=set to 1,
+         * 3=READ LOG DMA EXT/WRITE LOG DMA EXT (GPL DMA) supported
+         */
+        put_le16(p + 119, (1 << 14) | (1 << 3));
+        /* 14=set to 1, 3=GPL DMA enabled */
+        put_le16(p + 120, (1 << 14) | (1 << 3));
+    }
     if (dev && dev->conf.discard_granularity) {
         put_le16(p + 169, 1); /* TRIM support */
     }
@@ -1034,6 +1046,20 @@ void ide_start_dma(IDEState *s, BlockCompletionFunc *cb)
     }
 }
 
+static void ide_buffer_dma_cb(void *opaque, int ret)
+{
+    IDEState *s = opaque;
+
+    /*
+     * The data was generated synchronously into the I/O buffer before the
+     * transfer was started, so there is never a block I/O error to handle.
+     */
+    s->bus->dma->ops->rw_buf(s->bus->dma, 1);
+    s->status = READY_STAT | SEEK_STAT;
+    ide_bus_set_irq(s->bus);
+    ide_set_inactive(s, false);
+}
+
 static void ide_sector_write(IDEState *s);
 
 static void ide_sector_write_timer_cb(void *opaque)
@@ -1626,6 +1652,86 @@ static bool cmd_write_dma(IDEState *s, uint8_t cmd)
     return false;
 }
 
+/*
+ * Fill the I/O buffer with the General Purpose Logging data requested by a
+ * READ LOG EXT / READ LOG DMA EXT command and return the number of bytes to
+ * transfer, or a negative value if the command must be aborted (ACS-6 7.25).
+ */
+static int ide_read_log(IDEState *s)
+{
+    uint8_t log_address = s->sector;
+    uint16_t page = s->lcyl | ((uint16_t)s->hob_lcyl << 8);
+    uint32_t count = s->nsector; /* LOG PAGE COUNT, in 512-byte pages */
+    uint16_t log_size;
+
+    switch (log_address) {
+    case IDE_GPL_LOG_DIRECTORY:
+        log_size = 1;
+        break;
+    default:
+        /* Log (or its associated feature set) not supported (ACS-6 7.25.5). */
+        return -1;
+    }
+
+    /*
+     * A LOG PAGE COUNT of zero is invalid, and the requested pages must lie
+     * within the log as reported by the General Purpose Log Directory
+     * (ACS-6 7.25.5). The callers turn a zero COUNT into 65536, which the
+     * range check rejects; checking for zero guards a caller that does not.
+     */
+    if (count == 0 || page >= log_size || count > log_size - page) {
+        return -1;
+    }
+
+    switch (log_address) {
+    case IDE_GPL_LOG_DIRECTORY:
+        /* General Purpose Log Directory (ACS-6 9.2) */
+        memset(s->io_buffer, 0, count * 512);
+        /* word 0: General Purpose Logging Version */
+        put_le16((uint16_t *)s->io_buffer, 0x0001);
+        break;
+    }
+
+    return count * 512;
+}
+
+/* READ LOG EXT (PIO) and READ LOG DMA EXT, both 48-bit GPL commands */
+static bool cmd_read_log(IDEState *s, uint8_t cmd)
+{
+    bool dma = (cmd == WIN_READ_LOG_DMA_EXT);
+    int size;
+
+    if (!s->blk) {
+        ide_abort_command(s);
+        return true;
+    }
+
+    /* These commands are always 48-bit; COUNT holds the LOG PAGE COUNT. */
+    ide_cmd_lba48_transform(s, 1);
+
+    trace_ide_read_log(s, s->sector, s->lcyl | ((uint16_t)s->hob_lcyl << 8),
+                       s->nsector, dma ? "dma" : "pio");
+
+    size = ide_read_log(s);
+    if (size < 0) {
+        ide_abort_command(s);
+        return true;
+    }
+
+    if (dma) {
+        s->dma_cmd = IDE_DMA_READ_LOG;
+        s->io_buffer_index = 0;
+        s->io_buffer_size = size;
+        ide_start_dma(s, ide_buffer_dma_cb);
+        return false;
+    }
+
+    s->status = READY_STAT | SEEK_STAT;
+    ide_transfer_start(s, s->io_buffer, size, ide_transfer_stop);
+    ide_bus_set_irq(s->bus);
+    return false;
+}
+
 static bool cmd_flush_cache(IDEState *s, uint8_t cmd)
 {
     ide_flush_cache(s);
@@ -2107,6 +2213,7 @@ abort_cmd:
 
 /* Set the Disk Seek Completed status bit during completion */
 #define SET_DSC (1u << 8)
+#define AHCI_ONLY (1u << 9)
 
 /* See ACS-2 T13/2015-D Table B.2 Command codes */
 static const struct {
@@ -2125,6 +2232,8 @@ static const struct {
     [WIN_READDMA_EXT]             = { cmd_read_dma, HD_CFA_OK },
     [WIN_READ_NATIVE_MAX_EXT]     = { cmd_read_native_max, HD_CFA_OK | SET_DSC },
     [WIN_MULTREAD_EXT]            = { cmd_read_multiple, HD_CFA_OK },
+    [WIN_READ_LOG_EXT]            = { cmd_read_log, HD_OK | AHCI_ONLY },
+    [WIN_READ_LOG_DMA_EXT]        = { cmd_read_log, HD_OK | AHCI_ONLY },
     [WIN_WRITE]                   = { cmd_write_pio, HD_CFA_OK },
     [WIN_WRITE_ONCE]              = { cmd_write_pio, HD_CFA_OK },
     [WIN_WRITE_EXT]               = { cmd_write_pio, HD_CFA_OK },
@@ -2176,7 +2285,8 @@ static const struct {
 static bool ide_cmd_permitted(IDEState *s, uint32_t cmd)
 {
     return cmd < ARRAY_SIZE(ide_cmd_table)
-        && (ide_cmd_table[cmd].flags & (1u << s->drive_kind));
+        && (ide_cmd_table[cmd].flags & (1u << s->drive_kind))
+        && (s->ncq_queues || !(ide_cmd_table[cmd].flags & AHCI_ONLY));
 }
 
 void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 094772209d..389e15049e 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -81,7 +81,7 @@
 /* READ STREAM DMA EXT                  0x2A */
 /* READ STREAM EXT                      0x2B */
 /* reserved                             0x2C..0x2E */
-/* READ LOG EXT                         0x2F */
+#define WIN_READ_LOG_EXT                0x2F /* 48-Bit */
 #define WIN_WRITE                       0x30 /* 28-Bit */
 #define WIN_WRITE_ONCE                  0x31 /* 28-Bit w/o retries, obsolete since ATA5 */
 /* obsolete since ATA4                  0x32..0x33 */
@@ -104,7 +104,7 @@
 /* reserved                             0x43..0x44 */
 /* WRITE UNCORRECTABLE EXT              0x45 */
 /* reserved                             0x46 */
-/* READ LOG DMA EXT                     0x47 */
+#define WIN_READ_LOG_DMA_EXT            0x47 /* 48-Bit */
 /* reserved                             0x48..0x4F */
 /* obsolete since ATA4                  0x50 */
 /* CONFIGURE STREAM                     0x51 */
@@ -207,6 +207,12 @@
 /* feature values for Data Set Management */
 #define DSM_TRIM                        0x01
 
+/*
+ * Log addresses for the General Purpose Logging feature set, accessed via
+ * READ LOG EXT / READ LOG DMA EXT (see ACS-6 9.1 table 222).
+ */
+#define IDE_GPL_LOG_DIRECTORY           0x00 /* General Purpose Log Directory */
+
 #if (IDE_DMA_BUF_SECTORS < MAX_MULT_SECTORS)
 #error "IDE_DMA_BUF_SECTORS must be bigger or equal to MAX_MULT_SECTORS"
 #endif
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index c44eec6c58..102f39436c 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -17,6 +17,7 @@ ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of buffered re
 ide_cancel_dma_sync_remaining(void) "draining all remaining requests"
 ide_sector_read(int64_t sector_num, int nsectors) "sector=%"PRId64" nsectors=%d"
 ide_sector_write(int64_t sector_num, int nsectors) "sector=%"PRId64" nsectors=%d"
+ide_read_log(void *s, uint8_t log, uint16_t page, uint32_t count, const char *kind) "IDEState %p; log=0x%02x page=%u count=%u %s"
 ide_reset(void *s) "IDEstate %p"
 ide_bus_reset_aio(void) "aio_cancel"
 ide_dma_cb(void *s, int64_t sector_num, int n, const char *dma) "IDEState %p; sector_num=%"PRId64" n=%d cmd=%s"
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index f5eaaf68e6..258b216b44 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -47,6 +47,7 @@ enum ide_dma_cmd {
     IDE_DMA_WRITE,
     IDE_DMA_TRIM,
     IDE_DMA_ATAPI,
+    IDE_DMA_READ_LOG,
     IDE_DMA__COUNT
 };
 
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 2b668ea708..8ff30616d5 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1055,6 +1055,55 @@ static void test_specify(void)
     ahci_shutdown(ahci);
 }
 
+/*
+ * Exercise the General Purpose Logging feature set via READ LOG EXT (PIO) or
+ * READ LOG DMA EXT. Reads are performed one log page at a time so the same
+ * helper can drive both the PIO and DMA variants.
+ */
+static void ahci_test_read_log(AHCIQState *ahci, uint8_t read_log_cmd)
+{
+    uint16_t id[256];
+    uint16_t dir[256];
+    unsigned px;
+
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+
+    /*
+     * The device must advertise the GPL feature set (IDENTIFY word 84/87) and
+     * READ LOG DMA EXT support (word 86 bit 15 makes word 119 valid; word 119
+     * bit 3 = GPL DMA supported).
+     */
+    ahci_io(ahci, px, CMD_IDENTIFY, &id, 512, 0);
+    g_assert_cmphex(le16_to_cpu(id[84]) & (1 << 5), ==, (1 << 5));
+    g_assert_cmphex(le16_to_cpu(id[87]) & (1 << 5), ==, (1 << 5));
+    g_assert_cmphex(le16_to_cpu(id[86]) & (1 << 15), ==, (1 << 15));
+    g_assert_cmphex(le16_to_cpu(id[119]) & (1 << 3), ==, (1 << 3));
+
+    /* General Purpose Log Directory (log address 00h, page 0). */
+    ahci_io(ahci, px, read_log_cmd, &dir, 512, 0x00);
+    /* word 0: General Purpose Logging Version */
+    g_assert_cmphex(le16_to_cpu(dir[0]), ==, 0x0001);
+}
+
+static void test_read_log_dma(void)
+{
+    AHCIQState *ahci;
+
+    ahci = ahci_boot_and_enable(NULL);
+    ahci_test_read_log(ahci, CMD_READ_LOG_DMA_EXT);
+    ahci_shutdown(ahci);
+}
+
+static void test_read_log_pio(void)
+{
+    AHCIQState *ahci;
+
+    ahci = ahci_boot_and_enable(NULL);
+    ahci_test_read_log(ahci, CMD_READ_LOG_EXT);
+    ahci_shutdown(ahci);
+}
+
 /**
  * Fragmented DMA test: Perform a standard 4K DMA read/write
  * test, but make sure the physical regions are fragmented to
@@ -2511,6 +2560,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/hba_spec",   test_hba_spec);
     qtest_add_func("/ahci/hba_enable", test_hba_enable);
     qtest_add_func("/ahci/identify",   test_identify);
+    qtest_add_func("/ahci/io/dma/read_log", test_read_log_dma);
+    qtest_add_func("/ahci/io/pio/read_log", test_read_log_pio);
 
     for (i = MODE_BEGIN; i < NUM_MODES; i++) {
         for (j = ADDR_MODE_BEGIN; j < NUM_ADDR_MODES; j++) {
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index cf109b0799..d82efdfdda 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -746,6 +746,9 @@ static void test_identify(void)
 
     /* Write cache enabled bit */
     assert_bit_set(buf[85], 0x20);
+    assert_bit_clear(buf[84], 0x20);
+    assert_bit_clear(buf[86], 0x8000);
+    g_assert_cmphex(buf[119], ==, 0);
 
     ide_test_quit(qts);
     free_pci_device(dev);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 53a98bd6cb..e64fcade36 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -67,6 +67,10 @@ AHCICommandProp ahci_command_properties[] = {
                                  .lba48 = true, .write = true },
     { .cmd = CMD_IDENTIFY,       .data = true,  .pio = true,
                                  .size = 512,   .read = true },
+    { .cmd = CMD_READ_LOG_EXT,   .data = true,  .pio = true,
+                                 .lba48 = true, .read = true },
+    { .cmd = CMD_READ_LOG_DMA_EXT, .data = true, .dma = true,
+                                 .lba48 = true, .read = true },
     { .cmd = READ_FPDMA_QUEUED,  .data = true,  .dma = true,
                                  .lba48 = true, .read = true, .ncq = true },
     { .cmd = WRITE_FPDMA_QUEUED, .data = true,  .dma = true,
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index f098c91b47..9c4195eee9 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -280,6 +280,8 @@ enum {
     CMD_FLUSH_CACHE    = 0xE7,
     CMD_INIT_DP        = 0x91, /* INITIALIZE DEVICE PARAMETERS */
     CMD_IDENTIFY       = 0xEC,
+    CMD_READ_LOG_EXT     = 0x2F,
+    CMD_READ_LOG_DMA_EXT = 0x47,
     CMD_PACKET         = 0xA0,
     CMD_PACKET_ID      = 0xA1,
     /* NCQ */
-- 
2.56.1


