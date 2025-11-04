Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233CECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9k-0004Mf-OP; Tue, 04 Nov 2025 12:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9E-0004Ko-Oa
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:49 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9C-0005kJ-3k
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:48 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso10000938a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278524; x=1762883324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpbbKSWDlqLK/iFXVepkQyVZxIs53mvNqY/oK9a5cLQ=;
 b=XVdkhJnEiFN2jsskSSDuAXZrujG3wfdXRPo58UJIR3Qr5ZM0FUyJer3s7y/CB9ymAr
 j0dyQsAJxplDLAupnGotj3mMLrKJ1SuSq1mrwaPXQptt4h1duqx7DGczNvxRUTr8tt+D
 VcicS+q8AaFEAy0tmfV1G6bciaSVFPZ61LLUz3B5DPPe1ZAW+Z8LOTfJG3Nu+7vYdWMO
 L38wmNx695Q8D4Gx4TykYFNKXzQigfJ9uPMr3LAzp74HgacdRFc7NxCJobmBtw0JCXMD
 Mmtx9nA92sNeJ/sAUT4BIjLZenXuTAuy95920c0AMtHCxQHvpq7tvbsg839zgdkJKyyD
 Lklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278524; x=1762883324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpbbKSWDlqLK/iFXVepkQyVZxIs53mvNqY/oK9a5cLQ=;
 b=volf8HWBbs26VAhiOprN8r0BL9VP993G1sBoG7PgqlfvhNI7iG2BiA3pWyNY8EdDa2
 87gEW7fR4SIPaq2Fq6FHFZWS9nUHUzSAjDsmjWK0mwDigCUEeKU5fj4N8xFp0Qasm/3N
 7yLs1e1+qbb/H46wfY9Fb3vsYKm6iCTkpomy/iOuBHcWHkXvptGptF620/uBjfSw53xz
 tQ2RhI+Uv6ZQxM6oe6W/whw+nh0VNuRn5rGY9qJpdqduqYIbLJPZlZQRgZ3HLm3bIVgw
 fu68OvSaJLq3S9XsTYn90LR8hMzhscHgVwPJNwng1aNY+HYQl+bW6JbDpK315Esz63wM
 21ew==
X-Gm-Message-State: AOJu0Yz7TAeWrMZfs7y5Z6jRex+trHHSLVZdkm4OrRnFTLete7ZacDoy
 aXt6B7TJp1bjXypxArwk3BLgSDwjWxOlJXt5YeOkfaizZUrckHtwKyBFHGCuuJqtwUNaW1u/GVc
 i5Ta33g44bw==
X-Gm-Gg: ASbGnct4A68ao27qqRkpRmEx1eA9tbxv3DSU8W0m+c2W7oJ7FHiwY2j2j9W7JZw7Dam
 0VQalSYZDlaNDTegj46iRgImWYkCu/lJ1FRsEWGhnZCKh1UM5wjCC/gB44vWYdvEVCKQblil7z/
 2IFCV8D4Lz1QrwViCuyZnZrb46MGjDtm4y9e/J1eoqUL8c+fHCcKqYGLNkc4ntKROPAiFUMoikf
 UxRbqDjIYXhpyi5H1rVcvbdjlyQs9eWGw73W13P5tzia9q7MaWiPcCW9EpyNr61v7lQhY3TFnBD
 DMotBNTesNR0la8GNhlkXsSz2EAZVqPbhez1WrXvuR4kJeXidqcJSKbenVZ0dfK18p10x1MehC3
 q8R+P7OR02W4+OmwFUSY82Ctcw0qlG7roHQUIOBhcFkkXNGMMkPEk6BXuSOUCkMyrSDIhihcZ+Q
 rzJlTO3eyrEADkkIdm2LzNpg==
X-Google-Smtp-Source: AGHT+IEqQ4EuEvDFsTm4ML8s2LCyGSLJE99dragkR+MNohUGb2FxjNe5Ey+eEaz2/xiTTDZc4+QkNg==
X-Received: by 2002:a05:6402:5342:20b0:63c:4d42:992b with SMTP id
 4fb4d7f45d1cf-641058b9d71mr78556a12.13.1762278523995; 
 Tue, 04 Nov 2025 09:48:43 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640ee0b4f4esm1710250a12.11.2025.11.04.09.48.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:48:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] hw/sd/sdcard: Add basic support for RPMB partition
Date: Tue,  4 Nov 2025 18:48:18 +0100
Message-ID: <20251104174823.92412-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <d57388b599e47f5c95f30be7571b77f9016289eb.1762261430.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h |  22 +++++
 hw/sd/sd.c             | 217 +++++++++++++++++++++++++++++++++++++++--
 hw/sd/trace-events     |   2 +
 3 files changed, 233 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index ce6bc4e6ec4..c115f472efe 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -118,9 +118,31 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
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
+
+#define RPMB_RESULT_COUTER_EXPIRED      (0x80)
+
 #endif
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e43e1a10ebb..aa57c858cbb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -117,6 +117,26 @@ typedef struct SDProto {
     } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
 
