Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF00C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eSP-0003K9-Qn; Tue, 29 Apr 2025 02:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9eSL-0003GO-6Q
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:28:37 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9eSI-0007AI-FB
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:28:36 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 29 Apr
 2025 14:28:22 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 29 Apr 2025 14:28:22 +0800
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, "Alexey
 Kardashevskiy" <aik@ozlabs.ru>, Hao Wu <wuhaotsh@google.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Sunil V L <sunilvl@ventanamicro.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v8 1/1] pc-bios: Add AST27x0 vBootrom
Date: Tue, 29 Apr 2025 14:28:20 +0800
Message-ID: <20250429062822.1184920-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429062822.1184920-1-jamin_lin@aspeedtech.com>
References: <20250429062822.1184920-1-jamin_lin@aspeedtech.com>
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

The boot ROM is a minimal implementation designed to load an AST27x0 boot image.
Its source code is available at:
https://github.com/google/vbootrom
Commit id: d6e3386709b3e49322a94ffadc2aaab9944ab77b
Build Information:
```
Build Date : Apr 29 2025 01:23:18
FW Version : git-d6e3386
```

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
---
 MAINTAINERS                 |   1 +
 pc-bios/README              |   6 ++++++
 pc-bios/ast27x0_bootrom.bin | Bin 0 -> 15552 bytes
 pc-bios/meson.build         |   1 +
 4 files changed, 8 insertions(+)
 create mode 100644 pc-bios/ast27x0_bootrom.bin

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..70ab0d0afa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1163,6 +1163,7 @@ F: docs/system/arm/fby35.rst
 F: tests/*/*aspeed*
 F: tests/*/*ast2700*
 F: hw/arm/fby35.c
+F: pc-bios/ast27x0_bootrom.bin
 
 NRF51
 M: Joel Stanley <joel@jms.id.au>
diff --git a/pc-bios/README b/pc-bios/README
index f0f13e15f2..d009c37895 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -89,6 +89,12 @@
   more features over time as needed. The source code is available at:
   https://github.com/google/vbootrom
 
+- ast27x0_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
+  ASPEED AST27x0 BMC SOC. It currently implements the bare minimum to
+  load, parse, initialize and run boot images stored in SPI flash, but may grow
+  more features over time as needed. The source code is available at:
+  https://github.com/google/vbootrom
+
 - hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
   files for the HP-PARISC (hppa) architecture.
   They are built form the SeaBIOS-hppa sources, which is a fork of SeaBIOS
diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
new file mode 100644
index 0000000000000000000000000000000000000000..0b9b3a2360e375bb6007ecdf13b39d931870f6fa
GIT binary patch
literal 15552
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
F{ugK9U^D;#

literal 0
HcmV?d00001

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 34d6616c32..7d6f25eff8 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -28,6 +28,7 @@ if unpack_edk2_blobs
 endif
 
 blobs = [
+  'ast27x0_bootrom.bin',
   'bios.bin',
   'bios-256k.bin',
   'bios-microvm.bin',
-- 
2.43.0


