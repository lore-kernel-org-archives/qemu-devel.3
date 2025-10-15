Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE676CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t6e-00019n-UZ; Wed, 15 Oct 2025 00:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t6c-00017t-NO; Wed, 15 Oct 2025 00:27:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t6W-0002yo-Ai; Wed, 15 Oct 2025 00:27:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 723F515D9DC;
 Wed, 15 Oct 2025 07:25:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C0A629FE83;
 Wed, 15 Oct 2025 07:25:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 09/13] target/riscv: Fix the mepc when sspopchk
 triggers the exception
Date: Wed, 15 Oct 2025 07:25:33 +0300
Message-ID: <20251015042540.68611-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

When sspopchk is in the middle of TB and triggers the SW check
exception, it should update PC from gen_update_pc(). If not, RISC-V mepc
CSR will get wrong PC address which is still at the start of TB.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250924074818.230010-2-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit c851052a77fd79300708df2070297b5428b4be8d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index b0096adcd0..45686af4d6 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -40,6 +40,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                   tcg_env, offsetof(CPURISCVState, sw_check_code));
+    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.47.3


