Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42A1C52D54
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWiH-0004hz-Un; Thu, 01 Aug 2024 10:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiG-0004eY-Bd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiE-0002dq-Ja
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367963ea053so4496637f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722522205; x=1723127005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h+MJzRKWcpjrJjzySZ9OhtIFSfp0r37te0SXkDl+IAY=;
 b=nqP1IE//+sKDqhCWIxEUqQ8Nk64gLPP6QrRZdu4vfDxLd5I54Bm4GhUUAdzcmjYcwM
 g4SE/qRYSP4M6+XplO2TlvJ5++79dOk7TZ0pePnjeoWK9Cq9iAMonXWANCyZHWt+1oa4
 Wj6OayJGS01tDtntR35qpkM5QyHwwz7kxjqSvGD9BU3MHX8KfZlk+dRYSqVdtlXWJ2d5
 XMBXzrDGriz3lErOHAJH3CkzWI/Jq/8/ErJCa56OqYFBUmOv1z++fcvzBra0pDvIYAQo
 jcdL2g7ypHUbirALMxVI7LaJr8ouSDVRFO1vAgE0wKh+alXVLnDAnxWvykpsmCrApC0z
 WoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522205; x=1723127005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+MJzRKWcpjrJjzySZ9OhtIFSfp0r37te0SXkDl+IAY=;
 b=oEdOe+4aTaZRLQ7se1wgsmsBSAU4aYm4lyS7LSCY3HuPGUgXewo5gMTosQcDuSpN9M
 DtO+cDhxT08PXYmuUG0Gb67JuQ8UmpzcHorzW/smj/xbtABDBInKYKh7TFrsiQxVeTzR
 sL5Kgd2vxCo4iFVXot/qs8ggy4bXV/IrMG5JgCCdil4dv+VlizY2cHcARGUzqhqkCsBz
 k40I9y1yRXvnj76x3nX86RVPBKmWJboWABbSDMK+GmfAF/YFmop0QNwRm28FezEK0Li9
 jjWsbhfBEOGNM1vqDCqpalRzINK/Ht4VsYCVG/cqbmncjlHoGsfHjN2LNY2x27BtHLUH
 7clw==
X-Gm-Message-State: AOJu0YwzehNSUEZopNNbu4AXiap2RvTf/yKgg8jFwvMZ5bpRRG996DFG
 IPqJrvbDN4FTXWk+aPH/rJ97dI/xbAzOunOJT08t3GzUYV+m/P98WwOJ6Ho7kCmzfLHyJlkxI4J
 f
X-Google-Smtp-Source: AGHT+IHatWi5XSBaCnJPnbTC1lTaJEc3W6ghu5gwQ99vkxGuIZI4Y1XOFsnyNa+OIgwVc0d7czWPQA==
X-Received: by 2002:adf:f60d:0:b0:369:b842:5065 with SMTP id
 ffacd0b85a97d-36baaf61c08mr2242773f8f.41.1722522204684; 
 Thu, 01 Aug 2024 07:23:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e08012d7sm29657435e9.22.2024.08.01.07.23.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:23:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/arm/mps2-tz.c: fix RX/TX interrupts order
Date: Thu,  1 Aug 2024 15:23:19 +0100
Message-Id: <20240801142322.3948866-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801142322.3948866-1-peter.maydell@linaro.org>
References: <20240801142322.3948866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Marco Palumbi <Marco.Palumbi@tii.ae>

The order of the RX and TX interrupts are swapped.
This commit fixes the order as per the following documents:
 * https://developer.arm.com/documentation/dai0505/latest/
 * https://developer.arm.com/documentation/dai0521/latest/
 * https://developer.arm.com/documentation/dai0524/latest/
 * https://developer.arm.com/documentation/dai0547/latest/

Cc: qemu-stable@nongnu.org
Signed-off-by: Marco Palumbi <Marco.Palumbi@tii.ae>
Message-id: 20240730073123.72992-1-marco@palumbi.it
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a2d18afd792..aec57c0d686 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -435,7 +435,7 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
                                const char *name, hwaddr size,
                                const int *irqs, const PPCExtraData *extradata)
 {
-    /* The irq[] array is tx, rx, combined, in that order */
+    /* The irq[] array is rx, tx, combined, in that order */
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
     CMSDKAPBUART *uart = opaque;
     int i = uart - &mms->uart[0];
@@ -447,8 +447,8 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
     qdev_prop_set_uint32(DEVICE(uart), "pclk-frq", mmc->apb_periph_frq);
     sysbus_realize(SYS_BUS_DEVICE(uart), &error_fatal);
     s = SYS_BUS_DEVICE(uart);
-    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, irqs[0]));
-    sysbus_connect_irq(s, 1, get_sse_irq_in(mms, irqs[1]));
+    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, irqs[1]));
+    sysbus_connect_irq(s, 1, get_sse_irq_in(mms, irqs[0]));
     sysbus_connect_irq(s, 2, qdev_get_gpio_in(orgate_dev, i * 2));
     sysbus_connect_irq(s, 3, qdev_get_gpio_in(orgate_dev, i * 2 + 1));
     sysbus_connect_irq(s, 4, get_sse_irq_in(mms, irqs[2]));
-- 
2.34.1


