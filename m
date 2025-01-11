Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F4E7719D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMV-00073P-71; Sat, 11 Jan 2025 13:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMS-00071f-Vq; Sat, 11 Jan 2025 13:37:29 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMO-0003ts-46; Sat, 11 Jan 2025 13:37:28 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so4483677a12.3; 
 Sat, 11 Jan 2025 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620641; x=1737225441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9wFgo5Z7UpDwTBLjtHHDdpJs0leNa3i7KXv69IcxWY=;
 b=kZBMhFhiSbMi96giaVv4xGelTwoTaVS21B3iYVCXS15GgB5IeBP78hErx3fCI/5cHB
 5CBJQt3FbJjcWsAIDP2l2COh3j2mXzyc2PUsC6K6wXE9JUtk7kcTt+OBf+MVA9ed3cQV
 1tvGJjSw+U3eT4qWlrPkSaB4EKF3uiRk9/sfPgskRMQS+bPfCdlJPLTMowOC4FGiA3fa
 7KtnwSfRRSN/70bLwWzX5XVDrvYa0+FuYRR4odj/ZbfTC+B2IR9pjvk5daen03uZWpjT
 mw2E2qutIbwZj1AdzRsseuWvnPoXPISbuwkeZnjmJMZW8cK2HG9f9VPkmZf+m3YG9trF
 KIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620641; x=1737225441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9wFgo5Z7UpDwTBLjtHHDdpJs0leNa3i7KXv69IcxWY=;
 b=JhUVIHeiiAHisvkRrpnsLDIONoVu1hA3Kjqh4RyCVvajAhP/G16RpWolt/cbaZM+/x
 RQZzJD7LtqVtTx7boAfBTM8TuX+66/hOgRUVL3cHB1cG+y2Ss1WNp6nUIfOfqcimkAHa
 xfh8Hkv1MvLnV5zbPMOSPqAAu3qRPhoBnvHKpgRH3mKeevmn6qLnMU2SZ7dsaMJa7JT5
 psaI2SwgGMywpWqJvkr7oXXnhmiQIIVkjGSrNar2Zry6zkbt/ye9t+vAoTm/HdyrgJNh
 iOBULlUCA93hxo0y+nMrsIysoWJvtoZwCnla+sUc7qi0on/vM8zJ92Eq7Y4se9Zw07KV
 r1nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKX7NV8eCobhfMZmx18rEFqACMJG4f16iFnLbaZzBcT4DAogF6yFRUB8/ALoH8Gp8w+Tf+cwKMg==@nongnu.org,
 AJvYcCUtK7AOKnRikDeaVvZsm/8TITCNBDF37nAeT5h+nEKcvAiMYy5esYbmQzH6Lnez39bsle5SwueaW+48gQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx3OCPu6wJvSp3uMSHbkPOX5wbp2jXAs8S0+egi2Sj3KnJXmBjo
 Ff8vUO17JMyFQgSTowy5neJV7R8QJ/UdiMPXih81IqfBXjN2rU9La+Pqiw==
X-Gm-Gg: ASbGncv47krbHiazpRyROHTgPc4aO9CM7aU+8MyvfjbhuYga9au41K96drTyeRgt2DZ
 PAGrgfFHVBtxYFD3+FaVn4eZy2RXAZMPbvqnCs8k+CQ5NXBkJqX5PxSKZ5b0RoTqbeNtu4sH8Ey
 48mCl5PvIVQ+3a8aKMPdLilqT+oRcktgmKaf7CgtpiBWMgEHzjzHtpUx1ZclCnRvmp5JkarOcT2
 R5uZO9On5+cy96D1/UeQ+9Uao4w27VdT3wRXnRLykDVU/FwiLXKv4o/X2VGWzXHSa/U5nKEWcAg
 sRsK/X3cOazkRy+XjUzBNCSoCACGuk/UOoYJ2tVF+UE=
X-Google-Smtp-Source: AGHT+IFGzYj4uYhYKZZWEcNFd+glHbGCDxmWFpsiZrEGmLfJfdMZcF0jihQJuOsjM6OONL2cM5G9+g==
X-Received: by 2002:a17:907:787:b0:aae:849f:3255 with SMTP id
 a640c23a62f3a-ab2ab709e27mr1399276166b.34.1736620640445; 
 Sat, 11 Jan 2025 10:37:20 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:20 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 01/13] hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
Date: Sat, 11 Jan 2025 19:36:59 +0100
Message-ID: <20250111183711.2338-2-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In U-Boot, the fsl_esdhc[_imx] driver waits for both "transmit completed" and
"DMA" bits in esdhc_send_cmd_common() by means of DATA_COMPLETE constant. QEMU
currently misses to set the DMA bit which causes the driver to loop forever. Fix
that by setting the DMA bit if enabled when doing DMA block transfers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 299cd4bc1b..a958c11497 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -665,12 +665,13 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         }
     }
 
+    if (s->norintstsen & SDHC_NISEN_DMA) {
+        s->norintsts |= SDHC_NIS_DMA;
+    }
+
     if (s->blkcnt == 0) {
         sdhci_end_transfer(s);
     } else {
-        if (s->norintstsen & SDHC_NISEN_DMA) {
-            s->norintsts |= SDHC_NIS_DMA;
-        }
         sdhci_update_irq(s);
     }
 }
@@ -691,6 +692,10 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
     }
     s->blkcnt--;
 
+    if (s->norintstsen & SDHC_NISEN_DMA) {
+        s->norintsts |= SDHC_NIS_DMA;
+    }
+
     sdhci_end_transfer(s);
 }
 
-- 
2.48.0


