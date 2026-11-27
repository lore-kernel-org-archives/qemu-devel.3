Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A4606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwEY30oG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Ob-0002FI-Uo; Fri, 27 Nov 2026 14:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nu-0001sa-Ix; Fri, 27 Nov 2026 14:13:28 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nq-0007AI-Th; Fri, 27 Nov 2026 14:13:26 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BAC9140F67;
 Fri, 27 Nov 2026 19:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE11F0089C;
 Fri, 27 Nov 2026 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806801;
 bh=PGSOanl9FMlh1JHYI/Ey4bBrmsXYkjx2r5nfBWUKPbM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RwEY30oGoGXnWj4n+a7ywnJU5L3SUNkuHvxjwp/wTKHFihuI4B809VKTvH4OIRqfa
 zByYV5MxF/pBY4GQvmlu6vQ2mckxFIJGvMj1N112eom2TKXCABNDOx82OGIjWk442K
 4rUmlpC7X5yj7HiLq34P26Hg8vdBoiFecf7K5yDwfMltC44UvhU0w7qUWlxUZd8xU9
 /14ZoZF2cqFoRUVKRheMYxjrIuLhQWjbDxyKnSeRFl7bJAxn7tZuqsd7G9I+VHbkMP
 HQ6lmSluKDjL0u0U3Gh4bZL62rgzM0AKbiQdXKVIfQjc2eC9LqmbVm2cXy4ljIxAcN
 hpmcckZtNx58A==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 09/13] hw/ide: implement the NCQ Command Error log (10h)
Date: Fri, 27 Nov 2026 20:12:44 +0100
Message-ID: <20261127191250.3298004-10-cassel@kernel.org>
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

As per ACS-6 9.15, when an NCQ command fails, the device enter the NCQ
error state, and the host shall read the NCQ Command Error log (10h) to
find out which command that failed.

The NCQ Command Error log is a mandatory part of the NCQ feature set.
QEMU did not implement this mandatory part, making it impossible for the
host to know which command that failed.

Record the failed command in the log, with its sense data through NCQ
Autosense. Report INVALID COMMAND OPERATION CODE for an unsupported NCQ
command, INVALID FIELD IN CDB for an invalid RECEIVE FPDMA QUEUED, and
none for a failed read or write.

A PRDT that is too short for the transfer is detected by the HBA, not
the device (AHCI 1.3.1 6.1.5), so for that case, the command is only
released and OFS raised, without recording an error.

Once the device has entered the NCQ error state (see DFPDMAQ11 to
DFPDMAQ15), the outstanding NCQ commands neither complete nor fail, and
new commands are aborted (except for a READ LOG of the NCQ Command Error
log) or the port is reset.

Add qtests for the log contents, the error state and the sense data.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci.c            |  87 ++++++++++++---
 hw/ide/core.c            | 145 +++++++++++++++++++++++-
 hw/ide/ide-internal.h    |   9 ++
 include/hw/ide/ide-dev.h |  17 +++
 tests/qtest/ahci-test.c  | 231 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 473 insertions(+), 16 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d74d185607..a1fe0cc72d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -779,9 +779,9 @@ static void ahci_unmap_clb_address(AHCIDevice *ad)
     ad->lst = NULL;
 }
 
-static void ahci_write_fis_sdb(AHCIState *s, NCQTransferState *ncq_tfs)
+static void ahci_write_fis_sdb(AHCIDevice *ad, bool irq)
 {
-    AHCIDevice *ad = ncq_tfs->drive;
+    AHCIState *s = ad->hba;
     AHCIPortRegs *pr = &ad->port_regs;
     IDEState *ide_state;
     SDBFIS *sdb_fis;
@@ -796,7 +796,7 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTransferState *ncq_tfs)
 
     sdb_fis->type = SATA_FIS_TYPE_SDB;
     /* Interrupt pending & Notification bit */
-    sdb_fis->flags = 0x40; /* Interrupt bit, always 1 for NCQ */
+    sdb_fis->flags = irq ? 0x40 : 0; /* Interrupt bit */
     sdb_fis->status = ide_state->status & 0x77;
     sdb_fis->error = ide_state->error;
     /* update SAct field in SDB_FIS */
@@ -1021,12 +1021,17 @@ out:
     return r;
 }
 
