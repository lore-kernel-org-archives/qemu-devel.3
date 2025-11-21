Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1236CCFC52A
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 11:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcum-0000MS-At; Fri, 21 Nov 2025 20:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbsP-0004v9-Ml; Fri, 21 Nov 2025 19:53:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbsF-0000us-8g; Fri, 21 Nov 2025 19:53:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6219416CA45;
 Fri, 21 Nov 2025 21:44:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E044E321C81;
 Fri, 21 Nov 2025 21:44:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 10/81] target/riscv/kvm: fix env->priv setting in
 reset_regs_csr()
Date: Fri, 21 Nov 2025 21:43:09 +0300
Message-ID: <20251121184424.1137669-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This patch was originally made by Gitlab user Bo Gan (@ganboing) 4
months ago in the context of issue [1]. I asked the author to send a
patch to the mailing list ~3 months ago and got no reply. I'm sending
the patch myself because we already missed 10.1 without this fix.

I'll also just post verbatim Bo Gan comment in the commit msg:

"In RISCV Linux with KVM enabled, gdbstub is broken. The
get_physical_address isn't able to page-walk correctly and resolve the
physical page. This is due to that the vcpu is being treated as starting
in M mode even if KVM enabled. However, with KVM, the vcpu is actually
started in S mode. The mmu_idx will give 3 (M), instead of 1 (S),
resulting in Guest PA == VA (wrong)!"

Set env->priv to PRV_S in kvm_riscv_reset_regs_csr() since the VCPU is
always started in S-mode for KVM.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2991

Cc: qemu-stable@nongnu.org
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2991
Originally-by: Bo Gan (@ganboing in Gitlab)
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022111105.483992-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 2a21cbee47a124edf43fc9ee156d7093e2f957fd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 92240c6e4b..7b4a2aecbb 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -704,6 +704,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->satp = 0;
     env->scounteren = 0;
     env->senvcfg = 0;
+    env->priv = PRV_S;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.47.3


