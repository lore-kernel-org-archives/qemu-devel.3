Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F88AC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjJV-0001od-Dz; Sun, 27 Sep 2026 03:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIm-0000qp-4w; Sun, 27 Sep 2026 03:28:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIk-0005cX-IN; Sun, 27 Sep 2026 03:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494014; bh=NEXLc0QqPgkEArZ8bo5C0NvuUvxYTJ82vI+r3tbrniA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DktNuDo3QzKTtD3/RA+nNrf2KVFPU0MF+f3dSJd3E/ajdFEmX+S0lyquFY9FASGen
 ng40PGxVig12Vf0s82hNxLCH4RN1A2lEEI4nzLSQ2zZ2k+/6h/16cJpxRAfBEX53Vi
 mM+OJRZO3/JjydRG74kjndzV1Kn+3k1kDLIZHn8TcpXgArlbPbwXXcqnbP/AJtk0ds
 8T9aDknXaDoNOdfB7gPvOWbPu8AeQVlOn7viDWbTteQmo5xvysv4PqlU7Jk3u53mzi
 12j9GccpxJAzExB+DbefiNGO6uuxALMNcYZk4q5Bb2sdmlBYQdF/fbLWfuMflgQRaG
 6C1ndCC9EHY5Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B3321D8AC7;
 Sun, 27 Sep 2026 10:26:54 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 08BC8432059;
 Sun, 27 Sep 2026 10:26:54 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1219C5E63D; Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 69/72] target/i386: Update FPU tag word for FXCH
Date: Sun, 27 Sep 2026 10:26:01 +0300
Message-ID: <20260927072622.93656-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
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

From: Simon Scherer <scherer.simon89@gmail.com>

FXCH ST(i) exchanges the contents of ST(0) and ST(i). Both registers
receive a new value, so both should end up marked valid in the FPU tag
word, regardless of what they were tagged before the swap.

helper_fxchg_ST0_STN() swaps the two values but never touches either
register's tag. So if either register happened to be tagged empty
beforehand, it is still wrongly tagged empty afterwards.

Mark both ST0 and ST(st_index) valid after the swap.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260902120419.212855-3-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a9dbd71f033e6c8d005537da7168aae242b35daf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 53b6e612812..3e312c7a8bf 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -521,6 +521,9 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
     ST(st_index) = ST0;
     ST0 = tmp;
 
+    env->fptags[env->fpstt] = 0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
+
     /* C1 is unconditionally cleared to 0 */
     env->fpus &= ~0x0200;
 }
-- 
2.47.3


