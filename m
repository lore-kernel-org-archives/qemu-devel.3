Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B32C1090223
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvm-0005Ta-Sy; Thu, 19 Mar 2026 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38l3-0006Ov-Tt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:29:33 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38l0-0008Np-Eo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:29:33 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8SvwO014752;
 Thu, 19 Mar 2026 16:28:57 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:28:57 +0800
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <me@ziyao.cc>, <e@freeshell.de>, <qemu-devel@nongnu.org>, CL Wang
 <cl634@andestech.com>
Subject: [PATCH] riscv: spl: Clear BSS as early as possible
Date: Thu, 19 Mar 2026 16:28:51 +0800
Message-ID: <20260319082851.3262146-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8SvwO014752
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

From: CL Wang <cl634@andestech.com>

Move the BSS clearing sequence as early as possible, directly after
the hart lottery selection. This ensures all BSS variables are properly
zeroed before any C code executes.

Signed-off-by: CL Wang <cl634@andestech.com>
---
 arch/riscv/cpu/start.S | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7bafdfd390a..c54a194f5b1 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -166,7 +166,18 @@ call_harts_early_init:
 	bnez	tp, secondary_hart_loop
 #endif
 #endif
-	
+
+#ifdef CONFIG_XPL_BUILD
+	la	t0, __bss_start
+	la	t1, __bss_end
+	beq	t0, t1, spl_clear_bss_done
+1:
+	SREG	zero, 0(t0)
+	addi	t0, t0, REGBYTES
+	blt	t0, t1, 1b
+spl_clear_bss_done:
+#endif
+
 	mv      a0, s0
 	jal	board_init_f_init_reserve
 
@@ -219,16 +230,6 @@ wait_for_gd_init:
 	jalr	t5			/* jump to board_init_f() */
 
 #ifdef CONFIG_XPL_BUILD
-spl_clear_bss:
-	la	t0, __bss_start
-	la	t1, __bss_end
-	beq	t0, t1, spl_stack_gd_setup
-
-spl_clear_bss_loop:
-	SREG	zero, 0(t0)
-	addi	t0, t0, REGBYTES
-	blt	t0, t1, spl_clear_bss_loop
-
 spl_stack_gd_setup:
 	jal	spl_relocate_stack_gd
 
-- 
2.34.1

