Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F738CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdH3-0000Bk-3D; Fri, 21 Nov 2025 21:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdGz-00005J-4f; Fri, 21 Nov 2025 21:22:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdG7-0004dl-SM; Fri, 21 Nov 2025 21:22:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 265BA16C6DF;
 Fri, 21 Nov 2025 16:51:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74E49321956;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zejun Zhao <jelly.zhao.42@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 07/76] hw/riscv: Correct mmu-type property of sifive_u
 harts in device tree
Date: Fri, 21 Nov 2025 16:50:45 +0300
Message-ID: <20251121135201.1114964-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Zejun Zhao <jelly.zhao.42@gmail.com>

Correct mmu-type property of sifive_u harts from Sv48 to Sv39 in 64-bit
mode since it's the only supported SATP mode.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit e41139eaad1d6ea7c52b8ebb5def2dcb84ff57e1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d69f942cfb..3e1ed209ca 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -176,7 +176,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             if (is_32_bit) {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
             } else {
-                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv39");
             }
             riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
         } else {
-- 
2.47.3


