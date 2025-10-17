Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD53CCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjG-0005zh-GT; Fri, 17 Oct 2025 16:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjE-0005yR-D8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:08 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjC-0005N9-Dv
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 284666059B;
 Fri, 17 Oct 2025 20:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84B4C4CEE7;
 Fri, 17 Oct 2025 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731616;
 bh=nxkCcryR9ox7cJza480TkZP5H7/HWsSHSgslidVT5/I=;
 h=From:To:Cc:Subject:Date:From;
 b=q7NcXJfGycZXBbXkepHnWaFOsaPaA1UfXePL4Bv1q9BbPGI6gKTTlypxho9h9PbAc
 MMU57piFBaTHDVJD1gAa/iHnmfs3+O0KtvjOEOl2Q0dEtXZp33gf2njrebtrseRgHQ
 ReElEjqBauPTbsE0sjrTjMzUXEesV3oWod5FxsT0DstA3sJ6w8cK3HEsQR7nHj9JSc
 7KGncVm+clrrFRshP7qMCJV52Gd75SpFCnetfXzRrWfl4itf1YrS6h3/DkkBgprT0o
 6A30zKAeAaw8rP4Kp55boQyWEm/j9yD3OjRpMv1AuWkD06/Wstw+nMeNox78zeXZcX
 XftXfjjjVQapQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 00/10] HP-PARISC 715 machine with NCR710 SCSI chip
Date: Fri, 17 Oct 2025 22:06:43 +0200
Message-ID: <20251017200653.23337-1-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

This patch series adds a new emulation for a HP PA-RISC 715/64 model,
as it's descrived here:
https://www.openpa.net/systems/hp-9000_715.html.

That machine has no PCI bus and instead uses a "LASI" chip which
has built-in NCR710 SCSI and i82596 network chips. Compared
to the other already emulated machines B160L and C3700, this machine
should be able to support older operating systems like HP-UX 9 as well.

The QEMU project participated in the Google Summer of Code 2025 program by
"Implementing LASI Network Card and NCR 710 SCSI Controller Device Models", and
Soumyajyotii Ssarkar stepped up to develop those drivers.

This patch series includes the code for the NCR710 SCSI controller,
the network code will follow in later patch series.

Please review those patches.

Helge & Soumyajyotii

Helge Deller (7):
  target/hppa: Update SeaBIOS-hppa to version 19
  hw/hppa: Fix firmware end address for LASI chip
  hw/hppa: Fix interrupt of LASI parallel port
  hw/hppa: Add the NCR 710 SCSI driver to hppa machines
  hw/hppa: PCI devices depend on availability of PCI bus
  hw/hppa: Require SeaBIOS version 19 for 715 machine
  hw/hppa: Add 715 machine type including NCR710 SCSI

Soumyajyotii Ssarkar (3):
  ncr710: Add driver for the NCR 53c710 SCSI chip
  lasi: Forward LASI SCSI ports to NCR 53c710 driver
  hw/scsi: Add config option for new ncr710 driver

 hw/hppa/Kconfig             |    1 +
 hw/hppa/hppa_hardware.h     |    3 +-
 hw/hppa/machine.c           |  110 +-
 hw/misc/lasi.c              |    6 +-
 hw/scsi/Kconfig             |    5 +
 hw/scsi/lasi_ncr710.c       |  303 +++++
 hw/scsi/lasi_ncr710.h       |   53 +
 hw/scsi/meson.build         |    1 +
 hw/scsi/ncr53c710.c         | 2477 +++++++++++++++++++++++++++++++++++
 hw/scsi/ncr53c710.h         |  270 ++++
 hw/scsi/trace-events        |   33 +
 include/hw/misc/lasi.h      |    2 +
 pc-bios/hppa-firmware.img   |  Bin 167644 -> 630056 bytes
 pc-bios/hppa-firmware64.img |  Bin 206104 -> 699872 bytes
 roms/seabios-hppa           |    2 +-
 15 files changed, 3256 insertions(+), 10 deletions(-)
 create mode 100644 hw/scsi/lasi_ncr710.c
 create mode 100644 hw/scsi/lasi_ncr710.h
 create mode 100644 hw/scsi/ncr53c710.c
 create mode 100644 hw/scsi/ncr53c710.h

-- 
2.51.0


