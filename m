Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12954C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJg3-0006Df-HI; Tue, 06 Aug 2024 08:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJg2-0006Ao-Pv
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:34 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJg1-0008R1-2d
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:34 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52efd855adbso938164e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948751; x=1723553551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtzQOHvlE55OSnA48RNxVcrzEb0jC3AHIEec0cFYiUU=;
 b=oqMmWobdRxUPOyN26y6lubUXjzqiTSVaCEMDvJCv5gwr9mGv9AJYNYYxChS2icHnV5
 cdzmK1iW3ZFbge0V8d6mylzDuS26iBlJyWuuJFrX7IX4KGWpY/BNrx72WN6JB4VCIp7g
 X16jdqyiJMAbz7uxOMpCQmWW7f7U7eS6PtvJ2aJ2Qz6bKvUjHQORmXTAsfbORDbFASIX
 ugqe0Y7fx+v+3H8BSpOfe39YRf+sge8e0UJboFhGd7YgGr9eUlixxR6M4Y4aIFsMqhE1
 bqqFrbyi+MaBglvYHMq3THPp0oJvER8SkJAHBM/OOq2nsA/XsJTRNmk9/Q4Wu/xNBYPb
 irCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948751; x=1723553551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtzQOHvlE55OSnA48RNxVcrzEb0jC3AHIEec0cFYiUU=;
 b=jMMuKiuR7rs1D5uSdFfvnBzZ1J+7pWS2rtPOB8240KZqURe+jLr1f/ApEzWJFiSCnD
 jjVyRPKGGLnNOLUZrKQ3moaoW0rAArcouRAS+FCmaYh2wpolQYh/MHMPzGUVzHW1+Efg
 ocGa4frCPhtvLSB+907UH4awGgzgH9Oz3vBiZfibtXC7yARdcqJliDAbimfIWshE+GOg
 q1omCgB0wIGhGnnV9jnE1cOghzC7rmqcImk1ESXg49sPMFA2ChET7og9NmPxAhWwYa8H
 QGjmNjMas+IDr5OmBsIQjW5/cr5YleXgJXdT8o8HKzkiX4xL+mTapj48FvdEihiVfcYM
 t2HA==
X-Gm-Message-State: AOJu0YxEKoBaSnoMPjsqzzFQqiXpBRRK2hOYV4dHyNmDS/ka5T8+WvMU
 5If5gw0J0Oa9FqdCfn6+yJZJfDKGtUsCZIIgmzkU//UeDXz6sYkdLbf/pvnoY195ABPVJ0/13mS
 L
X-Google-Smtp-Source: AGHT+IG3JIs2tpCTM6Gw2T9UjzFujppPTF84uzcqsPnLsBd+77ve7uEKc/8OKqLvkTRtOytNjdO7IQ==
X-Received: by 2002:a05:6512:2311:b0:52c:df6d:e52e with SMTP id
 2adb3069b0e04-530bb36f9famr10337015e87.16.1722948750754; 
 Tue, 06 Aug 2024 05:52:30 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bcb19csm544275866b.42.2024.08.06.05.52.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 05/28] hw/intc/loongson_ipi: Move IPICore::mmio_mem to
 LoongsonIPIState
Date: Tue,  6 Aug 2024 14:51:33 +0200
Message-ID: <20240806125157.91185-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

It is easier to manage one array of MMIO MR rather
than one per vCPU.

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
Message-Id: <20240805180622.21001-6-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h |  2 +-
 hw/intc/loongson_ipi.c         | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 70e00dc1a7..5a52dfbf4d 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -19,7 +19,6 @@ OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
 
 typedef struct IPICore {
     LoongsonIPIState *ipi;
-    MemoryRegion *ipi_mmio_mem;
     uint32_t status;
     uint32_t en;
     uint32_t set;
@@ -39,6 +38,7 @@ struct LoongsonIPIClass {
 struct LoongsonIPIState {
     LoongsonIPICommonState parent_obj;
 
+    MemoryRegion *ipi_mmio_mem;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 7d15c28e94..03878b896f 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -320,12 +320,12 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->ipi_mmio_mem = g_new0(MemoryRegion, s->num_cpu);
     for (unsigned i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+        memory_region_init_io(&s->ipi_mmio_mem[i], OBJECT(dev),
                               &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+        sysbus_init_mmio(sbd, &s->ipi_mmio_mem[i]);
     }
 }
 
@@ -338,6 +338,10 @@ static void loongson_ipi_common_unrealize(DeviceState *dev)
 
 static void loongson_ipi_unrealize(DeviceState *dev)
 {
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
+
+    g_free(s->ipi_mmio_mem);
+
     loongson_ipi_common_unrealize(dev);
 }
 
-- 
2.45.2


