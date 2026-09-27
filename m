Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048CEC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmRg-00067m-2e; Sun, 27 Sep 2026 06:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRE-0005tv-3D; Sun, 27 Sep 2026 06:48:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRC-00010P-BL; Sun, 27 Sep 2026 06:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=I6P4jic7x4ju6OfKPsETZKjI/JI/h8MJn9rP0A/HgTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OYYY10zyIid/pwKUkW7zorXSq4NyXkFh9Gm7JHFdfm4nYJhhjdzFMcssFp+DTCHc0
 qPBOjUUwh/FI3p/uaiQNqPMh3pOdtTCiBaCaxLmKQYMTh93KcSTwxeOBy2Mel5xOjS
 h2+WDHaD81ktTxxPAwZL/kdOfCkKsrI0n8dutezN9d0psG7ST+EJnZ0/U2YpHJnQqD
 hFLcxvoNePumcIIXxLvpYeCffSuSV4o4ZS11ujIwiAy4welFw1lYp2ezfPt3Ymg5XP
 Wm0hEDJeyQYZRNfwuMmv2fIsCWzWxL2lTn39KDgqn0taJP1gh1visjWnkbhxnEaeXR
 WMYKtYijahdZg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 592211D8B58;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 55E8243215F;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 43C905E768; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 57/92] hw/riscv/virt.c: fix aclint soc/mtimer
 nodename
Date: Sun, 27 Sep 2026 13:47:33 +0300
Message-ID: <20260927104821.196183-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Running 'dtc' to generate a readable fdt for the virt machine produce
warnings:

 $ dtc -I dtb -O dts virt.dtb > virt.dts
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"

This happens because the 'reg' field does not match the address in the
nodename.  The right fix, pointed out by Chao in [1], is to make the
nodename match the reg value:

"In the current QEMU implement, `addr` is the MTIMECMP base address,
while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."

In other words, the 'reg' value is correct but the nodename isn't.

We'll make the fix now, allowing the next patch to move the fixed version
of aclint FDT to fdt-common.

[1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/

Cc: qemu-stable@nongnu.org
Suggested-by: Chao Liu <chao.liu@processmission.com>
Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9d6ac47d3182f2bdadea4bed596c82759a167e67)
(Mjt: drop format string change (it was corrected in subsequent change),
  but keep the value change)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51bac47a91d..6707979169a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -286,7 +286,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
                (s->memmap[VIRT_CLINT].size * socket);
         size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
     }
-    name = g_strdup_printf("/soc/mtimer@%lx", addr);
+    name = g_strdup_printf("/soc/mtimer@%lx",
+                           addr + RISCV_ACLINT_DEFAULT_MTIME);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "riscv,aclint-mtimer");
-- 
2.47.3


