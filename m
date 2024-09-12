Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE36EEED601
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojZm-0003K9-GH; Thu, 12 Sep 2024 09:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sojZj-00039M-KB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sojZg-0004q3-Qw
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxSOkE6OJm8eQFAA--.12716S3;
 Thu, 12 Sep 2024 21:09:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front2 (Coremail) with SMTP id qciowMDxl8Xr5+JmR8MFAA--.9219S8;
 Thu, 12 Sep 2024 21:09:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PULL 6/7] hw/loongarch: virt: pass random seed to fdt
Date: Thu, 12 Sep 2024 20:51:31 +0800
Message-Id: <20240912125132.268802-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240912125132.268802-1-gaosong@loongson.cn>
References: <20240912125132.268802-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8Xr5+JmR8MFAA--.9219S8
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
initialize early. Set this using the usual guest random number
generation function.

This is the same procedure that's done in b91b6b5a2c ("hw/microblaze:
pass random seed to fdt"), e4b4f0b71c ("hw/riscv: virt: pass random seed
to fdt"), c6fe3e6b4c ("hw/openrisc: virt: pass random seed to fdt"),
67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry"), c287941a4d
("hw/rx: pass random seed to fdt"), 5e19cc68fb ("hw/mips: boston: pass
random seed to fdt"), 6b23a67916 ("hw/nios2: virt: pass random seed to fdt")
c4b075318e ("hw/ppc: pass random seed to fdt"), and 5242876f37
("hw/arm/virt: dt: add rng-seed property").

These earlier commits later were amended to rerandomize the RNG seed on
snapshot load, but the LoongArch code somehow already does that, despite
not having this patch here, presumably due to some lucky copy and
pasting.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240905153316.2038769-1-Jason@zx2c4.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 76dd29a391..81b1f9486f 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -48,6 +48,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "qemu/guest-random.h"
 
 static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
@@ -303,6 +304,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
 static void create_fdt(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
+    uint8_t rng_seed[32];
 
     ms->fdt = create_device_tree(&lvms->fdt_size);
     if (!ms->fdt) {
@@ -316,6 +318,10 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
     qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
+
+    /* Pass seed to RNG */
+    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
 }
 
 static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
-- 
2.34.1


