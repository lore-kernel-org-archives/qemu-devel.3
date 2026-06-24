Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB6CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNt5-00049o-Ec; Wed, 24 Jun 2026 09:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsz-0003T3-SD; Wed, 24 Jun 2026 09:43:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsy-00025B-8f; Wed, 24 Jun 2026 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308007; bh=OF7kv8ty/UyH3XtZD3bgYaY8b9DOoJzTV7jeCA7mvHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N6byTTWMUq5gMxkMFMiku2+HdHaC5NkJ9LKfWoKCUc5Enpe8a7hvMRdm3jeU1FjKJ
 nBr0Li6OoNZn1NOaDnTSSvxjWRzGZ5TTNv+1KSSNMQuOiAPIw3Ek3BFHyRjnwf7K7d
 q5A6y/pwQza7EY/nCGzJE6cmguRs7ssQ4AxNizpEwThEd1TtwqRWTCZTPY6nwE7eOi
 ZcwOihwdnsPnj9yjyA+R//EKv1RIr8CxitAe+AlEbLbY7BFCJuRaxtLD8L4OsYgTFG
 JKlVxo2wcInCkEZUSJ8NTagwi8f3mT29/sIW7mFj1YxCIufW8x5SECOE2D//v4cFij
 0JbkwUcYBq1vw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E7D71BAA1A;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E5EF03DEA69;
 Wed, 24 Jun 2026 16:33:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 104/107] linux-user/xtensa: fix unlock of
 uninitialized frame pointer on sigreturn
Date: Wed, 24 Jun 2026 16:31:49 +0300
Message-ID: <20260624133301.403266-104-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

If lock_user_struct fails, frame is uninitialized but the badframe
label unconditionally calls unlock_user_struct on it. Handle the
lock failure inline so badframe is only reached with a valid lock.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 54e08dbe8f2aeca57e3b1a5eab09a9fec88c1c67)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


