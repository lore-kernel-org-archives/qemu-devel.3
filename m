Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2DEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGpF-0000D8-PC; Wed, 31 Jul 2024 17:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGpD-00008b-GP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGpB-0002Ha-3X
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso3542580f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722461131; x=1723065931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSCKNCS385Z7tdy/qq25A1b3soTdqIksx3r0Ajnm5Pk=;
 b=sz8jzUALidOE1rs3PV9L2UlPNZKnPs8R3QqJU+M5g6um9MLDJUo7DYq9pbzd9ztBJY
 IGB1Q+neZOO6YDdDHN27cO77jnmpiB2xWlyyS9jkRD+MrPP1OuOVyk28elTkIcvqIop6
 7W/VDtryzqxM3Bmber7JlqpNmaO7E+ajRKWwdT8T9B6F5uImeJN918/a3Fea/ZyOlE1M
 oESrz9NMgNHENh9pGh/PFx0RHCRVHGYUFtgcFYqixl339+5bmKY97J01k7iC00vHhfJW
 6ETNWtym/3KHlYBxu9vXK7EBI8yVUPYubNiu+IABCQ7iKtTVnvSYxPA3retzqA6kLAkX
 vylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722461131; x=1723065931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSCKNCS385Z7tdy/qq25A1b3soTdqIksx3r0Ajnm5Pk=;
 b=SdSYwlfVyeEh8dIOMRkYLDVApvcJqeytz58Qj5eAWKwvcY1v3A60MT0TlMqvwvtop/
 E6EJ5lu1HTFwJ2d7uiOh2jgqCHJz78NNZ2KPUs4LCA+EuuM1hELm+HVYSir56tdpTXaM
 L6cCGaeTAbVBKbd6bWSKV+LVU+7l4c08GYNmx4F/mJbsDQ3TxXjTH4zmlHYRq0bwsw2K
 6+qoFSwkRWNl2VLhb8XZ2RCIiVTxHkIwGcbAUnyk3ucSmdFZsQ0ftiOFydlzFUfFgEZ5
 /bxmIq7j8lUy87hADbJdAULXCDba8OMgBil2taWd2vDy5xmeVyVraR2iP3fKTU7BDrrL
 iF1g==
X-Gm-Message-State: AOJu0Yw4vd0Acmf0kJkwfEdD7iGun3lrQsWXla4OwfACDQfbnooMDFnM
 mKNbV33lx0Ps8UaXByNmpOILUnZnPb+TfsgtAdzKPVaZpN48lSPcC4KoELo49LTRE13bougT0mM
 d
X-Google-Smtp-Source: AGHT+IEeu+k9huFO1cfrt9EXZTMiEMNZH103Pt7NmOXYT4BOnV71kbFvIg1M0+7qYRrFDhRHahCntg==
X-Received: by 2002:adf:f6c4:0:b0:367:8e53:7fd7 with SMTP id
 ffacd0b85a97d-36baace2a4cmr402984f8f.28.1722461130582; 
 Wed, 31 Jul 2024 14:25:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d95c7sm17825028f8f.37.2024.07.31.14.25.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 Jul 2024 14:25:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH-for-9.1? v2 4/4] hw/sd/sdhci: Check ADMA descriptors can be
 accessed
Date: Wed, 31 Jul 2024 23:25:01 +0200
Message-ID: <20240731212501.44385-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731212501.44385-1-philmd@linaro.org>
References: <20240731212501.44385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since malicious guest can write invalid addresses to
the ADMASYSADDR register, we need to check whether the
descriptor could be correctly filled or not.

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2d8fa3151a..6794ee2267 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -701,13 +701,18 @@ static void trace_adma_description(const char *type, const ADMADescr *dscr)
 static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 {
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
+    MemTxResult res;
+
     switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
         {
             uint64_t adma2 = 0;
 
-            dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
-                            MEMTXATTRS_UNSPECIFIED);
+            res = dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
+                                  MEMTXATTRS_UNSPECIFIED);
+            if (res != MEMTX_OK) {
+                break;
+            }
             adma2 = le64_to_cpu(adma2);
             /*
              * The spec does not specify endianness of descriptor table.
@@ -724,8 +729,11 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         {
             uint32_t adma1 = 0;
 
-            dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
-                            MEMTXATTRS_UNSPECIFIED);
+            res = dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
+                                  MEMTXATTRS_UNSPECIFIED);
+            if (res != MEMTX_OK) {
+                break;
+            }
             adma1 = le32_to_cpu(adma1);
             dscr->addr = (hwaddr)(adma1 & ~0xfff);
             dscr->attr = (uint8_t)extract32(adma1, 0, 7);
@@ -748,8 +756,11 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
             } QEMU_PACKED adma2;
             QEMU_BUILD_BUG_ON(sizeof(adma2) != 12);
 
-            dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
-                            MEMTXATTRS_UNSPECIFIED);
+            res = dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
+                                  MEMTXATTRS_UNSPECIFIED);
+            if (res != MEMTX_OK) {
+                break;
+            }
             dscr->length = le16_to_cpu(adma2.length);
             dscr->addr = le64_to_cpu(adma2.addr);
             dscr->attr = adma2.attr & (uint8_t) ~0xc0;
-- 
2.45.2


