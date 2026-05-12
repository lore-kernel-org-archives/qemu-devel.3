Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B1CCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGs-0004VM-SP; Tue, 12 May 2026 17:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFi-0001Qy-EO; Tue, 12 May 2026 17:03:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFe-0007gx-RA; Tue, 12 May 2026 17:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=58bcFKJKFzhLq1flbHeG42oCoSB9ipPrqaov/X5rH4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rBStogTxb4xE5rFVMYAMFDNj7uCfvt5CaNnHI/Uz0kBlfYskiyP6tKfVvy+VCEnmE
 X5OP3EQJvpN3d5AMVWf1saSNk9DClKd4Z1XoXVqQlloZiSuOSPm0cJnvvmvVIrCOnK
 qJY7dAopW5rjcWtWiJ0HTS5TcHz69IHlxQjTw/aNyxCMoSNhxX/gsNrxe4r3gouTN2
 J/vP6q8HYrOW36XZeUjUWmPmOqP7u77EubJHW1vbUQFJ2BKbP/9RjHTCwqPhzv7Eig
 waDukelkBTTMtEeD4kjny7FUpVgO8rrB4dcAMoquCTMK14QrNDTahc0VjSgwLrvu3M
 RaWPb2uMRKawg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B20551AA31D;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B61A93ABC8E;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 081/107] linux-user: Flush errors by using exit()
 instead of _exit() in error path
Date: Tue, 12 May 2026 23:54:08 +0300
Message-ID: <20260512205437.360850-81-mjt@tls.msk.ru>
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
index db99160d2d..39ac98a74a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -786,7 +786,7 @@ int main(int argc, char **argv, char **envp)
         execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
             printf("Error while loading %s: %s\n", exec_path, strerror(errno));
-            _exit(EXIT_FAILURE);
+            exit(EXIT_FAILURE);
         }
     }
 
-- 
2.47.3


