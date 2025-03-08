Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B045C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzSb-0007uQ-3Q; Sat, 08 Mar 2025 14:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzSS-0007nR-9l
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzSP-0003gK-Bo
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso31866405e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460612; x=1742065412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQvf9YM7B8m3c5YxTAHSd6W3rVOYDlZhVENkZCcVArU=;
 b=ns7w44LpXorsU85iHgW4I+sy4YZiFIbUGrxrYIO3zGZgUrCYErwMS7DastTk2/5Ia9
 BbivITkqji2ZU/7O60c7+OI8ldosEawK5UUerppY7An0PAI653nyH6em5k2pt3jkREVK
 i5CXzRjhj0q4QadMYibk5r4szDDcMHW98T7KSScB0ikDOpTCNSqXfUkCnPoZc+zYWoba
 6oYhZyIvKr0CbSox5LwVV/RyFZiEQsaMo3wYbMiRXjCB45GVBBHJXpjLRm9RsNDItCbz
 4KQ+JxzxBnfOTGWWRueAoEhoaeecuXoQWcmYhzPQuwhmUeuN0sbIHKYlRbMPMEsqGi5t
 V33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460612; x=1742065412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQvf9YM7B8m3c5YxTAHSd6W3rVOYDlZhVENkZCcVArU=;
 b=eInafLM1B6JkNjk1/89YaUo8GaLVeXuIQxEjZyzWWHvj4IQcFea/ucJaSqotpnbYIo
 mPcJVokLxjlks7DM936/UrZu81tk3jfrIOLHm89sSZWgMMmlZVYlnYOVL6uX6/wwOuA8
 7dNFrXq8UjULFvo+cb0faUSOKuOJqpAmw9H6WKZ15hh6UpDsT93xTll8jc4tBnOoQzf+
 0DcFsr2ud8W+vBWeEGBCX6i0S2xcJjkwEHEPnoiAM0UzZ8k0ye0aIzinuo8aQj19LHit
 wYar967nWEtyc8l6n4L+V3gESe227xWfuFp2MdqfwjuDS/3PWeNtlU2wCQRSiFVi95C3
 RHQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDDFeWUzYhns77X2FqTMZyAXt0t4xAArGgTHUH7az7IiT0m/qxNGuUNa/iDu7hMjKuGAGyiAjxMYQM@nongnu.org
X-Gm-Message-State: AOJu0YzZgAxZDIrDtTaTw5+BJvRc8Wyjcw91ygFisXAWhau11Hh2nceZ
 mTWh3lEucIDdEKkR+iFGJYo00tDU6IObBhOidmDf8/IiIwFMMVtWkfPRYaYNChM=
X-Gm-Gg: ASbGnctzMq9r/lps9nKB86cTwTeM4YeDv7FDpzULn3v3LrpVzRZYb1Bar7SHCbHNSW2
 W7n7qTbfAolrZtip/sbqJ3TtTGF+YiQrst8912oYjZsg2q+drVpNSo+r49QmUqCskgFhK7zT4FE
 jH2+LfF+NXaD8fAOIqdcnGU5zXlN2pFUPK0YAMWyHIQpGKC+x6yDVFuGMTVuapcAcKI+lS32GBW
 I1Lh23oXUoKOAt8IA/AGiKQqBj8VpdBMk/b4N7bFArWg0CKc7TfRVlv8qEOCWwzZfI4TKJcn9Do
 +Ph42geQ6fJhNExQcEu/VBMen6IErp/ynjm60Xt2ylSY4EXFI1IQTOqz+9C0J6COzW5+wD87Mhb
 0PX2luJ3C3wESlIsTFH0=
X-Google-Smtp-Source: AGHT+IGH6OhdtLkPy1QuRlm60sPfB8LFJ6lvzms//nyrr1cC5Hw2r5tfojRiqjEMDa39OLL9kXIfAw==
X-Received: by 2002:a05:600c:1d24:b0:439:916a:b3db with SMTP id
 5b1f17b1804b1-43c5a6301b5mr61265805e9.6.1741460611733; 
 Sat, 08 Mar 2025 11:03:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cef25f075sm8657555e9.28.2025.03.08.11.03.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:03:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/12] hw/ppc/e500: Replace generic SDHCI by Freescale eSDHC
Date: Sat,  8 Mar 2025 20:02:30 +0100
Message-ID: <20250308190230.7508-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

As Zoltan reported, some U-Boot versions seem to expect
correctly initialized registers before expecting interrupts.

Now than we have a proper Freescale eSDHC implementation,
use it.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index fe8b9f79621..e69551ccdb3 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1027,20 +1027,12 @@ void ppce500_init(MachineState *machine)
 
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
         qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
         s = SYS_BUS_DEVICE(dev);
-- 
2.47.1


