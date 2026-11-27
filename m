Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1B606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uzetn6X4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Nn-0001p1-1g; Fri, 27 Nov 2026 14:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nc-0001lU-9o; Fri, 27 Nov 2026 14:13:09 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Na-00065B-E9; Fri, 27 Nov 2026 14:13:08 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 626E6611C7;
 Fri, 27 Nov 2026 19:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E9E1F00893;
 Fri, 27 Nov 2026 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806785;
 bh=hiMVmofQ9le2uPTR29ckErclhqD5uTB1ww31I+XjsWE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uzetn6X4t+JSzNts8ly/qXjiYnDz9D077n8BUTrFmGRjxI5qlhvQWcKFkmMqGKipT
 1d2D8mhj7lqIq4NhOkFobRtEOEWfpw8vCW36RuGxUVRt8Ja6Gzr6+0UJnzu64+Nnia
 eu37I+kcVFgBK91NdmXQ5dOYyrym1mulqjpgc2Eswl/ZjADeAroKdGEOUm2KvWG1QK
 gKJYMnuyaqVLwsBfLaxSf3FPtYKEH9+lP7Zxji2iU4I9MDJ+3I3rPpoh2MwxsdXjGY
 CcbeJgKkV3XjUOJuwPYYs8cP0K6RSL1B1m3jCAHkUl0zvih1hLXUH3gtVM+Vn2vKhu
 xr1quBbjIHPjA==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 03/13] hw/ide/ahci: clear a stale error status when an NCQ
 command is queued
Date: Fri, 27 Nov 2026 20:12:38 +0100
Message-ID: <20261127191250.3298004-4-cassel@kernel.org>
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

Successfully queueing an NCQ command should clear ERR_STAT, BUSY and
DRQ, see ACS-6 table 369 and SATA 3.5a DFPDMAQ2.

Simply restarting the port after a fatal error does not clear ERR_STAT.
The task file status in PxTFD only changes when the device sends a FIS,
i.e. when queueing a new NCQ command.

Without this, we would incorrectly again enter the HBA stopped state
when queueing a new NCQ command after restarting the port. Add a qtest
that issues an NCQ command after a failed WRITE DMA EXT.

Fixes: 2967dc8209dd ("hw/ide/ahci: write D2H FIS when processing NCQ command")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci.c           |  9 ++++--
 tests/qtest/ahci-test.c | 61 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3b872c6cf1..e3ae46e869 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1150,13 +1150,16 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
 
     /*
      * A NCQ command clears the bit in PxCI after the command has been QUEUED
-     * successfully (ERROR not set, BUSY and DRQ cleared).
-     *
-     * For NCQ commands, PxCI will always be cleared here.
+     * successfully (ERROR not set, BUSY and DRQ cleared). A device reports
+     * this status for every command that it queues (SATA 3.5a DFPDMAQ2,
+     * ACS-6 table 369), whatever the status of the previous command was, so
+     * PxCI will always be cleared here.
      *
      * (Once the NCQ command is COMPLETED, the device will send a SDB FIS with
      * the interrupt bit set, which will clear PxSACT and raise an interrupt.)
      */
+    ad->port.ifs[0].status = READY_STAT | SEEK_STAT;
+    ad->port.ifs[0].error = 0;
     ahci_clear_cmd_issue(ad, slot);
 
     /*
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 6acb2327e3..2b668ea708 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1169,6 +1169,66 @@ static void test_flush_retry(void)
     ahci_shutdown(ahci);
 }
 
+/*
+ * An NCQ command issued after a failed non-NCQ command is queued with BSY,
+ * DRQ and ERR cleared (SATA 3.5a DFPDMAQ2), so its PxCI bit is cleared and
+ * it completes without the error of the earlier command.
+ */
+static void test_ncq_after_error(void)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    uint32_t bit;
+    uint64_t ptr;
+    uint8_t px;
+    int i;
+
+    prepare_blkdebug_script(debug_path, "write_aio");
+    ahci = ahci_boot_and_enable("-drive file=blkdebug:%s:%s,if=none,id=drive0,"
+                                "format=%s -M q35 -device ide-hd,drive=drive0",
+                                debug_path, tmp_path, imgfmt);
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+
+    /* A WRITE DMA EXT that fails with the injected I/O error */
+    ptr = ahci_alloc(ahci, 512);
+    cmd = ahci_command_create(CMD_WRITE_DMA_EXT);
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue(ahci, cmd);
+    g_assert_cmphex(ahci_px_rreg(ahci, px, AHCI_PX_IS) & AHCI_PX_IS_TFES,
+                    !=, 0);
+    ahci_command_free(cmd);
+
+    /* Restart the port, as after any error (AHCI 1.3.1 6.2.2.1) */
+    ahci_px_clr(ahci, px, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    ahci_port_clear(ahci, px);
+    ahci_px_set(ahci, px, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+
+    cmd = ahci_command_create(READ_FPDMA_QUEUED);
+    ahci_command_set_buffer(cmd, ptr);
+    ahci_command_set_size(cmd, 512);
+    ahci_command_commit(ahci, cmd, px);
+    ahci_command_issue_async(ahci, cmd);
+    bit = 1u << ahci_command_slot(cmd);
+    for (i = 0; i < 100000 && (ahci_px_rreg(ahci, px, AHCI_PX_SACT) & bit);
+         i++) {
+        usleep(50);
+    }
+    g_assert_cmphex(ahci_px_rreg(ahci, px, AHCI_PX_SACT) & bit, ==, 0);
+    /* The command was acknowledged without an error, and PxCI cleared */
+    g_assert_cmphex(ahci_px_rreg(ahci, px, AHCI_PX_IS) & AHCI_PX_IS_TFES,
+                    ==, 0);
+    g_assert_cmphex(ahci_px_rreg(ahci, px, AHCI_PX_CI) & bit, ==, 0);
+    /* STS.ERR and the ERR field: nothing left from the failed command */
+    g_assert_cmphex(ahci_px_rreg(ahci, px, AHCI_PX_TFD) & 0xff01, ==, 0);
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+    ahci_shutdown(ahci);
+}
+
 /*
  * After a command fails, the HBA processes no further commands until software
  * clears PxCMD.ST (AHCI 1.3.1 6.2.2), so it does not execute the failed
@@ -2466,6 +2526,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/flush/simple", test_flush);
     qtest_add_func("/ahci/flush/retry", test_flush_retry);
+    qtest_add_func("/ahci/io/ncq/after_error", test_ncq_after_error);
     qtest_add_func("/ahci/io/dma/halt_after_error", test_halt_after_error);
     qtest_add_func("/ahci/flush/migrate", test_flush_migrate);
 
-- 
2.56.1


