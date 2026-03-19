Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4581090223
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvn-0005U6-1O; Thu, 19 Mar 2026 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38mA-0006rL-7l
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:42 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38m7-0000PT-1d
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:41 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8Tte2014940;
 Thu, 19 Mar 2026 16:29:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:29:55 +0800
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/6] riscv: Extend noncached memory support to RISC-V
Date: Thu, 19 Mar 2026 16:29:47 +0800
Message-ID: <20260319082951.3310908-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319082951.3310908-1-ycliang@andestech.com>
References: <20260319082951.3310908-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8Tte2014940
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

Extend the SYS_HAS_NONCACHED_MEMORY Kconfig to support RISC-V
in addition to ARM and MIPS, and add FTMAC100 to the list of
drivers that benefit from noncached memory.

The ftmac100 DMA descriptors needs to be marked uncacheable
to stay coherent for SW and HW on noncoherent platforms.

Also add MMU_SECTION_SIZE definition (1MB) to the RISC-V system
header, matching the MIPS convention used by the noncached memory
infrastructure.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/Kconfig                    | 2 +-
 arch/riscv/include/asm/system.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index fb3e8d598e7..b05f249b661 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -529,7 +529,7 @@ endmenu
 
 config SYS_HAS_NONCACHED_MEMORY
 	bool "Enable reserving a non-cached memory area for drivers"
-	depends on (ARM || MIPS) && (RTL8169 || MEDIATEK_ETH)
+	depends on (ARM || MIPS || RISCV) && (RTL8169 || MEDIATEK_ETH || FTMAC100)
 	help
 	  This is useful for drivers that would otherwise require a lot of
 	  explicit cache maintenance. For some drivers it's also impossible to
diff --git a/arch/riscv/include/asm/system.h b/arch/riscv/include/asm/system.h
index 87a804bfd5f..b71bbeef1e2 100644
--- a/arch/riscv/include/asm/system.h
+++ b/arch/riscv/include/asm/system.h
@@ -25,6 +25,12 @@ struct event;
         csr_set(CSR_SSTATUS, __flags & SR_SIE); \
     } while (0)
 
+#ifdef CONFIG_SYS_NONCACHED_MEMORY
+/* 1MB granularity */
+#define MMU_SECTION_SHIFT	20
+#define MMU_SECTION_SIZE	BIT(MMU_SECTION_SHIFT)
+#endif /* CONFIG_SYS_NONCACHED_MEMORY */
+
 /* Hook to set up the CPU (called from SPL too) */
 int riscv_cpu_setup(void);
 
-- 
2.34.1


