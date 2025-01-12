Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723CEE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Ju-0003sk-OP; Sun, 12 Jan 2025 17:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JS-0002q3-9V
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JQ-0006bb-Ca
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1818423f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720402; x=1737325202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEXTfVWwEyfI2ErBw07cb0pz0mwpOOYlmcjjIUHCrbM=;
 b=cwV/jg47TslB2qloUXHBRbQP70zhivWhEnKsfoH2crsavZOGsqMYm+2UyrsZ7BpdoE
 ssBTdEntwU/1bNeNAN2nMRTtLb1ZcyjgORIyb3ptc3R2ioVNRjoBqbsnjIgLKgwxRi+u
 fMj1TJcUg0CuvFfXvZAjmdhxLzePynB1BG53G+ltP1cI5xbddc8sE0TBSytgAFOVkNMO
 Ql0B+zlD+NaSf+xV0dMEKSHB85jCG/nQlJUMrgJoFjLY4FDREspjFfRTWQF/DeDw0ejc
 09S4kjswpFBNhqLWE8U8wLWNxIPUYaTq8G/VNLLnT+Q1GyHLvlIayRWjnkZV3Ka2ygt3
 xvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720402; x=1737325202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEXTfVWwEyfI2ErBw07cb0pz0mwpOOYlmcjjIUHCrbM=;
 b=Umkv4bTrvrdAjrh43lX6KICNStfOO0DxzAxCuHBQIxCr7RPucWVTcg0DzkdWJg//sN
 Sq36hvCDlzQM/BH/THvBJStNQR72IANxaHj4drs+1tSQe+An7tVB+YMC8jjQX6P0wpiA
 Jr4ZTIwFSZM13ibtqiEzp4r9ZjMwaxM1spmuLIs4XnR8m+8Vhy+YVLPFalEIVItQyDp/
 QivM+hMMDExfGX8dEiimybbdUX8bbn8CrUmEjGXxyVWOU6WLGFf18IK4A9FB1jZVPYZM
 CcUJcTdMwUd3jnIXdRnAixTAVCCSKo8X6EA8xy2SaBfX4D86UdGJbB3P+WiSvSVpIhaM
 0Oow==
X-Gm-Message-State: AOJu0Yz0U39Vb2X2f6tIeK6/DybWJqw3qid1ndUvfhhGQtbB9dnoyMRA
 MCtg3khpxzciLnhvJO4omwPtOcdynfyaPKlQEMhvWHdpxPU5CW5AOTaTn6rgRMIhM8uOAE5K/+w
 xRdU=
X-Gm-Gg: ASbGncvEOZXZqeykhgFU/jUoRCRv7Qc3tMLnKk4IPDOYLtojsELDBFZgiyv++Qc3O3E
 k1spjWOENa2kqu1vdmZSO5hpSaaZ+/sEKmm6RGYAE0oCVH4dxhUPajOYT5dvhRxpASJhPWgZWwR
 4dTk5D49GLcPg0QpUEFeJfaj/46Ue6XXPGvH8Rrud3fxZu74ZnX1VArPKHzMe7p5A2XhOUdZp06
 XGLh/bWyRlhBONH4bQdlYpbNZiTd68SB8J/q2YzOXHNH+YQufgpYaez2yADUjpll5bnyUNUazC1
 WxP0Vu+OwC9KTeBu5pv70n/1FVF8AOQ=
X-Google-Smtp-Source: AGHT+IH0sxNS3MkqOFhK1T8T4utheH4Pc0jgSnN6uYaLCq1oKltdvYg/8Q6uo4efiWa6a6/zuej+Kw==
X-Received: by 2002:a05:6000:1a8c:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38a87336f7amr18319885f8f.44.1736720402251; 
 Sun, 12 Jan 2025 14:20:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e36asm10377281f8f.5.2025.01.12.14.20.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/49] hw/misc/imx6_src: Convert DPRINTF() to trace events
Date: Sun, 12 Jan 2025 23:17:07 +0100
Message-ID: <20250112221726.30206-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108092538.11474-14-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/imx6_src.c   | 23 +++++------------------
 hw/misc/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index dc6a2b92ba4..06cc46292ed 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -17,18 +17,7 @@
 #include "qemu/module.h"
 #include "target/arm/arm-powerctl.h"
 #include "hw/core/cpu.h"
-
-#ifndef DEBUG_IMX6_SRC
-#define DEBUG_IMX6_SRC 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX6_SRC) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX6_SRC, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx6_src_reg_name(uint32_t reg)
 {
@@ -87,7 +76,7 @@ static void imx6_src_reset(DeviceState *dev)
 {
     IMX6SRCState *s = IMX6_SRC(dev);
 
-    DPRINTF("\n");
+    trace_imx6_src_reset();
 
     memset(s->regs, 0, sizeof(s->regs));
 
@@ -111,7 +100,7 @@ static uint64_t imx6_src_read(void *opaque, hwaddr offset, unsigned size)
 
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx6_src_reg_name(index), value);
+    trace_imx6_src_read(imx6_src_reg_name(index), value);
 
     return value;
 }
@@ -134,8 +123,7 @@ static void imx6_clear_reset_bit(CPUState *cpu, run_on_cpu_data data)
     assert(bql_locked());
 
     s->regs[SRC_SCR] = deposit32(s->regs[SRC_SCR], ri->reset_bit, 1, 0);
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n",
-            imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
+    trace_imx6_clear_reset_bit(imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
 
     g_free(ri);
 }
@@ -173,8 +161,7 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx6_src_reg_name(index),
-            (uint32_t)current_value);
+    trace_imx6_src_write(imx6_src_reg_name(index), value);
 
     change_mask = s->regs[index] ^ (uint32_t)current_value;
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0f5d2b56660..cf1abe69285 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -253,6 +253,12 @@ ccm_clock_freq(uint32_t clock, uint32_t freq) "(Clock = %d) = %d"
 ccm_read_reg(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
 ccm_write_reg(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 
+# imx6_src.c
+imx6_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx6_src_write(const char *reg_name, uint64_t value) "reg[%s] <= 0x%" PRIx64
+imx6_clear_reset_bit(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
+imx6_src_reset(void) ""
+
 # imx7_src.c
 imx7_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx7_src_write(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
-- 
2.47.1


