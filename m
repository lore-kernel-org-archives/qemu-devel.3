Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A41090222
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvu-0005Xb-SM; Thu, 19 Mar 2026 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38pT-0001Gt-6j
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:34:07 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38pR-0000w3-5i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:34:06 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8XlCB016335;
 Thu, 19 Mar 2026 16:33:47 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:33:47 +0800
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <me@ziyao.cc>, <anshuld@ti.com>, <xypron.glpk@gmx.de>,
 <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] riscv: Add CSR detection support
Date: Thu, 19 Mar 2026 16:33:38 +0800
Message-ID: <20260319083339.3429776-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8XlCB016335
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

Add a lightweight mechanism to safely probe CSRs that may not exist
on the current hart. This is useful for detecting optional extensions
(e.g. Smstateen) without relying on MARCHID or ISA string parsing.

The implementation consists of:
- A minimal expected trap handler (__riscv_expected_trap) that advances
  past the faulting instruction and signals the trap via register a4.
- csr_read_allowed() and csr_write_allowed() macros that temporarily
  swap the trap vector, attempt the CSR access, and report whether it
  trapped.

Ported from OpenSBI's sbi_csr_detect.h mechanism.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/include/asm/csr_detect.h | 90 +++++++++++++++++++++++++++++
 arch/riscv/lib/Makefile             |  1 +
 arch/riscv/lib/csr_detect.S         | 23 ++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 arch/riscv/include/asm/csr_detect.h
 create mode 100644 arch/riscv/lib/csr_detect.S

diff --git a/arch/riscv/include/asm/csr_detect.h b/arch/riscv/include/asm/csr_detect.h
new file mode 100644
index 00000000000..c058b6b85ea
--- /dev/null
+++ b/arch/riscv/include/asm/csr_detect.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Andes Technology Corporation
+ * Leo Yu-Chi Liang <ycliang@andestech.com>
+ *
+ * RISC-V CSR detection support
+ *
+ * Provides macros to safely probe CSRs that may not exist on the
+ * current hart. Uses a lightweight trap handler that simply advances
+ * past the faulting instruction and sets a flag.
+ *
+ * Ported from OpenSBI's sbi_csr_detect.h.
+ */
+
+#ifndef _ASM_RISCV_CSR_DETECT_H
+#define _ASM_RISCV_CSR_DETECT_H
+
+#include <asm/csr.h>
+
+#ifndef __ASSEMBLY__
+
+/* Two-level stringification so CSR macros are expanded before quoting */
+#define __CSR_DETECT_XSTR(x)	#x
+#define __CSR_DETECT_STR(x)	__CSR_DETECT_XSTR(x)
+
+#if CONFIG_IS_ENABLED(RISCV_SMODE)
+#define CSR_XTVEC	CSR_STVEC
+#else
+#define CSR_XTVEC	CSR_MTVEC
+#endif
+
+void __riscv_expected_trap(void);
+
+/**
+ * csr_read_allowed() - Read a CSR, detecting illegal-instruction traps.
+ * @csr_num:	CSR number (must be a compile-time constant).
+ * @trap:	lvalue that is set to 1 if the access trapped, 0 otherwise.
+ *
+ * Returns the CSR value on success, or 0 if the CSR does not exist.
+ *
+ * This works by temporarily installing a minimal trap handler that
+ * skips the faulting instruction and sets register a4 to 1. Interrupts
+ * must be disabled when calling this macro (they normally are during
+ * early init).
+ */
+#define csr_read_allowed(csr_num, trap)					\
+({									\
+	register unsigned long __mtvec =				\
+		(unsigned long)__riscv_expected_trap;			\
+	register unsigned long __trap asm("a4") = 0;			\
+	register unsigned long __ret = 0;				\
+	__asm__ __volatile__(						\
+		"csrrw %[mtvec], "					\
+			__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]\n"	\
+		"csrr %[ret], " __ASM_STR(csr_num) "\n"		\
+		"csrw "	__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]"	\
+		: [mtvec] "+&r"(__mtvec), [ret] "=&r"(__ret),		\
+		  [trap] "+&r"(__trap)					\
+		:							\
+		: "memory");						\
+	trap = __trap;							\
+	__ret;								\
+})
+
+/**
+ * csr_write_allowed() - Write a CSR, detecting illegal-instruction traps.
+ * @csr_num:	CSR number (must be a compile-time constant).
+ * @trap:	lvalue that is set to 1 if the access trapped, 0 otherwise.
+ * @value:	Value to write.
+ */
+#define csr_write_allowed(csr_num, trap, value)				\
+({									\
+	register unsigned long __mtvec =				\
+		(unsigned long)__riscv_expected_trap;			\
+	register unsigned long __trap asm("a4") = 0;			\
+	register unsigned long __val = (unsigned long)(value);		\
+	__asm__ __volatile__(						\
+		"csrrw %[mtvec], "					\
+			__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]\n"	\
+		"csrw " __ASM_STR(csr_num) ", %[val]\n"		\
+		"csrw "	__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]"	\
+		: [mtvec] "+&r"(__mtvec), [trap] "+&r"(__trap)		\
+		: [val] "rK"(__val)					\
+		: "memory");						\
+	trap = __trap;							\
+})
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_CSR_DETECT_H */
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index a527b3e9ae3..42463b8bed0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
 obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
+obj-y	+= csr_detect.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
 obj-$(CONFIG_SYS_CACHE_THEAD_CMO) += thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
diff --git a/arch/riscv/lib/csr_detect.S b/arch/riscv/lib/csr_detect.S
new file mode 100644
index 00000000000..69c4b8e7933
--- /dev/null
+++ b/arch/riscv/lib/csr_detect.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RISC-V CSR detection support
+ *
+ * Copyright (C) 2025 Andes Technology Corporation
+ * Leo Yu-Chi Liang <ycliang@andestech.com>
+ *
+ * Ported from OpenSBI's expected trap mechanism.
+ */
+
+#include <asm/encoding.h>
+
+	.text
+	.align 2
+	.global __riscv_expected_trap
+__riscv_expected_trap:
+	/* Advance past the faulting instruction */
+	csrr	a4, MODE_PREFIX(epc)
+	addi	a4, a4, 4
+	csrw	MODE_PREFIX(epc), a4
+	/* Set a4 = 1 to signal that a trap occurred */
+	li	a4, 1
+	MODE_PREFIX(ret)
-- 
2.34.1


