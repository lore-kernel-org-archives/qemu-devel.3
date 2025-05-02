Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D770BC3ABBA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnkw-00015V-K1; Fri, 02 May 2025 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAnk6-0008N8-Ku; Fri, 02 May 2025 06:35:43 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAnk4-0006n4-Qj; Fri, 02 May 2025 06:35:42 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 2 May
 2025 18:34:52 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 2 May 2025 18:34:52 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH v4 9/9] docs: Add support for ast2700fc machine
Date: Fri, 2 May 2025 18:34:45 +0800
Message-ID: <20250502103449.3091642-10-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502103449.3091642-1-steven_lee@aspeedtech.com>
References: <20250502103449.3091642-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Updated Aspeed family boards list to include `ast2700fc`.
- Added boot instructions for the `ast2700fc` machine.
- Detailed the configuration and loading of firmware for the
  Cortex-A35 and Cortex-M4 processors.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: Id41312e9c7cf79bc55c6f24a87a7ad9993dc7261
---
 docs/system/arm/aspeed.rst | 69 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 014545f444..58a8020eec 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-==================================================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``ast2700fc``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+=================================================================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -255,6 +255,7 @@ etc.
 AST2700 SoC based machines :
 
 - ``ast2700-evb``          Aspeed AST2700 Evaluation board (Cortex-A35)
+- ``ast2700fc``            Aspeed AST2700 Evaluation board (Cortex-A35 + Cortex-M4)
 
 Supported devices
 -----------------
@@ -285,7 +286,6 @@ Supported devices
 
 Missing devices
 ---------------
- * Coprocessor support
  * PWM and Fan Controller
  * Slave GPIO Controller
  * Super I/O Controller
@@ -353,6 +353,69 @@ specified path in the ${HOME} directory.
 
   -bios ${HOME}/ast27x0_bootrom.bin
 
+Booting the ast2700fc machine
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+AST2700 features four Cortex-A35 primary processors and two Cortex-M4 coprocessors.
+**ast2700-evb** machine focuses on emulating the four Cortex-A35 primary processors,
+**ast2700fc** machine extends **ast2700-evb** by adding support for the two Cortex-M4 coprocessors.
+
+Steps to boot the AST2700fc machine:
+
+1. Ensure you have the following AST2700A1 binaries available in a directory
+
+ * u-boot-nodtb.bin
+ * u-boot.dtb
+ * bl31.bin
+ * optee/tee-raw.bin
+ * image-bmc
+ * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)
+ * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)
+
+2. Execute the following command to start ``ast2700fc`` machine:
+
+.. code-block:: bash
+
+  IMGDIR=ast2700-default
+  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
+
+  $ qemu-system-aarch64 -M ast2700fc \
+       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
+       -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
+       -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
+       -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
+       -device loader,cpu-num=0,addr=0x430000000 \
+       -device loader,cpu-num=1,addr=0x430000000 \
+       -device loader,cpu-num=2,addr=0x430000000 \
+       -device loader,cpu-num=3,addr=0x430000000 \
+       -drive file=${IMGDIR}/image-bmc,if=mtd,format=raw \
+       -device loader,file=${IMGDIR}/zephyr-aspeed-ssp.elf,cpu-num=4 \
+       -device loader,file=${IMGDIR}/zephyr-aspeed-tsp.elf,cpu-num=5 \
+       -serial pty -serial pty -serial pty \
+       -snapshot \
+       -S -nographic
+
+After launching QEMU, serial devices will be automatically redirected.
+Example output:
+
+.. code-block:: bash
+
+   char device redirected to /dev/pts/55 (label serial0)
+   char device redirected to /dev/pts/56 (label serial1)
+   char device redirected to /dev/pts/57 (label serial2)
+
+- serial0: Console for the four Cortex-A35 primary processors.
+- serial1 and serial2: Consoles for the two Cortex-M4 coprocessors.
+
+Use ``tio`` or another terminal emulator to connect to the consoles:
+
+.. code-block:: bash
+
+   $ tio /dev/pts/55
+   $ tio /dev/pts/56
+   $ tio /dev/pts/57
+
+
 Aspeed minibmc family boards (``ast1030-evb``)
 ==================================================================
 
-- 
2.34.1


