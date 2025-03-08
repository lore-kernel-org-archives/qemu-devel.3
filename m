Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65ADC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzS1-00077n-UE; Sat, 08 Mar 2025 14:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRi-0006mH-Pk
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:02:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRc-0003VC-2C
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:02:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1382123f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460562; x=1742065362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGeGYkd/RvTeD7MNw4buaroHbkJmR8tAE2eHN3vxKfs=;
 b=A1o1VRydyRsDAzvzUxpEwF3ebPzNa409/VY2s7KvKS5rr9X/c7rtlaQpQ3Jqs8mUAU
 Ety96WWOgZ3iPCOY6vWg0nSrBGpqU4q8eGNKRubXJP8WrjxOEEqhAYGf1jwCSMdyNoEH
 7BpB2zptxhuVbp8R7wtF+zPYGnDEwZSqxv/cKqLHnKOP+W0X3W+l8qr/oNSfjZ5BXAxR
 lDuWXQDSPBuXaxbUqdK/N+DSyVPm9IsMUw7WsHV1udbrasu9X9xBAOpSrFUh74ZIouon
 2LU5p92TsfcgdqAmYQnCyfyOZGlUHsB82WCz9MQjUIJ7FKtVwzlY5/cp/4KepmMFUXH5
 BayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460562; x=1742065362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGeGYkd/RvTeD7MNw4buaroHbkJmR8tAE2eHN3vxKfs=;
 b=jubIEX3HzzkfrUdHfssI1BWD3ZN9YBvhcJRX0VAckGmeQAjzRbauI+hTNIiVMkrDrQ
 5LA5mgxCqLfBevwsotuRotC6I+QokkMsUNnpmzndB/EfyB+Z783AMvOBecrv9jt+PH9Q
 9L7LY9eBbBW9F5KedOfn2xsFaNUMr/CIyHu97vNmSVSWz6XUVrf2QWquIyottyX1MCB8
 23kWG76wLv6l+LOYCMzdP7OzwS//bUaB6iNmMu5wr+gzYBYIwRmS25NUJRptdPLnQV6E
 /psbVc2vCLb6qrkWOQl3Q14foB7lFXdeZF2CF83P713IYhvJoSiyC8FfRwEkUzkQY/bn
 9gcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTUmSwkFKF9tv3e21o9oPyk1N7QjvNyycivTxHBlORQ9SXJcHq1Hdqz0mP4J4VYscYAaqF+FtUGdSj@nongnu.org
X-Gm-Message-State: AOJu0YznfIylC4WPG37SIn3QxFfjiMbztN3uN1/u3vweY/c6STQrmoT8
 bTDLU9jswMZJnNP+rQQXA5eb7Ukrt0vbfKhCHQJchVVj0c88zyQlje1dYxwXtqo=
X-Gm-Gg: ASbGncscUuut7thAWcZ0jD2aUbWxuBsD73r5uq4PRSQ15hothGJ1+NEGxfwsEE9Ni0N
 SzNdHUZge6pddFiVNr+CWVaFvKgXYJ0MVmSNobHjP5A96AzZmRAXgo0/GzntWhTTpIakA2oDATy
 07B5NHqrjYLkduKEEviqH4KM9aTBHc+/fXQ8wPgR6+5RQkkCodz/W+HvzG/plesmZDWGCltniFt
 1SQBDHzyr5Ek+QNcoCgh79/nIte6Xm8BFnE3yQI977rrxufXIfkjKxOXafe4Hd2ShX6FPmz4NYn
 +zrjPgM6bKqwlXCHJYEEuO5KvQt/fTQqrX/Vd3clGCtzgSnPV+60KiQdVFQDyklkIrw1gLtYzUT
 n7X1n2UGSEhOtIMc6YqQ=
X-Google-Smtp-Source: AGHT+IEo3Pr2KZeNLe6d0rZaM7CvWCMMcLa33zM3zoeEoALypWKDmNel4OzWR5ekP2tJmWHckZ72QA==
X-Received: by 2002:a5d:6c6a:0:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-3913aed81aamr2276681f8f.4.1741460562232; 
 Sat, 08 Mar 2025 11:02:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce9f2d081sm27971865e9.21.2025.03.08.11.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:02:41 -0800 (PST)
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
Subject: [PATCH v3 02/12] hw/sd/sdhci: Introduce SDHCIClass stub
Date: Sat,  8 Mar 2025 20:02:20 +0100
Message-ID: <20250308190230.7508-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
to work with both SysBus / PCI parent. As this is not a
normal use, introduce SDHCIClass in its own commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 9 +++++++++
 hw/sd/sdhci.c         | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 48247e9a20f..c4b20db3877 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -107,6 +107,13 @@ struct SDHCIState {
 };
 typedef struct SDHCIState SDHCIState;
 
+typedef struct SDHCIClass {
+    union {
+        PCIDeviceClass pci_parent_class;
+        SysBusDeviceClass sbd_parent_class;
+    };
+} SDHCIClass;
+
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
@@ -123,6 +130,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
 #define TYPE_SYSBUS_SDHCI "generic-sdhci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
                          TYPE_SYSBUS_SDHCI)
+DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
+                       TYPE_SYSBUS_SDHCI)
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 149b748cbee..4917a9b3632 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1960,6 +1960,7 @@ static const TypeInfo sdhci_types[] = {
         .instance_size = sizeof(SDHCIState),
         .instance_init = sdhci_sysbus_init,
         .instance_finalize = sdhci_sysbus_finalize,
+        .class_size = sizeof(SDHCIClass),
         .class_init = sdhci_sysbus_class_init,
     },
     {
-- 
2.47.1


