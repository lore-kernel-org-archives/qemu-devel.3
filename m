Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7303BCD98FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIY-0002PP-WF; Fri, 19 Jun 2026 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIT-0002KQ-On; Fri, 19 Jun 2026 07:22:05 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yF-Ee; Fri, 19 Jun 2026 07:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=YqoPVle9ns1NfUZIud8G5x1VftK5Us7rWIgsNF2hhis=; b=t6RW0OxExgOT
 Qv9amTFtvQ/uVeaHiOQMGDNRKtni5+1byHboQ20tURLBmAW852XHzHIXPqLOPbKuDYXPwrJQSRzB6
 jNO1TrySxKNmliaMdW28eMm2fGteuNnpfjUwmICshOme2cVu8IorNSFvI3KtKplHEtlG9aUPX5r68
 +2yz4CS/4gvrKahQ63Vw6nUkan6s6etzeKJ5jtHFlO/lGVvytiRPZgITdYLMZDVxufZPZYHS8Rtxt
 /SIa+a7u2hR5asWxpmaWql2hQ9XYh5rGh4/3QVjE+eHWzkyS0X4PKaNtm2rCwiQsruGka8Kq5Tjaw
 IOLiXeEkTzdYNPz2b+cQ8g==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHn-0089QU-0o;
 Fri, 19 Jun 2026 13:21:55 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 0/9] hw/ide: fix ATAPI CD reads racing port reset and drain
Date: Fri, 19 Jun 2026 13:21:48 +0200
Message-ID: <20260619112158.304782-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
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

An in-flight ATAPI buffered CD read (ide_buffered_readv(), used by both
the PIO and DMA reply paths in hw/ide/atapi.c) can collide with a
concurrent port operation, and it breaks in two distinct ways. Both are
guest-triggerable and reproduce on current master.

Neither was found by inspection: both are real issues reported against
the qemu-kvm 10.0 downstream -- the crash from production, and the
deadlock from the downstream live-migration validation suite -- on
CD-ROMs backed by high-latency network storage, where a backend read
outlives the guest's SATA command timeout.

1. Command engine restart -> NULL-deref crash (patches 1-2)

   A guest can stop and restart a port's command engine
   (PxCMD.ST 1 -> 0 -> 1) while a read is in flight. The restart re-maps
   the command list and clears AHCIDevice.cur_cmd, but nothing tears
   down the outstanding read; its completion then dereferences the
   cleared cur_cmd in ahci_pio_transfer() / ahci_dma_rw_buf(). This is
   not the COMRESET path -- an engine restart does not run ide_reset(),
   so the drive's transfer state is preserved and the read still runs.

   Patch 1 cancels the outstanding I/O when the command list is
   unmapped, reusing ide_cancel_dma_sync() exactly as ATAPI DEVICE
   RESET already does from the same MMIO context. Patch 2 is a qtest
   covering the PIO and DMA reply paths.

2. Concurrent drain -> main-loop deadlock (patch 8, repro in patch 9)

   A multi-sector PIO read whose byte-count limit spans more than one
   sector must fetch the later sectors of a DRQ burst from inside the
   completion of the first, asynchronous read. cd_read_sector_sync()
   did that with a synchronous blk_pread(), which queues behind any
   drain in progress. When a guest reset reaches
   virtio_blk_stop_ioeventfd() -> bdrv_drain_all_begin() while such a
   read is in flight, the nested read is queued while the outer
   completion still holds blk->in_flight, so the drain never finishes:
   the main loop wedges in the drain with the BQL held and every
   QMP/monitor operation blocks behind it.

   Patch 8 reads the whole elementary transfer in a single asynchronous
   request, so no read is ever issued mid-burst; cd_read_sector_sync()
   is removed and the DMA path is unchanged. Patch 9 reproduces the
   hang via x-blockdev-set-iothread, which takes the same
   bdrv_drain_all_begin() path a guest reset does.

Patches 3-7 are the test groundwork the deadlock fix needs: they fold
the IDE CD-ROM read tests into one parametrized helper and add the
previously missing coverage -- multi-sector DMA, and raw 2352-byte
READ CD on both IDE and AHCI -- so the rewritten ATAPI read path
(including its in-place 2352 unpack) is exercised on both consumers.
The test patches pass with or without patch 8, keeping the series
bisectable.

Patches 1-2 stand alone as the engine-restart crash fix; they are
included here because the deadlock work shares and extends the same
ATAPI read path and its test scaffolding.

checkpatch is clean on all nine patches; the new and existing IDE and
AHCI qtests pass.

Denis V. Lunev (9):
  hw/ide/ahci: cancel in-flight buffered reads on command engine restart
  tests/qtest/ahci: test ATAPI read completing after engine restart
  tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
  tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
  tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
  tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
  tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
  hw/ide/atapi: read the whole elementary transfer asynchronously
  tests/qtest/ahci: regression test for ATAPI read vs. drain

 hw/ide/ahci.c             |   3 +
 hw/ide/atapi.c            | 180 +++++++++++++++-----------------
 tests/qtest/ahci-test.c   | 201 ++++++++++++++++++++++++++++++++++++
 tests/qtest/ide-test.c    | 211 ++++++++++++++++++++++++--------------
 tests/qtest/libqos/ahci.c |   8 ++
 tests/qtest/libqos/ahci.h |   2 +
 6 files changed, 433 insertions(+), 172 deletions(-)

-- 
2.53.0


