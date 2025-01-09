Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D620E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrWe-0001Ut-Aj; Thu, 09 Jan 2025 07:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrWd-0001UR-1w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:20:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrWb-0008Pv-FO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:20:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f796586so9153125e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736425231; x=1737030031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YD5uWlmiXv+X+N/DhIr8lUDqDkhwPiq6v0QtcDmQ27M=;
 b=Mdm2JlQmylA1grsgJ9cghgtF5vt0f8J9hhgbYNbxaGenIO2cjden4nVlVzjLXR/YTR
 7VYVSMI4TlPArd+bxWP3o966Z4KcXwMPdYDFjWRH3QUpErDEzxCOi1R9WrxpQttsoKi4
 S/+0Ql85J2L7Mb4pYYq3sxyIgfualjAZuvJagNaV0SDDtVdUOqoqhTmDhI0uCXhc5g+T
 0mzeJvmj+EJB8ywuNqa2UuS70A+kW8mgiwUTsTiLofs3k+M7fj8EnOe5T79PrxCh/yPy
 c3sE51SBDwES+3ZvxwZBK779sfOQNHRXOUqd4sxdDA9XNswWwimIBJl2GT/CeDsECM7s
 5T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425231; x=1737030031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YD5uWlmiXv+X+N/DhIr8lUDqDkhwPiq6v0QtcDmQ27M=;
 b=mao1mIRl7TtPRyqKeqBQvEVf2pRvAKSEkwBsqLXpINGbdqVJbL07ajZcRCFRS0sLE4
 UIXb91wXffcBJjjOmm/kvEYbXhvRIettcb3/COeZZnTFmzviy8sf44yrLHPrpL14ldCt
 9GVHVArheMa/FRvnt3zu8+ZBLqRkHoaDxKDBbvst/px9x3/7NgUilvw8qZ8lZQI7OO9l
 BwuV3AOH90xxZ7zoHz8UGcMedSdpq9b5m1rIVSW+NLdkNrPFNAcytmUq5opAwuX/WJdH
 RUa/SlOIw7VzMD5dYC9UdTKKXZhO8QrfG7M/36mcmKAcuq9BWL2GGl3kxdGuv1XPBKTq
 xO5A==
X-Gm-Message-State: AOJu0YyjJ0yv+Zp9btAlaByXHcegmciQGzdxQsQVmcDhQkSVmLn7varr
 n5J4myg+Pa9IVtqjp86LG6l7kkQ7LuaGV/61OteNf6uB6Kdq6WhZM/tDYcTFFrlLy4ikaI5fu4k
 kids=
X-Gm-Gg: ASbGncuDZuwiTakiTbxeQTqlmUyF5oO2jyAs9W5fYlocujusHuNbdybW471DyVvKUYK
 6h2kVp7rN4x6MTWSsUzH1axz0xseJgWVqB2lss0ijHMLVnaAuAuhDL3HBg4ZLTelvSlpAujK3FK
 5tQ3v2BOnMRSRaUdrhPBn4S70X9mJReQoP2ByKnzEmW8+hwxV6PhCY9D6THMEDSg+o8MN+cIixY
 MyLjEorxc6Wd4I515DvB1iBPSFhbfXDxVoa/zt8b2pBTSCaWhhcCChEs6hkLEu3LqpOzBqcwEwV
 r9mzwg15/iJVlUVegkORVt//UODgTl4=
X-Google-Smtp-Source: AGHT+IGJ01cE/+KKDhAmA8QEaUqC4qagPhyzq7ebmkESQfFpUIACp7iz8EYGFGWwUL2EKGJoIePGAg==
X-Received: by 2002:a05:600c:4fc6:b0:436:1baa:de1c with SMTP id
 5b1f17b1804b1-436e269793cmr63632635e9.13.1736425231255; 
 Thu, 09 Jan 2025 04:20:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0babsm53570935e9.14.2025.01.09.04.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 04:20:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/sd/sdhci: Factor sdhci_sdma_transfer() out
Date: Thu,  9 Jan 2025 13:20:29 +0100
Message-ID: <20250109122029.22780-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Factor sdhci_sdma_transfer() out of sdhci_data_transfer().
Re-use it in sdhci_write(), so we don't try to run multi
block transfer for a single block.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 299cd4bc1b6..332ea13fe55 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -694,6 +694,15 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
     sdhci_end_transfer(s);
 }
 
+static void sdhci_sdma_transfer(SDHCIState *s)
+{
+    if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
+        sdhci_sdma_transfer_single_block(s);
+    } else {
+        sdhci_sdma_transfer_multi_blocks(s);
+    }
+}
+
 typedef struct ADMADescr {
     hwaddr addr;
     uint16_t length;
@@ -925,12 +934,7 @@ static void sdhci_data_transfer(void *opaque)
     if (s->trnmod & SDHC_TRNS_DMA) {
         switch (SDHC_DMA_TYPE(s->hostctl1)) {
         case SDHC_CTRL_SDMA:
-            if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
-                sdhci_sdma_transfer_single_block(s);
-            } else {
-                sdhci_sdma_transfer_multi_blocks(s);
-            }
-
+            sdhci_sdma_transfer(s);
             break;
         case SDHC_CTRL_ADMA1_32:
             if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
@@ -1174,11 +1178,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             if (!(mask & 0xFF000000) && s->blkcnt &&
                 (s->blksize & BLOCK_SIZE_MASK) &&
                 SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
-                if (s->trnmod & SDHC_TRNS_MULTI) {
-                    sdhci_sdma_transfer_multi_blocks(s);
-                } else {
-                    sdhci_sdma_transfer_single_block(s);
-                }
+                sdhci_sdma_transfer(s);
             }
         }
         break;
-- 
2.47.1


