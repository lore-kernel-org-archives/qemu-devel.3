Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7156CF31B8
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 12:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhJ3-0004vj-03; Wed, 19 Nov 2025 07:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhIu-0004uG-E0
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:28:58 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhIs-0004by-Uh
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:28:56 -0500
Received: from cslab-raptor.s.cslab.moe (unknown [166.111.238.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 3950F498B3A;
 Wed, 19 Nov 2025 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1763555326; bh=utMgXFwBt5v+DJbkelXdVMjIbxtDWB5CwAyiVMGWzVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QA1t1zwdPkOz78tmbII70Nbfkab2b7Rglg5wFZag8ZI3vlbwaMowlyWt0xrPLQT2/
 uKgpU2QPfeWh58trNZXeJ5s2zlA/x/+IJOyHvVwtVmxc1V19DiE+YNK80Cip89zEs/
 QcBVYGMhAgLqU5LCBof/FhwblFK6fqVyQd5TojoM=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 1/7] target/loongarch: Require atomics to be aligned
Date: Wed, 19 Nov 2025 20:24:46 +0800
Message-ID: <20251119122822.1513788-2-c@jia.je>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119122822.1513788-1-c@jia.je>
References: <20251119122822.1513788-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, all atomic instructions in LoongArch require the address to
be aligned.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 77eeedbc42..5622202a67 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop | MO_ALIGN);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, t1, EXT_NONE);
@@ -37,7 +37,7 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     tcg_gen_mov_tl(val, src2);
     /* generate cmpxchg */
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval,
-                              val, ctx->mem_idx, mop);
+                              val, ctx->mem_idx, mop | MO_ALIGN);
     tcg_gen_setcond_tl(TCG_COND_EQ, dest, t0, cpu_llval);
     gen_set_label(done);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -63,7 +63,7 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
 
     addr = make_address_i(ctx, addr, 0);
 
-    func(dest, addr, val, ctx->mem_idx, mop);
+    func(dest, addr, val, ctx->mem_idx, mop | MO_ALIGN);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
     return true;
-- 
2.51.0


