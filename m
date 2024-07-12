Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C414C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5UB-0002pk-Rw; Thu, 11 Jul 2024 21:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sS5U9-0002ho-Ly
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sS5U6-0007El-9J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:09 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxL_G6jJBmj4QDAA--.10798S3;
 Fri, 12 Jul 2024 09:54:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnsezjJBmVSdFAA--.27574S4; 
 Fri, 12 Jul 2024 09:54:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL v2 2/8] hw/loongarch: Change the tpm support by default
Date: Fri, 12 Jul 2024 09:36:26 +0800
Message-Id: <20240712013632.3464731-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240712013632.3464731-1-gaosong@loongson.cn>
References: <20240712013632.3464731-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnsezjJBmVSdFAA--.27574S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Xianglai Li <lixianglai@loongson.cn>

Add devices that support tpm by default,
Fixed incomplete tpm acpi table information.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240624032300.999157-1-lixianglai@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/Kconfig      | 1 +
 hw/loongarch/acpi-build.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 90a0dba9d5..89be737726 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -8,6 +8,7 @@ config LOONGARCH_VIRT
     imply VIRTIO_VGA
     imply PCI_DEVICES
     imply NVDIMM
+    imply TPM_TIS_SYSBUS
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index af45ce526d..72bfc35ae6 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -646,6 +646,9 @@ void loongarch_acpi_setup(LoongArchVirtMachineState *lvms)
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
 
+    fw_cfg_add_file(lvms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
+                    acpi_data_len(tables.tcpalog));
+
     qemu_register_reset(acpi_build_reset, build_state);
     acpi_build_reset(build_state);
     vmstate_register(NULL, 0, &vmstate_acpi_build, build_state);
-- 
2.34.1


