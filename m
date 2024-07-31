Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF82C52D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGp1-000815-Ej; Wed, 31 Jul 2024 17:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGp0-0007z3-Ba
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGox-0002Bf-Kh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so28942745e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722461117; x=1723065917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dqJthe0fo5ExOTjiiBy7T5s1CTErpsVhn7olcnYzJ4=;
 b=GgPNbAysC4VXSAdVLlg3QIg5wtHE5SuAm0BBpMFIxFyPB8Nr+cN4/jBkvqT1NqgpGK
 8EozHKhkoIRcYRm1Ghyh/5MXnXjTf5+yzdtu7QYEUgznhwi72WPYAIeZKv+ASIK2imqv
 kmuGPvlOsxq0442sLdDCNlSR1WcwkXMV48XBKnfk9JbNJaZaaH4ZyrAZZ+C0ARBTHoeh
 dIG4oMn7vYylgcz9kfDAl9E10b9hQAC0bo8YI07+2VNRFrwcgupAA/Bz3Oz3gY38ucDG
 dXpdmh7Z30yhzEfywRRxlA/ej38cwxroFfJTVCElvZV+v0r9zf2cKNy9vg/oLvQ9v7vO
 vJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722461117; x=1723065917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dqJthe0fo5ExOTjiiBy7T5s1CTErpsVhn7olcnYzJ4=;
 b=rCb6HvPTeeCQMTHmCh6fc3AGoK6Pxy8INmFlbNO7QihaDI3ivN/bqupvGYA1eAAcJ/
 WbG/Z1IHhBGDuO5lfKVAP48VQhexS5jXVuD001qHcvNvnaOqiUhpDInXCl4XnYzuiJIs
 BKM1k5h6sVB25MdoocoOIY/o7K4o7EWh+kFR1VUYTm4H8vc+seMGr2wjXR/HjOBzMdDm
 LBneFnydWWGsRzVPGipFxGwJyq2CQ1x7fKEe7hyejzsYrtNE8gvLNskwUpFrkV99wUtc
 HvzsW3l2OMux2QelLTfppz1viva+kww34ecUx8KSO/wcVNNWzsz4Vp3t23Rg9oMceN6c
 oGiQ==
X-Gm-Message-State: AOJu0Yyl1q7P0v9qW2Qiqb3yxS/MqNpxYcnLxLSPYKpuW/p1yxIAIV8i
 yV3Qx2V5NcXltDe8vHq0obYMqErK1mL4y7rQkOCLHk6O37IPKvhAOjRo/yD3/jj4htTa42cAUIF
 g
X-Google-Smtp-Source: AGHT+IGa5BxCQhH8ge/A5VN3Uj1JVF3dXZIkEC9f8w/HUC5vTYKEU9rawL4Q3K9Seim9a1oILo0PWA==
X-Received: by 2002:a05:600c:4fd3:b0:426:5dd0:a1e4 with SMTP id
 5b1f17b1804b1-428a99dfc67mr4484055e9.8.1722461117549; 
 Wed, 31 Jul 2024 14:25:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0889sm17960188f8f.22.2024.07.31.14.25.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 Jul 2024 14:25:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-9.1? v2 2/4] hw/sd/sdhci: Reduce variables scope in
 get_adma_description()
Date: Wed, 31 Jul 2024 23:24:59 +0200
Message-ID: <20240731212501.44385-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731212501.44385-1-philmd@linaro.org>
References: <20240731212501.44385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The 'adma1' variable is only used in the SDHC_CTRL_ADMA1_32
case, and 'adma2' in SDHC_CTRL_ADMA2_32. Add braces in the
switch case to use local declarations.
Do the same in the SDHC_CTRL_ADMA2_64 case because we'll add
a local variable there in the next commit.

Replace 0xFFFFF000 -> ~0xfff to align with our codebase style.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 87 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 773f2b284b..0a95f49b93 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -700,50 +700,59 @@ static void trace_adma_description(const char *type, const ADMADescr *dscr)
 
 static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 {
-    uint32_t adma1 = 0;
-    uint64_t adma2 = 0;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
-                        MEMTXATTRS_UNSPECIFIED);
-        adma2 = le64_to_cpu(adma2);
-        /* The spec does not specify endianness of descriptor table.
-         * We currently assume that it is LE.
-         */
-        dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
-        dscr->length = (uint16_t)extract64(adma2, 16, 16);
-        dscr->attr = (uint8_t)extract64(adma2, 0, 7);
-        dscr->incr = 8;
-        trace_adma_description("ADMA2_32", dscr);
-        break;
-    case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
-                        MEMTXATTRS_UNSPECIFIED);
-        adma1 = le32_to_cpu(adma1);
-        dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
-        dscr->attr = (uint8_t)extract32(adma1, 0, 7);
-        dscr->incr = 4;
-        if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
-            dscr->length = (uint16_t)extract32(adma1, 12, 16);
-        } else {
-            dscr->length = 4 * KiB;
+        {
+            uint64_t adma2 = 0;
+
+            dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
+                            MEMTXATTRS_UNSPECIFIED);
+            adma2 = le64_to_cpu(adma2);
+            /*
+             * The spec does not specify endianness of descriptor table.
+             * We currently assume that it is LE.
+             */
+            dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
+            dscr->length = (uint16_t)extract64(adma2, 16, 16);
+            dscr->attr = (uint8_t)extract64(adma2, 0, 7);
+            dscr->incr = 8;
+            trace_adma_description("ADMA2_32", dscr);
+            break;
+        }
+    case SDHC_CTRL_ADMA1_32:
+        {
+            uint32_t adma1 = 0;
+
+            dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
+                            MEMTXATTRS_UNSPECIFIED);
+            adma1 = le32_to_cpu(adma1);
+            dscr->addr = (hwaddr)(adma1 & ~0xfff);
+            dscr->attr = (uint8_t)extract32(adma1, 0, 7);
+            dscr->incr = 4;
+            if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
+                dscr->length = (uint16_t)extract32(adma1, 12, 16);
+            } else {
+                dscr->length = 4 * KiB;
+            }
+            trace_adma_description("ADMA1_32", dscr);
+            break;
         }
-        trace_adma_description("ADMA1_32", dscr);
-        break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
-                        MEMTXATTRS_UNSPECIFIED);
-        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
-                        MEMTXATTRS_UNSPECIFIED);
-        dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
-                        MEMTXATTRS_UNSPECIFIED);
-        dscr->addr = le64_to_cpu(dscr->addr);
-        dscr->attr &= (uint8_t) ~0xC0;
-        dscr->incr = 12;
-        trace_adma_description("ADMA2_64", dscr);
-        break;
+        {
+            dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
+                            MEMTXATTRS_UNSPECIFIED);
+            dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
+                            MEMTXATTRS_UNSPECIFIED);
+            dscr->length = le16_to_cpu(dscr->length);
+            dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
+                            MEMTXATTRS_UNSPECIFIED);
+            dscr->addr = le64_to_cpu(dscr->addr);
+            dscr->attr &= (uint8_t) ~0xC0;
+            dscr->incr = 12;
+            trace_adma_description("ADMA2_64", dscr);
+            break;
+        }
     }
 }
 
-- 
2.45.2