-static void ncq_err(NCQTransferState *ncq_tfs)
+static void ncq_err(NCQTransferState *ncq_tfs, SCSISense sense)
 {
     IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
 
-    ide_state->error = ABRT_ERR;
-    ide_state->status = READY_STAT | ERR_STAT;
+    /*
+     * Record the failure (status/error registers and the NCQ Command Error
+     * log, 10h) so that the host can retrieve it after being notified of the
+     * error via the Set Device Bits FIS.
+     */
+    ide_ncq_cmd_error(ide_state, ncq_tfs->tag, ncq_tfs->lba,
+                      ncq_tfs->sector_count, sense);
     qemu_sglist_destroy(&ncq_tfs->sglist);
     ncq_tfs->used = 0;
 }
@@ -1040,7 +1045,7 @@ static void ncq_finish(NCQTransferState *ncq_tfs)
         ncq_tfs->drive->finished |= (1 << ncq_tfs->tag);
     }
 
-    ahci_write_fis_sdb(ncq_tfs->drive->hba, ncq_tfs);
+    ahci_write_fis_sdb(ncq_tfs->drive, true);
 
     trace_ncq_finish(ncq_tfs->drive->hba, ncq_tfs->drive->port_no,
                      ncq_tfs->tag);
@@ -1058,6 +1063,17 @@ static void ncq_cb(void *opaque, int ret)
 
     ncq_tfs->aiocb = NULL;
 
+    /*
+     * The device stopped processing NCQ commands when another one failed
+     * (SATA 3.5a DFPDMAQ11): this one neither completes nor fails.
+     */
+    if (ide_state->ncq_err.active) {
+        block_acct_failed(blk_get_stats(ide_state->blk), &ncq_tfs->acct);
+        qemu_sglist_destroy(&ncq_tfs->sglist);
+        ncq_tfs->used = 0;
+        return;
+    }
+
     if (ret < 0) {
         bool is_read = ncq_tfs->cmd == READ_FPDMA_QUEUED;
         BlockErrorAction action = blk_get_error_action(ide_state->blk,
@@ -1066,7 +1082,7 @@ static void ncq_cb(void *opaque, int ret)
             ncq_tfs->halt = true;
             ide_state->bus->error_status = IDE_RETRY_HBA;
         } else if (action == BLOCK_ERROR_ACTION_REPORT) {
-            ncq_err(ncq_tfs);
+            ncq_err(ncq_tfs, SENSE_CODE(NO_SENSE));
         }
         blk_error_action(ide_state->blk, action, is_read, -ret);
     } else {
@@ -1114,7 +1130,7 @@ static void execute_ncq_receive_fpdma_queued(NCQTransferState *ncq_tfs)
                                 ncq_tfs->sector_count);
 
         if (size < 0) {
-            ncq_err(ncq_tfs);
+            ncq_err(ncq_tfs, SENSE_CODE(INVALID_FIELD));
             break;
         }
         dma_buf_read(ide_state->io_buffer, size, NULL, &ncq_tfs->sglist,
@@ -1123,7 +1139,7 @@ static void execute_ncq_receive_fpdma_queued(NCQTransferState *ncq_tfs)
         break;
     }
     default:
-        ncq_err(ncq_tfs);
+        ncq_err(ncq_tfs, SENSE_CODE(INVALID_FIELD));
         break;
     }
 
@@ -1168,7 +1184,7 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
     default:
         trace_execute_ncq_command_unsup(ad->hba, port,
                                         ncq_tfs->tag, ncq_tfs->cmd);
-        ncq_err(ncq_tfs);
+        ncq_err(ncq_tfs, SENSE_CODE(INVALID_OPCODE));
         ncq_finish(ncq_tfs);
     }
 }
@@ -1184,6 +1200,18 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
     size_t size;
 
     g_assert(is_ncq(ncq_fis->command));
