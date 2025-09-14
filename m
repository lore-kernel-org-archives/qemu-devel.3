Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D26CAC594
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 13:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxmIM-0004Z5-5F; Sun, 14 Sep 2025 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2025091412464988ca4a05380002077e-Aj5bTV@rts-flowmailer.siemens.com>)
 id 1uxmIE-0004WV-AT
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:23 -0400
Received: from mta-64-228.siemens.flowmailer.net ([185.136.64.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2025091412464988ca4a05380002077e-Aj5bTV@rts-flowmailer.siemens.com>)
 id 1uxmHx-0002N0-76
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:19 -0400
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2025091412464988ca4a05380002077e for <qemu-devel@nongnu.org>;
 Sun, 14 Sep 2025 14:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gkJjkzfJ54aOpvtw66vqBrI2Glax4zLSb9r/OOdb3Vs=;
 b=IvrLboIuiEz/NhwBDG1G6qADh9CbralN1YlPZsK0T3fXVbdpgb3QGBR31WISM7No+G7tTH
 o5BYH/joGS1asR9l056VKlScrPi7bUBPzQZdLiJc03J7ArXsBVGk+xcwtHVqsgnI1jn0yjGt
 ZLi4PwVuMQPM9NOqFbbfhPv11wSK3BTNqxkKWPyInXwTqn5tbn2M8qQpeeyWsyF+sfNbmhX4
 0zS88pywXFLOhAlrERh1f0OapCxsDOuduwF3VIKnKSSesHN2u/6g/JEPeJcYOqAZdHOebCLX
 A+GGSJNweZeSdSx/7Goj6+dzpABFWA1YlvsNgZXQzAqj9aV2/8ltFUrg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 3/6] hw/sd/sdcard: Add basic support for RPMB partition
Date: Sun, 14 Sep 2025 14:46:43 +0200
Message-ID: <c4d76b23be313f2822882d860d9b9ae623a031a1.1757854006.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757854006.git.jan.kiszka@siemens.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.228;
 envelope-from=fm-294854-2025091412464988ca4a05380002077e-Aj5bTV@rts-flowmailer.siemens.com;
 helo=mta-64-228.siemens.flowmailer.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The Replay Protected Memory Block (RPMB) is available since eMMC 4.4
which has been obsoleted by 4.41. Therefore lift the provided
EXT_CSD_REV to 5 (4.41) and provide the basic logic to implement basic
support for it. This allows to set the authentication key, read the
write counter and authenticated perform data read and write requests.
Those aren't actually authenticated yet, support for that will be added
later.

The RPMB image needs to be added to backing block images after potential
boot partitions and before the user data. It's size is controlled by
the rpmb-partition-size property.

Also missing in this version (and actually not only for RPMB bits) is
persistence of registers that are supposed to survive power cycles. Most
prominent are the write counters or the authentication key. This feature
can be added later, e.g. by append a state structure to the backing
block image.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/sd/sd.c             | 207 +++++++++++++++++++++++++++++++++++++++--
 hw/sd/sdmmc-internal.h |  21 +++++
 hw/sd/trace-events     |   2 +
 3 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b86cbf0fbd..f7e41512a1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -117,6 +117,20 @@ typedef struct SDProto {
     } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
 
