Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310DBC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 09:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rit7K-0002Nm-79; Sat, 09 Mar 2024 04:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1rit7H-0002NT-R6
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 04:35:43 -0500
Received: from mail.kernel-space.org ([195.201.34.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1rit7F-0006ST-JB
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 04:35:43 -0500
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 109dc69e;
 Sat, 9 Mar 2024 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=s1; bh=hZwqIq0R7Q5x2X5pXNpiCWSKvo8
 =; b=TIXiyReUInSEht9pvtIBHlkQ6aREG0ttx9CbdO3jPccFvYSp9xPXpdCzrim
 F61xqMwvCZLTrazxsl2XPvLvbd+Nq7Y65xk3Ru9rfCLOjvmVclPaegzEUpJmZuIZ
 dS8ATEZKfXPrjSrITo3RSYtjOooNyXTKWohqBCpRjHI1FddM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from:to
 :cc:subject:date:message-id:mime-version
 :content-transfer-encoding; q=dns; s=s1; b=sMr9i97J4nbm492pCitQP
 5uFF68Bx07fUE5g5OwsmwV5ZS8dD1xJIk1HrONGM7KxXdPgGSC6sx+qlnkE7JZbE
 rUtjpUWXCclDbHBSv0JGWXifES4B9HPxgKQWHpJfrhHUej2gLQllTgBJqh1ZYdWZ
 8HxRHRijS4n52LSXbxgfj8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709976787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RhTm7ZUwb5pC4k/n/Wk7PbjmWWWIUggmraXNJnyAnvI=;
 b=M4eddSb0HjICV8GYysjrBJC5p1Gb649FseuQhXr5PSZEcP/sS2UIw8nRwwCNZISQCfadkU
 7FczYhERPqZkPhFAd/2M6shC/FB6LPK3AF88SBdmxWbacM/hGaEcyH6CkwPru449FhSPkV
 4iRASV2diO5NVGMJ5dSkrOpqeh1ZNu8=
Received: from localhost.localdomain
 (host-79-51-238-97.retail.telecomitalia.it [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id f60bb657
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 9 Mar 2024 09:33:07 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: huth@tuxfamily.org
Cc: qemu-devel@nongnu.org,
	Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v3] hw/m68k/mcf5208: add support for reset
Date: Sat,  9 Mar 2024 10:34:59 +0100
Message-ID: <20240309093459.984565-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.201.34.187;
 envelope-from=angelo@kernel-space.org; helo=mail.kernel-space.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add reset support for mcf5208.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 hw/m68k/mcf5208.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0cfb806c20..ec14096aa4 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -40,6 +40,8 @@
 #define PCSR_PRE_SHIFT  8
 #define PCSR_PRE_MASK   0x0f00
 
+#define RCR_SOFTRST     0x80
+
 typedef struct {
     MemoryRegion iomem;
     qemu_irq irq;
@@ -185,12 +187,50 @@ static const MemoryRegionOps m5208_sys_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
+static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
+                               unsigned size)
+{
+    return 0;
+}
+
+static void m5208_rcm_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    M68kCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    switch (addr) {
+    case 0x0: /* RCR */
+        if (value & RCR_SOFTRST) {
+            cpu_reset(cs);
+            cpu->env.aregs[7] = ldl_phys(cs->as, 0);
+            cpu->env.pc = ldl_phys(cs->as, 4);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps m5208_rcm_ops = {
+    .read = m5208_rcm_read,
+    .write = m5208_rcm_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
+                             M68kCPU *cpu)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *iomem_rcm = g_new(MemoryRegion, 1);
     m5208_timer_state *s;
     int i;
 
+    /* RCM */
+    memory_region_init_io(iomem_rcm, NULL, &m5208_rcm_ops, cpu,
+                          "m5208-rcm", 0x00000080);
+    memory_region_add_subregion(address_space, 0xfc0a0000, iomem_rcm);
     /* SDRAMC.  */
     memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
@@ -265,7 +305,7 @@ static void mcf5208evb_init(MachineState *machine)
     mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
     mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
 
-    mcf5208_sys_init(address_space_mem, pic);
+    mcf5208_sys_init(address_space_mem, pic, cpu);
 
     mcf_fec_init(address_space_mem, 0xfc030000, pic + 36);
 
-- 
2.44.0


