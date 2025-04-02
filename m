Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB2DC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 09:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzuGY-0005gw-Lj; Wed, 02 Apr 2025 05:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1tzuGV-0005fh-QF; Wed, 02 Apr 2025 05:20:07 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1tzuGT-0001EE-G6; Wed, 02 Apr 2025 05:20:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 2 Apr
 2025 17:14:47 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 2 Apr 2025 17:14:47 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/1] hw/misc/aspeed_sbc: Implement OTP memory and controller
Date: Wed, 2 Apr 2025 17:14:47 +0800
Message-ID: <20250402091447.3381734-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402091447.3381734-1-kane_chen@aspeedtech.com>
References: <20250402091447.3381734-1-kane_chen@aspeedtech.com>
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
Reply-to:  Kane-Chen-AS <kane_chen@aspeedtech.com>
From:  Kane-Chen-AS via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds the OTP memory and its controller as part of the
Secure Boot Controller (SBC) device model. The OTP memory content is
persisted to a file named 'otpmem', which is created if it does not
already exist.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/misc/aspeed_sbc.c         | 304 +++++++++++++++++++++++++++++++++++
 include/hw/misc/aspeed_sbc.h |  14 ++
 2 files changed, 318 insertions(+)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index e4a6bd1581..5d77fd45d7 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -15,9 +15,15 @@
 #include "hw/misc/aspeed_sbc.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "system/block-backend.h"
+#include "qobject/qdict.h"
 
 #define R_PROT          (0x000 / 4)
+#define R_CMD           (0x004 / 4)
+#define R_ADDR          (0x010 / 4)
 #define R_STATUS        (0x014 / 4)
+#define R_CAMP1         (0x020 / 4)
+#define R_CAMP2         (0x024 / 4)
 #define R_QSR           (0x040 / 4)
 
 /* R_STATUS */
@@ -41,6 +47,18 @@
 #define QSR_RSA_MASK           (0x3 << 12)
 #define QSR_HASH_MASK          (0x3 << 10)
 
+#define OTP_FILE_PATH "otpmem"
+
+#define BLK_VALID(s) \
+    do { \
+        if (s->blk == NULL) { \
+            qemu_log_mask(LOG_GUEST_ERROR, \
+                          "%s: blk is not initialized\n", \
+                          __func__); \
+            return; \
+        } \
+    } while (0)
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -57,6 +75,196 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
     return s->regs[addr];
 }
 
