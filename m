Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EBBCD5BCC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEUH-0004Rt-16; Thu, 05 Sep 2024 11:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smEUE-0004RN-UI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:33:30 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smEUD-0007BW-8j
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:33:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7FE5FA43FC7;
 Thu,  5 Sep 2024 15:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FA9C4CEC3;
 Thu,  5 Sep 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="bWw30yip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725550405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vv5plqd3K6cDeYPYJezVDbij64Zd5z2QhUKwGLG38AE=;
 b=bWw30yip41IOAuT3PdVYwLeGr5Bgfblwybo2+FnY/5dLFfP34EIDMT5W9pzQ4xZ+w0XBgJ
 UQLfBXmg1lW7sKtTRBkRfAOGu5/UVkj8ZYlwos/ysYOOkmcdwdDUc2TyMtabXO50xIYxSL
 PmQVXi3rmsLESXqGnIjvurVAWWW3RhY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 065ef099
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 5 Sep 2024 15:33:24 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: gaosong@loongson.cn, jiaxun.yang@flygoat.com, qemu-devel@nongnu.org,
 thomas@t-8ch.de, xry111@xry111.site, maobibo@loongson.cn
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] hw/loongarch: virt: pass random seed to fdt
Date: Thu,  5 Sep 2024 17:33:16 +0200
Message-ID: <20240905153316.2038769-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 hw/loongarch/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 29040422aa..0f0b7df205 100644
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
2.46.0


