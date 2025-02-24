Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8513AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdp6-0005f2-Hi; Mon, 24 Feb 2025 14:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdom-0005cY-LY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:42 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdok-0004mS-45
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:39 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220c665ef4cso83363435ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424115; x=1741028915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5YKF3HsuWUbiaPLrEWpm5TtTdaWovSQz+CQU4mRVEM=;
 b=dpK6cZ2QMtzDHQv4rI3ryw/lvFDX3IXr1yUy19U0jFus831iUieovlFiO0OE8EO6O3
 gAkmv/LFc/bHOXBk3NZq+abJ7ewRE3Mc/i+qifDaBDp4CWFoF9KryvemJR4PS1sw5vEK
 AbXp3NQt/jwSxPTPZwp9IsVw6X2VI98neo5YrEArfYHDNh/eIamu5ceFBfUxHDqBDHCR
 ulJY1ABVN4RvSfu4rfbn4ZA8J0bmKRUCght9bhA5BDHenDw7pfAHWuFBN9ieHQI9+/pg
 7y7NsEQi47NBv7gBfN7BjmSWLqKz8LQDFOzUFXImYwDWJJw4+Gq6XZtN73XDytjBfGPZ
 Bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424115; x=1741028915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5YKF3HsuWUbiaPLrEWpm5TtTdaWovSQz+CQU4mRVEM=;
 b=q6ZQoumh8toHWhb/YVa9XyB3nyM6tFZckuQCVW4l9uFD7d0H6+q+iJZtOR/NZcphpU
 7aB8nUo3hG4ukfbM9nE/MAWF74dW7mgUmjELpn41N7bbfr6uovKKxlJe45/qdKCdRlWe
 UhTj0nr+6j4Pxm/6hgu6ujuN2DTPw9VF3bW5hvzbMxIBmf9RLTwQwlwMmqv57wQflXTF
 xTH4yocqpDlbHpnwKqORtyrrP9vC+KiR0yFEYeI3ZYkdcNLyGyamBjiTFTk32IUmSzPT
 HGDUXHD808J1tD8OGq8pxXWtWdGekOjYxgLlLnobbzqbpLmzwYwex7TrXIA+kia3DxvX
 Lrng==
X-Gm-Message-State: AOJu0Yz/2b01zrWsiW+du1egUbkFYtYl0Q2LuXMXQdzbF4wnO8OWG4Ef
 aU0sd/wUf6k9Wap8o1QFycR3eNLf9TTLpGMW01NXxFZnow9yfnhT9f8xl72nMFXSI+ejGitiXra
 z
X-Gm-Gg: ASbGncvLEccJeJByqkvycLAXdsrN8ay/crz/fOSDgNum8WptQew0TtcoszXu4XCJ9B0
 ZuUvEy5ARKtPTcXI0LjzspC31701IrFF4Be1xuzANu7RKbA+RdvfArxqWPIpjIDJ+8Opl1KrJof
 IB7aQ9yONhy+RVhzrbY5PbpTDdUOeWeFd8BD7FEsbnNbt7t0RkEgiJddyoNCbswsDL3l8WEwUV3
 eC3WGvj6b+ORnBapScTQHWrnRZZg+afmXeHezFz0Q5zHj1T2ZqGtPsDrfZrJEA/Dip1qVv3HlRx
 CBMy8Qv+SUsF1eYGpdtRWPuuh1kcug==
X-Google-Smtp-Source: AGHT+IHFR7q/79SWVCsSWTocNfY/RAdad1m2qaTUQPu16hfUp1z4NaZP/483YVQ8VlKndyGV0Z9boA==
X-Received: by 2002:a17:902:f544:b0:215:6cb2:7877 with SMTP id
 d9443c01a7336-2219ff827cdmr287717055ad.4.1740424114844; 
 Mon, 24 Feb 2025 11:08:34 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 01/11] hw/riscv/riscv-iommu.h: add missing headers
Date: Mon, 24 Feb 2025 16:08:16 -0300
Message-ID: <20250224190826.1858473-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

This header is incomplete, i.e. it is using definitions that are being
supplied by the .c files that are including it.

Adding this header into a fresh .c file will result in errors:

/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:30:17: error: field ‘parent_obj’ has incomplete type
   30 |     DeviceState parent_obj;
      |                 ^~~~~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:50:5: error: unknown type name ‘dma_addr_t’; did you mean ‘in_addr_t’?
   50 |     dma_addr_t cq_addr;   /* Command queue base physical address */
      |     ^~~~~~~~~~
      |     in_addr_t
(...)
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:62:5: error: unknown type name ‘QemuThread’; did you mean ‘GThread’?
   62 |     QemuThread core_proc; /* Background processing thread */
      |     ^~~~~~~~~~
      |     GThread
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:63:5: error: unknown type name ‘QemuCond’
   63 |     QemuCond core_cond;   /* Background processing wake up signal */
      |     ^~~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:71:18: error: field ‘trap_as’ has incomplete type
   71 |     AddressSpace trap_as;
      |                  ^~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:72:18: error: field ‘trap_mr’ has incomplete type
   72 |     MemoryRegion trap_mr;
      |                  ^~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:80:18: error: field ‘regs_mr’ has incomplete type
   80 |     MemoryRegion regs_mr;
      |                  ^~~~~~~

Fix it by adding the missing headers for these definitions.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index fa8a50fa24..d2608d2f9b 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -20,6 +20,8 @@
 #define HW_RISCV_IOMMU_STATE_H
 
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
+#include "system/dma.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 
-- 
2.48.1


