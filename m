Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FA9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeTO-0000jM-NA; Tue, 28 Oct 2025 03:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeT7-0000Xx-1E
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:50:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeSm-00075O-R8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:50:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so5748563f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637789; x=1762242589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMp5SEiL/DqxiivezHK1UHyuC2K2nMhieBEi0DJq2ls=;
 b=VXnBT1LIMEm/zGdAG7JnGEx1vyym3uLCiGuNuf5ZuH+ehxQcVFAWHA35BIayVFqPmI
 R8+gugfqBI6ESY56wQzFiQ24I5DgHMyd0vBtkntNCLBbqT47siBe1lYt9fK255nEd97Y
 CSNnrgK5iet/f3qsTalWJRMzSiK/Dx2SxB5k9cPzFsEtQSSb6tkYsJmCFNB73o4N3Zvh
 9e7e7HKm3s6K2Lf7t7JWzyECjGfKh+YwtQLbjOUD9lD1poyK/8UTjq4eJXjf1FC/U7/R
 J9AMGKMRMRlJiLgqV4dXzu9SZLPiMQbnorHJ12dONjYYtRzzetVVU5R/DDq6X5P26aUI
 tXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637789; x=1762242589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMp5SEiL/DqxiivezHK1UHyuC2K2nMhieBEi0DJq2ls=;
 b=ONBrIFc/2tYrgE296bjqTb8Q1DRGgewqBmNyAXzkNcRrHvzxDm4qsTxgAn/Xsf+lSO
 TCG7CQsDqYSpB1yXcu7pVJdpodeaw0byB5T4X2tiL5dRVud/cSJz2TJ7hKvYEqqc0Lje
 fOo6qNKstFiSUv5iaIvtvNqzBfGmZbmfSExByyxAcFZLJRvQ1nkKepgjXqjfkX2PAuJh
 LSlb4Goqaw5zP2NtYZWz7triV8U7R42Hgw5+O/fOHwwTpZIpVlmxzvA2T54o28m9NKjp
 kOhEjry2NmZ8wPjpqqR9I+2fl91QsCMPgDCEvDO+icv3xMFJu5xO9xK3FoRdZBo25YCY
 37LA==
X-Gm-Message-State: AOJu0Yy81+vAJYgOskBVjOWDqdFayRofKFqCBjsEhyFMI6DCDlH+LV6s
 5RiCE9taYsWH2t5NmRBcO2nUpJm6nT9jNo1UzEfY0XZ4wIWBF/UCiQB/hEu6tfCVY1TKw3t2YSn
 +IS3gqi4=
X-Gm-Gg: ASbGnctKHAxIeDj7LzbKPdUtG4IqoMhmIIoJkBeuHWPUgOOS6dopGF2m/BZYw/Mmn+W
 5drG/M1YVXmtu1z62JMa8N/I8+V/CbTNJSSg8YpOqkPSAjGgkvF9+2/EluxDNrfz+Z1BD0XcbX5
 DOXC216pR/YDbrs4U2ZNWcEIZO/HGjtTh74lshgM/OYyRSO0cHBZAfkWAoSL6REJN4kX7+AyUfN
 fo1eQoaWjrEXF1szcHnvSPKy3LdmKw5BFI0Xbo3NDdiSxjUMSGHIBRdeCa7qJJu1Rn0EAJanxJg
 oTUP54SDHJv7Wjx/zUUBLsc5bNf9/F3jbtcKxN5JBrNgRbUsxKZPJ9sd4wOB4vFvCjwcFVDINLD
 hpGTbg3pZmIY0HtrERVpSt0+xD1KBUOawheYb4JwgTX5zOEvM0avWQV5dcxuPQcaTXl5GZiQRr0
 8o76OKAxH4iFYfdLRHKgKT8UqgvkTpomvXx/2dB9pFtJyfJhHsvJ80alM=
