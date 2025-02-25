Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41081C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLX-0005Gb-SI; Tue, 25 Feb 2025 13:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJh-0000Gc-0T
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJb-0002Ky-H2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso36758515e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506751; x=1741111551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i3LaSe6B2Ol1+6mqM3jCwCvLSHRa2sV49bRJeNYJwAY=;
 b=cq3b5co3O/oSFqIbASHbpfkRDXl/Zm0/yAwMudZYKYnkBzvDHPYTu9oxCnuHAiAmhs
 paQZIjgNHBlXmoUpVGMgvcge8EDifoa32558r0sdOqAj9zOKce/GmbkTmFimxbDggV1o
 85rBEQrFYDXPC5XlCXz69vpx4FVoSTOc1y+xpVoNK3YvQaVL0iYuKoNvrRvnXup9Sxyc
 GY+VyhmuzLXGlQK+eZIqjl3xX5jUifG6zvOq7OnG6IvLikDmD1tHT80tDyXFAm8lHTb3
 39TLr/f6pRa+QgbIwIrmOJFVI0rnCFJWimuE6li08x7LkGPeAcxqBpFqyQivjgDFhEW3
 B7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506751; x=1741111551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3LaSe6B2Ol1+6mqM3jCwCvLSHRa2sV49bRJeNYJwAY=;
 b=JNgWBf2njnqH0bR7i/WSZ74mnMKbyrEQahZF5ppMUMqIgMBkMcZXw3G2gD1RCgYNME
 W8BDeSF6FB09WTOoRGbY6UUb5PKk5twdj0NLhIrjk1ePm+ZgeoiuOlwc7AJqArThuErV
 1C61JyiO23+Zc4A7LZMjKqpa9VX5J4qH+fWqpo4Ia2z7G3rbjoz59vlnJO7p07Hm2PK/
 xpZ8zjwj85Av4MCc/HLKJfe2JOBeuPvigKcgm9JfdVgu2UNhwXrz6zEz2jedR6FdeY5E
 exovBQSdCXHZ8hdlzfinlF78G3/zq/5B8TAx5OVLyw/csmgn8gsnei/wgE0mcSgUrQeN
 cfyg==
X-Gm-Message-State: AOJu0YzC4HFvM/Yg71aLVsv24Pd67ygDQPjypLQ/O6Cz9f6d+qKefyN7
 lQ6kyK14WFKqOauv9ZLUDe69sBkK+q/vpk+ui/Oybc8HUgGlRmyiIK0eXCojDK0dnRDs7vHNICE
 F
X-Gm-Gg: ASbGncvAG55KyK07uh0/r7Ljo6XVVmTWmPOg+bGuBhYocmEa15x7DEmyxP+HQ/55YlM
 e7qKs8SrhahLQeLlp9zd1BSSzo1fb7ou8w/12pYD3sJfzAK7WR8xyu84uRDogRewvlm5KnZ3bhz
 VNedPKh1YHI1LvZx9gkJQye9B6STBZX/eRutm5coo6W5CXzu6kaNo3K3Lhjl4ze6jCn5doLlvll
 ND5JjI7ag/QDG6GqSzAzNg3aoHqellGOEWVBIUKxq6B+xMB+h4V1/Pg0CuwlSVN5PLDRRVZ/crQ
 q56pA6J9zjCdePISdaYcM3Z4UvPOSyxA
X-Google-Smtp-Source: AGHT+IEC4L8jlV28AqjnbzDf24I4wyuxSdwFZ8/iqnCsqoYtZEV6HrtA+RaUOHc55AIH5Xwpj341gQ==
X-Received: by 2002:a05:600c:5012:b0:439:98b0:f8ce with SMTP id
 5b1f17b1804b1-43ab60f0c1bmr25818195e9.7.1740506750722; 
 Tue, 25 Feb 2025 10:05:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/43] hw/arm/fsl-imx8mp: Add SNVS
Date: Tue, 25 Feb 2025 18:04:59 +0000
Message-ID: <20250225180510.1318207-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

SNVS contains an RTC which allows Linux to deal correctly with time. This is
particularly useful when handling persistent storage which will be done in the
next patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-7-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  2 ++
 hw/arm/fsl-imx8mp.c            | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index f0df346113f..22541c54424 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
 Boot options
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index ce5188e7f23..26e24e99a15 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
@@ -36,6 +37,7 @@ struct FslImx8mpState {
     GICv3State         gic;
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
+    IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
 };
 
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bc15b25ca16..18c9c54ddc6 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -201,6 +201,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -344,6 +346,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -352,6 +361,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_RAM:
+        case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
             /* device implemented and treated above */
             break;
-- 
2.43.0


