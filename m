Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD5CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOsK-0005aM-LO; Fri, 08 May 2026 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wLOsE-0005ZO-9y
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:20:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wLOs8-0002Jl-A7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:20:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso19581365e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778260817; x=1778865617; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BsbHoEJcJuoOcOaQjLPDPue9MZ/rjEaInQhqVEyJR4U=;
 b=MJXHKi7EUAScPqctf0Fzyz4GEZDWob//4x8Fl22TykaGCpUvmg2IYZpICtyYp/k8i1
 enWg0GB6STYfon9bC79AfgzyFFFZgCO03gMIvuXmBJBOkDP6CFvEXOSR7Q9yYQazgnP0
 R7LozaJondmYilWro/4RoHGP6RdX0i+pOuzwSYvamMPFCUAq0MXFhNNvI92cxizVOjG1
 q8awM8EbM4+/zPAN1fQvF/I/kohs8kidsJBTGJlP++XR4ui6wyo23tqtPM3Ac7l/mWps
 Zzbz/SlejO8IcU6ZfXsueUmDGW5QT8F+gX8D1oUIIZweef6kG0pP2bB74YO4wGmrXZQ8
 qOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260817; x=1778865617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BsbHoEJcJuoOcOaQjLPDPue9MZ/rjEaInQhqVEyJR4U=;
 b=IVPLC0ka8d44Z8Ci4vlhczog1pOlKUDKRffNN8aygUjrlG/1ljxyhAmxjUNu/FT1tK
 Ls+9EXnuUzqhY/Qo5dpSOU2EZcmNHmOw1t+/6StjZEhpROWp+IReDgPwYRzF1/8UNjZa
 rfnnfaKbSI797rtmYQU+oDW9QopXsQOmheBQVWy1WLP1AE7e5yU9oF/fcI+48EOB5o2u
 Do7VE6qSWMfkix6xxYCtofuwy+zHRITIFYBkXL8qyxz8iFGtivNhS3Kh3j2RKoq60frG
 jseJV712oi6oizAF+xeuR6do3tZWxKrGf0sfawlWD36is3yfQInLge4j6NEcw/bxOE6A
 UgVg==
X-Gm-Message-State: AOJu0YyHZIptvW7IkChj8R48YrBBOgyOOcAbDTS+Q1S7LEmI3dBtvY1J
 7uDMG4BmlytZXhkAm2ChYRoTewgeXAS/Jdjnz5BTvBQUvQTIhUxEt6tFdQGL6YDXNJpxe27dTvI
 knTjG
X-Gm-Gg: AeBDietJtUlIuiYRhz2fR7umM4od41MCLqyHlKIidOkEF+ZsuH51QcmMfkIXihtCfYT
 lm4WGDjXVINOxW8O/RIb7kGyyDPRbSvDUsNK+hW9Jbp85MUz2XDeVAlZXBEF5x/pMPyVtX4AQGR
 7YASRfBSDxp7+H+Y1r892WmzXJsM4P4X4iAfq2uHPbQyPNRUVYzRpY2gMmceJoGS33wNfzh5FQw
 T4wr+VGtvzrOOtvB/bMGoamT04mZCsV9lRn7wyEhaNP/9s8LITSBo/qzzGoVVDXC+y7zvBWvuKk
 HI0d7ySBzaIJ8/x+jsvNDL0HfFzdqvQoF57y0eBM3OHjasXLzpUFyg3GPBAqgZcepFrhodVQnL5
 5INQt2ziR8OieFZwZkk0Mf5k3HEdgtnIRTugLyPY3aVbt2slWemHZ1LxNbujMMYZETvkGnUEKB9
 sCC5IQ+z3El6369IAC+p0uRgMNr72Iy4yMjEDhjw==
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48e51e0a60fmr205763315e9.2.1778260816967; 
 Fri, 08 May 2026 10:20:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:e47d:4cf0:1918:bbbd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6dd2c550sm9516965e9.3.2026.05.08.10.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:20:16 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 08 May 2026 18:20:14 +0100
Subject: [PATCH 3/3] gpc-test.c: Basic test for granule protection check.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-jmac-gpctest-v1-3-e57e42c87e1e@linaro.org>
References: <20260508-jmac-gpctest-v1-0-e57e42c87e1e@linaro.org>
In-Reply-To: <20260508-jmac-gpctest-v1-0-e57e42c87e1e@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x330.google.com
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

* Sets up granule protection tablers
* Installs the alternative vector table
* Enables GPC
* Performs memory accesses in the protected region to
  check for allowed and disallowed reads.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |   5 ++
 tests/tcg/aarch64/system/gpc-test.c       | 125 ++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 60c65f4969..90630e95dc 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -71,6 +71,11 @@ QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -
 QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
 run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
 
