Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925E3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMh1-0003Lx-JL; Thu, 18 Jul 2024 04:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgz-0002ry-KZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgx-0005Qd-PG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so518555e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292046; x=1721896846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro2UkiIljPYm3x7SryacRuC51Y6LajCjN+Iei/DvqiY=;
 b=VakErUWCn+umKejbK6lmo1TMA5zsrntyFvUF9jSATZ1Sss1P/TJ+1aYugonkCgnQ1L
 DDT1wpBMF2tiN8051MalXNzynAQjoghAg8vhrk6xhnfnSJ9kYbvmegsqcoFnEd7OMoEo
 ugV+2x5nHlrdQQZHk1SdOaYWTw0Bigovg0j3fJSAKZ/7bEi0gu+5LHNUYlF7PWvRbehf
 /3sHnvCExdyCw685504cmGELkqWuHzYH0GetVCQ72itnCHg0sF3HL83Z2Cr1I0TTO2ro
 xPZPasmrdw1QPBXuIEdSxk1CSbFtlrk8a1Bi9Pdk7QIjlTSZvHpniK6Br0qSkfSS0hAc
 I7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292046; x=1721896846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ro2UkiIljPYm3x7SryacRuC51Y6LajCjN+Iei/DvqiY=;
 b=bUFyFSY1575ei8de7D/GfXLc8l+NVSgLM/s735O5Ss8OWHEgdzicYGthTs3D0f8vnf
 ZmDwDE4Z9zs+rwLJUemyg4i3T/ZR9lsz/ckGW+fSm+fIFVhDEYfXDwriiPH/rT5nofX8
 S9LBF7L+Gg7deGn2CyE7uDz8oUPRwhnWYx07gTRwVRJJ6McWGHPKUDxY1ovuSQt92CGN
 HY2ICEDe+rNvHRgSxyRx4kknaTPiL0enSSgfli8jVWwUToxFi6MYnoGHyZzofJdjIOGV
 1nV3V8HzIara7jVPpd0WgzOnqhdfmsjJIFZkd6152Vuh2iM2apIkrBQ7xkxUqrfBfHQo
 FY7A==
X-Gm-Message-State: AOJu0Yxz4qCaiNAzF2cA3glrgdotNqMgQOwfRw8PXO0mlMdSXahwI/wV
 jBA2q/dwepBUfFXpbzIRoSxxu59jBvpPD4XTlrAs3JxHLzdnQHVoUiMgJLwTe7/CU+tA/iVhRH/
 Y98s=
X-Google-Smtp-Source: AGHT+IEaG0LlqYdl2nf63fCVmiWL8bZphYOqbmzleu35XCOKmqCZtq+Ozs8kyMp9A+n3tVlNwRkZBA==
X-Received: by 2002:a05:600c:1d20:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427c2cad3c2mr34526435e9.4.1721292046177; 
 Thu, 18 Jul 2024 01:40:46 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29678sm1385875e9.36.2024.07.18.01.40.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 16/18] hw/loongarch/virt: Replace loongson IPI with
 loongarch IPI
Date: Thu, 18 Jul 2024 10:38:40 +0200
Message-ID: <20240718083842.81199-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
---
 include/hw/loongarch/virt.h | 1 -
 hw/loongarch/virt.c         | 4 ++--
 hw/loongarch/Kconfig        | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8fdfacf268..91216418c8 100644
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
2.41.0


