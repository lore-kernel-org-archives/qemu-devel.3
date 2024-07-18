Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A63FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURHb-0003W7-HD; Thu, 18 Jul 2024 09:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHX-0002zj-8U
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHV-00007p-JV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso3024105e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309688; x=1721914488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0uj0dnWiKopOMNbBacKJZ22z85m6+wChhbexgzZrEw=;
 b=h8sMqOdz5sjE8kRg5dfPIQk2AsX7XBoCYXVZ6TJDRSWJjNV8bZ/izLTJ1fMil3VtIb
 xATJFe4bEy0bIuxKXIehumCcQL+j7kBo6RYqLoCoSbUJlQ4LdwJfiw6n+ZlWZW01jMC4
 5hF9PMHGsGVQEaUjco0DcWEReq+NGOZFKSlBkY0tsH6rxNK/VX/EIcYwgMFDD/RU8EPa
 OgYwMKkbFTV+F5GZZfwUUVgGcCURjiXluRezJ1gz1b4C1oNRoy/8TQBPKd3KmjyDA0WI
 HsId+QKgtjatw8Q1OXhqmfw0ieEI6iqKgusr0D5H/Mv6L/aU2/oNXJSpMgkwd8uwVXiN
 32Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309688; x=1721914488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0uj0dnWiKopOMNbBacKJZ22z85m6+wChhbexgzZrEw=;
 b=bgSZQqlktxTCOMrkbeIG+2KREK9dhpzbN0Fcl0yykX/fj+DQPvw6D5wy7t3jP3RHUn
 34BAJ5+FDUn04Kl8MBtkqjs/8K/xzBCaUYuOgDACWGVUvPBxk4dJZ664Hp+DLxuF4+wn
 wUk82JARoX5U/JjcUemgmQAM8gwbK2NLvymBlDDU/sikbmE6xP/jQ7+UREH+FYhAloPD
 Jr+TdhvKbqFYI6pIxY5JxvCtr3EesVr2pUOA7Klg+xmgBuzI6DLdyXx+/5BpeRw+2EWf
 MVk/7FxmlwrntXCIemms0PNVRUCmhoh3DnojbMQfvf1gRn5BtdTZvfYopuWO/ho4Lm13
 Wh6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjS//bXg08Rk92x4qjbScvwLjxEqWNXi+oKG68ckdhkbf4wEhyS6RW0/J/SKE3OCVb6XEYeDuIpFssr3DHJaR7YYEgnPw=
X-Gm-Message-State: AOJu0YxgsKwxM1aEp9+Yq8lKsIWflxSW5NyJYE6lGAku7ZepKtQczgg/
 lyIHB7FdvqCvD9fl7itaCrMHyPjT6hXhhFSoOjUiIXdGv3tMIDJqZcZjsTxepx8=
X-Google-Smtp-Source: AGHT+IGbhfT6rdqyGH0NNEZrN+jnmAXNB4XrqIAgr++4eOPvMabDDkrKyFuNrs2dZuyIqpC8Vc8BkA==
X-Received: by 2002:a05:600c:1c02:b0:426:6eae:6596 with SMTP id
 5b1f17b1804b1-427c2d0227fmr37518395e9.25.1721309687921; 
 Thu, 18 Jul 2024 06:34:47 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b1dfd8sm13891305e9.22.2024.07.18.06.34.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 16/19] hw/loongarch/virt: Replace Loongson IPI with
 LoongArch IPI
Date: Thu, 18 Jul 2024 15:33:08 +0200
Message-ID: <20240718133312.10324-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
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


