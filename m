Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0C0C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVr-0002zu-6S; Wed, 17 Jul 2024 17:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVk-0002g8-VQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVj-0002Mc-CC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-427b9dcbb09so987675e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252909; x=1721857709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwac+UE3k7fTa6T7a7tJQF5gUa47msUfS3JaoFVGPX0=;
 b=C0btP9djRnXWgezsSmArIYlGf8+uRB0WIh0YvxYvPpWdFuvt61mhhXDypYExuIbaQt
 LXRlXs1iVE6O+s4BwLvXRyTlyOFP8DsTnok6bOMU1T0JNQXv1avW/gh/akMByTgOKyDP
 /gpQtvZEXHtrLcw0spljfyFIdv6CJy2T3JqSpMphUn327r+IvAHvS1QHnz9e1UMHQpy4
 d5b7xtfmY3t/JIh9fhf0ipQV07D3+WmUzEXPi4vDkA0oK7C7r9zsToWq0A23PmEK4UYN
 QNeCbVqSyfvK4T5nSBN4tnrC/xaVl/Tmud3+QmZ0AT3yxvxX5R3yg+ra5I1V+9QHPb3u
 HvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252909; x=1721857709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwac+UE3k7fTa6T7a7tJQF5gUa47msUfS3JaoFVGPX0=;
 b=gtKstURGOlGPBXttAkRjjd7Heq71thw2Wpx3ZGGHfAauurK+duVI43KXqBd6EEc0ME
 WVh1DpSSCaA1trgFHakhnNx3FlvjNOY4eHqPBArXBdOF60/m0UMMtr5TVgCGleRhUVqj
 wYCdSKoDEdo6YI7VgNIgqeTtj9gKnGaZJdrfGNgjZTzzDTQZJvQAHrk1l2og053VZFhw
 tLUEOyU8L9jTirs6sTPD8bRrHoDxY/A+EHWwGApTenEOinvYYQC9r9gYPGKRzqokSXRa
 INDcpxeiDVR4r0Kg0Yfx7HhwIRElhSjwQ27xVXbf2BvUum8A71DtkAaOf3iES4jETJOL
 9zVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa3ikMpHOn4nV7PpagwWupTkhFyvac6m3O5g+/zCZrI/fxwIVxSd1TI+ccdWGW/oybQKkr6piNgYI3hE6Cd0OxpukuWPI=
X-Gm-Message-State: AOJu0YxApnYx094OmmiiSRTcxjF1Wuse14A94jH++9c+Gg+8zaVJLzZ1
 yAUY4Mg7UzYIoejH+k8XeXCdL9egiflFZaq/stv+cpIGDmIOXKzi9msMkHQgTe4=
X-Google-Smtp-Source: AGHT+IGyZS2g+Q0q+SMmd085uf34ZOjp9vaeuble85NbDxYWyBtPWnPQUsYQRJiji+Kmdzj/aS6hYw==
X-Received: by 2002:a05:600c:310d:b0:425:7974:2266 with SMTP id
 5b1f17b1804b1-427c2d1c445mr20347725e9.24.1721252909500; 
 Wed, 17 Jul 2024 14:48:29 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf539sm12612214f8f.47.2024.07.17.14.48.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 10/17] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::get_iocsr_as handler
Date: Wed, 17 Jul 2024 23:47:01 +0200
Message-ID: <20240717214708.78403-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Allow Loongson IPI implementations to have their own get_iocsr_as()
handler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/loongson_ipi_common.h |  2 ++
 hw/intc/loongson_ipi.c                | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 891b43644d..e49c156db3 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -39,6 +39,8 @@ struct LoongsonIPICommonState {
 
 struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
+
+    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
 };
 
 /* Mainy used by iocsr read and write */
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8acd563db9..4a7a1fa38d 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -75,24 +75,30 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
     return loongson_ipi_core_readl(s, addr, data, size, attrs);
 }
 
-static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
-{
 #ifdef TARGET_LOONGARCH64
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
 #endif
+
 #ifdef TARGET_MIPS
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
         return &MIPS_CPU(cpu)->env.iocsr.as;
     }
-#endif
+
     return NULL;
 }
+#endif
 
 static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
                                  uint64_t val, hwaddr addr, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     int i, mask = 0, data = 0;
-    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
+    AddressSpace *iocsr_as = licc->get_iocsr_as(cpu);
 
     if (!iocsr_as) {
         return MEMTX_DECODE_ERROR;
@@ -338,9 +344,11 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongson_ipi_realize,
                                     &lic->parent_realize);
+    licc->get_iocsr_as = get_iocsr_as;
 }
 
 static void loongson_ipi_finalize(Object *obj)
-- 
2.41.0