X-Google-Smtp-Source: AGHT+IGtSEp433uC9qYma6kcQhFndenHMDLlZHsVpPwY2AHuor/xOMzhjJXK+9YHS53maFAvpXsY2A==
X-Received: by 2002:a05:6000:144d:b0:3f9:bc33:2fab with SMTP id
 ffacd0b85a97d-429a7e86d73mr2097883f8f.60.1761637789106; 
 Tue, 28 Oct 2025 00:49:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b43sm19118976f8f.6.2025.10.28.00.49.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:49:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PULL 02/23] qom: remove redundant typedef when use
 OBJECT_DECLARE_SIMPLE_TYPE
Date: Tue, 28 Oct 2025 08:48:38 +0100
Message-ID: <20251028074901.22062-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

When OBJECT_DECLARE_SIMPLE_TYPE is used, it automatically provides
the typedef, so we don’t have to define it ourselves.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251023063429.1400398-1-phind.uet@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/fsl_etsec/etsec.h                | 1 -
 include/hw/char/serial.h                | 1 -
 include/hw/input/lasips2.h              | 6 ++----
 include/hw/misc/auxbus.h                | 7 +++----
 include/hw/misc/bcm2835_mphi.h          | 7 ++-----
 include/hw/misc/npcm7xx_pwm.h           | 7 ++-----
 include/hw/pci-host/pnv_phb3.h          | 6 ++----
 include/hw/pci-host/pnv_phb4.h          | 8 ++++----
 include/hw/ppc/mac_dbdma.h              | 7 +++----
 include/hw/riscv/iommu.h                | 3 ---
 include/hw/scsi/scsi.h                  | 7 +++----
 include/hw/vfio/vfio-container-legacy.h | 5 ++---
 include/hw/virtio/virtio-serial.h       | 5 ++---
 include/net/can_emu.h                   | 7 +++----
 backends/cryptodev-lkcf.c               | 1 -
 hw/char/ipoctal232.c                    | 9 ++++-----
 hw/char/xen_console.c                   | 1 -
 hw/dma/pl330.c                          | 6 ++----
 hw/net/xen_nic.c                        | 2 --
 hw/pci-host/bonito.c                    | 7 +++----
 hw/ppc/pef.c                            | 1 -
 hw/usb/dev-mtp.c                        | 7 +++----
 hw/usb/dev-uas.c                        | 7 +++----
 23 files changed, 43 insertions(+), 75 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 3860864a3f5..bd2de3f99c7 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -130,7 +130,6 @@ struct eTSEC {
     /* Whether we should flush the rx queue when buffer becomes available. */
     bool need_flush;
 };
-typedef struct eTSEC eTSEC;
 
 #define TYPE_ETSEC_COMMON "eTSEC"
 OBJECT_DECLARE_SIMPLE_TYPE(eTSEC, ETSEC_COMMON)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 4bf90a46f3c..2cfeaed7fb9 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -77,7 +77,6 @@ struct SerialState {
     QEMUTimer *modem_status_poll;
     MemoryRegion io;
 };
-typedef struct SerialState SerialState;
 
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
diff --git a/include/hw/input/lasips2.h b/include/hw/input/lasips2.h
index 01911c50f9b..fd74883073b 100644
--- a/include/hw/input/lasips2.h
+++ b/include/hw/input/lasips2.h
@@ -32,7 +32,8 @@ struct LASIPS2PortDeviceClass {
     DeviceRealize parent_realize;
 };
 
