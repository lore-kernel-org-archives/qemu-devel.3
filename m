Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB3ACD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgNZ-0004tB-3E; Wed, 20 May 2026 08:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgN6-0004ZO-Ci; Wed, 20 May 2026 08:50:08 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgN1-0002cg-R3; Wed, 20 May 2026 08:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1iruL33lAUwm3VAULC9tHN/eVySDMJCXDMHGEP/IDUI=; b=nbzelfvZT4fj6UV
 1EqJdWC9v7tADPVCoaZW8IZri1LvDh7EQ6noxExohfnYXnK/IL/3H/1fh4wwyEOulDS2+HCQw7iUS
 PNkA9vh/bwJH/INpSF1Hofe5RHbR5A4wDyLHCrjv7sCbkdnKrizeJXaXMRcp7pspuzxUv6ntYNAiV
 +I=;
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v7 06/27] target/riscv: Fix size of guest_phys_fault_addr
Date: Wed, 20 May 2026 14:53:44 +0200
Message-ID: <20260520125406.28693-7-anjo@rev.ng>
In-Reply-To: <20260520125406.28693-1-anjo@rev.ng>
References: <20260520125406.28693-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Widen to 64 bits, and use hwaddr as argument to get_physical_address().

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 3 +--
 target/riscv/machine.c    | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3c7d4acff2..21f3400cd5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -237,7 +237,7 @@ struct CPUArchState {
     uint64_t badaddr;
     uint64_t bins;
 
-    target_ulong guest_phys_fault_addr;
+    uint64_t guest_phys_fault_addr;
 
     target_ulong priv_ver;
     target_ulong vext_ver;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6236f65ff8..752fb7c71d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1236,7 +1236,7 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *ret_prot, vaddr addr,
-                                target_ulong *fault_pte_addr,
+                                hwaddr *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage,
                                 bool is_debug, bool is_probe)
@@ -1840,7 +1840,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
                                    mmu_idx, true, true, false, probe);
-
         /*
          * A G-stage exception may be triggered during two state lookup.
          * And the env->guest_phys_fault_addr has already been set in
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index b047321073..27034180c4 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -438,7 +438,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.load_val, RISCVCPU),
         VMSTATE_UINT8(env.frm, RISCVCPU),
         VMSTATE_UINT64(env.badaddr, RISCVCPU),
-        VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
+        VMSTATE_UINT64(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
-- 
2.52.0


