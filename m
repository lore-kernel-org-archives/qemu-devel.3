Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ABBCE7AB2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRM2-0006mB-7w; Fri, 06 Sep 2024 01:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRLw-00063b-6l; Fri, 06 Sep 2024 01:17:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRLu-000830-HE; Fri, 06 Sep 2024 01:17:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 492828C125;
 Fri,  6 Sep 2024 08:15:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ED25C13336B;
 Fri,  6 Sep 2024 08:16:34 +0300 (MSK)
Received: (nullmailer pid 10436 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 17/40] target/arm: Avoid shifts by -1 in tszimm_shr()
 and tszimm_shl()
Date: Fri,  6 Sep 2024 08:16:05 +0300
Message-Id: <20240906051633.10288-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
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

The function tszimm_esz() returns a shift amount, or possibly -1 in
certain cases that correspond to unallocated encodings in the
instruction set.  We catch these later in the trans_ functions
(generally with an "a-esz < 0" check), but before we do the
decodetree-generated code will also call tszimm_shr() or tszimm_sl(),
which will use the tszimm_esz() return value as a shift count without
checking that it is not negative, which is undefined behaviour.

Avoid the UB by checking the return value in tszimm_shr() and
tszimm_shl().

Cc: qemu-stable@nongnu.org
Resolves: Coverity CID 1547617, 1547694
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-4-peter.maydell@linaro.org
(cherry picked from commit 76916dfa89e8900639c1055c07a295c06628a0bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7388e1dbc7..034e816491 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -61,13 +61,27 @@ static int tszimm_esz(DisasContext *s, int x)
 
 static int tszimm_shr(DisasContext *s, int x)
 {
-    return (16 << tszimm_esz(s, x)) - x;
+    /*
+     * We won't use the tszimm_shr() value if tszimm_esz() returns -1 (the
+     * trans function will check for esz < 0), so we can return any
+     * value we like from here in that case as long as we avoid UB.
+     */
+    int esz = tszimm_esz(s, x);
+    if (esz < 0) {
+        return esz;
+    }
+    return (16 << esz) - x;
 }
 
 /* See e.g. LSL (immediate, predicated).  */
 static int tszimm_shl(DisasContext *s, int x)
 {
-    return x - (8 << tszimm_esz(s, x));
+    /* As with tszimm_shr(), value will be unused if esz < 0 */
+    int esz = tszimm_esz(s, x);
+    if (esz < 0) {
+        return esz;
+    }
+    return x - (8 << esz);
 }
 
 /* The SH bit is in bit 8.  Extract the low 8 and shift.  */
-- 
2.39.2