+#define RPMB_KEY_MAC_LEN    32
+
+typedef struct {
+    uint8_t stuff_bytes[196];
+    uint8_t key_mac[RPMB_KEY_MAC_LEN];
+    uint8_t data[256];
+    uint8_t nonce[16];
+    uint32_t write_counter;
+    uint16_t address;
+    uint16_t block_count;
+    uint16_t result;
+    uint16_t req_resp;
+} RPMBDataFrame;
+
 struct SDState {
     DeviceState parent_obj;
 
@@ -140,6 +154,7 @@ struct SDState {
 
     uint8_t spec_version;
     uint64_t boot_part_size;
+    uint64_t rpmb_part_size;
     BlockBackend *blk;
     uint8_t boot_config;
 
@@ -172,6 +187,10 @@ struct SDState {
     uint32_t data_offset;
     size_t data_size;
     uint8_t data[512];
+    RPMBDataFrame rpmb_result;
+    uint32_t rpmb_write_counter;
+    uint8_t rpmb_key[32];
+    uint8_t rpmb_key_set;
     QEMUTimer *ocr_power_timer;
     uint8_t dat_lines;
     bool cmd_line;
@@ -506,7 +525,9 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t size)
     sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
     sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
     sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
-    sd->ext_csd[EXT_CSD_REV] = 3;
+    sd->ext_csd[EXT_CSD_REV] = 5;
+    sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
+    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
 
     /* Mode segment (RW) */
     sd->ext_csd[EXT_CSD_PART_CONFIG] = sd->boot_config;
@@ -834,7 +855,8 @@ static uint32_t sd_blk_len(SDState *sd)
 /*
  * This requires a disk image that has two boot partitions inserted at the
  * beginning of it, followed by an RPMB partition. The size of the boot
- * partitions is the "boot-partition-size" property.
+ * partitions is the "boot-partition-size" property, the one of the RPMB
+ * partition is 'rpmb-partition-size'.
  */
 static uint32_t sd_part_offset(SDState *sd)
 {
@@ -848,11 +870,13 @@ static uint32_t sd_part_offset(SDState *sd)
                                  & EXT_CSD_PART_CONFIG_ACC_MASK;
     switch (partition_access) {
     case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
-        return sd->boot_part_size * 2;
+        return sd->boot_part_size * 2 + sd->rpmb_part_size;
     case EXT_CSD_PART_CONFIG_ACC_BOOT1:
         return 0;
     case EXT_CSD_PART_CONFIG_ACC_BOOT2:
         return sd->boot_part_size * 1;
+    case EXT_CSD_PART_CONFIG_ACC_RPMB:
+        return sd->boot_part_size * 2;
     default:
          g_assert_not_reached();
     }
@@ -891,7 +915,7 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << HWBLOCK_SHIFT;
     if (sd_is_emmc(sd)) {
-        size -= sd->boot_part_size * 2;
+        size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
     }
 
     sect = sd_addr_to_wpnum(size) + 1;
@@ -979,6 +1003,34 @@ static const VMStateDescription sd_ocr_vmstate = {
     },
 };
 
+static bool vmstate_needed_for_rpmb(void *opaque)
+{
+    SDState *sd = opaque;
+
+    return sd->rpmb_part_size > 0;
+}
+
+static const VMStateDescription emmc_rpmb_vmstate = {
+    .name = "sd-card/ext_csd_modes-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_needed_for_rpmb,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState, RPMB_KEY_MAC_LEN),
+        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, 256),
+        VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
+        VMSTATE_UINT32(rpmb_result.write_counter, SDState),
+        VMSTATE_UINT16(rpmb_result.address, SDState),
+        VMSTATE_UINT16(rpmb_result.block_count, SDState),
+        VMSTATE_UINT16(rpmb_result.result, SDState),
+        VMSTATE_UINT16(rpmb_result.req_resp, SDState),
+        VMSTATE_UINT32(rpmb_write_counter, SDState),
+        VMSTATE_UINT8_ARRAY(rpmb_key, SDState, 32),
+        VMSTATE_UINT8(rpmb_key_set, SDState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool vmstate_needed_for_emmc(void *opaque)
 {
     SDState *sd = opaque;
@@ -1045,6 +1097,7 @@ static const VMStateDescription sd_vmstate = {
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
         &emmc_extcsd_vmstate,
+        &emmc_rpmb_vmstate,
         NULL
     },
 };
@@ -1067,6 +1120,105 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
+static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
+{
+    uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
+    uint16_t result = be16_to_cpu(sd->rpmb_result.result);
+    unsigned int curr_block = 0;
+
+    if ((result & ~RPMB_RESULT_COUTER_EXPIRED) == RPMB_RESULT_OK &&
+        resp == RPMB_RESP(RPMB_REQ_AUTH_DATA_READ)) {
+        curr_block = be16_to_cpu(sd->rpmb_result.address);
+        if (sd->rpmb_result.block_count == 0) {
+            sd->rpmb_result.block_count = cpu_to_be16(sd->multi_blk_cnt);
+        } else {
+            curr_block += be16_to_cpu(sd->rpmb_result.block_count) -
+                sd->multi_blk_cnt;
+        }
+        addr = curr_block * 256 + sd_part_offset(sd);
+        if (blk_pread(sd->blk, addr, 256, sd->rpmb_result.data, 0) < 0) {
+            fprintf(stderr, "sd_blk_read: read error on host side\n");
+            memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_READ_FAILURE |
+                (result & RPMB_RESULT_COUTER_EXPIRED));
+        }
+    }
+    memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
+
+    trace_sdcard_rpmb_read_block(resp, curr_block,
+                                 be16_to_cpu(sd->rpmb_result.result));
+}
+
+static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
+{
+    RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
+    uint16_t req = be16_to_cpu(frame->req_resp);
+
+    if (req == RPMB_REQ_READ_RESULT) {
+        /* just return the current result register */
+        goto exit;
+    }
+    memset(&sd->rpmb_result, 0, sizeof(sd->rpmb_result));
+    memcpy(sd->rpmb_result.nonce, frame->nonce, sizeof(sd->rpmb_result.nonce));
+    sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_OK);
+    sd->rpmb_result.req_resp = cpu_to_be16(RPMB_RESP(req));
+
+    if (!sd->rpmb_key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
+        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
+        goto exit;
+    }
+
+    switch (req) {
+    case RPMB_REQ_PROGRAM_AUTH_KEY:
+        if (sd->rpmb_key_set) {
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
+            break;
+        }
+        memcpy(sd->rpmb_key, frame->key_mac, sizeof(sd->rpmb_key));
+        sd->rpmb_key_set = 1;
+        break;
+    case RPMB_REQ_READ_WRITE_COUNTER:
+        sd->rpmb_result.write_counter = cpu_to_be32(sd->rpmb_write_counter);
+        break;
+    case RPMB_REQ_AUTH_DATA_WRITE:
+        /* We only support single-block writes so far */
+        if (sd->multi_blk_cnt != 1) {
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
+            break;
+        }
+        if (sd->rpmb_write_counter == 0xffffffff) {
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
+            break;
+        }
+        if (be32_to_cpu(frame->write_counter) != sd->rpmb_write_counter) {
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
+            break;
+        }
+        sd->rpmb_result.address = frame->address;
+        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
+        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
+            fprintf(stderr, "sd_blk_write: write error on host side\n");
+            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
+        } else {
+            sd->rpmb_write_counter++;
+        }
+        sd->rpmb_result.write_counter = cpu_to_be32(sd->rpmb_write_counter);
+        break;
+    case RPMB_REQ_AUTH_DATA_READ:
+        sd->rpmb_result.address = frame->address;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "RPMB request %d not implemented\n", req);
+        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
+        break;
+    }
+exit:
+    if (sd->rpmb_write_counter == 0xffffffff) {
+        sd->rpmb_result.result |= cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
+    }
+    trace_sdcard_rpmb_write_block(req, be16_to_cpu(sd->rpmb_result.result));
+}
+
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1180,6 +1332,19 @@ static void emmc_function_switch(SDState *sd, uint32_t arg)
         break;
     }
 
