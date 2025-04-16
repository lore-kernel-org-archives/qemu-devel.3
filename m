Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0865C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 04:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4upw-0008Kb-La; Wed, 16 Apr 2025 00:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u4upu-0008Hk-5a; Wed, 16 Apr 2025 00:57:22 -0400
Received: from out28-148.mail.aliyun.com ([115.124.28.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u4upq-0008CE-LJ; Wed, 16 Apr 2025 00:57:21 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cNtMemJ_1744779430 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 16 Apr 2025 12:57:10 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: palmer@dabbelt.com,
	alistair23@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zhangtj@tecorigin.com,
 zqz00548@tecorigin.com, lc00631@tecorigin.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 1/1] hw/riscv: fix PLIC hart topology configuration string
 when not getting CPUState correctly
Date: Wed, 16 Apr 2025 12:53:58 +0800
Message-ID: <07d62c9297d69d3330c8c75d54632d3a7f10cecb.1744776027.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1744776027.git.lc00631@tecorigin.com>
References: <cover.1744776027.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.148;
 envelope-from=lc00631@tecorigin.com; helo=out28-148.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

riscv_plic_hart_config_string() when getting CPUState via qemu_get_cpu()
should be consistent with keeping sifive_plic_realize()
by hartid_base + cpu_index.

A better approach is to use cpu_by_arch_id() instead of qemu_get_cpu(),
in riscv cpu_by_arch_id() uses the mhartid.

For non-numa or single-cluster machines, hartid_base should be 0.

Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
---
 hw/intc/sifive_plic.c      | 2 +-
 hw/riscv/boot.c            | 4 ++--
 hw/riscv/microchip_pfsoc.c | 2 +-
 hw/riscv/sifive_u.c        | 5 +++--
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/boot.h    | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index a5b0f6ef1b..0a91c5dca7 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -399,7 +399,7 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
      * hardware controlled when a PLIC is attached.
      */
     for (i = 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
+        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
         if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
             error_setg(errp, "SEIP already claimed");
             return;
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 765b9e2b1a..4cd29221c2 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -44,13 +44,13 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
  * Return the per-socket PLIC hart topology configuration string
  * (caller must free with g_free())
  */
-char *riscv_plic_hart_config_string(int hart_count)
+char *riscv_plic_hart_config_string(int hart_base, int hart_count)
 {
     g_autofree const char **vals = g_new(const char *, hart_count + 1);
     int i;
 
     for (i = 0; i < hart_count; i++) {
-        CPUState *cs = qemu_get_cpu(i);
+        CPUState *cs = cpu_by_arch_id(hart_base + i);
         CPURISCVState *env = &RISCV_CPU(cs)->env;
 
         if (kvm_enabled()) {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 9c846f9b5b..5269336346 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -275,7 +275,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 l2lim_mem);
 
     /* create PLIC hart topology configuration string */
-    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
+    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
 
     /* PLIC */
     s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 679f2024bc..516912c4f4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -790,10 +790,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
+    int hartid_base = 1;
     int i, j;
 
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
-    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", hartid_base);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", s->cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
 
@@ -829,7 +830,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
                                 l2lim_mem);
 
     /* create PLIC hart topology configuration string */
-    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
+    plic_hart_config = riscv_plic_hart_config_string(hartid_base, ms->smp.cpus);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e517002fdf..41fdfd2bc8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1280,7 +1280,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
     g_autofree char *plic_hart_config = NULL;
 
     /* Per-socket PLIC hart topology configuration string */
-    plic_hart_config = riscv_plic_hart_config_string(hart_count);
+    plic_hart_config = riscv_plic_hart_config_string(base_hartid, hart_count);
 
     /* Per-socket PLIC */
     ret = sifive_plic_create(
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 7d59b2e6c6..5937298646 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -40,7 +40,7 @@ typedef struct RISCVBootInfo {
 
 bool riscv_is_32bit(RISCVHartArrayState *harts);
 
-char *riscv_plic_hart_config_string(int hart_count);
+char *riscv_plic_hart_config_string(int hart_base, int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
 target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-- 
2.48.1


