Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE16CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 07:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy3Vg-0002KQ-CO; Mon, 15 Sep 2025 03:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uy3VZ-0002IB-OB
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uy3VG-0000KP-B6
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:17 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_tITvsdo8GwKAA--.22255S3;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxVOQSvsdoXteWAA--.24724S4;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/8] hw/loongarch/virt: Add field ram_end in
 LoongArchVirtMachineState
Date: Mon, 15 Sep 2025 15:19:40 +0800
Message-Id: <20250915071946.315171-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250915071946.315171-1-maobibo@loongson.cn>
References: <20250915071946.315171-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxVOQSvsdoXteWAA--.24724S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DRAM region is dynamically set and the last valid physical address
region with LoongArch Virt Machine. To record the last valid physical
address, field ram_end is added in structure LoongArchVirtMachineState.
In future PCIE 64-bit MMIO region will start next from DRAM memory
region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 2 ++
 include/hw/loongarch/virt.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 31215b7785..76e43c5f71 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -755,8 +755,10 @@ static void virt_init(MachineState *machine)
             exit(EXIT_FAILURE);
         }
         machine_memory_devices_init(machine, base, device_mem_size);
+        base += device_mem_size;
     }
 
+    lvms->ram_end = base;
     /* load the BIOS image. */
     virt_firmware_init(lvms);
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 602feab0f0..8b970d1753 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -65,6 +65,7 @@ struct LoongArchVirtMachineState {
     DeviceState *extioi;
     struct memmap_entry *memmap_table;
     unsigned int memmap_entries;
+    hwaddr ram_end;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.39.3


