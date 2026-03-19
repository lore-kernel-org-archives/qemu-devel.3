Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B287B1090223
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvp-0005V0-7N; Thu, 19 Mar 2026 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38lD-0006Pf-C5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:29:43 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38lB-0008Uo-26
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:29:42 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8TGIZ014809;
 Thu, 19 Mar 2026 16:29:16 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:29:15 +0800
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <me@ziyao.cc>, <anshuld@ti.com>, <xypron.glpk@gmx.de>,
 <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] riscv: andes: Add Smstateen extension support
Date: Thu, 19 Mar 2026 16:29:11 +0800
Message-ID: <20260319082911.3270255-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319082911.3270255-1-ycliang@andestech.com>
References: <20260319082911.3270255-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8TGIZ014809
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

Use the CSR detection mechanism to probe for the Smstateen extension
and initialize mstateen0/sstateen0 CSRs when present.

The mstateen0 register is configured to allow S-mode access to fcsr,
AIA, IMSIC, indirect CSR access, environment configuration, and
sstateen0. The sstateen0 register enables U-mode access to compressed
extension state and fcsr.

Supports both RV32 (using MSTATEEN0/MSTATEEN0H split) and RV64.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andes/cpu.c   | 29 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/riscv/cpu/andes/cpu.c b/arch/riscv/cpu/andes/cpu.c
index d25ecba0e88..feb755a4f0d 100644
--- a/arch/riscv/cpu/andes/cpu.c
+++ b/arch/riscv/cpu/andes/cpu.c
@@ -9,6 +9,7 @@
 #include <irq_func.h>
 #include <asm/cache.h>
 #include <asm/csr.h>
+#include <asm/csr_detect.h>
 #include <asm/arch-andes/csr.h>
 
 /*
@@ -60,5 +61,33 @@ void harts_early_init(void)
 		mmisc_ctl_val |= MMISC_CTL_NON_BLOCKING_EN;
 
 		csr_write(CSR_MMISC_CTL, mmisc_ctl_val);
+
+		/* Initialize Smstateen if the extension is present */
+		{
+			int trap = 0;
+			unsigned long long mstateen0;
+
+			mstateen0 = csr_read_allowed(CSR_MSTATEEN0, trap);
+			if (!trap) {
+#if __riscv_xlen == 32
+				mstateen0 |= (unsigned long long)
+					csr_read(CSR_MSTATEEN0H) << 32;
+#endif
+				mstateen0 |= SMSTATEEN0_CS | SMSTATEEN0_FCSR |
+					     SMSTATEEN0_CONTEXT |
+					     SMSTATEEN0_IMSIC |
+					     SMSTATEEN0_AIA |
+					     SMSTATEEN0_CSRIND |
+					     SMSTATEEN0_ENVCFG |
+					     SMSTATEEN0_SE0;
+				csr_write(CSR_MSTATEEN0, mstateen0);
+#if __riscv_xlen == 32
+				csr_write(CSR_MSTATEEN0H, mstateen0 >> 32);
+#endif
+				csr_write(CSR_SSTATEEN0,
+					  csr_read(CSR_SSTATEEN0) |
+					  SMSTATEEN0_CS | SMSTATEEN0_FCSR);
+			}
+		}
 	}
 }
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 986f951c31a..cef0fd906da 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -97,6 +97,18 @@
 #define SIE_STIE		(_AC(0x1, UL) << IRQ_S_TIMER)
 #define SIE_SEIE		(_AC(0x1, UL) << IRQ_S_EXT)
 
+/* Smstateen: mstateen0 / sstateen0 bit definitions */
+#define SMSTATEEN0_CS		(_AC(0x1, ULL) << 0)
+#define SMSTATEEN0_FCSR		(_AC(0x1, ULL) << 1)
+#define SMSTATEEN0_JVT		(_AC(0x1, ULL) << 2)
+#define SMSTATEEN0_CONTEXT	(_AC(0x1, ULL) << 57)
+#define SMSTATEEN0_IMSIC	(_AC(0x1, ULL) << 58)
+#define SMSTATEEN0_AIA		(_AC(0x1, ULL) << 59)
+#define SMSTATEEN0_CSRIND	(_AC(0x1, ULL) << 60)
+#define SMSTATEEN0_P1P13	(_AC(0x1, ULL) << 61)
+#define SMSTATEEN0_ENVCFG	(_AC(0x1, ULL) << 62)
+#define SMSTATEEN0_SE0		(_AC(0x1, ULL) << 63)
+
 #define CSR_FCSR		0x003
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -105,6 +117,7 @@
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
 #define CSR_SCOUNTEREN		0x106
+#define CSR_SSTATEEN0		0x10c
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142
@@ -126,6 +139,8 @@
 #else
 #define CSR_MCOUNTEREN		0x306
 #endif
+#define CSR_MSTATEEN0		0x30c
+#define CSR_MSTATEEN0H		0x31c
 #define CSR_MSCRATCH		0x340
 #define CSR_MEPC		0x341
 #define CSR_MCAUSE		0x342
-- 
2.34.1


