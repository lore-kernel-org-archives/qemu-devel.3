Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA728C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGp7-0008M0-47; Wed, 31 Jul 2024 17:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGp5-0008LI-ON
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGp4-0002EX-8x
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428163f7635so39240965e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722461124; x=1723065924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UExLWm9ddjnMRPI0UADCJZeULFWbdE7wtbj111e1TQ4=;
 b=Guf4mfy+Pa4b4IAfKEe/iv+6c3fe8KtDPXzmyIC1wLKBfri+6rfzM+wRIrUNFbnYU6
 23S/wgVHBz/Pbs34WjFTTWaP6N0kAk7xk3zSEidzH+kMKlo8783MeGCq9XufBSs7E1Kc
 lg2qTtW9OF3ICCrACvYL09Rs3yJtRD5RXQWrPVl6LUElAyYF2qjF/fRVWkSRDvHOMJQj
 NljPjo7SqBLK2G6XQX7DCum6YcxXDEdyQohrIIIGuHEe2zam5pJtZXEPl8DEjZ+Y4Jh0
 mVCy37VPErc5KuYLnL2OHYsugEiBqxqc9i0xIBv9d0wCuu+xLLcxD1Q/bgMxGhmM7ewH
 pziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722461124; x=1723065924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UExLWm9ddjnMRPI0UADCJZeULFWbdE7wtbj111e1TQ4=;
 b=rQ0KZii78WgQSmDU4zfVn+j+J9EgrguGYFFzMWeFGZ9DosjVKdExl2hR1tkZPRR3pk
 cUPYH1bylX/Vdje1Hh6/AZPPFA4DNcyYknbxVYoqWClv03A19vxLfp4fvb/6SB7Ofxb9
 nr6g6HpOJQ+3cfu9coIA80/slZVjkGSMOO0AzzAS9Ub5HWViyZbUjx+AWwd5TVrWn02/
 NRXLuW6GOy019dpa4CQUSV02Zlep5PGkqLjg4gSMfUnzTQBV0vCZ1QHG9Z4JwZAT/A80
 3dGq2j3XFW4yiIrUMct1srwgvhdnLA+YFkfeIwvgq9ATzpFF+5ZmVAHfiSLVsbyDMivC
 jNtQ==
X-Gm-Message-State: AOJu0YzIiRUOVeROncAcC/ITwbm+5tKkoP8uXuIZr7KjsN++b+ZHjGHp
 /Lvq37nhmNz80MgRlMfurXKNG8x/49sfwxVSOjfkWjN9CO+FxW/sQ3h+B0et2xYaR1FRbiwT0vd
 z
X-Google-Smtp-Source: AGHT+IFBNMvEtEwBQ+Q5LVFvrrOzmRaVx39hGRDTtRbQh5GJXCpnQCMe5JrPciQ9Yghz9IfkI1HqAQ==
X-Received: by 2002:a5d:6701:0:b0:362:c7b3:764c with SMTP id
 ffacd0b85a97d-36baaf762b8mr227649f8f.48.1722461124140; 
 Wed, 31 Jul 2024 14:25:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282baccae2sm34983355e9.30.2024.07.31.14.25.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 Jul 2024 14:25:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-9.1? v2 3/4] hw/sd/sdhci: Read ADMA2_64 descriptor with a
 single dma_memory_read()
Date: Wed, 31 Jul 2024 23:25:00 +0200
Message-ID: <20240731212501.44385-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731212501.44385-1-philmd@linaro.org>
References: <20240731212501.44385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Instead of 3 consecutive dma_memory_read() calls, use
a packed structure to read the descriptor in a single
call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 0a95f49b93..2d8fa3151a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -740,16 +740,20 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         }
     case SDHC_CTRL_ADMA2_64:
         {
-            dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
+            struct {
+                uint8_t attr;
+                uint8_t pad;
+                uint16_t length;
+                uint64_t addr;
+            } QEMU_PACKED adma2;
+            QEMU_BUILD_BUG_ON(sizeof(adma2) != 12);
+
+            dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
                             MEMTXATTRS_UNSPECIFIED);
-            dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
-                            MEMTXATTRS_UNSPECIFIED);
-            dscr->length = le16_to_cpu(dscr->length);
-            dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
-                            MEMTXATTRS_UNSPECIFIED);
-            dscr->addr = le64_to_cpu(dscr->addr);
-            dscr->attr &= (uint8_t) ~0xC0;
-            dscr->incr = 12;
+            dscr->length = le16_to_cpu(adma2.length);
+            dscr->addr = le64_to_cpu(adma2.addr);
+            dscr->attr = adma2.attr & (uint8_t) ~0xc0;
+            dscr->incr = sizeof(adma2);
             trace_adma_description("ADMA2_64", dscr);
             break;
         }
-- 
2.45.2