+# gpc-test needs EL3 and RME
+QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
+QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
+run-gpc-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
new file mode 100644
index 0000000000..fae754a56c
--- /dev/null
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <minilib.h>
+
+#define ID_AA64PFR0_EL1 "S3_0_C0_C4_0"
+
+#define GPCCR_EL3 "S3_6_C2_C1_6"
+#define GPTBR_EL3 "S3_6_C2_C1_4"
+
+#define VBAR_EL3 "S3_6_C12_C0_0"
+
+#define get_sys_reg(register_name, dest) \
+        asm("mrs %[reg], " register_name "\n\t" : [reg] "=r" (dest))
+#define set_sys_reg(register_name, value) \
+        asm("msr " register_name ", %[reg]\n\r" : : [reg] "r" (value))
+
+extern void alt_vector_table(void); /* From altvec.S */
+extern volatile uint64_t exception_log[]; /* From altvec.S */
+extern uint64_t realms_gpt0[]; /* From boot.S */
+extern uint64_t realms_gpt1[]; /* From boot.s */
+
+const uint32_t gpc_granule_size = 4096;
+const uint32_t gpis_per_64_bits = 16;
+
+int main(uint64_t sp)
+{
+    uint64_t out;
+    uint64_t pfr0;
+    uint64_t gpt_base;
+    uint64_t rme_status;
+    uint64_t currentel_raw;
+    uint64_t currentel;
+    uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
+    uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    get_sys_reg("CurrentEL", currentel_raw);
+    currentel = (currentel_raw >> 2) & 0x3;
+
+    if (currentel < 3) {
+        ml_printf("FAIL: Test must be run at EL3 (it is %d)\n", currentel);
+        return 1;
+    }
+
+    get_sys_reg(ID_AA64PFR0_EL1, pfr0);
+
+    /* rme_status is 1 for RME, 2 for RME + GPC2, 3 for RME+GPC3 */
+    rme_status = (pfr0 >> 52) & 0xF;
+    ml_printf("RME is %ld\n", rme_status);
+    if (rme_status < 1) {
+        ml_printf("SKIP: System does not support GPC (RME=%ld)\n", rme_status);
+        return 0;
+    }
+
+    /* Configure the level 0 table for the first 4GB of memory */
+    realms_gpt0[0] = gpt_table1_addr | 0x3; /* Covers GB 0; table descriptor */
+    realms_gpt0[1] = 0xf1; /* Covers GB 1; full access */
+    realms_gpt0[2] = 0xf1; /* Covers GB 2; full access */
+    realms_gpt0[3] = 0xf1; /* Covers GB 3; full access */
+
+    /* Install new vector table */
+    set_sys_reg(VBAR_EL3, alt_vector_table);
+
+    /* Pick a random location to read inside the first 1GB. */
+    uint64_t fault_location = 0x10202008;
+    uint32_t gpi_index = fault_location / gpc_granule_size;
+    realms_gpt1[gpi_index / gpis_per_64_bits] = 0;
+
+    gpt_base = gpt_table0_addr >> 12;
+    set_sys_reg(GPTBR_EL3, gpt_base);
+
+    /*
+     * Default values:
+     * PPS=0:     GPC table 0 protects 4GB.
+     * RLPAD=0:   Realm physical address spaces are normal
+     * NSPAD=0:   Non-secure physical address spaces are normal
+     * SPAD=0:    Secure physical address spaces are normal
+     * IRGN=0:    Inner non-cacheable
+     * ORGN=0:    Outer non-cacheable
+     * PGS=0:     Physical granule size is 4KB.
+     * GPCP=0:    All GPC faults reported
+     * TBGPCP=0:  Trace buffer rejects trace
+     * L0GPTSZ=0: Each entry in table 0 protects 1GB.
+     * APPSAA=0:  Accesses above 4GB must be to Non-secure PAs
+     * GPCBW=0:   Bypass windows disabled.
+     * NA6, NA7, NSP, SA, NSO are all reserved values for GPI.
+     */
+    uint64_t gpccr = 0;
+
+    /* Switch on granule protection check */
+    gpccr |= 1 << 16; /* GPC enabled. */
+    gpccr |= 0b10 << 12; /* SH = Outer shareable */
+    set_sys_reg(GPCCR_EL3, gpccr);
+
+    /* Access some memory outside the GPC forbidden region */
+    uint64_t x = *(unsigned int *) (fault_location + 4096 * 16);
+    ml_printf("Fault address: %lx\n", exception_log[0]);
+    if (exception_log[0] != 0) {
+        ml_printf("FAIL: Memory access was blocked by GPC, "
+                  "and should not have been\n");
+        return 1;
+    }
+
+    /* Access the GPC forbidden region */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_log[0]);
+    if (exception_log[0] != fault_location) {
+        ml_printf("FAIL: Memory access was not blocked by GPC, "
+                  "and should have been\n");
+        return 1;
+    }
+    return 0;
+}

-- 
2.43.0