+
+    /*
+     * After an NCQ command failed, any other command is aborted (SATA 3.5a
+     * DFPDMAQ12, DFPDMAQ13), until the host reads the NCQ Command Error log.
+     */
+    if (ad->port.ifs[0].ncq_err.active) {
+        ad->port.ifs[0].status = READY_STAT | ERR_STAT;
+        ad->port.ifs[0].error = ABRT_ERR;
+        ahci_write_fis_d2h(ad, false);
+        return;
+    }
+
     if (ncq_tfs->used) {
         /* error - already in use */
         qemu_log_mask(LOG_GUEST_ERROR, "%s: tag %d already used\n",
@@ -1226,8 +1254,15 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
                    ((uint64_t)ncq_fis->lba1 << 8) |
                    (uint64_t)ncq_fis->lba0;
 
-    /* Accepting an NCQ command makes the sense data unavailable (ACS-6 4.25) */
-    ad->port.ifs[0].sense_data_avail = false;
+    /*
+     * Accepting an NCQ command makes the sense data unavailable, unless it
+     * reads the NCQ Command Error log (ACS-6 4.25).
+     */
+    if (!(ncq_fis->command == RECEIVE_FPDMA_QUEUED &&
+          ncq_tfs->subcmd == RECEIVE_FPDMA_READ_LOG_DMA_EXT &&
+          (ncq_tfs->lba & 0xff) == IDE_GPL_LOG_NCQ_CMD_ERROR)) {
+        ad->port.ifs[0].sense_data_avail = false;
+    }
     ncq_tfs->tag = tag;
 
     /* Sanity-check the NCQ packet */
@@ -1260,7 +1295,12 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
         error_report("ahci: PRDT length for NCQ command (0x" DMA_ADDR_FMT ") "
                      "is smaller than the requested size (0x%zx)",
                      ncq_tfs->sglist.size, size);
-        ncq_err(ncq_tfs);
+        /*
+         * The HBA detected the overflow, not the device (AHCI 1.3.1 6.1.5):
+         * release the command without recording an NCQ error.
+         */
+        qemu_sglist_destroy(&ncq_tfs->sglist);
+        ncq_tfs->used = 0;
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_OFS);
         return;
     } else if (ncq_tfs->sglist.size != size) {
@@ -1394,6 +1434,25 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
      */
     ad->busy_slot = slot;
 
+    /*
+     * Reading the NCQ Command Error log ends the NCQ error state: the device
+     * discards the queued commands, and reports this with a Set Device Bits
+     * FIS that has ERR cleared and all ACT bits set, but no interrupt (SATA
+     * 3.5a DFPDMAQ14, DFPDMAQ15; IDENTIFY DEVICE word 76 bit 15 is set for
+     * NCQ devices, which allows READ LOG DMA EXT).
+     */
+    if (ide_state->ncq_err.active &&
+        (cmd_fis[2] == WIN_READ_LOG_EXT ||
+         cmd_fis[2] == WIN_READ_LOG_DMA_EXT) &&
+        cmd_fis[4] == IDE_GPL_LOG_NCQ_CMD_ERROR) {
+        ahci_cancel_ncq_requests(ad);
+        ide_state->ncq_err.active = false;
+        ide_state->status = READY_STAT | SEEK_STAT;
+        ide_state->error = 0;
+        ad->finished = 0xffffffff;
+        ahci_write_fis_sdb(ad, false);
+    }
+
     /* We're ready to process the command in FIS byte 2. */
     ide_bus_exec_cmd(&s->dev[port].port, cmd_fis[2]);
 }
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 2d8bca0762..cc38a3ef65 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -204,6 +204,8 @@ static void ide_identify(IDEState *s)
         put_le16(p + 76, (1 << 15) | (1 << 8));
         /* 6=SEND AND RECEIVE QUEUED COMMANDS supported (SATA NCQ log 13h) */
         put_le16(p + 77, (1 << 6));
+        /* SATA features supported: 7=NCQ Autosense (sense in NCQ error log) */
+        put_le16(p + 78, (1 << 7));
     }
 
     put_le16(p + 80, 0xf0); /* ata3 -> ata6 supported */
@@ -595,6 +597,42 @@ void ide_abort_command(IDEState *s)
     ide_abort_command_with_sense(s, SENSE_CODE(NO_SENSE));
 }
 
