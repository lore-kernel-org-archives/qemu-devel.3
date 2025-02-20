Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AED8C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Jh-0008Ct-MI; Thu, 20 Feb 2025 11:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Jd-00087k-Nc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JZ-0008I1-MK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439a331d981so9852075e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068536; x=1740673336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MBD+TT8mnodRwZqgq3dyoU33xacFSFLNRqCw2b4seEo=;
 b=fK/KLSu7loT0ah0ptk9aB2xBehkD3o7nZoXyd5TDL0IpjBE0YDz728SPA2DN3D1tNC
 grfVELXrWTx4Iki+/nVKCVFEf1AmOMwmraYl86MzzLYwk0MlQ+4tJoXhoy4aWF0qyEyG
 YWZRHC/4+18zITgIA9LA8bMr26yN/hCPQcPFl6g1i3Tnz+WH3IuLvdLyZfwV6tP/2ahE
 IiThMTvztwmubRtNj4uy80pOpJC6rNJSQZKW/tkgAywGBQQkJqwGJmNM5AQ/ADUJFCFQ
 nnRmca/5GAyBKMzvW5VvoxrYxWqy0PnB1T76tWQNPmNb6sKs3pZZ4C8167LB1MKKwMnF
 /efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068536; x=1740673336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBD+TT8mnodRwZqgq3dyoU33xacFSFLNRqCw2b4seEo=;
 b=rRUBZ/u8L2vLR9faFJ4xfUZvBsrPmUzecJYXJr+TNIyIkxnmWKlQKq8bjZf5SOZUEv
 P16ACISFYQf/4GFOZvb+f3yB8cjhauASwpc7rySp91zClhBg7oz9XB/4fvenSkA/jYp7
 YIsjns/ftAX9iFnsrvXjthD0Q9tUX1eLQgLRJUQGQZ9RFxrsF0sFHXrMQC5Pa7NKs08N
 yYuqZvT9d47/nWj4uG3vnz0HvJebN9kgyAJpNlSaPQt7vXANyIqbNdnPRwTokyAKkofD
 rSR9kFKZQWfXF5P5B00f4dSTioK2OQ+PSNtStuTw6V8dvio26mNbUQBuvFhj6cCIi1oD
 39jQ==
X-Gm-Message-State: AOJu0YwUxBtxxb9eArs66w20XMiO/lsim82ja55cc5c+HJgbkuiSNewo
 BCd/pTrDFy64/MWQMBbdHWhRRKC+Xp/gPvZEByyRo4N1VCGpUEIhXuQg1OF5zrgWL/9ApESACuB
 6
X-Gm-Gg: ASbGncvXQc66KkB2QJz9dy6iHVSroCHy806odA/qkCz3+ahhWTlN52HKW7MDcFjWXcg
 eWLbsT+QRsqKB0g5YRXc7qA6gT2WINdKDcZaAzNf3f7VhyxB3zZNg3UBu9UNFeKSsRIOw4gjEVu
 Od7LzLS5ukv9rBWpnvpF6/khXaIdo2Gy2jFqoBjf0gpIyXijfmnQ8uZkF4KHUm4/QDTfSeyGIMg
 f6O5kzjjy1aYxL2+xSf4v4qGisphFiFfZC1SXwAF05Coxpn6MVMgbJ/YwBBV471BFC9ILLd57tn
 gj2VC9zLl9Xb6gYYdgiOdQ==
X-Google-Smtp-Source: AGHT+IE1LOR7bX293JbUUa6rmBSKfcQzrQZdK7UZSsMO8Sp9H7Verh2rcbnHktZgRrVqChSL8y2/0w==
X-Received: by 2002:a05:600c:350c:b0:439:9206:86d6 with SMTP id
 5b1f17b1804b1-43999d8dda5mr92852635e9.7.1740068535836; 
 Thu, 20 Feb 2025 08:22:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/41] docs/system/arm: Add Description for NPCM8XX SoC
Date: Thu, 20 Feb 2025 16:21:22 +0000
Message-ID: <20250220162123.626941-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Hao Wu <wuhaotsh@google.com>

NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.

This document describes the NPCM8XX SoC and an evaluation board
(NPCM 845 EVB).

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250219184609.1839281-18-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst | 27 ++++++++++++++++++++-------
 hw/arm/npcm8xx_boards.c     |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 05059378e55..e4827fb43a1 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -1,12 +1,13 @@
-Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
-=====================================================================================================
+Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``, ``npcm845-evb``)
+======================================================================================================================
 
-The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+The `Nuvoton iBMC`_ chips are a family of Arm-based SoCs that are
 designed to be used as Baseboard Management Controllers (BMCs) in various
-servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
-assortment of peripherals targeted for either Enterprise or Data Center /
-Hyperscale applications. The former is a superset of the latter, so NPCM750 has
-all the peripherals of NPCM730 and more.
+servers. Currently there are two families: NPCM7XX series and
+NPCM8XX series. NPCM7XX series feature one or two Arm Cortex-A9 CPU cores,
+while NPCM8XX feature 4 Arm Cortex-A35 CPU cores. Both series contain a
+different assortment of peripherals targeted for either Enterprise or Data
+Center / Hyperscale applications.
 
 .. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
 
@@ -27,6 +28,11 @@ There are also two more SoCs, NPCM710 and NPCM705, which are single-core
 variants of NPCM750 and NPCM730, respectively. These are currently not
 supported by QEMU.
 
+The NPCM8xx SoC is the successor of the NPCM7xx SoC. It has 4 Cortex-A35 cores.
+The following machines are based on this chip :
+
+- ``npcm845-evb``       Nuvoton NPCM845 Evaluation board
+
 Supported devices
 -----------------
 
@@ -62,6 +68,8 @@ Missing devices
    * System Wake-up Control (SWC)
    * Shared memory (SHM)
    * eSPI slave interface
+   * Block-transfer interface (8XX only)
+   * Virtual UART (8XX only)
 
  * Ethernet controller (GMAC)
  * USB device (USBD)
@@ -76,6 +84,11 @@ Missing devices
  * Video capture
  * Encoding compression engine
  * Security features
+ * I3C buses (8XX only)
+ * Temperature sensor interface (8XX only)
+ * Virtual UART (8XX only)
+ * Flash monitor (8XX only)
+ * JTAG master (8XX only)
 
 Boot options
 ------------
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 19610483f93..3fb8478e72e 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "chardev/char.h"
+#include "hw/boards.h"
 #include "hw/arm/npcm8xx.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
-- 
2.43.0


