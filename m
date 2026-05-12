Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCF2CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuiM-00043Q-VT; Tue, 12 May 2026 17:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuhI-0003Tu-Sz; Tue, 12 May 2026 17:31:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuYB-0000uu-0U; Tue, 12 May 2026 17:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619499; bh=QtZMv/eUNp00lZGF+Ax8EVZrxLcKxZLVCasWZm66xAY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C3D9A16nLwbFzv7/7P3R2/NaOGN73DfYaqmRP4huvMnrLMi7TbR0NUDMi/wZEDLwB
 uo7to2WKr+C5a6o8nAXLx+yov5+wv5QnNPcnMqcUaCTU3plEhhlQnHjUA65WaxNpB5
 26/R8CPuNDvvQM550wOHbqI14N6WHVNA8v7BzPTpbEVAwuB80Uuizyle16oRr1wR4p
 7E/vImWilJQlbYHaGc40eivTOrTpbv0A7i66yFVAWd5w/v+k5PQnxG243W0iaZh7nH
 km4/DD050pWeVJf5z7WpnMUyScmGPpBdMtWE62g+nzxv7gYNtvZE1sXoeIHoNemJzF
 +3oppXhddrh1A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F13D1AA3EF;
 Tue, 12 May 2026 23:58:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5AFA33ABD47;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 36/58] target/riscv: Generate access fault if sc
 comparison fails
Date: Tue, 12 May 2026 23:57:57 +0300
Message-ID: <20260512205820.361821-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states:

"For the purposes of memory protection, a failed SC.W may be treated
like a store."

So if the comparison in sc.w fails we should still check for alignment
and do a probe access to check permissions.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260415233740.3027321-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d107b748072cea3f86089a4a7b2e83f1a62745f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..fa16ab2b82 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(ssamoswap_disabled, void, env)
 #endif
+
+/* Zalrsc SC write probe */
+DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index a7a3278d24..62c0fe673d 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      */
     TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
+    /*
+     * "For the purposes of memory protection, a failed SC.W may be treated
+     * like a store." so let's check the write access permissions
+     */
+    gen_helper_sc_probe_write(tcg_env, src1,
+                              tcg_constant_tl(memop_size(mop)));
     gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
 
     gen_set_label(l2);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..b569366369 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
+                           target_ulong size)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = riscv_env_mmu_index(env, false);
+
+    if (addr & (size - 1)) {
+        env->badaddr = addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
+    }
+
+    probe_write(env, addr, size, mmu_idx, ra);
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
-- 
2.47.3


