Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9473CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMD-0007eF-He; Tue, 12 May 2026 17:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMB-0007Qt-4t; Tue, 12 May 2026 17:09:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuM9-0003Ln-10; Tue, 12 May 2026 17:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=MTXhZdUjhIEYWnwZZmspysqWDV7PKPgiFTrPw5Ta2sk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eOOSAVRxYp3fuSe7dVAj4fP8ZYEnuF42ygXx7Pgwigd3UpglkoPLLPFRwi+T0ol/N
 SjiRn4q2aNWErlcN3wcK9t1Pgl9Udz6e7ydAo8TahHvwc1nYiNygp+iVH2e9sc+Slr
 z8s3VoiiMgy4BliMaKobznmUVPvBzF2hFNnL/MU2hFpp1zyUOL5cbz1jg3HZajqB76
 kHuwd8Aa6qGq6xlp/e6HOX6leXtZntVmWaNkJ2N095747zZHIiOEwwemYomYXL/1Cx
 jeukKNOhDZrjWto3KH2rqjyAYA1idixIJuzh+3H+v+k9DLn5OGhtBDWG6mHAYTnokc
 9DGa9Ko7M5TGg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A3961AA360;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1744A3ABCD0;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 035/117] scripts/qemu-guest-agent/fsfreeze-hook: Avoid
 bash-isms
Date: Tue, 12 May 2026 23:53:37 +0300
Message-ID: <20260512205503.361097-35-mjt@tls.msk.ru>
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

The fsfreeze-hook script starts with #!/bin/sh, but it uses
several bash-specific constructs, resulting in misbehaviour
on guest systems where /bin/sh is some other POSIX shell.

Fix the simple ones reported by shellcheck:

In scripts/qemu-guest-agent/fsfreeze-hook line 27:
touch "$LOGFILE" &>/dev/null || USE_SYSLOG=1
                 ^---------^ SC3020 (warning): In POSIX sh, &> is undefined.

In scripts/qemu-guest-agent/fsfreeze-hook line 31:
    local message="$1"
    ^-----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

In scripts/qemu-guest-agent/fsfreeze-hook line 46:
    log_message "Executing $file $@"
                                 ^-- SC2145 (error): Argument mixes string and array. Use * or separate argument.

In scripts/qemu-guest-agent/fsfreeze-hook line 55:
    if [ $STATUS -ne 0 ]; then
         ^-----^ SC2086 (info): Double quote to prevent globbing and word splitting.

There is also a use of PIPESTATUS that is more complex to fix;
that will be dealt with in a separate commit.

Cc: qemu-stable@nongnu.org
Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260317094806.1944053-2-peter.maydell@linaro.org
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit b5abb655fab6145ff3728d4bdaea3648468590fc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 5b915af017..6e2d7588af 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -24,15 +24,14 @@ USE_SYSLOG=0
 # if log file is not writable, fallback to syslog
 [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
 # try to update log file and fallback to syslog if it fails
-touch "$LOGFILE" &>/dev/null || USE_SYSLOG=1
+touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1
 
 # Ensure the log file is writable, fallback to syslog if not
 log_message() {
-    local message="$1"
     if [ "$USE_SYSLOG" -eq 0 ]; then
-        printf "%s: %s\n" "$(date)" "$message" >>"$LOGFILE"
+        printf "%s: %s\n" "$(date)" "$1" >>"$LOGFILE"
     else
-        logger -t qemu-ga-freeze-hook "$message"
+        logger -t qemu-ga-freeze-hook "$1"
     fi
 }
 
@@ -43,7 +42,7 @@ for file in "$FSFREEZE_D"/* ; do
     is_ignored_file "$file" && continue
     [ -x "$file" ] || continue
 
-    log_message "Executing $file $@"
+    log_message "Executing $file $*"
     if [ "$USE_SYSLOG" -eq 0 ]; then
         "$file" "$@" >>"$LOGFILE" 2>&1
         STATUS=$?
@@ -52,7 +51,7 @@ for file in "$FSFREEZE_D"/* ; do
         STATUS=${PIPESTATUS[0]}
     fi
 
-    if [ $STATUS -ne 0 ]; then
+    if [ "$STATUS" -ne 0 ]; then
         log_message "Error: $file finished with status=$STATUS"
     else
         log_message "$file finished successfully"
-- 
2.47.3


