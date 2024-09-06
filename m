Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE757CE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSro-0004JI-Vs; Fri, 06 Sep 2024 02:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrm-00049t-LQ; Fri, 06 Sep 2024 02:54:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrk-0002z0-Ui; Fri, 06 Sep 2024 02:54:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB8E08C238;
 Fri,  6 Sep 2024 09:53:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 849F01333F0;
 Fri,  6 Sep 2024 09:54:29 +0300 (MSK)
Received: (nullmailer pid 43321 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 03/53] target/arm: LDAPR should honour SCTLR_ELx.nAA
Date: Fri,  6 Sep 2024 09:53:33 +0300
Message-Id: <20240906065429.42415-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit c1a1f80518d360b when we added the FEAT_LSE2 relaxations to
the alignment requirements for atomic and ordered loads and stores,
we didn't quite get it right for LDAPR/LDAPRH/LDAPRB with no
immediate offset.  These instructions were handled in the old decoder
as part of disas_ldst_atomic(), but unlike all the other insns that
function decoded (LDADD, LDCLR, etc) these insns are "ordered", not
"atomic", so they should be using check_ordered_align() rather than
check_atomic_align().  Commit c1a1f80518d360b used
check_atomic_align() regardless for everything in
disas_ldst_atomic().  We then carried that incorrect check over in
the decodetree conversion, where LDAPR/LDAPRH/LDAPRB are now handled
by trans_LDAPR().

The effect is that when FEAT_LSE2 is implemented, these instructions
don't honour the SCTLR_ELx.nAA bit and will generate alignment
faults when they should not.

(The LDAPR insns with an immediate offset were in disas_ldst_ldapr_stlr()
and then in trans_LDAPR_i() and trans_STLR_i(), and have always used
the correct check_ordered_align().)

Use check_ordered_align() in trans_LDAPR().

Cc: qemu-stable@nongnu.org
Fixes: c1a1f80518d360b ("target/arm: Relax ordered/atomic alignment checks for LSE2")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240709134504.3500007-3-peter.maydell@linaro.org
(cherry picked from commit 25489b521b61b874c4c6583956db0012a3674e3a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f2d05c589c..2fccd836b7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3306,7 +3306,7 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
     if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
-    mop = check_atomic_align(s, a->rn, a->sz);
+    mop = check_ordered_align(s, a->rn, 0, false, a->sz);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
                                 a->rn != 31, mop);
     /*
-- 
2.39.2


