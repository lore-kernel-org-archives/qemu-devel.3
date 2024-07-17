Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D51C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVE-0008CP-9w; Wed, 17 Jul 2024 17:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVB-0007uK-ST
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVA-0002CE-2c
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367a9ab4d81so91204f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252872; x=1721857672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exmNDPsH0KpZQ3m+4rsADpeyE4/2w009QzC3/hhmhHY=;
 b=hn2cTS58emJ7YjvIbdBWILM3mU5dzTRCFWe/1GP8mZb6R0KqiL5YNYDL1kC1x/s0kf
 9jmD/OCusVewGBmbmUNkKeLRUYv/bEq8hAHyMUzNSfHAwkF0TJOLgyDl/foUbFn1fbo4
 KSdKQitJv+Qyutk1YbLRmN8NR4A8n9+IVxCU+ocHA34wqFFYoRaE6L1gHFzrujPt08oI
 /jrI+atDHohSbpur7YkdCEf4B5SGc5ZH0Q/0MTeSu+b3XcMW75HrzPXy+MxlAb+IiTki
 nRtugK1sqiNr1v7FPZcGenTb3KJt+DYG4xctd72K8+zs2x3nK6ckStOuAB0nNkOuWbgn
 blng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252872; x=1721857672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exmNDPsH0KpZQ3m+4rsADpeyE4/2w009QzC3/hhmhHY=;
 b=FZGtK7xAtjX+KvTfXCZLwvm2OPXuX3Ap2+wPA8m6Sou/VahuwzWeudkgY8PK2MG5s3
 PGPLSbCunVar6gjX9sKK3EPFqwtgY4w6lVR1fdCgfVco/jEySNCsa7IFYU+lzLeMFo+p
 qGZdcitvjVtjDBV60twH9sSwqUq/KLt8sewF2GC5i58axi7Arpbu5FTZfVAWU86r7her
 ZTLBws8CY249VVF35FCBBcAGHz4uKqb/3WrVnHvZqRJJmdUH0Zti1PUxBzFsBVnDFoEI
 YnskpRqt6FfScnGO8gMkcQSGyuNJS5n3hropVxSQZevmKQOSPoNgXur22cOGMu7BVxZV
 Xu1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuVDEpsb94N9ZbYLhSxlponjPlzeLpQqh+4vqVpxONSOHYqxFOi6aqRnZ2cNBfQOCX4w5B6uzNmRt0U13pOLOIkLW0pRw=
X-Gm-Message-State: AOJu0YxhuvrIpSrws+toCFdS3MNlSbMQIGk2xhZuDrLuolsGWdwy+XWc
 IKAmGcuAcwgm9uwfbV7Gh6MjlmUldOPsAQVQCA9xvfOvq8NbFZFWRFoObBhjVS4=
X-Google-Smtp-Source: AGHT+IH6uwKHtELkeXOqDFpZIPLs1MnF/gclpl1EsXYOMal2Fg2DBf5OtiHflL+jszgV0+RYrbSnsg==
X-Received: by 2002:a05:6000:2a8:b0:367:95d2:4ec0 with SMTP id
 ffacd0b85a97d-368317b4061mr1931740f8f.62.1721252872108; 
 Wed, 17 Jul 2024 14:47:52 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c7797d74sm12319205e9.4.2024.07.17.14.47.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 04/17] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
Date: Wed, 17 Jul 2024 23:46:55 +0200
Message-ID: <20240717214708.78403-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

In preparation to extract common IPI code in few commits,
extract loongson_ipi_common_realize().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 3b3481c43e..40ac769aad 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -275,7 +275,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPIState *s = LOONGSON_IPI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -301,20 +301,31 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
 
     s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for IPICore faile");
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi = s;
+
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
+}
+
+static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
+
+    loongson_ipi_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
+    for (unsigned i = 0; i < s->num_cpu; i++) {
         s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
         memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
                               &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
         sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
     }
 }
 
-- 
2.41.0


