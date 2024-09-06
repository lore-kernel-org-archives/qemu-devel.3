Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C0CCE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSrn-0004DM-KL; Fri, 06 Sep 2024 02:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrm-00049W-Ie; Fri, 06 Sep 2024 02:54:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrk-0002ys-OT; Fri, 06 Sep 2024 02:54:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC8778C237;
 Fri,  6 Sep 2024 09:53:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 747101333EF;
 Fri,  6 Sep 2024 09:54:29 +0300 (MSK)
Received: (nullmailer pid 43311 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 02/53] target/arm: Fix handling of LDAPR/STLR with
 negative offset
Date: Fri,  6 Sep 2024 09:53:32 +0300
Message-Id: <20240906065429.42415-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When we converted the LDAPR/STLR instructions to decodetree we
accidentally introduced a regression where the offset is negative.
The 9-bit immediate field is signed, and the old hand decoder
correctly used sextract32() to get it out of the insn word,
but the ldapr_stlr_i pattern in the decode file used "imm:9"
instead of "imm:s9", so it treated the field as unsigned.

Fix the pattern to treat the field as a signed immediate.

Cc: qemu-stable@nongnu.org
Fixes: 2521b6073b7 ("target/arm: Convert LDAPR/STLR (imm) to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2419
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240709134504.3500007-2-peter.maydell@linaro.org
(cherry picked from commit 5669d26ec614b3f4c56cf1489b9095ed327938b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a20dce3c8..6cc29a4bce 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -467,7 +467,7 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
 
 &ldapr_stlr_i   rn rt imm sz sign ext
-@ldapr_stlr_i   .. ...... .. . imm:9 .. rn:5 rt:5 &ldapr_stlr_i
+@ldapr_stlr_i   .. ...... .. . imm:s9 .. rn:5 rt:5 &ldapr_stlr_i
 STLR_i          sz:2 011001 00 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
 LDAPR_i         sz:2 011001 01 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
 LDAPR_i         00 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=0
-- 
2.39.2


