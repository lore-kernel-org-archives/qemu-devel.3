Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82751606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCD/+peE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Pj-0003qq-OI; Fri, 27 Nov 2026 14:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nq-0001qp-M7; Fri, 27 Nov 2026 14:13:22 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nn-0006xi-Uo; Fri, 27 Nov 2026 14:13:22 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B014B43259;
 Fri, 27 Nov 2026 19:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C151F00899;
 Fri, 27 Nov 2026 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806798;
 bh=MXLr2BgN6g0wofnlccPy2ARfsaXGggCj8CNKnrzWPHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CCD/+peET8E8BGPYOVRimn6cYVEfz+0eYRy76bdJdrA2JxBliMpwbAvLJdilxPSVN
 vchoIvBe2qbz9tGa7yxKureW7Ab20GpMWU7Q5asvTJc/RF7phsGD6A8gPIiLjdfXfK
 b3rEkMhxDffEdqp1vs0l+GiDrCdpB1yTY2tQUlT3xua/paTVyp0vqSxfwJAuenSMlH
 BB6NCTBZKnVYXBqeiDReczR5b4jL2Z9sYKDE5jMpUOAtHqNKFqh1yElcaZKdoDcmLE
 QnCXhREMQcqwsQ9tH6drXccU5WeeDn+n1X8KmF/N/Yfd8RIwvEn6cZXw64E8VnDS8a
 ItaixkYA9DZug==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 08/13] hw/ide: add Sense Data Reporting feature set support
Date: Fri, 27 Nov 2026 20:12:43 +0100
Message-ID: <20261127191250.3298004-9-cassel@kernel.org>
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

Implement the Sense Data Reporting feature set (ACS-6 4.25).

When it is enabled, a failed command sets SENSE DATA AVAILABLE, and
REQUEST SENSE DATA EXT (0Bh) returns the sense key, ASC and ASCQ.
The sense data is discarded on a reset and when another command is
accepted.

An unsupported command reports INVALID COMMAND OPERATION CODE (ACS-6
6.8.18), and an invalid input field reports INVALID FIELD IN CDB (6.8.19),
both with ILLEGAL REQUEST. Other errors make no sense data available.

As with NCQ and GPL, only a disk behind AHCI offers the feature set.
This feature will be used to populate the NCQ Command Error log and to
implement NCQ Autosense. Add a qtest that checks the sense data of an
aborted SET FEATURES.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci.c             |   3 +
 hw/ide/core.c             | 146 +++++++++++++++++++++++++++++++++++---
 hw/ide/ide-internal.h     |   3 +-
 include/hw/ide/ide-dev.h  |   4 ++
 tests/qtest/ahci-test.c   |  69 ++++++++++++++++++
 tests/qtest/libqos/ahci.c |  10 +++
 tests/qtest/libqos/ahci.h |   5 +-
 7 files changed, 230 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 21938703da..d74d185607 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1225,6 +1225,9 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
                    ((uint64_t)ncq_fis->lba2 << 16) |
                    ((uint64_t)ncq_fis->lba1 << 8) |
                    (uint64_t)ncq_fis->lba0;
+
+    /* Accepting an NCQ command makes the sense data unavailable (ACS-6 4.25) */
+    ad->port.ifs[0].sense_data_avail = false;
     ncq_tfs->tag = tag;
 
     /* Sanity-check the NCQ packet */
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0ccac398b2..2d8bca0762 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -37,6 +37,8 @@
 #include "system/dma.h"
 #include "hw/block/block.h"
 #include "system/block-backend.h"
