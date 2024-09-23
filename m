Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1EFCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPZ-0002JQ-DR; Mon, 23 Sep 2024 05:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPY-0002FI-CU; Mon, 23 Sep 2024 05:31:16 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPV-0006xs-PZ; Mon, 23 Sep 2024 05:31:16 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d51a7d6f5so614214066b.2; 
 Mon, 23 Sep 2024 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083870; x=1727688670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwsoQdUrJVWYxvUgDYuKBFMf0v5P53ou5sqi+kSdVbs=;
 b=eRPu9/NLDZyWvWoorAOmXVrUIXZU8URNj0I7sZKCbAa3S56vG1DtUppbqf+K2/FTAY
 yPdHFfas9qNdutyDogRV8IA7Mja8J6bzQYt8v7WNourd4yRJnUQKHgAi6YC7gz7ITrm0
 5TsYvuODR7di1ooLx2kSQlclmOuCCool0mbjbCLGOfSixSbd9CZujtERXfzg05Kcaz38
 ZsGihV5NblB6wmQx4arDwdaqsTmK5dQO5nq+wd3Pp/khDuy2CbeeMw4E80YjdyeufB2i
 IPXBxuyB0QH9sXni1NtLB+LPlPM7xHhtqDTUx8Ky5n9pzsBQ+5KCTchLmcQK/msV33ws
 fwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083870; x=1727688670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwsoQdUrJVWYxvUgDYuKBFMf0v5P53ou5sqi+kSdVbs=;
 b=RuRqpKxR9ahJjq9gt/xn9B8XvsUDpmyrg+Jajj2+/ZS9LQ3RxOQzdFjpNnfothhs1x
 DxRF073zPsoGjmytnz6U9txMsH6OlCu9tD4+pmZpFSUVFbYsrCk6K6UDns0ATQgk2yHu
 mQIa5qk6uIJhbWJOfg2t3fVjdYennOX2Q5/HDPMIP9JHLI6ceJ50+SqJFGBQeqeDSGi8
 c+NYtRg3REDn3OCSKMYPs90PPShEAgpZV8n4aiDIMtuCdElOnU9LL4zPGpGWVFUDWWlm
 +tf1BzRR4+btUtIffBmHSbea5SLKiGexuRzMHgzbWr47+OUVtVDPichGJaPKOBinN5x6
 1qdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQD2LZ/SQ6v3VAZaw+LYkmpnNmc3dQqKBXeV3ILoNoGKH0oqV2Ej4YQDLdykCaeX8RV3Qw9Nh/SIQ=@nongnu.org,
 AJvYcCURCnFKgQI+9Etfd8AwFTIyTJYW0ohYicAU0aZRy7OjxCjhymztVCV5iK1oKLiQC0FePOgXItvyQNuK@nongnu.org
X-Gm-Message-State: AOJu0YxjDCECXVfQ+0jXKpXZPMh3NyPyIhDsM4WF8Hn4O9Y8At7xoaHr
 X9QlWYw6gNZ/WAsk6b/eF+x9/zqBl1pF5fAkevqCwl2hrDLoFSGGwnXlIg==
X-Google-Smtp-Source: AGHT+IFkEwvgPFvsRjXEL7W5AqBarn2pB08glC2ZukVll0DZqIc/t2lr7n2Yg4Rw34hRsJ767JDAaw==
X-Received: by 2002:a17:907:7d87:b0:a7a:b561:3575 with SMTP id
 a640c23a62f3a-a90d5168094mr1093817466b.56.1727083870015; 
 Mon, 23 Sep 2024 02:31:10 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:08 -0700 (PDT)
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
Subject: [PATCH 06/23] hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's
 internal resources
Date: Mon, 23 Sep 2024 11:29:59 +0200
Message-ID: <20240923093016.66437-7-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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

Rather than accessing the attributes of TYPE_CCSR directly, use the SysBusDevice
API which exists exactly for that purpose. Furthermore, registering the memory
region with the SysBusDevice API makes it show up in QMP's `info qom-tree`
command.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 10 +++++-----
 hw/ppc/e500.c         |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 95b983b2b3..97e5d47cec 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,7 +16,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/ppc/e500-ccsr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
@@ -419,11 +418,12 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    SysBusDevice *ccsr = SYS_BUS_DEVICE(container_get(qdev_get_machine(),
+                                                      "/e500-ccsr"));
+    MemoryRegion *ccsr_space = sysbus_mmio_get_region(ccsr, 0);
 
-    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
-                             0, int128_get64(ccsr->ccsr_space.size));
+    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
+                             ccsr_space, 0, int128_get64(ccsr_space->size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
 }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e2a4f265a5..2225533e33 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -924,7 +924,6 @@ void ppce500_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
-    PPCE500CCSRState *ccsr;
     I2CBus *i2c;
 
     irqs = g_new0(IrqLines, smp_cpus);
@@ -980,10 +979,10 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     dev = qdev_new("e500-ccsr");
+    s = SYS_BUS_DEVICE(dev);
     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ccsr = CCSR(dev);
-    ccsr_addr_space = &ccsr->ccsr_space;
+    sysbus_realize_and_unref(s, &error_fatal);
+    ccsr_addr_space = sysbus_mmio_get_region(s, 0);
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
 
@@ -1270,6 +1269,7 @@ static void e500_ccsr_initfn(Object *obj)
     PPCE500CCSRState *ccsr = CCSR(obj);
     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
                        MPC8544_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
 }
 
 static const TypeInfo e500_ccsr_info = {
-- 
2.46.1


