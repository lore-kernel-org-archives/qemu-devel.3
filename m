Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB92C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYyI-0003VX-FF; Mon, 26 Feb 2024 06:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxb-0002pY-3Q
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxX-0000Qy-R0
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d01faf711so3080919f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946146; x=1709550946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQBZGMQv95fG7g2BcVonDm8ogUcoDN/1uDc2HQWAe8c=;
 b=MIPdxWCd9Aa49oMSKFA9XMbycmL0YNTmNginFKuVnG3MPKuWB3SYRcEE/645SotLcJ
 6sW9NvFs9FxyMLDYGnbU/MHk47hxP8DsISAwCOdMyIkbESUpzNtLBqFHbPNwvVyzTVI4
 g/IH93JJ26DecnconJvRulr1cme4x5eSEEmTVMLkOWma73zv8NOCyGnEi/YDcS36vL40
 oMKC6jEsq0jZjngnh7T7jl9Du1wD2rEhod70uXnUb+i3m2tbsnaHo1E8Ud/sS/7kWGDL
 U5VMDIE+ExGoLwMYtIiB/68m5gokJW8lCrzt8jRDHine1SViJ7ARzv2RF+psyg65A2tN
 usrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946146; x=1709550946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQBZGMQv95fG7g2BcVonDm8ogUcoDN/1uDc2HQWAe8c=;
 b=V5mG9h26vT/Xi0tp3qS/sDFowitvBwWOvwKs2CjZ/PTnvSeGWzMWR6/Wr8X1bNAptd
 +goozCku5PxsHpVUvXd/luAHWLrVXZMcWEVYuE42qyUr9ViQ0yooWwxCAQ696BZ0TMMD
 vgCVTqDehLLxVT3VuzzzSDaA/f6H1mkgUr62cSA+CBkZ/6Mn4k69edoJwN+DX8aUYrr6
 WzT3L8FS7V0dTbvpczoybMJHppLEfoeqfEElKM7GI1pLGV4eZ8mz1BwxiAYf98aj4RI+
 QWpwHQJ6zt9p0S3NA7N2h2pU1azJD3VIgT9PHRhivh4RoqnJBJ+ed8Pt7JiLSkblagv/
 jPWA==
X-Gm-Message-State: AOJu0Yz8B+IMjIJOHEcE/ruzDgTY+2Fwhanz1KNI/awEpy8ia1U9ia+F
 Ak1NMbeB69fHjaBqx+vVn3b02D7W34KL/Li6XYqj+yvXiWxd7X/fLtDVVF7SoK9Laa0NoLS6w8m
 j
X-Google-Smtp-Source: AGHT+IGnTUqkFzyCqHifShvt11DWJOWRzoiGheEL55TQXf7R3c3lofAvreERbjiUNCiKDcpJ+SXYjA==
X-Received: by 2002:adf:f88f:0:b0:33d:2226:a26b with SMTP id
 u15-20020adff88f000000b0033d2226a26bmr5039729wrp.24.1708946145798; 
 Mon, 26 Feb 2024 03:15:45 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 k29-20020adfb35d000000b0033de2f2a88dsm978050wrd.103.2024.02.26.03.15.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/15] hw/southbridge/ich9: Extract LPC definitions to
 'hw/isa/ich9_lpc.h'
Date: Mon, 26 Feb 2024 12:14:13 +0100
Message-ID: <20240226111416.39217-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Most ICH9-related files use the 'ich9_' prefix,
rename lpc_ich9.c as ich9_lpc.c.

