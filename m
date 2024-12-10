Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B0CE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqZ3-00008w-3G; Mon, 09 Dec 2024 22:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqZ1-00008D-8G; Mon, 09 Dec 2024 22:05:31 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYz-0003HE-7z; Mon, 09 Dec 2024 22:05:31 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216401de828so17083045ad.3; 
 Mon, 09 Dec 2024 19:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799927; x=1734404727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeWNwp+7gNfaxpbB+LR/oQe4Y23byGeRB+Qua9V3R1E=;
 b=jCyinH5zEdfl7YEdHMT87hSsArfTLOWVNf/esakzgQmsjiA4Mpue9UrzG57IMjeQb/
 0Da3ToYF/+jXCAdK2fL4r2zbVkza/CQfY/0+wLKXe/rimAJF1yfR9wKZVVl2PAU9xRI/
 BM3/VGHmq5VgUXdgzummgb6ZHaQGe2ZQ80X06AmR8mRr+o9sRBbFMqEU1hXSAaXEjWE9
 YETMVB9JCk19bQnF8nFnkRt5qVKnnGrxmf3aHgx97MsElqmlKV6UsMO/jAnbavtPK9TG
 RNgHZzZP2qMc/Ns+kUnwHif4eE6/GhjCu93JPcwJeDoJ1V+za/QjgjhGpM2BMREnPGLx
 vUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799927; x=1734404727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeWNwp+7gNfaxpbB+LR/oQe4Y23byGeRB+Qua9V3R1E=;
 b=cwB2xeLkD6e/3LBK1O/atSGEYfFOBc5q1Yk2VXCdY9HRgBjDvo0g8ts5jXxQNXINk8
 +ysUiHndVe0A4eF9M7mL5m6WfbO5t8/3VlndDpfb0FU2ZjXW4+6xNZA18GCG0AQ71yEP
 zXw5BGP51qOcRPyEPdomVWgbfeAEh2nd/PnqjBN3ZoAYFOSlh2/nOpRJ6kSckoG9xrF+
 b6P5xDDoKfTOEt4stKMQmIDWpX+XPmAgGzJKZZ0L8FTjBUK4w14E+VD/yR531kHCYfBm
 XImRh2yrcP9AW4e2W+sc5a0Ct/whZ6UBvwTuQfn6xUkZALbsWC9jpR8ILJxMLJNiP1JJ
 BnDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVFZa3PHWFm5DZRmAJxrIsuBE3c6IoeUk+3HmGkWdnqPpjzJCq2pgPvLlcY4GM+Yd9Mj6voe0JOoR9@nongnu.org
X-Gm-Message-State: AOJu0Yw54/amyYU3CG4BAJlhaQ6pK7KgcVzl9naDG0uP7QzybotKCb8H
 d8Sm36vX67xv7EhPRSnLp80ulbQWdn8uyO0JWAlsCfHvLMhheXHf61ZhQg==
X-Gm-Gg: ASbGncuYRrcv5Mp0fASS2qCNeKKxGPBgXnZHQ0hRn7GTpZPzrIlKST8rhcMoNlZAkYr
 rCcn0TZe8kqEJ0rBiW0flIkl9Q+OtUPxvcsZ8kFubRVXx98oUkd9t9BMlVA8hUz/r5v5mBK8agk
 ZoA6hkvZgXoF/Jt5gYp47c+E5OY4Kky7b8ZOUp7fbMWmhjyRipsuvFgFCHalzeNwG3jMbpv3CR2
 v3QVWHOUpcgVpRgawiYHgxtHsR+Obwn+ozKseQ/ZmNljoD+7rEWlPpYNqjT
X-Google-Smtp-Source: AGHT+IEUJ9V1QYHTMpRg+GnVM7KUOHdwtSlSFdX55gLnrVIhFERaa5dmiYuGDeh4TMs5NKmHBuRkWQ==
X-Received: by 2002:a17:902:dac8:b0:215:b087:5d62 with SMTP id
 d9443c01a7336-2166a03f16cmr48662655ad.36.1733799927000; 
 Mon, 09 Dec 2024 19:05:27 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 9/9] ppc/pnv/occ: Implement a basic dynamic OCC model
Date: Tue, 10 Dec 2024 13:04:49 +1000
Message-ID: <20241210030451.1306608-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The OCC is an On Chip Controller that handles various thermal and power
management. It is a PPC405 microcontroller that runs its own firmware
which is out of scope of the powernv machine model. Some dynamic
behaviour and interfaces that are important for host CPU testing can be
implemented with a much simpler state machine.

