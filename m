Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838F0C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifo4-0001mz-50; Sat, 11 Jul 2026 18:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifo2-0001jD-FM; Sat, 11 Jul 2026 18:04:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifo0-0000GV-Pq; Sat, 11 Jul 2026 18:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=NC6KBC9WdXLOAh9bLq7yGrmhRdpCxbbAkK3QPsV7m0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JPFV5Mt43hUF4lW4scVThqvV5KULT5p+F7LnqxFDX3x6HBBF0k4F8wNUB3Df7IVE/
 kroWkjne8GevkInxUKDccxtF0RyLuN93dP4idMeXuGlFyLzIq0nyRVQQZwyHKR46MS
 ADnYjpbYw1gmOGvmucmx1QIJqDXYSYIFDMvACdno8hTwupk3EeFaOMSTKCRd+jZQ1Q
 9J02GwDuMAIQ//gCWESaS45EsGzFsejFfHeBGp5OQRiO0BfG/mfwORWikJ8umV3ZfP
 72N0pYc3jvUh9slFDkxxq7TdzjAX2ssnAq9dMkVS2Pav5DaK70FXITw2dlciIUorYY
 cXOorcVWikP9g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 391981C0ABB;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E488E3EAF46;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AB1B313343; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 48/81] hw/ide/ahci: cancel in-flight buffered reads on
 command engine restart
Date: Sun, 12 Jul 2026 00:58:26 +0300
Message-ID: <20260711215904.3757-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

ATAPI CD reads are issued through ide_buffered_readv()
(cd_read_sector() and ide_atapi_cmd_read_dma_cb() in hw/ide/atapi.c).
The PIO path discards the returned aiocb; the DMA path stores it in
s->bus->dma->aiocb.

A guest can stop and restart a port's command engine
(PxCMD.ST 1 -> 0 -> 1) while such a read is still in flight. Stopping
the engine unmaps the command list (ahci_unmap_clb_address()) and
restarting it re-maps the list and clears AHCIDevice.cur_cmd to NULL,
but nothing tears down the outstanding read. This path does not run
ide_reset(), so the drive's transfer state is preserved and the read
still completes. Its callbacks then dereference the stale or NULL
cur_cmd in the AHCI transfer helpers:

  PIO: cd_read_sector_cb() -> ide_atapi_cmd_reply_end() ->
       ide_transfer_start_norecurse() -> ahci_pio_transfer()

  DMA: ide_atapi_cmd_read_dma_cb() -> ahci_dma_rw_buf() ->
       ahci_populate_sglist()

Both crash with a NULL cur_cmd; the PIO variant has been seen in the
field.

Cancel the outstanding I/O when the command list is unmapped, reusing
ide_cancel_dma_sync() as the ATAPI DEVICE RESET command does. It runs
the completion callback with -ECANCELED (which tears down
s->bus->dma->aiocb for the DMA case) and orphans the buffered request,
so the eventual asynchronous completion is a no-op. Merely setting the
orphaned flag is not enough: it would leave s->bus->dma->aiocb pointing
at a freed aiocb that a later reset would cancel.

Fixes: 1d8c11d63154 ("ide: add support for IDEBufferedRequest")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260619112158.304782-2-den@openvz.org>
[PMD: Use ide_bus_active_if()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit d9f78431d8ebdc2d03ad74461138c1c9eb076aa5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 08f51c8e361..80cc386a6aa 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
 
 static void ahci_unmap_clb_address(AHCIDevice *ad)
 {
+    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
+    ide_cancel_dma_sync(ide_bus_active_if(&ad->port));
+
     if (ad->lst == NULL) {
         trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
         return;
-- 
2.47.3