+#include "scsi/constants.h"
+#include "scsi/utils.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "system/replay.h"
@@ -244,12 +246,13 @@ static void ide_identify(IDEState *s)
     }
     if (s->ncq_queues) {
         /*
-         * 14=set to 1,
+         * 14=set to 1, 6=Sense Data Reporting supported,
          * 3=READ LOG DMA EXT/WRITE LOG DMA EXT (GPL DMA) supported
          */
-        put_le16(p + 119, (1 << 14) | (1 << 3));
-        /* 14=set to 1, 3=GPL DMA enabled */
-        put_le16(p + 120, (1 << 14) | (1 << 3));
+        put_le16(p + 119, (1 << 14) | (1 << 6) | (1 << 3));
+        /* 14=set to 1, 6=Sense Data Reporting enabled, 3=GPL DMA enabled */
+        put_le16(p + 120, (1 << 14) | (1 << 3) |
+                 (s->sense_data_enabled ? (1 << 6) : 0));
     }
     if (dev && dev->conf.discard_granularity) {
         put_le16(p + 169, 1); /* TRIM support */
@@ -555,11 +558,41 @@ BlockAIOCB *ide_issue_trim(
     return &iocb->common;
 }
 
-void ide_abort_command(IDEState *s)
+/*
+ * Record sense data for the Sense Data Reporting feature set (ACS-6 4.25).
+ * When the feature is enabled the SENSE DATA AVAILABLE bit is reported in the
+ * STATUS field so the host can retrieve the sense with REQUEST SENSE DATA EXT.
+ * When it is disabled this is a no-op, so the ATAPI sense_key/asc are left
+ * untouched for packet devices.
+ */
+static void ide_set_sense(IDEState *s, SCSISense sense)
+{
+    /*
+     * NO SENSE means that there is no sense data to report (ACS-6 6.8.31):
+     * none is made available, and the host relies on the ERROR field.
+     */
+    if (!s->sense_data_enabled || sense.key == NO_SENSE) {
+        return;
+    }
+    s->sense_key = sense.key;
+    s->asc = sense.asc;
+    s->ascq = sense.ascq;
+    s->sense_data_avail = true;
+    s->status |= SENSE_DATA_STAT;
+}
+
+/* Abort the command, and record @sense for Sense Data Reporting */
+static void ide_abort_command_with_sense(IDEState *s, SCSISense sense)
 {
     s->status = READY_STAT | ERR_STAT;
     s->error = ABRT_ERR;
     ide_transfer_stop(s);
+    ide_set_sense(s, sense);
+}
+
+void ide_abort_command(IDEState *s)
+{
+    ide_abort_command_with_sense(s, SENSE_CODE(NO_SENSE));
 }
 
 static void ide_set_retry(IDEState *s)
@@ -1432,6 +1465,14 @@ static void ide_reset(IDEState *s, IDEResetKind kind)
     s->select = (ATA_DEV_ALWAYS_ON);
     s->status = READY_STAT | SEEK_STAT;
 
+    /*
+     * Sense data does not survive a reset (ACS-6 4.25), but the enabled
+     * state of the Sense Data Reporting feature set does: a power-on reset
+     * should disable it (ACS-6 9.11.5.2.46), but IDE_RESET_HARDWARE also
+     * covers COMRESET, which must not change it.
+     */
+    s->sense_data_avail = false;
+
     s->lba48 = 0;
 
     /* ATAPI specific */
@@ -1712,6 +1753,7 @@ static const IDEIdentifyBit ide_sata_capabilities[] = {
 /* The Current Settings QWord of page 04h, terminated by a zero word */
 static const IDEIdentifyBit ide_current_settings[] = {
     { 85, 5, 13 },      /* VOLATILE WRITE CACHE ENABLED */
+    { 120, 6, 10 },     /* SENSE DATA ENABLED */
     { 85, 0, 6 },       /* SMART ENABLED */
     { 0 }
 };
@@ -1932,7 +1974,7 @@ static bool cmd_read_log(IDEState *s, uint8_t cmd)
     size = ide_read_log(s, s->sector, s->lcyl | ((uint16_t)s->hob_lcyl << 8),
                         s->nsector);
     if (size < 0) {
-        ide_abort_command(s);
+        ide_abort_command_with_sense(s, SENSE_CODE(INVALID_FIELD));
         return true;
     }
 
@@ -2020,6 +2062,38 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
     return true;
 }
 
+/*
+ * REQUEST SENSE DATA EXT (0Bh), Sense Data Reporting feature set (ACS-6 7.35)
+ */
+static bool cmd_request_sense_data_ext(IDEState *s, uint8_t cmd)
+{
+    /*
+     * Return the most recent sense data in the LBA field (ACS-6 table 371):
+     * LBA 7:0 = ASCQ, LBA 15:8 = ASC, LBA 19:16 = SENSE KEY. The COUNT and
+     * upper LBA fields (progress indication / vendor specific) are zeroed.
+     */
+    s->nsector = 0;
+    s->hob_nsector = 0;
+    s->hob_sector = 0;
+    s->hob_lcyl = 0;
+    s->hob_hcyl = 0;
+
+    if (s->sense_data_avail) {
+        s->sector = s->ascq;
+        s->lcyl = s->asc;
+        s->hcyl = s->sense_key & 0x0f;
+        s->status |= SENSE_DATA_STAT;
+        /* The sense data is consumed by reading it (ACS-6 4.25). */
+        s->sense_data_avail = false;
+    } else {
+        s->sector = 0;
+        s->lcyl = 0;
+        s->hcyl = 0;
+    }
+
+    return true;
+}
+
 static bool cmd_set_features(IDEState *s, uint8_t cmd)
 {
     uint16_t *identify_data;
@@ -2049,6 +2123,20 @@ static bool cmd_set_features(IDEState *s, uint8_t cmd)
         put_le16(identify_data + 85, ide_identify_word85(s));
         ide_flush_cache(s);
         return false;
+    case 0xc3: /* enable/disable the Sense Data Reporting feature set */
+        if (!s->ncq_queues) {
+            goto abort_cmd;
+        }
+        s->sense_data_enabled = s->nsector & 0x01;
+        identify_data = (uint16_t *)s->identify_data;
+        if (s->sense_data_enabled) {
+            put_le16(identify_data + 120,
+                     le16_to_cpu(identify_data[120]) | (1 << 6));
+        } else {
+            put_le16(identify_data + 120,
+                     le16_to_cpu(identify_data[120]) & ~(1 << 6));
+        }
+        return true;
     case 0xcc: /* reverting to power-on defaults enable */
         s->reset_reverts = true;
         return true;
@@ -2101,7 +2189,7 @@ static bool cmd_set_features(IDEState *s, uint8_t cmd)
     }
 
 abort_cmd:
-    ide_abort_command(s);
+    ide_abort_command_with_sense(s, SENSE_CODE(INVALID_FIELD));
     return true;
 }
 
