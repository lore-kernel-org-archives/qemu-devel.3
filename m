Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83842C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 22:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfQ7Z-0004dM-LE; Thu, 02 Jul 2026 18:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfQ7V-0004d4-PG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 18:42:58 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfQ7U-0001AT-3z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 18:42:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2548342D6F;
 Thu,  2 Jul 2026 22:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3881F000E9;
 Thu,  2 Jul 2026 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783032173;
 bh=FjNEbOp7XbwpC/81qTdo7kQQ4vzYN51oRdw+3F/z9Rc=;
 h=From:To:Cc:Subject:Date;
 b=F9V8LgdoBPrCfn+/kzzLR3sZgZVPKPmtjHy6L2EYcN1u6f8LwWLF+WYwug4e7IorJ
 s7oa0ndIvTRlx86nXb0/NKlm4/giKlCT0fiB+6ebQ6iXkIuMXyCvDMaXL6SzMo1Epf
 DOzk5a3wwxcA88Wshb7QnofWJTQw+WRYP6egdoACDLBKtZsyh8ijn6WCws9+mw8EwC
 Z26XzJqq72UWfVQ7H6Xge9vVeC4MhBsg8/FuE8+lW8w6Pujs/yDxG3rhmVKCXmLPZs
 sEtHL6/7FA2LX/8aDtIUx1Sv8/PGa/08FaWuHsJ/AD6jecJWziN0UDAL5jOcPrGoLC
 rCggaIPF9pnRw==
From: Helge Deller <deller@kernel.org>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] target/hppa: Work around Fast TLB insert instruction for
 HP-UX 9
Date: Fri,  3 Jul 2026 00:42:41 +0200
Message-ID: <20260702224241.29866-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
0x05385400), which seem to be wrongly encoded fast TLB instructions, but
similiar to the non-fast instructions idtlba r17,(r9) and
idtlbp r24,(r9).

It's not clear, if those undocumented instructions were used by mistake,
or intentionally. Either way, this patch allows qemu to handle those
instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (but
still crashes due to other reasons afterwards).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/insns.decode |  4 ++--
 target/hppa/translate.c  | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 13c6a55bf2..837a0b73e6 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -162,8 +162,8 @@ ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 00000      data=1
 ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
                 sp=%assemble_sr3x data=0
 
-# pcxl and pcxl2 Fast TLB Insert instructions
-ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+# pcxl and pcxl2 Fast TLB Insert instructions (with HP-UX 9 workaround)
+ixtlbxf           000001 b:5 r:5 0- 0 data:1 01000 addr:1 0 00000
 
 # pa2.0 tlb insert idtlbt and iitlbt instructions
 ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4e34822565..72bc881784 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2666,6 +2666,17 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
      *    return gen_illegal(ctx);
      */
 
+    /*
+     * The HP-UX 9 kernel uses two undocumented instructions 0x05315440 and
+     * 0x05385400, which seem to be wrongly encoded fast TLB instructions,
+     * similiar to idtlba r17,(r9) and idtlbp r24,(r9).
+     * To support HP-UX 9, check b against 0 (documented) and 9 (to allow the
+     * r9 case), and genenerate an illegal instruction trap otherwise.
+     */
+    if (a->b != 0 && a->b != 9) {
+        return gen_illegal(ctx);
+    }
+
     atl = tcg_temp_new_i64();
     stl = tcg_temp_new_i64();
     addr = tcg_temp_new_i64();
-- 
2.54.0


