Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iaqq0oxo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6U-0004gh-BP; Fri, 27 Nov 2026 01:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6G-0003pg-RW; Fri, 27 Nov 2026 01:06:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6E-0000Ka-Q7; Fri, 27 Nov 2026 01:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=svGVFSb9scdlBQXfAuICdmP1jBQoNpUJavU/rxEoskE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iaqq0oxozS9kLWAducSmAbrxBgPzEEbtbeq+4dVW9HlBb4L41433M0Zx4Fijqh119
 +MzB0+jcnLGHgk4D7upfDW+gdx08s7f5Vr1ClooAQqcJM9nXaiiQuXv4U0cwzbyM6L
 W7ni9KLIoNI+6zfPaLUwR1/2S04h+PPJQqXx6Cxo2cr0wCjP3ustLmRtJ+7XnkN9Tf
 av/COGo1hS3JbxnBA3xmBWrOVkDBsbPIjTe1vK8orkOm643H7xBfkCCk+Ko5i8vBjL
 mnzNg0tzjKKT01EbeDF/C2tAEj6OwcYaZ3YYbLMgQ2GBRrtKi3npJRNeUx8UKcjgiH
 qk6u8v3LQYOAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 12ED51EA357;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 106B7469982;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F32B9CF2FC; Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 101/152] target/riscv: Fix RCsc ordering of Zalasr
 store-release
Date: Fri, 27 Nov 2026 08:53:59 +0300
Message-ID: <20261127055709.39630-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

The Zalasr load-acquire instructions carry an acquire-RCsc annotation
and the store-release instructions carry a release-RCsc annotation;
the extension has no RCpc variant (Zalasr specification, chapter 2).

Per Rule 7 of the RVWMO preserved program order rules ("a and b both
have RCsc annotations"), a Zalasr store-release must precede any
subsequent RCsc memory operation of the same hart in the global
memory order.  In particular "sw.rl X=1; lw.aq r1=Y" must be ordered,
which is what forbids the [0,0] outcome of a Store Buffering litmus
test that runs this pair on two harts.

gen_store_release() only emits a barrier before the store, which
orders the memory operations preceding the store before the store
itself (Rule 6, release semantics).  Nothing prevents the store from
being reordered with the memory operations that follow it, so under
MTTCG the host CPU may execute the load-acquire that immediately
follows a store-release before the store has left its store buffer:

  * on an x86 host (TSO), store-load is the only reordering the
    hardware may perform, and it is exactly the ordering that is
    missing here;

  * on an aarch64 host, no dmb follows the store either.

The defect is easily observed with a bare-metal Store Buffering
litmus test on a 4 vCPU guest: "sw.rl X=1; lw.aq r1=Y" on hart 0 and
"sw.rl Y=1; lw.aq r2=X" on hart 1 produce the architecturally
forbidden [0,0] result in 89881 out of 100000 iterations.

Fix this by emitting a full barrier after the store as well, which
mirrors the FENCE translation.  The TCG_MO_ST_LD bit included in
TCG_MO_ALL makes the x86 backend emit a serializing lock-prefixed
instruction after the store, draining the store buffer before any
subsequent load executes, and the aarch64 backend emit dmb ish; the
store therefore becomes globally visible before any subsequent memory
operation of the same vCPU, and Rule 7 is satisfied.  This is
stronger than Rule 7 strictly requires, since the barrier also orders
the store with respect to subsequent non-RCsc operations, but this
matches how QEMU already implements FENCE and keeps the fix simple.

The load-acquire side needs no change: the barrier emitted after the
load already orders it with all subsequent memory operations, which
covers Rule 5 and the remaining Rule 7 combinations (load-load and
load-store).

Cc: qemu-stable@nongnu.org
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Co-authored-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
Signed-off-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 1f19e0dea11b1f20bd20d3293963859aa414dc2e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
index 79b0b2c63b8..28d9b13c55e 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
@@ -86,6 +86,14 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+
+    /*
+     * Zalasr annotations are always RCsc: per RVWMO Rule 7, the store
+     * must also be ordered before any subsequent memory operation,
+     * e.g. a load-acquire in a Store Buffering litmus test.  The
+     * barrier above only orders previous memory ops before the store.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     return true;
 }
 
-- 
2.47.3


