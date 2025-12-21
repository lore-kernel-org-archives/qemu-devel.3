Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908E2E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKJs-0004MO-6s; Sun, 21 Dec 2025 09:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKJ0-0003GM-UX
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKIy-0000gn-Pv
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=74zb+FExjdJPJZXYLz9xpbv7g8TXAM20uG6m9dgRS/Q=; b=n0pZA9GmBa0p6t1
 SpsITi2CKhxhaqGk5bi9y1w9VW9+2dGUbvGlwsVpop2ioaLw+bbH9nCOOpz5Sdrpywq+Z/9xlhuRW
 yR74gLcXnpLjrEnXgpgZMqHds4s2xFSaVlfzTEK4Nmc1835foNWMJwZTj4y+k0wEE4+GAJ3KN0pMY
 G4=;
Date: Sun, 21 Dec 2025 15:23:13 +0100
Subject: [PATCH v2 09/14] target/riscv: Replace TARGET_LONG_BITS in header
 exposed to common code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-hw-riscv-cpu-int-v2-9-eb49d72c5b2f@rev.ng>
References: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
In-Reply-To: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
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

IRQ_LOCAL_GUEST_MAX depends on TARGET_LONG_BITS and is used in
hw/intc/riscv_imsic.c.  The macro is replaced by a field in RISCVCPUDef
initialized in riscv_cpu_class_base_init().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h      |  1 +
 target/riscv/cpu_bits.h |  2 --
 hw/intc/riscv_imsic.c   |  4 +++-
 target/riscv/cpu.c      | 14 ++++++++++++--
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 946665d9ed..3573581f0c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -563,6 +563,7 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+    uint8_t irq_local_guest_max;
     const RISCVCSR *custom_csrs;
 } RISCVCPUDef;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..13e052bce2 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -809,8 +809,6 @@ typedef enum RISCVException {
 #define IRQ_S_GEXT                         12
 #define IRQ_PMU_OVF                        13
 #define IRQ_LOCAL_MAX                      64
-/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
-#define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
 
 /* RNMI causes */
 #define RNMI_MAX                           16
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 9274a1e842..3d32198468 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -453,13 +453,15 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
 {
     DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
     CPUState *cpu = cpu_by_arch_id(hartid);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(RISCV_CPU(cpu));
     uint32_t i;
 
     assert(!(addr & (IMSIC_MMIO_PAGE_SZ - 1)));
     if (mmode) {
         assert(num_pages == 1);
     } else {
-        assert(num_pages >= 1 && num_pages <= (IRQ_LOCAL_GUEST_MAX + 1));
+        assert(num_pages >= 1 &&
+               num_pages <= (mcc->def->irq_local_guest_max + 1));
     }
     assert(IMSIC_MIN_ID <= num_ids);
     assert(num_ids <= IMSIC_MAX_ID);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7a8b8d736e..dd58e63ecd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1019,6 +1019,7 @@ void riscv_add_satp_mode_properties(Object *obj)
 
 static void riscv_cpu_set_irq(void *opaque, int irq, int level)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
     RISCVCPU *cpu = RISCV_CPU(opaque);
     CPURISCVState *env = &cpu->env;
 
@@ -1053,7 +1054,7 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         default:
             g_assert_not_reached();
         }
-    } else if (irq < (IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX)) {
+    } else if (irq < (IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max)) {
         /* Require H-extension for handling guest local interrupts */
         if (!riscv_has_ext(env, RVH)) {
             g_assert_not_reached();
@@ -1100,7 +1101,7 @@ static void riscv_cpu_init(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
-                      IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
+                      IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max);
     qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
                             "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
@@ -2791,6 +2792,15 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def = g_new0(RISCVCPUDef, 1);
     }
 
+    /*
+     * RISCVCPUDef::irq_local_guest_max is initialized to 
+     * `target_long_bits()-1` due to bit zero of hgeip and hgeie
+     * being ROZ.
+     *
+     * This value does not vary between CPU types.
+     */
+    mcc->def->irq_local_guest_max = target_long_bits() - 1;
+
     if (data) {
         const RISCVCPUDef *def = data;
         mcc->def->bare |= def->bare;

-- 
2.51.0


