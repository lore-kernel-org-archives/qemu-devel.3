Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11027CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuNV-0001kg-2m; Thu, 23 Oct 2025 08:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.aliokhin@syntacore.com>)
 id 1vBuKs-0006KK-7x; Thu, 23 Oct 2025 08:22:36 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.aliokhin@syntacore.com>)
 id 1vBuKp-00078B-P1; Thu, 23 Oct 2025 08:22:29 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id DE7461A0005;
 Thu, 23 Oct 2025 12:22:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com DE7461A0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1761222135; bh=yTrFtcH5W+HLnEhgtmthehlr4V835CwHQv+3ZwafY58=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=V6nbW9rjkBVBKXEOROhoEDtn2TQdPXquS2B3UnSiITlPo2vHnWTwp75vjVd5Gief3
 2ZdYAGlH6ypTYjNBtNpi8t938Hz7EFHWjHU0oj+4AAaCKSWDTlrHIkH7DsRdFSzttp
 D5G8CUrr6qMx5bysVRNzfvdFNVve9o3+yi2DSZ9MsbTHmUnI9HQ8DPhgXo+gP82MK0
 pv8O0OPL4la9/kbMqDl0S0At7H2RSHAZtmdda2vuGga3YNKqGnKnik5osxD4DsMb46
 oW6dVKew6xEyX/Qa/TvR/xv4lLaizVUmoHl/1oPWmA8cB0e5uiZayYW9lb4YgIb565
 ji/Ta2bMO+bsw==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 12:22:14 +0000 (UTC)
Received: from mail.syntacore.com (172.27.12.37) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 15:21:45 +0300
From: Andrey Alekhin <a.aliokhin@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair Francis
 <alistair.francis@wdc.com>, <qemu-riscv@nongnu.org>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Andrey Alekhin <a.aliokhin@syntacore.com>
Subject: [PATCH] target/riscv/insn_trans: Fix sc.w & sc.d incorrect behavior
 on misaligned access
Date: Thu, 23 Oct 2025 15:20:21 +0300
Message-ID: <20251023122021.16138-1-a.aliokhin@syntacore.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.27.12.37]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/10/23 07:51:00 #27791923
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=a.aliokhin@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 08:24:30 -0400
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

cs.w and sc.d instructions should throw
a "Load/Save/AMO address misaligned" exception when this
happens, but they don't. Fix solves this issue.

Note: When using misaligned address sc.w and sc.d commands
always skip store phase because either there was
no corresponding lr.w or lr.d command or there was
a corresponding command with an unaligned address
or there was mismatched command with a completely different
address.
In either case, the reservation set did not match the
address and command goes to final step to invalidate
reservation set. According specification all sc commands
always must first invalidate reservation set (if any)
and then complete execution normally or by throwing
an exception

Signed-off-by: Andrey Alekhin <a.aliokhin@syntacore.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 9cf3ae8019..93b89866ae 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -57,9 +57,10 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 
 static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
-    TCGv dest, src1, src2;
+    TCGv dest, src1, src2, mc;
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
+    TCGLabel *l3 = gen_new_label();
 
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
@@ -93,6 +94,26 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      */
     tcg_gen_movi_tl(load_res, -1);
 
+    mc = tcg_constant_tl((1 << (mop & MO_SIZE)) - 1);
+    /*
+     *   When using misaligned address sc.w and sc.d commands
+     *   always skip store phase because either there was
+     *   no corresponding lr.w or lr.d command or there was
+     *   a corresponding command with an unaligned address
+     *   or there was mismatched command with a completely different
+     *   address.
+     *   In either case, the reservation set did not match the
+     *   address and command goes to final step to invalidate
+     *   reservation set. According specification all sc commands
+     *   always must first invalidate reservation set (if any)
+     *   and then complete execution normally or by throwing
+     *   an exception
+     */
+    tcg_gen_brcond_tl(TCG_COND_TSTEQ, src1, mc, l3);
+    gen_helper_raise_exception(tcg_env,
+        tcg_constant_i32(RISCV_EXCP_STORE_AMO_ADDR_MIS));
+
+    gen_set_label(l3);
     return true;
 }
 
-- 
2.43.0


