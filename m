Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59CAC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5dd-0006s0-Td; Tue, 11 Mar 2025 15:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dV-0006qr-Rc
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dU-0007Pn-7d
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1408096f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722689; x=1742327489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGrs420JsV3u/d0B9Ht+EZ0wlrymz2aBc5SkvyjS3Qc=;
 b=MjhkmYnnaHtqHxHE1w2RcUr1K4va6gLeflrSL8oZngmbRD0ev8tbTQrrk8/gZdXVtw
 gd8pW91ooGycl9w+LPWZ6pinSZl3WYwRJATNlr3SO/X4IAEzzI1ifCxXpCKEURF6okbb
 XMuEOQKzsDdv+RGlaINRY7tWrPZu84+7e/SSRfBqT19n7r9vuedmpYQE2i5o8lvR7Vh2
 37ByXitx3crlx3DBDjFlp7JEvRu2/Y/sQz1BFW50Fffw2isNkpm6tUVH+WrzH/EFBtbQ
 6OEUZu5vsTmH64wJ7SPQfPJ3TMvux/LCuXxfty39Cw1y1hkat6pDe+kewOxXs+O8lUwm
 xATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722689; x=1742327489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGrs420JsV3u/d0B9Ht+EZ0wlrymz2aBc5SkvyjS3Qc=;
 b=Ehsox1To0O3KH/pd7EE2id10NC8jzjeapDyAXEjTq7OJqeqtTdSV7YmsemInTrGatI
 Hj0CwFciegjUszK2Jf56I1TbCAhfCIfZ8dUMxOHZIh9e4Wl9vezQcA1t3pHQINGP9Tp8
 QetNYFbQPkD//qM8i/ZCMmEvXybld+EqUuvIMFilq0yoe+1LZb6pPseRWH3zWReiDo8E
 zAeJRQWJJ3CJuLLDZZEbvLND7ixq7jHq8j3nQcJ5DsA/FRKYRrahMRhiXoR7DdJEQnph
 3DEBkaXRqbGPDr0FcNfJtFli6apsfVN2xmr/3SYgKku7XlCLiDN/cv75oWYjB+GRo0mV
 ucug==
X-Gm-Message-State: AOJu0YyiZbFuss0M/eSTZ1qVghLUaRPFlBHN4DO8Q+AR0c1z+8f8PZeh
 JZNn8lK7NmZAlL+ZYX/SU9FpIUqNe2jAQJufXrCIHtGCQiGqjRyA5fp29AOKcVHUnEwJc2KgiHn
 U0yM=
X-Gm-Gg: ASbGncvj9/E7WaCAhJ4av68wXve49cYLxhr/mchBH1Fb8EiAaqFdjkIF0il/cwhxBM6
 DFOe3QRChJ0+ow6WuaAb0XUTzKu0Rlan1+o+nnMubJOK6hR8xChUqsvCgsKLNFg57surHa2T5Iy
 nmcwmqTk1Mai9uo+bK+raLvSTBmcRyVj8yfgOj5vwPH3PN50g5/ae6TxTLwTaJPoLR0Ny0m4fPx
 FLckaYOji2KF33YJu3eOtH2NNczQ+SMYX3SmvlTRSuZfa+jfiM/mxYgGWCh+7oxLeoL/PGgE8qJ
 O6/bWZqbMYAxtTkqY2h5FuCCoosXSKZPlHfg7b5UZ0rcgFjsoQ7g2H8skMK/97PIRi4ucycYuRE
 gNxb5tXSXwWJ+U4wNfvg=
X-Google-Smtp-Source: AGHT+IGEN20I940F9lhIDfDjuoeZWOG5Jbkm96dy4qMFtMC5/P4BnT5s5o6pXgzXd97uYFsLhyBlpA==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id
 ffacd0b85a97d-39132dab192mr14785471f8f.54.1741722689500; 
 Tue, 11 Mar 2025 12:51:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103290sm18644297f8f.87.2025.03.11.12.51.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] hw/sd/sdhci: Set reset value of interrupt registers
Date: Tue, 11 Mar 2025 20:51:10 +0100
Message-ID: <20250311195123.94212-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The interrupt enable registers are not reset to 0 on Freescale eSDHC
but some bits are enabled on reset. At least some U-Boot versions seem
to expect this and not initialise these registers before expecting
interrupts. Use existing vendor property for Freescale eSDHC and set
the reset value of the interrupt registers to match Freescale
documentation.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 1 +
 hw/ppc/e500.c         | 1 +
 hw/sd/sdhci.c         | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 38c08e28598..f722d8eb1cc 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -110,6 +110,7 @@ typedef struct SDHCIState SDHCIState;
 
 #define SDHCI_VENDOR_NONE       0
 #define SDHCI_VENDOR_IMX        1
+#define SDHCI_VENDOR_FSL        2
 
 /*
  * Controller does not provide transfer-complete interrupt when not
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index fe8b9f79621..69269aa24c4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1043,6 +1043,7 @@ void ppce500_init(MachineState *machine)
         dev = qdev_new(TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
         qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
+        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1f45a77566c..fe87e18d5d2 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -307,6 +307,10 @@ static void sdhci_reset(SDHCIState *s)
     s->data_count = 0;
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
+    if (s->vendor == SDHCI_VENDOR_FSL) {
+        s->norintstsen = 0x013f;
+        s->errintstsen = 0x117f;
+    }
 }
 
 static void sdhci_poweron_reset(DeviceState *dev)
-- 
2.47.1


