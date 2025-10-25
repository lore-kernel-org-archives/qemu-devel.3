Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D19CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCgz8-0004mR-IG; Sat, 25 Oct 2025 12:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgz7-0004m5-0V
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:17 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgz4-00049D-PE
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 369304508E;
 Sat, 25 Oct 2025 16:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7712BC4CEF5;
 Sat, 25 Oct 2025 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409145;
 bh=IwwcrkyRAxP+UZG2knDprMgmqQAMEBHIojF+8FwR1o0=;
 h=From:To:Cc:Subject:Date:From;
 b=OLgc7LPvLq00Ur4gcSkRIVt9X9XKBZMavu1TPS1T0piXQVlEUvcFhuo2O5FcE62y9
 d05v0ju32piDyo6qlhIDZrP7nd9uLbZ7zcOuIn9ILAFZb0UmhYPRTxUA+eA0E/dZEK
 m8Kwjv+lIo0x7SCQG9ZBO5NSPIxH/jd4pa729cKAobivRGenA9l+UCY87zafu6qaH8
 IZ7Gd/UoP8RqOF0YF/St3KAr+BxtdcAuKyy+DEAn5MtBmSJB4Ovp/fG87BmO4/GLpy
 kwyahjtqYkpoCSf3D7bnmNbGOymj5L03DW4Rc+UtI8HY6bn+WPrlEmh0TbyWGbE58y
 BJtA0+aXwYmeA==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 00/11] HP-PARISC 715 machine with NCR710 SCSI chip
Date: Sat, 25 Oct 2025 18:18:50 +0200
Message-ID: <20251025161901.32710-1-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Second round for review:
- previous big SCSI patch has been splitted up -> now patches #2 and #3
- Soumyajyotii has heavily cleaned up the SCSI driver (patches #2 & #3)
- I have reviewed the SCSI patches (#2 and #3), of course additional review
  is welcome.
- added R-b tags to patches #4 - #7
- new review needed for patches #8 & patch #9, both changed according to Richard's feedback.

---------

Additional generic info:

This patch series adds a new emulation for a HP PA-RISC 715/64 model,
as descrived here:
https://www.openpa.net/systems/hp-9000_715.html.

That machine has no PCI bus and instead uses a "LASI" chip which has built-in
NCR 53c710 SCSI and i82596 network chips. Compared to the other already
emulated machines B160L and C3700, this machine should be able to support older
operating systems like HP-UX 9 as well.

The QEMU project participated in the Google Summer of Code 2025 program by
"Implementing LASI Network Card and NCR 710 SCSI Controller Device Models", and
Soumyajyotii Ssarkar stepped up to develop those drivers.

This patch series includes the code for the NCR710 SCSI controller,
the network code will follow in later patch series.

Helge & Soumyajyotii

Helge Deller (7):
  target/hppa: Update SeaBIOS-hppa to version 19
  hw/hppa: Fix firmware end address for LASI chip
  hw/hppa: Fix interrupt of LASI parallel port
  hw/hppa: Add NCR 710 SCSI driver to LASI chip Kconfig entry
  hw/hppa: PCI devices depend on availability of PCI bus
  hw/hppa: Require SeaBIOS version 19 for 715 machine
  hw/hppa: Add 715 machine type including NCR710 SCSI

Soumyajyotii Ssarkar (4):
  lasi_ncr710: Add LASI wrapper for NCR 53c710 SCSI chip
  ncr710: Add driver for the NCR 53c710 SCSI chip
  lasi: Forward LASI SCSI ports to NCR 53c710 driver
  hw/scsi: Add config option for new ncr710 driver

 MAINTAINERS                 |    2 +
 hw/hppa/Kconfig             |    2 -
 hw/hppa/hppa_hardware.h     |    3 +-
 hw/hppa/machine.c           |  127 +-
 hw/misc/Kconfig             |    5 +
 hw/misc/lasi.c              |    6 +-
 hw/scsi/Kconfig             |    5 +
 hw/scsi/lasi_ncr710.c       |  282 ++++
 hw/scsi/lasi_ncr710.h       |   57 +
 hw/scsi/meson.build         |    1 +
 hw/scsi/ncr53c710.c         | 2432 +++++++++++++++++++++++++++++++++++
 hw/scsi/ncr53c710.h         |  246 ++++
 hw/scsi/trace-events        |   29 +
 include/hw/misc/lasi.h      |    2 +
 pc-bios/hppa-firmware.img   |  Bin 167644 -> 630056 bytes
 pc-bios/hppa-firmware64.img |  Bin 206104 -> 699872 bytes
 roms/seabios-hppa           |    2 +-
 17 files changed, 3179 insertions(+), 22 deletions(-)
 create mode 100644 hw/scsi/lasi_ncr710.c
 create mode 100644 hw/scsi/lasi_ncr710.h
 create mode 100644 hw/scsi/ncr53c710.c
 create mode 100644 hw/scsi/ncr53c710.h

-- 
2.51.0


