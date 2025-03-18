Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2554C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWkk-00034y-Vp; Tue, 18 Mar 2025 09:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWji-0002Rw-NZ; Tue, 18 Mar 2025 09:12:04 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWje-0003wE-SC; Tue, 18 Mar 2025 09:12:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2b10bea16so488193166b.0; 
 Tue, 18 Mar 2025 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303516; x=1742908316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j23N8vOYcpKi67Cqo7/zZHv4kG2whHLTAlH6+ZbQMt4=;
 b=OHyI+t1Z1z6qmjTOVhElGWF1DdNhKsWTYn55QGpZ8wWCnXr+0i8wfKdrdJo5uPPBHW
 eowWM2MgP3l0fiLEDS91cI0Bo1F7spSdyGUCnRv4z53S3TE3/yTTOYGdX9/IMoLJQYCT
 mcn+GROXhSka3NVc4+W15adFcSmJLu8MdPmSPSS+OvN0VfeN6PqEI9RXDBkRXUtUYRqO
 QQIon+2kmOI3h7+JgeeDVN+RltcTIseNL+97ji1PpXkZS/AuZjvvbvOUEdvgqL0ypatB
 pqxs0ASFcc8t3wPtGVSwMeEzdVFo8Kqpt1N4S8dY+HYzFI/AZ5y03Esl7UXNn+rmoBMY
 nktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303516; x=1742908316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j23N8vOYcpKi67Cqo7/zZHv4kG2whHLTAlH6+ZbQMt4=;
 b=hOsTXYOOG1N4tWU0oyZ8728Qg/XsVEvWgp7fuqBR302GTvcwr9mlWuKvQxYMTGGU4G
 qWcjPGzIHTSrtRc/cn2FDQl9GOb8p4Xio06h4yNzHFdcZBF+uzAatfHyC/UVF1CMeRtm
 vqaUzuC5P1SYH0pzMnjHGTaKZFI5c2GsSv+gBdjTB168rFnbVMTB76WyHmN7N70z5W0k
 4j1wPrLZfGjLEFzNP1pJbAh3Sk69dbkKUG6nCvNCa258KEoTfDmYr/FdFpmdcmKOivCL
 qk0WVXJT0CzpCQSl64bFfjpu74Ii13OvBVYOcYmRUqjh7p4C/EWRVOw/zFE1VZYF9Psj
 dyEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Yt/c7a8r0nk+9McJgx0Bp2AjJz2vA92xnsKXYN5j6i35cI7JBIFYJ1gp7OtZolm0eppct2Efgg==@nongnu.org
X-Gm-Message-State: AOJu0Yw/nlYkAU1l6dTglQtKgIhY0TIQStUHpBABbBF2zYtbQMuLzFXw
 8x7cD+4fSjr4sMCRe9cu7oCKL/S+zoCrt0zYTJbU/JQGcHbd1daRj0/7qKDT
X-Gm-Gg: ASbGncv6dfX0icDAfTanyr05/T8tWaYLj4hp2iNJ59s4BQP7hfyJfghkYYuw/D/PHCS
 QxJAjlpW0GDQr0DZ6bnZHKeQwddeZyvqE8Og9EE2qmOBD9ynAqrbKEifahNHcBmI4Q4gTgc7AuX
 t9zB6frdV01W3G76v/H68VK0DIy/VCIWjSX0bCIaLAUIFORVBpNFErgJXG/tCbhzufPE1m6lStQ
 t7DO+TmVkZFc/lTNQiUYUT4XsabOJXZotBWnPjTZibu3Vbck9lsQ3dtBCtBFkALzU2zk4TgDLCS
 f1Bhn9gTgGEXh5Y6YDLj3arwnHKOxVIg38Pd93lHAj6mEq1UBO3XAuSp4QUOFQxpZxQ=
X-Google-Smtp-Source: AGHT+IGGPWxnh0QlL4IU2qsLSPRZbfU8RQ7chA6yMQvIMv4KyCTLXafg6SP2b5xW3TltQ86sf0DFLg==
X-Received: by 2002:a17:906:d554:b0:ac1:def4:ce20 with SMTP id
 a640c23a62f3a-ac330188c47mr1531992666b.18.1742303505310; 
 Tue, 18 Mar 2025 06:11:45 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:11:44 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 16/21] hw/arm/beckhoff_CX7200: Remove usb interfaces
Date: Tue, 18 Mar 2025 14:08:07 +0100
Message-ID: <20250318130817.119636-17-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62a.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

The CX7200 does not support usb interfaces. That is why they
are removed.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/Kconfig           | 1 -
 hw/arm/beckhoff_CX7200.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8727b3e837..a8648b9edf 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -322,7 +322,6 @@ config BECK_CX7200
     select PL330
     select SDHCI
     select SSI_M25P80
-    select USB_EHCI_SYSBUS
     select XILINX # UART
     select XILINX_AXI
     select XILINX_SPI
diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index 1e7152e871..efce3be395 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -28,7 +28,6 @@
 #include "hw/loader.h"
 #include "hw/adc/zynq-xadc.h"
 #include "hw/ssi/ssi.h"
-#include "hw/usb/chipidea.h"
 #include "qemu/error-report.h"
 #include "hw/sd/sdhci.h"
 #include "hw/char/cadence_uart.h"
@@ -280,9 +279,6 @@ static void beckhoff_cx7200_init(MachineState *machine)
     n = beckhoff_cx7200_init_spi_flashes(0xE000D000, pic[51 - IRQ_OFFSET],
                                          true, n);
 
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
-
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-- 
2.49.0