-typedef struct LASIPS2State LASIPS2State;
+#define TYPE_LASIPS2 "lasips2"
+OBJECT_DECLARE_SIMPLE_TYPE(LASIPS2State, LASIPS2)
 
 struct LASIPS2Port {
     DeviceState parent_obj;
@@ -74,7 +75,4 @@ struct LASIPS2State {
     qemu_irq irq;
 };
 
-#define TYPE_LASIPS2 "lasips2"
-OBJECT_DECLARE_SIMPLE_TYPE(LASIPS2State, LASIPS2)
-
 #endif /* HW_INPUT_LASIPS2_H */
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index ccd18ce2095..0051e039471 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -29,13 +29,15 @@
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
-typedef struct AUXSlave AUXSlave;
 typedef enum AUXCommand AUXCommand;
 typedef enum AUXReply AUXReply;
 
 #define TYPE_AUXTOI2C "aux-to-i2c-bridge"
 OBJECT_DECLARE_SIMPLE_TYPE(AUXTOI2CState, AUXTOI2C)
 
+#define TYPE_AUX_SLAVE "aux-slave"
+OBJECT_DECLARE_SIMPLE_TYPE(AUXSlave, AUX_SLAVE)
+
 enum AUXCommand {
     WRITE_I2C = 0,
     READ_I2C = 1,
@@ -73,9 +75,6 @@ struct AUXBus {
     AddressSpace aux_addr_space;
 };
 
-#define TYPE_AUX_SLAVE "aux-slave"
-OBJECT_DECLARE_SIMPLE_TYPE(AUXSlave, AUX_SLAVE)
-
 struct AUXSlave {
     /* < private > */
     DeviceState parent_obj;
diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
index 751363f496c..3f1997e5f24 100644
--- a/include/hw/misc/bcm2835_mphi.h
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -23,7 +23,8 @@
 
 #define MPHI_MMIO_SIZE      0x1000
 
-typedef struct BCM2835MphiState BCM2835MphiState;
+#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2835MphiState, BCM2835_MPHI)
 
 struct BCM2835MphiState {
     SysBusDevice parent_obj;
@@ -37,8 +38,4 @@ struct BCM2835MphiState {
     uint32_t swirq;
 };
 
-#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
-
-OBJECT_DECLARE_SIMPLE_TYPE(BCM2835MphiState, BCM2835_MPHI)
-
 #endif
diff --git a/include/hw/misc/npcm7xx_pwm.h b/include/hw/misc/npcm7xx_pwm.h
index bf953440acc..df927266209 100644
--- a/include/hw/misc/npcm7xx_pwm.h
+++ b/include/hw/misc/npcm7xx_pwm.h
@@ -35,8 +35,8 @@
  * value of 100,000 the duty cycle for that PWM is 10%.
  */
 #define NPCM7XX_PWM_MAX_DUTY 1000000
-
-typedef struct NPCM7xxPWMState NPCM7xxPWMState;
+#define TYPE_NPCM7XX_PWM "npcm7xx-pwm"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxPWMState, NPCM7XX_PWM)
 
 /**
  * struct NPCM7xxPWM - The state of a single PWM channel.
@@ -100,7 +100,4 @@ struct NPCM7xxPWMState {
     uint32_t    piir;
 };
 
-#define TYPE_NPCM7XX_PWM "npcm7xx-pwm"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxPWMState, NPCM7XX_PWM)
-
 #endif /* NPCM7XX_PWM_H */
diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_phb3.h
index 24ca3dddaa9..682f62a638f 100644
--- a/include/hw/pci-host/pnv_phb3.h
+++ b/include/hw/pci-host/pnv_phb3.h
@@ -14,7 +14,8 @@
 #include "qom/object.h"
 #include "hw/pci-host/pnv_phb.h"
 
-typedef struct PnvPHB3 PnvPHB3;
+#define TYPE_PNV_PHB3 "pnv-phb3"
+OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB3, PNV_PHB3)
 
 /*
  * PHB3 XICS Source for MSIs
@@ -115,9 +116,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB3RootBus, PNV_PHB3_ROOT_BUS)
 /*
  * PHB3 PCIe Host Bridge for PowerNV machines (POWER8)
  */
-#define TYPE_PNV_PHB3 "pnv-phb3"
-OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB3, PNV_PHB3)
-
 #define PNV_PHB3_NUM_M64      16
 #define PNV_PHB3_NUM_REGS     (0x1000 >> 3)
 #define PNV_PHB3_NUM_LSI      8
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 8a80c0c667a..de996e718b0 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -17,8 +17,11 @@
 #include "hw/ppc/xive.h"
 #include "qom/object.h"
 
+
+#define TYPE_PNV_PHB4 "pnv-phb4"
+OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
+
 typedef struct PnvPhb4PecStack PnvPhb4PecStack;
-typedef struct PnvPHB4 PnvPHB4;
 
 /*
  * We have one such address space wrapper per possible device under
@@ -59,9 +62,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
 /*
  * PHB4 PCIe Host Bridge for PowerNV machines (POWER9)
  */
-#define TYPE_PNV_PHB4 "pnv-phb4"
-OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
-
 #define PNV_PHB4_MAX_LSIs          8
 #define PNV_PHB4_MAX_INTs          4096
 #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 896ee4a2b17..76764882453 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -164,7 +164,9 @@ struct DBDMAState {
     DBDMA_channel channels[DBDMA_CHANNELS];
     QEMUBH *bh;
 };
-typedef struct DBDMAState DBDMAState;
+
+#define TYPE_MAC_DBDMA "mac-dbdma"
+OBJECT_DECLARE_SIMPLE_TYPE(DBDMAState, MAC_DBDMA)
 
 /* Externally callable functions */
 
@@ -173,7 +175,4 @@ void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
                             void *opaque);
 void DBDMA_kick(DBDMAState *dbdma);
 