+static void aspeed_sbc_otpmem_read(void *opaque)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    uint32_t otp_addr, data, otp_offset;
+    bool is_data = false;
+
+    BLK_VALID(s);
+    otp_addr = s->regs[R_ADDR];
+    if (otp_addr < OTP_DATA_DWORD_COUNT) {
+        is_data = true;
+    } else if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid OTP addr 0x%x\n",
+                      __func__, otp_addr);
+        return;
+    }
+    otp_offset = otp_addr << 2;
+
+    if (blk_pread(s->blk, (int64_t)otp_offset, sizeof(data), &data, 0) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to read data 0x%x\n",
+                      __func__, otp_offset);
+        return;
+    }
+    s->regs[R_CAMP1] = data;
+
+    if (is_data) {
+        if (blk_pread(s->blk, (int64_t)otp_offset + 4,
+                      sizeof(data), &data, 0) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to read data 0x%x\n",
+                          __func__, otp_offset);
+            return;
+        }
+        s->regs[R_CAMP2] = data;
+    }
+}
+
+static bool check_bit_conditions(uint32_t otp_addr,
+                                 uint32_t value, uint32_t prog_bit)
+{
+    uint32_t programed_bits, pass;
+    bool is_odd = otp_addr & 1;
+
+    if (is_odd) {
+        programed_bits = ~value & prog_bit;
+    } else {
+        programed_bits = value & (~prog_bit);
+    }
+
+    pass = value ^ (~prog_bit);
+
+    if (programed_bits) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Found programed bits in addr %x\n",
+                      __func__, otp_addr);
+        for (int i = 0; i < 32; ++i) {
+            if (programed_bits & (1U << i)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "  Programed bit %d\n",
+                              i);
+            }
+        }
+    }
+
+    return pass != 0;
+}
+
+static bool program_otp_data(void *opaque, uint32_t otp_addr,
+                             uint32_t prog_bit, uint32_t *value)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    bool is_odd = otp_addr & 1;
+    uint32_t otp_offset = otp_addr << 2;
+
+    if (blk_pread(s->blk, (int64_t)otp_offset,
+                  sizeof(uint32_t), value, 0) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to read data 0x%x\n",
+                      __func__, otp_offset);
+        return false;
+    }
+
+    if (check_bit_conditions(otp_addr, *value, prog_bit) == false) {
+        return false;
+    }
+
+    if (is_odd) {
+        *value &= ~prog_bit;
+    } else {
+        *value |= ~prog_bit;
+    }
+
+    return true;
+}
+
+static void mr_handler(uint32_t otp_addr, uint32_t data)
+{
+    switch (otp_addr) {
+    case MODE_REGISTER:
+    case MODE_REGISTER_A:
+    case MODE_REGISTER_B:
+        /* HW behavior, do nothing here */
+        break;
+    default:
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Unsupported address 0x%x\n",
+                  __func__, otp_addr);
+        return;
+    }
+}
+
+static void aspeed_sbc_otpmem_write(void *opaque)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    uint32_t otp_addr, data;
+
+    otp_addr = s->regs[R_ADDR];
+    data = s->regs[R_CAMP1];
+
+    if (otp_addr == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ignore write program bit request\n",
+                      __func__);
+    } else if (otp_addr >= MODE_REGISTER) {
+        mr_handler(otp_addr, data);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unhandled OTP write address 0x%x\n",
+                      __func__, otp_addr);
+    }
+}
+
+static void aspeed_sbc_otpmem_prog(void *opaque)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    uint32_t otp_addr, value, otp_offset;
+
+    BLK_VALID(s);
+    otp_addr = s->regs[R_ADDR];
+    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid OTP addr 0x%x\n",
+                      __func__, otp_addr);
+        return;
+    }
+
+    otp_offset = otp_addr << 2;
+    if (program_otp_data(opaque, otp_addr,
+                         s->regs[R_CAMP1], &value) == false) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                       "%s: Failed to program data 0x%x to 0x%x\n",
+                      __func__, s->regs[R_CAMP1], otp_offset);
+        return;
+    }
+
+    if (blk_pwrite(s->blk, (int64_t)otp_offset,
+                   sizeof(value), &value, 0) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to write data 0x%x to 0x%x\n",
+                      __func__, value, otp_offset);
+    }
+}
+
+static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+
+    s->regs[R_STATUS] &= ~(OTP_MEM_IDLE | OTP_IDLE);
+
+    switch (cmd) {
+    case READ_CMD:
+        aspeed_sbc_otpmem_read(s);
+        break;
+    case WRITE_CMD:
+        aspeed_sbc_otpmem_write(s);
+        break;
+    case PROG_CMD:
+        aspeed_sbc_otpmem_prog(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unknown command 0x%x\n",
+                      __func__, cmd);
+        break;
+    }
+
+    s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
+}
+
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                               unsigned int size)
 {
@@ -78,6 +286,9 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                       "%s: write to read only register 0x%" HWADDR_PRIx "\n",
                       __func__, addr << 2);
         return;
+    case R_CMD:
+        aspeed_sbc_handle_command(opaque, data);
+        return;
     default:
         break;
     }
@@ -113,6 +324,92 @@ static void aspeed_sbc_reset(DeviceState *dev)
     }
 
     s->regs[R_QSR] = s->signing_settings;