+/*
+ * Record the most recent NCQ command failure so that it can be reported
+ * through the NCQ Command Error log (10h) when the host reads it. Unlike the
+ * Sense Data Reporting feature set, the NCQ Autosense sense data is always
+ * recorded (its presence in the log is gated on NCQ Autosense support).
+ */
+void ide_ncq_cmd_error(IDEState *s, uint8_t tag, uint64_t lba,
+                       uint16_t count, SCSISense sense)
+{
+    s->status = READY_STAT | ERR_STAT;
+    s->error = ABRT_ERR;
+
+    /*
+     * The device processes no other command until the host reads the log or
+     * resets the device (SATA 3.5a DFPDMAQ11, DFPDMAQ13).
+     */
+    s->ncq_err.active = true;
+    s->ncq_err.valid = true;
+    s->ncq_err.tag = tag;
+    /*
+     * The STATUS field in the log advertises SENSE DATA AVAILABLE (ACS-6 6.2.9)
+     * if there is sense data, so that a host supporting NCQ Autosense reads the
+     * sense key / ASC / ASCQ from the log (libata only does so when this bit
+     * is set). NO SENSE means that there is none (ACS-6 6.8.31).
+     */
+    s->ncq_err.status = s->status |
+                        (sense.key != NO_SENSE ? SENSE_DATA_STAT : 0);
+    s->ncq_err.error = s->error;
+    s->ncq_err.device = 1 << 6; /* LBA addressing */
+    s->ncq_err.lba = lba;
+    s->ncq_err.count = count;
+    s->ncq_err.sense_key = sense.key;
+    s->ncq_err.asc = sense.asc;
+    s->ncq_err.ascq = sense.ascq;
+}
+
 static void ide_set_retry(IDEState *s)
 {
     s->bus->retry_unit = s->unit;
@@ -1472,6 +1510,7 @@ static void ide_reset(IDEState *s, IDEResetKind kind)
      * covers COMRESET, which must not change it.
      */
     s->sense_data_avail = false;
+    s->ncq_err.active = false;
 
     s->lba48 = 0;
 
@@ -1882,6 +1921,54 @@ static void ide_fill_identify_device_log(IDEState *s, uint16_t page,
     }
 }
 
+/*
+ * Fill the NCQ Command Error log (Log Address 10h) - ACS-6 9.15, SATA 3.5a
+ * 13.7.4. Page 0 reports the most recent NCQ command failure.
+ */
+static void ide_fill_ncq_cmd_error_log(IDEState *s, uint16_t page,
+                                       uint32_t count)
+{
+    uint32_t p;
+
+    memset(s->io_buffer, 0, count * 512);
+
+    for (p = 0; p < count; p++) {
+        uint8_t *buf = s->io_buffer + p * 512;
+        unsigned int sum = 0;
+        int i;
+
+        if (page + p == 0) {
+            if (s->ncq_err.valid) {
+                /* NQ=0, DEFERRED=0, NCQ TAG field valid (ACS-6 9.15.2). */
+                buf[0] = s->ncq_err.tag & 0x1f;
+                buf[2] = s->ncq_err.status;
+                buf[3] = s->ncq_err.error;
+                buf[4] = s->ncq_err.lba;
+                buf[5] = s->ncq_err.lba >> 8;
+                buf[6] = s->ncq_err.lba >> 16;
+                buf[7] = s->ncq_err.device;
+                buf[8] = s->ncq_err.lba >> 24;
+                buf[9] = s->ncq_err.lba >> 32;
+                buf[10] = s->ncq_err.lba >> 40;
+                buf[12] = s->ncq_err.count;
+                buf[13] = s->ncq_err.count >> 8;
+                buf[14] = s->ncq_err.sense_key;
+                buf[15] = s->ncq_err.asc;
+                buf[16] = s->ncq_err.ascq;
+            } else {
+                /* NQ=1: the NCQ TAG field is not valid (ACS-6 9.15.3). */
+                buf[0] = 1 << 7;
+            }
+        }
+
+        /* Each page ends with a checksum making its bytes sum to zero. */
+        for (i = 0; i < 511; i++) {
+            sum += buf[i];
+        }
+        buf[511] = -sum;
+    }
+}
+
 /*
  * Fill the I/O buffer with the General Purpose Logging data selected by
  * log_address, page and count (the LOG PAGE COUNT, in 512-byte pages) and
@@ -1898,6 +1985,12 @@ int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
     case IDE_GPL_LOG_DIRECTORY:
         log_size = 1;
         break;
+    case IDE_GPL_LOG_NCQ_CMD_ERROR:
+        if (!s->ncq_queues) {
+            return -1;
+        }
+        log_size = 1;
+        break;
     case IDE_GPL_LOG_NCQ_SEND_RECV:
         /* Only meaningful for devices that support the NCQ feature set. */
         if (!s->ncq_queues) {
@@ -1933,6 +2026,7 @@ int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
         put_le16((uint16_t *)s->io_buffer + IDE_GPL_LOG_IDENTIFY_DEVICE,
                  IDE_GPL_LOG_IDENTIFY_DEVICE_LEN);
         if (s->ncq_queues) {
+            put_le16((uint16_t *)s->io_buffer + IDE_GPL_LOG_NCQ_CMD_ERROR, 1);
             put_le16((uint16_t *)s->io_buffer + IDE_GPL_LOG_NCQ_SEND_RECV, 1);
         }
         break;
@@ -1946,6 +2040,9 @@ int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
          */
         stl_le_p(s->io_buffer + 8, (1 << 1) | (1 << 0));
         break;
+    case IDE_GPL_LOG_NCQ_CMD_ERROR:
+        ide_fill_ncq_cmd_error_log(s, page, count);
+        break;
     case IDE_GPL_LOG_IDENTIFY_DEVICE:
         ide_fill_identify_device_log(s, page, count);
         break;
@@ -2599,11 +2696,14 @@ static bool ide_cmd_permitted(IDEState *s, uint32_t cmd)
 
 /*
  * Whether the sense data stays available once this command is accepted
- * (ACS-6 4.25): REQUEST SENSE DATA EXT returns it.
+ * (ACS-6 4.25): REQUEST SENSE DATA EXT returns it, and reading the NCQ
+ * Command Error log does not discard it.
  */
 static bool ide_cmd_keeps_sense_data(IDEState *s, uint8_t cmd)
 {
-    return cmd == WIN_REQUEST_SENSE_DATA_EXT;
+    return cmd == WIN_REQUEST_SENSE_DATA_EXT ||
+           ((cmd == WIN_READ_LOG_EXT || cmd == WIN_READ_LOG_DMA_EXT) &&
+            s->sector == IDE_GPL_LOG_NCQ_CMD_ERROR);
 }
 
 void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
@@ -2627,6 +2727,18 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
         }
     }
 
