Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994C1CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuIB-0001Pn-EU; Tue, 12 May 2026 17:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuGj-0003M4-GX; Tue, 12 May 2026 17:03:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuGh-0007yj-Ky; Tue, 12 May 2026 17:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619279; bh=jlweqHsRclPjzVpESFSnRSyHSwik9MIMl7d+JoYYJZ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RqS6VlfolG3RdVuEKV4v36EUxvx6xTScHPKStZtchB73eZe3waZIF+3ydFs1tfm6j
 p+vmfRr7gzgz9gouhBWfSaNqafyBdHpOO6epWm4UEUrX5pVUxFesA0gDcjQ651lEuo
 ocub517nVV0Ene5FnxVS9t8GKUVzzD+3YWmwV2Wsrh/Ep5LXhHp9UIeiTKPeYItBsu
 W4waBACei52AM0sEbuHpG5d5t/WAEF47d119SKL16VMSow063dqFmW6/ArO6zeblqD
 wBYXtKs7mM2Gqig2zv6X2/oJUuVff3yDyZYtfOvl+3p14qMlY/H7QeU1Yp2Zk9XmAt
 /Uiufc7xzvvEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 53FA71AA326;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 574D63ABC97;
 Tue, 12 May 2026 23:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Warner Losh <imp@bsdimp.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 090/107] linux-user: Flush errors by using exit()
 instead of _exit() in error path
Date: Tue, 12 May 2026 23:54:17 +0300
Message-ID: <20260512205437.360850-90-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Similiar to previous patch - ensure that we always flush I/O by using
exit() instead of _exit().

Reported by: Tobias Bergkvist <tobias@bergkv.ist>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 9fb681792d65fa570cb3e1a769945c10bf276d25)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/main.c b/linux-user/main.c
index 39ac98a74a..57fc568e72 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -987,7 +987,7 @@ int main(int argc, char **argv, char **envp)
         info, &bprm);
     if (ret != 0) {
         printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
-        _exit(EXIT_FAILURE);
+        exit(EXIT_FAILURE);
     }
 
     for (wrk = target_environ; *wrk; wrk++) {
-- 
2.47.3


