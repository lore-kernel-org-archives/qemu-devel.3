Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464BEC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQgM-0002NG-UD; Sun, 09 Mar 2025 20:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfr-0002CV-O5
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:16 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfo-0007Q9-Fi
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so2130668f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565231; x=1742170031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbDUibVkXNR8REIQVVOEU7ZYDHi6ABLRhy2a8AYGnao=;
 b=OtPWoLzvBNGuPVeoSR1K39DckV9OM/kmSmSPWOUkGvyvXLI0+y+6fueluA42oNkSDA
 3mqLlUap8YeLzynHhu/VN6BmJCI5dCUvOC1bS8ab/CHIRg0O0h37jXuhEDG/UKA+mdZ9
 jmZeyoDP8ke+wRtzkFU9efPgNVS+PuYKFJKsO/Vn3IhBjgvjgefWITs7hkkQypy8Qn1r
 p2db93FD9mmhwuwtkjVK/HtGoV+QFuGlAXlYI7/IQSLvnl8lJu5aFbEFVOo8GOHHJV2X
 8DehayfynZU0mG8otkpyvdFpxJr2vcJ/Ckd8kn5fqMjoqnoXV1+PNk5Hzn1ngpvleyLE
 qh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565231; x=1742170031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbDUibVkXNR8REIQVVOEU7ZYDHi6ABLRhy2a8AYGnao=;
 b=vHPiROQolNS6lY6UC51afD/Z7UVkoVwR0/7cBcQjILqgsHm/bkifgHMwT76PtIp0C5
 IY+vhih5/u5D9U1Xt5ADObnPagOjmFbWeTuntW5omsWtDf3QT6N8d34afvVla+g9Mbzy
 zojE9mLp1fenXpsLHB92pwQA7gyaJSRAMnNDpX2yGRV0vMwRGqNb09unTZdCg2YPNFcW
 LrKc9NrLsJp63nlGxLYbdwS1KyA7knjnp021lvecQoUdeAlvapILNKfvyLRh+AvL+amK
 tRCTzRkY8lx82U/qbKByqUkeN1ID7x10mlOqLkn7+ZM/xp2itXQ/Xxt4AMoimVoGIgQ7
 Msng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOGLj6V9wJRqaUDlrBRboEzwpePukW7+QKzti1am9atbgg0/mdgaRgG3L9nTBianvhjmmYvCZ4Q1wT@nongnu.org
X-Gm-Message-State: AOJu0YyznysQhSeH+oZHsX4lGhy08soLQ8xDEmI1DRa7X7u9mi+pYLhE
 NSD8H1DQ32DPqJgRfAalifknikpERM4LSzk1v5rpaE8+jNB84sLX9JZaHx7Jf/Y=
X-Gm-Gg: ASbGncswNPupglmfkFHKPcFi4fiH+eGRx7kotUZTNUFl/RdxshyYGV6Cb+OYRZGr8z3
 fnL+BmbCmz8MF7CvrfxCu1tZGkHUXWc0C3XcVYV285NyJtp/AWRLPYytQyvRZttNufIjgwvuqot
 tq9irnmc+FJUiYEz2Re/rdJZPbnBLYmDyrYql9jmjfgSfq4hXbxobXV+u8eg+5+9ZFZjviB05ql
 nCv91lkL1xBRNQHMMUAt2npUn6LYAzRQmKvc/hxkCGhsjp99ZEf73nCKKLj08qvtkIHDZ2BETSw
 3rSeqBqgexbipJsDsUSKTVjHpn2ou/sUywqdCwbEbQzavOF4g/ElLfVK7/FurLyVj3LZ53UzBuj
 vzBy2se35N88g2F1z+EQ=
X-Google-Smtp-Source: AGHT+IF5QewoVsjT0unohWqDO9VhZs6iTnHGiomQ1HBvRBt7UeRTDl3O4/PgLX/bqsZG4FCZJdNBVw==
X-Received: by 2002:a5d:5886:0:b0:391:4684:dbdb with SMTP id
 ffacd0b85a97d-3914684ddbemr1391364f8f.17.1741565231072; 
 Sun, 09 Mar 2025 17:07:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb799fsm13080658f8f.2.2025.03.09.17.07.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 09/14] hw/sd/sdhci: Allow SDHCI classes to register their
 own MemoryRegionOps
Date: Mon, 10 Mar 2025 01:06:15 +0100
Message-ID: <20250310000620.70120-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Add MemoryRegionOps as a class property. For now it is only
used by TYPE_IMX_USDHC.
Otherwise the default remains in little endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index dfa0c214036..108bc1993c6 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -117,6 +117,7 @@ struct SDHCIClass {
         SysBusDeviceClass sbd_parent_class;
     };
 
+    const MemoryRegionOps *io_ops;
     uint32_t quirks;
     uint64_t iomem_size;
 };
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 3467385490d..6868bf68285 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1428,8 +1428,6 @@ void sdhci_initfn(SDHCIState *s)
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      sdhci_data_transfer, s);
     s->quirks = s->sc->quirks;
-
-    s->io_ops = &sdhci_mmio_le_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1447,6 +1445,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     SDHCIClass *sc = s->sc;
     const char *class_name = object_get_typename(OBJECT(s));
 
+    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
         /* s->io_ops is little endian by default */
@@ -1890,17 +1889,11 @@ static const MemoryRegionOps usdhc_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void imx_usdhc_init(Object *obj)
-{
-    SDHCIState *s = SYSBUS_SDHCI(obj);
-
-    s->io_ops = &usdhc_mmio_ops;
-}
-
 static void imx_usdhc_class_init(ObjectClass *oc, void *data)
 {
     SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
 
+    sc->io_ops = &usdhc_mmio_ops;
     sc->quirks = BIT(SDHCI_QUIRK_NO_BUSY_IRQ);
 
     sdhci_common_class_init(oc, data);
@@ -1957,11 +1950,13 @@ static const MemoryRegionOps sdhci_s3c_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void sdhci_s3c_init(Object *obj)
+static void sdhci_s3c_class_init(ObjectClass *oc, void *data)
 {
-    SDHCIState *s = SYSBUS_SDHCI(obj);
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
 
-    s->io_ops = &sdhci_s3c_mmio_ops;
+    sc->io_ops = &sdhci_s3c_mmio_ops;
+
+    sdhci_common_class_init(oc, data);
 }
 
 static const TypeInfo sdhci_types[] = {
@@ -1983,13 +1978,12 @@ static const TypeInfo sdhci_types[] = {
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-        .instance_init = imx_usdhc_init,
         .class_init = imx_usdhc_class_init,
     },
     {
         .name = TYPE_S3C_SDHCI,
         .parent = TYPE_SYSBUS_SDHCI,
-        .instance_init = sdhci_s3c_init,
+        .class_init = sdhci_s3c_class_init,
     },
 };
 
-- 
2.47.1


