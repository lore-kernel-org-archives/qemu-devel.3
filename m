Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F0AC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVT-0001D6-5y; Wed, 17 Jul 2024 17:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVR-00012c-Nh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVQ-0002LJ-4m
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so63896f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252891; x=1721857691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chy4jtNU6iWnrH6rF7I9Uod60had5r2Sf4ZzHJviZ5Q=;
 b=GfsHJzuvvW9pD4tB3nLht13WJqsqK5XNLFIkOatMvCFnrpHau93OETWUvzmgXk5msV
 iVw/n5met94txwPT1CyjWMWGB1utJRzWPsGIuobLh58gmn12EG7UoLMpKnfQB3hP/kXZ
 wCc8Qk1uXjruCzmNjP9mrACguWkdote//WWQckoTgpfYn3qkcK55vQnSO63HU4A0NyjK
 8K4tP25ix/IrG0XaK7PLDEIyqSJGbMMCtuoZx7nacusJNWfzGIhKpRn+wtR+AR0al8PO
 4eL572hhCc6z0LWfF+gReYtM3NrCxWmgcOUZON6dbI/lBzfkLYG+9mdkiNaRiRq7CS8B
 TsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252891; x=1721857691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chy4jtNU6iWnrH6rF7I9Uod60had5r2Sf4ZzHJviZ5Q=;
 b=mifYRoHZ+M0t+gFKTzQCkhmhxglPq+WsMzWpB+U0GGRK9p2uBfrsEEG5yY3CTi4SBH
 1ukTh8Hkj10x5EW/oehjOzGV6Cxh+OwZIpVkmKXjDzqF12BfDN5c7oY66oR4p6C3Hyoa
 E4TEIcHK5YunTjBegkySIAYOxZXEBlulEihHoiKk7nGoZdthZS12UiQfzFyO9rdHMJBN
 KWTxcpWjbF3jDpa4HtZfMiMVawBuTLCjCk1250FojjVx04VUiEdXCxwQfuvrFVFiInlJ
 DKg30PDRd71tA/DKB5cFHqGCyFHghHpTy13ZdNDSfk/mbX3qhr3eOtIIblq0aQdCC1C0
 S/bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKWwRp/IypS0B5AVOqHpKup6JPTbdAfWxoJa2RwJT1RlmmNITYAMNdKFkiXg6y7YZUFDtKjG4KV5H6OYqqo2AHPyOyMzk=
X-Gm-Message-State: AOJu0YzUqgPyyKPk3Fs99xIW80YovU1A7xBejmOFCW3D3WDy693XfjmG
 rFt2RRKsxjCqXS8iFjiObzMbV01s2U1b8LFaGAOraxN9Yknytq2C0aLTWa1aAD4=
X-Google-Smtp-Source: AGHT+IGBp3OkNFokz30qDalLI8hcO1U6cEf/w+yy7aiobSg0QvUCY8uhuARE7CpRLZCEZOzcaqssTQ==
X-Received: by 2002:a5d:5906:0:b0:367:33f0:91c6 with SMTP id
 ffacd0b85a97d-368317b76eemr1717886f8f.62.1721252890811; 
 Wed, 17 Jul 2024 14:48:10 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c7797d74sm12326795e9.4.2024.07.17.14.48.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 07/17] hw/intc/loongson_ipi: Move IPICore::mmio_mem to
 LoongsonIPIState
Date: Wed, 17 Jul 2024 23:46:58 +0200
Message-ID: <20240717214708.78403-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
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

It is easier to manage one array of MMIO MR rather
than one per vCPU.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index e8772f1b96..a9fca28430 100644
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


