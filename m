Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3AAC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgc-0000Nw-LA; Thu, 18 Jul 2024 04:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgZ-0008F8-JH
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:23 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgX-00057y-Ap
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e976208f8so57738e87.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292018; x=1721896818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jW541QXlMDLOV+DwTuPovPBUePRuwd+f2A4/2HtxxX0=;
 b=CuDoV8aJRWeI1UF3yYsKs6M+wEDxw5h5n0XNGUvkXaR41aRaSbbeAGP8Uv3qui7vII
 cQQbPnieKDwpe6CJWWYifodor4LnuUY49Hf4yVlPnY3TXeCAkMsuDJG2SeJLllPmq3qn
 elsM3Un7eUH/7r5c32A8Bk5L7nnbSPUBSh6Wz8GiPdEftQFEygCKP63k9oGg/y8tMaBc
 bgkNC+MmmEcHiMW9zfF39lz1+5rqj4H5BXheqtDwBtrg2rp6Cpj+lnKes3nAUn/ALkEQ
 QsLyDr0toQxu03+js4wS/HTz/jwps4gMhJfefbhPuzWQtCcSKdLFF1V+FIQ9FMgLwcMu
 27Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292018; x=1721896818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jW541QXlMDLOV+DwTuPovPBUePRuwd+f2A4/2HtxxX0=;
 b=r0gBgTxhnT7utjFi4YM4yYJrJCeLPE5ZD/sbjHFWCeG1yCfKHHMm0GFFzS7551gBsp
 MfWGN/S35cZp4RdA1AYgzHGAXzN30F/irouF7EkGSddcwxEasptEaQZubMt3R73F4v1v
 Ye60wFsJNGgUFGzT6WPx3+WgbUvpKxnkhiNDexzxh5rd4MqIOJHu2IyOy1uQOwUM6QwT
 cZil8VJcTI/FtkvwsTeNEGI9+Qd3hiQPprSMNmXiIg477rtkiTkWGhzNzwE3C24XU+R3
 CDc/vjs25a3W3IHyCPow3vCeuRo42csPcewVgaDHHf/bUqhwt88KLsCYRiUxAdTBoB4K
 PI2w==
X-Gm-Message-State: AOJu0YwgfDSOfW3V03KzQ+A1NE3fDXzk3bnZuUjGYVKRyHuLtT6iFKfN
 YeVWwqsHy3ByNp0xI5jfPeQfUlqEqQ/txbCn4IQXBVxmzhaf8XU8MTeWzlwRmv2dyMUt2a8f09r
 GsFU=
X-Google-Smtp-Source: AGHT+IHOJJ5ngR6u++9y0EhsajGjKqDwCzCMGXl+bq+JlJsrpem40GDHjwN0/2LWPe79i0FJY4ATyw==
X-Received: by 2002:a05:6512:10c5:b0:52c:e1cd:39b7 with SMTP id
 2adb3069b0e04-52ee539bd32mr3577237e87.5.1721292018336; 
 Thu, 18 Jul 2024 01:40:18 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6efb6sm2597165e9.24.2024.07.18.01.40.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 12/18] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::cpu_by_arch_id handler
Date: Thu, 18 Jul 2024 10:38:36 +0200
Message-ID: <20240718083842.81199-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
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

Allow Loongson IPI implementations to have their own cpu_by_arch_id()
handler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongson_ipi_common.h |  1 +
 hw/intc/loongson_ipi.c                | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index e49c156db3..5447e9f650 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -41,6 +41,7 @@ struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
 
     AddressSpace *(*get_iocsr_as)(CPUState *cpu);
+    CPUState *(*cpu_by_arch_id)(int64_t id);
 };
 
 /* Mainy used by iocsr read and write */
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 2c8829c3cc..39bcf0031d 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -128,12 +128,13 @@ static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
 static MemTxResult mail_send(LoongsonIPICommonState *ipi,
                              uint64_t val, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     uint32_t cpuid;
     hwaddr addr;
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = cpu_by_arch_id(cpuid);
+    cs = licc->cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -147,12 +148,13 @@ static MemTxResult mail_send(LoongsonIPICommonState *ipi,
 static MemTxResult any_send(LoongsonIPICommonState *ipi,
                             uint64_t val, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     uint32_t cpuid;
     hwaddr addr;
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = cpu_by_arch_id(cpuid);
+    cs = licc->cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -169,6 +171,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
 {
     IPICore *s = opaque;
     LoongsonIPICommonState *ipi = s->ipi;
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     int index = 0;
     uint32_t cpuid;
     uint8_t vector;
@@ -203,7 +206,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
         cpuid = extract32(val, 16, 10);
         /* IPI status vector */
         vector = extract8(val, 0, 5);
-        cs = cpu_by_arch_id(cpuid);
+        cs = licc->cpu_by_arch_id(cpuid);
         if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
             return MEMTX_DECODE_ERROR;
         }
@@ -349,6 +352,7 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_realize(dc, loongson_ipi_realize,
                                     &lic->parent_realize);
     licc->get_iocsr_as = get_iocsr_as;
+    licc->cpu_by_arch_id = cpu_by_arch_id;
 }
 
 static void loongson_ipi_finalize(Object *obj)
-- 
2.41.0


