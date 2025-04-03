Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A23C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTJ-0007PA-SN; Thu, 03 Apr 2025 19:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTH-0007AH-2l
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTF-0002cz-25
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso14782855e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724779; x=1744329579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WA+aRHvNoDByFG0pXYQNX38xTne48Zg59Pu/HsGsRuU=;
 b=fileE6QROhKFFSqZLylEa61UQLrze5n5FF/e8tvaEIv49nUQW2qSFQoQboQCKxB53/
 72KM18ai5fdoAmXef1W7Z5I17HAhh/aHoAWCncrb7Td4019vLzV2g3DPEmTy3Dge3YvK
 LX692Igo9CZidCKFy4uD2D+aV7HVqxfzLEXFC93MyzQwdo87gSpQnIYo+6TlihofrGP1
 vAwQ492fXnkzeaFjQGfLNnUStcwnDWzH6rmWWhoivU48q2CW2N9bcGIOZjARsYhc5p4O
 ysyTX8qNvMXgrLUDazOy+ICuXubOuVoIfvqADaa5UKooQCmBwKLtW2jpF1oWeNaYdpM8
 oiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724779; x=1744329579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WA+aRHvNoDByFG0pXYQNX38xTne48Zg59Pu/HsGsRuU=;
 b=AHe6OolxbT3F/umVnTDxy99IoAjAFh4XQmAma/vIig/w2jrk/g1nIXrUEzDFbXFiHt
 yc7sN9SycgzIVk226tGyrNV7fVz1TCgG9kIIjIEhjCBEczMSO+2WHVtp1sKm/KrkAAFu
 Y2NH//yJjfyXAOP4QfRXgGG0PsXVFS/gjPqUcKAL13NIr7XC+bWK6+OUmGZxfh8O7yM+
 qqkKfOFED7ML538mImbyI7cj5Mp93VSwJgv6acYBwS8XB7tuo+j4jt7Mu4Gp3azmOLQW
 xE6/MaqCUmCL1WrgovPR/xcV2QMgabYOLY3mn4VTYf1EQxp1cKZbN82f5aXI/ozYOhSU
 4rVQ==
X-Gm-Message-State: AOJu0Yz2bTzLk2sS5dPkiscf2/nfh1ILvXBgVX/2806HjNIgR+3Bcl3o
 XLGivTguVINuq5UFv2rmJ9t0n6DKdzoQNYXO9VSqbWba/ZI22NNOG+HDv/g/mp+XknSNovfUMN8
 I
X-Gm-Gg: ASbGncumb/BgZF+7u59OAI0974XL8BtfFO9hLx1/Z7mJ7GjVpH5kDzXWQNvJdu593W6
 rYU4/do9ujMFPR/ihsRMvFJe/jjLjZKgRbR4/LqEauTE9Xp8JNXk82AfipHGIq0Owgx8yYRMsWd
 HfVu78mXGejU0RQ1e/c7Gys9JcpKFRw6LUHPGEePo10jdmziYYfcdIzWEJm1F2dv++iuz0gMHdD
 N8W65lolezOw5tpK08om3ARMhCA7436yGLJqmoWGfgpJr1rxN4Yf+ZCCHUPFoQHXCJKxejTyTU1
 dqQMSPRkBE/KQ2LduGhLKmGUXr2OJeoWFZl/4GUHcgqgk0ppTcq5UDo3DDbgG63OlxxWcsG5CWK
 9AUD5wFJ9ipV1nofHQ+A=
X-Google-Smtp-Source: AGHT+IE1Q3z9pWqGifkD+P0jUOYvfmmPQry9vvoO0NvO7g6dPks5IqHFTbX8hwAlI7XJucDzt0U5UQ==
X-Received: by 2002:a5d:6d8b:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-39d0de25f88mr474677f8f.27.1743724778843; 
 Thu, 03 Apr 2025 16:59:38 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226ea8sm2937655f8f.81.2025.04.03.16.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 11/39] hw/arm: Use full "target/arm/cpu.h" path
 to include target's "cpu.h"
Date: Fri,  4 Apr 2025 01:57:53 +0200
Message-ID: <20250403235821.9909-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

We would like to get rid of '-I target/$ARCH/' in the CPPFLAGS.
Use the full path to "cpu.h": "target/arm/cpu.h".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/digic.h      | 2 +-
 include/hw/arm/fsl-imx6.h   | 2 +-
 include/hw/arm/fsl-imx6ul.h | 2 +-
 include/hw/arm/fsl-imx7.h   | 2 +-
 include/hw/arm/fsl-imx8mp.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/digic.h b/include/hw/arm/digic.h
index 8f2735c284f..646802806e0 100644
--- a/include/hw/arm/digic.h
+++ b/include/hw/arm/digic.h
@@ -18,7 +18,7 @@
 #ifndef HW_ARM_DIGIC_H
 #define HW_ARM_DIGIC_H
 
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/timer/digic-timer.h"
 #include "hw/char/digic-uart.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 124bbd478fd..0ac145cf6ba 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -35,7 +35,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/or-irq.h"
 #include "system/memory.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qom/object.h"
 
 #define TYPE_FSL_IMX6 "fsl-imx6"
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 4e3209b25b2..f8f9c249a23 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -34,7 +34,7 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "system/memory.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index aa7818c4999..6aedd2b80b5 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -37,7 +37,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
 #include "hw/or-irq.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index bc97fc416eb..f20f9e53187 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -9,7 +9,7 @@
 #ifndef FSL_IMX8MP_H
 #define FSL_IMX8MP_H
 
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/i2c/imx_i2c.h"
-- 
2.47.1


