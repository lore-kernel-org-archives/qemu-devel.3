Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23C8CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHs-0000Fd-Fe; Tue, 21 Oct 2025 16:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHp-0000B3-II
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHm-0001Bf-2j
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso43074905e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079726; x=1761684526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pm3cCQ10tYk8d37QLddrP30Ira7iE5Xo6EG/tSdEOMU=;
 b=ONPl/mviAiPnYPpO+s+pG5C/7W7YWnywePAT/DuR8iockeRHOSRf5h+HmYcZ733WHc
 BPkxpb5ej5QgrBpxisdPWNokAgVAHuGAkVwDhMVauHMu3Ctz21cYqvd50AQiVIBb6v6S
 /XoR9Q5qAqusNF2gGo7JRLNrHBq9MmXId88qxCFoVnoxJQAbayV/H35VTjOJB1J0SRoW
 7I5n+QtK67/mciFAlelID+R/LhrdQCEP2biRfMOMfmQtn+sVKzebeq6rd91ZWyMYsEad
 o7AJfTkW/jB2V16Y1RSUb8RzLk+kDxec0ywkSGf0ijFk9b9Ni74dNfn55N7KKeI+7rEt
 EfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079726; x=1761684526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pm3cCQ10tYk8d37QLddrP30Ira7iE5Xo6EG/tSdEOMU=;
 b=foo4mai//5npxfImu9cvVDREQGK2sg7VbUURtMde1ZNw95xsdMdXk5sZLJY07uZxvS
 7gVLm1nJEx1QP6c4NAnXCCFGWxq8CQMS22VKtozkT6vsywgwIRcKj+JFKAzO2YNdFWTp
 VdajEljqVysBxGRN8dObSHPv2c5HHn3HdU3b5yoNpZSXtl50U+tqRVLet5gYZuk20TjY
 rKATPBvt/FKV3CNTWsM2MA6Oh8C19IJpf8Re71T6RuasZFk6ZwNKtiAw7hWFXxu1r+s7
 8HVCrAnn+WRk0YUSPg+ALd06D68UeaZQQ5OdP4fZjVdEcou+PXpTku9ZAKnTwEDFt08K
 P7kQ==
X-Gm-Message-State: AOJu0YxrNQq2L7gTKAsTLeYXi7e6KFU4yfmmt4nwGnEFkvF9ILuQ9YDU
 7tnWXrV+Spm5X0BCaP2UHMzzqytrbakNwC8B2bvsIHiJF+XC594TljBCzs+OIuj5wA2a75pVdXl
 w6n9h8OU=
X-Gm-Gg: ASbGnctA09ZQHM/ezRyX5dLOLS5YeyX8xmeGxTs+e2yC3zIlXn20I2i40rAgWM3Yv4s
 Smd0SAKvGqvtRTm5Zmy2moobHYzAQIQSV02ZTEn2jU8TzuWsgL1N/BtTAqv57DWSjR1xF+j2I3a
 rK1scXjSOmYEmduBu2EIqm8zlNb8HcDc3wBwJcln7lGQaefpZzPsHNOdodVVcMei9hqMyd7Sa4X
 xzp4eYrAJ3Y4mcbmHjroO/wt0aN9fmajqBmyYLZ9AUIcM77KZQF7QYFxTEJmhvBUE8d9JfaVvWj
 E92HM1s9lMin+65kasfRJeHWzTiTPGZyhnFjfKbksg6N9vP5ALIvrRsUU5utDX2x8AnSM63rdmb
 y3ERzSgB5fJLaaSqFMpgc3R8pc2qsDtRHRYFeUdIvNrHpVJq79nHaKzm+cv4P/sI2c6fPWIgM0e
 Ajjq/A/L/5xbi/J/twiU2i9Tz8z+kcjSRxVbUXepgmkhkI/RIQDw==
