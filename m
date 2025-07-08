Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37772C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEar-0003yD-CW; Tue, 08 Jul 2025 16:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uZDRs-0000WK-JR; Tue, 08 Jul 2025 14:53:57 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uZDRY-00087Z-08; Tue, 08 Jul 2025 14:53:44 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 13:58:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 8 Jul 2025 13:58:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v4 0/5] ASPEED OTP QEMU model: block backend, machine alias,
 SoC integration
Date: Tue, 8 Jul 2025 13:57:52 +0800
Message-ID: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

This patch series extends the QEMU model for the ASPEED OTP (One-Time
Programmable) memory device with block backend support and tighter
integration with the SoC and machine configuration.

The OTP model simulates a simple fuse array, used in ASPEED SoCs
for secure boot and configuration purposes. The updated model now
supports loading initial OTP content from a file via the QEMU CLI.

Example usage:
  ./qemu-system-arm \
    -machine ast2600-evb,otpmem=otp \
    -blockdev driver=file,filename=otpmem.img,node-name=otp \
    -global aspeed-otp.drive=otp \
    ...

ChangeLog
---------
v4:
- Add a 'drive' property to allow backing OTP data with a block device
- Expose a machine parameter (`-machine otpmem=XXX`) for convenient
  aliasing of the OTP drive via QOM path

v3:
- Switched to object_property_set_int() for setting "size"
- Simplified qdev_realize() error handling by passing errp directly
- Added "drive" property to OTP model for future extensibility

v2:
- Rename device from 'aspeed_otpmem' to 'aspeed_otp' and move it to hw/nvram/
- Move OTP device realization from instance_init to the realize function
- Improve error logging with qemu_log_mask() and remove unused error propagation

v1:
- Initial version

---

Kane-Chen-AS (5):
  hw/misc/aspeed_otp: Add ASPEED OTP memory device model
  hw/misc/aspeed_sbc: Connect ASPEED OTP memory device to SBC
  hw/arm: Integrate ASPEED OTP memory support into AST2600 SoCs
  hw/misc/aspeed_otp: Add 'drive' property to support block backend
  hw/misc/aspeed_sbc: Add machine parameter to alias OTP drive property

 include/hw/misc/aspeed_sbc.h  |   5 ++
 include/hw/nvram/aspeed_otp.h |  33 ++++++++++
 hw/arm/aspeed.c               |  20 ++++++
 hw/arm/aspeed_ast2600.c       |   2 +-
 hw/misc/aspeed_sbc.c          | 121 ++++++++++++++++++++++++++++++++++
 hw/nvram/aspeed_otp.c         | 113 +++++++++++++++++++++++++++++++
 hw/misc/trace-events          |   5 ++
 hw/nvram/meson.build          |   4 ++
 8 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/nvram/aspeed_otp.h
 create mode 100644 hw/nvram/aspeed_otp.c

-- 
2.43.0


