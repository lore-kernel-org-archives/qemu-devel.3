Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E06C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCp-0002Hj-3c; Tue, 11 Mar 2025 08:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCf-0001xO-3N; Tue, 11 Mar 2025 08:59:25 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCb-0007wb-3v; Tue, 11 Mar 2025 08:59:24 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso7752706a91.0; 
 Tue, 11 Mar 2025 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697958; x=1742302758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UE/0F1oCsxuW6Zn4Oxkfeuhf/dmH1J3omqaeTt273/s=;
 b=ZOEbIlSBwYIwDAjkGnI+bqaFKpkjzdY4Mpe3ibd4e6N/zll+iFV11FaOXgIzrizC0j
 MLlSNdUW/yDdciS4XJ4C6gcpDmDWvJvcVqqrVmDUW51qrGvSbLfAPMW8BHbBvswFIqme
 d1ISZvKHNPmaB9WcfVQRGGhANCr5sv/WcU2P0yyG613xEVAYA6jKHZT0wcaoHA/mp1Zm
 fEnYgKQ5IaFLNC6cPhXL669Yj9Fe0Oi/W0XQANwYRbeiIb0pPsb5bMUvEV7BJvf7nKL6
 hV3XZvBHOCkB6KVVhD1e3C7/iEvU8FMrX4K0WTE+BugSWNwpMbp+qqQsKeU2roCgmHKh
 nOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697958; x=1742302758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UE/0F1oCsxuW6Zn4Oxkfeuhf/dmH1J3omqaeTt273/s=;
 b=APUy/yphjyajt1U1wxsfe0YJ72m/loaFD6+K+D5LHo8ahVQfmmaDdN8gko+bMzdGa0
 rJ1Ow6l4ZLhlwRd1VpB0nX+/VOI4Uhg4gVljoAtjOW6Vw+tWBrK1zt4YACXQ2cDRPEC/
 HpECOCYZrvwLFZpCZKfK+9pKLLm8VKMWiF5GkR5iy+9yvdGVd/AyOmkV7KPtVX3P0wU6
 M3lPp0Q+J5yw/2y9O2pzCRLYF+6RTKkCFXNBpEEaLmM7/ZBMaGbegBV8UhThZpIhoo24
 wmS9XVWDQ7u10j4MKuVdNTg6jE7hPTGWFZYsKE/Ne0Yj/mTGqIVXP8Ihr8JOe+bnqNNj
 GAgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCO/zHWT+7g8jSm/wN9QK+SWAE81womiU5pi7CMUWHQjIjzrIbv8/uB98DM3ARLqdYEmmnwC4xhg==@nongnu.org
X-Gm-Message-State: AOJu0YzvQ9Qf5XE8NIqc+eyNAmieBWdA78baRbQ1V1r6HN3pBXqw7GiZ
 kRy6kgdk27xze3zilEDHTZOJyOXudYyzLdTDMRgWRlHq5S90PluQYA42uQ==
X-Gm-Gg: ASbGncuUlmoRcr1IrkSQ1favtSNMPl5Gebb2jvC2UnJ8mL2cZ1l4ciVeMA+JQsVo6z6
 /kvnHaitqPjB5StaegMML6yIly0NZCBEUXaydN+/n0dlyGx5+XwSxW4Lj36Fjmctv90dAscZ1tu
 NWbia+WrfZjbJUlwKoQbLDKeyhEkHj5lm5SypPRt6GppktttbCBemgGRMsEFx4VMcUUfrMMG3d/
 6G3eKvHfieZzsF5Pgy0tQW3dtRP/bmnrb6T+kjWfcf9bL7S+bzUY2zkMiFTQM3XowEI4/xIfzP9
 h/gDiqmN4Wx/luuuzYyFI9ggioL+GuhnS5TBpFgTcypeB0Hw3pU=
X-Google-Smtp-Source: AGHT+IHiRLIIZjbcAFAK0jHHweWIKArYV/YLTbEn2bwKu3i8Mg4V2J0vjSwg8413tKV8DzxxyzIYNQ==
X-Received: by 2002:a17:90b:3887:b0:2fe:80cb:ac05 with SMTP id
 98e67ed59e1d1-2ff7ce7ac2bmr28535031a91.9.1741697957658; 
 Tue, 11 Mar 2025 05:59:17 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 15/72] ppc/pnv/occ: Implement a basic dynamic OCC model
Date: Tue, 11 Mar 2025 22:57:09 +1000
Message-ID: <20250311125815.903177-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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
 hw/ppc/pnv_occ.c         | 146 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_occ.h |   3 +
 2 files changed, 149 insertions(+)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 34decb1700..d9ce35a4d6 100644
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
 
 static const Property pnv_occ_properties[] = {
@@ -647,6 +671,27 @@ static bool occ_write_static_data(PnvOCC *occ,
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
@@ -668,6 +713,107 @@ static bool occ_write_dynamic_data(PnvOCC *occ,
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
+    case 0xD1: { /* SET_POWER_CAP */
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
+    }
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
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index f994860980..3ec42de0ff 100644
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
 
-- 
2.47.1


