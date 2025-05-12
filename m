Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF1BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPBH-0005SM-IJ; Mon, 12 May 2025 05:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uEPBE-0005Rc-63; Mon, 12 May 2025 05:10:36 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uEPBB-00056F-VM; Mon, 12 May 2025 05:10:35 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 12 May
 2025 17:10:15 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 12 May 2025 17:10:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC controller
Date: Mon, 12 May 2025 17:10:12 +0800
Message-ID: <20250512091014.3454083-3-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
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

Integrate the aspeed.otpmem backend with the ASPEED Secure Boot
Controller (SBC).

This patch adds command handling support in the SBC to read and program
the connected OTP memory using READ, WRITE, and PROG commands. It enables
basic interaction with OTP content for secure boot or fuse modeling logic.

Tracepoints are used to monitor command activity and unsupported paths.

The following QOM hierarchy illustrates how OTP is connected:

  /machine (ast1030-evb-machine)
    /soc (ast1030-a1)
      /sbc (aspeed.sbc-ast10X0)
        /aspeed.sbc[0] (memory-region)
        /otpmem (aspeed.otpmem)
          /aspeed.otpmem.backend[0] (memory-region)

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/misc/aspeed_sbc.c         | 179 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events         |   5 +
 include/hw/misc/aspeed_sbc.h |   5 +
 3 files changed, 189 insertions(+)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index a7d101ba71..237a8499d9 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -15,9 +15,14 @@
 #include "hw/misc/aspeed_sbc.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
 #define R_PROT          (0x000 / 4)
+#define R_CMD           (0x004 / 4)
+#define R_ADDR          (0x010 / 4)
 #define R_STATUS        (0x014 / 4)
+#define R_CAMP1         (0x020 / 4)
+#define R_CAMP2         (0x024 / 4)
 #define R_QSR           (0x040 / 4)
 
 /* R_STATUS */
@@ -41,6 +46,19 @@
 #define QSR_RSA_MASK           (0x3 << 12)
 #define QSR_HASH_MASK          (0x3 << 10)
 
+typedef enum {
+    SBC_OTP_CMD_READ = 0x23b1e361,
+    SBC_OTP_CMD_WRITE = 0x23b1e362,
+    SBC_OTP_CMD_PROG = 0x23b1e364,
+} SBC_OTP_Command;
+
+#define OTP_DATA_DWORD_COUNT        (0x800)
+#define OTP_TOTAL_DWORD_COUNT       (0x1000)
+
+#define MODE_REGISTER               (0x1000)
+#define MODE_REGISTER_A             (0x3000)
+#define MODE_REGISTER_B             (0x5000)
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -57,6 +75,143 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
     return s->regs[addr];
 }
 
