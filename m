Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915821090221
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvv-0005Xy-HA; Thu, 19 Mar 2026 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38tK-0003IG-Fm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:38:07 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38tF-0001VG-Vp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:38:06 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bI6K017660;
 Thu, 19 Mar 2026 16:37:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 3/6] riscv: andes: Implement noncached memory using SBI PMA
Date: Thu, 19 Mar 2026 16:37:10 +0800
Message-ID: <20260319083713.3456894-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bI6K017660
Received-SPF: pass client-ip=60.248.187.195;
 envelope-from=ycliang@andestech.com; helo=Atcsqr.andestech.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Mar 2026 08:56:52 -0400
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
Reply-to:  Leo Yu-Chi Liang <ycliang@andestech.com>
From:  Leo Yu-Chi Liang via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement noncached memory region management for Andes RISC-V
platforms using SBI PMA (Physical Memory Attribute) calls:

- noncached_init(): Compute region below malloc area, probe PMA
  support via sbi_pma_probe(), then configure the region as
  non-cacheable bufferable using sbi_pma_set() with NAPOT and
  NON_CACHE_BUF flags.
- noncached_alloc(): Bump allocator from the noncached region.
- noncached_set_region(): No-op since PMA handles attributes.
- noncached_free(): Release PMA entry, with probe-before-free
  guard to avoid calling free on unsupported firmware.

Also call noncached_free() in cleanup_before_linux() before
cache_flush() so the PMA entry is released before handing off
to Linux.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andes/Makefile   |  1 +
 arch/riscv/cpu/andes/cpu.c      |  3 ++
 arch/riscv/cpu/andes/noncache.c | 79 +++++++++++++++++++++++++++++++++
 include/cpu_func.h              |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 arch/riscv/cpu/andes/noncache.c

diff --git a/arch/riscv/cpu/andes/Makefile b/arch/riscv/cpu/andes/Makefile
index 35a1a2fb836..f3602f6f598 100644
--- a/arch/riscv/cpu/andes/Makefile
+++ b/arch/riscv/cpu/andes/Makefile
@@ -6,3 +6,4 @@
 obj-y	:= cpu.o
 obj-y	+= cache.o
 obj-y	+= spl.o
+obj-$(CONFIG_SYS_HAS_NONCACHED_MEMORY) += noncache.o
diff --git a/arch/riscv/cpu/andes/cpu.c b/arch/riscv/cpu/andes/cpu.c
index feb755a4f0d..3aa89d86b6b 100644
--- a/arch/riscv/cpu/andes/cpu.c
+++ b/arch/riscv/cpu/andes/cpu.c
@@ -22,6 +22,9 @@ int cleanup_before_linux(void)
 {
 	disable_interrupts();
 
+	if (IS_ENABLED(CONFIG_SYS_HAS_NONCACHED_MEMORY))
+		noncached_free();
+
 	cache_flush();
 
 	return 0;
diff --git a/arch/riscv/cpu/andes/noncache.c b/arch/riscv/cpu/andes/noncache.c
new file mode 100644
index 00000000000..9886a757620
--- /dev/null
+++ b/arch/riscv/cpu/andes/noncache.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Andes Technology Corporation
+ * Rick Chen, Andes Technology Corporation <rick@andestech.com>
+ */
+
+#include <cpu_func.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/sbi.h>
+#include <asm/system.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+static unsigned long noncached_start;
+static unsigned long noncached_end;
+static unsigned long noncached_next;
+
+void noncached_set_region(void)
+{
+}
+
+int noncached_init(void)
+{
+	phys_addr_t start, end;
+	size_t size;
+	int ret;
+
+	/* If this calculation changes, update board_f.c:reserve_noncached() */
+	end = ALIGN(mem_malloc_start, MMU_SECTION_SIZE) - MMU_SECTION_SIZE;
+	size = ALIGN(CONFIG_SYS_NONCACHED_MEMORY, MMU_SECTION_SIZE);
+	start = end - size;
+
+	debug("mapping memory %pa-%pa non-cached\n", &start, &end);
+
+	ret = sbi_pma_probe();
+	if (ret <= 0) {
+		debug("PMA probe failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = sbi_pma_set(start, size,
+			  ANDES_PMACFG_ETYP_NAPOT |
+			  ANDES_PMACFG_MTYP_MEM_NON_CACHE_BUF);
+	if (ret) {
+		debug("PMA set failed: %d\n", ret);
+		return ret;
+	}
+
+	noncached_start = start;
+	noncached_end = end;
+	noncached_next = start;
+
+	return 0;
+}
+
+phys_addr_t noncached_alloc(size_t size, size_t align)
+{
+	phys_addr_t next = ALIGN(noncached_next, align);
+
+	if (next >= noncached_end || (noncached_end - next) < size)
+		return 0;
+
+	debug("allocated %zu bytes of uncached memory @%pa\n", size, &next);
+	noncached_next = next + size;
+
+	return next;
+}
+
+void noncached_free(void)
+{
+	if (!noncached_start)
+		return;
+
+	if (sbi_pma_probe() <= 0)
+		return;
+
+	sbi_pma_free(noncached_start);
+}
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 70a41ead3f7..061d497d454 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -100,6 +100,7 @@ int noncached_init(void);
 void noncached_set_region(void);
 
 phys_addr_t noncached_alloc(size_t size, size_t align);
+void noncached_free(void);
 
 enum {
 	/* Disable caches (else flush caches but leave them active) */
-- 
2.34.1