+#define RPMB_STUFF_LEN      196
+#define RPMB_KEY_MAC_LEN    32
+#define RPMB_DATA_LEN       256     /* one RPMB block is half a sector */
+#define RPMB_NONCE_LEN      16
+
+typedef struct QEMU_PACKED {
+    uint8_t stuff_bytes[RPMB_STUFF_LEN];
+    uint8_t key_mac[RPMB_KEY_MAC_LEN];
+    uint8_t data[RPMB_DATA_LEN];
+    uint8_t nonce[RPMB_NONCE_LEN];
+    uint32_t write_counter;
+    uint16_t address;
+    uint16_t block_count;
+    uint16_t result;
+    uint16_t req_resp;
+} RPMBDataFrame;
+
+QEMU_BUILD_BUG_MSG(sizeof(RPMBDataFrame) != 512,
+                   "invalid RPMBDataFrame size");
+
 struct SDState {
     DeviceState parent_obj;
 
@@ -140,6 +160,7 @@ struct SDState {
 
     uint8_t spec_version;
     uint64_t boot_part_size;
+    uint64_t rpmb_part_size;
     BlockBackend *blk;
     uint8_t boot_config;
 
@@ -172,6 +193,12 @@ struct SDState {
     uint32_t data_offset;
     size_t data_size;
     uint8_t data[512];
+    struct {
+        uint32_t write_counter;
+        uint8_t key[RPMB_KEY_MAC_LEN];
+        uint8_t key_set;
+        RPMBDataFrame result;
+    } rpmb;
     QEMUTimer *ocr_power_timer;
     uint8_t dat_lines;
     bool cmd_line;
@@ -506,7 +533,9 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t size)
     sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
     sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
     sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
-    sd->ext_csd[EXT_CSD_REV] = 3;
+    sd->ext_csd[EXT_CSD_REV] = 5;
+    sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
+    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
 
     /* Mode segment (RW) */
     sd->ext_csd[EXT_CSD_PART_CONFIG] = sd->boot_config;
@@ -834,7 +863,8 @@ static uint32_t sd_blk_len(SDState *sd)
 /*
  * This requires a disk image that has two boot partitions inserted at the
  * beginning of it, followed by an RPMB partition. The size of the boot
- * partitions is the "boot-partition-size" property.
+ * partitions is the "boot-partition-size" property, the one of the RPMB
+ * partition is 'rpmb-partition-size'.
  */
 static uint32_t sd_part_offset(SDState *sd)
 {
@@ -848,11 +878,13 @@ static uint32_t sd_part_offset(SDState *sd)
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
@@ -891,7 +923,7 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << HWBLOCK_SHIFT;
     if (sd_is_emmc(sd)) {
-        size -= sd->boot_part_size * 2;
+        size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
     }
 
     sect = sd_addr_to_wpnum(size) + 1;
@@ -979,6 +1011,34 @@ static const VMStateDescription sd_ocr_vmstate = {
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
+        VMSTATE_UINT8_ARRAY(rpmb.result.key_mac, SDState, RPMB_KEY_MAC_LEN),
+        VMSTATE_UINT8_ARRAY(rpmb.result.data, SDState, RPMB_DATA_LEN),
+        VMSTATE_UINT8_ARRAY(rpmb.result.nonce, SDState, RPMB_NONCE_LEN),
+        VMSTATE_UINT32(rpmb.result.write_counter, SDState),
+        VMSTATE_UINT16(rpmb.result.address, SDState),
+        VMSTATE_UINT16(rpmb.result.block_count, SDState),
+        VMSTATE_UINT16(rpmb.result.result, SDState),
+        VMSTATE_UINT16(rpmb.result.req_resp, SDState),
+        VMSTATE_UINT32(rpmb.write_counter, SDState),
+        VMSTATE_UINT8_ARRAY(rpmb.key, SDState, 32),
+        VMSTATE_UINT8(rpmb.key_set, SDState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool vmstate_needed_for_emmc(void *opaque)
 {
     SDState *sd = opaque;
@@ -1045,6 +1105,7 @@ static const VMStateDescription sd_vmstate = {
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
         &emmc_extcsd_vmstate,
+        &emmc_rpmb_vmstate,
         NULL
     },
 };
@@ -1067,6 +1128,108 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
+static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
+{
+    uint16_t resp = lduw_be_p(&sd->rpmb.result.req_resp);
+    uint16_t result = lduw_be_p(&sd->rpmb.result.result);
+    unsigned int curr_block = 0;
+
+    if ((result & ~RPMB_RESULT_COUTER_EXPIRED) == RPMB_RESULT_OK &&
+        resp == RPMB_RESP(RPMB_REQ_AUTH_DATA_READ)) {
+        curr_block = lduw_be_p(&sd->rpmb.result.address);
+        if (sd->rpmb.result.block_count == 0) {
+            stw_be_p(&sd->rpmb.result.block_count, sd->multi_blk_cnt);
+        } else {
+            curr_block += lduw_be_p(&sd->rpmb.result.block_count);
+            curr_block -= sd->multi_blk_cnt;
+        }
+        addr = curr_block * RPMB_DATA_LEN + sd_part_offset(sd);
+        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN,
+                      sd->rpmb.result.data, 0) < 0) {
+            error_report("sd_blk_read: read error on host side");
+            memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
+            stw_be_p(&sd->rpmb.result.result,
+                     RPMB_RESULT_READ_FAILURE
+                     | (result & RPMB_RESULT_COUTER_EXPIRED));
+        }
+    }
+    memcpy(sd->data, &sd->rpmb.result, sizeof(sd->rpmb.result));
+
+    trace_sdcard_rpmb_read_block(resp, curr_block,
+                                 lduw_be_p(&sd->rpmb.result.result));
+}
+
+static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
+{
+    RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
+    uint16_t req = lduw_be_p(&frame->req_resp);
+
+    if (req == RPMB_REQ_READ_RESULT) {
+        /* just return the current result register */
+        goto exit;
+    }
+    memset(&sd->rpmb.result, 0, sizeof(sd->rpmb.result));
+    memcpy(sd->rpmb.result.nonce, frame->nonce, sizeof(sd->rpmb.result.nonce));
+    stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_OK);
+    stw_be_p(&sd->rpmb.result.req_resp, RPMB_RESP(req));
+
+    if (!sd->rpmb.key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
+        stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_NO_AUTH_KEY);
+        goto exit;
+    }
+
+    switch (req) {
+    case RPMB_REQ_PROGRAM_AUTH_KEY:
+        if (sd->rpmb.key_set) {
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_WRITE_FAILURE);
+            break;
+        }
+        memcpy(sd->rpmb.key, frame->key_mac, sizeof(sd->rpmb.key));
+        sd->rpmb.key_set = 1;
+        break;
+    case RPMB_REQ_READ_WRITE_COUNTER:
+        stl_be_p(&sd->rpmb.result.write_counter, sd->rpmb.write_counter);
+        break;
+    case RPMB_REQ_AUTH_DATA_WRITE:
+        /* We only support single-block writes so far */
+        if (sd->multi_blk_cnt != 1) {
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_GENERAL_FAILURE);
+            break;
+        }
+        if (sd->rpmb.write_counter == 0xffffffff) {
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_WRITE_FAILURE);
+            break;
+        }
+        if (ldl_be_p(&frame->write_counter) != sd->rpmb.write_counter) {
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_COUNTER_FAILURE);
+            break;
+        }
+        sd->rpmb.result.address = frame->address;
+        addr = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
+        if (blk_pwrite(sd->blk, addr, RPMB_DATA_LEN, frame->data, 0) < 0) {
+            error_report("sd_blk_write: write error on host side");
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_WRITE_FAILURE);
+        } else {
+            sd->rpmb.write_counter++;
+        }
+        stl_be_p(&sd->rpmb.result.write_counter, sd->rpmb.write_counter);
+        break;
+    case RPMB_REQ_AUTH_DATA_READ:
+        sd->rpmb.result.address = frame->address;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "RPMB request %d not implemented\n", req);
+        stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_GENERAL_FAILURE);
+        break;
+    }
+exit:
+    if (sd->rpmb.write_counter == 0xffffffff) {
+        stw_be_p(&sd->rpmb.result.result,
+                 lduw_be_p(&sd->rpmb.result.result) | RPMB_RESULT_COUTER_EXPIRED);
+    }
+    trace_sdcard_rpmb_write_block(req, lduw_be_p(&sd->rpmb.result.result));
+}
+
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1180,6 +1343,19 @@ static void emmc_function_switch(SDState *sd, uint32_t arg)
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
@@ -2378,6 +2554,7 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 
 static void sd_write_byte(SDState *sd, uint8_t value)
 {
+    unsigned int partition_access;
     int i;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
@@ -2427,7 +2604,13 @@ static void sd_write_byte(SDState *sd, uint8_t value)
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
@@ -2510,6 +2693,7 @@ static uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
+    unsigned int partition_access;
     uint8_t ret;
     uint32_t io_len;
 
@@ -2553,7 +2737,13 @@ static uint8_t sd_read_byte(SDState *sd)
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
 
@@ -2805,7 +2995,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
         blk_size = blk_getlength(sd->blk);
     }
     if (blk_size >= 0) {
-        blk_size -= sd->boot_part_size * 2;
+        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
         if (blk_size > SDSC_MAX_CAPACITY) {
             if (sd_is_emmc(sd) &&
                 !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
@@ -2846,13 +3036,23 @@ static void sd_realize(DeviceState *dev, Error **errp)
                           "The boot partition size must be multiples of 128K"
                           "and not larger than 32640K.\n");
     }
+    if (!QEMU_IS_ALIGNED(sd->rpmb_part_size, 128 * KiB) ||
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
@@ -2869,6 +3069,7 @@ static const Property sd_properties[] = {
 static const Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
+    DEFINE_PROP_UINT64("rpmb-partition-size", SDState, rpmb_part_size, 0),
 };
 
 static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 8d49840917e..d30daa21431 100644
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


