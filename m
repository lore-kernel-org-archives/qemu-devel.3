Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC93CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsRv-0007Nb-MR; Sun, 31 May 2026 22:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRu-0007N9-Il; Sun, 31 May 2026 22:32:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRt-0004V7-5d; Sun, 31 May 2026 22:32:18 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 10:31:51 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 10:31:51 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 6/6] docs/system/arm: Document AST1040 Caliptra mailbox
Date: Mon, 1 Jun 2026 10:31:47 +0800
Message-ID: <20260601023149.2309299-7-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
References: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
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

Document the AST1040 Caliptra MCI mailbox windows, the SCU-controlled remap aperture, and how to connect the external mailbox peer through a chardev backend.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 docs/system/arm/aspeed.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 2d51ceeb84..1ffa88c2ae 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -483,6 +483,7 @@ Supported devices
  * ADC
  * Secure Boot Controller
  * PECI Controller (minimal)
+ * Caliptra MCI mailbox (AST1040 only)
 
 
 Missing devices
@@ -512,3 +513,34 @@ To boot a kernel directly from a Zephyr build tree:
 
   $ qemu-system-arm -M ast1030-evb -nographic \
         -kernel zephyr.bin
+
+Caliptra MCI mailbox (ast1040-evb)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The AST1040 chip provides a mechanism to map the Caliptra MCI mailbox
+register space into the Cortex-M4F address space. The Caliptra MCI mailbox
+SRAM and CSR are accessible at fixed addresses:
+
+- Mailbox SRAM at ``0x21400000`` (2 MiB, command/response payload)
+- Mailbox CSR  at ``0x21600000`` (4 KiB, LOCK/CMD/DLEN/EXECUTE/STATUS)
+
+The SCU ``CPTRA_PAGE_REG0`` register (at ``0x74C02120``) selects which
+Caliptra MCI page (SRAM or CSR) is exposed through the 4 KiB aperture at
+``0x74200000``, allowing firmware to access either window through a single
+address.
+
+By default the mailbox has no Caliptra peer, so writing ``EXECUTE`` reports
+``CMD_FAILURE``. To service commands with an external Caliptra simulator (for
+example caliptra-server) over a UNIX socket, start the simulator first, then
+create an external peer device and link it with the machine's ``cptra-peer``
+option:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M ast1040-evb,cptra-peer=peer0 -nographic \
+        -chardev socket,id=cptra0,path=/tmp/mcu_mbox.sock \
+        -device cptra-mbox-peer-extern,id=peer0,chardev=cptra0 \
+        -kernel zephyr.elf
+
+Writing ``EXECUTE`` bridges the command and the mailbox SRAM payload to the
+peer over the socket, and writes the response back into the mailbox SRAM.
-- 
2.43.0


