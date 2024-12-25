Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABD0E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 08:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQMu5-0002dL-PB; Wed, 25 Dec 2024 03:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1tQMu2-0002cj-Ox
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 03:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1tQMu0-0004Wl-Cd
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 03:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735115878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MyJFkDoeUbyNu6pFuHgrzeTcWJQh+2xOk2sQbPsr/kw=;
 b=PRGDdAqvxHE7CeQjXj9NT4/J+YPItgUe6hbVsaoyyVMEctWInklI8uU9TzDGQrpq4PFEKS
 0ISh/jFjskB/QWbVgCwUIUYmMy5kda37kjnmW8wjQ4w3C98GqT6I2o/1gw54XtlVyQ/TMj
 PAmxzKuf/ZsaSWw15x6E4JoYIPUDswY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-F9YqC7vzM5yn0YO4Z7tH_A-1; Wed,
 25 Dec 2024 03:37:54 -0500
X-MC-Unique: F9YqC7vzM5yn0YO4Z7tH_A-1
X-Mimecast-MFC-AGG-ID: F9YqC7vzM5yn0YO4Z7tH_A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87B7F195608C; Wed, 25 Dec 2024 08:37:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C9D21956052; Wed, 25 Dec 2024 08:37:49 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH] qemu-ga: Optimize freeze-hook script logic of logging error
Date: Wed, 25 Dec 2024 16:37:44 +0800
Message-Id: <20241225083744.277374-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make sure the error log of fsfreeze hooks
when freeze/thaw/snapshot could be logged
to system logs if the default logfile of
qga can't be written or other situations

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 36 +++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 13aafd4845..c1feb6f5ce 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -19,15 +19,43 @@ is_ignored_file() {
     return 1
 }
 
+USE_SYSLOG=0
+# if log file is not writable, fallback to syslog
+[ ! -w "$LOGFILE" ] && USE_SYSLOG=1
+# try to update log file and fallback to syslog if it fails
+touch "$LOGFILE" &>/dev/null || USE_SYSLOG=1
+
+# Ensure the log file is writable, fallback to syslog if not
+log_message() {
+    local message="$1"
+    if [ "$USE_SYSLOG" -eq 0 ]; then
+        printf "%s: %s\n" "$(date)" "$message" >>"$LOGFILE"
+    else
+        logger -t qemu-ga-freeze-hook "$message"
+    fi
+}
+
 # Iterate executables in directory "fsfreeze-hook.d" with the specified args
 [ ! -d "$FSFREEZE_D" ] && exit 0
+
 for file in "$FSFREEZE_D"/* ; do
     is_ignored_file "$file" && continue
     [ -x "$file" ] || continue
-    printf "$(date): execute $file $@\n" >>$LOGFILE
-    "$file" "$@" >>$LOGFILE 2>&1
-    STATUS=$?
-    printf "$(date): $file finished with status=$STATUS\n" >>$LOGFILE
+
+    log_message "Executing $file $@"
+    if [ "$USE_SYSLOG" -eq 0 ]; then
+        "$file" "$@" >>"$LOGFILE" 2>&1
+        STATUS=$?
+    else
+        "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
+        STATUS=${PIPESTATUS[0]}
+    fi
+
+    if [ $STATUS -ne 0 ]; then
+        log_message "Error: $file finished with status=$STATUS"
+    else
+        log_message "$file finished successfully"
+    fi
 done
 
 exit 0
-- 
2.40.1


