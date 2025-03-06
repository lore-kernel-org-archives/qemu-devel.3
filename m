Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0A1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8gV-0002oU-Tq; Thu, 06 Mar 2025 05:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8fb-0001KH-4T; Thu, 06 Mar 2025 05:41:39 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8fU-0000om-JS; Thu, 06 Mar 2025 05:41:38 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 6 Mar
 2025 18:38:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 6 Mar 2025 18:38:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 29/29] docs/specs: Add aspeed-intc
Date: Thu, 6 Mar 2025 18:38:37 +0800
Message-ID: <20250306103846.429221-30-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add AST2700 INTC design guidance and its block diagram.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 docs/specs/aspeed-intc.rst | 136 +++++++++++++++++++++++++++++++++++++
 docs/specs/index.rst       |   1 +
 2 files changed, 137 insertions(+)
 create mode 100644 docs/specs/aspeed-intc.rst

diff --git a/docs/specs/aspeed-intc.rst b/docs/specs/aspeed-intc.rst
new file mode 100644
index 0000000000..9cefd7f37f
--- /dev/null
+++ b/docs/specs/aspeed-intc.rst
@@ -0,0 +1,136 @@
+===========================
+ASPEED Interrupt Controller
+===========================
+
+AST2700
+-------
+There are a total of 480 interrupt sources in AST2700. Due to the limitation of
+interrupt numbers of processors, the interrupts are merged every 32 sources for
+interrupt numbers greater than 127.
+
+There are two levels of interrupt controllers, INTC (CPU Die) and INTCIO
+(I/O Die).
+
+Interrupt Mapping
+-----------------
+- INTC: Handles interrupt sources 0 - 127 and integrates signals from INTCIO.
+- INTCIO: Handles interrupt sources 128 - 319 independently.
+
+QEMU Support
+------------
+Currently, only GIC 192 to 201 are supported, and their source interrupts are
+from INTCIO and connected to INTC at input pin 0 and output pins 0 to 9 for
+GIC 192-201.
+
+Design for GICINT 196
+---------------------
+The orgate has interrupt sources ranging from 0 to 31, with its output pin
+connected to INTCIO "T0 GICINT_196". The output pin is then connected to INTC
+"GIC_192_201" at bit 4, and its bit 4 output pin is connected to GIC 196.
+
+INTC GIC_192_201 Output Pin Mapping
+-----------------------------------
+The design of INTC GIC_192_201 have 10 output pins, mapped as following:
+
+====  ====
+Bit   GIC
+====  ====
+0     192
+1     193
+2     194
+3     195
+4     196
+5     197
+6     198
+7     199
+8     200
+9     201
+====  ====
+
+AST2700 A0
+----------
+It has only one INTC controller, and currently, only GIC 128-136 is supported.
+To support both AST2700 A1 and AST2700 A0, there are 10 OR gates in the INTC,
+with gates 1 to 9 supporting GIC 128-136.
+
+Design for GICINT 132
+---------------------
+The orgate has interrupt sources ranging from 0 to 31, with its output pin
+connected to INTC. The output pin is then connected to GIC 132.
+
+Block Diagram of GICINT 196 for AST2700 A1 and GICINT 132 for AST2700 A0
+------------------------------------------------------------------------
+
+.. code-block::
+
+   |-------------------------------------------------------------------------------------------------------|
+   |                                                   AST2700 A1 Design                                   |
+   |           To GICINT196                                                                                |
+   |                                                                                                       |
+   |   ETH1    |-----------|                    |--------------------------|        |--------------|       |
+   |  -------->|0          |                    |         INTCIO           |        |  orgates[0]  |       |
+   |   ETH2    |          4|   orgates[0]------>|inpin[0]-------->outpin[0]|------->| 0            |       |
+   |  -------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|------->| 1            |       |
+   |   ETH3    |          6|   orgates[2]------>|inpin[2]-------->outpin[2]|------->| 2            |       |
+   |  -------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|------->| 3  OR[0:9]   |-----| |
+   |   UART0   |         20|-->orgates[4]------>|inpin[4]-------->outpin[4]|------->| 4            |     | |
+   |  -------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|------->| 5            |     | |
+   |   UART1   |         22|   orgates[6]------>|inpin[6]-------->outpin[6]|------->| 6            |     | |
+   |  -------->|8        23|   orgates[7]------>|inpin[7]-------->outpin[7]|------->| 7            |     | |
+   |   UART2   |         24|   orgates[8]------>|inpin[8]-------->outpin[8]|------->| 8            |     | |
+   |  -------->|9        25|   orgates[9]------>|inpin[9]-------->outpin[9]|------->| 9            |     | |
+   |   UART3   |         26|                    |--------------------------|        |--------------|     | |
+   |  ---------|10       27|                                                                             | |
+   |   UART5   |         28|                                                                             | |
+   |  -------->|11       29|                                                                             | |
+   |   UART6   |           |                                                                             | |
+   |  -------->|12       30|     |-----------------------------------------------------------------------| |
+   |   UART7   |         31|     |                                                                         |
+   |  -------->|13         |     |                                                                         |
+   |   UART8   |  OR[0:31] |     |                |------------------------------|           |----------|  |
+   |  -------->|14         |     |                |            INTC              |           |     GIC  |  |
+   |   UART9   |           |     |                |inpin[0:0]--------->outpin[0] |---------->|192       |  |
+   |  -------->|15         |     |                |inpin[0:1]--------->outpin[1] |---------->|193       |  |
+   |   UART10  |           |     |                |inpin[0:2]--------->outpin[2] |---------->|194       |  |
+   |  -------->|16         |     |                |inpin[0:3]--------->outpin[3] |---------->|195       |  |
+   |   UART11  |           |     |--------------> |inpin[0:4]--------->outpin[4] |---------->|196       |  |
+   |  -------->|17         |                      |inpin[0:5]--------->outpin[5] |---------->|197       |  |
+   |   UART12  |           |                      |inpin[0:6]--------->outpin[6] |---------->|198       |  |
+   |  -------->|18         |                      |inpin[0:7]--------->outpin[7] |---------->|199       |  |
+   |           |-----------|                      |inpin[0:8]--------->outpin[8] |---------->|200       |  |
+   |                                              |inpin[0:9]--------->outpin[9] |---------->|201       |  |
+   |-------------------------------------------------------------------------------------------------------|
+   |-------------------------------------------------------------------------------------------------------|
+   |  ETH1    |-----------|     orgates[1]------->|inpin[1]----------->outpin[10]|---------->|128       |  |
+   | -------->|0          |     orgates[2]------->|inpin[2]----------->outpin[11]|---------->|129       |  |
+   |  ETH2    |          4|     orgates[3]------->|inpin[3]----------->outpin[12]|---------->|130       |  |
+   | -------->|1         5|     orgates[4]------->|inpin[4]----------->outpin[13]|---------->|131       |  |
+   |  ETH3    |          6|---->orgates[5]------->|inpin[5]----------->outpin[14]|---------->|132       |  |
+   | -------->|2        19|     orgates[6]------->|inpin[6]----------->outpin[15]|---------->|133       |  |
+   |  UART0   |         20|     orgates[7]------->|inpin[7]----------->outpin[16]|---------->|134       |  |
+   | -------->|7        21|     orgates[8]------->|inpin[8]----------->outpin[17]|---------->|135       |  |
+   |  UART1   |         22|     orgates[9]------->|inpin[9]----------->outpin[18]|---------->|136       |  |
+   | -------->|8        23|                       |------------------------------|           |----------|  |
+   |  UART2   |         24|                                                                                |
+   | -------->|9        25|                       AST2700 A0 Design                                        |
+   |  UART3   |         26|                                                                                |
+   | -------->|10       27|                                                                                |
+   |  UART5   |         28|                                                                                |
+   | -------->|11       29| GICINT132                                                                      |
+   |  UART6   |           |                                                                                |
+   | -------->|12       30|                                                                                |
+   |  UART7   |         31|                                                                                |
+   | -------->|13         |                                                                                |
+   |  UART8   |  OR[0:31] |                                                                                |
+   | -------->|14         |                                                                                |
+   |  UART9   |           |                                                                                |
+   | -------->|15         |                                                                                |
+   |  UART10  |           |                                                                                |
+   | -------->|16         |                                                                                |
+   |  UART11  |           |                                                                                |
+   | -------->|17         |                                                                                |
+   |  UART12  |           |                                                                                |
+   | -------->|18         |                                                                                |
+   |          |-----------|                                                                                |
+   |                                                                                                       |
+   |-------------------------------------------------------------------------------------------------------|
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index d7675cebc2..f19d73c9f6 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -38,3 +38,4 @@ guest hardware that is specific to QEMU.
    rocker
    riscv-iommu
    riscv-aia
+   aspeed-intc
-- 
2.43.0


