Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A13E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKR-0003y4-5z; Wed, 08 Jan 2025 04:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK3-0003uV-9D; Wed, 08 Jan 2025 04:25:56 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK1-0004lj-P6; Wed, 08 Jan 2025 04:25:55 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso327131a12.1; 
 Wed, 08 Jan 2025 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328351; x=1736933151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXu/deQBUSnnpDSne97TzvwNxObiNI5E/wDmJP67j7k=;
 b=bSLMuEeTMsmKBN5B7XrmrNkmcwyBsCbLhbI5hPIuxmC4WWIJdhVF1E7I98wKjq/Ke2
 3FBv2sx8EBpWhq0ZD2a0k95Bj4e+xEWwxVLI9AhdDrjBb/C/qqO77Y6HS/O3leQsMUrA
 eoJcBamaRjjE4+y3jhMJkNcCRCyd0+Oag+pGOHL0WXKXrq/a5Ao/Pd+C80PBWhaZzdYc
 NqOaOyLk10ZDxtUEC2ftW4k7JY3YLUsqzg3q5IvEPaS/kplqAFqlMbmK9x5nrHsU4sKP
 Txs60waZPKl5qIMZUCzO77yIhw3cpLFFJlMG2yJW4lV/PiO2Crg2iow2ZooKo49zzbcY
 zP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328351; x=1736933151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXu/deQBUSnnpDSne97TzvwNxObiNI5E/wDmJP67j7k=;
 b=SxixJltMuBmIrsBR6eBlnvIKJ/PSJrrwhNtf0TI/YnfjPguhH2GLBB9M7tYM4DEAfW
 MTZbiH584CK6NwPdlVdNgNACMuTnd5K7zZJ7Y1ilX8/ZWzBA1PBmVJ4wfZUelg87J56O
 GH7F/4Y9wuXEZbEzFwqSH0NUflAIW/AeF/zaLnTuaX4T1n2cqb1m7eeuE+Mjt5Ace7LC
 t6Vt4iXxHwnk1E2lvdBFKiVcV8rgf71kYTKWGsnJH1OdW0kn/n/YhaxBNtfO0b5pgM2f
 Dm+4jy0hUHtIaoZhweVqv0QCw9iOE0c9gK/moW+V5OdNNDPcvlhD1yQsAl1zJGNcyiVf
 bKsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZVmYhkmp7isB7a+GR1edgmcPqXH63e5yz5Bf630pbtm0d0SomnnNAgfLS0XpBDXDBNWeBpSxd8w==@nongnu.org,
 AJvYcCX7ESo2vflDvZN0igpz3Tu/b//1RTHSiNK5gqVHMpnUBqcoEQXgtf58/vvJ2ogWI9EPiVUv+xWvMzmyBw==@nongnu.org
X-Gm-Message-State: AOJu0YxJrFQHHxfkgwha4dOoYehNHSlI03ygkhu06tvWeykg6qnqeN8e
 5PTmj8sF0yOar3kpqMah/Gfb0XI423gWpczmt2pyqT5gPY63l0LtG2oDNXCj
X-Gm-Gg: ASbGncu1KWvQSKLG0K7j/iC2vCqPhLslc4bSHvkKa6LqAmoekSuZtFaxbyi0LSXer01
 JJBbSA7+U6siCn8WNZ0ZEqaD0JOfBttunb+X1FnwaVMY+cQQDhnFQSTx8vq33zyN+J3bEGCmrv/
 MuhvzVO8zlB8jZrqebsxowOSdNhx3hWRlN0cHc1gxTX2n5/XdCCx9ArXE/oewenPwavQ476DHto
 S12kW2iJSPbT8cKoco0d8V3EX0EP+CYY1ewQp8MiYGlMcfDzk/oq9KYNK5DkUDXNseZDDzQhwHu
 aGOR5PybJKr5fqTYRZ6wuZg9bVNW0D8gz5FTvaW1HFaQqz0=
X-Google-Smtp-Source: AGHT+IEdl0jXAisf4h7trCYbLzurFWxs9kxVpMSvY31SMbqVsugTdi+MxWUuUUa4zrb0mvLwGSE+Jg==
X-Received: by 2002:a05:6402:2347:b0:5d2:729f:995f with SMTP id
 4fb4d7f45d1cf-5d972e6f957mr1368915a12.29.1736328350418; 
 Wed, 08 Jan 2025 01:25:50 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:50 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 01/14] hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
Date: Wed,  8 Jan 2025 10:25:25 +0100
Message-ID: <20250108092538.11474-2-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
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
2.47.1


