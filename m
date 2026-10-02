Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD35CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdcQ-0000HX-6a; Fri, 02 Oct 2026 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xCdcN-0000HJ-7O; Fri, 02 Oct 2026 09:48:07 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xCdcJ-000698-8i; Fri, 02 Oct 2026 09:48:05 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id F404223ABD;
 Fri, 02 Oct 2026 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1790948881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X/rAufdl4WUacev28wGy7SGRE3Ug56V0VeC3fOx+6Ws=;
 b=IheFvqDcNKKZifAoIXF4AsI2NhBXSiQ+rkfhcoiiI73WbVe03Q4dbPmYs4JwprsE9EMFjB
 IIs942asGxKosyG6z56YG3aOaRop7rex0KR1mvPllnj+CTcj+3kyAAAjSscOrADu0O4Zl9
 cbrqAYXdj8OWYKPxMMPrWAZ0OYIYz50ebWpWrq2pfMtTWh8OlGzz9BQJnXCJl3HM3fecjd
 KCJqIfMFiyj5zSzRcdJfjtEwZFsVBjVIun+mT/krGX1YvDoP5yyQKg83nWnqZYlVs+sKfn
 1CBZ3xTfIqyp/TS2cyFkGuuogiFibztGXMQ/aW5xb0u8Rszm3C+Y39PVm15pKA==
Received: from [192.168.1.131] (OPNsense.thinking.duckdns.org [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id 55135C5F;
 Fri, 02 Oct 2026 06:48:00 -0700 (PDT)
Message-ID: <d6db9f89-36d6-436d-a915-407cd28e1778@sloservers.com>
Date: Fri, 2 Oct 2026 06:47:58 -0700
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Content-Language: en-US
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
From: Rick Richard <rick@sloservers.com>
Subject: [PATCH] target/riscv: Use TSO barriers instead of full barriers for
 Ztso
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

With Ztso, plain loads and stores follow RVTSO, but the barriers
around them use TCG_MO_ALL.  That also orders a store before a later
load, which TSO doesn't require, and is expensive: on x86 hosts it
adds a locked instruction around every load and store in a
multi-threaded guest.

The barrier after a load now only keeps later loads and stores
behind it, and the barrier before a store only keeps earlier loads
and stores ahead of it.  That is all TSO needs.

Signed-off-by: Rick Richard <rick@sloservers.com>
---
I found this while looking into why riscv64 guests were so much
slower than aarch64 ones under bsd-user on FreeBSD.  The default -cpu
max enables Ztso, and turning it off with ztso=false accounted for
most of the difference.

On an x86-64 host the patch made xz almost four times faster and cut
the time of a clang compile by about 30%, the same as running with
ztso=false.  The output didn't change.

I also tested it on a Raspberry Pi 3B+, which is arm64 and doesn't
give TSO ordering in hardware, to make sure the weaker barriers still
hold up there.  Everything ran correctly, and xz was about 12% faster.

 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 4 ++--
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index 40b4c9aa..d31e4295 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -424,7 +424,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     }
 
     if (ctx->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
     }
 
     return out;
@@ -485,7 +485,7 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
 
     if (ctx->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
     }
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index a22e2cae..8c21ab87 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -731,7 +731,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
      * around the loop.
      */
     if (is_store && s->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
     }
 
     mark_vs_dirty(s);
@@ -739,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     if (!is_store && s->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
     }
 
     finalize_rvv_inst(s);
-- 
2.43.0


