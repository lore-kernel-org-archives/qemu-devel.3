Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63930D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqa-0002bd-CU; Thu, 27 Nov 2025 08:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqU-0002Zf-Dt
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqS-0001DD-JF
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bw7Au92vBEE7EHdF1CnAMWxiCpqWaUehH7lggjaeklw=;
 b=buuEfT5a3X/XA2+hNBEqi2dKzDcqcR/Kt8envrd0OPpV4bEcLF5jdQbvCehpHYg6NX+BVL
 wAXh/zGkpMqiiAdFfr+DGdOn5mjf0Y+dZ41D1mYhU/DkZzmMRzf8hlaNGmkhb+IjfO2Fzu
 2xapiLeT4ne+WW4gGcoyLwnVhB7yNTk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-IEBbESLJOGKnQEtV8zN7wg-1; Thu, 27 Nov 2025 08:15:34 -0500
X-MC-Unique: IEBbESLJOGKnQEtV8zN7wg-1
X-Mimecast-MFC-AGG-ID: IEBbESLJOGKnQEtV8zN7wg_1764249333
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b763bab126aso78741866b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249332; x=1764854132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bw7Au92vBEE7EHdF1CnAMWxiCpqWaUehH7lggjaeklw=;
 b=L9UoAX1aPGzu+VZO7YeLEMvnhMU5CtSDubeP2dGfuKJlmocu/7cMEVA9V6nCMRcFDC
 Af+aMSUqYKXQNTmgb8k4KlKKRz4jVasOexBA/EISBnVlJ/o7uIUyU9EGpLEK05PpbJ9u
 YIDRX4/DZMwBIsBKtSD4Xz1Y7jcNH1+9fw6/zqFGnv0iSSzlcIClBGCJetaGDyyeL6CP
 vqgaFgJ/MXvCnk/vcyAWwUc3AfSgCoD74HzsFCdvBLbahdDzRfhTlAjx+WpZgmnPZsut
 l1jFq4rCdyrWFA+KrEmco8awUHkE1yHJagrI76nLZLZGYL9ETf2GIZord4iH8clHlUld
 I4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249332; x=1764854132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bw7Au92vBEE7EHdF1CnAMWxiCpqWaUehH7lggjaeklw=;
 b=S3fUDuJHX4iPnogiNpDxUP9N/6nFsFlEH0T6BXsbPX6+We9ek/TnDMMg7OivVC9Gt6
 fkFKhQ8ymiPueAdxaIagv8aMGO7oQprfxOKbEgmXcmypWtzowkYM0jIHfS46J9OdlZUS
 3aG1vHsQmdysw/35iIzMkMhdnolPJJyKeojthhVy/Dt8vM23wyYEb5OHAx8sEa0FdDS9
 7IkInnL9qpLXGVOiyee12eT7lGmfeObU8LL6Hw2z0/h1bkpnTlke6Z9KcZq4iUPva5kR
 ea6/T5mmwUtR6SAgBxXTdhRRSZZHDNd3TiZR7QEOe41966LtnISRckH589zPFTADLB6u
 8zwg==
X-Gm-Message-State: AOJu0YyvojPVYKDr0X1J7ylUIOiwkgJZZ9jBTp/lO0K4D6VGj0Jhvbgk
 BWA8K3GoPfMdDX8XisaO34tntq8SeN9LM3xzIgrGEOnn3BsqVWv2BxOGd/v8NBVhVUya96laG6c
 jdhsC9SlBm17MLLt8oSSYDXnaIjYrB7XCXN/w+t6U797JHA2L4TFJREAX104eZ/tasL3YZzlx6T
 tdSwJhhm5IUPoNWSsiqGXQnh6nhJ2S4LkT9RU+2Vbl
X-Gm-Gg: ASbGncuFy+SUeT6eVTOvIG9hf1GRqclPWPwPnqCFLTOnsh9rMMfp0R2ycmVQiDeiH/3
 EQfCobEjkA494pJ4C+oJiHkzSrJlFD7bk4Ai0hJFA6GVFJdW2bX7QgmYwY1qv6JqhBAiOC1uvb+
 MWe2yttDRV5eIzawDVGyNfggINAD/5fXWfYdi/qpVZrBxco8ifRDioqtOZmrAg4v9zMYm1XD8EP
 5LPd4NlmTtN6NYMb0vkt701xi+rDoa+pZ+25XHBmAcsgXIMF77XGQCA6OcvSeXVQ/vn+zlrRR6l
 I7fPXK4D0sHw/u1l9tkGC1yR3jne/Ew1/2Wv24GzdDH8LEreHRie4aipaKE96dnWGnpuki7gdy4
 MFDQpkiQwMiJ+rDLq1ihWQmDhkpl1qSPSNAHd1zUDuZTF8j7rVlzSgeeSAzyppN04K4ImzAgO2F
 vWYDse2KqgX2Jhb9U=
