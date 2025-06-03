Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAE3C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLI6-0000MC-Ft; Tue, 03 Jun 2025 02:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGb-0007jd-6n
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGY-0003RI-Do
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnFSGK1CctR2WtyuT5Bw9qUosWhTcg0WPez9U4gK6JE=;
 b=cQ7pJt6I7XFmNdQcFu9IL8v4OxHAv+Utr8oOuVCxRmub5FwVOM8KZkKZ1JEMADYrCk/VD9
 uQ+V22FeGed7RsgxLbAKBMzHakL36WHOgX5uyB+nqHzUhyJ3WpzMa23hOpHVPBKfKCstjJ
 4EIPfsLT/0u/s+O0nQQRX0LEzX+7tYM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-HJjqF6kYOm2QMQl3eFUQ9A-1; Tue,
 03 Jun 2025 02:36:52 -0400
X-MC-Unique: HJjqF6kYOm2QMQl3eFUQ9A-1
X-Mimecast-MFC-AGG-ID: HJjqF6kYOm2QMQl3eFUQ9A_1748932611
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31C3A19560AF
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCDFE1956094
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1ED5E21E6540; Tue, 03 Jun 2025 08:36:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 13/13] qapi: Improve documentation around job state @concluded
Date: Tue,  3 Jun 2025 08:36:44 +0200
Message-ID: <20250603063644.3953528-14-armbru@redhat.com>
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We use "the query list" in a few places.  It's not entirely obvious
what that means.  It's actually the output of query-jobs or
query-block-jobs.

Documentation of @auto-dismiss talks about the job disappearing from
the query list when it reaches state @concluded.  This is less than
precise.  The job doesn't merely disappear from the query list, it
disappears, period.

Documentation of JobStatus @concluded explains "the job will remain in
the query list until it is dismissed".  Again less than precise.  It
remains in state @concluded until dismissed.

Rephrase without use of "the query list" for clarity and precision.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-14-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 19 +++++++------------
 qapi/job.json        |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index da390f85ac..1df6644f0d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1417,8 +1417,8 @@
 # @auto-finalize: Job will finalize itself when PENDING, moving to the
 #     CONCLUDED state.  (since 2.12)
 #
-# @auto-dismiss: Job will dismiss itself when CONCLUDED, moving to the
-#     NULL state and disappearing from the query list.  (since 2.12)
+# @auto-dismiss: Job will dismiss itself when CONCLUDED, and
+#     disappear.  (since 2.12)
 #
 # @error: Error information if the job did not complete successfully.
 #     Not set if the job completed successfully.  (since 2.12.1)
@@ -1614,8 +1614,7 @@
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
 #     @job-dismiss.  When true, this job will automatically disappear
-#     from the query list without user intervention.  Defaults to
-#     true.  (Since 2.12)
+#     without user intervention.  Defaults to true.  (Since 2.12)
 #
 # @filter-node-name: the node name that should be assigned to the
 #     filter driver that the backup job inserts into the graph above
@@ -1855,8 +1854,7 @@
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
 #     @job-dismiss.  When true, this job will automatically disappear
-#     from the query list without user intervention.  Defaults to
-#     true.  (Since 3.1)
+#     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # Features:
 #
@@ -2219,8 +2217,7 @@
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
 #     @job-dismiss.  When true, this job will automatically disappear
-#     from the query list without user intervention.  Defaults to
-#     true.  (Since 3.1)
+#     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # Since: 1.3
 ##
@@ -2538,8 +2535,7 @@
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
 #     @job-dismiss.  When true, this job will automatically disappear
-#     from the query list without user intervention.  Defaults to
-#     true.  (Since 3.1)
+#     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # @target-is-zero: Assume the destination reads as all zeroes before
 #     the mirror started.  Setting this to true can speed up the
@@ -2866,8 +2862,7 @@
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
 #     @job-dismiss.  When true, this job will automatically disappear
-#     from the query list without user intervention.  Defaults to
-#     true.  (Since 3.1)
+#     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # Errors:
 #     - If @device does not exist, DeviceNotFound.
diff --git a/qapi/job.json b/qapi/job.json
index 441cd7772b..126fa5ce60 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -74,7 +74,7 @@
 #     process.
 #
 # @concluded: The job has finished all work.  If auto-dismiss was set
-#     to false, the job will remain in the query list until it is
+#     to false, the job will remain in this state until it is
 #     dismissed via @job-dismiss.
 #
 # @null: The job is in the process of being dismantled.  This state
-- 
2.48.1


