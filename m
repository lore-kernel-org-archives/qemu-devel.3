Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F53BE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlRG-0008Qk-4D; Mon, 06 Jan 2025 06:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUlRE-0008QE-LU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUlRD-0004Al-3i
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736163506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CetRUUBxtPevXxM7igiwTG2nR/AZhjJ6d2ql9nH4u9M=;
 b=VubMBDbdzZVmdaVkB5KkgTt+xYzcioPv5uNujvxPUkwYN04hgrpjSbMz2WT+oPYbYZEXsG
 sjTqVOgKjddLncc01Ss+dWMcvjoU2aANN9pYTaH9MRmBtshdJAihS8LIw1Bc0Bqe/4upZM
 qlnJoTWDgyZNVJd/voq13sdIzm+B6ns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-E8Qd4lTBPdeCk5PmNWBNuQ-1; Mon,
 06 Jan 2025 06:38:24 -0500
X-MC-Unique: E8Qd4lTBPdeCk5PmNWBNuQ-1
X-Mimecast-MFC-AGG-ID: E8Qd4lTBPdeCk5PmNWBNuQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 700D91955E8D; Mon,  6 Jan 2025 11:38:23 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2668E3000197; Mon,  6 Jan 2025 11:38:21 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/2] qemu-ga: Optimize freeze-hook script logic of logging error
Date: Mon,  6 Jan 2025 13:38:14 +0200
Message-ID: <20250106113814.35459-3-kkostiuk@redhat.com>
In-Reply-To: <20250106113814.35459-1-kkostiuk@redhat.com>
References: <20250106113814.35459-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

From: Dehan Meng <demeng@redhat.com>

Make sure the error log of fsfreeze hooks
when freeze/thaw/snapshot could be logged
to system logs if the default logfile of
qga can't be written or other situations

Signed-off-by: Dehan Meng <demeng@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20241225083744.277374-1-demeng@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.47.1


