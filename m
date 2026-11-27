Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A0606A33C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=T+iVOh1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxv-00033L-Bv; Fri, 27 Nov 2026 00:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxt-0002zR-P0; Fri, 27 Nov 2026 00:57:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxr-0004GU-MS; Fri, 27 Nov 2026 00:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=Gr5RqgXemGeZz59ga1twHJaQ8bonPTmYBE657d7+yvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T+iVOh1FgsM8Q93wZVjBC7aD4YgVezcEGgPeC93qYiYEevBuMcxYOETawbgOFnHWx
 SVd6zqwg6G6/zu/FZxkSoDNrv6zPeSYF7uTXPMRsaiVMwjw3GKZyFnYLuk2AgD8diM
 HjFQXihwhqS1b4nfp3j3Rsm6Su+CX8maKVkE81ov615HyDHjcGag7s4Dj7WoERAwff
 Pp63yN/CW3/MHWmjPzjhN8yd72o5RDctbB2/csB1MTIGD9p/WaUTQpvr+/FJvSrvvv
 GVRSvzmOqGtRQixRGl+aiGDJddth+GQufJHV/uIL3dONQVHxJ76u/b2oag4/iVEsjk
 rcUYeiS8wP93Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A07541EA2E9;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9E13E469924;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8D879CF254; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 095/140] target/arm: Fix RCsc ordering of
 store-release instructions
Date: Fri, 27 Nov 2026 08:53:21 +0300
Message-ID: <20261127055421.39015-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

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

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4872
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 9567b4d2c38cf9a44bdcda39163c01d7dc23bd55)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 05cdd2b9f77..d6bf83d6428 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3196,6 +3196,13 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
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
 
@@ -3890,6 +3897,12 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
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
index d6dbbf48a7f..80b6e08921e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5485,6 +5485,12 @@ static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
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
2.47.3


