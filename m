Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5588DCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMQ-0008Cp-2g; Tue, 12 May 2026 17:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuME-0007ku-B6; Tue, 12 May 2026 17:09:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMC-0003MX-Ca; Tue, 12 May 2026 17:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=2S1GGvJaNsn51bYl05lwRS9Qw+/ufVmwcAlhOtnfHIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jgK+XzZKy25GnvsKu7ac4+vGBg1JsybQs9cQwVxPxJNtevHAR0wc/sDoUxeqoHGLO
 2Pmiw2Jw3OluTskMYgCJDHtgE915eI0qqNK0mTEhm0DuQlJwMb//VQxpVuCC9lSr1i
 Y9PNOEAfI3GcmFN9mVnISLeXA71zlOASvBwpMN6XjpRFYwMGoDywmV1G79aykC8Iy5
 7bE5ooCc92nEPEVsDnA2bGLQYeuXwvz0OwETDHioYWg742nlfXQbWAl9LMsros8D+p
 umNHEjl0nJhrfaSpL9xYMaDvxn8DCTcF/dOLHyBfY1tF7/PbK64vsGPB2B3VDFbPJV
 7nZPsnL1432Eg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 17DBB1AA361;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 254B93ABCD1;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 036/117] scripts/qemu-guest-agent/fsfreeze-hook: Avoid
 use of PIPESTATUS
Date: Tue, 12 May 2026 23:53:38 +0300
Message-ID: <20260512205503.361097-36-mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

PIPESTATUS is a bash-specific construct, and this script is supposed
to be POSIX shell. We only use it in one place, to capture the exit
status of a command whose output we are piping to 'logger'.

Replace the PIPESTATUS usage with the trick described in
https://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/70675#70675
which uses a command-group to capture the status of the
first process in the pipeline.

Cc: qemu-stable@nongnu.org
Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3339
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260317094806.1944053-3-peter.maydell@linaro.org
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 65b9f4791c24b09814ae51135e8dad283faed348)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 6e2d7588af..21eb5c5145 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -47,8 +47,23 @@ for file in "$FSFREEZE_D"/* ; do
         "$file" "$@" >>"$LOGFILE" 2>&1
         STATUS=$?
     else
-        "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
-        STATUS=${PIPESTATUS[0]}
+        # We want to pipe the output of $file through 'logger' and also
+        # capture its exit status. Since we are a POSIX script we can't
+        # use PIPESTATUS, so instead this is a trick borrowed from
+        # https://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/70675#70675
+        # which uses command-groups and redirection to get the exit status.
+        # This is equivalent to
+        #   "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
+        # plus setting the exit status of the pipe to the exit
+        # status of the first command rather than the last one.
+        { { { {
+                "$file" "$@" 2>&1 3>&- 4>&-
+                echo $? >&3
+            } | logger -t qemu-ga-freeze-hook >&4
+            } 3>&1
+          } | { read -r xs ; exit "$xs"; }
+        } 4>&1
+        STATUS=$?
     fi
 
     if [ "$STATUS" -ne 0 ]; then
-- 
2.47.3


