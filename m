Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD77FC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:59:00 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf5u-00051V-Ns; Fri, 07 Jun 2024 15:17:46 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf5p-0004m2-FN; Fri, 07 Jun 2024 15:17:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf5n-00037P-69; Fri, 07 Jun 2024 15:17:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE3BF6E56D;
 Fri,  7 Jun 2024 22:14:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0D558E2766;
 Fri,  7 Jun 2024 22:14:00 +0300 (MSK)
Received: (nullmailer pid 529466 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Fabian Thomas <fabian.thomas@cispa.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 63/71] target/riscv: rvzicbo: Fixup CBO extension
 register calculation
Date: Fri,  7 Jun 2024 22:13:44 +0300
Message-Id: <20240607191356.529336-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair23@gmail.com>

When running the instruction

```
    cbo.flush 0(x0)
```

QEMU would segfault.

The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
allocated.

In order to fix this let's use the existing get_address()
helper. This also has the benefit of performing pointer mask
calculations on the address specified in rs1.

The pointer masking specificiation specifically states:

"""
Cache Management Operations: All instructions in Zicbom, Zicbop and Zicboz
"""

So this is the correct behaviour and we previously have been incorrectly
not masking the address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240514023910.301766-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit c5eb8d6336741dbcb98efcc347f8265bf60bc9d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index d5d7095903..15711c3140 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -31,27 +31,35 @@
 static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_inval(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
 {
     REQUIRE_ZICBOZ(ctx);
-    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_zero(tcg_env, src);
     return true;
 }
-- 
2.39.2