This change adds a 100ms timer that ticks through a simple state machine
that looks for "OCC command requests" coming from host firmware, and
responds to them.

For now the powercap command is implemented because that is used by
OPAL and exported to Linux and is easy to test.

  $ F=/sys/firmware/opal/powercap/system-powercap/powercap-current
  $ cat $F
  100
  $ echo 50 | sudo tee $F
  50
  $ cat $F
  50

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_occ.h |   3 +
 hw/ppc/pnv_occ.c         | 145 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index f9948609808..3ec42de0ff1 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -41,6 +41,9 @@ DECLARE_INSTANCE_CHECKER(PnvOCC, PNV10_OCC, TYPE_PNV10_OCC)
 struct PnvOCC {
     DeviceState xd;
 
+    /* OCC dynamic model is driven by this timer. */
+    QEMUTimer state_machine_timer;
+
     /* OCC Misc interrupt */
     uint64_t occmisc;
 
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index aa46e118e93..11081ecc4b7 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -35,6 +35,7 @@
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
 #define   OCCMISC_PSI_IRQ       PPC_BIT(0)
+#define   OCCMISC_IRQ_SHMEM     PPC_BIT(3)
 
 /* OCC sensors */
 #define OCC_SENSOR_DATA_BLOCK_OFFSET          0x0000
@@ -67,6 +68,11 @@ static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
     qemu_set_irq(occ->psi_irq, !!(val & OCCMISC_PSI_IRQ));
 }
 
+static void pnv_occ_raise_msg_irq(PnvOCC *occ)
+{
+    pnv_occ_set_misc(occ, occ->occmisc | OCCMISC_PSI_IRQ | OCCMISC_IRQ_SHMEM);
+}
+
 static uint64_t pnv_occ_power8_xscom_read(void *opaque, hwaddr addr,
                                           unsigned size)
 {
@@ -281,6 +287,20 @@ static const TypeInfo pnv_occ_power10_type_info = {
 };
 
 static bool occ_init_homer_memory(PnvOCC *occ, Error **errp);
+static bool occ_model_tick(PnvOCC *occ);
+
+/* Relatively arbitrary */
+#define OCC_POLL_MS 100
+
+static void occ_state_machine_timer(void *opaque)
+{
+    PnvOCC *occ = opaque;
+    uint64_t next = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + OCC_POLL_MS;
+
+    if (occ_model_tick(occ)) {
+        timer_mod(&occ->state_machine_timer, next);
+    }
+}
 
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
@@ -306,6 +326,10 @@ static void pnv_occ_realize(DeviceState *dev, Error **errp)
                           PNV_OCC_SENSOR_DATA_BLOCK_SIZE);
 
     qdev_init_gpio_out(dev, &occ->psi_irq, 1);