+static bool aspeed_sbc_otpmem_read(AspeedSBCState *s,
+                                   uint32_t otp_addr, Error **errp)
+{
+    uint32_t data = 0, otp_offset;
+    bool is_data = false;
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(s);
+    const AspeedOTPMemOps *otp_ops;
+
+    if (sc->has_otpmem == false) {
+        trace_aspeed_sbc_otpmem_state("disabled");
+        return true;
+    }
+
+    otp_ops = aspeed_otpmem_get_ops(&s->otpmem);
+
+    if (otp_addr < OTP_DATA_DWORD_COUNT) {
+        is_data = true;
+    } else if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+        error_setg(errp, "Invalid OTP addr 0x%x", otp_addr);
+        return false;
+    }
+    otp_offset = otp_addr << 2;
+
+    data = otp_ops->read(&s->otpmem, otp_offset, errp);
+    if (*errp) {
+        return false;
+    }
+    s->regs[R_CAMP1] = data;
+
+    if (is_data) {
+        data = otp_ops->read(&s->otpmem, otp_offset + 4, errp);
+        if (*errp) {
+            return false;
+        }
+        s->regs[R_CAMP2] = data;
+    }
+
+    return true;
+}
+
+static bool mr_handler(uint32_t otp_addr, Error **errp)
+{
+    switch (otp_addr) {
+    case MODE_REGISTER:
+    case MODE_REGISTER_A:
+    case MODE_REGISTER_B:
+        /* HW behavior, do nothing here */
+        return true;
+    default:
+        error_setg(errp, "Unsupported address 0x%x", otp_addr);
+        return false;
+    }
+}
+
+static bool aspeed_sbc_otpmem_write(AspeedSBCState *s,
+                                    uint32_t otp_addr, Error **errp)
+{
+    if (otp_addr == 0) {
+        trace_aspeed_sbc_ignore_cmd(otp_addr);
+        return true;
+    } else if (otp_addr >= MODE_REGISTER) {
+        if (mr_handler(otp_addr, errp) == false) {
+            return false;
+        }
+    } else {
+        error_setg(errp, "Unhandled OTP write address 0x%x", otp_addr);
+        return false;
+    }
+
+    return true;
+}
+
+static bool aspeed_sbc_otpmem_prog(AspeedSBCState *s,
+                                   uint32_t otp_addr, Error **errp)
+{
+    uint32_t value;
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(s);
+    const AspeedOTPMemOps *otp_ops;
+
+    if (sc->has_otpmem == false) {
+        trace_aspeed_sbc_otpmem_state("disabled");
+        return true;
+    }
+
+    otp_ops = aspeed_otpmem_get_ops(&s->otpmem);
+    value = s->regs[R_CAMP1];
+    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+        error_setg(errp, "Invalid OTP addr 0x%x", otp_addr);
+        return false;
+    }
+
+    otp_ops->prog(&s->otpmem, otp_addr, value, errp);
+
+    if (*errp) {
+        return false;
+    }
+
+    return true;
+}
+
+static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    Error *local_err = NULL;
+    bool ret = false;
+    uint32_t otp_addr;
+
+    s->regs[R_STATUS] &= ~(OTP_MEM_IDLE | OTP_IDLE);
+    otp_addr = s->regs[R_ADDR];
+
+    switch (cmd) {
+    case SBC_OTP_CMD_READ:
+        ret = aspeed_sbc_otpmem_read(s, otp_addr, &local_err);
+        break;
+    case SBC_OTP_CMD_WRITE:
+        ret = aspeed_sbc_otpmem_write(s, otp_addr, &local_err);
+        break;
+    case SBC_OTP_CMD_PROG:
+        ret = aspeed_sbc_otpmem_prog(s, otp_addr, &local_err);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unknown command 0x%x\n",
+                      __func__, cmd);
+        break;
+    }
+
+    trace_aspeed_sbc_handle_cmd(cmd, otp_addr, ret);
+    if (ret == false && local_err) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: %s\n",
+                      __func__, error_get_pretty(local_err));
+        error_free(local_err);
+    }
+    s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
+}
+
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                               unsigned int size)
 {
@@ -78,6 +233,9 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                       "%s: write to read only register 0x%" HWADDR_PRIx "\n",
                       __func__, addr << 2);
         return;
+    case R_CMD:
+        aspeed_sbc_handle_command(opaque, data);
+        return;
     default:
         break;
     }
@@ -119,11 +277,32 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSBCState *s = ASPEED_SBC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(dev);
+    char *otpmem;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
             TYPE_ASPEED_SBC, 0x1000);
 
     sysbus_init_mmio(sbd, &s->iomem);
+
+    otpmem = object_property_get_str(qdev_get_machine(), "otpmem", errp);
+    /*
+     * If user doesn't specify the otpmem file location,
+     * to disable the OTP memory feature due to no backend data
+     */
+    if ((otpmem == NULL) || !strlen(otpmem)) {
+        sc->has_otpmem = false;
+    }
+
+    if (sc->has_otpmem) {
+        object_initialize_child(OBJECT(s), "optmem",
+                                &s->otpmem, TYPE_ASPEED_OTPMEM);
+        aspeed_otpmem_set_backend(&s->otpmem, otpmem);
+        qdev_realize(DEVICE(&s->otpmem), NULL, errp);
+        trace_aspeed_sbc_otpmem_state("enabled");
+    } else {
+        trace_aspeed_sbc_otpmem_state("disabled");
+    }
 }
 
 static const VMStateDescription vmstate_aspeed_sbc = {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e9df349f6d..e67dcf6653 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -95,6 +95,11 @@ aspeed_otpmem_prog(uint32_t addr, uint32_t prog_value, uint32_t value) "OTP Memo
 aspeed_otpmem_prog_conflict(uint32_t addr, uint32_t bits) "Conflict at addr=0x%x, bits=0x%08x"
 aspeed_otpmem_prog_bit(int bit) "Programmed bit %d"
 
+# aspped_sbc.c
+aspeed_sbc_otpmem_state(const char *enabled) "OTP Memory is %s"
+aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%" PRIx32
+aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
+
 # aspeed_scu.c
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 405e6782b9..667d6088c0 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -10,6 +10,7 @@
 #define ASPEED_SBC_H
 
 #include "hw/sysbus.h"
+#include "hw/misc/aspeed_otpmem.h"
 
 #define TYPE_ASPEED_SBC "aspeed.sbc"
 #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
@@ -36,10 +37,14 @@ struct AspeedSBCState {
     MemoryRegion iomem;
 
     uint32_t regs[ASPEED_SBC_NR_REGS];
+
+    AspeedOTPMemState otpmem;
 };
 
 struct AspeedSBCClass {
     SysBusDeviceClass parent_class;
+
+    bool has_otpmem;
 };
 
 #endif /* ASPEED_SBC_H */
-- 
2.43.0


