Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C21C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMfT-0002LY-Vh; Thu, 18 Jul 2024 04:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfS-0002GD-Dm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfP-0004ic-IB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so197142f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291949; x=1721896749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5lansJILRN85MsTS1zJi4KEEbl2KrPrS5MA+Irf47U=;
 b=xWnStxm5pJNpZB4PTD7bcI0k0Z+z1kSHmpT5dJNcRNAPSFtcF9Nr1Sxb+Mr81bMeUi
 enThWY0zHs1ffzefSHOnLO8pqxzsom0EgFTGixcXKYankYt5JUfPHWjv7vVRaf3wgsR2
 HiZwEhfYxHrKGjB9dUWNKWlJYQ+m76uxxXn8ePqFSdUHFAitGPF6MU/GKEZTFjJGCWoH
 FLxsMZ7aoSHsSChHkWCeUT7uAxc2SOG4MtGtPbI0VrBAF79FxSWF50Gj3/8ZGMXG/Ts4
 XJPkxZ1PYF6xj5zsNPzn80WRYLY1U+thwmR1Wwqe57AnWgr04sg0ErYfzDY5l2MNCHx/
 ZO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291949; x=1721896749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5lansJILRN85MsTS1zJi4KEEbl2KrPrS5MA+Irf47U=;
 b=hqauUpwiYh6NK7ITp5QpjQ8bITN94e34IIf7oKf5YHOgMHZj0TtZr5BWFAloCoE3Sw
 pwoSxzNqNHN6eQBELPONWqANSEFw7ehMcTGyCRoZeSHaJJJUi4omGp+9Ity2vilpg0AK
 f5duj1sUPlimbmca4Aei2pL3ovlvvYKTd9H2I1B4GW6VcCZB5CkCxdc2sEz/1jfiuHrg
 KICQFi3XmuLOo695bfUHZ6qWFCJi8x/s7HD6ya7fRyjTgRTl35xX74p6oIqRfIN9Sbql
 o+qfcDRYaBfBlNxK/Wy8Wx5kxZdWcv+UuaJ899Ojwkzfq8pwRx0RReIbn56Gc4wvTXN5
 zqvA==
X-Gm-Message-State: AOJu0Yx0BIhag6G43PruoL7txlZ9Su6aD6+yoMOQrbMLcN6Xd/B6/8Dd
 rJpVk/iQaRY3bgfbpGLiRalQ1uSMLDJlX9GWJvwPQJNf+8lgNqhXjDq6B46HvCSbNsFjSFcLYkm
 wFTU=
X-Google-Smtp-Source: AGHT+IFx9CbBV4zbYQsXbE3iuvxkTYQJQSI9zxAwMJ2nKs1ec+72+zqe/UWpjEwc7y952R3zvPlq+w==
X-Received: by 2002:adf:b511:0:b0:368:41e0:16c0 with SMTP id
 ffacd0b85a97d-36841e01812mr1631301f8f.22.1721291949600; 
 Thu, 18 Jul 2024 01:39:09 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf144sm13575237f8f.26.2024.07.18.01.39.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 03/18] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
Date: Thu, 18 Jul 2024 10:38:27 +0200
Message-ID: <20240718083842.81199-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

We'll have to add LoongsonIPIClass in few commits,
so rename LoongsonIPI as LoongsonIPIState for clarity.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongson_ipi.h |  6 +++---
 hw/intc/loongson_ipi.c         | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 3f795edbf3..efb772f384 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -31,10 +31,10 @@
 #define IPI_MBX_NUM           4
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
+OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPIState, LOONGSON_IPI)
 
 typedef struct IPICore {
-    LoongsonIPI *ipi;
+    LoongsonIPIState *ipi;
     MemoryRegion *ipi_mmio_mem;
     uint32_t status;
     uint32_t en;
@@ -45,7 +45,7 @@ typedef struct IPICore {
     qemu_irq irq;
 } IPICore;
 
-struct LoongsonIPI {
+struct LoongsonIPIState {
     SysBusDevice parent_obj;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index d315f6f303..d870af39c1 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -64,7 +64,7 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
                                             uint64_t *data,
                                             unsigned size, MemTxAttrs attrs)
 {
-    LoongsonIPI *ipi = opaque;
+    LoongsonIPIState *ipi = opaque;
     IPICore *s;
 
     if (attrs.requester_id >= ipi->num_cpu) {
@@ -160,7 +160,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
                                             MemTxAttrs attrs)
 {
     IPICore *s = opaque;
-    LoongsonIPI *ipi = s->ipi;
+    LoongsonIPIState *ipi = s->ipi;
     int index = 0;
     uint32_t cpuid;
     uint8_t vector;
@@ -214,7 +214,7 @@ static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
                                             uint64_t val, unsigned size,
                                             MemTxAttrs attrs)
 {
-    LoongsonIPI *ipi = opaque;
+    LoongsonIPIState *ipi = opaque;
     IPICore *s;
 
     if (attrs.requester_id >= ipi->num_cpu) {
@@ -277,7 +277,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
 
 static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 {
-    LoongsonIPI *s = LOONGSON_IPI(dev);
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     int i;
 
@@ -337,14 +337,14 @@ static const VMStateDescription vmstate_loongson_ipi = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPI, num_cpu,
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPIState, num_cpu,
                          vmstate_ipi_core, IPICore),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static Property ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPIState, num_cpu, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -359,7 +359,7 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 
 static void loongson_ipi_finalize(Object *obj)
 {
-    LoongsonIPI *s = LOONGSON_IPI(obj);
+    LoongsonIPIState *s = LOONGSON_IPI(obj);
 
     g_free(s->cpu);
 }
@@ -368,7 +368,7 @@ static const TypeInfo loongson_ipi_types[] = {
     {
         .name               = TYPE_LOONGSON_IPI,
         .parent             = TYPE_SYS_BUS_DEVICE,
-        .instance_size      = sizeof(LoongsonIPI),
+        .instance_size      = sizeof(LoongsonIPIState),
         .class_init         = loongson_ipi_class_init,
         .instance_finalize  = loongson_ipi_finalize,
     }
-- 
2.41.0


