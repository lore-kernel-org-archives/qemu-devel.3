Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894EBC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGM-0003sn-B0; Thu, 18 Jul 2024 09:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGK-0003iy-1O
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:36 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGI-0008RW-1f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:35 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e9c6b5a62so385504e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309612; x=1721914412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1X1N1UHwRToEvVtdtgPiuXjRXuRHL3MityADuWCMGFA=;
 b=qCfKJTkFS0eqUuBVdReCvqI8kk3oFEPJ599KRhOLan/dq4zJ4N8WRoPA0gOj2HPPyb
 Jit5gYGTbExX/2xaXn/wn8CtCSlJ1bkilNK2HBiP1t0ZPakCCWPS785e2LdYpDstXTFA
 91VtuDoYnQQ80wNRgnV4Qdtrin39Typ28ZV00faDNsylIsYRRPilz5EhIAUYfQIZzY9D
 z0vWfbhx76ZcAl4KNNVsttFfj9I24PSKAro0VQNnWoKQjQ0lWTo92oonFsnjQzNxldXP
 z4AZWUYOggSqjXOoBsJyDGNq/TS+aJOWLIYEtxi6EzXW0LnV5RdZqDZOVOmew0OHz/2p
 NV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309612; x=1721914412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1X1N1UHwRToEvVtdtgPiuXjRXuRHL3MityADuWCMGFA=;
 b=cQWOoe70k/dEpmBze6rocwqNo4grT2oEpeyRivP8Y/mPemBsE5emLpKaZ+W8nbw3vF
 mZamKrvsKb/i6rSBhuglX+RXdGcA77EvzuJAgTtgzJW9wNgY+/Jc0qihRQAyKg1GZBoV
 vuC6H544wC6SdaqsjnnE0K3TitpJQTbPXkdYXKLT3/+9gIqiHMGB5pbJaDA7mxWiY60Q
 whaTWqLy37ZYF4VtInQjnhFY5FlmTpfbvZ3KSu2fYdO/HqjHCfhY+J1Fr435Vvi+e4Um
 5GD6xgWuL6CZslyTsK8E3ayxmeKQMhNHLrzkArC9p8I/KErCSe+kEErJhNCxyrnwlDRw
 At8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYCliSoDUicn1arpKOQb31X7HUm2TuAiVIMcqXjnOOID1uvl3BedmbalsvtwVPTwgnkSmoNyiFAfGCbIiUSV3wo8YI6Ag=
X-Gm-Message-State: AOJu0YzKbZr4YwYBubkBZ/KBPaGQQ2MnqF/wxFQ8UOcB+fmR9Ptgqxjb
 5rwmU8yjhL6FXahSj4osfxix7cINbvns0Xersx52Rhj9W4HUjwVcngDgpvseM70=
X-Google-Smtp-Source: AGHT+IHEsqgslR0qUsWaqYMixjBiQmP1+4+nTShkAnzupczpHbDPDIVrDuTunApY+AlYTbaIHFfUmQ==
X-Received: by 2002:a05:6512:3b8f:b0:52c:820e:a7e7 with SMTP id
 2adb3069b0e04-52ee542b307mr3809009e87.50.1721309612180; 
 Thu, 18 Jul 2024 06:33:32 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8d8a8sm15126005e9.36.2024.07.18.06.33.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 03/19] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
Date: Thu, 18 Jul 2024 15:32:55 +0200
Message-ID: <20240718133312.10324-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
Acked-by: Song Gao <gaosong@loongson.cn>
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


