Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB91CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNjb-00079i-Om; Wed, 24 Jun 2026 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNjU-00074A-9V; Wed, 24 Jun 2026 09:33:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNjR-0000PK-4d; Wed, 24 Jun 2026 09:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307995; bh=nmmnp3npEHERyKVMs7WdQEpW4jB59+5sjKmOfypT4CE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p6E1lrsrMZxoMJPlJwmGmXbJPvaJrePrtKITdnV45ov/xgQcWWh62w+ua20MApBJF
 EDKJetEWXd+2l5xmZTXSVW7jg0Lxp2OLeIUTSweRCbOztTUVyYFWKz0AEGn008nhin
 m+rs5/RkP5lnzSgfDEuGj2MSfUYD8JXRg3tmLW8wu2PNzXjBMaiTAdPJfOhbmbmQc4
 idK5TUEp/Ft//15KAIn+nJKbkB4r3k6gwiSwTNowGkWEW1RMfZ3Mi0kjUUey9Fb1zm
 yVXCcAfw7gejJ1iIfQlF50XRa2ez3G588rCRTw3iCwLugTR3ZqZy7wiHRMrr9hNgXY
 AHTj7wESzeHnw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C3B31BA9B8;
 Wed, 24 Jun 2026 16:33:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 396583DEA07;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 006/107] target/riscv: rvv: Handle source overlap of
 vector widening reduction instructions
Date: Wed, 24 Jun 2026 16:30:11 +0300
Message-ID: <20260624133301.403266-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Anton Blanchard <antonb@tenstorrent.com>

Widening reductions read vs2 as a vector of SEW elements and vs1[0] as a
scalar of 2*SEW. The ISA does not allow the same vector register to be read
with different EEWs, so they must not overlap.

vs1 is read as a scalar from element 0, so it is treated as a single vector
register (independent of LMUL) when checking overlap.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3208
Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260417080328.31918-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit caf3bef5f01e85b8bbd24e1851b50616fa03a5bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4df9a40b44..d9a0027e0b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3062,6 +3062,7 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_check(s, a) && (s->sew < MO_64) &&
+           !is_overlapped(a->rs1, 1, a->rs2, 1 << MAX(s->lmul, 0)) &&
            ((s->sew + 1) <= (s->cfg_ptr->elen >> 4));
 }
 
-- 
2.47.3