Restrict LPC/ISA definitions by moving them
to the "hw/isa/ich9_lpc.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                       |   1 +
 include/hw/isa/ich9_lpc.h         | 166 ++++++++++++++++++++++++++++++
 include/hw/southbridge/ich9.h     | 158 ++--------------------------
 hw/acpi/ich9.c                    |   1 +
 hw/acpi/ich9_tco.c                |   1 +
 hw/i386/acpi-build.c              |   1 +
 hw/i386/pc_q35.c                  |   1 +
 hw/isa/{lpc_ich9.c => ich9_lpc.c} |  34 +++++-
 tests/qtest/tco-test.c            |   2 +-
 hw/isa/meson.build                |   2 +-
 10 files changed, 209 insertions(+), 158 deletions(-)
 create mode 100644 include/hw/isa/ich9_lpc.h
 rename hw/isa/{lpc_ich9.c => ich9_lpc.c} (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d1b3e0d99..6b783e3360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2621,6 +2621,7 @@ F: hw/southbridge/ich9.c
 F: include/hw/acpi/ich9*.h
 F: include/hw/i2c/ich9_smbus.h
 F: include/hw/ide/ahci-pci.h
+F: include/hw/isa/ich9_lpc.h
 F: include/hw/pci-bridge/ich9_dmi.h
 F: include/hw/southbridge/ich9.h
 
diff --git a/include/hw/isa/ich9_lpc.h b/include/hw/isa/ich9_lpc.h
new file mode 100644
index 0000000000..b64d88b395
--- /dev/null
+++ b/include/hw/isa/ich9_lpc.h
@@ -0,0 +1,166 @@
+/*
+ * QEMU ICH9 PCI-to-LPC/ISA bridge emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ISA_ICH9_LPC_H
+#define HW_ISA_ICH9_LPC_H
+
+#include "exec/memory.h"
+#include "hw/isa/apm.h"
+#include "hw/acpi/ich9.h"
+#include "hw/intc/ioapic.h"
+#include "hw/pci/pci_device.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "qemu/notify.h"
+#include "qom/object.h"
+
+#define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
+OBJECT_DECLARE_SIMPLE_TYPE(ICH9LPCState, ICH9_LPC_DEVICE)
+
+#define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
+
+struct ICH9LPCState {
+    /* ICH9 LPC PCI to ISA bridge */
+    PCIDevice d;
+
+    /* (pci device, intx) -> pirq
+     * In real chipset case, the unused slots are never used
+     * as ICH9 supports only D25-D31 irq routing.
+     * On the other hand in qemu case, any slot/function can be populated
+     * via command line option.
+     * So fallback interrupt routing for any devices in any slots is necessary.
+    */
+    uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
+
+    MC146818RtcState rtc;
+    APMState apm;
+    ICH9LPCPMRegs pm;
+    uint32_t sci_level; /* track sci level */
+    uint8_t sci_gsi;
+
+    /* 2.24 Pin Straps */
+    struct {
+        bool spkr_hi;
+    } pin_strap;
+
+    /* 10.1 Chipset Configuration registers(Memory Space)
+     which is pointed by RCBA */
+    uint8_t chip_config[ICH9_CC_SIZE];
+
+    /*
+     * 13.7.5 RST_CNT---Reset Control Register (LPC I/F---D31:F0)
+     *
+     * register contents and IO memory region
+     */
+    uint8_t rst_cnt;
+    MemoryRegion rst_cnt_mem;
+
+    /* SMI feature negotiation via fw_cfg */
+    uint64_t smi_host_features;       /* guest-invisible, host endian */
+    uint8_t smi_host_features_le[8];  /* guest-visible, read-only, little
+                                       * endian uint64_t */
+    uint8_t smi_guest_features_le[8]; /* guest-visible, read-write, little
+                                       * endian uint64_t */
+    uint8_t smi_features_ok;          /* guest-visible, read-only; selecting it
+                                       * triggers feature lockdown */
+    uint64_t smi_negotiated_features; /* guest-invisible, host endian */
+
+    MemoryRegion rcrb_mem; /* root complex register block */
+    Notifier machine_ready;
+
+    qemu_irq gsi[IOAPIC_NUM_PINS];
+};
+
+#define ICH9_MASK(bit, ms_bit, ls_bit) \
+((uint##bit##_t)(((1ULL << ((ms_bit) + 1)) - 1) & ~((1ULL << ls_bit) - 1)))
+
+#define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
+
+/* ICH9: Chipset Configuration Registers */
+#define ICH9_CC_ADDR_MASK                       (ICH9_CC_SIZE - 1)
+
+#define ICH9_CC
+#define ICH9_CC_D28IP                           0x310C
+#define ICH9_CC_D28IP_SHIFT                     4
+#define ICH9_CC_D28IP_MASK                      0xf
+#define ICH9_CC_D28IP_DEFAULT                   0x00214321
+#define ICH9_CC_D31IR                           0x3140
+#define ICH9_CC_D30IR                           0x3142
+#define ICH9_CC_D29IR                           0x3144
+#define ICH9_CC_D28IR                           0x3146
+#define ICH9_CC_D27IR                           0x3148
+#define ICH9_CC_D26IR                           0x314C
+#define ICH9_CC_D25IR                           0x3150
+#define ICH9_CC_DIR_DEFAULT                     0x3210
+#define ICH9_CC_D30IR_DEFAULT                   0x0
+#define ICH9_CC_DIR_SHIFT                       4
+#define ICH9_CC_DIR_MASK                        0x7
+#define ICH9_CC_OIC                             0x31FF
+#define ICH9_CC_OIC_AEN                         0x1
+#define ICH9_CC_GCS                             0x3410
+#define ICH9_CC_GCS_DEFAULT                     0x00000020
+#define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
+
+/* D31:F0 LPC Processor Interface */
+#define ICH9_RST_CNT_IOPORT                     0xCF9
+
+/* D31:F1 LPC controller */
+#define ICH9_A2_LPC                             "ICH9 A2 LPC"
+#define ICH9_A2_LPC_SAVEVM_VERSION              0
+
+#define ICH9_A2_LPC_REVISION                    0x2
+#define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
+
+#define ICH9_LPC_PMBASE                         0x40
+#define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       ICH9_MASK(32, 15, 7)
+#define ICH9_LPC_PMBASE_RTE                     0x1
+#define ICH9_LPC_PMBASE_DEFAULT                 0x1
+
+#define ICH9_LPC_ACPI_CTRL                      0x44
+#define ICH9_LPC_ACPI_CTRL_ACPI_EN              0x80
+#define ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK     ICH9_MASK(8, 2, 0)
+#define ICH9_LPC_ACPI_CTRL_9                    0x0
+#define ICH9_LPC_ACPI_CTRL_10                   0x1
+#define ICH9_LPC_ACPI_CTRL_11                   0x2
+#define ICH9_LPC_ACPI_CTRL_20                   0x4
+#define ICH9_LPC_ACPI_CTRL_21                   0x5
+#define ICH9_LPC_ACPI_CTRL_DEFAULT              0x0
+
+#define ICH9_LPC_PIRQA_ROUT                     0x60
+#define ICH9_LPC_PIRQB_ROUT                     0x61
+#define ICH9_LPC_PIRQC_ROUT                     0x62
+#define ICH9_LPC_PIRQD_ROUT                     0x63
+
+#define ICH9_LPC_PIRQE_ROUT                     0x68
+#define ICH9_LPC_PIRQF_ROUT                     0x69
+#define ICH9_LPC_PIRQG_ROUT                     0x6a
+#define ICH9_LPC_PIRQH_ROUT                     0x6b
+
+#define ICH9_LPC_PIRQ_ROUT_IRQEN                0x80
+#define ICH9_LPC_PIRQ_ROUT_MASK                 ICH9_MASK(8, 3, 0)
+#define ICH9_LPC_PIRQ_ROUT_DEFAULT              0x80
+
+#define ICH9_LPC_GEN_PMCON_1                    0xa0
+#define ICH9_LPC_GEN_PMCON_1_SMI_LOCK           (1 << 4)
+#define ICH9_LPC_GEN_PMCON_2                    0xa2
+#define ICH9_LPC_GEN_PMCON_3                    0xa4
+#define ICH9_LPC_GEN_PMCON_LOCK                 0xa6
+
+#define ICH9_LPC_RCBA                           0xf0
+#define ICH9_LPC_RCBA_BA_MASK                   ICH9_MASK(32, 31, 14)
+#define ICH9_LPC_RCBA_EN                        0x1
+#define ICH9_LPC_RCBA_DEFAULT                   0x0
+
+#define ICH9_LPC_PIC_NUM_PINS                   16
+#define ICH9_LPC_IOAPIC_NUM_PINS                24
+
+/* D31:F0 power management I/O registers
+   offset from the address ICH9_LPC_PMBASE */
+
+/* FADT ACPI_ENABLE/ACPI_DISABLE */
+#define ICH9_APM_ACPI_ENABLE                    0x2
+#define ICH9_APM_ACPI_DISABLE                   0x3
+
+#endif
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 7e75496b0b..d6c3b5ece3 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -1,173 +1,27 @@
+/*
+ * QEMU Intel ICH9 south bridge emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
 #ifndef HW_SOUTHBRIDGE_ICH9_H
 #define HW_SOUTHBRIDGE_ICH9_H
 
-#include "hw/isa/apm.h"
-#include "hw/acpi/ich9.h"
-#include "hw/intc/ioapic.h"
-#include "hw/pci/pci.h"
-#include "hw/pci/pci_device.h"
-#include "hw/rtc/mc146818rtc.h"
-#include "exec/memory.h"
-#include "qemu/notify.h"
 #include "qom/object.h"
 
 #define TYPE_ICH9_SOUTHBRIDGE "ICH9-southbridge"
 OBJECT_DECLARE_SIMPLE_TYPE(ICH9State, ICH9_SOUTHBRIDGE)
 
-#define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
-
-#define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
-OBJECT_DECLARE_SIMPLE_TYPE(ICH9LPCState, ICH9_LPC_DEVICE)
-
-struct ICH9LPCState {
-    /* ICH9 LPC PCI to ISA bridge */
-    PCIDevice d;
-
-    /* (pci device, intx) -> pirq
-     * In real chipset case, the unused slots are never used
-     * as ICH9 supports only D25-D31 irq routing.
-     * On the other hand in qemu case, any slot/function can be populated
-     * via command line option.
-     * So fallback interrupt routing for any devices in any slots is necessary.
-    */
-    uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
-
-    MC146818RtcState rtc;
-    APMState apm;
-    ICH9LPCPMRegs pm;
-    uint32_t sci_level; /* track sci level */
-    uint8_t sci_gsi;
-
-    /* 2.24 Pin Straps */
-    struct {
-        bool spkr_hi;
-    } pin_strap;
-
-    /* 10.1 Chipset Configuration registers(Memory Space)
-     which is pointed by RCBA */
-    uint8_t chip_config[ICH9_CC_SIZE];
-
-    /*
-     * 13.7.5 RST_CNT---Reset Control Register (LPC I/F---D31:F0)
-     *
-     * register contents and IO memory region
-     */
-    uint8_t rst_cnt;
-    MemoryRegion rst_cnt_mem;
-
-    /* SMI feature negotiation via fw_cfg */
-    uint64_t smi_host_features;       /* guest-invisible, host endian */
-    uint8_t smi_host_features_le[8];  /* guest-visible, read-only, little
-                                       * endian uint64_t */
-    uint8_t smi_guest_features_le[8]; /* guest-visible, read-write, little
-                                       * endian uint64_t */
-    uint8_t smi_features_ok;          /* guest-visible, read-only; selecting it
-                                       * triggers feature lockdown */
-    uint64_t smi_negotiated_features; /* guest-invisible, host endian */
-
-    MemoryRegion rcrb_mem; /* root complex register block */
-    Notifier machine_ready;
-
-    qemu_irq gsi[IOAPIC_NUM_PINS];
-};
-
-#define ICH9_MASK(bit, ms_bit, ls_bit) \
-((uint##bit##_t)(((1ULL << ((ms_bit) + 1)) - 1) & ~((1ULL << ls_bit) - 1)))
-
-/* ICH9: Chipset Configuration Registers */
-#define ICH9_CC_ADDR_MASK                       (ICH9_CC_SIZE - 1)
-
-#define ICH9_CC
-#define ICH9_CC_D28IP                           0x310C
-#define ICH9_CC_D28IP_SHIFT                     4
-#define ICH9_CC_D28IP_MASK                      0xf
-#define ICH9_CC_D28IP_DEFAULT                   0x00214321
-#define ICH9_CC_D31IR                           0x3140
-#define ICH9_CC_D30IR                           0x3142
-#define ICH9_CC_D29IR                           0x3144
-#define ICH9_CC_D28IR                           0x3146
-#define ICH9_CC_D27IR                           0x3148
-#define ICH9_CC_D26IR                           0x314C
-#define ICH9_CC_D25IR                           0x3150
-#define ICH9_CC_DIR_DEFAULT                     0x3210
-#define ICH9_CC_D30IR_DEFAULT                   0x0
-#define ICH9_CC_DIR_SHIFT                       4
-#define ICH9_CC_DIR_MASK                        0x7
-#define ICH9_CC_OIC                             0x31FF
-#define ICH9_CC_OIC_AEN                         0x1
-#define ICH9_CC_GCS                             0x3410
-#define ICH9_CC_GCS_DEFAULT                     0x00000020
-#define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
-
 /* D28:F[0-5] */
 #define ICH9_PCIE_DEV                           28
 #define ICH9_PCIE_FUNC_MAX                      6
 
-/* D31:F0 LPC Processor Interface */
-#define ICH9_RST_CNT_IOPORT                     0xCF9
-
 /* D31:F1 LPC controller */
-#define ICH9_A2_LPC                             "ICH9 A2 LPC"
-#define ICH9_A2_LPC_SAVEVM_VERSION              0
-
 #define ICH9_LPC_DEV                            31
 #define ICH9_LPC_FUNC                           0
 
-#define ICH9_A2_LPC_REVISION                    0x2
-#define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
-
-#define ICH9_LPC_PMBASE                         0x40
-#define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       ICH9_MASK(32, 15, 7)
-#define ICH9_LPC_PMBASE_RTE                     0x1
-#define ICH9_LPC_PMBASE_DEFAULT                 0x1
-
-#define ICH9_LPC_ACPI_CTRL                      0x44
-#define ICH9_LPC_ACPI_CTRL_ACPI_EN              0x80
-#define ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK     ICH9_MASK(8, 2, 0)
-#define ICH9_LPC_ACPI_CTRL_9                    0x0
-#define ICH9_LPC_ACPI_CTRL_10                   0x1
-#define ICH9_LPC_ACPI_CTRL_11                   0x2
-#define ICH9_LPC_ACPI_CTRL_20                   0x4
-#define ICH9_LPC_ACPI_CTRL_21                   0x5
-#define ICH9_LPC_ACPI_CTRL_DEFAULT              0x0
-
-#define ICH9_LPC_PIRQA_ROUT                     0x60
-#define ICH9_LPC_PIRQB_ROUT                     0x61
-#define ICH9_LPC_PIRQC_ROUT                     0x62
-#define ICH9_LPC_PIRQD_ROUT                     0x63
-
-#define ICH9_LPC_PIRQE_ROUT                     0x68
-#define ICH9_LPC_PIRQF_ROUT                     0x69
-#define ICH9_LPC_PIRQG_ROUT                     0x6a
-#define ICH9_LPC_PIRQH_ROUT                     0x6b
-
-#define ICH9_LPC_PIRQ_ROUT_IRQEN                0x80
-#define ICH9_LPC_PIRQ_ROUT_MASK                 ICH9_MASK(8, 3, 0)
-#define ICH9_LPC_PIRQ_ROUT_DEFAULT              0x80
-
-#define ICH9_LPC_GEN_PMCON_1                    0xa0
-#define ICH9_LPC_GEN_PMCON_1_SMI_LOCK           (1 << 4)
-#define ICH9_LPC_GEN_PMCON_2                    0xa2
-#define ICH9_LPC_GEN_PMCON_3                    0xa4
-#define ICH9_LPC_GEN_PMCON_LOCK                 0xa6
-
-#define ICH9_LPC_RCBA                           0xf0
-#define ICH9_LPC_RCBA_BA_MASK                   ICH9_MASK(32, 31, 14)
-#define ICH9_LPC_RCBA_EN                        0x1
-#define ICH9_LPC_RCBA_DEFAULT                   0x0
-
-#define ICH9_LPC_PIC_NUM_PINS                   16
-#define ICH9_LPC_IOAPIC_NUM_PINS                24
-
 #define ICH9_GPIO_GSI "gsi"
 
-/* D31:F0 power management I/O registers
-   offset from the address ICH9_LPC_PMBASE */
-
-/* FADT ACPI_ENABLE/ACPI_DISABLE */
-#define ICH9_APM_ACPI_ENABLE                    0x2
-#define ICH9_APM_ACPI_DISABLE                   0x3
-
 #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
 
 /* bit positions used in fw_cfg SMI feature negotiation */
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index daf93361eb..1f41ab49c4 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -37,6 +37,7 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/ich9_tco.h"
 #include "hw/southbridge/ich9.h"
+#include "hw/isa/ich9_lpc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index dd4aff82e0..7499ec17db 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -13,6 +13,7 @@
 #include "migration/vmstate.h"
 
 #include "hw/acpi/ich9_tco.h"
+#include "hw/isa/ich9_lpc.h"
 #include "trace.h"
 
 enum {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e724494c7b..67a141efc4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -56,6 +56,7 @@
 
 /* Supported chipsets: */
 #include "hw/southbridge/ich9.h"
+#include "hw/isa/ich9_lpc.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/pc.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 63fec8b439..14df9e910b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -50,6 +50,7 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
 #include "hw/southbridge/ich9.h"
+#include "hw/isa/ich9_lpc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/ich9_lpc.c
similarity index 95%
rename from hw/isa/lpc_ich9.c
rename to hw/isa/ich9_lpc.c
index bd727b2320..17d4a95bd2 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/ich9_lpc.c
@@ -1,5 +1,5 @@
 /*
- * QEMU ICH9 Emulation
+ * QEMU ICH9 LPC PCI-to-ISA bridge Emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
  * Copyright (c) 2009, 2010, 2011
@@ -41,6 +41,7 @@
 #include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "hw/southbridge/ich9.h"
+#include "hw/isa/ich9_lpc.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
 #include "hw/pci/pci_bus.h"
@@ -53,10 +54,35 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "trace.h"
 
-/*****************************************************************************/
-/* ICH9 LPC PCI to ISA bridge */
+#define ICH9_A2_LPC_REVISION                    0x2
+#define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
 
-/* chipset configuration register
+/* ICH9: Chipset Configuration Registers */
+#define ICH9_CC_ADDR_MASK                       (ICH9_CC_SIZE - 1)
+
+#define ICH9_CC
+#define ICH9_CC_D28IP                           0x310C
+#define ICH9_CC_D28IP_SHIFT                     4
+#define ICH9_CC_D28IP_MASK                      0xf
+#define ICH9_CC_D28IP_DEFAULT                   0x00214321
+#define ICH9_CC_D31IR                           0x3140
+#define ICH9_CC_D30IR                           0x3142
+#define ICH9_CC_D29IR                           0x3144
+#define ICH9_CC_D28IR                           0x3146
+#define ICH9_CC_D27IR                           0x3148
+#define ICH9_CC_D26IR                           0x314C
+#define ICH9_CC_D25IR                           0x3150
+#define ICH9_CC_DIR_DEFAULT                     0x3210
+#define ICH9_CC_D30IR_DEFAULT                   0x0
+#define ICH9_CC_DIR_SHIFT                       4
+#define ICH9_CC_DIR_MASK                        0x7
+#define ICH9_CC_OIC                             0x31FF
+#define ICH9_CC_OIC_AEN                         0x1
+#define ICH9_CC_GCS                             0x3410
+#define ICH9_CC_GCS_DEFAULT                     0x00000020
+#define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
+
+/*
  * to access chipset configuration registers, pci_[sg]et_{byte, word, long}
  * are used.
  * Although it's not pci configuration space, it's little endian as Intel.
diff --git a/tests/qtest/tco-test.c b/tests/qtest/tco-test.c
index 0547d41173..c5974e72bd 100644
--- a/tests/qtest/tco-test.c
+++ b/tests/qtest/tco-test.c
@@ -14,7 +14,7 @@
 #include "libqos/pci-pc.h"
 #include "qapi/qmp/qdict.h"
 #include "hw/pci/pci_regs.h"
-#include "hw/southbridge/ich9.h"
+#include "hw/isa/ich9_lpc.h"
 #include "hw/acpi/ich9.h"
 #include "hw/acpi/ich9_tco.h"
 
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index 3219282217..3b5504f78d 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -8,4 +8,4 @@ system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
-specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
+specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('ich9_lpc.c'))
-- 
2.41.0


