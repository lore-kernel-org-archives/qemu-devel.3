Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDA10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bct-0003zD-Gs; Fri, 27 Mar 2026 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6Bcb-0003x7-65
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BcY-0002SS-Ie
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774634959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIAaJAjcvFaLvDqLLXrGMVTN6RSpPKshiiUuUkR1Gcs=;
 b=VLQUKjyEmcP6zrX6i9g95jI7o/zwEBpEuieyxU3nz3rdV3KNv6qzfflNYOo5Cd6NMf9cqg
 of+GmEm/EUkV7+ygf1/wLQkvhqnhuWgJjOXfD7xFwoDgnRMaOkFLQwsg7Px+4VpvKuNohF
 u3NQyKONszxnPS7WRT1gqFCfaHbUMbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-TmqwS21QPmaQ67-GF_w7FQ-1; Fri,
 27 Mar 2026 14:09:16 -0400
X-MC-Unique: TmqwS21QPmaQ67-GF_w7FQ-1
X-Mimecast-MFC-AGG-ID: TmqwS21QPmaQ67-GF_w7FQ_1774634955
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD925180034E; Fri, 27 Mar 2026 18:09:14 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B161800761; Fri, 27 Mar 2026 18:09:13 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Subject: [PULL 3/3] scripts/qemu-guest-agent/fsfreeze-hook: Fix
 syslog-fallback logic
Date: Fri, 27 Mar 2026 20:09:05 +0200
Message-ID: <20260327180905.378560-4-kkostiuk@redhat.com>
In-Reply-To: <20260327180905.378560-1-kkostiuk@redhat.com>
References: <20260327180905.378560-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 scripts/qemu-guest-agent/fsfreeze-hook | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.52.0


