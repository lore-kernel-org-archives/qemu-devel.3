Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCADFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHbZ-0005oD-T2; Mon, 27 Apr 2026 04:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wHHbX-0005ns-J9; Mon, 27 Apr 2026 04:46:11 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wHHbV-0001C8-6z; Mon, 27 Apr 2026 04:46:11 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 27 Apr
 2026 16:40:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 27 Apr 2026 16:40:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [RFC PATCH v1 0/1] hw/arm: aspeed: PoC integration for Caliptra Root
 of Trust
Date: Mon, 27 Apr 2026 16:40:53 +0800
Message-ID: <20260427084055.2246089-1-steven_lee@aspeedtech.com>
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

Hi all,

The ASPEED AST2700fc SoC integrates the Caliptra Root of Trust
(Caliptra 1.2 core). Moving forward, we expect more SoCs to adopt
Caliptra cores (e.g., Caliptra 2.x). Currently, QEMU does not have
a native Caliptra emulator.

This RFC explores possible approaches for supporting Caliptra in QEMU.
The included patch provides a Proof of Concept (PoC) integration using
the external `caliptra-sw` C-binding emulator to enable booting the
AST2700fc machine.

This RFC does not propose merging the current PoC design as-is.
Instead, it is intended to gather early feedback on architecture and
integration strategy.

In this PoC, the `caliptra-sw` emulator is used as a reference model
to enable early bring-up and validation of the AST2700fc secure boot
flow, rather than as a final implementation choice. The integration is
based on the `caliptra-1.2` branch of the official repository:
https://github.com/chipsalliance/caliptra-sw/tree/caliptra-1.2

To avoid making normal ASPEED/AArch64 builds depend on a local external
checkout, the c-binding backend is compiled only when this PoC detects
the generated `caliptra-sw` c-binding header and static library in an
expected sibling source tree.  A mergeable version would need an
explicit configure option and a proper dependency integration.

Since QEMU currently lacks a `bootmcu` model and the associated mailbox
interactions with Caliptra, the PoC simplifies the boot flow by using
a background thread and the `caliptra_model_boot_default` C-binding to
simulate early boot stages.

To approximate the hardware behavior where the Cortex-A35 CPUs remain
in reset until secure boot is completed, the PoC uses
`vm_stop_force_state()` as a temporary approximation.

This approach is intentionally simplified and not intended to reflect
the final QEMU design. In particular, the use of a background thread
and global VM control APIs may not align with QEMU device model
expectations.

Support for the `bootmcu` model and a more accurate secure boot flow
is planned for future work.

Discussion points:

1. Emulator strategy:
   For early enablement, is it acceptable to rely on an external
   reference model such as `caliptra-sw`, or would the community
   prefer focusing directly on a native QEMU QOM device model?

2. Build system integration:
   If using the external `caliptra-sw` library is acceptable, what is
   the preferred integration method (e.g., git submodule, meson
   subproject, or system-installed library via pkg-config)?

3. Boot synchronization:
   In real hardware, CPUs are held in reset until the secure boot
   flow completes. What is the recommended way in QEMU to model such
   dependencies between devices and CPU startup?

Feedback and suggestions are highly appreciated.

Thanks,
Steven

Steven Lee (1):
  hw/arm: aspeed: Add PoC integration for Caliptra Root of Trust

 MAINTAINERS                          |   2 +
 docs/system/arm/aspeed.rst           |  20 +++
 include/hw/arm/aspeed_caliptra_emu.h |  17 ++
 hw/arm/aspeed_ast27x0-fc.c           |  60 +++++++
 hw/arm/aspeed_caliptra_emu.c         | 259 +++++++++++++++++++++++++++
 hw/arm/meson.build                   |  31 +++-
 6 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/arm/aspeed_caliptra_emu.h
 create mode 100644 hw/arm/aspeed_caliptra_emu.c

-- 
2.43.0

