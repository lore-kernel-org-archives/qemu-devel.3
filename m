Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B81EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riWE6-00060N-0Z; Fri, 08 Mar 2024 04:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1riWE1-00060E-LP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:09:09 -0500
Received: from mail.kernel-space.org ([195.201.34.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1riWDw-00034M-NZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:09:09 -0500
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 1f39f6f6;
 Fri, 8 Mar 2024 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=s1; bh=WfrBjKyZG01ugPP3gB3fUo94jPE
 =; b=TH8yhEIt3Mem0UtNpzaZ1H3agG2uFKNBpcsNTeCFLj81ttY4nWV0dDXOdwu
 h5zO4wlYUjLf7Yk9cfwbGXiirxk8vackNUyjgQuZwG1jdYa55WVDX9MLosxij8v9
 4ytSc/DZfta6SNHDAsqJ3mY5Sa9ilAwYaR32RB/g+UzoF33E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from:to
 :cc:subject:date:message-id:mime-version
 :content-transfer-encoding; q=dns; s=s1; b=tc08dEKxLLxW13HLDhiAm
 pR128LdcvF0sbF1B8O6j2x7YguPL6g1GM8y6O+JHFNzOdj0+whiT4IPUdVMdwed2
 TB64MIQ1VRXku2Wp+ZDYY/rI23pzcAuhwgs73l6cr3KZ59Du7BhN1x2SnlurWzx3
 kv/EqCXvsgQyS+kJGugANI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709888789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zx3i0PGwjQuNRJXVuYQUYLMuwDJfetMtlusraMs/YLo=;
 b=U89Ma/pCrR7Kt/czhuGcNza1/8ctqI9Ak/uklP5bL1uwidh2kuo06ISGflVgqpE+2vMYdt
 tOYAri+r/TP4TbW8nEb/OWFO5zc4sMpHjOHpJAZ6vTawipDkVqWfDe0Gs9c9NGVamBbUHH
 hB/uxZ2HTuO72+dMCnkRAgsqs1lbkPw=
Received: from localhost.localdomain
 (host-79-51-238-97.retail.telecomitalia.it [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id b5a408a0
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 8 Mar 2024 09:06:29 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: huth@tuxfamily.org
Cc: qemu-devel@nongnu.org,
	Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2] hw/m68k/mcf5208: add support for reset
Date: Fri,  8 Mar 2024 10:08:12 +0100
Message-ID: <20240308090812.1316635-1-angelo@kernel-space.org>
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
 hw/m68k/mcf5208.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0cfb806c20..d8a38274d0 100644
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
@@ -185,13 +187,54 @@ static const MemoryRegionOps m5208_sys_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
+static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
+                               unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                  __func__, addr);
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
-    MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *iomem;
     m5208_timer_state *s;
     int i;
 
+    /* RCM */
+    iomem = g_new(MemoryRegion, 1);
+    memory_region_init_io(iomem, NULL, &m5208_rcm_ops, cpu,
+                          "m5208-rcm", 0x00000080);
+    memory_region_add_subregion(address_space, 0xfc0a0000, iomem);
     /* SDRAMC.  */
+    iomem = g_new(MemoryRegion, 1);
     memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
     /* Timers.  */
@@ -265,7 +308,7 @@ static void mcf5208evb_init(MachineState *machine)
     mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
     mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
 
-    mcf5208_sys_init(address_space_mem, pic);
+    mcf5208_sys_init(address_space_mem, pic, cpu);
 
     mcf_fec_init(address_space_mem, 0xfc030000, pic + 36);
 
-- 
2.44.0


