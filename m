Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CC0C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmTs-0005ek-L8; Sun, 27 Sep 2026 06:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTp-0005Yi-P8; Sun, 27 Sep 2026 06:51:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTo-0001WF-7i; Sun, 27 Sep 2026 06:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=y93/ikCtWINyScQPH0qIduEsC+O2GGqwUISpAzr+9EU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DslOnaPzVowP7ojL2Bc58YVGsW3RlL1aG0l3i1zCXINaEPDTNMuokUqVlisckRQz4
 QLl5rR1/IoKv9k/1WtScwIXTKyyyl/lx7yoNqlg2KLDo/38dIhLyxJEj49Hu61O6rj
 VJZqk8ryF2Jk2NbDC9Xzqa2JhAnvCj/6jvTxvVjX6Hq/t5c2/47h7RzeJTl4nSIpeH
 ThoABMQ0Dp734rVtPkR/d/LoI+jbCReDipy0Hvk9GDfVbbmZ6+NoGmdYoNxUSWlX+1
 ScZlwbR+7nPOjhQFJ5oYFC+kk5urheWyLfNJwGNukeZcHVoQ6tzIS/z1VjZ92hF5V7
 khExgeVjRwMOg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62C7F1D8B78;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5EEA743217F;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 137DE5E7A8; Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 89/92] linux-user/sh4: fix vdso CFA for
 rt_sigreturn frames
Date: Sun, 27 Sep 2026 13:48:05 +0300
Message-ID: <20260927104821.196183-33-mjt@tls.msk.ru>
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

From: Matt Turner <mattst88@gmail.com>

The unwinder looks up a return address as IP - 1 (hence the nop before
sigreturn_region_start). For a frame returning to __kernel_rt_sigreturn
that is the last byte of __kernel_sigreturn, which still has the
sigreturn CFA, so the rt_sigreturn frame is unwound with the wrong
sigcontext offset. _Unwind_Backtrace() from an SA_SIGINFO handler stops
after three frames.

Add a nop after .cfi_def_cfa_offset, as linux-user/i386/vdso.S does.

Fixes: 975bd51a88 ("linux-user/sh4: add VDSO support for sh4 and sh4eb")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 5c98e72e6aae3e538ef8276e8d7f30d33af6d6bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index bc1fb37e108..df9fa22efab 100755
Binary files a/linux-user/sh4/vdso-be.so and b/linux-user/sh4/vdso-be.so differ
diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index c1ff560cc16..decd6742022 100755
Binary files a/linux-user/sh4/vdso-le.so and b/linux-user/sh4/vdso-le.so differ
diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 1faa6657746..290eb498aeb 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -141,8 +141,9 @@ __kernel_sigreturn:
 	sigreturn_tramp __NR_sigreturn
 endf __kernel_sigreturn
 
-	/* Update CFA base for the rt_sigreturn frame layout. */
+	/* rt_sigreturn frame layout; nop for the same reason as above. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
+	nop
 
 __kernel_rt_sigreturn:
 	sigreturn_tramp __NR_rt_sigreturn
-- 
2.47.3


