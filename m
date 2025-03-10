Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65BC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQhU-0003a7-Dq; Sun, 09 Mar 2025 20:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQgB-0002NE-8k
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQg9-0007Vf-La
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so1254185e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565251; x=1742170051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5cfsxYC6Xjld/r/JqOEermJubm5JBpQoqIXWekO6mg=;
 b=nneatwbfbwVp29rYFzmzKnhJyWbGVwcoEEkNxxnkcVkkC5N8N4QY6UHC3vNBZsaeG8
 ON23bCJpsWrbF65stmMmQSqRmkADUX35HoCKHgWcanB0DIpk2qhcFaxTNZM9SJKoHKf6
 8GxBwGA5qxX3PHTMVzSuyRsoY26Xxm9la5TveVz0TvZcQS8Qt4Ip+QYqvARc6staAjCt
 naofQY0BqQNEFlTcV9rv46gp05SmPOPFFhVrcIUXKl8+bVRRRGexXol+iP8zkgwUiOTS
 llXoCIMnD58QPY+I+6+wxwfmtsFgK4TworV2A23XK7FEuJRLzyG4hV9TJLN6Bt7qOPdw
 2F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565251; x=1742170051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5cfsxYC6Xjld/r/JqOEermJubm5JBpQoqIXWekO6mg=;
 b=NVQM80XAioX2HhFyPXhY5UCNQKzhky4pfDADla9SPLSzLfiWq7bbKmBEInuzCyQ3pN
 bhv4jMH7T/JrFJE0pkUUYDc9SvsWOOBWT9TxtBkpJgvuKDcnftlSnKx2mGeS4CwSBozK
 EpCCyY814sLLr2Yuf8XyEqbXPpBJwErkqsoLPac3Yi/YMFRSdhVjdNcah9lKbvGsyydS
 anrLneLZkqMIG11m0TKB9xjZcdW4r+BW6gatB6QMq/UJ8ymxDLe5Tb2kwVuqA4Ne5aI8
 LRJGpwArdFD0PixOJKBvDf7pwWyO8gYi5k0/i6TUEzzXp25FALGQYT1Sup4yYNSaRLpK
 kk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJrOMYmGPDjdGP+gKUf9hNFQg4lNsDeKVsVsKewrSw59mw2ZNO3iZdQ6CotuuWLr1uMKc+iL/XENyC@nongnu.org
X-Gm-Message-State: AOJu0YwxEyhS6rBNqeUqkJSH2abq0DmA/YuJJZ+X8CGC9JWmllZc9N7T
 fPwr1efhtu84jhqVCxTrWUQUcMsO1Cv7+PPZ/WXTXaQYUATt4ckHaMPf+qsZMhE=
X-Gm-Gg: ASbGncv3BlDgYr/JbTNcWcRQ8hgV/U0GPTjBCXGKL61Vxwx8OUXwDWK4323p29fZMSc
 9s1ys+/mfZ5D/GqDikgl0CllLwPCXWHesZLg+4W0Y+A+3HgKzcUprqycOTplXedEgDN79zoNJB2
 mlSW6gk2tTnEvlSOPOGQDatHkC7pOtoBd+BRLF1Qzw1tzZSIcy6XLv6aGkv0fV+Jwpi2Aq9O1Y8
 2cKbG2nHJ6cbj7rGvi4RdQJoYH0m6yzIPeWR1WbPhfY+8SK7zNBFCXBXM6d7LSOBctKYXB1CR3E
 Sll9Gnkrcihzf+JsYuUOrdJdeKQQHBNAJn6sOkqqMjOqgi3Plv62cxcysLG0G+X6UYBqWpsSYxv
 pJTJvMilBVShFT4IdF3g=
X-Google-Smtp-Source: AGHT+IEhh9NwzECdI4Tc9MSV2/EcCXRTLQg8iKhWY8DRcCUsXG/E2Q6uVro6pRDyFUpCZzEIGYjSNA==
X-Received: by 2002:a05:600c:1d01:b0:439:8e95:796a with SMTP id
 5b1f17b1804b1-43ce4dd80fdmr46685805e9.13.1741565251461; 
 Sun, 09 Mar 2025 17:07:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e222dsm13208524f8f.72.2025.03.09.17.07.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:30 -0700 (PDT)
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
Subject: [PATCH v5 13/14] hw/ppc/e500: Replace generic SDHCI by Freescale eSDHC
Date: Mon, 10 Mar 2025 01:06:19 +0100
Message-ID: <20250310000620.70120-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Zoltan reported some U-Boot versions seem to want registers
to be initialized correctly before expecting interrupts.

Now than we have a proper Freescale eSDHC implementation,
use it.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index fe8b9f79621..2de7d94df9c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -49,7 +49,6 @@
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/sd/sdhci.h"
-#include "hw/misc/unimp.h"
 
 #define EPAPR_MAGIC                (0x45504150)
 #define DTC_LOAD_PAD               0x1800000
@@ -1027,22 +1026,13 @@ void ppce500_init(MachineState *machine)
 
     /* eSDHC */
     if (pmc->has_esdhc) {
-        dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
-        qdev_prop_set_string(dev, "name", "esdhc");
-        qdev_prop_set_uint64(dev, "size", MPC85XX_ESDHC_REGS_SIZE);
-        s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
-        memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_OFFSET,
-                                    sysbus_mmio_get_region(s, 0));
-
         /*
          * Compatible with:
          * - SD Host Controller Specification Version 2.0 Part A2
          * (See MPC8569E Reference Manual)
          */
-        dev = qdev_new(TYPE_SYSBUS_SDHCI);
+        dev = qdev_new(TYPE_FSL_ESDHC);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
-        qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
-- 
2.47.1


