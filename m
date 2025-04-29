Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6C1C3ABA3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 02:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9aGX-0001Wh-7R; Mon, 28 Apr 2025 22:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9aGE-0001CO-72
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 21:59:53 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9aGA-0000Uu-FP
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 21:59:49 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 29 Apr
 2025 09:59:39 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 29 Apr 2025 09:59:38 +0800
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, "Alexey
 Kardashevskiy" <aik@ozlabs.ru>, Hao Wu <wuhaotsh@google.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>
Subject: [PATCH v7 0/1] Support vbootrom for AST2700
Date: Tue, 29 Apr 2025 09:59:33 +0800
Message-ID: <20250429015938.74359-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1:
  Add initial support for AST27x0
  The purpose of vbootrom here is to simulate the work of BootMCU SPL (riscv)
  in AST2700, because QEMU doesn't support heterogenous architecture yet.

  ast27x0_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
  ASPEED AST27x0 BMC SOC. It currently implements the bare minimum to
  load, parse, initialize and run boot images stored in SPI flash, but may grow
  more features over time as needed. The source code is available at:
  https://github.com/google/vbootrom

v2:
  Add "Introduced ASPEED_DEV_VBOOTROM in the device enumeration" patch to fix
  build failed.

v3:
  1. Supports both vbootrom and device loader boot methods, with vbootrom used as
  the default.
  2. Fix review and QTEST test failed issues. 

v4: 
  Adjust the patch order.
  
v5:
  fix review issue and remove unnecessary class attribure.
  doc: create a new section for AST2700.
  
v6:
  fix review issue.
  Add google/vbootrom commit id for ast27x0
  split to patch to update documentataion for ast27x0

v7:
  update vbootrom pre-built image and add its build info

Jamin Lin (1):
  pc-bios: Add AST27x0 vBootrom

 MAINTAINERS                 |   1 +
 pc-bios/README              |   6 ++++++
 pc-bios/ast27x0_bootrom.bin | Bin 0 -> 15552 bytes
 pc-bios/meson.build         |   1 +
 4 files changed, 8 insertions(+)
 create mode 100644 pc-bios/ast27x0_bootrom.bin

-- 
2.43.0


