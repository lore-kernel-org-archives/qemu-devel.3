Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B585606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q985vBW4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXju-00060j-HK; Mon, 23 Nov 2026 12:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXjt-00060H-M5
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:01 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXjr-0002jz-UJ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:01 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E164D44E20;
 Mon, 23 Nov 2026 17:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCAC1F000D3;
 Mon, 23 Nov 2026 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454515;
 bh=ZmOpM2IQ4kmZseG/LBs8EIhar4S3b8RO7X1iUrM69NM=;
 h=From:To:Cc:Subject:Date;
 b=Q985vBW4kYEYHKLhen42VWaw0OqAVLuD3KTyryFYaltKRMjXm1npxmeTgcjAoqYT/
 rkydjcEk3WwL9hs0aDndgDlp1lJObFZ1uJz0H2JuOtQYLzFPj1wQoKvb7TfNBipV8W
 pzd7h4JdDlZFndUyd35huVZkJbsizvyFe0+Cv3xFMXA/6zeuzVvQgo0BecQ250R34K
 GIo/A5puE/ywqtOA3hWVxhhjadth7yy6dHG5t6LMvzaFOCeD9eTqqX4QXiDL1O771V
 tINf5i5Plk9SzgD3MM01hRP5jgpziByS297wleHBP9U0WxB+ISAPm0vpx+ISuUd7D2
 C05aOZqbhE82Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 00/14] nc53c710 rewrite
Date: Mon, 23 Nov 2026 18:21:37 +0100
Message-ID: <20261123172151.7605-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Fifth attempt to replace the existing 53c710 driver by
a new driver based on the code of the lsi53c895a.c 🙂

Since v5:
Incorporated feedback from BALATON Zoltan <balaton@eik.bme.hu>,
specifically:
- added his r-b tag
- use dma_addr_t in lsi_do_dma() as in lsi53c895a driver
- rephrased commit message in patch 11, text from Keith Monahan
- stick to version 2 in vmstate struct

Since v4:
Used LLM to decompose v3 as logical / atomic changes when
possible (didn't work well with the rewrite patch).

Fixes extracted first so could be merged for v11.2 (patches
1 to 5). The rest is the rewrite, so up to the maintainers
(Helge, Mark) and is probably OK as hobbyist-only code.

Since v3:
- header split, Suggested-by tag (Zoltan)
- I couldn't figure the "hw/misc/lasi.c" change so dropped
  the comment about it.
- Dropped "move to COMMAND on CLEAR ACK after MESSAGE REJECT"
- Split rewrite patch as separated commits:
   - base engine
   - asynchronous completions
   - synchronous drain
   - HP-UX MESSAGE REJECT quirk
   - reentrancy guard and reset-time request cancel

hw/scsi/ncr53c710.c is derived from hw/scsi/lsi53c895a.c which
is LGPL, the rewrite is now declared GPL-2.0-or-later.
hw/scsi/lsi_scsi.h, which is moved verbatim from lsi53c895a.c,
keeps the original terms: its header says "This code is licensed
under the LGPL." with SPDX-License-Identifier: LGPL-2.1-or-later.

Keith Monahan (9):
  hw/scsi/scsi-disk: Add quirk_mode_page_no_flexible_disk, use it on the
    715
  hw/scsi: Move shared LSI/NCR definitions to lsi_scsi.h
  hw/scsi/ncr53c710: Rewrite the 53C710 SCRIPTS engine
  hw/scsi/ncr53c710: Deliver completions from bottom halves
  hw/scsi/ncr53c710: Drain asynchronous transfers in the register write
  hw/scsi/ncr53c710: Append SAVE DATA POINTERS after MESSAGE REJECT for
    HP-UX
  hw/scsi/ncr53c710: Guard SCRIPTS reentrancy and cancel requests on
    soft reset
  hw/scsi/lasi_ncr710: Map the full LASI SCSI module page
  hw/scsi/ncr53c710: Bump the migration version

Philippe Mathieu-Daudé (5):
  hw/scsi/ncr53c710: Cancel the in-flight request on soft reset
  hw/scsi/ncr53c710: Do not load SBCL from DBC after a SCRIPTS phase
    move
  hw/scsi/lasi_ncr710: Limit max_target and max_lun to 7
  hw/scsi/ncr53c710: Keep DCNTL.EA and DMODE.FC1 across an ISTAT.RST
    reset
  hw/scsi/ncr53c710: Document the SIGP latch deviation

 MAINTAINERS            |    1 +
 hw/hppa/machine.c      |   10 +
 hw/scsi/lasi_ncr710.c  |  135 +-
 hw/scsi/lasi_ncr710.h  |   28 +-
 hw/scsi/lsi53c895a.c   |   79 +-
 hw/scsi/lsi_scsi.h     |  104 ++
 hw/scsi/ncr53c710.c    | 2957 +++++++++++++++-------------------------
 hw/scsi/ncr53c710.h    |  287 ++--
 hw/scsi/scsi-disk.c    |   13 +
 hw/scsi/trace-events   |   43 +-
 include/hw/scsi/scsi.h |    1 +
 11 files changed, 1441 insertions(+), 2217 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

-- 
2.54.0


