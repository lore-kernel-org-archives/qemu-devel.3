Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ADCD3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMV-00079I-3l; Tue, 05 Nov 2024 17:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SM6-0006fm-OX
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SM5-0004JT-4X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so50892425e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846935; x=1731451735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sfn7cm81gRHlzMkLVCOGrjRL5gmP+m5CKJ7vqtP/iic=;
 b=ATRx8l5pKW0PgFupOjzjzh6P0af7g5/gpWeYUlztUxck+iOCt4zjAvPBww0DrFmy3D
 blMiCHzfjnnQfe/IbRSgh1FmEqqyqHYQKCnRAkyEhol1fI6o+9rglVzct3I++CHiAbiy
 9iufu3JbT2TJjr7izV52mUV/zFEkkngrwmitOy2cqJgGXxLs7p8d9AhfqSN+wfznsuMi
 L+E47g6WY12+tVqZipgihnYMX9tH6guq1y9IXj+9Djg4kMzOKlixChxjRFdqBHxJQOkE
 ay8rjVkK3Og7Anu3aqtrMygX/1Gi9simJ6VWYinR5N9gOCvfjGabjTKwKyoZxHqj45oC
 bCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846935; x=1731451735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sfn7cm81gRHlzMkLVCOGrjRL5gmP+m5CKJ7vqtP/iic=;
 b=reuRFUep8/ODGgdugIsFJMDOvJXgEXI2UXi4kgf9itg6IgDGviKEYMXWLDUHW9DEe/
 CVr4oBxwzIbOe/JByrasLMEK4RBop5+hdOe+KK9O/Rskx3O/iQyKuwYLe/jCiSWDXFXB
 nu+Gu5p3h6tzF0NLKOllyMsMSDXaUgP37xVF3ksSDKC/IpuK3phd1qL024jvfHFLM4gH
 rEWhk1/rjUaEJCiMqBVNdojNhuD5j2qGYzJL3vzfDBArbvzhses/NMGem6CAiD2mfpbX
 nD06F56wkKMRlRbVvLjrzMmm5NRIIRMVNUDdBS1VPoMer5+B+I2taRSPoo3TUHwMcPoN
 Ii3Q==
X-Gm-Message-State: AOJu0YypivYzFMBStF78G/PFtp0hDcpn3cjOOPbD1B0r49OUAipwm1nD
 72hfO+x2l7yXEmxdWU/lkaHazeK3BeFYqlUGSg5Nv7mfhhB7K7LXo8jxlVOEh0S7mB8IC7CgwEu
 Fal04pg==
X-Google-Smtp-Source: AGHT+IGLhqVLULf0uTm19kAkS4b1LNyC7QEysjsXOfRy4ryVfHBH9xx0Wn8nwrGi6XeMywu8amoCtQ==
X-Received: by 2002:a05:6000:788:b0:37d:4cee:55b with SMTP id
 ffacd0b85a97d-381c7ae3095mr13007244f8f.59.1730846935423; 
 Tue, 05 Nov 2024 14:48:55 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49dfsm17451083f8f.46.2024.11.05.14.48.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/29] hw/i2c/mpc_i2c: Convert DPRINTF to trace events for
 register access
Date: Tue,  5 Nov 2024 22:47:14 +0000
Message-ID: <20241105224727.53059-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-12-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/mpc_i2c.c    | 9 +++++----
 hw/i2c/trace-events | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 2467d1a9aa2..3d79c156531 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
+#include "trace.h"
 
 /* #define DEBUG_I2C */
 
@@ -224,8 +225,8 @@ static uint64_t mpc_i2c_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
-    DPRINTF("%s: addr " HWADDR_FMT_plx " %02" PRIx32 "\n", __func__,
-                                         addr, value);
+    trace_mpc_i2c_read(addr, value);
+
     return (uint64_t)value;
 }
 
@@ -234,8 +235,8 @@ static void mpc_i2c_write(void *opaque, hwaddr addr,
 {
     MPCI2CState *s = opaque;
 
-    DPRINTF("%s: addr " HWADDR_FMT_plx " val %08" PRIx64 "\n", __func__,
-                                             addr, value);
+    trace_mpc_i2c_write(addr, value);
+
     switch (addr) {
     case MPC_I2C_ADR:
         s->adr = value & CADR_MASK;
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 6900e06edad..f708a7ace18 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -35,6 +35,11 @@ aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uint64_t va
 aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%s send %d/%d 0x%02x"
 aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%s recv %d/%d 0x%02x"
 
+# mpc_i2c.c
+
+mpc_i2c_read(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] -> 0x%02" PRIx32
+mpc_i2c_write(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] <- 0x%02" PRIx32
+
 # npcm7xx_smbus.c
 
 npcm7xx_smbus_read(const char *id, uint64_t offset, uint64_t value, unsigned size) "%s offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
-- 
2.45.2


