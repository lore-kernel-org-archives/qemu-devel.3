Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43381C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1T-0002gR-IM; Tue, 15 Jul 2025 02:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1J-0002Uj-Fe
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1H-00077E-0b
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4184325f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560401; x=1753165201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuDzbbwm2kJEj0yYBiGbuSIbCM9/3TFQdYicUYRD+Aw=;
 b=db9iws1+3pd+XR1Uplo6GtO9PTR7wI9gYJqGOuuWDzyRua4PJezdlSXIr7vGUf1v1m
 ilqaNw7xLXvcI4VfqTqTH6xi6sQZ2WbFENbgzbZzJxumlDJQ4ZY4o3PFvOVobB5HZM7D
 mqY2qjaVWWJXnU8Q7LjQeIhu6q1tMPhPdQFtBC1Lc4xRUvoHmiXoxKvhQS/iyZeYrx5H
 AY2aZHhygVKMesLDqpqM/BIe7b+5Sq1srYB1QYj1WQQ/A0mMeUXP6aEP8F7pq/0BwGg1
 xze1RlZ6tM8nCmMGHEuGhaUa8RlQnDwHkfWt3L/vph4Ja457sNmqGBFvddB355sRrRa+
 4cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560401; x=1753165201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuDzbbwm2kJEj0yYBiGbuSIbCM9/3TFQdYicUYRD+Aw=;
 b=dRR08b/1r5GjSMSOma4t03TQdKJFwCDbDKwyJjDnTKn+JN2Gu8HEOfBf/TkelFzL+t
 wEUSMT26bf0owtuiuMHsAhPySLegyNNh8tCipzn3fBM5oblqWpZkLQyd0U53RAEdAjTO
 AoeRUcXjWt7oDIhCy5+K6hCdSGpr0zcGwpoc8COZ36MS5nzI4/j1FpNxD5ecJBo6x1qn
 Pp12AChgZ9UZmJlb9FlIEb2Do/fX3PmblYxbUpBqbv3LI2nkjb3jE7H7Li3YFcCiW1mB
 6TXCprDGamk/yn7dLS6uAAAGe9hyBM5FNvVUkYk45dhqBZYRiH7ycsYaZ+ICgItN96/g
 T+Bg==
X-Gm-Message-State: AOJu0YyVX/GxDivZNVdEcL6AZmZO0/ZuryRfWZXHk2+odaHTAGZKy/Kr
 j0NXHK/ikKPDvfOdFqDV+HKXVY75jSXNt4eHTXrP1t31PqLjX8Ia+1J7uo5fqPSKpkgTZM106WQ
 /EHW5
X-Gm-Gg: ASbGncsxyos6ow69nVZZQzWKNFRgggKbcaMPnkn6LggbEid/1sHqdosBkkIrAcluM34
 sDKT/1qduN/oRT3saSOupZ7CQxJ9pvX117/HGHjLS5kSfX5ba3ftGN5D7gfwA+vckGsO7rP2qP5
 sLKv43IT719NF2Gy+wQjFXbRIUgdf9XViFhHmfVDdI5Oxe+b/TaDRDiJnr58H5ekSfsO3KwDbSj
 RXuumtg4rmZLDu76Tr16z85p6vTzDU7UqBWTpxsPH/G5UYW945BxARsv6q/UW2pRPE1h07MbUJb
 /T+rKbeIagNtxzxA3hNO3Ts55hQ0Bh8ewFM3euqcFCeS7XFGJk+8a3+Bl0h+bAqjsnlisK9vKj3
 L6V3kCOdLPqWrHYTZpHRpoD3zS6/UPfYJF3dwU32rhG5Sx5hEbHjx8qVdqLng1b87wrNW1Ds0
X-Google-Smtp-Source: AGHT+IH803WUgSzhwZmoBVziYExZUFLo7kt21Qg3JYwpUOp8Dq+pGXMaoNAfdekHb9avXTUDhLvYvg==
X-Received: by 2002:a05:6000:2410:b0:3b5:f0af:4bb0 with SMTP id
 ffacd0b85a97d-3b5f2dd1547mr11682036f8f.23.1752560400824; 
 Mon, 14 Jul 2025 23:20:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43912dsm153473015e9.2.2025.07.14.23.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 08/17] hw/mips: Restrict ITU to TCG
Date: Tue, 15 Jul 2025 08:19:08 +0200
Message-ID: <20250715061918.44971-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

MIPS Inter-Thread Communication Unit is implemented using
TCG. Check for TCG both in Kconfig and CPS source.

Fixes: 2321d971b6f ("hw/mips: Add dependency MIPS_CPS -> MIPS_ITU")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250702164953.18579-1-philmd@linaro.org>
---
 hw/mips/cps.c   | 4 ++--
 hw/mips/Kconfig | 2 +-
 hw/misc/Kconfig | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 2a3ba3f58d2..e47695e2b0a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -24,7 +24,7 @@
 #include "hw/mips/mips.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
-#include "system/kvm.h"
+#include "system/tcg.h"
 #include "system/reset.h"
 
 qemu_irq get_cps_irq(MIPSCPSState *s, int pin_number)
@@ -59,7 +59,7 @@ static bool cpu_mips_itu_supported(CPUMIPSState *env)
 {
     bool is_mt = (env->CP0_Config5 & (1 << CP0C5_VP)) || ase_mt_available(env);
 
-    return is_mt && !kvm_enabled();
+    return is_mt && tcg_enabled();
 }
 
 static void mips_cps_realize(DeviceState *dev, Error **errp)
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index b09c89a0175..f84fffcd323 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -76,7 +76,7 @@ config LOONGSON3V
 
 config MIPS_CPS
     bool
-    select MIPS_ITU
+    select MIPS_ITU if TCG
 
 config MIPS_BOSTON
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c27285b47ab..4e35657468b 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -119,6 +119,7 @@ config STM32L4X5_RCC
 
 config MIPS_ITU
     bool
+    depends on TCG
 
 config MPS2_FPGAIO
     bool
-- 
2.49.0


