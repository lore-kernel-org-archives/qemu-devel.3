Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8D7C27C65
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:44:25 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf2I-0001AO-9j; Fri, 07 Jun 2024 15:14:03 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf2D-000169-Tq; Fri, 07 Jun 2024 15:14:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf2C-0001pb-5p; Fri, 07 Jun 2024 15:13:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E5056E545;
 Fri,  7 Jun 2024 22:14:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 80EE9E2742;
 Fri,  7 Jun 2024 22:13:09 +0300 (MSK)
Received: (nullmailer pid 528715 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "yang.zhang" <yang.zhang@hexintek.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 29/45] hw/intc/riscv_aplic: APLICs should add child
 earlier than realize
Date: Fri,  7 Jun 2024 22:12:48 +0300
Message-Id: <20240607191307.528622-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: "yang.zhang" <yang.zhang@hexintek.com>

Since only root APLICs can have hw IRQ lines, aplic->parent should
be initialized first.

Fixes: e8f79343cf ("hw/intc: Add RISC-V AIA APLIC device emulation")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240409014445.278-1-gaoshanliukou@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit c76b121840c6ca79dc6305a5f4bcf17c72217d9c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 6e816e33bf..ab23399a8d 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -975,16 +975,16 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     qdev_prop_set_bit(dev, "msimode", msimode);
     qdev_prop_set_bit(dev, "mmode", mmode);
 
+    if (parent) {
+        riscv_aplic_add_child(parent, dev);
+    }
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     if (!is_kvm_aia(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
-    if (parent) {
-        riscv_aplic_add_child(parent, dev);
-    }
-
     if (!msimode) {
         for (i = 0; i < num_harts; i++) {
             CPUState *cpu = cpu_by_arch_id(hartid_base + i);
-- 
2.39.2


