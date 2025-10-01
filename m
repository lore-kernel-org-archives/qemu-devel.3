Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06028CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJO-0005jw-Dx; Wed, 01 Oct 2025 03:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJK-0005i3-Uv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:39 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIs-0003Uu-7U
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=WdP4pIfC7U4qeXInFso/6l/E/NaiO3xJOiQGSm8Ew2Y=; b=umChvy9mrqygXUG
 q+GeGYBstPEwECZHZyu5Wf9NzhU/aoBwxEU3M5dlKyQfvBQD8lO96SC0EBZkSwM6ORGrsEeGk9FZf
 0SITwCBDXrvvDHc2WrMikxMh7zuXTqrrd9shyP9RseOrFnkRQ59YQRwS6Wgipfk/IQ7mV6ZcqB7UQ
 fc=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 15/33] target/riscv: Fix size of priv_ver and vext_ver
Date: Wed,  1 Oct 2025 09:32:48 +0200
Message-ID: <20251001073306.28573-16-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix these fields to 32 bits, also update corresponding priv_ver field
in DisasContext as well as function arguments. 32 bits was chosen
since it's large enough to fit all stored values and int/int32_t is
used in RISCVCPUDef and a few functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h       | 6 +++---
 target/riscv/machine.c   | 4 ++--
 target/riscv/translate.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fcca4dfe49..83d516e510 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -238,8 +238,8 @@ struct CPUArchState {
 
     uint64_t guest_phys_fault_addr;
 
-    target_ulong priv_ver;
-    target_ulong vext_ver;
+    uint32_t priv_ver;
+    uint32_t vext_ver;
 
     /* RISCVMXL, but uint32_t for vmstate migration */
     uint32_t misa_mxl;      /* current mxl */
@@ -798,7 +798,7 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 #endif
 
 static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
-                                              target_long priv_ver,
+                                              uint32_t priv_ver,
                                               uint32_t misa_ext)
 {
     /* In priv spec version 1.12 or newer, C always implies Zca */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1bac57a60b..f1a0d16fdd 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -414,8 +414,8 @@ const VMStateDescription vmstate_riscv_cpu = {
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
index 339ef91f6b..10d39fd42a 100644
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
2.51.0


