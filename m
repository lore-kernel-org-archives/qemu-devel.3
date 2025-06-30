Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE511C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 05:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6tj-0005Xi-P3; Mon, 30 Jun 2025 01:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW6th-0005XI-JY; Mon, 30 Jun 2025 01:17:41 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW6tf-0003fn-RM; Mon, 30 Jun 2025 01:17:41 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Jun
 2025 13:17:21 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 13:17:21 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC
Date: Mon, 30 Jun 2025 13:17:19 +0800
Message-ID: <20250630051721.254207-3-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630051721.254207-1-kane_chen@aspeedtech.com>
References: <20250630051721.254207-1-kane_chen@aspeedtech.com>
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

This patch connects the aspeed.otp device to the ASPEED Secure Boot
Controller (SBC) model. It implements OTP memory access via the SBC's
command interface and enables emulation of secure fuse programming flows.

The following OTP commands are supported:
  - READ: reads a 32-bit word from OTP memory into internal registers
  - PROG: programs a 32-bit word value to the specified OTP address

Trace events are added to observe read/program operations and command
handling flow.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_sbc.h |   5 ++
 hw/misc/aspeed_sbc.c         | 111 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events         |   5 ++
 3 files changed, 121 insertions(+)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 405e6782b9..0c2746d392 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -10,6 +10,7 @@
 #define ASPEED_SBC_H
 
 #include "hw/sysbus.h"
+#include "hw/nvram/aspeed_otp.h"
 
 #define TYPE_ASPEED_SBC "aspeed.sbc"
 #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
@@ -36,10 +37,14 @@ struct AspeedSBCState {
     MemoryRegion iomem;
 
     uint32_t regs[ASPEED_SBC_NR_REGS];
+
+    AspeedOTPState otp;
 };
 
 struct AspeedSBCClass {
     SysBusDeviceClass parent_class;
+
+    bool has_otp;
 };
 
 #endif /* ASPEED_SBC_H */
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index a7d101ba71..46a038337c 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -15,9 +15,13 @@
 #include "hw/misc/aspeed_sbc.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
 #define R_PROT          (0x000 / 4)
+#define R_CMD           (0x004 / 4)
+#define R_ADDR          (0x010 / 4)
 #define R_STATUS        (0x014 / 4)
+#define R_CAMP1         (0x020 / 4)
 #define R_QSR           (0x040 / 4)
 
 /* R_STATUS */
@@ -41,6 +45,11 @@
 #define QSR_RSA_MASK           (0x3 << 12)
 #define QSR_HASH_MASK          (0x3 << 10)
 
+#define OTP_MEMORY_SIZE 0x4000
+/* OTP command */
+#define SBC_OTP_CMD_READ 0x23b1e361
+#define SBC_OTP_CMD_PROG 0x23b1e364
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -57,6 +66,84 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
     return s->regs[addr];
 }
 
+static bool aspeed_sbc_otp_read(AspeedSBCState *s,
+                                   uint32_t otp_addr)
+{
+    MemTxResult ret;
+    AspeedOTPState *otp = &s->otp;
+    uint32_t value, otp_offset;
+
+    otp_offset = otp_addr << 2;
+    ret = address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
+                             &value, sizeof(value));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Failed to read OTP memory, addr = %x\n",
+                      otp_addr);
+        return false;
+    }
+    s->regs[R_CAMP1] = value;
+    trace_aspeed_sbc_otp_read(otp_addr, value);
+
+    return true;
+}
+
+static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
+                                   uint32_t otp_addr)
+{
+    MemTxResult ret;
+    AspeedOTPState *otp = &s->otp;
+    uint32_t value = s->regs[R_CAMP1];
+
+    ret = address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED,
+                        &value, sizeof(value));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Failed to write OTP memory, addr = %x\n",
+                      otp_addr);
+        return false;
+    }
+
+    trace_aspeed_sbc_otp_prog(otp_addr, value);
+
+    return true;
+}
+
+static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(opaque);
+    bool ret = false;
+    uint32_t otp_addr;
+
+    if (!sc->has_otp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: OTP memory is not supported\n",
+                      __func__);
+        return;
+    }
+
+    s->regs[R_STATUS] &= ~(OTP_MEM_IDLE | OTP_IDLE);
+    otp_addr = s->regs[R_ADDR];
+
+    switch (cmd) {
+    case SBC_OTP_CMD_READ:
+        ret = aspeed_sbc_otp_read(s, otp_addr);
+        break;
+    case SBC_OTP_CMD_PROG:
+        ret = aspeed_sbc_otp_prog(s, otp_addr);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unknown command 0x%x\n",
+                      __func__, cmd);
+        break;
+    }
+
+    trace_aspeed_sbc_handle_cmd(cmd, otp_addr, ret);
+    s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
+}
+
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                               unsigned int size)
 {
@@ -78,6 +165,9 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                       "%s: write to read only register 0x%" HWADDR_PRIx "\n",
                       __func__, addr << 2);
         return;
+    case R_CMD:
+        aspeed_sbc_handle_command(opaque, data);
+        return;
     default:
         break;
     }
@@ -115,10 +205,30 @@ static void aspeed_sbc_reset(DeviceState *dev)
     s->regs[R_QSR] = s->signing_settings;
 }
 
+static void aspeed_sbc_instance_init(Object *obj)
+{
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(obj);
+    AspeedSBCState *s = ASPEED_SBC(obj);
+
+    if (sc->has_otp) {
+        object_initialize_child(OBJECT(s), "otp", &s->otp,
+                                TYPE_ASPEED_OTP);
+    }
+}
+
 static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSBCState *s = ASPEED_SBC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(dev);
+
+    if (sc->has_otp) {
+        object_property_set_int(OBJECT(&s->otp), "size",
+                                OTP_MEMORY_SIZE, &error_abort);
+        if (!qdev_realize(DEVICE(&s->otp), NULL, errp)) {
+            return;
+        }
+    }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
             TYPE_ASPEED_SBC, 0x1000);
@@ -155,6 +265,7 @@ static const TypeInfo aspeed_sbc_info = {
     .name = TYPE_ASPEED_SBC,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedSBCState),
+    .instance_init = aspeed_sbc_instance_init,
     .class_init = aspeed_sbc_class_init,
     .class_size = sizeof(AspeedSBCClass)
 };
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e3f64c0ff6..9e05b82f37 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -90,6 +90,11 @@ slavio_sysctrl_mem_readl(uint32_t ret) "Read system control 0x%08x"
 slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
 slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
 
+# aspeed_sbc.c
+aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
+aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
+aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
+
 # aspeed_scu.c
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
-- 
2.43.0


