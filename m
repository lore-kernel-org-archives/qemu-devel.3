Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B017CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVt-0003H6-HK; Wed, 17 Jul 2024 17:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVq-00033F-Rx
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVp-0002NL-6p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3683329f787so92513f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252916; x=1721857716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilScFmA5v9fzs5muI3HEIkUzwDEqqO456JgzUU0riEg=;
 b=d/xqvniiwCH2zvYQUJOl94Xequt+NnR2Z7inA01zVFRFhNPxXJ0Mp7rpzKoMyzpkCF
 teXePfMa695ky+kwfDViZ2MV/0CQKKL6H3L9LXz1Ky7JS070xoxRnEOGjBzvf3OsEjdq
 bTud1aFu57Ex8drBm/1L7kag0Ww8gg6mfvs/N6LjFisrLDEvbBrV61JQrEdi/XEOZyX8
 rAnhq6nd348jCPvUjFpFCUt3PiFd5zh0RTXCkRKtNDQ/+VZ44Lfcs+dLsVVfAdW/GXlx
 Y3TS9wfsZoZC8zJstNeOUiP+L3HceB3/fxw8LaU/jKEB0mMh6215oHr0ldfNj6mHFVyZ
 5krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252916; x=1721857716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ilScFmA5v9fzs5muI3HEIkUzwDEqqO456JgzUU0riEg=;
 b=IARbDcWXTS9j6o5QfTkd2UgGQbzv2rN19XnOmBto4NpNSN6YyM9URj3GuuNVz9X0oA
 yssXQSWhcHnOuffvcmlXwfMmnXXWe/NXAWAkmM6j7kS8XsGD8Jp7N5CmCyTr/w33LUQ3
 SGo4BetwnBxKRZcmYu+eyb6Jh9LkvXV2iflx2D+d8p1Bx1D8ZXy6Wvi5LSJm0TWFQvoP
 ZRf83BUCxEnkkb88h2OEICdvXDggc3/E9s34SX5MCBmbdz3qKFNyCeR3BxWPmTXus3NO
 hqrmP/0w0+ieFj66EcjMW5YvBF265srptaZJaBe9x0fgUd8pqCK0omhP1aPQEg1vqBjY
 bzUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHj89wI7qjurHezsFobShINGdv2AQyOkxq6qwkopT2PICDkrKAND74uZ79/uloMUkh9R2vBCT3HH57rHWU81VMK330/mk=
X-Gm-Message-State: AOJu0YwouMYrHZY5tKDFEwl2k55OxZXqlMvtyp5TbcowCJ01646+bzcJ
 rJZ3SuuMwl+j33BNbwK8CNYWO6crqDwCKB5Oru+3+fXwSy9Ee6PM94YCQxoLJxV42WWRsuL32A1
 tTwc=
X-Google-Smtp-Source: AGHT+IFlG61vTYx+vAy2HI5tjelCGcB0uiXk35Rz3j8K9Tk013pknoC87WPidEYBacmbZEC04o6HKQ==
X-Received: by 2002:a5d:4f04:0:b0:367:8ff5:5858 with SMTP id
 ffacd0b85a97d-36831755822mr1750649f8f.56.1721252915765; 
 Wed, 17 Jul 2024 14:48:35 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c77d810dsm11683355e9.26.2024.07.17.14.48.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 11/17] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::cpu_by_arch_id handler
Date: Wed, 17 Jul 2024 23:47:02 +0200
Message-ID: <20240717214708.78403-12-philmd@linaro.org>
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

Allow Loongson IPI implementations to have their own cpu_by_arch_id()
handler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 4a7a1fa38d..603a88356d 100644
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


