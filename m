Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4143FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrB-0005Al-Of; Thu, 30 Apr 2026 05:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqy-0004nI-Ri
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqk-0002Xp-SV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-449e96a8a80so37064f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541905; x=1778146705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3VHUpeET5mE4ABlG1aCJty2zCZSCJVxDWKrB9qKNsA=;
 b=wRiPBilhEdV2bqIYOVxmKDq4TYM0/WdHxxzwXLo7JYziuDC6ACzGd2Dy+qoslx22vs
 FSUrFe1HhZdp/6+D0KBzWBaFD5HWNpmsRMO5kqhKUyeKzRMLiI9wHWU+/X16f7y6KWaU
 BWJFlrJfsOTmZOTI57MPbuuFDk1hdYhpNDuVYQd+gn6bGMJhDQdblJmObDP5vLVozzdg
 vur9ZqvXqgByWtOj06QHH3sN7USILjQcxgn/uqlx+GAYT+1FImEDs5zs1grHD5JeTqH7
 dKyn4Gka64gMwSVh1+/qw2W+MlZ1BL/EAnE6IbxaqRc0EVpg3OsBzPTjRfdm4jyMIEC7
 3e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541905; x=1778146705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a3VHUpeET5mE4ABlG1aCJty2zCZSCJVxDWKrB9qKNsA=;
 b=jELFOTGPn9iu3SYy5+7PJ4CwKa3iJHsK9AupgIONeeT6NnLnW06yPK84e9kJG1GLvz
 OY5jSra1WxsZjNRQB1eMYuV2u8D0hpvOqPFcJQUQ5yzuEEWMqGXwZowlAXrCGMIpBgQ7
 Qr+BqSRfjcH+Eq8HpLaBPb0Zv1e4fPuaGmQN/Xl70pQfvE74EL1fPbqv+Goe+76dLWi1
 mlYwWLAHqHC7zsbUClYh97ZoDtCMVqYzE2t7xdrNxRJ+TKmqQRlZPYgtwlkrhcTTVceG
 BI//4t0Pi2sklgWGiN7RW7wwRlrHlflM6TQYD6W5nxj/ivH4vS8WbRXKJRBZNh0/gYPG
 4CnA==
X-Gm-Message-State: AOJu0YxPxWmcRtDOecbe+PNt+9eOxHkSNzA1RF9K1QIZ1/jJJP71ozzs
 xA0Q/vJFRm+hY8/tadAwbwNAlj3ipvjvHTLmu7Zdail2Ym2Fnk5dsFw/PgpJ95QfC4EBhoG9zaG
 tywT/
X-Gm-Gg: AeBDietb0aHrdtezMXOPR3YXj1icmfesY+X7nFpi9T+eAS5bVm2tnMZxMNR/+7z6tU+
 BRC4X6TqjBXNI5V0sbkr1inbkidxvsJ1tOwTTuuYq7aqgwGWjMP1M1dFjp0uUHwzSso+KVgmj0c
 JxYy16RLKf7vAqlygqpIyglOKWbcawOTiFLBJkLBBS6PWRwNvQg9XaWfzYO7h3yic+FiDZAtK4G
 wV0ZzFRXxPewpAB0DPGR0CZfnHdQ4/gY3j11eHlYPK1x4KjlFZ37MgZt5ghRfZp0eWH4YMwzauT
 EcTq719iipReCt9JuhvWyMoKxWJPiEaCc7EHIIbx7o7qIbXwWBmQvgSAqNNoeVtepuNAVfvi/w5
 MI5N3/crdnBGj4E1yU7jRccgS62xVVT1FcmvSL54sjqFeusviAaInAqIRclVc/A4zv2a2QWr2qK
 TX7db61j+2u/vOrazyflbHGvShXGtpA/u6fUecTDg0KhDkrMUmJPKo1Qo4T14OWW/TbGGmDeGwz
 7aVXz5AkNJPCfKBizl6TR2F2ysdneK4o6CZqvXdmA==
X-Received: by 2002:a05:6000:1789:b0:43d:1df7:ed24 with SMTP id
 ffacd0b85a97d-4493f42ce1amr3240933f8f.21.1777541905086; 
 Thu, 30 Apr 2026 02:38:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 10/25] target: Rename cpu_get_phys_page_{,attrs_}debug
Date: Thu, 30 Apr 2026 10:37:55 +0100
Message-ID: <20260430093810.2762539-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename cpu_phys_page_debug() and cpu_phys_page_attrs_debug() to
cpu_phys_addr_debug() and cpu_phys_addr_attrs_debug().

Commit created with:
 sed -i -e 's/cpu_get_phys_page_debug/cpu_get_phys_addr_debug/g;s/cpu_get_phys_page_attrs_debug/cpu_get_phys_addr_attrs_debug/g' $(git grep -l cpu_get_phys_page)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-10-peter.maydell@linaro.org
---
 hw/core/cpu-system.c        | 6 +++---
 hw/i386/vapic.c             | 4 ++--
 hw/xtensa/sim.c             | 2 +-
 hw/xtensa/xtfpga.c          | 2 +-
 include/hw/core/cpu.h       | 8 ++++----
 monitor/hmp-cmds.c          | 2 +-
 plugins/api.c               | 2 +-
 system/physmem.c            | 2 +-
 target/sparc/mmu_helper.c   | 6 +++---
 target/xtensa/xtensa-semi.c | 2 +-
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 93dc861083..05c126ecb6 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -55,7 +55,7 @@ bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
     return false;
 }
 
-hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
     hwaddr paddr;
@@ -73,11 +73,11 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
     return paddr;
 }
 
-hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
+hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
 {
     MemTxAttrs attrs = {};
 
-    return cpu_get_phys_page_attrs_debug(cpu, addr, &attrs);
+    return cpu_get_phys_addr_attrs_debug(cpu, addr, &attrs);
 }
 
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 3738031a05..225f19a75c 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -173,7 +173,7 @@ static int find_real_tpr_addr(VAPICROMState *s, CPUX86State *env)
      * virtual address space for the APIC mapping.
      */
     for (addr = 0xfffff000; addr >= 0x80000000; addr -= TARGET_PAGE_SIZE) {
-        paddr = cpu_get_phys_page_debug(cs, addr);
+        paddr = cpu_get_phys_addr_debug(cs, addr);
         if (paddr != APIC_DEFAULT_ADDRESS) {
             continue;
         }
@@ -305,7 +305,7 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
 
     /* find out virtual address of the ROM */
     rom_state_vaddr = s->rom_state_paddr + (ip & 0xf0000000);
-    paddr = cpu_get_phys_page_debug(cs, rom_state_vaddr);
+    paddr = cpu_get_phys_addr_debug(cs, rom_state_vaddr);
     if (paddr == -1) {
         return -1;
     }
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 994460d041..32eb16442f 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -41,7 +41,7 @@ static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
 
-    return cpu_get_phys_page_debug(CPU(cpu), addr);
+    return cpu_get_phys_addr_debug(CPU(cpu), addr);
 }
 
 static void sim_reset(void *opaque)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5e509216df..256497e162 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -192,7 +192,7 @@ static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
 
-    return cpu_get_phys_page_debug(CPU(cpu), addr);
+    return cpu_get_phys_addr_debug(CPU(cpu), addr);
 }
 
 static void xtfpga_reset(void *opaque)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 207a7a1bec..9d6b4fd697 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -745,7 +745,7 @@ enum CPUDumpFlags {
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 /**
- * cpu_get_phys_page_attrs_debug:
+ * cpu_get_phys_addr_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
  * @addr: The virtual address.
  * @attrs: Updated on return with the memory transaction attributes to use
@@ -757,11 +757,11 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
  *
  * Returns: Corresponding physical page address or -1 if no page found.
  */
-hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs);
 
 /**
- * cpu_get_phys_page_debug:
+ * cpu_get_phys_addr_debug:
  * @cpu: The CPU to obtain the physical page address for.
  * @addr: The virtual address.
  *
@@ -770,7 +770,7 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
  *
  * Returns: Corresponding physical page address or -1 if no page found.
  */
-hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
 /** cpu_asidx_from_attrs:
  * @cpu: CPU
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bc26b39d70..e6d8322bcc 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -720,7 +720,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
+    gpa  = cpu_get_phys_addr_debug(cs, addr & TARGET_PAGE_MASK);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
diff --git a/plugins/api.c b/plugins/api.c
index 0c348a789b..4b6fad4999 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -619,7 +619,7 @@ bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
 #ifdef CONFIG_SOFTMMU
     g_assert(current_cpu);
 
-    uint64_t res = cpu_get_phys_page_debug(current_cpu, vaddr);
+    uint64_t res = cpu_get_phys_addr_debug(current_cpu, vaddr);
 
     if (res == (uint64_t)-1) {
         return false;
diff --git a/system/physmem.c b/system/physmem.c
index c58d940e80..652b03ad5f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4041,7 +4041,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         MemTxResult res;
 
         page = addr & TARGET_PAGE_MASK;
-        phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
+        phys_addr = cpu_get_phys_addr_attrs_debug(cpu, page, &attrs);
         asidx = cpu_asidx_from_attrs(cpu, attrs);
         /* if no physical page mapped, return an error */
         if (phys_addr == -1)
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 34b212a7aa..e1abd520c4 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -366,20 +366,20 @@ void dump_mmu(CPUSPARCState *env)
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
         pde = mmu_probe(env, va, 2);
         if (pde) {
-            pa = cpu_get_phys_page_debug(cs, va);
+            pa = cpu_get_phys_addr_debug(cs, va);
             qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
                         " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
-                    pa = cpu_get_phys_page_debug(cs, va1);
+                    pa = cpu_get_phys_addr_debug(cs, va1);
                     qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
                                 HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
                                 va1, pa, pde);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
-                            pa = cpu_get_phys_page_debug(cs, va2);
+                            pa = cpu_get_phys_addr_debug(cs, va2);
                             qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
                                         HWADDR_FMT_plx " PTE: "
                                         TARGET_FMT_lx "\n",
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 28dfb29cbd..9a6a9c8b4e 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -215,7 +215,7 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t len_done = 0;
 
             while (len > 0) {
-                hwaddr paddr = cpu_get_phys_page_debug(cs, vaddr);
+                hwaddr paddr = cpu_get_phys_addr_debug(cs, vaddr);
                 uint32_t page_left =
                     TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
                 uint32_t io_sz = page_left < len ? page_left : len;
-- 
2.43.0


