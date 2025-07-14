Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF12C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKpv-0004P8-Ir; Mon, 14 Jul 2025 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUl-0000NN-Qd
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0003ch-Bk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goTk8fpkg6kLQG+1Ex/C2mUcAe3gDFJizHbedpmLko0=;
 b=iQO/FQkOoUsboWBKfT/86d/8YOzjnicOgJYy0yo/oGLzsNkxalPYtIYuhEfJaxvuk1OQlQ
 tZIaTNn1VuRqpqaunVJKkEbwyA+Cq0RIVV4nUoT/WuP12MlJt1EPx9U+aF1f+/8/Yd9+ia
 RV5ZJbnYvzQtsWMg1C3BrHxJMUg5kPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-m-b68erGOrmopJ99JPPvtQ-1; Mon,
 14 Jul 2025 09:45:10 -0400
X-MC-Unique: m-b68erGOrmopJ99JPPvtQ-1
X-Mimecast-MFC-AGG-ID: m-b68erGOrmopJ99JPPvtQ_1752500709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BAEA1955F41
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6907019560A3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06C7A21E668C; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 17/32] qapi: add cross-references to job.json
Date: Mon, 14 Jul 2025 15:44:43 +0200
Message-ID: <20250714134458.2991097-18-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-7-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Accidental line rewrap and an unwanted cross-refence dropped]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/job.json | 56 +++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 51a57c523e..8b08350af2 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -12,26 +12,26 @@
 #
 # Type of a background job.
 #
-# @commit: block commit job type, see "block-commit"
+# @commit: block commit job type, see `block-commit`
 #
-# @stream: block stream job type, see "block-stream"
+# @stream: block stream job type, see `block-stream`
 #
-# @mirror: drive mirror job type, see "drive-mirror"
+# @mirror: drive mirror job type, see `drive-mirror`
 #
-# @backup: drive backup job type, see "drive-backup"
+# @backup: drive backup job type, see `drive-backup`
 #
-# @create: image creation job type, see "blockdev-create" (since 3.0)
+# @create: image creation job type, see `blockdev-create` (since 3.0)
 #
-# @amend: image options amend job type, see "x-blockdev-amend"
+# @amend: image options amend job type, see `x-blockdev-amend`
 #     (since 5.1)
 #
-# @snapshot-load: snapshot load job type, see "snapshot-load"
+# @snapshot-load: snapshot load job type, see `snapshot-load`
 #     (since 6.0)
 #
-# @snapshot-save: snapshot save job type, see "snapshot-save"
+# @snapshot-save: snapshot save job type, see `snapshot-save`
 #     (since 6.0)
 #
-# @snapshot-delete: snapshot delete job type, see "snapshot-delete"
+# @snapshot-delete: snapshot delete job type, see `snapshot-delete`
 #     (since 6.0)
 #
 # Since: 1.7
@@ -67,7 +67,7 @@
 #
 # @pending: The job has finished its work, but has finalization steps
 #     that it needs to make prior to completing.  These changes will
-#     require manual intervention via @job-finalize if auto-finalize
+#     require manual intervention via `job-finalize` if auto-finalize
 #     was set to false.  These pending changes may still fail.
 #
 # @aborting: The job is in the process of being aborted, and will
@@ -77,7 +77,7 @@
 #
 # @concluded: The job has finished all work.  If auto-dismiss was set
 #     to false, the job will remain in this state until it is
-#     dismissed via @job-dismiss.
+#     dismissed via `job-dismiss`.
 #
 # @null: The job is in the process of being dismantled.  This state
 #     should not ever be visible externally.
@@ -93,21 +93,21 @@
 #
 # Represents command verbs that can be applied to a job.
 #
-# @cancel: see @job-cancel
+# @cancel: see `job-cancel`
 #
-# @pause: see @job-pause
+# @pause: see `job-pause`
 #
-# @resume: see @job-resume
+# @resume: see `job-resume`
 #
-# @set-speed: see @block-job-set-speed
+# @set-speed: see `block-job-set-speed`
 #
-# @complete: see @job-complete
+# @complete: see `job-complete`
 #
-# @dismiss: see @job-dismiss
+# @dismiss: see `job-dismiss`
 #
-# @finalize: see @job-finalize
+# @finalize: see `job-finalize`
 #
-# @change: see @block-job-change (since 8.2)
+# @change: see `block-job-change` (since 8.2)
 #
 # Since: 2.12
 ##
@@ -140,7 +140,7 @@
 #
 # The job will pause as soon as possible, which means transitioning
 # into the PAUSED state if it was RUNNING, or into STANDBY if it was
-# READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
+# READY.  The corresponding `JOB_STATUS_CHANGE` event will be emitted.
 #
 # Cancelling a paused job automatically resumes it.
 #
@@ -175,7 +175,7 @@
 # cancellation.
 #
 # The job will cancel as soon as possible and then emit a
-# JOB_STATUS_CHANGE event.  Usually, the status will change to
+# `JOB_STATUS_CHANGE` event.  Usually, the status will change to
 # ABORTING, but it is possible that a job successfully completes (e.g.
 # because it was almost done and there was no opportunity to cancel
 # earlier than completing the job) and transitions to PENDING instead.
@@ -194,14 +194,14 @@
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
-# mirroring includes drive-mirror, blockdev-mirror and block-commit
+# mirroring includes `drive-mirror`, `blockdev-mirror` and `block-commit`
 # job (only in case of "active commit", when the node being commited
 # is used by the guest).  The ability to complete is signaled with a
-# BLOCK_JOB_READY event.
+# `BLOCK_JOB_READY` event.
 #
 # This command completes an active background block operation
 # synchronously.  The ordering of this command's return with the
-# BLOCK_JOB_COMPLETED event is not defined.  Note that if an I/O error
+# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O error
 # occurs during the processing of this command: 1) the command itself
 # will fail; 2) the error will be processed according to the
 # rerror/werror arguments that were specified when starting the
@@ -219,14 +219,14 @@
 # Deletes a job that is in the CONCLUDED state.  This command only
 # needs to be run explicitly for jobs that don't have automatic
 # dismiss enabled.  In turn, automatic dismiss may be enabled only
-# for jobs that have @auto-dismiss option, which are drive-backup,
-# blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
-# block-stream.  @auto-dismiss is enabled by default for these
+# for jobs that have @auto-dismiss option, which are `drive-backup`,
+# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit` and
+# `block-stream`.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
-# the JOB_READY event, job-cancel or job-complete will still need to
+# the JOB_READY event, `job-cancel` or `job-complete` will still need to
 # be used as appropriate.
 #
 # @id: The job identifier.
-- 
2.49.0