@@ -2443,6 +2531,8 @@ static const struct {
     [CFA_REQ_EXT_ERROR_CODE]      = { cmd_cfa_req_ext_error_code, CFA_OK },
     [WIN_DSM]                     = { cmd_data_set_management, HD_CFA_OK },
     [WIN_DEVICE_RESET]            = { cmd_device_reset, CD_OK },
+    [WIN_REQUEST_SENSE_DATA_EXT]  = { cmd_request_sense_data_ext,
+                                      HD_OK | AHCI_ONLY },
     [WIN_RECAL]                   = { cmd_nop, HD_CFA_OK | SET_DSC},
     [WIN_READ]                    = { cmd_read_pio, ALL_OK },
     [WIN_READ_ONCE]               = { cmd_read_pio, HD_CFA_OK },
@@ -2507,6 +2597,15 @@ static bool ide_cmd_permitted(IDEState *s, uint32_t cmd)
         && (s->ncq_queues || !(ide_cmd_table[cmd].flags & AHCI_ONLY));
 }
 
+/*
+ * Whether the sense data stays available once this command is accepted
+ * (ACS-6 4.25): REQUEST SENSE DATA EXT returns it.
+ */
+static bool ide_cmd_keeps_sense_data(IDEState *s, uint8_t cmd)
+{
+    return cmd == WIN_REQUEST_SENSE_DATA_EXT;
+}
+
 void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
 {
     IDEState *s;
@@ -2529,7 +2628,7 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
     }
 
     if (!ide_cmd_permitted(s, val)) {
-        ide_abort_command(s);
+        ide_abort_command_with_sense(s, SENSE_CODE(INVALID_OPCODE));
         ide_bus_set_irq(s->bus);
         return;
     }
@@ -2538,6 +2637,15 @@ void ide_bus_exec_cmd(IDEBus *bus, uint32_t val)
     s->error = 0;
     s->io_buffer_offset = 0;
 
+    /*
+     * Accepting a command makes the sense data unavailable, unless the command
+     * reads it (ACS-6 4.25); a failing command records fresh sense of its own
+     * below.
+     */
+    if (!ide_cmd_keeps_sense_data(s, val)) {
+        s->sense_data_avail = false;
+    }
+
     complete = ide_cmd_table[val].handler(s, val);
     if (complete) {
         s->status &= ~BUSY_STAT;
@@ -3368,6 +3476,27 @@ static const VMStateDescription vmstate_ide_tray_state = {
     }
 };
 
