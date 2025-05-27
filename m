Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A9EC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouq-0004KL-3m; Tue, 27 May 2025 03:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouo-0004IG-RB
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007rT-Jd
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGOsfpsk52O3wqXAESwuXuJAkLAyRIx13EMBIFUWd/o=;
 b=JZBOu9MllTgLXLnARVbsjfeFT4aATH2Yd4k2Bag9u0cUHJufGYmI4bwy8l6XmPkF6ljTCP
 nsx9giBpFbyFHEhXYynz3yN+xIFa/QXtGaDC0dv47HcA0GdPev9ZuSzX/gmv+qpqIyaEIv
 XoYTUfMMzaRQuvO8TRNO31bO5ZPFXjs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-ANsZygg2Pl6Vjd3VSJZyFQ-1; Tue,
 27 May 2025 03:39:23 -0400
X-MC-Unique: ANsZygg2Pl6Vjd3VSJZyFQ-1
X-Mimecast-MFC-AGG-ID: ANsZygg2Pl6Vjd3VSJZyFQ_1748331563
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0CD019560AD; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97A0518004A7; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4CC1921E65FD; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 11/13] qapi: Mention both job-cancel and block-job-cancel in
 doc comments
Date: Tue, 27 May 2025 09:39:14 +0200
Message-ID: <20250527073916.1243024-12-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Several doc comments mention block-job-cancel where the more generic
job-cancel would also work.  Adjust them to mention both.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6e5b90d5df..ad6de151c8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1894,7 +1894,7 @@
 # The status of ongoing drive-backup operations can be checked with
 # query-block-jobs where the BlockJobInfo.type field has the value
 # 'backup'.  The operation can be stopped before it has completed
-# using the block-job-cancel command.
+# using the job-cancel or block-job-cancel command.
 #
 # Features:
 #
@@ -1925,7 +1925,7 @@
 # The status of ongoing blockdev-backup operations can be checked with
 # query-block-jobs where the BlockJobInfo.type field has the value
 # 'backup'.  The operation can be stopped before it has completed
-# using the block-job-cancel command.
+# using the job-cancel or block-job-cancel command.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2788,7 +2788,7 @@
 # immediately once streaming has started.  The status of ongoing block
 # streaming operations can be checked with query-block-jobs.  The
 # operation can be stopped before it has completed using the
-# block-job-cancel command.
+# job-cancel or block-job-cancel command.
 #
 # The node that receives the data is called the top image, can be
 # located in any part of the chain (but always above the base image;
@@ -3075,8 +3075,8 @@
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
-# make use of the BLOCK_JOB_READY event, block-job-cancel or
-# job-complete will still need to be used as appropriate.
+# make use of the BLOCK_JOB_READY event, job-cancel, block-job-cancel
+# or job-complete will still need to be used as appropriate.
 #
 # @id: The job identifier.
 #
-- 
2.48.1


