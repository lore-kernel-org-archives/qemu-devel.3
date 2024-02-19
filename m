Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52764C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6fu-0001Si-Io; Mon, 19 Feb 2024 11:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6ft-0001Rt-US
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fs-0002wJ-8x
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4125eabb8f4so16788645e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360761; x=1708965561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzsFl96TqsANx0Bu/9mPtcZl7XwvdqWDGq2/cLicoFE=;
 b=vFS4/IPXvaSfFTS+xWdLBrfxLQlwE8h4CaELCeC2+j/j2WmBkrZqY5V15fQt1fCeZ3
 kLKaJas1OXmMbSVPZ7F3klZTvF90QLSFf4T1ZTJumWq3sYKx6SqYxr1gt5eQrzbDdROm
 /C60DouBYD4m0QkRCrEE52aSPJ0SO6qVvKoY7TLWApaMM529xHj7MZUuG9E6UNHZJBsC
 6k1BthiGYdFXyj/EUASUWsG9vJnXEW8gy4saMlJf/B3Yy6QZ7tcWhFv18W0fJyKY98K4
 4apan46gc26vo6rOfCBty8jRYsxVLyDgTOyw65AwNULQu8sMY4O1KYoqWlADHT+JmwHj
 Sl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360761; x=1708965561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzsFl96TqsANx0Bu/9mPtcZl7XwvdqWDGq2/cLicoFE=;
 b=xTGXwaaULvCzRZ6dlTt9PB/uvEtm8wIccD7ylZdkoDNH3DGazAGYp4SuVzaw2VDrja
 pltb/ecvgz9J+N9L2eYbykUJd9BznABcjC0iHoJilN3Ze7cg3hipWUDukh3y+dj0/59u
 AwBdjcNYdBBtts2WO6khWsUnlIb+m9EmQQ9c5HTm+3C1CU0H+N2gs/WK8eSsxdJlXnj/
 odSSHA6l59XqnVttFCfMpH3hoBz6IS8LFFICLChiO2PeaHbDn/yWi0hCbolmciQBEgC3
 qcC3q3CDFjoeYCCr05z+Lsy4EQFuDze2BwMda5oR2vxzXwp+FdvtbnzjQZK/B07nmkhE
 WTHw==
X-Gm-Message-State: AOJu0YxiAq+S9kb//2GStXC8vTLwoOrhZoCyXco0FJMLgHKxY+LKrLo1
 R6Pphh1wlACikQbHdBGa7n8qGOw/2oNK63aI724H4lH93AeDos37Dxoxi3sv/7ea/gRkh2zKngj
 e
X-Google-Smtp-Source: AGHT+IETcHxSVZu5bybRHQpnjteNlCXM0zm/8cCcn7BYNRUNS6bB8xvOn1ZSmX3U+OVzafmhbfOkRg==
X-Received: by 2002:a05:600c:34c4:b0:412:6cb2:e1db with SMTP id
 d4-20020a05600c34c400b004126cb2e1dbmr132672wmq.0.1708360760860; 
 Mon, 19 Feb 2024 08:39:20 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 d2-20020adfef82000000b0033b75b39aebsm10845231wro.11.2024.02.19.08.39.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/14] hw/acpi/ich9: Restrict definitions from
 'hw/southbridge/ich9.h'
Date: Mon, 19 Feb 2024 17:38:43 +0100
Message-ID: <20240219163855.87326-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Restrict ACPI definitions from "hw/southbridge/ich9.h"
to the ACPI files where they are used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9.h        | 15 +++++++++++++++
 include/hw/southbridge/ich9.h | 18 ------------------
 hw/acpi/ich9.c                |  4 ++++
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 215de3c91f..3587a35c9f 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -91,4 +91,19 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev, BusState *bus);
 
 void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
+
+#define ICH9_PMIO_PM1_STS                       0x00
+#define ICH9_PMIO_PM1_EN                        0x02
+#define ICH9_PMIO_PM1_CNT                       0x04
+#define ICH9_PMIO_PM1_TMR                       0x08
+#define ICH9_PMIO_GPE0_STS                      0x20
+#define ICH9_PMIO_GPE0_EN                       0x28
+#define ICH9_PMIO_GPE0_LEN                      16
+#define ICH9_PMIO_SMI_EN                        0x30
+#define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
+#define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
+#define ICH9_PMIO_SMI_STS                       0x34
+#define ICH9_PMIO_TCO_RLD                       0x60
+#define ICH9_PMIO_TCO_LEN                       32
+
 #endif /* HW_ACPI_ICH9_H */
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index fd01649d04..1ac4238f7e 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -183,24 +183,6 @@ struct ICH9LPCState {
 /* D31:F0 power management I/O registers
    offset from the address ICH9_LPC_PMBASE */
 
-/* ICH9 LPC PM I/O registers are 128 ports and 128-aligned */
-#define ICH9_PMIO_SIZE                          128
-#define ICH9_PMIO_MASK                          (ICH9_PMIO_SIZE - 1)
-
-#define ICH9_PMIO_PM1_STS                       0x00
-#define ICH9_PMIO_PM1_EN                        0x02
-#define ICH9_PMIO_PM1_CNT                       0x04
-#define ICH9_PMIO_PM1_TMR                       0x08
-#define ICH9_PMIO_GPE0_STS                      0x20
-#define ICH9_PMIO_GPE0_EN                       0x28
-#define ICH9_PMIO_GPE0_LEN                      16
-#define ICH9_PMIO_SMI_EN                        0x30
-#define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
-#define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
-#define ICH9_PMIO_SMI_STS                       0x34
-#define ICH9_PMIO_TCO_RLD                       0x60
-#define ICH9_PMIO_TCO_LEN                       32
-
 /* FADT ACPI_ENABLE/ACPI_DISABLE */
 #define ICH9_APM_ACPI_ENABLE                    0x2
 #define ICH9_APM_ACPI_DISABLE                   0x3
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index be375a8b9d..228ebc9a1e 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -49,6 +49,10 @@ do { printf("%s "fmt, __func__, ## __VA_ARGS__); } while (0)
 #define ICH9_DEBUG(fmt, ...)    do { } while (0)
 #endif
 
+/* ICH9 LPC PM I/O registers are 128 ports and 128-aligned */
+#define ICH9_PMIO_SIZE                          128
+#define ICH9_PMIO_MASK                          (ICH9_PMIO_SIZE - 1)
+
 static void ich9_pm_update_sci_fn(ACPIREGS *regs)
 {
     ICH9LPCPMRegs *pm = container_of(regs, ICH9LPCPMRegs, acpi_regs);
-- 
2.41.0


