Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005E7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMU-0008Nx-6W; Tue, 12 May 2026 17:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuME-0007n6-LL; Tue, 12 May 2026 17:09:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMC-0003Ru-Nt; Tue, 12 May 2026 17:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=opGEO7diMnZcMSLx88mGJUbb/S7qf0ZqVr0UjX8gEhA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rhsPb6bX+njf8F+yoZlN3VKeYTyV1uSCXhWkzpqBwhFuQ8kWCm+WVlJjZ4O/qZM8T
 G9oRc6VLB3wHDxbTU3XCm+WH34rih2MskR26pyPOLBVJy2LkLgbzC9Tr15tcO+fu3v
 Ektq75f/SV7NH8Ft/W5H2RsIpg+UibSPRnr4bLjIZ7V/sv38SKt9GSOfHlhR+ZzDQC
 EfFS2v31PdErSKvYPBZI2jhJu4kgz7P18+2S2Tf2/UBFnpPQ3oGfAdDcPTVW0M+sdT
 K24Yigno9sTk7kFz6gL6Ek0YSBJ81gCyuGq79/s27mEbPpM31QmWgW8o0vzZoRWFyX
 +sHmG8y6p7Pcg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2765C1AA362;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 32F6E3ABCD2;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 037/117] scripts/qemu-guest-agent/fsfreeze-hook: Fix
 syslog-fallback logic
Date: Tue, 12 May 2026 23:53:39 +0300
Message-ID: <20260512205503.361097-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Maydell <peter.maydell@linaro.org>

In the fsfreeze script we attempt to implement "log to a file if we
can, and fall back to syslog if we cannot".  We do this with:

  [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
  touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1

This has a weird behaviour if it is run in a setup where we have
permissions that would allow us to write to $LOGFILE but it does not
currently exist.  On the first execution, the '-w' fails and so we
set USE_SYSLOG=1.  But since we also do the "touch $LOGFILE" step we
create an empty logfile.  Then on the second time the script is
executed, we see a writeable logfile and will use it.  The effect is
"log to syslog once, then to the logfile thereafter", which is not
likely to be what anybody wants.

Update the condition of the first check to only pick syslog if
the logfile exists but is not writable. This means that:
 * if the logfile doesn't exist but we are able to create it,
   we will create it and use it
 * if the logfile already exists and we can write to it,
   we will use it
 * if the logfile already exists but we can't write to it,
   we will fall back to syslog
 * if the logfile doesn't exist and we can't create it,
   we will fall back to syslog

Cc: qemu-stable@nongnu.org
Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260317094806.1944053-4-peter.maydell@linaro.org
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 08497afcb2a737794991f17a37f0a0971fca411e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 21eb5c5145..76669f5caf 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -21,8 +21,8 @@ is_ignored_file() {
 }
 
 USE_SYSLOG=0
-# if log file is not writable, fallback to syslog
-[ ! -w "$LOGFILE" ] && USE_SYSLOG=1
+# if log file exists but is not writable, fallback to syslog
+[ -e "$LOGFILE" ] && [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
 # try to update log file and fallback to syslog if it fails
 touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1
 
-- 
2.47.3


