Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC3ED1F9A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kT-0001QI-WC; Thu, 04 Dec 2025 04:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5kA-0001Ds-95
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:24 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k6-0003Sk-QE
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:21 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6431b0a1948so1129379a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840917; x=1765445717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDQJUrQzwQ5JOi2EX7Frys9dODpqxnEfpv5EfNFdo4A=;
 b=J89ySl6z1EDkevZk80qgeUx3u8zec3qIylU32/0gtxdNFag3TtVC9LliTcR3/sCdtq
 fB6Y111Rtl8Dz0pk/ohmX4fcNLGtZB5iPq9ojMGzyfL6IwC8iFnvh7y/iCRPhXYu6L1p
 PS5sn1ZvrQVft4pgmAaEo+sFVv6qLClW3SI5jgszJ3HpoOyGuCd7QinOL+XcgCbLhKhw
 9k2B0RaNk4bLDfD5k6K2ah4QkAOcMInNNeEz0NNq9LoQJbhVVugi027U3WR/NFhxRFyD
 JfqKpNMtFiYA7ADTMOcCpOC2ExnnXTLMjAAAXHL9wAWQHH13+H/RHRjuodfOxsp03hAw
 QIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840917; x=1765445717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YDQJUrQzwQ5JOi2EX7Frys9dODpqxnEfpv5EfNFdo4A=;
 b=J4V1w8XsdkGmJeIf/+2IMyn7k6XAEef43fYTQ+VlI60BE0zQXjjY/oFNrhFMe+JoG3
 qmU29c/Rl9KWn5cCnwHu4ntPyKYvlh/vM0LWkSl7rwIIeV8WCtnUIPW/hkkqgIBIbMHb
 rVN7Dtp7/da6kHslwTFq8Q1OP5VrcIb44B8hmY+92c11Wz9f0G8b/XJBfaRd8s91CtXL
 o1x8YFnNt0nHyJgd9AIBgVkKK7Nb3rXEdcOCJgRxgiUJ+1PCpBiI5v9ZxynuquJyIlsc
 +E7bOEMwM2eAtilNtH9Igi34gRZbMC/kyDmGtuyNW+N9fadQ4HxsX51JEfTucKG58sb7
 jSdA==
X-Gm-Message-State: AOJu0Yxy/Vkw1a1aorwvb3oXPSnrm5ZkUZEr+hKi/Jgx6c288TrJMqA2
 Zgtm64ZoduxBAQQLtISm+L9+cmiLKsHDNE+F+PkFdnfz6XlQ/PKML1WWv1z+sR37
X-Gm-Gg: ASbGncs/SnJ9pSexiwtgF8ZuJrckJqkqhRB44JZ4bDHzsvEGhTIjWialfQZKH1mPFiI
 hzqfXGX5Tp6CY+vjLXh25xzFbu6dCm8gkd1NvOfJbqAa6S+twlGbwYwv9jdmZc0GBg0c3MPwrbr
 47KzRienjdQtWvpefAAJBxBm8ZwEX3mOWoXYv2C7poUrIYIeBpGg/R3JSmmVcSwn1u0KjVBiRGU
 IUDsr2GnwwuwScHwqIkzDS05qlCwFNIcpvH9dUEeVoEmgBi11zjwhsDJ9QNC/c8Kvlnk+LXGCAr
 SyytE5ZhTSlSppi137t/k5pQHtT6pKpoOGgVDpolkMRu2HuMvEE1jFu1MwO/bVKMTmk2eyvrPdn
 mZ1kpLnwCFThFGUd0IJQay2qRKMJqfh4CWQZDOv69n+N/j5XuN1QP/IoBKo5LS5hooy2mEB4FVk
 2T3xThw9nY6fElL4XYpmhsQ7zhQZb+7dA=
X-Google-Smtp-Source: AGHT+IFq1Dj2cz1jPd1sM4YW1icb+M+nQwDN4Zgyx9JcbDECbN+4vyvd2TJyB3LCHde5Q7QFDa2PTw==
X-Received: by 2002:a05:6402:26c5:b0:647:5c87:8668 with SMTP id
 4fb4d7f45d1cf-647abda024dmr1934226a12.14.1764840917071; 
 Thu, 04 Dec 2025 01:35:17 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:16 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v5 12/15] hw/arm/xilinx_zynq: Split xilinx_zynq into header
 and implementation files
Date: Thu,  4 Dec 2025 10:34:59 +0100
Message-ID: <20251204093502.50582-13-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

Create xilinx_zynq.h header file to expose ZynqMachineState and
related definitions for machine inheritance. This enables creation
of derived machines based on the Zynq platform.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c         | 13 +------------
 include/hw/arm/xilinx_zynq.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/arm/xilinx_zynq.h

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c03ed09a67..4d095ab6f3 100644
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
index 0000000000..ec80441e7c
--- /dev/null
+++ b/include/hw/arm/xilinx_zynq.h
@@ -0,0 +1,36 @@
+/*
+ * Xilinx Zynq Baseboard System emulation.
+ *
+ * Copyright (c) 2010 Xilinx.
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.croshtwaite@petalogix.com)
+ * Copyright (c) 2012 Petalogix Pty Ltd.
+ * Written by Haibing Ma
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_ARM_ZYNQ_H
+#define QEMU_ARM_ZYNQ_H
+
+#include "target/arm/cpu-qom.h"
+#include "hw/qdev-clock.h"
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
2.47.3


