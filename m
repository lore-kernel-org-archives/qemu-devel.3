Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152DEC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCUn-00071B-OF; Wed, 17 Jul 2024 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCUm-000701-2J
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCUk-0001sM-BX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36844375001so113123f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252848; x=1721857648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HOJ9dHSdrI02h20r8v9vJ4RkLFUfsaDgRPfqb5PG7w=;
 b=pAlSW3O0CmnArL+gH1RWSfJbEbenDhbOZ7iePiSddYTit2xEN+pM3sM/U84PWCkSO9
 VKIXi5hz3qlRO1tiSdeHrH1y0h/aNAlOe/bfDyEA/ormpUDQd5iVhqFhQBPtQBvw3Aa8
 g9E0lVO0F7/Xvd26cEj+f3rnARGS30ULAzAUfhRNY4lkLvztXfgz67XICEuxG2Yic+sy
 VdRZV9hekgch3eCd0Gu9g1oIU1muXPwfPtjGzfmm5B4GBJlPCTis/qVY9E/o/WPhKMZJ
 pUnVmIg9SKh+vIDsiBkCkEVN1XhuexxBKJbf8hOh1kr3KGkS+1cj4MAg5y6UCSJN8rxZ
 mYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252848; x=1721857648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HOJ9dHSdrI02h20r8v9vJ4RkLFUfsaDgRPfqb5PG7w=;
 b=am//z2zl3490uY21v88ZbLQ3ggOAvLf3stuxaOqnUiDwH0+Q++Sk1S/YOBPY587qQp
 4nXa1mXt9aFcpAJxS0VBep6bSbz239nb3Y8pwbLoG88sCynobWAaKx6OI2AEgmYUFGAR
 v/jPm+6bTdFFLR94uEgEJSx/b8kuN5o00H/Fqm7xsduDVbJv4ADF2s0pCgmB1Dt1kvcW
 ryLBg6ds3dljgkgBFwzH94fnaN08IFu2umGxRlJv1nX0bg2BTLxIpGAU7AUE27lGn9H3
 us4i86iWdYoG7+Db4UuMkdW2mD3bRbh1KZjVt/aJlrL2y8eKdipxpY/g0CxjZdFI5unU
 4IDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1YfGAl8qm7y8I3BeknWJ1gFY+eQZiEapO+psy0dPXSrpQwhhdgtE76j58ZhGt4TT9MnfY3k+2+E6COLLMr036LLfTpDI=
X-Gm-Message-State: AOJu0YwMbbV+j3sf2cUZQ1aQbBmKHOKEcledpMwhpEmMRiA+USpZ795F
 qrCak59Zd9bh/Z5ekmw217WftC11r42XU6t6mPpIQvQEDzzQpeOQObPy0xJPy7c=
X-Google-Smtp-Source: AGHT+IFQ74xOaocD3Cuj2QbT/EgamOmtX6kmbMb5RuQxA4M2LzOuHFWAmFchWuhDi7GBwkQEYRnjbw==
X-Received: by 2002:adf:fa8d:0:b0:367:8aa3:436f with SMTP id
 ffacd0b85a97d-3683167aedbmr1825102f8f.38.1721252846929; 
 Wed, 17 Jul 2024 14:47:26 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c780c9d5sm10992955e9.38.2024.07.17.14.47.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:47:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 02/17] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
Date: Wed, 17 Jul 2024 23:46:53 +0200
Message-ID: <20240717214708.78403-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index e7979dbdd8..a34e7e634f 100644
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
@@ -367,7 +367,7 @@ static void loongson_ipi_finalize(Object *obj)
 static const TypeInfo loongson_ipi_info = {
     .name          = TYPE_LOONGSON_IPI,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongsonIPI),
+    .instance_size = sizeof(LoongsonIPIState),
     .class_init    = loongson_ipi_class_init,
     .instance_finalize = loongson_ipi_finalize,
 };
-- 
2.41.0