+
+    if (!s->blk) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: blk not initialized!\n",
+                      __func__);
+        return;
+    }
+}
+
+static BlockBackend *init_otpmem(int64_t size_bytes)
+{
+    Error *local_err = NULL;
+    BlockDriverState *bs = NULL;
+    BlockBackend *blk = NULL;
+    bool image_created = false;
+    QDict *options;
+    uint32_t i, odd_def = 0xffffffff, even_def = 0, *def;
+
+    if (!g_file_test(OTP_FILE_PATH, G_FILE_TEST_EXISTS)) {
+        bdrv_img_create(OTP_FILE_PATH, "raw", NULL, NULL,
+                        NULL, size_bytes, 0, true, &local_err);
+        if (local_err) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to create image %s: %s\n",
+                          __func__, OTP_FILE_PATH,
+                          error_get_pretty(local_err));
+            error_free(local_err);
+            return NULL;
+        }
+        image_created = true;
+    }
+
+    blk = blk_new(qemu_get_aio_context(),
+                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                  0);
+    if (!blk) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to create BlockBackend\n",
+                      __func__);
+        return NULL;
+    }
+
+    options =  qdict_new();
+    qdict_put_str(options, "driver", "raw");
+    bs = bdrv_open(OTP_FILE_PATH, NULL, options, BDRV_O_RDWR, &local_err);
+    if (local_err) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to create OTP memory, err = %s\n",
+                      __func__, error_get_pretty(local_err));
+        blk_unref(blk);
+        error_free(local_err);
+        return NULL;
+    }
+
+    blk_insert_bs(blk, bs, &local_err);
+    if (local_err) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to insert OTP memory to SBC, err = %s\n",
+                      __func__, error_get_pretty(local_err));
+        bdrv_unref(bs);
+        blk_unref(blk);
+        error_free(local_err);
+        return NULL;
+    }
+    bdrv_unref(bs);
+
+    if (image_created) {
+        /* init otp memory data */
+        for (i = 0; i < OTP_TOTAL_DWORD_COUNT; i++) {
+            if (i & 1) {
+                def = &odd_def;
+            } else {
+                def = &even_def;
+            }
+
+            if (blk_pwrite(blk, i << 2, sizeof(uint32_t), def, 0) < 0) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: Failed to init OTP memory file\n",
+                              __func__);
+                blk_unref(blk);
+                return NULL;
+            }
+        }
+    }
+
+    return blk;
 }
 
 static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
@@ -124,6 +421,13 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
             TYPE_ASPEED_SBC, 0x1000);
 
     sysbus_init_mmio(sbd, &s->iomem);
+
+    s->blk = init_otpmem(OTP_FILE_SIZE);
+    if (s->blk == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to attach otpmem\n",
+                      __func__);
+    }
 }
 
 static const VMStateDescription vmstate_aspeed_sbc = {
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 405e6782b9..fbdef86a63 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -27,6 +27,18 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
 #define QSR_SHA384                  (0x2 << 10)
 #define QSR_SHA512                  (0x3 << 10)
 
+#define READ_CMD                    (0x23b1e361)
+#define WRITE_CMD                   (0x23b1e362)
+#define PROG_CMD                    (0x23b1e364)
+
+#define OTP_DATA_DWORD_COUNT        (0x800)
+#define OTP_TOTAL_DWORD_COUNT       (0x1000)
+#define OTP_FILE_SIZE               (OTP_TOTAL_DWORD_COUNT * sizeof(uint32_t))
+
+#define MODE_REGISTER               (0x1000)
+#define MODE_REGISTER_A             (0x3000)
+#define MODE_REGISTER_B             (0x5000)
+
 struct AspeedSBCState {
     SysBusDevice parent;
 
@@ -36,6 +48,8 @@ struct AspeedSBCState {
     MemoryRegion iomem;
 
     uint32_t regs[ASPEED_SBC_NR_REGS];
+
+    BlockBackend *blk;
 };
 
 struct AspeedSBCClass {
-- 
2.43.0


