Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E393F10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bct-0003zC-HD; Fri, 27 Mar 2026 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6Bcb-0003x6-53
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BcY-0002SW-OS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774634959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sr+/JG3n/S4Z1brMvv8Rm72w4ChyR/gR5Pw29+Ls2ss=;
 b=BCFw5Vc3S6XxiNXNia+5ENkKi9Z5a91KJPBirAyG36qmmfSMutFupDURdA+TYow8KBOEmX
 dgBXHPU4PdamqzYFWxmxgTetgvpImoNtpz5Ve5XWBYxQxs4FznWOR+A7nxHavod0PTCHtp
 1LttW/dR/MqLOoI2uuagevrl9Vi5oII=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-zWMIcIRRMXSIz7lwFpzZsw-1; Fri,
 27 Mar 2026 14:09:14 -0400
X-MC-Unique: zWMIcIRRMXSIz7lwFpzZsw-1
X-Mimecast-MFC-AGG-ID: zWMIcIRRMXSIz7lwFpzZsw_1774634953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ACD81800345; Fri, 27 Mar 2026 18:09:13 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8FFE1800763; Fri, 27 Mar 2026 18:09:11 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Subject: [PULL 2/3] scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of
 PIPESTATUS
Date: Fri, 27 Mar 2026 20:09:04 +0200
Message-ID: <20260327180905.378560-3-kkostiuk@redhat.com>
In-Reply-To: <20260327180905.378560-1-kkostiuk@redhat.com>
References: <20260327180905.378560-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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
---
 scripts/qemu-guest-agent/fsfreeze-hook | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

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
2.52.0