+static bool ide_sense_data_needed(void *opaque)
+{
+    IDEState *s = opaque;
+
+    return s->sense_data_enabled || s->sense_data_avail;
+}
+
+/* sense_key and asc travel with the main structure (ATAPI shares them) */
+static const VMStateDescription vmstate_ide_sense_data = {
+    .name = "ide_drive/sense_data",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ide_sense_data_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(sense_data_enabled, IDEState),
+        VMSTATE_BOOL(sense_data_avail, IDEState),
+        VMSTATE_UINT8(ascq, IDEState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ide_drive_pio_state = {
     .name = "ide_drive/pio_state",
     .version_id = 1,
@@ -3423,6 +3552,7 @@ const VMStateDescription vmstate_ide_drive = {
         &vmstate_ide_drive_reset_reverts,
         &vmstate_ide_tray_state,
         &vmstate_ide_atapi_gesn_state,
+        &vmstate_ide_sense_data,
         NULL
     }
 };
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 382e2a4915..0fb4776356 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -26,6 +26,7 @@
 /* Bits of HD_STATUS */
 #define ERR_STAT                0x01
 #define INDEX_STAT              0x02
+#define SENSE_DATA_STAT         0x02    /* SENSE DATA AVAILABLE (ACS-6 6.2.9) */
 #define ECC_STAT                0x04    /* Corrected error */
 #define DRQ_STAT                0x08
 #define SEEK_STAT               0x10
@@ -65,7 +66,7 @@
 /* reserved                             0x07 */
 #define WIN_DEVICE_RESET                0x08
 /* reserved                             0x09..0x0a */
-/* REQUEST SENSE DATA EXT               0x0B */
+#define WIN_REQUEST_SENSE_DATA_EXT      0x0B /* 48-Bit */
 /* reserved                             0x0C..0x0F */
 #define WIN_RECAL                       0x10 /* obsolete since ATA4 */
 /* obsolete since ATA3, retired in ATA4 0x11..0x1F */
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 258b216b44..01b7952957 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -96,6 +96,10 @@ struct IDEState {
     struct unreported_events events;
     uint8_t sense_key;
     uint8_t asc;
+    /* Sense Data Reporting feature set (ATA HD) */
+    uint8_t ascq;
+    bool sense_data_enabled;
+    bool sense_data_avail;
     bool tray_open;
     bool tray_locked;
     uint8_t cdrom_changed;
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5e924010f0..e7df8c9fc8 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1174,6 +1174,63 @@ static void test_read_log_pio(void)
     ahci_shutdown(ahci);
 }
 
+/* Restart command list processing after a task file error (AHCI 6.2.2) */
+static void ahci_port_restart(AHCIQState *ahci, unsigned px)
+{
+    ahci_px_clr(ahci, px, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    ahci_port_clear(ahci, px);
+    ahci_px_set(ahci, px, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+}
+
+/* Issue a non-data command; return the D2H Register FIS it completes with */
+static RegD2HFIS ahci_nodata_cmd(AHCIQState *ahci, unsigned px, uint8_t op,
+                                 uint16_t feature, uint16_t count, uint8_t err)
+{
+    AHCICommand *cmd = ahci_command_create(op);
+    RegD2HFIS d2h;
+
+    ahci_command_set_feature(cmd, feature);
+    ahci_command_set_count(cmd, count);
+    if (err) {
+        ahci_command_expect_error(cmd, err);
+    }
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+    qtest_memread(ahci->parent->qts, ahci->port[px].fb + 0x40, &d2h,
+                  sizeof(d2h));
+    return d2h;
+}
+
+/*
+ * Boot with the Sense Data Reporting feature set enabled, and make sense data
+ * available: SET FEATURES with an unsupported subcommand is aborted, which
+ * records ILLEGAL REQUEST / INVALID FIELD IN CDB.
+ */
+static AHCIQState *ahci_boot_with_sense_data(unsigned *px)
+{
+    AHCIQState *ahci;
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=%s "
+                                "-M q35 -device ide-hd,drive=drive0",
+                                tmp_path, imgfmt);
+    *px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, *px);
+    ahci_nodata_cmd(ahci, *px, CMD_SET_FEATURES, 0xc3, 1, 0);
+    ahci_nodata_cmd(ahci, *px, CMD_SET_FEATURES, 0x47, 0, ATA_ERR_ABRT);
+    ahci_port_restart(ahci, *px);
+    return ahci;
+}
+
+/* REQUEST SENSE DATA EXT: the sense key, ASC and ASCQ as KKAAQQh */
+static uint32_t ahci_sense(AHCIQState *ahci, unsigned px)
+{
+    RegD2HFIS fis = ahci_nodata_cmd(ahci, px, CMD_REQ_SENSE_DATA, 0, 0, 0);
+
+    return (fis.lba_lo[2] & 0x0f) << 16 | fis.lba_lo[1] << 8 | fis.lba_lo[0];
+}
+
 /**
  * Fragmented DMA test: Perform a standard 4K DMA read/write
  * test, but make sure the physical regions are fragmented to
@@ -2617,6 +2674,16 @@ static void create_ahci_io_test(enum IOMode type, enum AddrMode addr,
 
 /******************************************************************************/
 
+static void test_sense_data_set_features(void)
+{
+    unsigned px;
+    AHCIQState *ahci = ahci_boot_with_sense_data(&px);
+
+    ahci_nodata_cmd(ahci, px, CMD_SET_FEATURES, 0x47, 0, ATA_ERR_ABRT);
+    g_assert_cmphex(ahci_sense(ahci, px), ==, 0x052400);
+    ahci_shutdown(ahci);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch, *base;
@@ -2708,6 +2775,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/identify",   test_identify);
     qtest_add_func("/ahci/io/dma/read_log", test_read_log_dma);
     qtest_add_func("/ahci/io/pio/read_log", test_read_log_pio);
+    qtest_add_func("/ahci/io/sense_data/set_features",
+                   test_sense_data_set_features);
 
     for (i = MODE_BEGIN; i < NUM_MODES; i++) {
         for (j = ADDR_MODE_BEGIN; j < NUM_ADDR_MODES; j++) {
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index d50ff4767b..a4790c2f0c 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -71,6 +71,8 @@ AHCICommandProp ahci_command_properties[] = {
                                  .lba48 = true, .read = true },
     { .cmd = CMD_READ_LOG_DMA_EXT, .data = true, .dma = true,
                                  .lba48 = true, .read = true },
+    { .cmd = CMD_SET_FEATURES,   .data = false },
+    { .cmd = CMD_REQ_SENSE_DATA, .lba48 = true },
     { .cmd = READ_FPDMA_QUEUED,  .data = true,  .dma = true,
                                  .lba48 = true, .read = true, .ncq = true },
     { .cmd = WRITE_FPDMA_QUEUED, .data = true,  .dma = true,
@@ -1219,6 +1221,14 @@ void ahci_command_set_ncq_subcmd(AHCICommand *cmd, uint8_t subcmd)
     nfis->prio = (nfis->prio & ~0x1f) | (subcmd & 0x1f);
 }
 
+/* Set the 16-bit FEATURE field of a (non-NCQ) command. */
+void ahci_command_set_feature(AHCICommand *cmd, uint16_t feature)
+{
+    g_assert(!cmd->props->ncq);
+    cmd->fis.feature_low = feature & 0xff;
+    cmd->fis.feature_high = (feature >> 8) & 0xff;
+}
+
 void ahci_command_expect_error(AHCICommand *cmd, uint8_t err)
 {
     cmd->interrupts |= AHCI_PX_IS_TFES;
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 9b40eabe35..a23ea8b2f0 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -282,6 +282,8 @@ enum {
     CMD_IDENTIFY       = 0xEC,
     CMD_READ_LOG_EXT     = 0x2F,
     CMD_READ_LOG_DMA_EXT = 0x47,
+    CMD_SET_FEATURES     = 0xEF,
+    CMD_REQ_SENSE_DATA   = 0x0B,
     CMD_PACKET         = 0xA0,
     CMD_PACKET_ID      = 0xA1,
     /* NCQ */
@@ -654,9 +656,10 @@ void ahci_command_set_sizes(AHCICommand *cmd, uint64_t xbytes,
                             unsigned prd_size);
 void ahci_command_set_count(AHCICommand *cmd, uint16_t count);
 void ahci_command_set_ncq_subcmd(AHCICommand *cmd, uint8_t subcmd);
-void ahci_command_expect_error(AHCICommand *cmd, uint8_t err);
 void ahci_command_set_acmd(AHCICommand *cmd, void *acmd);
 void ahci_command_enable_atapi_dma(AHCICommand *cmd);
+void ahci_command_set_feature(AHCICommand *cmd, uint16_t feature);
+void ahci_command_expect_error(AHCICommand *cmd, uint8_t err);
 void ahci_command_adjust(AHCICommand *cmd, uint64_t lba_sect, uint64_t gbuffer,
                          uint64_t xbytes, unsigned prd_size);
 
-- 
2.56.1


