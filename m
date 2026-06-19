Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A67CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIU-0002M2-VD; Fri, 19 Jun 2026 07:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIT-0002Jo-5h; Fri, 19 Jun 2026 07:22:05 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yD-G2; Fri, 19 Jun 2026 07:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=WtvhKYN+ZUt6rDhVVmQmiflcDKFDLl5jJMNEdeicrys=; b=wMOppAG5rgpM
 zd7q66xaDYPN7WBXklcCdNFHEgYhpoHyOlDSkyc0y75eWhMz87sg4ojnnaK//AKYk5MrvkDu5wW06
 Kr0YG4fNYyWlmJcP0dRj2VB5ciX1Ul6YjfypP86xHHmToUgskkaPflY/wy59TjeAO9M2uj1+8gdJ+
 do6HxtTqmBBMtt/aK6PT3CC4oDTJbS4wYEPv2ebUX6iiIiA4wBYjrimUfKSePagCw7oW830EiI3lL
 TWAjcVUoT7ZC9T6G8sBAClT8b5NcBLJnsZCAuv7Gj+1/xf/nOlsW5xF5FnyY8woKRO6q4IghTUzuA
 +1B5MobknXfdUHU5SMFSVA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHn-0089QU-1y;
 Fri, 19 Jun 2026 13:21:55 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/9] hw/ide/ahci: cancel in-flight buffered reads on command
 engine restart
Date: Fri, 19 Jun 2026 13:21:49 +0200
Message-ID: <20260619112158.304782-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
References: <20260619112158.304782-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 hw/ide/ahci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c2b4432b94..8e3684cd3c 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
 
 static void ahci_unmap_clb_address(AHCIDevice *ad)
 {
+    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
+    ide_cancel_dma_sync(&ad->port.ifs[0]);
+
     if (ad->lst == NULL) {
         trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
         return;
-- 
2.53.0


