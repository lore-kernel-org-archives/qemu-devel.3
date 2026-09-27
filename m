Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9702C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkqA-00015Q-Qf; Sun, 27 Sep 2026 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpc-0008Ug-F6; Sun, 27 Sep 2026 05:06:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpa-000868-Hu; Sun, 27 Sep 2026 05:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499956; bh=8lATwgFAZf0GaQqiWWyOkMjEM2htT3z1FKVo8PB+JPI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NQpaLQoQwI4GjPdMkPxb0pKUluSm2XGnMA7py6KuBVrxXxg1BCmRhc80cgd41LOND
 ARlOGeUST402GYkb4XInfB7jJ0wrCi7qKSqwp2JBrPA0cTsk/nIJRqSTpD5LWpBzWd
 eU/RHtwGy8AyKtQaEMRjjzzvDvfA1Ra0+NXhoKc1oU7hnBiyUz4zTTZru4wt4frWhG
 gW3Ubjr85q2mG8TKBUoOQrNjUwjrfHf/+17gPt0pY5xM8vE6eblfFJ/PJV5o69ZJIB
 Sb0fSU0PsZ4ah0Z2whdP1Dj+oAwnHKyY2dkH8B4l1hzoPCkMPd6LddRpUYr6mICD8w
 Pk0oro40COTYg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5FC61D8B0B;
 Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2E364320C4;
 Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CD2985E647; Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 58/86] hw/riscv/virt.c: fix aclint soc/mtimer
 nodename
Date: Sun, 27 Sep 2026 12:05:05 +0300
Message-ID: <20260927090540.102811-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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
index a1c323e66df..5dc4a787ee2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -406,7 +406,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
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


