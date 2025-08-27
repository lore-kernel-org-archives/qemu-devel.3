Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C72BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHhS-0003VZ-6K; Wed, 27 Aug 2025 11:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhH-00036J-FQ; Wed, 27 Aug 2025 11:04:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhF-0004tU-31; Wed, 27 Aug 2025 11:04:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F7E814C538;
 Wed, 27 Aug 2025 18:02:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5AA7D269840;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 16/59] target/riscv: Restrict mideleg/medeleg/medelegh
 access to S-mode harts
Date: Wed, 27 Aug 2025 18:02:21 +0300
Message-ID: <20250827150323.2694101-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jay Chang <jay.chang@sifive.com>

RISC-V Privileged Spec states:
"In harts with S-mode, the medeleg and mideleg registers must exist, and
setting a bit in medeleg or mideleg will delegate the corresponding trap
, when occurring in S-mode or U-mode, to the S-mode trap handler. In
harts without S-mode, the medeleg and mideleg registers should not
exist."

Add smode predicate to ensure these CSRs are only accessible when S-mode
is supported.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
Message-ID: <20250701030021.99218-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e443ba03361b63218e6c3aa4f73d2cb5b9b1d372)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f1c4c8c1b8..7fe6ac7ea2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5783,8 +5783,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                           NULL,                read_mstatus_i128           },
     [CSR_MISA]        = { "misa",       any,   read_misa,    write_misa,
                           NULL,                read_misa_i128              },
-    [CSR_MIDELEG]     = { "mideleg",    any,   NULL, NULL,   rmw_mideleg   },
-    [CSR_MEDELEG]     = { "medeleg",    any,   read_medeleg, write_medeleg },
+    [CSR_MIDELEG]     = { "mideleg",    smode,   NULL, NULL,   rmw_mideleg   },
+    [CSR_MEDELEG]     = { "medeleg",    smode,   read_medeleg, write_medeleg },
     [CSR_MIE]         = { "mie",        any,   NULL, NULL,   rmw_mie       },
     [CSR_MTVEC]       = { "mtvec",      any,   read_mtvec,   write_mtvec   },
     [CSR_MCOUNTEREN]  = { "mcounteren", umode, read_mcounteren,
@@ -5792,7 +5792,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
-    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+    [CSR_MEDELEGH]    = { "medelegh",   smode32, read_zero, write_ignore,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
     [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
-- 
2.47.2


