Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwqx-0007Yd-TH; Fri, 15 May 2026 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqG-0007Ip-2h
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:00:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqD-0001HR-SL
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=AMcqkz5A6CJzcdkas/7AWl9nwVdJve9KArgdY7RKNoE=; b=CulQySUyJu/LyIK
 1Jwh0DXSF5scNyLu1sZ/UhYegsZKhQTrsuFqW81L5ckn2COqj/fAEgm1JrkKC6iRdVEZqlAFm6YhF
 uNH4CfPgYhcmWgxnDaHorIaphy3qcKtOHOt8eQn+4cVynxLKxTo3YvGP1W4h/GkwIxoAsb7IjlxPs
 cY=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 07/27] target/riscv: Fix size of priv_ver and vext_ver
Date: Fri, 15 May 2026 20:04:17 +0200
Message-ID: <20260515180437.23620-8-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
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

Fix these fields to 32 bits, also update corresponding priv_ver field
in DisasContext as well as function arguments. 32 bits was chosen
since it's large enough to fit all stored values and int/int32_t is
used in RISCVCPUDef and a few functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 6 +++---
 target/riscv/machine.c   | 4 ++--
 target/riscv/translate.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 21f3400cd5..feacf19a5e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -239,8 +239,8 @@ struct CPUArchState {
 
     uint64_t guest_phys_fault_addr;
 
-    target_ulong priv_ver;
-    target_ulong vext_ver;
+    uint32_t priv_ver;
+    uint32_t vext_ver;
 
     /* RISCVMXL, but uint32_t for vmstate migration */
     uint32_t misa_mxl;      /* current mxl */
@@ -844,7 +844,7 @@ bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
 }
 
 static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
-                                              target_long priv_ver,
+                                              uint32_t priv_ver,
                                               uint32_t misa_ext)
 {
     /* In priv spec version 1.12 or newer, C always implies Zca */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 27034180c4..1cf744c5f0 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -439,8 +439,8 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT8(env.frm, RISCVCPU),
         VMSTATE_UINT64(env.badaddr, RISCVCPU),
         VMSTATE_UINT64(env.guest_phys_fault_addr, RISCVCPU),
-        VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
-        VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
+        VMSTATE_UINT32(env.priv_ver, RISCVCPU),
+        VMSTATE_UINT32(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
         VMSTATE_UNUSED(4),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1ea7faea4c..18a1e0ae99 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -59,7 +59,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     target_ulong cur_insn_len;
     target_ulong pc_save;
-    target_ulong priv_ver;
+    uint32_t priv_ver;
     RISCVMXL misa_mxl_max;
     RISCVMXL xl;
     RISCVMXL address_xl;
-- 
2.52.0


