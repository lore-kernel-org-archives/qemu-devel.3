Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1794C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Sr-0007tD-Hv; Thu, 06 Feb 2025 13:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Sp-0007s8-Mi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Sn-0006qW-7f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso9209535e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865935; x=1739470735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3chV6Syf4UgzPYrc3klqldaIF78PGsSbuVaW5fDvGGY=;
 b=mM3fr7aYsRzvJJGqOTAiU7R7OJHjyzO640aF3yItt6Ixb5Lw/QiuDw0I0bUs4dIZ0T
 XVH5Hz5Wy1gJApwoq5mkonhazpCpu49bVM8elitA7HY85cKaD3o087TvdGgoFkpFnGHx
 cXa4KWk4FqolvrNO6v38Qxo/2dH4sMBCuEFh1un4UiJ/7hw1lErRWPA5XlaKVJGoEN1M
 /nK2cu46sKyC5Wb2pthuvTBwsHyXzznGHM3DN5vxybT+LdB/KTkO9nWSk81ia0lcXduT
 M5pxZA4/wyxhccDOjz/CTDjgmoRDU25XXpJoBGnQK25+cZx52diQNJrWNSQrkTplsD3N
 hH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865935; x=1739470735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3chV6Syf4UgzPYrc3klqldaIF78PGsSbuVaW5fDvGGY=;
 b=LOimC4Ibi1skTF+RyzbEA1DHiiV5IbDsXDILq35OQNRWSKUzQJYh0Shm+F6MUg22cq
 n9yRtNgYRp7Lsl4XJbMC9QK7AnX2y3KNqVKMwZGl/sMoYJY1+/AiLov+uhjVWHU8azyy
 yliKv+sSJLZTjg5nkp/Cfx3YREVGI5+xAKUze0APfkx4tIzV3msTqcXX1/H55FvNPtX7
 yRfM0quNU3E3WuYNefROSWP2y0hLiWWv/ExiD+QwpPEWSnDe+z/491dSrFEi9I8nAXW6
 oqHk/hXLGWE/tH2GHWzEgpjoDaK+tctFxlBiPaxw/4AZL25CKnqv0cnqjt9fFrNJSnD1
 /NSQ==
X-Gm-Message-State: AOJu0Yztvb/THXpXNr9mkEoQ2l9gLtRPZFfK4uyufkhA8NSYl+fKNzKk
 cshd7/saEMtdJ+KARziRNddLbkj+dBJttvfgLr23/axHpuTqaybSlkp1LPKMYkaIkEh+rpuqpOG
 oEEw=
X-Gm-Gg: ASbGncvd3jfwG3CE7WdHlcK55v1CggOspTBQwr34ovsW3KABvr44Yg8G4jUEPAW09D2
 5SIbQA2RcFw4rFwPXMKcXaGtV5FJTuddt5VwOdi1EbIuFJpsinME10sRz+WBSPjkkVXYR/0WBVZ
 f4s4i+nAS506DYCYT5ALHu4cu8+clnBgIcEip3Bwm6ArCSBX/x3UOekUKRm90zd2LbQw8CeuKKD
 /Hi9BDjs3h98eu51qvjzLd2RFx+HUNiqJdHQT7qVXCSOKxQ/ZHyiy2jw+EfyNv9OQgbcm9qX98G
 0L8mx5ScUqC+sq0CX7Om3gP6bVztIpkxBS9zrBPmjRrATmSjPTMYmiv16eGkMFXPtg==
X-Google-Smtp-Source: AGHT+IEA0DMN4iOBz9G2FC5ueovoYaZq2D4m+00UatsLM9qrQKFf6i0Vnv5yiTPmm2//MFKpTDLJHQ==
X-Received: by 2002:a05:600c:1e0e:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-43924988870mr3600075e9.8.1738865935183; 
 Thu, 06 Feb 2025 10:18:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43907f16ffasm58795995e9.1.2025.02.06.10.18.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:18:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] hw/riscv/iommu: Reduce needs for target-specific code
Date: Thu,  6 Feb 2025 19:18:25 +0100
Message-ID: <20250206181827.41557-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206181827.41557-1-philmd@linaro.org>
References: <20250206181827.41557-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Use the qemu_target_page_size() runtime function instead
of the TARGET_PAGE_SIZE definition, remove unnecessary
"exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/riscv-iommu-pci.c | 5 +++--
 hw/riscv/riscv-iommu-sys.c | 1 -
 hw/riscv/riscv-iommu.c     | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 12451869e41..d8779481421 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -22,13 +22,13 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
+#include "exec/target_page.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "qom/object.h"
 
-#include "cpu_bits.h"
 #include "riscv-iommu.h"
 #include "riscv-iommu-bits.h"
 #include "trace.h"
@@ -102,7 +102,8 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
     qdev_realize(DEVICE(iommu), NULL, errp);
 
     memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
-        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
+        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr),
+                      qemu_target_page_size()));
     memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
 
     pcie_endpoint_cap_init(dev, 0);
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 65b24fb07de..bbe839ed241 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -26,7 +26,6 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "exec/exec-all.h"
 #include "trace.h"
 
 #include "riscv-iommu.h"
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e7568ca227a..fb763e6e69d 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 
+#include "target/riscv/cpu.h"
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
 #include "riscv-iommu-bits.h"
-- 
2.47.1


