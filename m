Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638B1C52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb26w-0006gg-J6; Mon, 05 Aug 2024 14:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26p-0006PX-7K
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26n-0006On-51
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso75608645e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881218; x=1723486018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiHMMAZSBCaFrOKQJaxByo1l7oxpgp4DVAjVwFZv5Rw=;
 b=cCPQLLjJrobU4it2HjgVBugtIaWTYf6f+1/646eiEMFBFzh06sspxCZzRf4V/I2Lif
 xa08suK4wgPAESJ2Hg18BRxmnM8hJvfahebqC7x+DGqxPia5QaTto7j1TEqAUoj4JAG4
 YQGVZuSmE81INydvpo/R9BsTZZXwEiL1iyUsXqwD6mKeBovtH8Z4CeDmEtUosgrQKqZR
 0S56/CK4hswWbeh4rfOUeQLZcxJv3ovTd909umeGMCsNr+SFmV3ES1JNTLnHbjRtV+Ty
 5HyTQTMhrqKUpZFaPlPLsSEkbzfNAh4Zu93TOHFzw16zwUO658UjSQADqqjPx2mmshRP
 EhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881218; x=1723486018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiHMMAZSBCaFrOKQJaxByo1l7oxpgp4DVAjVwFZv5Rw=;
 b=RlMcaoUzU6c3TBR8BdcFwRTQTPtzRqn5KfOulXzeSbIKi7RAVD7eFnhooex/nXYfEb
 C9a4HnVxaV3XPLl9toxErvbJwyTU7hNmXsGmaxSYfLkOUcarQ55bsW7v2fQDbJlJV9W8
 5yiEB4Q4Idfuo++GHYpQoWqfHobs10SClIDCKxU95tMAO3GWcfoZ8a0TfuW2yxYh50VZ
 qtvuBIsakFWtu9MX2Fer+NHySb5fMGstRnlS7qb7uA14AK+iRxBThd0orfWhImJibxST
 JxmYHjsqLyYA0p6LyRrlStuD675i0FuwHpMNbwnzs8Ch3e08MnbQ/QiRcav7cmrfizxL
 ByVQ==
X-Gm-Message-State: AOJu0YzAP/QugUaLpxMOjPtGfTGQNS4uOa87FVKO0CpSHIG/ZZondfGa
 MC4DwGBAqf15JrmU5j9eBljwKSMKBSNdzwcFIqv5Zu51lz7tQCHMkFjyVFFq9jc0qlrgeR/fgr+
 C
X-Google-Smtp-Source: AGHT+IFK1cplCXYlbjwxYrX5iL+X8eeJNjaLBFBqM2fqVZw1BZNc3hblMWzd0+HqKEB6A5XK2UFMNg==
X-Received: by 2002:a05:600c:4f4f:b0:428:eb6:2e73 with SMTP id
 5b1f17b1804b1-428e6b7c989mr86361525e9.29.1722881218122; 
 Mon, 05 Aug 2024 11:06:58 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e9d887sm148883495e9.43.2024.08.05.11.06.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:06:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 05/15] hw/intc/loongson_ipi: Move IPICore::mmio_mem
 to LoongsonIPIState
Date: Mon,  5 Aug 2024 20:06:12 +0200
Message-ID: <20240805180622.21001-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
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
Message-Id: <20240718133312.10324-9-philmd@linaro.org>
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