X-Google-Smtp-Source: AGHT+IF9xeU35tnwNruu0VbMQf5zaeTVg+1Ap70Go1+m30PtINYvI0CUtLPXw/XQ05R1ZZ/o/vlrmA==
X-Received: by 2002:a05:600c:470d:b0:471:7c8:ddf7 with SMTP id
 5b1f17b1804b1-471178a7447mr121045525e9.14.1761079725951; 
 Tue, 21 Oct 2025 13:48:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4378cbesm9203365e9.16.2025.10.21.13.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/45] hw/net/can/xlnx-versal-canfd: remove register API usage
 for banked regs
Date: Tue, 21 Oct 2025 22:46:36 +0200
Message-ID: <20251021204700.56072-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Luc Michel <luc.michel@amd.com>

Now that we have a simple decoding logic for all the banked registers,
remove the register API usage for them. This restricts the register API
usage to only the base registers (from 0x0 to 0xec).

This also removes all the custom code that was creating register
descriptors for the register API and was leading to memory leaks when
the device was finalized.

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Message-ID: <20251017161809.235740-7-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/net/xlnx-versal-canfd.h |   8 -
 hw/net/can/xlnx-versal-canfd.c     | 303 ++---------------------------
 2 files changed, 15 insertions(+), 296 deletions(-)

diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
index ad3104dd13f..396f90d6dc1 100644
--- a/include/hw/net/xlnx-versal-canfd.h
+++ b/include/hw/net/xlnx-versal-canfd.h
@@ -54,14 +54,6 @@ typedef struct XlnxVersalCANFDState {
     qemu_irq                irq_addr_err;
 
     RegisterInfo            reg_info[XLNX_VERSAL_CANFD_R_MAX];
-    RegisterAccessInfo      *tx_regs;
-    RegisterAccessInfo      *rx0_regs;
-    RegisterAccessInfo      *rx1_regs;
-    RegisterAccessInfo      *af_regs;
-    RegisterAccessInfo      *txe_regs;
-    RegisterAccessInfo      *rx_mailbox_regs;
-    RegisterAccessInfo      *af_mask_regs_mailbox;
-
     uint32_t                regs[XLNX_VERSAL_CANFD_R_MAX];
 
     ptimer_state            *canfd_timer;
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 04f9a6d57d7..5735639b85a 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1426,46 +1426,6 @@ static void filter_reg_write(XlnxVersalCANFDState *s, hwaddr addr,
     }
 }
 
-static uint64_t filter_mask(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
-    uint32_t reg_idx = (reg->access->addr) / 4;
-    uint32_t val = val64;
-    uint32_t filter_offset = (reg_idx - R_AFMR_REGISTER) / 2;
-
-    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
-        (1 << filter_offset))) {
-        s->regs[reg_idx] = val;
-    } else {
-        g_autofree char *path = object_get_canonical_path(OBJECT(s));
-
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter %d not enabled\n",
-                      path, filter_offset + 1);
-    }
-
-    return s->regs[reg_idx];
-}
-
-static uint64_t filter_id(RegisterInfo *reg, uint64_t val64)
-{
-    XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
-    hwaddr reg_idx = (reg->access->addr) / 4;
-    uint32_t val = val64;
-    uint32_t filter_offset = (reg_idx - R_AFIR_REGISTER) / 2;
-
-    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
-        (1 << filter_offset))) {
-        s->regs[reg_idx] = val;
-    } else {
-        g_autofree char *path = object_get_canonical_path(OBJECT(s));
-
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter %d not enabled\n",
-                      path, filter_offset + 1);
-    }
-
-    return s->regs[reg_idx];
-}
-
 static uint64_t canfd_tx_fifo_status_prew(RegisterInfo *reg, uint64_t val64)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
@@ -1591,125 +1551,6 @@ static uint64_t canfd_write_check_prew(RegisterInfo *reg, uint64_t val64)
     return 0;
 }
 
