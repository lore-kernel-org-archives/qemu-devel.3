Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3302C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURHC-0001Bw-4v; Thu, 18 Jul 2024 09:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHA-00010k-5g
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURH8-00005i-E4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:27 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367b8a60b60so526070f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309665; x=1721914465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+OxJiG+z3ssF/3QJZPn0rn/Ivu5hISnKA+KGQ086vg=;
 b=hwDyVAfTKPofCaxYMKdnFC5+csFksV2A1cLZgt+QaOwseFktExvtWW7hIYKJFDqwD0
 fzlOm7NKNU8J1Rj9bWemW7t4+rrWkRfjEBfsjdBQAmp7IG3YY4xO9AFCUPf+MyNMeHmi
 nHqCJz+yqe/HLS+YwvB7nRXSUIuRPxssEvju97jeEYPQLFQsF3iXqM2tKaCRC5sgZQyt
 JKUTnfdkq9cfF6xJF8RmWNLeTvAnVPbifESnON4Vo+5l+MD//Eyc3b4euqNieDWEUAP2
 +XPFbKZOoOffKttAjrNfhRTebJLfnnBI4S06NRBmjKFo3sVj0+WFwSA9UrqmjM1SCDJU
 ka4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309665; x=1721914465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+OxJiG+z3ssF/3QJZPn0rn/Ivu5hISnKA+KGQ086vg=;
 b=IHwwJIlCi3TJNLmep1M2kDffjggjVl1BMSpT5h0NmtzZgM7fpgvBM9l3praZrwqdF1
 FpRsV3VSrQ0ujBb/2MSEFvhgzh47s+ZX49yqRMjB04stA+RukW9Ik6JG9Jp8E4oMnUee
 P9bZW9DbIr4b8qTCPJph0sCJWJe8ugAYYdPefN79Zmw9vuXXAzgwEAICGNbwz/SI8+tA
 /5l006hTEQPLTwolE4gFTcBg7oP6Jjm+tMCP0iVi8dtobdfOlTsCUx7GQOzDnM0XlTer
 c14MikYdWgycFNb75WJ1Ln5pvpp5CAM28ltRK/mHw5cNtov8VT/rj2S2NVv2T32zlRyc
 uO2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgKqKbfeM5V2XF5Wus84TZ8LzLGNLmTKReINCF1kK8LE3utSJx+2f3RR7w2gP8EnOAGXosgxmql8KVWvHJn9mANboC5mM=
X-Gm-Message-State: AOJu0Yz1KYBRw4Fc5rv7My4+CradJPoHFuaZZBDZIRMRy2z+u/eLQVFg
 khCkkSrG4NkzHBVrLVINbtWEGI/MCjvuny4QjFyipQ7mlrN7Td/x3UWnCwNuP6E=
X-Google-Smtp-Source: AGHT+IH/1j9YofXBjUd3Wg03tMNt97po48y7MUwHPTOPIYeX2Wc4PRa7vYqb9cS5A72xZ9U2T8ZlUA==
X-Received: by 2002:a5d:6488:0:b0:367:f245:d847 with SMTP id
 ffacd0b85a97d-368315edb49mr4725844f8f.2.1721309664766; 
 Thu, 18 Jul 2024 06:34:24 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db047c4sm14339224f8f.108.2024.07.18.06.34.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 12/19] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::cpu_by_arch_id handler
Date: Thu, 18 Jul 2024 15:33:04 +0200
Message-ID: <20240718133312.10324-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Allow Loongson IPI implementations to have their own
cpu_by_arch_id() handler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
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


