Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DD8C5DF8F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxIwG-0001Y5-5z; Fri, 21 Aug 2026 02:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIwE-0001XE-Pd; Fri, 21 Aug 2026 02:41:14 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIw8-000660-Ps; Fri, 21 Aug 2026 02:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787294441; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=3Sv77UAvL0ZdsbyH97t0JnaftxrQooorODzWX0jaZio=;
 b=mjS37iUYhzpCV9cRP+9HYaceiACWSg5SUBUxh5nQ89AiUfTf6XNlY76IQEyVLxDKfmyCxeKyagALt0lyQZPa1dmLetMeRXJxj/dFgDzFnR4luSeftjfw0EuzzpbtWR4OXutmfBHaoWjo0LzWHp3vqKoqKpebnjDPzyEy6LgJ/3w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0X9LMiS5_1787294439; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X9LMiS5_1787294439 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 21 Aug 2026 14:40:40 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com,
 zhiwei_liu@linux.alibaba.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH 1/3] target/riscv: Fix RCsc ordering of Zalasr store-release
Date: Fri, 21 Aug 2026 14:40:30 +0800
Message-Id: <20260821064032.49556-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Co-authored-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
Signed-off-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
---
 target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
index 79b0b2c63b..28d9b13c55 100644
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
2.43.0


