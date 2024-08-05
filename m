Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C968EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb26W-0005kQ-F9; Mon, 05 Aug 2024 14:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26V-0005jg-9d
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26T-0006O9-Ij
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42819654737so67693345e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881200; x=1723486000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5uNst4W6LAAfy5PWyCP4yG159IePDhcmfia8qBHksY=;
 b=y1Xw4TQtsidYL/UnDxqVe8SG3Gacakh4ZjFJhQv3Y55GTQDto7e6hRhjJaATYdrluW
 mZ/v07m77zR5PbIiALA3jj/dTMLjltqogzp5Iv5l6Z/jKldd8DdJZA0u/n5/JzqGU87t
 qS7bcDyFxK+RIylLOLr9LdyDNoW7R94WsUKh8ZcZ5HJTDM9TYQGtqAKf73bmJCiX/RuZ
 SIK3CPUMbiqVy9xk2Qt931TXbuFNs+CUUfR0Z7I3JOsHtKyWhgj+nOQnsZUBuXh15QFR
 en7oAjXiqNy/Z8JcHPBdq+pEIF4ersYSSF2S225vBZR1zLhxrNkp+ueoK/xD42mW95S4
 1QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881200; x=1723486000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5uNst4W6LAAfy5PWyCP4yG159IePDhcmfia8qBHksY=;
 b=ttVykInKF8s47l4BcSgAzCSDclomauEwGWGnJaxYuYrNByaYTqcniX8Yn140/EyoEy
 bGoQ6HDgfFV+gW7QdrhVXhGpnFh1llL9cd7yDItNoP797g1FRF+qoXRMIDJpqoLy/rrQ
 6a7xzNe92aOBYX6FJaZ9o+yDBG+U1uNiNP++FNO5a9ZH8g7tEdO5Hxi0Llo+OgJOSuMB
 KoQLPf8H80B69Hg1cZUS74HuvNj1lprLwOVQFeRjpca0BxRbUrYTogGxCKDsGe6BfFzk
 ccye73IPEEDWcBFLNH+Fr1A/67tH7LYLf+Gy31oTDT/O+YMbcNYGH7iT27g5TulPk0sl
 RFdg==
X-Gm-Message-State: AOJu0YylbqqGbe4WiPeFBztTICzGPeZV7sH1vodb3nqE/pL5DP9MT8jr
 4TcARZk6gGOGALhCNgGHdT27h4eMJ69EXIpQCwySjIaF4NDdhTMwv1MlKxVUDcp/1KdCfByGZGl
 X
X-Google-Smtp-Source: AGHT+IH+/b5gXbgVYgqAE5C/9oJu9I+V/z5UKh+QPkq9aw270746zBALsF8awtuO0Hja1QdEfWoDuA==
X-Received: by 2002:a5d:4fc7:0:b0:368:7fd3:291c with SMTP id
 ffacd0b85a97d-36bbc180c19mr7926345f8f.60.1722881199386; 
 Mon, 05 Aug 2024 11:06:39 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06fbfdsm10519622f8f.106.2024.08.05.11.06.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:06:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 02/15] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
Date: Mon,  5 Aug 2024 20:06:09 +0200
Message-ID: <20240805180622.21001-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-6-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 903483ae80..8aab7e48e8 100644
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
@@ -301,30 +301,46 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
 
     s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for IPICore faile");
-        return;
-    }
-
     for (i = 0; i < s->num_cpu; i++) {
         s->cpu[i].ipi = s;
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
-        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
-                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
 
         qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
     }
 }
 
-static void loongson_ipi_unrealize(DeviceState *dev)
+static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
+
+    loongson_ipi_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    for (unsigned i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
+        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
+        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
+        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+    }
+}
+
+static void loongson_ipi_common_unrealize(DeviceState *dev)
 {
     LoongsonIPIState *s = LOONGSON_IPI(dev);
 
     g_free(s->cpu);
 }
 
+static void loongson_ipi_unrealize(DeviceState *dev)
+{
+    loongson_ipi_common_unrealize(dev);
+}
+
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
     .version_id = 2,
-- 
2.45.2


