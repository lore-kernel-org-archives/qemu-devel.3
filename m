Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+H3aYnQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Nm-0001on-TY; Fri, 27 Nov 2026 14:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Na-0001kW-Ak; Fri, 27 Nov 2026 14:13:06 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1NY-0005sY-59; Fri, 27 Nov 2026 14:13:06 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3CA6449CE;
 Fri, 27 Nov 2026 19:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD61F00893;
 Fri, 27 Nov 2026 19:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806782;
 bh=IUugToqMokQ3XaxPMoFuFHHc5lLNWbQ5b99sDropAdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i+H3aYnQvBG8XfnA/cPOnSeyfys3qQS4qOh+FovR5FccZc/sZeQmt0gu48vsCdXVE
 wFGwNF4WvFoz7GUkIXdefQAqzbjUqFTp1J9Ci950XsSR/0mvayxsPyBhAWhQbpkC+5
 VGMsk1MJf12GYghJmVL6MSlZCesZUsCx9zUbm5Em46JDrw5tATenvucxzUucl3hpcK
 qLpnzxa3pNzPSnlInyIw6oK9TtjlhQM+gdZbYfEbgkwAXQ35HyMRc39PppFoFT01jh
 qllkYsTeF5Kvx9X8L0D3NUnljPol2+y0KTntPVXp3eKmAUBkeERQjT5km9ot2zp+gr
 wE+J1b0uGO6hg==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 02/13] hw/ide/ahci: stop processing commands after a fatal
 error
Date: Fri, 27 Nov 2026 20:12:37 +0100
Message-ID: <20261127191250.3298004-3-cassel@kernel.org>
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

As per AHCI 1.3.1, 6.2.2, after a fatal error, the HBA should not
process any further commands until software clears PxCMD.ST.

This was previously missing in the QEMU model, which emulates both
both the drive and the HBA.

Previously, QEMU went on processing commands, and as a failed command
keeps its bit in PxCI, check_cmd() executed it again when the host issued
another command without restarting the port.

Add a new state that halts the port after a fatal error.
Linux, SeaBIOS and libqos already restart the port using PxCMD.ST after
an error.

Add a qtest that checks that a command issued after a failed WRITE DMA
EXT, without restarting the port, is not processed, and that the failed
write is not executed again.

Fixes: 1a16ce64fda1 ("hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci-internal.h  |  4 +++
 hw/ide/ahci.c           | 39 ++++++++++++++++++++++++-
 tests/qtest/ahci-test.c | 63 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/hw/ide/ahci-internal.h b/hw/ide/ahci-internal.h
index a318f36811..ca11a370c7 100644
--- a/hw/ide/ahci-internal.h
+++ b/hw/ide/ahci-internal.h
@@ -165,6 +165,9 @@ enum AHCIPortIRQ {
 #define DEF_PORT_IRQ              (PORT_IRQ_ERROR | PORT_IRQ_SG_DONE |     \
                                    PORT_IRQ_SDB_FIS | PORT_IRQ_DMAS_FIS |  \
                                    PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS)
+/* The fatal errors, after which the HBA stops (AHCI 1.3.1 6.2.2) */
+#define PORT_IRQ_FATAL            (PORT_IRQ_TF_ERR | PORT_IRQ_HBUS_ERR |   \
+                                   PORT_IRQ_HBUS_DATA_ERR | PORT_IRQ_IF_ERR)
 
 /* PORT_CMD bits */
 #define PORT_CMD_ATAPI            (1 << 24) /* Device is ATAPI */
@@ -318,6 +321,7 @@ struct AHCIDevice {
     bool done_first_drq;
     int32_t busy_slot;
     bool init_d2h_sent;
+    bool halted; /* fatal error (PxIS.TFES), until PxCMD.ST is cleared */
     AHCICmdHdr *cur_cmd;
     NCQTransferState ncq_tfs[AHCI_MAX_CMDS];
     MemReentrancyGuard mem_reentrancy_guard;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 86f6297dc9..3b872c6cf1 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -208,6 +208,13 @@ static void ahci_trigger_irq(AHCIState *s, AHCIDevice *d,
                            irqstat & d->port_regs.irq_mask);
 
     d->port_regs.irq_stat = irqstat;
+    /*
+     * A fatal error halts the port until PxCMD.ST is cleared
+     * (AHCI 1.3.1 6.2.2).
+     */
+    if (irq & PORT_IRQ_FATAL) {
+        d->halted = true;
+    }
     ahci_check_irq(s);
 }
 
