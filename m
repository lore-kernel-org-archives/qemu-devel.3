Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8545FC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp7R-00024z-8r; Tue, 25 Aug 2026 07:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7P-000248-W3; Tue, 25 Aug 2026 07:15:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7O-0000Gd-45; Tue, 25 Aug 2026 07:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=ki00NNJjWyNtohHPZCYG5y2QqeJ5IIkuYaEqXkqmKJo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I7YbZf23GwCFJ+jeGs8o0/eT7xPyVgliqPcBJOwBchsPPjgX93zK8px8BS4ByKrQ3
 Adjfac7IHVuw8ID+QHkgFTpDncXwdpW3K+GKhDPMZ0/ahH1b8+N4RhVea7IMhTbhrd
 UZUdMN//Xiw7P8O9L8WrtYkTQ1HCxG7ZLwFQ/uO0wUztBDhsFeMpfHXILn8ZmHuUZt
 BLWay2zDf8/A3eDgl23r4SYd5SyKNq8eo34jimWPZ0Biisa/Wa8hfqZ6X02/xeh1pG
 blvuSvjLolVbjZOK1kjT7f+rjg1LEZp5+MPxhuz2Nf8iKe9jUoIcDk/VikmaEuDtlC
 H34UJ8gKtgADA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4EE091CE4B3;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 677AA41627F;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 92044325A9; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>,
 A-Shehab <ahshehab24@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 151/166] target/riscv: Fix PC sync in
 trans_sspopchk for CFI exception handling
Date: Tue, 25 Aug 2026 14:11:47 +0300
Message-ID: <20260825111206.482723-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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

From: Max Chou <max.chou@sifive.com>

Move gen_update_pc call before conditional logic to ensure consistent
PC state regardless of execution path.

Previously, the host instructions generated to update the cpu_pc were
only executed in the failure path when shadow stack validation failed.
This created inconsistent PC synchronization.

This inconsistency caused issues in CF_PCREL mode where subsequent
instructions calculated wrong relative offsets from stale pc_save
values, and could lead to incorrect exception return addresses.

This fix ensures PC is always synchronized before any helper that
might raise an exception, maintaining consistent translator state
across all execution paths.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4118
Signed-off-by: Max Chou <max.chou@sifive.com>
[ahshehab: rebased on current master; file moved to
 target/riscv/tcg/insn_trans/ and the ssp load is now 64-bit wide]
Tested-by: A-Shehab <ahshehab24@gmail.com>
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260730181852.1622-1-ahshehab24@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 4a884ba94b43f5b2a640f4ea882655503f9ae954)
(Mjt: back-port the changes back to 11.0.x, to the original patch state)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index f4a1c12ca0b..4cf14d2a37a 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -32,6 +32,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
+    gen_update_pc(ctx, 0);
     tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
@@ -40,7 +41,6 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                   tcg_env, offsetof(CPURISCVState, sw_check_code));
-    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.47.3


