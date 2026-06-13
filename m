Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC58CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUOc-0000nS-2Y; Sat, 13 Jun 2026 15:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOU-0000ir-7b; Sat, 13 Jun 2026 15:51:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOS-0003Tg-Iw; Sat, 13 Jun 2026 15:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380258; bh=VI+FTEMQDasixsklhSAas2E/Qe0UoujHhKn+Z3uX80s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H7saQMvzmYL/WLHska5D2VcfD4Ih4Ll73jm50w2zI91O7pmNuDJyvONxxxy2lFvJO
 YQKBwIs0HZyql/UlPrakTSIn/mAidjuldroWxiP+i5gQgdOfkYuw04UH2fJo7NAgFZ
 UsAnVDvXPleZuVWUtsJqyeGs201f38+cNpLnfBReEBXyQjFlISEt4J1iL1igweWts/
 8Li1II7uK6VswaWvT06dz4irvTJD0LeDb4notxMgVOArJ79mDAWS5phhP1SyMh1kOx
 VJSWU+JCQU4bgDSKFIjs7JA/EX+T/FUzUIpaRcWE/3HKXCHgWgXBn9e0eqPmdMPnxw
 nfAqSSOoBfeww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 54D301B6E16;
 Sat, 13 Jun 2026 22:50:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE5E63CE890;
 Sat, 13 Jun 2026 22:51:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Abhigyan Kumar <314abh@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 07/56] target/riscv: Fix medeleg[11] read-only zero
 bit for M-mode ECALL
Date: Sat, 13 Jun 2026 22:50:21 +0300
Message-ID: <20260613195116.1807273-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Abhigyan Kumar <314abh@gmail.com>

RISC-V Privileged Specification 3.1.8 (Machine Trap Delegation Registers
(medeleg and mideleg)) mentions:

"For exceptions that cannot occur in less privileged modes, the
corresponding medeleg bits should be read-only zero. In particular,
medeleg[11] is read-only zero."

QEMU incorrectly included RISCV_EXCP_M_ECALL in DELEGABLE_EXCPS. It
allowed the 11th bit to be written and read as set. Fixed by removing it
from the DELEGABLE_EXCPS mask, adhering to the specification.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3438
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260427060849.749179-2-314abh@gmail.com>
[ Changes by AF:
 - Remove comment
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit a0946caf1d9ec21446ebdcb5eab2400baa4323ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 68036c79e0..f8241ea3f4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1782,7 +1782,6 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_U_ECALL)) | \
                          (1ULL << (RISCV_EXCP_S_ECALL)) | \
                          (1ULL << (RISCV_EXCP_VS_ECALL)) | \
-                         (1ULL << (RISCV_EXCP_M_ECALL)) | \
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
-- 
2.47.3


