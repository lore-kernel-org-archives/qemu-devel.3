Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6F8C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn6a-0002op-9R; Tue, 25 Aug 2026 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn6Y-0002mK-RH; Tue, 25 Aug 2026 05:06:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn6X-0003sn-0m; Tue, 25 Aug 2026 05:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=+3rXjVHlNZk9Db+vUe8bJDs3TV+RUWy0qNqU8HsHrwM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oQUanUAa+FvAo84WaOB6JqpoLYGrCHS+78TfDSc4vGRcGphabs3VIGHcEmLHZPDkM
 XExZDIU+RX3YxaG4xLSDdyej74GiseuVj3+pmqnKTkFP9rHtWr7bkRLT+c60RwF6wo
 Wc0iXK8RLUBJFdKwnR0UyV4Ne5rb5xWV2n2Rrmrh30zevf/yP87iFq6Uas2Z5lL63Y
 HftuNzJJ5mGOK9kmuAM6PxNPQ88CI2aQOoKNfek7YdK23fdvPhIUXAUo6DOhaWKfP1
 0f2DTPawT3b0iAOst1QiVzkxZm+J/s0ydh93rrDrQfYt95NwmO6ABNNXNQH0SX91EE
 BTg/n4NkDoUzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D844E1CE3CD;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C44A141618F;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2095B32583; Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 195/196] target/riscv: enforce even register
 constraints for Zdinx fcvt pairs
Date: Tue, 25 Aug 2026 12:01:52 +0300
Message-ID: <20260825090157.471948-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

fcvt.d.h and fcvt.h.d access a 64-bit double held in a register
pair, so under Zdinx/Zhinxmin the odd-rd (fcvt.d.h) and odd-rs1
(fcvt.h.d) encodings are reserved.  Add the missing REQUIRE_EVEN
checks so those encodings raise an illegal-instruction exception
instead of retiring.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4109
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <ea287909fd6043e0bbcdbfdcb0cc8063@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e68cc2e5cd28333ac76d757ed2db7d2f7635d09a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 791ee51f652..d547a1d04c5 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -413,6 +413,7 @@ static bool trans_fcvt_d_h(DisasContext *ctx, arg_fcvt_d_h *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
     REQUIRE_ZDINX_OR_D(ctx);
+    REQUIRE_EVEN(ctx, a->rd);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
@@ -447,6 +448,7 @@ static bool trans_fcvt_h_d(DisasContext *ctx, arg_fcvt_h_d *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
     REQUIRE_ZDINX_OR_D(ctx);
+    REQUIRE_EVEN(ctx, a->rs1);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
-- 
2.47.3


