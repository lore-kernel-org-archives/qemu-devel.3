Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162C6C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmTd-0004Q9-1y; Sun, 27 Sep 2026 06:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTP-0004EW-Jg; Sun, 27 Sep 2026 06:51:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTN-0001UY-RG; Sun, 27 Sep 2026 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=CqPeSmLOKfORqhwf1puP6OV29jgnqqbTnuWmVIN7bys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KNcDMgpJPzDHyuH4C/X7N+caPAqTDP38W2aQM+1d8irXv/xZsAN8qXhE0G9uGuLVo
 OoujZ2sH11hhiTrIfKtQNwiY3IN5vEs6uqrKI3upGIJOd3hL5dP923GlePeN2/nZuS
 D9HBsH1DhPOIatWLNJFHmGMRVWHI6453NVk3B9qqmTuHUuxqd4n7rj1JXahkd8SC97
 KXnDiY/5aGd9tIUopKRBWEKS2te7KenqB9ObZTWKupJttvdTa9WB7ocv4CCk6J+kHz
 JCesGpVdYNyQPNl0dZ9aRdN6fga48rK7CM4zqhTQRt/V83K5m47tLy8lLl5Ii5RuqS
 Je2fzglZg0O4w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 534D21D8B74;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 486CD43217B;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 073575E7A0; Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 85/92] target/i386: Update FPU tag word for FSTP
Date: Sun, 27 Sep 2026 13:48:01 +0300
Message-ID: <20260927104821.196183-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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

FSTP ST(i) copies the value in ST(0) into ST(i) and then pops the
register stack. ST(i) should end up marked valid in the FPU tag word
and the old ST(0) should end up marked empty.

helper_fmov_STN_ST0() copies the value into ST(i) but never touches
its tag. So if ST(i) happened to be tagged empty beforehand, it is
still wrongly tagged empty afterwards.

Mark the destination tag to valid in helper_fmov_STN_ST0().
This also fixes FST ST(i), which shares the same helper.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260902120419.212855-2-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f2357fdcd984c37fb0f3f64698a38ba1f55fd9c5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 829b2c80dbc..1a2b782e0f9 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -510,6 +510,7 @@ void helper_fmov_ST0_STN(CPUX86State *env, int st_index)
 void helper_fmov_STN_ST0(CPUX86State *env, int st_index)
 {
     ST(st_index) = ST0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
 }
 
 void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
-- 
2.47.3