-static const RegisterAccessInfo canfd_tx_regs[] = {
-    {   .name = "TB_ID_REGISTER",  .addr = A_TB_ID_REGISTER,
-    },{ .name = "TB0_DLC_REGISTER",  .addr = A_TB0_DLC_REGISTER,
-    },{ .name = "TB_DW0_REGISTER",  .addr = A_TB_DW0_REGISTER,
-    },{ .name = "TB_DW1_REGISTER",  .addr = A_TB_DW1_REGISTER,
-    },{ .name = "TB_DW2_REGISTER",  .addr = A_TB_DW2_REGISTER,
-    },{ .name = "TB_DW3_REGISTER",  .addr = A_TB_DW3_REGISTER,
-    },{ .name = "TB_DW4_REGISTER",  .addr = A_TB_DW4_REGISTER,
-    },{ .name = "TB_DW5_REGISTER",  .addr = A_TB_DW5_REGISTER,
-    },{ .name = "TB_DW6_REGISTER",  .addr = A_TB_DW6_REGISTER,
-    },{ .name = "TB_DW7_REGISTER",  .addr = A_TB_DW7_REGISTER,
-    },{ .name = "TB_DW8_REGISTER",  .addr = A_TB_DW8_REGISTER,
-    },{ .name = "TB_DW9_REGISTER",  .addr = A_TB_DW9_REGISTER,
-    },{ .name = "TB_DW10_REGISTER",  .addr = A_TB_DW10_REGISTER,
-    },{ .name = "TB_DW11_REGISTER",  .addr = A_TB_DW11_REGISTER,
-    },{ .name = "TB_DW12_REGISTER",  .addr = A_TB_DW12_REGISTER,
-    },{ .name = "TB_DW13_REGISTER",  .addr = A_TB_DW13_REGISTER,
-    },{ .name = "TB_DW14_REGISTER",  .addr = A_TB_DW14_REGISTER,
-    },{ .name = "TB_DW15_REGISTER",  .addr = A_TB_DW15_REGISTER,
-    }
-};
-
-static const RegisterAccessInfo canfd_rx0_regs[] = {
-    {   .name = "RB_ID_REGISTER",  .addr = A_RB_ID_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DLC_REGISTER",  .addr = A_RB_DLC_REGISTER,
-        .ro = 0xfe1fffff,
-    },{ .name = "RB_DW0_REGISTER",  .addr = A_RB_DW0_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW1_REGISTER",  .addr = A_RB_DW1_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW2_REGISTER",  .addr = A_RB_DW2_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW3_REGISTER",  .addr = A_RB_DW3_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW4_REGISTER",  .addr = A_RB_DW4_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW5_REGISTER",  .addr = A_RB_DW5_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW6_REGISTER",  .addr = A_RB_DW6_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW7_REGISTER",  .addr = A_RB_DW7_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW8_REGISTER",  .addr = A_RB_DW8_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW9_REGISTER",  .addr = A_RB_DW9_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW10_REGISTER",  .addr = A_RB_DW10_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW11_REGISTER",  .addr = A_RB_DW11_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW12_REGISTER",  .addr = A_RB_DW12_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW13_REGISTER",  .addr = A_RB_DW13_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW14_REGISTER",  .addr = A_RB_DW14_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW15_REGISTER",  .addr = A_RB_DW15_REGISTER,
-        .ro = 0xffffffff,
-    }
-};
-
-static const RegisterAccessInfo canfd_rx1_regs[] = {
-    {   .name = "RB_ID_REGISTER_1",  .addr = A_RB_ID_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DLC_REGISTER_1",  .addr = A_RB_DLC_REGISTER_1,
-        .ro = 0xfe1fffff,
-    },{ .name = "RB0_DW0_REGISTER_1",  .addr = A_RB0_DW0_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW1_REGISTER_1",  .addr = A_RB_DW1_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW2_REGISTER_1",  .addr = A_RB_DW2_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW3_REGISTER_1",  .addr = A_RB_DW3_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW4_REGISTER_1",  .addr = A_RB_DW4_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW5_REGISTER_1",  .addr = A_RB_DW5_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW6_REGISTER_1",  .addr = A_RB_DW6_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW7_REGISTER_1",  .addr = A_RB_DW7_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW8_REGISTER_1",  .addr = A_RB_DW8_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW9_REGISTER_1",  .addr = A_RB_DW9_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW10_REGISTER_1",  .addr = A_RB_DW10_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW11_REGISTER_1",  .addr = A_RB_DW11_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW12_REGISTER_1",  .addr = A_RB_DW12_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW13_REGISTER_1",  .addr = A_RB_DW13_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW14_REGISTER_1",  .addr = A_RB_DW14_REGISTER_1,
-        .ro = 0xffffffff,
-    },{ .name = "RB_DW15_REGISTER_1",  .addr = A_RB_DW15_REGISTER_1,
-        .ro = 0xffffffff,
-    }
-};
-
-/* Acceptance filter registers. */
-static const RegisterAccessInfo canfd_af_regs[] = {
-    {   .name = "AFMR_REGISTER",  .addr = A_AFMR_REGISTER,
-        .pre_write = filter_mask,
-    },{ .name = "AFIR_REGISTER",  .addr = A_AFIR_REGISTER,
-        .pre_write = filter_id,
-    }
-};
-
-static const RegisterAccessInfo canfd_txe_regs[] = {
-    {   .name = "TXE_FIFO_TB_ID_REGISTER",  .addr = A_TXE_FIFO_TB_ID_REGISTER,
-        .ro = 0xffffffff,
-    },{ .name = "TXE_FIFO_TB_DLC_REGISTER",  .addr = A_TXE_FIFO_TB_DLC_REGISTER,
-        .ro = 0xffffffff,
-    }
-};
-
 static const RegisterAccessInfo canfd_regs_info[] = {
     {   .name = "SOFTWARE_RESET_REGISTER",  .addr = A_SOFTWARE_RESET_REGISTER,
         .pre_write = canfd_srr_pre_write,
@@ -1915,6 +1756,16 @@ static const MemoryRegionOps canfd_ops = {
     },
 };
 
+static const MemoryRegionOps canfd_regs_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void canfd_reset(DeviceState *dev)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(dev);
@@ -1994,140 +1845,16 @@ static int xlnx_canfd_connect_to_bus(XlnxVersalCANFDState *s,
     return can_bus_insert_client(bus, &s->bus_client);
 }
 
-#define NUM_REG_PER_AF      ARRAY_SIZE(canfd_af_regs)
-#define NUM_AF              32
-#define NUM_REG_PER_TXE     ARRAY_SIZE(canfd_txe_regs)
-#define NUM_TXE             32
-
-static int canfd_populate_regarray(XlnxVersalCANFDState *s,
-                                  RegisterInfoArray *r_array, int pos,
-                                  const RegisterAccessInfo *rae,
-                                  int num_rae)
-{
-    int i;
-
-    for (i = 0; i < num_rae; i++) {
-        int index = rae[i].addr / 4;
-        RegisterInfo *r = &s->reg_info[index];
-
-        *r = (RegisterInfo) {
-            .data = &s->regs[index],
-            .data_size = sizeof(uint32_t),
-            .access = &rae[i],
-            .opaque = OBJECT(s),
-        };
-
-        r_array->r[i + pos] = r;
-    }
-    return i + pos;
-}
-
-static void canfd_create_rai(RegisterAccessInfo *rai_array,
-                                const RegisterAccessInfo *canfd_regs,
-                                int template_rai_array_sz,
-                                int num_template_to_copy)
-{
-    int i;
-    int reg_num;
-
-    for (reg_num = 0; reg_num < num_template_to_copy; reg_num++) {
-        int pos = reg_num * template_rai_array_sz;
-
-        memcpy(rai_array + pos, canfd_regs,
-               template_rai_array_sz * sizeof(RegisterAccessInfo));
-
-        for (i = 0; i < template_rai_array_sz; i++) {
-            const char *name = canfd_regs[i].name;
-            uint64_t addr = canfd_regs[i].addr;
-            rai_array[i + pos].name = g_strdup_printf("%s%d", name, reg_num);
-            rai_array[i + pos].addr = addr + pos * 4;
-        }
-    }
-}
-
-static RegisterInfoArray *canfd_create_regarray(XlnxVersalCANFDState *s)
-{
-    const char *device_prefix = object_get_typename(OBJECT(s));
-    uint64_t memory_size = XLNX_VERSAL_CANFD_R_MAX * 4;
-    int num_regs;
-    int pos = 0;
-    RegisterInfoArray *r_array;
-
-    num_regs = ARRAY_SIZE(canfd_regs_info) +
-                s->cfg.tx_fifo * NUM_REGS_PER_MSG_SPACE +
-                s->cfg.rx0_fifo * NUM_REGS_PER_MSG_SPACE +
-                NUM_AF * NUM_REG_PER_AF +
-                NUM_TXE * NUM_REG_PER_TXE;
-
-    s->tx_regs = g_new0(RegisterAccessInfo,
-                        s->cfg.tx_fifo * ARRAY_SIZE(canfd_tx_regs));
-
-    canfd_create_rai(s->tx_regs, canfd_tx_regs,
-                     ARRAY_SIZE(canfd_tx_regs), s->cfg.tx_fifo);
-
-    s->rx0_regs = g_new0(RegisterAccessInfo,
-                         s->cfg.rx0_fifo * ARRAY_SIZE(canfd_rx0_regs));
-
-    canfd_create_rai(s->rx0_regs, canfd_rx0_regs,
-                     ARRAY_SIZE(canfd_rx0_regs), s->cfg.rx0_fifo);
-
-    s->af_regs = g_new0(RegisterAccessInfo,
-                        NUM_AF * ARRAY_SIZE(canfd_af_regs));
-
-    canfd_create_rai(s->af_regs, canfd_af_regs,
-                     ARRAY_SIZE(canfd_af_regs), NUM_AF);
-
-    s->txe_regs = g_new0(RegisterAccessInfo,
-                         NUM_TXE * ARRAY_SIZE(canfd_txe_regs));
-
-    canfd_create_rai(s->txe_regs, canfd_txe_regs,
-                     ARRAY_SIZE(canfd_txe_regs), NUM_TXE);
-
-    if (s->cfg.enable_rx_fifo1) {
-        num_regs += s->cfg.rx1_fifo * NUM_REGS_PER_MSG_SPACE;
-
-        s->rx1_regs = g_new0(RegisterAccessInfo,
-                             s->cfg.rx1_fifo * ARRAY_SIZE(canfd_rx1_regs));
-
-        canfd_create_rai(s->rx1_regs, canfd_rx1_regs,
-                         ARRAY_SIZE(canfd_rx1_regs), s->cfg.rx1_fifo);
-    }
-
-    r_array = g_new0(RegisterInfoArray, 1);
-    r_array->r = g_new0(RegisterInfo * , num_regs);
-    r_array->num_elements = num_regs;
-    r_array->prefix = device_prefix;
-
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  canfd_regs_info,
-                                  ARRAY_SIZE(canfd_regs_info));
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->tx_regs, s->cfg.tx_fifo *
-                                  NUM_REGS_PER_MSG_SPACE);
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->rx0_regs, s->cfg.rx0_fifo *
-                                  NUM_REGS_PER_MSG_SPACE);
-    if (s->cfg.enable_rx_fifo1) {
-        pos = canfd_populate_regarray(s, r_array, pos,
-                                      s->rx1_regs, s->cfg.rx1_fifo *
-                                      NUM_REGS_PER_MSG_SPACE);
-    }
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->af_regs, NUM_AF * NUM_REG_PER_AF);
-    pos = canfd_populate_regarray(s, r_array, pos,
-                                  s->txe_regs, NUM_TXE * NUM_REG_PER_TXE);
-
-    memory_region_init_io(&r_array->mem, OBJECT(s), &canfd_ops, r_array,
-                          device_prefix, memory_size);
-    return r_array;
-}
-
 static void canfd_realize(DeviceState *dev, Error **errp)
 {
     XlnxVersalCANFDState *s = XILINX_CANFD(dev);
     RegisterInfoArray *reg_array;
 
-    reg_array = canfd_create_regarray(s);
+    reg_array = register_init_block32(dev, canfd_regs_info,
+                                      ARRAY_SIZE(canfd_regs_info), s->reg_info,
+                                      s->regs, &canfd_regs_ops, false,
+                                      A_RX_FIFO_WATERMARK_REGISTER
+                                          + sizeof(uint32_t));
     memory_region_add_subregion(&s->iomem, 0x00, &reg_array->mem);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq_canfd_int);
-- 
2.51.0


