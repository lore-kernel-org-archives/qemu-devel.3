Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC54C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgP-00078b-VD; Thu, 18 Jul 2024 04:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMg5-0005bF-Fs
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:58 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMg3-0004lC-Ov
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:53 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eeb2d60efbso8248051fa.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291989; x=1721896789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8wMyk/xzuN68uq36ZSlC+LiLHV8Iu/AZcg4twoLmKk=;
 b=zw6mBx5gL+wfMZiD7hlOevQIvMj1GcoPqi1D0oGS6V3I75GBSvslvdzPfCrRMESPdy
 MhxVTzhHi/d8Mlvlf+ZpYjMwYhvefr4QZxHuh+PWHVFDxI9tFKVCMssn+jO/NL8lp06i
 TsYEr2ldUgZRfwg9RL5pGvRgY2GMt1PzLh7DD7c0++JVT7C3OY5qwUBd2+R0S+RT5R+O
 2ssoAqILwgM2wPoDf95xWu8slCl49lQ5RS2ZZyjgGb39pQlYVXCE8CaWLxhsReYam5Vp
 JaEGGMosHKN8uI/uAc4+AP83L3Hsc9ACMpQk2MgpmYWVfGtrgGw184utV8i5rW+d+nCo
 tn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291989; x=1721896789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8wMyk/xzuN68uq36ZSlC+LiLHV8Iu/AZcg4twoLmKk=;
 b=gbPs8tAmdHsnBnpykVH2+ewy+ycFXWDSyuPdfFIZQi5TKbNKZnxK45RiunHkuUIGhW
 ALelz/9ctxhMH99ZUY1qyNNpf8luSyOaVtCPD0lJ4SiubVUhhsJu2d/t2uFQrIst6qco
 FsK+BIGqEwtGBuoeJ33XNbuSRp82Bn8gTOxtTcDts8PQrLmNvGToMI8anVJW3G620IzG
 2/kYcPDrecGqOPeRUkHPqBPovQtf92cgLmTaJpcA//UtWy2BBU+uz8sHZXGEE5kN0+i8
 E5LrDYJFk0nxDqYixHaYdXsetCYG6LeZk/oQKyOuMSbf1wUxYRp1wnzlGvGRmgMMpazl
 5iFQ==
X-Gm-Message-State: AOJu0YzTOc1ki4CphneevJD/o3aazoefhI0unHfNxEurCf0Loz1CN807
 2s61crBOU2YF32qNZJ34UYt2Nj+gdUOvHZtUTFWsEnzFDVvqaXbiPQteBaONA0loB8Rony9Thd3
 6IX8=
X-Google-Smtp-Source: AGHT+IEw7tUL4gTwI3gGFEbniP8wbjFoBIAhJyjkiZiMojPkKy5ktrayv2gp3wcilok7DjwO/f6PiQ==
X-Received: by 2002:a2e:a541:0:b0:2ee:7dfe:d99c with SMTP id
 38308e7fff4ca-2ef05d2ed3fmr13844591fa.31.1721291989448; 
 Thu, 18 Jul 2024 01:39:49 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e47csm2209615e9.29.2024.07.18.01.39.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 08/18] hw/intc/loongson_ipi: Move IPICore::mmio_mem to
 LoongsonIPIState
Date: Thu, 18 Jul 2024 10:38:32 +0200
Message-ID: <20240718083842.81199-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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
---
 include/hw/intc/loongson_ipi.h | 2 +-
 hw/intc/loongson_ipi.c         | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index d53bd5dcfe..00a65a82fb 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -19,7 +19,6 @@ OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
 
 typedef struct IPICore {
     LoongsonIPIState *ipi;
-    MemoryRegion *ipi_mmio_mem;
     uint32_t status;
     uint32_t en;
     uint32_t set;
@@ -38,6 +37,7 @@ struct LoongsonIPIClass {
 struct LoongsonIPIState {
     LoongsonIPICommonState parent_obj;
 
+    MemoryRegion *ipi_mmio_mem;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 20f3f6bd3f..2319aea18f 100644
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
 
@@ -379,6 +379,9 @@ static void loongson_ipi_common_finalize(Object *obj)
 
 static void loongson_ipi_finalize(Object *obj)
 {
+    LoongsonIPIState *s = LOONGSON_IPI(obj);
+
+    g_free(s->ipi_mmio_mem);
     loongson_ipi_common_finalize(obj);
 }
 
-- 
2.41.0


