Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEA0C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 00:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAywu-0001Ko-I1; Sun, 27 Sep 2026 20:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xAy93-00050W-Vk; Sun, 27 Sep 2026 19:18:57 -0400
Received: from vmexit.de ([2a0a:4cc0:c1:d4ba::2] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xAy92-0001c8-0s; Sun, 27 Sep 2026 19:18:57 -0400
From: Ralf Ramsauer <ralf@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1790551129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LSVcCaB/lC+MLtJl6kRphvXsrliN21Zj5Sg5dUFUWHk=;
 b=kNyhf5jfvAC9Qel0jt8age10w9epG1s8XT44qKqS+ffSOUB59X+jlq7MKB5rwG5+XIlTCl
 e3VD4/4ohXDvWXtAnMQe/Q4yr/BtMLM/vO/R04CZw/7MVEEHlpGjWkOPTwVskjo/+1SMaf
 2fql0WEV31uhOiCToBwnKk2ctkXxyMo=
To: qemu-devel@nongnu.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] hw/riscv/virt: only describe PLIC contexts that exist
Date: Mon, 28 Sep 2026 01:18:37 +0200
Message-ID: <20260927231838.236616-1-ralf@vmexit.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a0a:4cc0:c1:d4ba::2; envelope-from=ralf@vmexit.de;
 helo=gizmo.vmexit.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 27 Sep 2026 20:10:26 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

The PLIC device is created from the topology string built by
riscv_plic_hart_config_string(), which gives a hart a supervisor context
only if that hart actually has supervisor mode.  The device tree, in
contrast, lists a machine and a supervisor context for every hart,
unconditionally.

The two have disagreed since commit 7d10ff8a4d ("hw/riscv: virt: Use the
PLIC config helper function") taught the device about harts without
S-mode and left the device tree behind.  Boot with

    -cpu rv64,s=false,u=false -smp 4

and the PLIC implements four contexts while the device tree advertises
eight.  Contexts are numbered by their position in 'interrupts-extended',
so a guest that takes its context number from the property gets it wrong
for every hart but the first: hart 1 drives the context of hart 2, and
the upper harts address contexts the PLIC never created.  This is what an
M-mode kernel on the virt machine runs into; sifive_u already omits the
supervisor entry for its management hart.

Emit the supervisor entry only for the harts that have supervisor mode.

Fixes: 7d10ff8a4d ("hw/riscv: virt: Use the PLIC config helper function")
Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 hw/riscv/virt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..d0ce9dc862 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -165,14 +165,23 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
             plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
         }
    } else {
-        cells_length = s->soc[socket].num_harts * 4;
-        plic_cells = g_new0(uint32_t, cells_length);
+        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
+        cells_length = 0;
 
         for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
-            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+            CPURISCVState *env = &s->soc[socket].harts[cpu].env;
+
+            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
+            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
+
+            /*
+             * The PLIC implements a supervisor context only for harts that
+             * have supervisor mode, see riscv_plic_hart_config_string().
+             */
+            if (riscv_has_ext(env, RVS)) {
+                plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
+                plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
+            }
         }
     }
 

base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
-- 
2.54.0


