Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AB4C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLHF-00082w-Sn; Tue, 03 Jun 2025 02:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGa-0007jV-To
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGY-0003RR-Gi
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ip/X/jpkSPz0/SkFjgZHiyCVKteQl5DLHoP96z9zlgQ=;
 b=Vy55HrLGZiBqr7GnrJdGc8A+AZWLL6hZASmXIC0pq6FEi0Cmd/r2+97Nn+Dnd/PcIxTO+m
 rWMij3ZpprmDj8aISHY+FBrmaBjjTXA5XX1OZRA0vEgIZ/kzN9IOeocsgVotfTP5xAeVjY
 uNm0Iwov5GAa1+E5IzbW4U0B5aYeIUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-tdXC6B_hMi-0YLZFdwb9EQ-1; Tue,
 03 Jun 2025 02:36:51 -0400
X-MC-Unique: tdXC6B_hMi-0YLZFdwb9EQ-1
X-Mimecast-MFC-AGG-ID: tdXC6B_hMi-0YLZFdwb9EQ_1748932611
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE3E318003FC
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA56018018B4
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1ABEA21E65FE; Tue, 03 Jun 2025 08:36:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 12/13] qapi: Tidy up references to job state CONCLUDED
Date: Tue,  3 Jun 2025 08:36:43 +0200
Message-ID: <20250603063644.3953528-13-armbru@redhat.com>
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

When talking about the job state machine, we refer to the states like
READY, ABORTING, CONCLUDED, and so forth.  Except in two places, where
we use JOB_STATUS_CONCLUDED.  Replace by CONCLUDED for consistency.

We should arguably use the JobStatus enum values instead.  Left for
another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-13-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 6 +++---
 qapi/job.json        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ad6de151c8..da390f85ac 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3074,9 +3074,9 @@
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
-# reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
-# make use of the BLOCK_JOB_READY event, job-cancel, block-job-cancel
-# or job-complete will still need to be used as appropriate.
+# reached its terminal state, CONCLUDED.  For jobs that make use of
+# the BLOCK_JOB_READY event, job-cancel, block-job-cancel or
+# job-complete will still need to be used as appropriate.
 #
 # @id: The job identifier.
 #
diff --git a/qapi/job.json b/qapi/job.json
index 9ddba537db..441cd7772b 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -223,9 +223,9 @@
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
-# reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
-# make use of JOB_READY event, job-cancel or job-complete will still
-# need to be used as appropriate.
+# reached its terminal state, CONCLUDED.  For jobs that make use of
+# the JOB_READY event, job-cancel or job-complete will still need to
+# be used as appropriate.
 #
 # @id: The job identifier.
 #
-- 
2.48.1


