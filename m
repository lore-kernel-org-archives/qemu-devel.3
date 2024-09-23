Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75646CF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPk-00033Z-TB; Mon, 23 Sep 2024 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPb-0002SK-KS; Mon, 23 Sep 2024 05:31:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPZ-0006yM-08; Mon, 23 Sep 2024 05:31:19 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so7802029a12.1; 
 Mon, 23 Sep 2024 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083874; x=1727688674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RERJXKUszJ43EeqHg4WLrmh2/0JVzvko+c62JLfBV1k=;
 b=jnFHJLfiDwp4x4MQcNW3CDYzSNxrYteg/ksCFdOsL4kWZBwbZ1yttbHYRliJNkTAvR
 JoVHsG8k3l4FJ7UsCNWwGsBjy48hF6rpMI2PQWbwbPI6JMH0z5NjeLPKhRsHJqlozPs3
 EBc/AskRt9j2vkd2NGB5iQmDqURtpdBmX6MuENdvPnH2EQ3BqF/IV4JyB8XQ1Ea4dGV0
 eIHsQa4uT+q1lAA6Ww2ZFENtvS59WMLSyAYROdq5RQwKIRdU7AYUsEieaYs1wRosj3K7
 zduNui3vgTNqXr2RNp4uCl05B2Mb+6OILDGmFX7iWTn2rWkU8MJXG0eIPQnNMSPeWGtT
 SoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083874; x=1727688674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RERJXKUszJ43EeqHg4WLrmh2/0JVzvko+c62JLfBV1k=;
 b=p8D1fF9vTxZxXFnFHf5lrQZBwS7stvVenzwSuoSYfrfOtExDhCU3VW8h4Eou3C8e4G
 LS5aNOL0M2oHwKmkEC9t6TQlAW+lEwRv/dG+VcLBzCLyxzMBkpYm+m/zwSUAnYWTecnT
 mw6XO5NjBy2eXdoOndtW90crB1fcO+Fa7Tgcr4/+6yfxNN5h/0noXClnKNtTtFWdSfc5
 9y7pMJztCEh6Z6QI/Z9xe7IVEZ9WrVOUYMkPMQgNZZTAaWEMSPJZdvumfeoQabSrSlIW
 SqBmxF0WWlBfunzf9l9ndnrCmSXa2PEvLL8bFcvmYFRMwzFRmbw1cg0jM7wpboLWb5Et
 2t8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqRVFDaBIs8VCYvC0S3H4ckaTmDpcWQ6Dcr5IwpNhGC/b3ea0taru2WHXX5hq32+CBLDJIs4OWQJ8=@nongnu.org,
 AJvYcCXuYFthgVsrR9JOZlasA+jIY3XUO6Sscq2FzOGnpaqa2Bx2awhrGWqpiodRUEHqbbYnbcR9tFychOMz@nongnu.org
X-Gm-Message-State: AOJu0Yy7167X8zmyy3RCWf7UETM0M6Shu/PCiDkCfhaxGJ4QRyWCdf+3
 oe+1RhQmC2MVr2LY7Jy6faJxrPBNaTCXYh9PDvsFaaDx6imYtG5ipaCBhA==
X-Google-Smtp-Source: AGHT+IFvV8tT709ubtZE3OCMj4d/1/E7HCpx7Ggm+UbJBUd/nhLzPNWdSF3QOsvTqsugtHHOvBT3/w==
X-Received: by 2002:a17:907:9408:b0:a8d:498f:640 with SMTP id
 a640c23a62f3a-a90c1d6ec4dmr1533310766b.21.1727083873500; 
 Mon, 23 Sep 2024 02:31:13 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 08/23] hw/ppc/ppce500_ccsr: Log access to unimplemented
 registers
Date: Mon, 23 Sep 2024 11:30:01 +0200
Message-ID: <20240923093016.66437-9-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The CCSR space is just a container which is meant to be covered by platform
device memory regions. However, QEMU only implements a subset of these devices.
Add some logging to see which devices a guest attempts to access.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/ppce500_ccsr.c | 33 +++++++++++++++++++++++++++++++--
 hw/ppc/trace-events   |  3 +++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
index 191a9ceec3..28942b2348 100644
--- a/hw/ppc/ppce500_ccsr.c
+++ b/hw/ppc/ppce500_ccsr.c
@@ -15,14 +15,43 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "e500-ccsr.h"
+#include "trace.h"
+
+static uint64_t ppce500_ccsr_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t value = 0;
+
+    trace_ppce500_ccsr_io_read(addr, value, size);
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented [0x%" HWADDR_PRIx "] -> 0\n",
+                  __func__, addr);
+
+    return value;
+}
+
+static void ppce500_ccsr_io_write(void *opaque, hwaddr addr, uint64_t value,
+                                  unsigned size)
+{
+    trace_ppce500_ccsr_io_write(addr, value, size);
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented [0x%" HWADDR_PRIx "] <- 0x%" PRIx32 "\n",
+                  __func__, addr, (uint32_t)value);
+}
+
+static const MemoryRegionOps ppce500_ccsr_ops = {
+    .read = ppce500_ccsr_io_read,
+    .write = ppce500_ccsr_io_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
 
 static void e500_ccsr_init(Object *obj)
 {
     PPCE500CCSRState *ccsr = CCSR(obj);
 
-    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
-                       MPC8544_CCSRBAR_SIZE);
+    memory_region_init_io(&ccsr->ccsr_space, obj, &ppce500_ccsr_ops, obj,
+                          "e500-ccsr", MPC8544_CCSRBAR_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
 }
 
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 1f125ce841..ca4c231c9f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -143,6 +143,9 @@ ppc_irq_cpu(const char *action) "%s"
 ppc_dcr_read(uint32_t addr, uint32_t val) "DRCN[0x%x] -> 0x%x"
 ppc_dcr_write(uint32_t addr, uint32_t val) "DRCN[0x%x] <- 0x%x"
 
+ppce500_ccsr_io_read(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] -> 0x%08x (size: 0x%" PRIu8 ")"
+ppce500_ccsr_io_write(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] <- 0x%08x (size: 0x%" PRIu8 ")"
+
 # prep_systemio.c
 prep_systemio_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 prep_systemio_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
-- 
2.46.1