-#define TYPE_MAC_DBDMA "mac-dbdma"
-OBJECT_DECLARE_SIMPLE_TYPE(DBDMAState, MAC_DBDMA)
-
 #endif
diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index 8a8acfc3f07..25f1a8b1596 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -24,18 +24,15 @@
 
 #define TYPE_RISCV_IOMMU "riscv-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
-typedef struct RISCVIOMMUState RISCVIOMMUState;
 
 #define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
 typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 
 #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
-typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
 
 #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
-typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
 
 #define FDT_IRQ_TYPE_EDGE_LOW 1
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 90ee192b4d4..044bd048b49 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -10,7 +10,9 @@
 
 #define MAX_SCSI_DEVS 255
 
-typedef struct SCSIBus SCSIBus;
+#define TYPE_SCSI_BUS "SCSI"
+OBJECT_DECLARE_SIMPLE_TYPE(SCSIBus, SCSI_BUS)
+
 typedef struct SCSIBusInfo SCSIBusInfo;
 typedef struct SCSIDevice SCSIDevice;
 typedef struct SCSIRequest SCSIRequest;
@@ -151,9 +153,6 @@ struct SCSIBusInfo {
     void (*drained_end)(SCSIBus *bus);
 };
 
-#define TYPE_SCSI_BUS "SCSI"
-OBJECT_DECLARE_SIMPLE_TYPE(SCSIBus, SCSI_BUS)
-
 struct SCSIBus {
     BusState qbus;
     int busnr;
diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index ffd594e80d6..fe822125268 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -12,7 +12,8 @@
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 
-typedef struct VFIOLegacyContainer VFIOLegacyContainer;
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
+
 typedef struct VFIODevice VFIODevice;
 
 typedef struct VFIOGroup {
@@ -35,6 +36,4 @@ struct VFIOLegacyContainer {
     VFIOContainerCPR cpr;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
-
 #endif /* HW_VFIO_CONTAINER_LEGACY_H */
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index d87c62eab7a..60641860bf8 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -29,7 +29,8 @@ struct virtio_serial_conf {
 OBJECT_DECLARE_TYPE(VirtIOSerialPort, VirtIOSerialPortClass,
                     VIRTIO_SERIAL_PORT)
 
-typedef struct VirtIOSerial VirtIOSerial;
+#define TYPE_VIRTIO_SERIAL "virtio-serial-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerial, VIRTIO_SERIAL)
 
 #define TYPE_VIRTIO_SERIAL_BUS "virtio-serial-bus"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerialBus, VIRTIO_SERIAL_BUS)
@@ -221,7 +222,5 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
-#define TYPE_VIRTIO_SERIAL "virtio-serial-device"
-OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerial, VIRTIO_SERIAL)
 
 #endif
diff --git a/include/net/can_emu.h b/include/net/can_emu.h
index 6f9b206bb5f..777281bad96 100644
--- a/include/net/can_emu.h
+++ b/include/net/can_emu.h
@@ -85,7 +85,9 @@ typedef struct qemu_can_filter {
 #define QEMU_CAN_INV_FILTER 0x20000000U
 
 typedef struct CanBusClientState CanBusClientState;
-typedef struct CanBusState CanBusState;
+
+#define TYPE_CAN_BUS "can-bus"
+OBJECT_DECLARE_SIMPLE_TYPE(CanBusState, CAN_BUS)
 
 typedef struct CanBusClientInfo {
     bool (*can_receive)(CanBusClientState *);
@@ -105,9 +107,6 @@ struct CanBusClientState {
     bool fd_mode;
 };
 
-#define TYPE_CAN_BUS "can-bus"
-OBJECT_DECLARE_SIMPLE_TYPE(CanBusState, CAN_BUS)
-
 int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id);
 
 int can_bus_insert_client(CanBusState *bus, CanBusClientState *client);
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index bb7a81d5d06..97a8a8812ce 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -68,7 +68,6 @@ typedef struct CryptoDevBackendLKCFSession {
     QCryptoAkCipherOptions akcipher_opts;
 } CryptoDevBackendLKCFSession;
 
-typedef struct CryptoDevBackendLKCF CryptoDevBackendLKCF;
 typedef struct CryptoDevLKCFTask CryptoDevLKCFTask;
 struct CryptoDevLKCFTask {
     CryptoDevBackendLKCFSession *sess;
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 752c6c818ab..0a7ffcd0b7e 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -93,7 +93,10 @@
 #define ISR_RXRDY(CH) (((CH) & 1) ? BIT(5) : BIT(1))
 #define ISR_BREAK(CH) (((CH) & 1) ? BIT(6) : BIT(2))
 
-typedef struct IPOctalState IPOctalState;
+#define TYPE_IPOCTAL "ipoctal232"
+
+OBJECT_DECLARE_SIMPLE_TYPE(IPOctalState, IPOCTAL)
+
 typedef struct SCC2698Channel SCC2698Channel;
 typedef struct SCC2698Block SCC2698Block;
 
@@ -122,10 +125,6 @@ struct IPOctalState {
     uint8_t irq_vector;
 };
 
-#define TYPE_IPOCTAL "ipoctal232"
-
-OBJECT_DECLARE_SIMPLE_TYPE(IPOctalState, IPOCTAL)
-
 static const VMStateDescription vmstate_scc2698_channel = {
     .name = "scc2698_channel",
     .version_id = 1,
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 9c34a554bfa..0e73c2aee40 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -56,7 +56,6 @@ struct XenConsole {
     CharBackend       chr;
     int               backlog;
 };
-typedef struct XenConsole XenConsole;
 
 #define TYPE_XEN_CONSOLE_DEVICE "xen-console"
 OBJECT_DECLARE_SIMPLE_TYPE(XenConsole, XEN_CONSOLE_DEVICE)
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index a570bb08ec4..f9c91f924bb 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -111,7 +111,8 @@ typedef enum  {
     pl330_chan_fault = 15,
 } PL330ChanState;
 
-typedef struct PL330State PL330State;
+#define TYPE_PL330 "pl330"
+OBJECT_DECLARE_SIMPLE_TYPE(PL330State, PL330)
 
 typedef struct PL330Chan {
     uint32_t src;
@@ -274,9 +275,6 @@ struct PL330State {
     AddressSpace *mem_as;
 };
 
-#define TYPE_PL330 "pl330"
-OBJECT_DECLARE_SIMPLE_TYPE(PL330State, PL330)
-
 static const VMStateDescription vmstate_pl330 = {
     .name = "pl330",
     .version_id = 2,
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 34c6a1d0b08..e7bdc732de0 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -62,8 +62,6 @@ struct XenNetDev {
     NICState              *nic;
 };
 
-typedef struct XenNetDev XenNetDev;
-
 #define TYPE_XEN_NET_DEVICE "xen-net-device"
 OBJECT_DECLARE_SIMPLE_TYPE(XenNetDev, XEN_NET_DEVICE)
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7d6251a78d7..cbda068ef7d 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -230,7 +230,9 @@ struct PCIBonitoState {
     MemoryRegion bonito_localio;
 
 };
-typedef struct PCIBonitoState PCIBonitoState;
+
+#define TYPE_PCI_BONITO "Bonito"
+OBJECT_DECLARE_SIMPLE_TYPE(PCIBonitoState, PCI_BONITO)
 
 struct BonitoState {
     PCIHostState parent_obj;
@@ -239,9 +241,6 @@ struct BonitoState {
     MemoryRegion pci_mem;
 };
 
-#define TYPE_PCI_BONITO "Bonito"
-OBJECT_DECLARE_SIMPLE_TYPE(PCIBonitoState, PCI_BONITO)
-
 static void bonito_writel(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index 254f5707876..39b4ce94f10 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -19,7 +19,6 @@
 #define TYPE_PEF_GUEST "pef-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
 
-typedef struct PefGuest PefGuest;
 typedef struct PefGuestClass PefGuestClass;
 
 struct PefGuestClass {
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index ce45c9cd061..afd7944b737 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -123,11 +123,13 @@ typedef struct {
 
 /* ----------------------------------------------------------------------- */
 
-typedef struct MTPState MTPState;
 typedef struct MTPControl MTPControl;
 typedef struct MTPData MTPData;
 typedef struct MTPObject MTPObject;
 
+#define TYPE_USB_MTP "usb-mtp"
+OBJECT_DECLARE_SIMPLE_TYPE(MTPState, USB_MTP)
+
 enum {
     EP_DATA_IN = 1,
     EP_DATA_OUT,
@@ -236,9 +238,6 @@ typedef struct {
     /* string and other data follows */
 } QEMU_PACKED ObjectInfo;
 
-#define TYPE_USB_MTP "usb-mtp"
-OBJECT_DECLARE_SIMPLE_TYPE(MTPState, USB_MTP)
-
 #define QEMU_STORAGE_ID 0x00010001
 
 #define MTP_FLAG_WRITABLE 0
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 21cc2835c62..18ebe15d0c4 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -109,10 +109,12 @@ typedef struct {
 #define UAS_STREAM_BM_ATTR  4
 #define UAS_MAX_STREAMS     (1 << UAS_STREAM_BM_ATTR)
 
-typedef struct UASDevice UASDevice;
 typedef struct UASRequest UASRequest;
 typedef struct UASStatus UASStatus;
 
+#define TYPE_USB_UAS "usb-uas"
+OBJECT_DECLARE_SIMPLE_TYPE(UASDevice, USB_UAS)
+
 struct UASDevice {
     USBDevice                 dev;
     SCSIBus                   bus;
@@ -133,9 +135,6 @@ struct UASDevice {
     USBPacket                 *status3[UAS_MAX_STREAMS + 1];
 };
 
-#define TYPE_USB_UAS "usb-uas"
-OBJECT_DECLARE_SIMPLE_TYPE(UASDevice, USB_UAS)
-
 struct UASRequest {
     uint16_t     tag;
     uint64_t     lun;
-- 
2.51.0


