Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EEFD1268C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 01:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQbeo-0005SG-4j; Tue, 02 Dec 2025 20:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tphan@ventanamicro.com>)
 id 1vQae9-00010X-2V
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 19:23:05 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tphan@ventanamicro.com>)
 id 1vQae7-0000vT-Fd
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 19:23:04 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7b86e0d9615so7338706b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 16:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764721381; x=1765326181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gd0KWvCcV63RFImWGjcCMBVmotIXPRGLHBDmbO1O2k4=;
 b=plup31dUxm1wqysiFLrS+u7XUX93CbF7/HIzh+Fae26tDHV7RQRQeD4gme6HVOVYvN
 6rUub8Zi9lsdi6WQQdibAfgmw14ewh0o+9YlDMc8nzHhB/eCxYAkkgHPpucDPOVDH5Zo
 e58NxXPH/D5E6HQLpYYtZ8jxNZnMPEuZSlHEHKxVsXs3Cpwaj0tPI5FLApyf3o+asEl4
 onOGJHo7I2KhoHRkCvca2gQi/WwlDfcL/qi+C/Da44Sw6uww65ndT9pP5ic21tUlj9bW
 c3PplWXjVcjUECuFeActP8XdgT2edOYSTu6OTJe6k77yyl7SlIMaU3VEOx4KsQDzBcKR
 NFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764721381; x=1765326181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd0KWvCcV63RFImWGjcCMBVmotIXPRGLHBDmbO1O2k4=;
 b=LT8GKhELzgq6HyBSbhy7xk9GKsN5YwOHQZ1pIUDmSrpZKiVDyfTJnv92xvO3qyXKys
 G4xXBigrfvEuEvXHeS5+eYUTUtMV7uds7JMVf5dREKK5f8CDEHKIBO9uqxm72AFfNF37
 43FtS2S0KpYG6H2XJ24idfK+Dc1Hq4ATETgtSgRG4l7dx14ExAW58tF0U7TtJKh29qTp
 Z4ahxL8FRBBJrYyanKYzBtLwX9OiqOsmo86TMUXzVbuRMGRUB0MXz2rDivgj0Yll5+2O
 YHGwSUc1hpq2/uK1uO/JbAIy6abCmJdpnMnHBnzIoj4fyG8EAOmbtwDQQGoNlKK++WHO
 kAwA==
X-Gm-Message-State: AOJu0YyaP8mlu5kwL/VGOhL+w4XfCfdxl+td0Mfci2KFqFFxSw/GEUcf
 cABiSqaMsXqJ8cTpqy0YrDWSnUkm5HHiVLYnjJR9Dy6wXuBwxl0g51eXYdlXH4a01B4lUJLs2A0
 FAC4k
X-Gm-Gg: ASbGncvBhh6pAaMgcQNjfeqjzX0kPhwqp86g7N5agwkomsNam/5CZfvBYi44QhGCtSm
 gjcM+k/YLDaYmNFf67USo3tue8Pe38GceEK3+QiTSaaZlmVPmHo+IjKBR+bUD1guT/mLKMFoEpJ
 8W0uqrKUEZsTzfM3nB0SNpsA7EefueXoVw025mCIbmFODtGMzFj5QHQIwNuiuTE7XYzk8h5aK3l
 peIBBd3vaJ56y1QTKADlH0fqC5UzbtyDYs8Ttjngep/2XM5DblWV75V7B+1TeBQdnF108BkJIcv
 t0pXBfrBhWIzWr+7eK/ysbSJGCSpH1NqfRxPWmzTXRUveZVb+g9qoamHmL+Ut70o0BXx2kjNm7y
 e2J8y791fzHHyjSnD/E/1vzeuaZaOJXn535b4wRV310eJCmp62zxgCMHAxzDbfenAP6z0aLwSbG
 79+VWV7d9TIkGCjaj0HCM8f+fxMsJwiBWETZHmmnoQc5U8jBY36LD9f4sNYB/COlL7KHNgaKrHO
 bPSHBCsxQ2jsKRf8jC3UK9vJw==
X-Google-Smtp-Source: AGHT+IGuVl4btVJJT3VuWptosWRBoYhFtS2dClw1b7SGaJQvw7xqV8dylkWzbsryVNXxqy6D3bkVsQ==
X-Received: by 2002:a05:7022:1607:b0:11a:3734:3db3 with SMTP id
 a92af1059eb24-11df0cd7faemr310058c88.32.1764721381115; 
 Tue, 02 Dec 2025 16:23:01 -0800 (PST)
Received: from DESKTOP-I1ETA6N.dc1.ventanamicro.com
 (c-73-223-207-212.hsd1.ca.comcast.net. [73.223.207.212])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11dcb057cb0sm94148974c88.9.2025.12.02.16.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 16:23:00 -0800 (PST)
From: Tuan Phan <tphan@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Tuan Phan <tphan@ventanamicro.com>
Subject: [PATCH] hw/riscv/virt-acpi-build.c: Add TPM2 device node and ACPI
 table support
Date: Tue,  2 Dec 2025 16:22:59 -0800
Message-Id: <20251203002259.2856-1-tphan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=tphan@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Dec 2025 20:27:47 -0500
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

This patch enables TPM2 support in the RISC-V virt machine ACPI builder.

Signed-off-by: Tuan Phan <tphan@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb68339..b5bf812a9d36 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -32,6 +32,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/platform-bus.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
 #include "hw/virtio/virtio-acpi.h"
@@ -39,6 +40,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
+#include "system/tpm.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
@@ -224,6 +226,41 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, const MemMapEntry *iommu_memmap,
     aml_append(scope, dev);
 }
 
+#ifdef CONFIG_TPM
+static void acpi_dsdt_add_tpm(Aml *scope, RISCVVirtState *s)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(s->platform_bus_dev);
+    hwaddr pbus_base = s->memmap[VIRT_PLATFORM_BUS].base;
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
+    MemoryRegion *sbdev_mr;
+    hwaddr tpm_base;
+
+    if (!sbdev) {
+        return;
+    }
+
+    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    assert(tpm_base != -1);
+
+    tpm_base += pbus_base;
+
+    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
+
+    Aml *dev = aml_device("TPM0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs,
+               aml_memory32_fixed(tpm_base,
+                                  (uint32_t)memory_region_size(sbdev_mr),
+                                  AML_READ_WRITE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+#endif
+
 /*
  * Serial Port Console Redirection Table (SPCR)
  * Rev: 1.10
@@ -479,6 +516,10 @@ static void build_dsdt(GArray *table_data,
         acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
     }
 
+#ifdef CONFIG_TPM
+    acpi_dsdt_add_tpm(scope, s);
+#endif
+
     if (socket_count == 1) {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
@@ -914,6 +955,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
         }
     }
 
+#ifdef CONFIG_TPM
+    /* TPM info */
+    if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_tpm2(tables_blob, tables->linker,
+                   tables->tcpalog, s->oem_id,
+                   s->oem_table_id);
+    }
+#endif
+
     /* XSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
@@ -1025,6 +1076,11 @@ void virt_acpi_setup(RISCVVirtState *s)
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
 
+#ifdef CONFIG_TPM
+    fw_cfg_add_file(s->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
+                    acpi_data_len(tables.tcpalog));
+#endif
+
     qemu_register_reset(virt_acpi_build_reset, build_state);
     virt_acpi_build_reset(build_state);
     vmstate_register(NULL, 0, &vmstate_virt_acpi_build, build_state);
-- 
2.34.1


