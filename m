Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B77CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 09:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullVY-0007wE-4h; Tue, 12 Aug 2025 05:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullVS-0007mC-7K; Tue, 12 Aug 2025 05:41:22 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullVO-0000lv-6y; Tue, 12 Aug 2025 05:41:21 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 17:40:15 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 17:40:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 08/10] hw/misc/aspeed_sbc: Handle OTP write command for
 voltage mode registers
Date: Tue, 12 Aug 2025 17:40:05 +0800
Message-ID: <20250812094011.2617526-9-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Extend OTP command handling to recognize specific voltage mode register
addresses and emulate the expected hardware behavior. Without this
change, legitimate voltage mode change requests would be incorrectly
reported as "Unknown command" and logged as an error.

This implementation does not perform actual mode changes, but ensures
that valid requests are accepted and ignored as per hardware behavior.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/misc/aspeed_sbc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 787e2d0489..2fc5db749d 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -49,10 +49,17 @@
 #define OTP_MEMORY_SIZE 0x4000
 /* OTP command */
 #define SBC_OTP_CMD_READ 0x23b1e361
+#define SBC_OTP_CMD_WRITE 0x23b1e362
 #define SBC_OTP_CMD_PROG 0x23b1e364
 
 #define OTP_DATA_DWORD_COUNT        (0x800)
 #define OTP_TOTAL_DWORD_COUNT       (0x1000)
+
+/* Voltage mode */
+#define MODE_REGISTER               (0x1000)
+#define MODE_REGISTER_A             (0x3000)
+#define MODE_REGISTER_B             (0x5000)
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -115,6 +122,37 @@ static bool aspeed_sbc_otp_read(AspeedSBCState *s,
     return true;
 }
 
+static bool mode_handler(uint32_t otp_addr)
+{
+    switch (otp_addr) {
+    case MODE_REGISTER:
+    case MODE_REGISTER_A:
+    case MODE_REGISTER_B:
+        /* HW behavior, do nothing here */
+        return true;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Unsupported address 0x%x\n",
+                      otp_addr);
+        return false;
+    }
+}
+
+static bool aspeed_sbc_otp_write(AspeedSBCState *s,
+                                    uint32_t otp_addr)
+{
+    if (otp_addr == 0) {
+        trace_aspeed_sbc_ignore_cmd(otp_addr);
+        return true;
+    } else {
+        if (mode_handler(otp_addr) == false) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
                                    uint32_t otp_addr)
 {
@@ -157,6 +195,9 @@ static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
     case SBC_OTP_CMD_READ:
         ret = aspeed_sbc_otp_read(s, otp_addr);
         break;
+    case SBC_OTP_CMD_WRITE:
+        ret = aspeed_sbc_otp_write(s, otp_addr);
+        break;
     case SBC_OTP_CMD_PROG:
         ret = aspeed_sbc_otp_prog(s, otp_addr);
         break;
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 9e05b82f37..eeb9243898 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -91,6 +91,7 @@ slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
 slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
 
 # aspeed_sbc.c
+aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%" PRIx32
 aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
 aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
 aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
-- 
2.43.0