X-Received: by 2002:a17:907:1c28:b0:b73:3ced:2f59 with SMTP id
 a640c23a62f3a-b76715dcc1bmr2659629366b.27.1764249331999; 
 Thu, 27 Nov 2025 05:15:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv5zx2oOuKZheCWtSTZ/9HMEYYJjUqgEyqdX8ovI/9vLVYQxRQzFHfn4cbBM5U04UT3GYe6w==
X-Received: by 2002:a17:907:1c28:b0:b73:3ced:2f59 with SMTP id
 a640c23a62f3a-b76715dcc1bmr2659623966b.27.1764249331464; 
 Thu, 27 Nov 2025 05:15:31 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f519e23esm165885666b.23.2025.11.27.05.15.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/28] include: move hw/hotplug.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:55 +0100
Message-ID: <20251127131516.80807-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/acpi/cpu.h           | 2 +-
 include/hw/acpi/cpu_hotplug.h   | 2 +-
 include/hw/acpi/pcihp.h         | 2 +-
 include/hw/{ => core}/hotplug.h | 0
 include/hw/i386/pc.h            | 2 +-
 include/hw/pci/pcie.h           | 2 +-
 include/hw/pci/shpc.h           | 2 +-
 include/hw/qdev-core.h          | 2 +-
 hw/acpi/acpi-nvdimm-stub.c      | 2 +-
 hw/acpi/piix4.c                 | 2 +-
 hw/core/hotplug.c               | 2 +-
 hw/pci-bridge/pci_bridge_dev.c  | 2 +-
 hw/pci/pci.c                    | 2 +-
 hw/pci/pcie_port.c              | 2 +-
 hw/s390x/css-bridge.c           | 2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename include/hw/{ => core}/hotplug.h (100%)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 95dc58b5adb..a64d19445cc 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -17,7 +17,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/core/boards.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
 
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
index 3b932abbbbe..5b670b04eb6 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -16,7 +16,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pc-hotplug.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/acpi/cpu.h"
 
 typedef struct AcpiCpuHotplug {
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ca6a2588258..efce5fd2e10 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -29,7 +29,7 @@
 
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
 #define ACPI_PCIHP_IO_LEN_PROP "acpi-pcihp-io-len"
diff --git a/include/hw/hotplug.h b/include/hw/core/hotplug.h
similarity index 100%
rename from include/hw/hotplug.h
rename to include/hw/core/hotplug.h
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ade2da92bad..b3a45ab71a8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -9,7 +9,7 @@
 #include "hw/block/flash.h"
 #include "hw/i386/x86.h"
 
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "qom/object.h"
 #include "hw/i386/sgx-epc.h"
 #include "hw/cxl/cxl.h"
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 42cebcd0338..c880ae1e04b 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -25,7 +25,7 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 typedef struct PCIEPort PCIEPort;
 typedef struct PCIESlot PCIESlot;
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index ad1089567a0..fce5bdd3bc7 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -2,7 +2,7 @@
 #define SHPC_H
 
 #include "system/memory.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 018c134011e..8170836d432 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -7,7 +7,7 @@
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qom/object.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/irq.h"
 #include "hw/resettable.h"
 
diff --git a/hw/acpi/acpi-nvdimm-stub.c b/hw/acpi/acpi-nvdimm-stub.c
index 65f491d6535..22ba17f5118 100644
--- a/hw/acpi/acpi-nvdimm-stub.c
+++ b/hw/acpi/acpi-nvdimm-stub.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 7a18f18dda2..9e0892a51f8 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -35,7 +35,7 @@
 #include "qemu/range.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/memory_hotplug.h"
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 17ac9866859..68aabad8ae0 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "qemu/module.h"
 
 void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b328e50ab31..cb4809f38b1 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -30,7 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "system/memory.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "qom/object.h"
 
 #define TYPE_PCI_BRIDGE_DEV      "pci-bridge"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e03953813c2..02a59f355b6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -45,7 +45,7 @@
 #include "trace.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index f3841a26568..20b5e4cfb51 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 void pcie_port_init_reg(PCIDevice *d)
 {
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 0f87b8c5c44..f3b6ef56300 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
-- 
2.51.1


