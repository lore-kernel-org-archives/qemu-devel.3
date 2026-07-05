Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FC8C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgP4Z-0007dt-U9; Sun, 05 Jul 2026 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wgP4X-0007dL-Ny
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 11:47:57 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wgP4W-00018r-D8
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 11:47:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 567776138A;
 Sun,  5 Jul 2026 15:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0EC1F000E9;
 Sun,  5 Jul 2026 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783266475;
 bh=gZ0FwzXuCMbgNXwhRz4tKMQ7UBdngg5+eQSXSvYinEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eJEfIuTYWm8VyYHY96OERKtiSukDRsf1wY87raWVgCL94XaiOtvJjEf1GrdN1Wa+i
 HvE8/HNhMxeiEkGxVs5e56a8WFr+9Iul1d8A5vGC9weuiLAwb0fS54E88l1vF7+Y4H
 PiU6iGqHnPmYIRYwFtqQm/foVaC3QoXYg4jW6HEnHgRrRZVpXB3Dat8iOQjBs1dps5
 jIiTCRDCkcfSebIJcAxwFqBtLcK7dDRP3y6i4c2xQ6yYc7MLIzJC14UA/GpaTy38UL
 fxs3xxeXZsqlH0BCQ1rlj/fw26aEwFL/R3ZzZvnhy1gRi2PbLugkVbGRZPAqgZnrmF
 8nnsVftnQwWfw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/4] target/hppa: Delay MMU update until TLB protection bits
 were set
Date: Sun,  5 Jul 2026 17:47:46 +0200
Message-ID: <20260705154749.7368-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705154749.7368-1-deller@kernel.org>
References: <20260705154749.7368-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

On a 32-bit HPPA CPU, the TLB update for a data translation happens with
two consecutive instructions: IDTLBA and IDTLBP. The former sets the
target page address, while the second sets the protection bits.
There is no need to update the MMU after setting the address bits only,
so delay the final update of the MMU until after the execution of the
second instruction when the protection bits are known too.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4e34822565..002189ddfb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2570,7 +2570,7 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
-    if (ctx->tb_flags & PSW_C) {
+    if (ctx->tb_flags & PSW_C && !a->addr) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     }
     return nullify_end(ctx);
@@ -2687,7 +2687,7 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
-    if (ctx->tb_flags & PSW_C) {
+    if (ctx->tb_flags & PSW_C && !a->addr) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     }
     return nullify_end(ctx);
-- 
2.54.0


