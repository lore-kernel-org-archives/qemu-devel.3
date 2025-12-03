Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F70D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhpC-0005cj-8R; Wed, 03 Dec 2025 03:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhoy-0005MD-E5; Wed, 03 Dec 2025 03:02:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhov-0007Ik-Gb; Wed, 03 Dec 2025 03:02:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D89517077F;
 Wed, 03 Dec 2025 10:59:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3A1E732B4A6;
 Wed, 03 Dec 2025 10:59:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harald van Dijk <hdijk@accesssoftek.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 114/116] target/arm: Fix assert on BRA.
Date: Wed,  3 Dec 2025 10:59:34 +0300
Message-ID: <20251203075939.2366131-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Harald van Dijk <hdijk@accesssoftek.com>

trans_BRA does

    gen_a64_set_pc(s, dst);
    set_btype_for_br(s, a->rn);

gen_a64_set_pc does

    s->pc_save = -1;

set_btype_for_br (if aa64_bti is enabled and the register is not x16 or
x17) does

    gen_pc_plus_diff(s, pc, 0);

gen_pc_plus_diff does

    assert(s->pc_save != -1);

Hence, this assert is getting hit. We need to call set_btype_for_br
before gen_a64_set_pc, and there is nothing in set_btype_for_br that
depends on gen_a64_set_pc having already been called, so this commit
simply swaps the calls.

(The commit message for 64678fc45d8f6 says that set_brtype_for_br()
must be "moved after" get_a64_set_pc(), but this is a mistake in
the commit message -- the actual changes in that commit move
set_brtype_for_br() *before* get_a64_set_pc() and this is necessary
to avoid the assert.)

Cc: qemu-stable@nongnu.org
Fixes: 64678fc45d8f6 ("target/arm: Fix BTI versus CF_PCREL")
Signed-off-by: Harald van Dijk <hdijk@accesssoftek.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com
[PMM: added note about 64678fc45d8f6 to commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7248dab3c9d73fcefe609f7a3414f9d048fefcc1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8d3a8d7a25..05cdd2b9f7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1852,8 +1852,8 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
         return false;
     }
     dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
-    gen_a64_set_pc(s, dst);
     set_btype_for_br(s, a->rn);
+    gen_a64_set_pc(s, dst);
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.47.3


