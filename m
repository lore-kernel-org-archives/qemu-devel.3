Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EAFCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgj-0001ar-FJ; Fri, 29 May 2026 07:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgh-0001Yp-0V
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgf-0008CR-6b
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:38 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so1139129f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055256; x=1780660056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GFBRenfOuA37ru0m45qaD8VsAzhwbebsBqKnduTUijI=;
 b=nNuc7rZ2PBRfXcayadLdT129Xqj5jJlcUcj77Da6ytcllx6PAia0gQpXRwduI0+ujM
 0wtqYfmGQb6+tqeFCAxLCgd6uem8orYoJGFPVIyJNs1RraDgT5eCwaPZCK+Hnq4Zjtj4
 1b0W208JAX3klaz+Hw8eP7953OStQDf8ufQK2KIUyF4OF/SvaEcXbJ4vVcCxxlAZY+F8
 q60INkahyg5xYC/l3ciEqdh2w3DSE3DporXkL1eDi2ay90VdbC1kmRhCMa/w1aEBrHK2
 CLHxKoGmI/yw/qy/5cswr26PTEnxprA5vwnnBxdDIfGpGtL+SOc8Ju6lcf96faajS4C1
 TCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055256; x=1780660056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GFBRenfOuA37ru0m45qaD8VsAzhwbebsBqKnduTUijI=;
 b=PM64b5C0yssMM3KbW3ZX+vksF+mXTB0E1TJbZKCVr6o1xCFmXSZ1LAV71Z4p9ZmyU0
 Ix6xE+4NDg+xfIix6aozIMZgdn4i6khsbVrJCSg2ITy+c/JiRiWqdwMB7gtOZXeGCttM
 tnsNQ8SAN0lii3j00Y5yIO08nYVAEkq2SaXkqZAg/OWoQwNTwj1+Zt/LV9WI4Ibz7GZy
 ep3xNFc9HwV0lHDmaZnDFgTX9yDaGuAsy+gKB39HA/NTxJIJNJjBG67A4CcFYb1mwb/o
 FDkO1zIMQIwATGfeBy/Kr2V8YlAkXoo40UOUq8qe5lM7qmqh5C8CSXA8DTE2/qEhgINv
 w1lg==
X-Gm-Message-State: AOJu0YwUk1OXz7AOX9nX//oEMBhzcHNwouVo5Hqf9KgmKxo/TLaxwp6a
 So8njBLsvAQRt2cUMZVjm0NcaUusoSWytZIov4EJoZ4g/PUfkcYQOIGl8Nyr5vxoktuMjJggUiN
 qNwiz
X-Gm-Gg: Acq92OFbU9uD2urjL5D9Fe1Kr3zTyD3Hb7Qt2GALlOpOwbGgd9YhTieA7hepsrQDUyj
 58pLbcgctuy0IX85tRWyupchgCh9fEhxPkYZP/Ka35eNwy3uop/+b3pxAadqTIc0aZosFdAlGcI
 wMthDWdY/pkldJoDMJfaRm9RlD95jrnII4DRBFXccCwgqtZ+XDUaf3nJWSS9cS3Plw0LtqPPTPQ
 GO6lkmG8cnRHIM/L64rLxkamGx7kXxn/KNFkVR0fHspVS5fUk5fPntmk6FYI5awgUDH725xITgd
 B1x8MnZvq17oNBFdK5YEdR+ALJdLtWDaX8OBdjHHFnp78B2PYtSuvAdBWQis2nEFSn913OKEfhR
 0hoHnoLjlwxkoX6uNf0rw5ZgbOnB4otixHdSrcQmfWW2z7pWOMSlMJyMeRoJ9r+R3pnAEq/cwUo
 /rgg67Iz+EJvm7/u/dsmeso7VE+iEIRM6MERsHFOJ0EschngIWhzk4Y9e1SDsAnjVSiQATeRaak
 5/Q80KVMJ7G4Aaeza8XL+UJlY3p+OhfHtbpH3/PZWlUKsSzUtcX
X-Received: by 2002:adf:e5cc:0:b0:45e:742c:f195 with SMTP id
 ffacd0b85a97d-45ef140c1e1mr3176707f8f.12.1780055255654; 
 Fri, 29 May 2026 04:47:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/21] hw/arm/xilinx_zynq: Split xilinx_zynq into header and
 implementation files
Date: Fri, 29 May 2026 12:47:11 +0100
Message-ID: <20260529114723.42040-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Create xilinx_zynq.h header file to expose ZynqMachineState and
related definitions for machine inheritance. This enables creation
of derived machines based on the Zynq platform.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260518073401.11279-11-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c         | 13 +------------
 include/hw/arm/xilinx_zynq.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/arm/xilinx_zynq.h

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66a4480cc8..6c83439017 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -41,9 +41,7 @@
 #include "exec/tswap.h"
 #include "target/arm/cpu-qom.h"
 #include "qapi/visitor.h"
-
-#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
-OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
+#include "hw/arm/xilinx_zynq.h"
 
 /* board base frequency: 33.333333 MHz */
 #define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
@@ -87,15 +85,6 @@ static const int dma_irqs[8] = {
     0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... */ \
     0xe5801000 + (addr)
 
-#define ZYNQ_MAX_CPUS 2
-
-struct ZynqMachineState {
-    MachineState parent;
-    Clock *ps_clk;
-    ARMCPU *cpu[ZYNQ_MAX_CPUS];
-    uint8_t boot_mode;
-};
-
 static void zynq_write_board_setup(ARMCPU *cpu,
                                    const struct arm_boot_info *info)
 {
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
new file mode 100644
index 0000000000..cefb7789ff
--- /dev/null
+++ b/include/hw/arm/xilinx_zynq.h
@@ -0,0 +1,30 @@
+/*
+ * Xilinx Zynq Baseboard System emulation.
+ *
+ * Copyright (c) 2010 Xilinx.
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.croshtwaite@petalogix.com)
+ * Copyright (c) 2012 Petalogix Pty Ltd.
+ * Written by Haibing Ma
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_ARM_ZYNQ_H
+#define QEMU_ARM_ZYNQ_H
+
+#include "target/arm/cpu-qom.h"
+#include "hw/core/qdev-clock.h"
+
+#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
+OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
+
+#define ZYNQ_MAX_CPUS 2
+
+struct ZynqMachineState {
+    MachineState parent;
+    Clock *ps_clk;
+    ARMCPU *cpu[ZYNQ_MAX_CPUS];
+    uint8_t boot_mode;
+};
+
+#endif /* QEMU_ARM_ZYNQ_H */
-- 
2.43.0