+
+    timer_init_ms(&occ->state_machine_timer, QEMU_CLOCK_VIRTUAL,
+                  occ_state_machine_timer, occ);
+    timer_mod(&occ->state_machine_timer, OCC_POLL_MS);
 }
 
 static Property pnv_occ_properties[] = {
@@ -646,6 +670,27 @@ static bool occ_write_static_data(PnvOCC *occ,
     return true;
 }
 
+static bool occ_read_dynamic_data(PnvOCC *occ,
+                                  struct occ_dynamic_data *dynamic_data,
+                                  Error **errp)
+{
+    PnvOCCClass *poc = PNV_OCC_GET_CLASS(occ);
+    PnvHomer *homer = occ->homer;
+    hwaddr static_addr = homer->base + poc->opal_shared_memory_offset;
+    hwaddr dynamic_addr = static_addr + OPAL_DYNAMIC_DATA_OFFSET;
+    MemTxResult ret;
+
+    ret = address_space_read(&address_space_memory, dynamic_addr,
+                             MEMTXATTRS_UNSPECIFIED, dynamic_data,
+                             sizeof(*dynamic_data));
+    if (ret != MEMTX_OK) {
+        error_setg(errp, "OCC: cannot read OCC-OPAL dynamic data");
+        return false;
+    }
+
+    return true;
+}
+
 static bool occ_write_dynamic_data(PnvOCC *occ,
                                   struct occ_dynamic_data *dynamic_data,
                                   Error **errp)
@@ -667,6 +712,106 @@ static bool occ_write_dynamic_data(PnvOCC *occ,
     return true;
 }
 
+static bool occ_opal_send_response(PnvOCC *occ,
+                                   struct occ_dynamic_data *dynamic_data,
+                                   enum occ_response_status status,
+                                   uint8_t *data, uint16_t datalen)
+{
+    struct opal_command_buffer *cmd = &dynamic_data->cmd;
+    struct occ_response_buffer *rsp = &dynamic_data->rsp;
+
+    rsp->request_id = cmd->request_id;
+    rsp->cmd = cmd->cmd;
+    rsp->status = status;
+    rsp->data_size = cpu_to_be16(datalen);
+    if (datalen) {
+        memcpy(rsp->data, data, datalen);
+    }
+    if (!occ_write_dynamic_data(occ, dynamic_data, NULL)) {
+        return false;
+    }
+    /* Would be a memory barrier here */
+    rsp->flag = OCC_FLAG_RSP_READY;
+    cmd->flag = 0;
+    if (!occ_write_dynamic_data(occ, dynamic_data, NULL)) {
+        return false;
+    }
+
+    pnv_occ_raise_msg_irq(occ);
+
+    return true;
+}
+
+/* Returns error status */
+static bool occ_opal_process_command(PnvOCC *occ,
+                                     struct occ_dynamic_data *dynamic_data)
+{
+    struct opal_command_buffer *cmd = &dynamic_data->cmd;
+    struct occ_response_buffer *rsp = &dynamic_data->rsp;
+
+    if (rsp->flag == 0) {
+        /* Spend one "tick" in the in-progress state */
+        rsp->flag = OCC_FLAG_CMD_IN_PROGRESS;
+        return occ_write_dynamic_data(occ, dynamic_data, NULL);
+    } else if (rsp->flag != OCC_FLAG_CMD_IN_PROGRESS) {
+        return occ_opal_send_response(occ, dynamic_data,
+                                      OCC_RSP_INTERNAL_ERROR,
+                                      NULL, 0);
+    }
+
+    switch (cmd->cmd) {
+    case 0xD1: /* SET_POWER_CAP */
+        uint16_t data;
+        if (be16_to_cpu(cmd->data_size) != 2) {
+            return occ_opal_send_response(occ, dynamic_data,
+                                          OCC_RSP_INVALID_CMD_DATA_LENGTH,
+                                          (uint8_t *)&dynamic_data->cur_pwr_cap,
+                                          2);
+        }
+        data = be16_to_cpu(*(uint16_t *)cmd->data);
+        if (data == 0) { /* clear power cap */
+            dynamic_data->pwr_cap_type = 0x00; /* none */
+            data = PCAP_MAX_POWER_W;
+        } else {
+            dynamic_data->pwr_cap_type = 0x02; /* user set in-band */
+            if (data < PCAP_HARD_MIN_POWER_W) {
+                data = PCAP_HARD_MIN_POWER_W;
+            } else if (data > PCAP_MAX_POWER_W) {
+                data = PCAP_MAX_POWER_W;
+            }
+        }
+        dynamic_data->cur_pwr_cap = cpu_to_be16(data);
+        return occ_opal_send_response(occ, dynamic_data,
+                                      OCC_RSP_SUCCESS,
+                                      (uint8_t *)&dynamic_data->cur_pwr_cap, 2);
+
+    default:
+        return occ_opal_send_response(occ, dynamic_data,
+                                      OCC_RSP_INVALID_COMMAND,
+                                      NULL, 0);
+    }
+    g_assert_not_reached();
+}
+
+static bool occ_model_tick(PnvOCC *occ)
+{
+    struct occ_dynamic_data dynamic_data;
+
+    if (!occ_read_dynamic_data(occ, &dynamic_data, NULL)) {
+        /* Can't move OCC state field to safe because we can't map it! */
+        qemu_log("OCC: failed to read HOMER data, shutting down OCC\n");
+        return false;
+    }
+    if (dynamic_data.cmd.flag == OPAL_FLAG_CMD_READY) {
+        if (!occ_opal_process_command(occ, &dynamic_data)) {
+            qemu_log("OCC: failed to write HOMER data, shutting down OCC\n");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
 {
     PnvOCCClass *poc = PNV_OCC_GET_CLASS(occ);
-- 
2.45.2