+    if (index == EXT_CSD_PART_CONFIG) {
+        uint8_t part = b & EXT_CSD_PART_CONFIG_ACC_MASK;
+
+        if (((part == EXT_CSD_PART_CONFIG_ACC_BOOT1 ||
+              part == EXT_CSD_PART_CONFIG_ACC_BOOT2) && !sd->boot_part_size) ||
+            (part == EXT_CSD_PART_CONFIG_ACC_RPMB && !sd->rpmb_part_size)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MMC switching to illegal partition\n");
+            sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
+            return;
+        }
+    }
+
     trace_sdcard_ext_csd_update(index, sd->ext_csd[index], b);
     sd->ext_csd[index] = b;
 }
@@ -2378,6 +2543,7 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 
 static void sd_write_byte(SDState *sd, uint8_t value)
 {
+    unsigned int partition_access;
     int i;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
@@ -2427,7 +2593,13 @@ static void sd_write_byte(SDState *sd, uint8_t value)
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            sd_blk_write(sd, sd->data_start, sd->data_offset);
+            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                    & EXT_CSD_PART_CONFIG_ACC_MASK;
+            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+                emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
+            } else {
+                sd_blk_write(sd, sd->data_start, sd->data_offset);
+            }
             sd->blk_written++;
             sd->data_start += sd->blk_len;
             sd->data_offset = 0;