@@ -301,6 +308,7 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         if ((pr->cmd & PORT_CMD_START) && !(val & PORT_CMD_START)) {
             pr->scr_act = 0;
             pr->cmd_issue = 0;
+            s->dev[port].halted = false;
         }
 
         /* Block any Read-only fields from being set;
@@ -565,7 +573,13 @@ static void check_cmd(AHCIState *s, int port)
     uint8_t slot;
 
     if ((pr->cmd & PORT_CMD_START) && pr->cmd_issue) {
-        for (slot = 0; (slot < 32) && pr->cmd_issue; slot++) {
+        /*
+         * After a fatal error the HBA processes no commands until software
+         * clears PxCMD.ST (AHCI 1.3.1 6.2.2). A command can fail before
+         * handle_cmd() returns, so check before each slot.
+         */
+        for (slot = 0; (slot < 32) && pr->cmd_issue && !s->dev[port].halted;
+             slot++) {
             if (pr->cmd_issue & (1U << slot)) {
                 handle_cmd(s, port, slot);
             }
@@ -664,6 +678,7 @@ static void ahci_reset_port(AHCIState *s, int port, IDEResetKind kind)
     pr->cmd_issue = 0;
     d->busy_slot = -1;
     d->init_d2h_sent = false;
+    d->halted = false;
 
     ide_state = &s->dev[port].port.ifs[0];
     if (!ide_state->blk) {
@@ -1738,6 +1753,24 @@ static const VMStateDescription vmstate_ncq_tfs = {
     },
 };
 
+static bool ahci_device_halted_needed(void *opaque)
+{
+    AHCIDevice *ad = opaque;
+
+    return ad->halted;
+}
+
+static const VMStateDescription vmstate_ahci_device_halted = {
+    .name = "ahci port/halted",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ahci_device_halted_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(halted, AHCIDevice),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_ahci_device = {
     .name = "ahci port",
     .version_id = 1,
@@ -1767,6 +1800,10 @@ static const VMStateDescription vmstate_ahci_device = {
                              1, vmstate_ncq_tfs, NCQTransferState),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_ahci_device_halted,
+        NULL
+    },
 };
 
 static int ahci_state_post_load(void *opaque, int version_id)
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 291f29e762..6acb2327e3 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1169,6 +1169,68 @@ static void test_flush_retry(void)
     ahci_shutdown(ahci);
 }
 
+/*
+ * After a command fails, the HBA processes no further commands until software
+ * clears PxCMD.ST (AHCI 1.3.1 6.2.2), so it does not execute the failed
+ * command again either.
+ */
+static void test_halt_after_error(void)
+{
+    g_autofree unsigned char *before = g_malloc(512);
+    g_autofree unsigned char *tx = g_malloc(512);
+    g_autofree unsigned char *rx = g_malloc(512);
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    uint32_t pending;
+    uint64_t ptr;
+    unsigned px;
+
+    prepare_blkdebug_script(debug_path, "write_aio");
+    ahci = ahci_boot_and_enable("-drive file=blkdebug:%s:%s,if=none,id=drive0,"
+                                "format=%s -M q35 -device ide-hd,drive=drive0",
+                                debug_path, tmp_path, imgfmt);
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+    ahci_io(ahci, px, CMD_READ_DMA_EXT, before, 512, 0);
+    memset(tx, before[0] ^ 0xff, 512);
+
+    /* A WRITE DMA EXT that fails with the injected I/O error */
+    ptr = ahci_alloc(ahci, 512);
+    qtest_bufwrite(ahci->parent->qts, ptr, tx, 512);
+    cmd = ahci_command_create(CMD_WRITE_DMA_EXT);
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    /* Not ahci_command_verify(), which would restart the port */
+    g_assert_cmphex(ahci_px_rreg(ahci, px, AHCI_PX_IS) & AHCI_PX_IS_TFES,
+                    !=, 0);
+    ahci_command_free(cmd);
+
+    /* A command issued without restarting the port is not processed */
+    cmd = ahci_command_create(CMD_READ_DMA_EXT);
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue_async(ahci, cmd);
+    /* Nothing to poll for: give the command time to be processed */
+    g_usleep(50 * 1000);
+    pending = ahci_px_rreg(ahci, px, AHCI_PX_CI) &
+              (1u << ahci_command_slot(cmd));
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+
+    /* Restarting the port drops it; the sector still has its old data */
+    ahci_px_clr(ahci, px, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    ahci_port_clear(ahci, px);
+    ahci_px_set(ahci, px, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    ahci_io(ahci, px, CMD_READ_DMA_EXT, rx, 512, 0);
+    g_assert_cmphex(memcmp(rx, before, 512), ==, 0);
+    g_assert_cmphex(pending, !=, 0);
+
+    ahci_shutdown(ahci);
+}
+
 /**
  * Basic sanity test to boot a machine, find an AHCI device, and shutdown.
  */
@@ -2404,6 +2466,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/flush/simple", test_flush);
     qtest_add_func("/ahci/flush/retry", test_flush_retry);
+    qtest_add_func("/ahci/io/dma/halt_after_error", test_halt_after_error);
     qtest_add_func("/ahci/flush/migrate", test_flush_migrate);
 
     qtest_add_func("/ahci/migrate/sanity", test_migrate_sanity);
-- 
2.56.1