+    /*
+     * After an NCQ command failed, any other command is aborted (SATA 3.5a
+     * DFPDMAQ13). The HBA ends that state before issuing a read of the NCQ
+     * Command Error log.
+     */
+    if (s->ncq_err.active) {
+        ide_abort_command(s);
+        ide_cmd_done(s);
+        ide_bus_set_irq(s->bus);
+        return;
+    }
+
     if (!ide_cmd_permitted(s, val)) {
         ide_abort_command_with_sense(s, SENSE_CODE(INVALID_OPCODE));
         ide_bus_set_irq(s->bus);
@@ -3497,6 +3609,34 @@ static const VMStateDescription vmstate_ide_sense_data = {
     }
 };
 
+static bool ide_ncq_err_needed(void *opaque)
+{
+    IDEState *s = opaque;
+
+    return s->ncq_err.valid;
+}
+
+static const VMStateDescription vmstate_ide_ncq_err = {
+    .name = "ide_drive/ncq_err",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ide_ncq_err_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(ncq_err.valid, IDEState),
+        VMSTATE_BOOL(ncq_err.active, IDEState),
+        VMSTATE_UINT8(ncq_err.tag, IDEState),
+        VMSTATE_UINT8(ncq_err.status, IDEState),
+        VMSTATE_UINT8(ncq_err.error, IDEState),
+        VMSTATE_UINT8(ncq_err.device, IDEState),
+        VMSTATE_UINT8(ncq_err.sense_key, IDEState),
+        VMSTATE_UINT8(ncq_err.asc, IDEState),
+        VMSTATE_UINT8(ncq_err.ascq, IDEState),
+        VMSTATE_UINT16(ncq_err.count, IDEState),
+        VMSTATE_UINT64(ncq_err.lba, IDEState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ide_drive_pio_state = {
     .name = "ide_drive/pio_state",
     .version_id = 1,
@@ -3553,6 +3693,7 @@ const VMStateDescription vmstate_ide_drive = {
         &vmstate_ide_tray_state,
         &vmstate_ide_atapi_gesn_state,
         &vmstate_ide_sense_data,
+        &vmstate_ide_ncq_err,
         NULL
     }
 };
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 0fb4776356..b39b5460c3 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -8,6 +8,7 @@
  */
 
 #include "hw/ide/ide-bus.h"
+#include "scsi/utils.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
@@ -213,6 +214,7 @@
  * READ LOG EXT / READ LOG DMA EXT (see ACS-6 9.1 table 222).
  */
 #define IDE_GPL_LOG_DIRECTORY           0x00 /* General Purpose Log Directory */
+#define IDE_GPL_LOG_NCQ_CMD_ERROR       0x10 /* NCQ Command Error log */
 #define IDE_GPL_LOG_NCQ_SEND_RECV       0x13 /* SATA NCQ Send and Receive log */
 #define IDE_GPL_LOG_IDENTIFY_DEVICE     0x30 /* IDENTIFY DEVICE data log */
 
@@ -456,6 +458,13 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val);
 int ide_read_log(IDEState *s, uint8_t log_address, uint16_t page,
                  uint32_t count);
 
+/*
+ * Record the most recent NCQ command failure, with its sense data, so that it
+ * can be reported through the NCQ Command Error log (10h).
+ */
+void ide_ncq_cmd_error(IDEState *s, uint8_t tag, uint64_t lba,
+                       uint16_t count, SCSISense sense);
+
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func);
 bool ide_transfer_start_norecurse(IDEState *s, uint8_t *buf, int size,
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 01b7952957..8cdce3b517 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -51,6 +51,22 @@ enum ide_dma_cmd {
     IDE_DMA__COUNT
 };
 
+/* The NCQ Command Error log (10h) and the NCQ error state */
+typedef struct IDENCQError {
+    bool valid;         /* the log holds a failed NCQ command */
+    /* NCQ error: waiting for log 10h or a reset (SATA 3.5a DFPDMAQ13) */
+    bool active;
+    uint8_t tag;
+    uint8_t status;
+    uint8_t error;
+    uint8_t device;
+    uint8_t sense_key;
+    uint8_t asc;
+    uint8_t ascq;
+    uint16_t count;
+    uint64_t lba;
+} IDENCQError;
+
 /* NOTE: IDEState represents in fact one drive */
 struct IDEState {
     IDEBus *bus;
@@ -100,6 +116,7 @@ struct IDEState {
     uint8_t ascq;
     bool sense_data_enabled;
     bool sense_data_avail;
+    IDENCQError ncq_err;
     bool tray_open;
     bool tray_locked;
     uint8_t cdrom_changed;
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e7df8c9fc8..df9295906c 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1938,6 +1938,231 @@ static void test_ncq_read_log(void)
     ahci_shutdown(ahci);
 }
 
+/*
+ * A failed NCQ command is reported through the NCQ Command Error log (10h):
+ * the host is notified via the Set Device Bits FIS and then reads the log to
+ * learn which tag failed and why. Here an injected I/O error fails a WRITE
+ * FPDMA QUEUED. The error has no more specific reason, so the log has no
+ * sense data.
+ */
+static void test_ncq_cmd_error(void)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    uint16_t dir[256];
+    uint8_t *log;
+    uint64_t ptr;
+    unsigned px;
+    unsigned int sum = 0;
+    int i;
+
+    prepare_blkdebug_script(debug_path, "write_aio");
+    ahci = ahci_boot_and_enable("-drive file=blkdebug:%s:%s,if=none,id=drive0,"
+                                "format=%s,cache=writeback,"
+                                "rerror=report,werror=report "
+                                "-M q35 -device ide-hd,drive=drive0",
+                                debug_path, tmp_path, imgfmt);
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+
+    /* The NCQ Command Error log (10h) is advertised, one page long. */
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, dir, 512, 0x00);
+    g_assert_cmphex(le16_to_cpu(dir[0x10]), ==, 1);
+
+    /* An NCQ write of one sector at LBA 8 that fails with an I/O error. */
+    ptr = ahci_alloc(ahci, 512);
+    g_assert(ptr);
+    cmd = ahci_command_create(WRITE_FPDMA_QUEUED);
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_set_offset(cmd, 8);
+    ahci_command_expect_error(cmd, ATA_ERR_ABRT);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+
+    /* Read the NCQ Command Error log; page 0 records the failure. */
+    log = g_malloc0(512);
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, log, 512, 0x10);
+
+    g_assert_cmphex(log[0] & (1 << 7), ==, 0); /* NQ=0: NCQ tag is valid */
+    g_assert_cmphex(log[2], ==, 0x41);         /* STATUS: DRDY | ERR */
+    g_assert_cmphex(log[3], ==, 0x04);         /* ERROR: ABRT */
+    g_assert_cmphex(log[4], ==, 8);            /* LBA (7:0) */
+    g_assert_cmphex(log[12], ==, 1);           /* COUNT (7:0) */
+    /* No sense data: SENSE KEY, ASC and ASCQ are zero. */
+    g_assert_cmphex(log[14], ==, 0x00);
+    g_assert_cmphex(log[15], ==, 0x00);
+    g_assert_cmphex(log[16], ==, 0x00);
+    for (i = 0; i < 512; i++) {
+        sum += log[i];
+    }
+    g_assert_cmphex(sum & 0xff, ==, 0);        /* checksum: bytes sum to zero */
+
+    g_free(log);
+    ahci_shutdown(ahci);
+}
+
+/* The sense key that REQUEST SENSE DATA EXT returns (LBA 19:16) */
+static uint8_t ahci_sense_key(AHCIQState *ahci, unsigned px)
+{
+    return ahci_nodata_cmd(ahci, px, CMD_REQ_SENSE_DATA, 0, 0, 0).lba_lo[2] &
+           0x0f;
+}
+
+/* READ LOG DMA EXT of the NCQ Command Error log (10h) */
+static void ahci_read_ncq_log(AHCIQState *ahci, unsigned px)
+{
+    uint8_t log[512];
+
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, log, 512, 0x10);
+}
+
+/*
+ * Reading the NCQ Command Error log does not make the sense data unavailable
+ * (ACS-6 4.25), with READ LOG DMA EXT or with RECEIVE FPDMA QUEUED.
+ */
+static void test_sense_data_ncq_log(void)
+{
+    AHCICommand *cmd;
+    uint64_t ptr;
+    unsigned px;
+    AHCIQState *ahci = ahci_boot_with_sense_data(&px);
+
+    ahci_read_ncq_log(ahci, px);
+    g_assert_cmphex(ahci_sense_key(ahci, px), ==, 0x05); /* ILLEGAL REQUEST */
+
+    ahci_nodata_cmd(ahci, px, CMD_SET_FEATURES, 0x47, 0, ATA_ERR_ABRT);
+    ahci_port_restart(ahci, px);
+    ptr = ahci_alloc(ahci, 512);
+    cmd = ahci_command_create(RECEIVE_FPDMA_QUEUED);
+    ahci_command_set_ncq_subcmd(cmd, 0x01);         /* READ LOG DMA EXT */
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_set_offset(cmd, 0x10);              /* LOG ADDRESS 10h */
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+    g_assert_cmphex(ahci_sense_key(ahci, px), ==, 0x05);
+
+    ahci_shutdown(ahci);
+}
+
+/* Accepting an NCQ command makes the sense data unavailable (ACS-6 4.25). */
+static void test_sense_data_ncq_cmd(void)
+{
+    uint8_t buf[512];
+    unsigned px;
+    AHCIQState *ahci = ahci_boot_with_sense_data(&px);
+
+    ahci_io(ahci, px, READ_FPDMA_QUEUED, buf, 512, 0);
+    g_assert_cmphex(ahci_sense_key(ahci, px), ==, 0);
+
+    ahci_shutdown(ahci);
+}
+
+/* Issue a 512-byte NCQ command that the device is expected to abort */
+static void ahci_ncq_expect_abort(AHCIQState *ahci, unsigned px, uint8_t op,
+                                  uint8_t subcmd, uint64_t lba, uint64_t ptr)
+{
+    AHCICommand *cmd = ahci_command_create(op);
+
+    if (subcmd) {
+        ahci_command_set_ncq_subcmd(cmd, subcmd);
+    }
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_set_offset(cmd, lba);
+    ahci_command_expect_error(cmd, ATA_ERR_ABRT);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+}
+
+/*
+ * After an NCQ command fails, the device processes no other command until the
+ * host reads the NCQ Command Error log or resets the device (SATA 3.5a
+ * DFPDMAQ11, DFPDMAQ13). Reading the log discards the queued commands with a
+ * Set Device Bits FIS that has ERR cleared and ACT set to FFFFFFFFh
+ * (DFPDMAQ15), after which commands are processed again.
+ */
+static void test_ncq_error_state(void)
+{
+    uint8_t buf[512], sdb[8];
+    AHCIQState *ahci;
+    uint64_t ptr;
+    unsigned px;
+
+    prepare_blkdebug_script(debug_path, "write_aio");
+    ahci = ahci_boot_and_enable("-drive file=blkdebug:%s:%s,if=none,id=drive0,"
+                                "format=%s,rerror=report,werror=report "
+                                "-M q35 -device ide-hd,drive=drive0",
+                                debug_path, tmp_path, imgfmt);
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+    ptr = ahci_alloc(ahci, 512);
+
+    /* A WRITE FPDMA QUEUED that fails with the injected I/O error */
+    ahci_ncq_expect_abort(ahci, px, WRITE_FPDMA_QUEUED, 0, 0, ptr);
+
+    /*
+     * Any other command is aborted: a non-NCQ command, an NCQ command, and
+     * an NCQ read of the NCQ Command Error log itself.
+     */
+    ahci_nodata_cmd(ahci, px, CMD_SET_FEATURES, 0x02, 0, ATA_ERR_ABRT);
+    ahci_ncq_expect_abort(ahci, px, READ_FPDMA_QUEUED, 0, 0, ptr);
+    ahci_ncq_expect_abort(ahci, px, RECEIVE_FPDMA_QUEUED, 0x01, 0x10, ptr);
+
+    /* READ LOG DMA EXT of the log reports the failed command ... */
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, buf, 512, 0x10);
+    g_assert_cmphex(buf[0] & (1 << 7), ==, 0);       /* NQ=0 */
+    /* ... after discarding the queued commands */
+    qtest_memread(ahci->parent->qts, ahci->port[px].fb + 0x58, sdb,
+                  sizeof(sdb));
+    g_assert_cmphex(sdb[0], ==, 0xa1);               /* Set Device Bits FIS */
+    g_assert_cmphex(sdb[1] & 0x40, ==, 0);           /* Interrupt bit */
+    g_assert_cmphex(sdb[2] & 0x01, ==, 0);           /* STATUS: ERR */
+    g_assert_cmphex(sdb[3], ==, 0);                  /* ERROR */
+    g_assert_cmphex((uint32_t)ldl_le_p(sdb + 4), ==, 0xffffffff); /* ACT */
+
+    /* Commands are processed again */
+    ahci_io(ahci, px, READ_FPDMA_QUEUED, buf, 512, 0);
+    ahci_nodata_cmd(ahci, px, CMD_SET_FEATURES, 0x02, 0, 0);
+
+    ahci_free(ahci, ptr);
+    ahci_shutdown(ahci);
+}
+
+/*
+ * IDENTIFY DEVICE data log page 04h (Current Settings) is supported, and
+ * reports whether the Sense Data Reporting feature set is enabled.
+ */
+static void test_sense_data_current_settings(void)
+{
+    uint8_t page[512];
+    uint64_t settings;
+    unsigned px;
+    AHCIQState *ahci = ahci_boot_with_sense_data(&px);
+
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, page, 512, 0x30);
+    g_assert_cmphex(page[8], ==, 8);                 /* number of entries */
+    g_assert_cmphex(page[13], ==, 0x04);             /* page 04h listed */
+
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, page, 512, 0x30 | (0x04 << 8));
+    g_assert_cmphex(page[2], ==, 0x04);              /* PAGE NUMBER */
+    memcpy(&settings, page + 8, sizeof(settings));
+    /* 63=valid, 10=SENSE DATA ENABLED */
+    g_assert_cmphex(le64_to_cpu(settings) & (1ULL << 63), ==, 1ULL << 63);
+    g_assert_cmphex(le64_to_cpu(settings) & (1ULL << 10), ==, 1ULL << 10);
+
+    ahci_shutdown(ahci);
+}
+
 static int prepare_iso(size_t size, unsigned char **buf, char **name)
 {
     g_autofree char *cdrom_path = NULL;
@@ -2808,6 +3033,12 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/io/ncq/simple", test_ncq_simple);
     qtest_add_func("/ahci/io/ncq/read_log", test_ncq_read_log);
+    qtest_add_func("/ahci/io/ncq/error", test_ncq_cmd_error);
+    qtest_add_func("/ahci/io/ncq/error_state", test_ncq_error_state);
+    qtest_add_func("/ahci/io/ncq/sense_data/log", test_sense_data_ncq_log);
+    qtest_add_func("/ahci/io/ncq/sense_data/cmd", test_sense_data_ncq_cmd);
+    qtest_add_func("/ahci/io/sense_data/current_settings",
+                   test_sense_data_current_settings);
     qtest_add_func("/ahci/migrate/ncq/simple", test_migrate_ncq);
     qtest_add_func("/ahci/io/ncq/retry", test_halted_ncq);
     qtest_add_func("/ahci/migrate/ncq/halted", test_migrate_halted_ncq);
-- 
2.56.1


