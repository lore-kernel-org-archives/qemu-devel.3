Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D26FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 03:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK6ka-0003ye-0Z; Mon, 04 May 2026 23:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wK6kW-0003yN-TP; Mon, 04 May 2026 23:47:08 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wK6kT-00029X-9y; Mon, 04 May 2026 23:47:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 5 May
 2026 11:46:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 5 May 2026 11:46:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:All patches
 CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [RFC PATCH v2 0/1] hw/arm: aspeed: PoC integration for Caliptra Root
 of Trust
Date: Tue, 5 May 2026 11:46:53 +0800
Message-ID: <20260505034654.815746-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=twmbx01.aspeedtech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

This series is an RFC for modelling the Caliptra Root of Trust found
in the ASPEED ast27x0 family.

ast27x0 integrates a Caliptra 1.2 core as an on-die RoT block.
From the host side, the visible interface is a Caliptra APB register
window rather than a standardized external command protocol. QEMU does
not currently have a Caliptra emulator, and there is not yet an agreed
upstream model for how ASPEED Caliptra support should be structured.

On the real ast27x0, Caliptra bring-up and secure-boot
orchestration are handled by bootmcu rather than by the CA35 host CPUs.
In particular, bootmcu is expected to own the mailbox-driven
interaction with the Caliptra core during firmware loading and
verification. At a high level:

- bootmcu releases the Caliptra core from reset
- bootmcu loads the Caliptra FMC/runtime firmware through the mailbox path
- Caliptra verifies the images and boots to runtime-ready
- bootmcu then relies on Caliptra services as part of the platform
  secure-boot flow before CA35 firmware starts

QEMU does not currently model bootmcu or that orchestration flow.
Accordingly, this RFC does not attempt to model the final ast27x0
boot architecture. Instead, it uses the CA35-visible Caliptra MMIO/APB
window as an initial integration point to validate the
transport/backend split. A subsequent revision would wire this into
the proper bootmcu-owned boot path.

Changes since RFC v1:
- reworked the PoC to remove the direct `caliptra-sw` C-binding
  dependency from the QEMU build.
- dropped the sibling-tree auto-detection of external headers and
  libraries.
- replaced the in-process Caliptra model with an external
  `caliptra-server` backend reached over a Unix socket.
- replaced the v1 worker-thread-based boot sequencing with a model
  where the backend is started independently and is already
  runtime-ready when QEMU connects.
- removed the use of `vm_stop_force_state()` to hold the CA35 until
  Caliptra boot completion.
- narrowed the QEMU-side PoC to the CA35-visible Caliptra MMIO/APB
  window on ast2700fc machine.

The patch in this RFC:
- adds an ASPEED-specific sysbus device for Caliptra emulation.
- exposes a 128 KiB MMIO window at 0x14c60000 on ast2700fc machine.
- forwards guest MMIO accesses to an external backend as APB
  read/write transactions over a Unix socket.
- assumes the backend is already running and ready before QEMU starts.

Current limitations of the PoC:
- no boot handshake between QEMU and the backend.
- synchronous socket round-trips on guest register access.
- no reset/migration/lifecycle integration.
- minimal wire protocol, designed to be replaced with a standardized
  IPC scheme.
- no modeling of bootmcu or the full secure-boot orchestration flow.

Testing:

  # Terminal 1: start the external backend and wait for runtime-ready.
  caliptra-server \
      --socket /tmp/caliptra.sock \
      --rom images/caliptra-rom.bin \
      --firmware images/caliptra-fw.bundle

  # The server boots caliptra-sw independently, then prints that it is
  # listening on the socket after boot_status reaches runtime-ready.

  # Terminal 2: launch QEMU after the socket is ready.
  qemu-system-aarch64 \
      -M ast2700fc,caliptra-socket=/tmp/caliptra.sock \
      ...

  # In the guest, exercise the Caliptra MMIO window and confirm the
  # APB transactions are forwarded to caliptra-server.
  #
  # The sequence below drives the mailbox CSR block at 0x30020000
  # through the AST2700fc window:
  #   0x00  LOCK     - confirm the mailbox CSR block is reachable
  #   0x08  CMD      - program the mailbox command opcode
  #   0x0c  DLEN     - declare the payload length
  #   0x10  DATAIN   - provide the checksum word required by CAPS
  #   0x18  EXECUTE  - doorbell to start command processing
  #   0x1c  STATUS   - read back the command result

md 0x14c60000 1        # Read LOCK to confirm the Caliptra mailbox CSR window is accessible.
mw 0x14c60008 0x43415053  # Write CMD = OP_CAPABILITIES ("CAPS").
mw 0x14c6000c 4        # Write DLEN = 4 bytes; CAPABILITIES carries only the checksum word.
mw 0x14c60010 0xFFFFFED9  # Write the checksum word expected by caliptra-sw for this CAPS request.
mw 0x14c60018 1        # Write EXECUTE = 1 to kick off mailbox command processing.
md 0x14c6001c 1        # Read STATUS to verify the command completed successfully.

The backend used for evaluation is currently based on the
`caliptra-1.2` branch of:
  https://github.com/chipsalliance/caliptra-sw

The reference `caliptra-server` implementation used in this RFC is
available at:
  https://github.com/stevenlee7189/caliptra-server

The intent here is not to propose this PoC as merge-ready. The goal is
to get feedback on whether this general direction makes sense for
ASPEED.

In particular, feedback is welcome on the following:

- Is a socket-connected external backend an acceptable direction for
  supporting a Caliptra core on ASPEED platforms, or should we pursue
  an alternative approach such as an in-process model or a different
  IPC mechanism?

Other comments on the design are also welcome.

Thanks,
Steven Lee

Steven Lee (1):
  hw/arm: aspeed: PoC integration for Caliptra Root of Trust

 MAINTAINERS                          |   2 +
 docs/system/arm/aspeed.rst           |  35 +++
 include/hw/arm/aspeed_caliptra_emu.h |  29 +++
 hw/arm/aspeed_ast27x0-fc.c           |  55 +++++
 hw/arm/aspeed_caliptra_emu.c         | 338 +++++++++++++++++++++++++++
 hw/arm/meson.build                   |   1 +
 6 files changed, 460 insertions(+)
 create mode 100644 include/hw/arm/aspeed_caliptra_emu.h
 create mode 100644 hw/arm/aspeed_caliptra_emu.c

-- 
2.43.0


