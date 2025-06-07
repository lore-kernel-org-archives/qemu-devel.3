Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65148C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 02:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNj2X-0000Ow-Em; Fri, 06 Jun 2025 22:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1uNj2V-0000OO-MF; Fri, 06 Jun 2025 22:12:07 -0400
Received: from mail-m16.yeah.net ([1.95.21.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1uNj2S-0000ZY-UC; Fri, 06 Jun 2025 22:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4G
 1Xzps8QKk9wVYdy6qJKAOzAXKYdZXFxT2+W20a0v4=; b=Jr8lcyX+wARI4FvBGw
 pFEbyebrVFUvlP/R9HsRcXD2PFnfO/w7esxDglBGNhRfSAI+HN8pQ15BLOXQiBp2
 ACQPbA7/RN1VhyNVfjbH0zt5EnQcYxZmXC51K+hyADsKpTP+NAvPPRjy+cYQYK0d
 NbeSGs0tHwVzgVya6SP+PFLvw=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgD3lzban0NoD9EbAA--.58043S3;
 Sat, 07 Jun 2025 10:11:41 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: dbarboza@ventanamicro.com,
	palmer@dabbelt.com,
	alistair23@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhangtj@tecorigin.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@yeah.net>,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v5 1/1] hw/riscv: fix PLIC hart topology configuration string
 when not getting CPUState correctly
Date: Sat,  7 Jun 2025 10:11:28 +0800
Message-ID: <e4750730e723642922021767946bf277765201a1.1749224867.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749224867.git.chao.liu@yeah.net>
References: <cover.1749224867.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgD3lzban0NoD9EbAA--.58043S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr48Kr1DKry5uFyrJrWrZrb_yoWrtw1UpF
 WUCrs0yrykGF9xuay3tFW8Gr47Cwnxur15twsrury3Ar4jyFW5ZanFkw1YyryrJFyrAa4j
 9rZ7u3WYy3WYkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaksgUUUUU=
X-Originating-IP: [124.128.76.86]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiNB0KMmhDn9230AAA3f
Received-SPF: pass client-ip=1.95.21.17; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
---
 hw/intc/sifive_plic.c      | 4 ++--
 hw/riscv/boot.c            | 4 ++--
 hw/riscv/microchip_pfsoc.c | 2 +-
 hw/riscv/sifive_u.c        | 2 +-
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/boot.h    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 3160b216fd..8e7ebc0655 100644
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
@@ -505,7 +505,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
 
     for (i = 0; i < plic->num_addrs; i++) {
         int cpu_num = plic->addr_config[i].hartid;
-        CPUState *cpu = qemu_get_cpu(cpu_num);
+        CPUState *cpu = cpu_by_arch_id(cpu_num);
 
         if (plic->addr_config[i].mode == PLICMode_M) {
             qdev_connect_gpio_out(dev, cpu_num - hartid_base + num_harts,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 828a867be3..aa775e846c 100644
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
index 2e74783fce..6c0e3b22af 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -274,7 +274,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 l2lim_mem);
 
     /* create PLIC hart topology configuration string */
-    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
+    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
 
     /* PLIC */
     s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d69f942cfb..c89dac0f21 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -829,7 +829,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
                                 l2lim_mem);
 
     /* create PLIC hart topology configuration string */
-    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
+    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cf280a92e5..d094bd186b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1289,7 +1289,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
     g_autofree char *plic_hart_config = NULL;
 
     /* Per-socket PLIC hart topology configuration string */
-    plic_hart_config = riscv_plic_hart_config_string(hart_count);
+    plic_hart_config = riscv_plic_hart_config_string(base_hartid, hart_count);
 
     /* Per-socket PLIC */
     return sifive_plic_create(
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
2.49.0


