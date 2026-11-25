Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC186606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJLqB1Qh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35A-000834-6C; Tue, 24 Nov 2026 21:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW356-000825-3N
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:00 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW353-0006m5-CU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:49:58 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D81B64368E;
 Wed, 25 Nov 2026 02:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB051F000C4;
 Wed, 25 Nov 2026 02:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795574995;
 bh=xyBPF/nugxmLTKRC36/Hvr5WLNvAXrRmNPi78wqjMF0=;
 h=From:To:Cc:Subject:Date;
 b=cJLqB1QhxN36eCX3cmF9vbUXsGUcy5tyNbyi/zTEWCjJlNoVTDuHqmar3jbtvjfnB
 V8d3o9LAyXyTNmV5OwZ7oMmxZZEhK4rCAjSiQwl5OLJpupIAm7BpsyF7lHiuUHhCt+
 6F6hWjLlRuvBYzcGjByzIL38KZuw7XhNXrSoJPMpYDM0FjkrJU7iTo2YvzQsIWdA+d
 TaQSJsOcyJMcHTGbdm55hvmcmL7cAiSQw7pYQu8WS54pxmlpeEkTRpSkhWyv2GCX+6
 T7F1XMcd5ju7YTWmWGICEeNCc8juCfF9/bp/reBwMa96neZAL4iV0Cus+2TdZUhgqK
 hsKugzHWUtw8Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 00/14] ncr53c710 driver rewrite
Date: Wed, 25 Nov 2026 03:49:37 +0100
Message-ID: <20261125024951.10428-1-deller@kernel.org>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 225d5bd4691fc75e32536428fc9a23ddb8e30784:

  Merge tag 'pull-nvme-20261120' of https://gitlab.com/birkelund/qemu into staging (2026-11-20 11:44:53 -0800)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa715-scsi-v6-pull-request

for you to fetch changes up to a4de3d6e91850c2e7ccfe4e0bda86959f5b4fbe0:

  hw/scsi/ncr53c710: Bump the migration version (2026-11-25 03:23:47 +0100)

----------------------------------------------------------------
NCR53c710 driver rewrite

Rewrite the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
LSI53C895A model (hw/scsi/lsi53c895a.c), an actively maintained sibling
in the same NCR/LSI SCRIPTS family, adapted to the 53C710: its register
map, single byte (DSTAT/SSTAT0) interrupt model, big endian SCRIPTS and
table indirect fetch (the part sits on the big endian PA-RISC LASI bus),
and 24 bit DMA counts.  Behaviour follows the NCR 53C710 Data Manual
(Jun 1992) and Programmer's Guide (Oct 1990).

The driver is only used by the HP-PARISC emulation in the 715 machine
and was tested with:
  - HP-UX 10.20 installs and reboots into the installed system, on both
    the Ignite (16700A) media and a software install that overlaps
    tagged commands.
  - Linux lasi700/53c700 installs and boots Debian off the 710.
  - NetBSD/hppa 9.4 and 10.1 (osiop) boot and enumerate disk and CD-ROM.

----------------------------------------------------------------

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
 hw/scsi/ncr53c710.c    | 2959 +++++++++++++++-------------------------
 hw/scsi/ncr53c710.h    |  287 ++--
 hw/scsi/scsi-disk.c    |   13 +
 hw/scsi/trace-events   |   43 +-
 include/hw/scsi/scsi.h |    1 +
 11 files changed, 1446 insertions(+), 2214 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

-- 
2.54.0


