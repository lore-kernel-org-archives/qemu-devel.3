Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A83C5DF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxIwG-0001Y9-BZ; Fri, 21 Aug 2026 02:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIwE-0001WZ-7T; Fri, 21 Aug 2026 02:41:14 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIw9-000661-0D; Fri, 21 Aug 2026 02:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787294441; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=UKnM9cWdP672CNzhiWDOMhhND+Qv5p67Q8VNGPB24y0=;
 b=dNwEUWKHiih9g2AdvMJ/A+r0aRAfwLLMk6xt5kduR34+1o352GTlyVlDFht/V3mjKPJG4Mpg+gajs+KbJL8bcnzK7SnzejvrNsMjg9G7KemkFDK+UP5SE/ZyQU4ddBdqNwZoYWS5/G/uZ2FOXyCGlu6BqMC6VBBCjb/l5ZBc6K8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X9LMiSM_1787294440; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X9LMiSM_1787294440 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 21 Aug 2026 14:40:41 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com,
 zhiwei_liu@linux.alibaba.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PATCH 2/3] target/arm: Fix RCsc ordering of store-release
 instructions
Date: Fri, 21 Aug 2026 14:40:31 +0800
Message-Id: <20260821064032.49556-3-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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

The Armv8 memory model has no RCpc store: every store-release in the
architecture, including the AArch64 STLR and STLPUR and the A32/T32
STL, STLB and STLH, carries RCsc semantics (Arm Architecture Reference
Manual, DDI 0487, section B2.3.8 "Acquire and release semantics").
The architecture therefore orders a Store-Release tagged RCsc before
any subsequent Load-Acquire tagged RCsc of the same shareability
domain, which is what forbids the [0,0] outcome of a Store Buffering
litmus test that pairs "STLR X=1; LDAR Y" on one PE with
"STLR Y=1; LDAR X" on another.

The translators only emit a barrier before the store, which orders the
memory operations preceding the store before the store itself (release
semantics).  Nothing prevents the store from being reordered with the
memory operations that follow it, so under MTTCG the host CPU may
execute the load-acquire that immediately follows a store-release
before the store has left its store buffer:

  * on an x86 host (TSO), store-load is the only reordering the
    hardware may perform, and it is exactly the ordering that is
    missing here;

  * on an aarch64 host, no dmb follows the store either.

The defect is easily observed with a bare-metal Store Buffering litmus
test on a 2 vCPU virt guest: "STLR X=1; LDAR Y" on CPU 0 and
"STLR Y=1; LDAR X" on CPU 1 produce the architecturally forbidden [0,0]
result in 6 to 7 out of 100000 iterations, while inserting a DMB ISH
between the store and the load on each CPU brings the number to 0,
which validates the harness.

Fix this by emitting a full barrier after the store as well, for
STLR/STLLR and STLPUR on the AArch64 side and STL/STLB/STLH on the
A32/T32 side.  The TCG_MO_ST_LD bit included in TCG_MO_ALL makes the
x86 backend emit a serializing lock-prefixed instruction after the
store, draining the store buffer before any subsequent load executes,
and the aarch64 backend emit dmb ish; the store therefore becomes
globally visible before any subsequent memory operation of the same
vCPU, and the RCsc store->load ordering is satisfied.  This is
stronger than the architecture strictly requires, since the barrier
also orders the store with respect to subsequent RCpc operations such
as LDAPR, but this matches how QEMU already implements FENCE-like
ordering and keeps the fix simple.  After the fix the litmus test no
longer produces the forbidden outcome.

The load-acquire side needs no change: the barrier emitted after an
RCsc LDAR already orders it with all subsequent memory operations, and
QEMU deliberately implements the RCpc LDAPR family as full load-acquire.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/arm/tcg/translate-a64.c | 13 +++++++++++++
 target/arm/tcg/translate.c     |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4f9a93950b..b5bf977910 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3672,6 +3672,13 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
                                 true, a->rn != 31, memop);
     do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
               iss_sf, a->lasr);
+    /*
+     * STLR is an RCsc store-release: the Armv8 architecture orders it
+     * before any subsequent RCsc load-acquire, which is what forbids the
+     * store-buffering litmus test.  The barrier above only orders
+     * previous accesses before the store.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     return true;
 }
 
@@ -4415,6 +4422,12 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     /* Store-Release semantics */
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, mop, true, a->rt, iss_sf, true);
+    /*
+     * Like STLR, STLPUR is an RCsc store-release and must be ordered
+     * before any subsequent RCsc load-acquire, so it needs a barrier
+     * after the store as well.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     return true;
 }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 1770428d3c..bddac41bf9 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4259,6 +4259,12 @@ static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
     tmp = load_reg(s, a->rt);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | MO_ALIGN);
+    /*
+     * STL has the same RCsc store-release semantics as the AArch64 STLR
+     * and must be ordered before a subsequent RCsc load-acquire (LDA).
+     * The barrier above only orders previous accesses before the store.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
 
     return true;
-- 
2.43.0


