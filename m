Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2283110F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bcn-0003z6-Ao; Fri, 27 Mar 2026 14:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BcZ-0003wq-RO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BcS-0002Ru-Nk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774634955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v45564o7v1jdhOY/Wc628rhxJLScUOhlcWmhroo/Vpc=;
 b=DDlajBr4XCfxEWyxWDO1XBxIGu0vJt47QPTDRy+sytpEbLLZf0inHigc1DAIPnHHDupGCn
 t7K0fIyPW/AEcM8bDHQExT1DX6iusu0j/vKc2mW0q9VWR4QCuzsmsbpqVrR5tm/Evj9wor
 aopzJi5Kf0V9y7ia6bycEyQ1Dfzh6uc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-E5dO_MS9MHKSILgi7QAJ-g-1; Fri,
 27 Mar 2026 14:09:12 -0400
X-MC-Unique: E5dO_MS9MHKSILgi7QAJ-g-1
X-Mimecast-MFC-AGG-ID: E5dO_MS9MHKSILgi7QAJ-g_1774634951
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59EEF19560A6; Fri, 27 Mar 2026 18:09:11 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30DD61800760; Fri, 27 Mar 2026 18:09:09 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Subject: [PULL 1/3] scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
Date: Fri, 27 Mar 2026 20:09:03 +0200
Message-ID: <20260327180905.378560-2-kkostiuk@redhat.com>
In-Reply-To: <20260327180905.378560-1-kkostiuk@redhat.com>
References: <20260327180905.378560-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 scripts/qemu-guest-agent/fsfreeze-hook | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

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
2.52.0


