Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0829CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrm3-00025i-HY; Wed, 30 Sep 2026 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001cp-Aq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qe-RP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBsoearseXoaf36T78qF+IBzK+3yvw/bQYK3j2HfHwA=;
 b=Q7bEPsFozZv0UeYzUbc4xme/XoSP7hDGyG9sX15eKalsveGePSHwJL/uzurNVXablL2bzB
 RgFafZJfFCj5HsqXyr/WFh5QhAn3/QjeMvddtZGuyY8hU8JOSOvMtWm971qDu0ZHNA0H0i
 OTIe4szD5olrXxNrWx6MqAZl/NE7ACY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-o8Yv-xICO86hU0JK94bTcQ-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: o8Yv-xICO86hU0JK94bTcQ-1
X-Mimecast-MFC-AGG-ID: o8Yv-xICO86hU0JK94bTcQ_1790764770
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68C2F185BE99; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 261D31956042; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3626D21E6486; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 099/105] qapi: convert/split intros for job.json commands
Date: Wed, 30 Sep 2026 12:39:04 +0200
Message-ID: <20260930103910.3934848-100-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: John Snow <jsnow@redhat.com>

Convert or split apart the existing intro for commands in job.json
into introduction and details sections. The introduction is indented,
remaining plaintext/details paragraphs are not.

@job-dismiss has its text split apart a little more aggressively to
help the documentation read more smoothly in the rendered version.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260928192557.509157-5-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/job.json | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index b68d729242..aa75a8efa2 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -128,8 +128,7 @@
 
 ##
 # @job-pause:
-#
-# Pause an active job.
+#     Pause an active job.
 #
 # This command returns immediately after marking the active job for
 # pausing.  Pausing an already paused job is an error.
@@ -148,8 +147,7 @@
 
 ##
 # @job-resume:
-#
-# Resume a paused job.
+#     Resume a paused job.
 #
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
@@ -165,10 +163,9 @@
 
 ##
 # @job-cancel:
-#
-# Instruct an active background job to cancel at the next opportunity.
-# This command returns immediately after marking the active job for
-# cancellation.
+#     Instruct an active background job to cancel at the next
+#     opportunity.  This command returns immediately after marking the
+#     active job for cancellation.
 #
 # The job will cancel as soon as possible and then emit a
 # `JOB_STATUS_CHANGE` event.  Usually, the status will change to
@@ -184,9 +181,9 @@
 
 ##
 # @job-complete:
-#
-# Manually trigger completion of an active job in the READY or STANDBY
-# state.  Completing the job in any other state is an error.
+#     Manually trigger completion of an active job in the READY or
+#     STANDBY state.  Completing the job in any other state is an
+#     error.
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
@@ -211,14 +208,14 @@
 
 ##
 # @job-dismiss:
+#     Deletes a job that is in the CONCLUDED state.
 #
-# Deletes a job that is in the CONCLUDED state.  This command only
-# needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.  In turn, automatic dismiss may be enabled only for
-# jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
-# and `block-stream`.  @auto-dismiss is enabled by default for these
-# jobs.
+# This command only needs to be run explicitly for jobs that don't
+# have automatic dismiss enabled.  In turn, automatic dismiss may be
+# enabled only for jobs that have @auto-dismiss option, which are
+# `drive-backup`, `blockdev-backup`, `drive-mirror`,
+# `blockdev-mirror`, `block-commit` and `block-stream`.  @auto-dismiss
+# is enabled by default for these jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
@@ -233,11 +230,10 @@
 
 ##
 # @job-finalize:
-#
-# Instructs all jobs in a transaction (or a single job if it is not
-# part of any transaction) to finalize any graph changes and do any
-# necessary cleanup.  This command requires that all involved jobs are
-# in the PENDING state.
+#     Instructs all jobs in a transaction (or a single job if it is
+#     not part of any transaction) to finalize any graph changes and
+#     do any necessary cleanup.  This command requires that all
+#     involved jobs are in the PENDING state.
 #
 # For jobs in a transaction, instructing one job to finalize will
 # force ALL jobs in the transaction to finalize, so it is only
-- 
2.55.0


