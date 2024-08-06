Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA9C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJgu-0002TM-Py; Tue, 06 Aug 2024 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgt-00029E-4Y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:27 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgq-00005O-Vf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:26 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so7796141fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948802; x=1723553602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8648z5sS/UfBnXQZvsAoQAWkk3MCJog805U1PXZhiE=;
 b=PyGmHIN5jDuMoklnCp783bN7iEKy/YDmLLsYURq5eYQDHKqK8ArfzVPzpmNAEDLh0V
 QRybU3aQDnQhbNfSgNAzljyou0+PjBt2rANWdM1LshMLARu2+sTheYlUReFbFWXpplig
 fuOw6vRhLEULjCUiEcucgANgSIcFnHtETUU7aKpubG6GCbaNU3ZmnBH1Wo6+dtafPtft
 EgSrVLslSIF0eTkPFwASHE8Hzx1w5qsNyCy/s2WdS4EI1q1pCGtp+llzGCVVRC137pq8
 SkzSP2aLIA0g0fy86uzjLAuI6GsZfGUZTxoy5iqny1nAVmFGqyX5/zCch1V8ut4vQeG9
 jocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948802; x=1723553602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8648z5sS/UfBnXQZvsAoQAWkk3MCJog805U1PXZhiE=;
 b=N6r7wp591t4l+L3bC7tvz6x3GX1555DS9A4jVISIZjuV+T3mp8T9uGaNThHYpoBrCU
 inys8aHaAwMLO70kV/SoeJ70ZqaF5oGarHm9EycnQcZ/7pKPglDMChSTQkAjibz/r/Ic
 qeX+ntWzM8ac1/RmhWYhItSBVY0xqv6S3PO6A1Ko9pkxDrKXdmtV0Sa7xTbHEcAyd1a4
 kFJtuZ3AJ4YxSRU4f29rIaqTplIqsXhzGfdQ7ks5OG6gB89wLEH+S+J/kI5jRwdcBQvt
 jLWE6Sq8zAp//V1QvVPpk8gdksI4nCujHcGP7u2IQ31voTuv++1sTfHneD5vIoTjRnGu
 9G6g==
X-Gm-Message-State: AOJu0YwPRdy1WtGdlreeUvHA2xxL7T47RTnvOv7fazUvORSsVOwWk4xy
 QRVL2egbdtypejReJu4YqGtwUJiqwndCAxs0BiN1gnoR4n3ggXbkskfNjqW0WHAAZG+o1OEiBbj
 p
X-Google-Smtp-Source: AGHT+IE10M0J/3bUj06b02NgS5GBKMCTvEQWAgYD/eoTa67AHR53VTtggkSNeA1IIrR2XnzzrS8JIw==
X-Received: by 2002:a05:651c:112:b0:2ef:2c0f:283e with SMTP id
 38308e7fff4ca-2f15aa95ca9mr97809021fa.12.1722948802073; 
 Tue, 06 Aug 2024 05:53:22 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b7245f8sm5968354a12.74.2024.08.06.05.53.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 13/28] hw/loongarch/virt: Replace Loongson IPI with LoongArch
 IPI
Date: Tue,  6 Aug 2024 14:51:41 +0200
Message-ID: <20240806125157.91185-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Loongarch IPI inherits from class LoongsonIPICommonClass, and it
only contains Loongarch 3A5000 virt machine specific interfaces,
rather than mix different machine implementations together.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Rebased]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240805180622.21001-14-philmd@linaro.org>
---
 include/hw/loongarch/virt.h | 1 -
 hw/loongarch/virt.c         | 4 ++--
 hw/loongarch/Kconfig        | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 603c1cebdb..c373e48f27 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -11,7 +11,6 @@
 #include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
-#include "hw/intc/loongson_ipi.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e592b1b6b7..29040422aa 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -23,7 +23,7 @@
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/intc/loongson_ipi.h"
+#include "hw/intc/loongarch_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
@@ -788,7 +788,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGSON_IPI);
+    ipi = qdev_new(TYPE_LOONGARCH_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 89be737726..0de713a439 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -12,7 +12,7 @@ config LOONGARCH_VIRT
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-    select LOONGSON_IPI
+    select LOONGARCH_IPI
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
-- 
2.45.2


