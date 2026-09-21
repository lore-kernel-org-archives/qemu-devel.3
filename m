Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAD8C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8l53-0005M7-0L; Mon, 21 Sep 2026 16:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l4z-0005Kw-RA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l4x-0003YG-Sl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790024255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvxpNyORierNGQUOqwuOaHgR/j0WTOhNPJNjkzjFekY=;
 b=UgdlxE2XnQlMdkXDFOKYfk8ssEY4l0GW7qE4yEpLYdEJMbRrl50JRh4AXb2Jdo3kkjNjsZ
 VeTHyFFjobmAq1kn9loli8Yg/m8pJJQEmCtAo0LdeEeGIKj1gaen6uxHB1B1hJMyu6PUid
 xps4bbVEsnOuhHP3ufvOATgm9wuA82o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-PahojPbzPVeMzo_hyNIuag-1; Mon,
 21 Sep 2026 16:57:31 -0400
X-MC-Unique: PahojPbzPVeMzo_hyNIuag-1
X-Mimecast-MFC-AGG-ID: PahojPbzPVeMzo_hyNIuag_1790024250
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7112C1933E3A; Mon, 21 Sep 2026 20:57:30 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B07051956047; Mon, 21 Sep 2026 20:57:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 04/10] qapi: convert/split intros for job.json commands
Date: Mon, 21 Sep 2026 16:57:06 -0400
Message-ID: <20260921205712.1862167-5-jsnow@redhat.com>
In-Reply-To: <20260921205712.1862167-1-jsnow@redhat.com>
References: <20260921205712.1862167-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/job.json | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index b68d7292423..aa75a8efa24 100644
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


