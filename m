Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FAAC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wileR-0006d8-Vb; Sun, 12 Jul 2026 00:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wileR-0006am-3Z; Sun, 12 Jul 2026 00:18:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wileP-0006ag-Ft; Sun, 12 Jul 2026 00:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=+FR8wz4KKUliuwCuouh/wAFEggyzulrk6oUFPWA1z5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MeaY17z36ehtBMB2KOKMd114h4J/9gSRsGvIzG4iOnVKX9NPkP2DoqJt2gh82yuy0
 3tfhneN7p8V8bDSF5o0GBfEwUuzVHsnlrpDDexU+See4H2UNefhJKQGLbjpKCjzTfQ
 wdZfR6Q7EzBSeDwkNapAILojSFvVMLeaothIQl/+srasY5eUku4oTvsVJxsA8vvM4f
 lwNg96ii4NuoA4rJQ+z0o8+/vnCdJX8j2hod3t57LSjM8QmApZbXDY6GTxLkGbgzTl
 1MxWSj31lQfIBKDUggbY8Y36BJ4p8kU06h+JqI+jrDJ66BuSmX9veTWge50fRS5A1V
 NrKAwpxOaLtcA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B3301C0BF8;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DF443EB958;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 58363133F3; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Qingwei Hu <qingwei.hu@bytedance.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Sunil V L <sunilvl@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 29/75] hw/riscv/virt-acpi-build: Fix RINTC PLIC
 context ID for KVM
Date: Sun, 12 Jul 2026 07:14:47 +0300
Message-ID: <20260712041539.108341-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Qingwei Hu <qingwei.hu@bytedance.com>

Each RISC-V MADT RINTC entry contains an External Interrupt Controller
ID field. On the virt machine without AIA, this field identifies the
S-mode PLIC context associated with the hart.

TCG virt has both M-mode and S-mode PLIC contexts, so the S-mode context
ID is odd and 2 * local_cpu_id + 1 is correct. KVM virt exposes only
S-mode PLIC contexts, and those contexts are numbered contiguously from
0. Reporting the TCG context ID for KVM makes the guest enable a
different PLIC context from the one used by QEMU.

With ACPI enabled, this can leave PCI INTx interrupts pending in QEMU
while the guest-programmed PLIC context remains disabled. A virtio-blk
root disk can then stall during boot because its first interrupt is never
delivered.

Use local_cpu_id for KVM and keep the existing odd S-mode context ID for
TCG.

Fixes: d641da6ed43 ("hw/riscv/virt-acpi-build.c: Add PLIC in MADT")
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Message-ID: <20260604120017.398890-1-qingwei.hu@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit fdfcd98f6656b0cf425475bd8ce7f4c08adf8ca6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index e2b8229168d..b14c1c8e8c5 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -100,6 +100,8 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
         build_append_int_noprefix(entry,
                                   ACPI_BUILD_INTC_ID(
                                       arch_ids->cpus[uid].props.node_id,
+                                      kvm_enabled() ?
+                                      local_cpu_id :
                                       2 * local_cpu_id + 1),
                                   4);
     } else {
-- 
2.47.3