@@ -2510,6 +2682,7 @@ static uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
+    unsigned int partition_access;
     uint8_t ret;
     uint32_t io_len;
 
@@ -2553,7 +2726,13 @@ static uint8_t sd_read_byte(SDState *sd)
                                   sd->data_start, io_len)) {
                 return dummy_byte;
             }
-            sd_blk_read(sd, sd->data_start, io_len);
+            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                    & EXT_CSD_PART_CONFIG_ACC_MASK;
+            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
+            } else {
+                sd_blk_read(sd, sd->data_start, io_len);
+            }
         }
         ret = sd->data[sd->data_offset ++];
 
@@ -2803,7 +2982,8 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
+        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2 -
+            sd->rpmb_part_size;
         if (blk_size > SDSC_MAX_CAPACITY) {
             if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) != 0) {
                 int64_t blk_size_aligned =
@@ -2842,13 +3022,23 @@ static void sd_realize(DeviceState *dev, Error **errp)
                           "The boot partition size must be multiples of 128K"
                           "and not larger than 32640K.\n");
     }
+    if (sd->rpmb_part_size % (128 * KiB) ||
+        sd->rpmb_part_size > 128 * 128 * KiB) {
+        char *size_str = size_to_str(sd->boot_part_size);
+
+        error_setg(errp, "Invalid RPMB partition size: %s", size_str);
+        g_free(size_str);
+        error_append_hint(errp,
+                          "The RPMB partition size must be multiples of 128K"
+                          "and not larger than 16384K.\n");
+    }
 }
 
 static void emmc_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
 
-    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.3 */
+    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.5 */
 
     sd_realize(dev, errp);
 }
@@ -2865,6 +3055,7 @@ static const Property sd_properties[] = {
 static const Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
+    DEFINE_PROP_UINT64("rpmb-partition-size", SDState, rpmb_part_size, 0),
 };
 
 static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index ce6bc4e6ec..c4a9aa8edf 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -118,9 +118,30 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
 #define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT1           (0x1)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT2           (0x2)
+#define EXT_CSD_PART_CONFIG_ACC_RPMB            (0x3)
 
 #define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
 #define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
 #define EXT_CSD_PART_CONFIG_EN_USER             (0x7 << 3)
 
+#define RPMB_REQ_PROGRAM_AUTH_KEY       (1)
+#define RPMB_REQ_READ_WRITE_COUNTER     (2)
+#define RPMB_REQ_AUTH_DATA_WRITE        (3)
+#define RPMB_REQ_AUTH_DATA_READ         (4)
+#define RPMB_REQ_READ_RESULT            (5)
+#define RPMB_REQ_AUTH_CONFIG_WRITE      (6)
+#define RPMB_REQ_AUTH_CONFIG_READ       (7)
+
+#define RPMB_RESP(__req__)              ((__req__) << 8)
+
+#define RPMB_RESULT_OK                  (0)
+#define RPMB_RESULT_GENERAL_FAILURE     (1)
+#define RPMB_RESULT_AUTH_FAILURE        (2)
+#define RPMB_RESULT_COUNTER_FAILURE     (3)
+#define RPMB_RESULT_ADDRESS_FAILURE     (4)
+#define RPMB_RESULT_WRITE_FAILURE       (5)
+#define RPMB_RESULT_READ_FAILURE        (6)
+#define RPMB_RESULT_NO_AUTH_KEY         (7)
+#define RPMB_RESULT_COUTER_EXPIRED      (0x80)
+
 #endif
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 8d49840917..d30daa2143 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -59,6 +59,8 @@ sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
 sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "SWITCH acc:%u idx:%u val:%u set:%u"
+sdcard_rpmb_read_block(uint16_t resp, uint16_t read_addr, uint16_t result) "resp 0x%x read_addr 0x%x result 0x%x"
+sdcard_rpmb_write_block(uint16_t req, uint16_t result) "req 0x%x result 0x%x"
 
 # pl181.c
 pl181_command_send(uint8_t cmd, uint32_t arg) "sending CMD%02d arg 0x%08" PRIx32
-- 
2.51.0


