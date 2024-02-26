Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91526C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwX-0000cl-4u; Mon, 26 Feb 2024 06:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwU-0000aa-O4
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwS-0008Rk-4G
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412a4055897so7474215e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946078; x=1709550878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QBqOyXgT7orA7qPi5TfakjR96hU4MOD2t1dujux2Zs=;
 b=H0ThD5ylskWje9aLan9+WVqTHLInbCs8lyyvkbnzJ3jWfyr+1WogGiFmhSINnO5WM3
 KKloHYofNPb9qluCMG7mtNOxiZaN/DqI4rTSi3ysJ34kfm3KnwWJhIVvNSE/vN2t+uc+
 0Sz9vZOpZPrGV3oIv1FagFgQpbvOM/rPs4/RIB9RbK8mC8GxtFi9n6SukjYa2W7c3I9F
 ryN7zx8ECZCwRZzjzuzx2D5ObNiVs2cjpvdaUrYNIg/zCAJJi5hlF5t+JUS4J/CGTbTU
 hQqxdpZdHfl6vzyafJFpmXOvAgUvcSozi8SL4Pg5HIuF5Xuj+coYsfN8YWh9Dy19lU/L
 iV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946078; x=1709550878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QBqOyXgT7orA7qPi5TfakjR96hU4MOD2t1dujux2Zs=;
 b=Ih2EfiQKBpZvA5IO3gmGauZG4YEQSaYvUg70DYJvD/F2KiF41M65UHWNvvIfJdu99F
 ijlOcpWFtwJ9bhtMvIpiIeL6iRt/NfJbuQ5Oz3abKY8G5/yxvgk3I5yP+qYUUqY2iFwD
 OjGh6Wi5Q2OQDRRBI8GrLJ1p+O6NT97XMx1xwcaYNWXOTZAY4GRP7OfEaT+S4Nc7ck/c
 x6z8qxsnzqWQ2z1wLYjdwhFdARGNSiCPoRdda2giv+C1UZQoHn3yGIq8DgjFgftM7YBJ
 z3qiQyFpw9wWKyRt3o5YjN+YYEKBn2JiXhdjcu6Epy8jJIji7rb6mkFXV50lsIVPQoC5
 Yy6g==
X-Gm-Message-State: AOJu0Yxddr/oqynfAknNM9+td487vDtctwtkFq7Y1xbJmhN86KVqjjyN
 I+dOFgRSIwij5x33UojqTG9XIFbvzNAvsAEPDHbss2ZoXEwF5BSc8lBZKLykVJnmRTvMwf3v5az
 1
X-Google-Smtp-Source: AGHT+IHwuvebxgZaX3nPwlCy9vfi9tPjsJPtUQYGi5V/cqQf9DvYjIwJwpP61R+qjgYpWztCNyKgIw==
X-Received: by 2002:a05:600c:2e04:b0:410:a039:ed5d with SMTP id
 o4-20020a05600c2e0400b00410a039ed5dmr5953078wmf.33.1708946078313; 
 Mon, 26 Feb 2024 03:14:38 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c020900b004104bc8d841sm11534200wmi.13.2024.02.26.03.14.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/15] hw/acpi/ich9: Restrict definitions from
 'hw/southbridge/ich9.h'
Date: Mon, 26 Feb 2024 12:14:02 +0100
Message-ID: <20240226111416.39217-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 6205de6046..4c75d1b56b 100644
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


