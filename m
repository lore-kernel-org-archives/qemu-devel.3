Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F952CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JnL-0005a7-PG; Wed, 24 Sep 2025 03:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnJ-0005Z1-9i
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnE-0003Qt-OD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FuP228aWvrb3rDWGtRNaGaKjMkqO5qyI+ksM3jM6RxE=; b=jluqcZPKYgS5Rv2
 0ElGQrOM/b1MrmXfdPk8g8w9xwqWIHN+PZxb4lopZXmsSF8+AOgmUC/UprMQF5Le+rDiF5r1CvTXw
 doOn5YeKHauhnbTysQzDI8a+a/6POUZguciZ4o4eP/A7J0SrsEQmEwL134Pl/4q+jAi10Jup/V/Ki
 cU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 16/34] target/riscv: Fix size of priv_ver and vext_ver
Date: Wed, 24 Sep 2025 09:21:06 +0200
Message-ID: <20250924072124.6493-17-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
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
index b36d596127..0f43887c74 100644
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
index 472b2dcd8f..9a2fd3267d 100644
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


