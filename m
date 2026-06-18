Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACF0CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 21:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waKgu-0003fn-D2; Thu, 18 Jun 2026 17:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1waKgt-0003eq-9I; Thu, 18 Jun 2026 17:54:27 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1waKgr-0002Ks-28; Thu, 18 Jun 2026 17:54:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15312440B7;
 Thu, 18 Jun 2026 21:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C34B1F000E9;
 Thu, 18 Jun 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781819663;
 bh=8P2EgFQk+ZR72MD1XtSiusYTZJj70kGRSnZOGBod6KQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZRT/mm9e8caXr5XPW5sNbsLvSOVNO2L5YsedeY9+ZRJf5mNF7XJP0InOC8sQq/JYL
 qtw8evjkEIrNMm81EtwJlMq3kZQARzWz/1MvtCp2Fwt/WuvRtwfHKQZJ7wNvDePruv
 vFBm5gT9aSsT5ORFatURwq2xrYsW5ZsvWZH5nMfKRQjhlni3o7IAwkxdUf58AZYgA8
 6vhgNdUYrRNb3eB7dtXucnOW8qfVUZ3KJkPZE3upFu+OVkfMa9xxZv3QZtCDVbPJU4
 anGte6eKbGI91i3tY3DsuomPke5MRBbx6mpUByeBc5Zd6dyBEd1LEpHmnIxn2oMjxY
 43QpmWh3q/vsw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PULL 4/4] linux-user/xtensa: fix unlock of uninitialized frame
 pointer on sigreturn
Date: Thu, 18 Jun 2026 23:54:11 +0200
Message-ID: <20260618215411.22057-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618215411.22057-1-deller@kernel.org>
References: <20260618215411.22057-1-deller@kernel.org>
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

From: Matt Turner <mattst88@gmail.com>

If lock_user_struct fails, frame is uninitialized but the badframe
label unconditionally calls unlock_user_struct on it. Handle the
lock failure inline so badframe is only reached with a valid lock.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/xtensa/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index e3f9da322b..4990c50045 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -355,7 +355,8 @@ long do_rt_sigreturn(CPUXtensaState *env)
 
     trace_user_do_rt_sigreturn(env, frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
-        goto badframe;
+        force_sig(TARGET_SIGSEGV);
+        return -QEMU_ESIGRETURN;
     }
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
-- 
2.54.0


