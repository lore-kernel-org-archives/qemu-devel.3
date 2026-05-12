Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185F4CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuRe-00007u-3I; Tue, 12 May 2026 17:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuRb-0008Kp-3P; Tue, 12 May 2026 17:15:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuRZ-00066z-1j; Tue, 12 May 2026 17:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=zFDJf8yIYUB/twmcIlBtgTln1mnhH3QL8rKuTxLxqGY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=r8QUS+3N7/P3w590RBUqIka0IqjmiaUwc8EYGtxl50FwnFm6HL1RSRzEGd4JBPQIX
 r80p2DsToHgtXcKRrBKXEOJEsaeSWEkKo5d4F6mlfmRHBVmVzsncRBdLbE4STuSwMR
 HlPWKP7Wn3Kenl0iPDKlbNVda91qQpJ6RBdcsGAxxRC9iw5sX0cHspUWc7vWdv3te4
 Di0dRzo3r5V5fdi7KTnNeNamH0goCJqnbP1hlrbZ8Ik38haFDDUkqLHj9JrGH1NeLQ
 befY8W7jU06v990SWNeUcmik5q6/79d1uZzdK2JIQiMRPPwbgVBlyeKr6D3j8lDH62
 5jl2qTsMW3Sbw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DAA671AA399;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DF0923ABD08;
 Tue, 12 May 2026 23:55:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 091/117] linux-user: Flush errors by using exit()
 instead of _exit() in error path
Date: Tue, 12 May 2026 23:54:33 +0300
Message-ID: <20260512205503.361097-91-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

Qemu user mode does not properly flushes error messages related to bad
arguments when exiting (at least when the output is piped to a file
instead of running on a terminal).
Ensure that we always flush by using exit() instead of _exit().

Reported by: Tobias Bergkvist
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 9e7734ead149d73f1d25f61d0b7f075d4b2cb07d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/main.c b/linux-user/main.c
index c49d1e91d2..84e110dfe9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -767,7 +767,7 @@ int main(int argc, char **argv, char **envp)
         execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
             printf("Error while loading %s: %s\n", exec_path, strerror(errno));
-            _exit(EXIT_FAILURE);
+            exit(EXIT_FAILURE);
         }
     }
 
-- 
2.47.3


