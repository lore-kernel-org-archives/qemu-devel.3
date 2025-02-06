Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A063C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Sv-000841-NG; Thu, 06 Feb 2025 13:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6St-00081S-NQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:19:03 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Ss-0006rC-4N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:19:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dc5b8ed86so250405f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865940; x=1739470740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Rk4bXft0s/BXA9vpR8jU6qA4/CSXx2ZYQlNSJ5gsvQ=;
 b=QjSLcK4Zl4wZIrLlHM1PKf2geh0rzVeMmfoaHDm4hKnPQdaOqrP21wBiV+6iFN3Mm2
 k+/5tOIRLu4TCiV9hSwvsCOhj6lAnwl5sX66HREyTEq6YyiVhoRtITFQn7yAYOIMKfBT
 zYk/kldzeWF4HDD4/W7hE9hzulSOHnB6GlXbYmCVmZIe6STzHFLSML4mt/UkqBdiwwYd
 VWIfIM/lzPP+wAQlUjsLcntq+IvgDWv84RLNN2vgPu1kHScp4tAXyOFc8VhRuzCT//D+
 E/pIF8Dcc2hif0wV2pl5IUTZUGbQQnY5mQ6rEKsr9Rkd1K0tfSWUAdQEOQ3N/TQeS7/G
 RRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865940; x=1739470740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Rk4bXft0s/BXA9vpR8jU6qA4/CSXx2ZYQlNSJ5gsvQ=;
 b=WXeYkqNQR9TMu7D+nwyPPO/xy7UlYP+ApEmNQcujJ5H/NmglTEOQBNbNwgMZL0Dewv
 IsvRJizlSMGBULJBPjZLagoxnahFKkd3u88qtfAxXwpGIKSMeQBtEk2Jhx1MbzLx7Drd
 grDEuR19xdrhYctvErCtYC3Dri4sgWu6agKJukwUJa2S0fE8ctBj8+d9dS488CRzQKCq
 IhrNWAqxDuG3nfIrclNNqZQqY5jsGFKA+rUG/iS8itaSWCd2tKO7QmpuXjaQyKOKd1BW
 e1OOj1nKLnjCnRUP3qwPtC5aPdsiPokrzoR+5XaVqSMm0ALXSDEi14r9hulEOQUIVDhV
 k8VA==
X-Gm-Message-State: AOJu0Yz7WT5xJIYMYe7PCZhakstjVobQ3VquQsHQ8WLwX2lwK04Jr0Kj
 qsqByZulC5VnRQSBnQ/NB36DDyLGfE79jV68hWDR2XKQG82epdUlqnfTRb0yewzdjOnKk6EaLk/
 DKtw=
X-Gm-Gg: ASbGncss24ZtRqGTmiUr9SAxAMkGmgcZl7QOqgSK0Arvc1+Iu2rJXySqVSCTwqcbNXP
 jKoQd9P0utdFt9EUJMQ/jR2Iwcz30NfrJHRpMTfryPUZd8HLyOCzHjtwQics4sJ6LQHOesViRRD
 BnkYbTK4U2Mi3CbNS9W9rFyTTAekl5H/UM+swbAyTZa7lqh7MZ+mFdj/fFPcTE6rudSDMblqQ+W
 qdSI+PQfkFAbnS3OBUsRNQAMhrgQ0HW80XMng+dpHY7RgIITb2doSswp77/v+LUFRAhl8friost
 VLbycQlTggyNvwbl6K/B3NfrqYIMhv3fw72REEqP3mQAYjB4e6wlXVASFmK+KcFF4g==
X-Google-Smtp-Source: AGHT+IE/1lQWPvojDSp4YKi4o595AHTqMFnURwEpiv2mdh2Nf9nSCBYB9pEzJYPH6M6RAwhKN+Tauw==
X-Received: by 2002:a05:6000:4c1:b0:38d:a910:b4d5 with SMTP id
 ffacd0b85a97d-38db494e5fcmr4870954f8f.54.1738865940138; 
 Thu, 06 Feb 2025 10:19:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d802sm65995685e9.12.2025.02.06.10.18.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:18:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] hw/riscv/hart: Make 'riscv_hart.h' header target-agnostic
Date: Thu,  6 Feb 2025 19:18:26 +0100
Message-ID: <20250206181827.41557-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206181827.41557-1-philmd@linaro.org>
References: <20250206181827.41557-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hardware code using HART rarely needs to knows its internals.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/riscv_hart.h | 4 ++--
 hw/riscv/virt-acpi-build.c    | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index a6ed73a1956..a2ca455d8b1 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -22,7 +22,7 @@
 #define HW_RISCV_HART_H
 
 #include "hw/sysbus.h"
-#include "target/riscv/cpu.h"
+#include "target/riscv/cpu-qom.h"
 #include "qom/object.h"
 
 #define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
@@ -42,7 +42,7 @@ struct RISCVHartArrayState {
     uint64_t *rnmi_irqvec;
     uint32_t num_rnmi_excpvec;
     uint64_t *rnmi_excpvec;
-    RISCVCPU *harts;
+    ArchCPU *harts;
 };
 
 #endif
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1ad68005085..0030c21bc41 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -39,6 +39,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
+#include "target/riscv/cpu.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
-- 
2.47.1


