Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A77C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Dc2-0002LL-1A; Thu, 03 Sep 2026 16:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2Dc0-0002Kd-LB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2Dbz-0002RR-2P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788465638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Et2pI9Cw4cqy4tpgAKfzyVHhuXMNzXx4qYUPgtBY1xk=;
 b=g84TTQAm2aZ5OdPGoeXDBFMrBciOWzEISigubs19QVaZtwluAHvGNRyvDLhTX3u5QhkKc8
 mAJ7e+cECSIiK4qI1iC8SoJzWD5mQBd0C+ZMJXg2arw3eI/D8kcHaQZKWsWJu8999x7tQO
 Bpoz3JB//9U3IAEjlKipL20/Dosf6qw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-e-N3vHiOOfSs9DdGcv96MA-1; Thu,
 03 Sep 2026 16:00:34 -0400
X-MC-Unique: e-N3vHiOOfSs9DdGcv96MA-1
X-Mimecast-MFC-AGG-ID: e-N3vHiOOfSs9DdGcv96MA_1788465632
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 378EA18C0FB4; Thu,  3 Sep 2026 20:00:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.104])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BEAD1955F70; Thu,  3 Sep 2026 20:00:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 5/5] qapi: convert simple event intros for block-core.json
Date: Thu,  3 Sep 2026 16:00:08 -0400
Message-ID: <20260903200008.729791-6-jsnow@redhat.com>
In-Reply-To: <20260903200008.729791-1-jsnow@redhat.com>
References: <20260903200008.729791-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 29f011dc209..84ef21736b8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5555,11 +5555,10 @@
 
 ##
 # @BLOCK_IMAGE_CORRUPTED:
-#
-# Emitted when a disk image is being marked corrupt.  The image can be
-# identified by its device or node name.  The 'device' field is always
-# present for compatibility reasons, but it can be empty ("") if the
-# image does not have a device name associated.
+#     Emitted when a disk image is being marked corrupt.  The image
+#     can be identified by its device or node name.  The 'device'
+#     field is always present for compatibility reasons, but it can be
+#     empty ("") if the image does not have a device name associated.
 #
 # @device: device name.  This is always present for compatibility
 #     reasons, but it can be empty ("") if the image does not have a
@@ -5788,11 +5787,10 @@
 
 ##
 # @BLOCK_JOB_PENDING:
-#
-# Emitted when a block job is awaiting explicit authorization to
-# finalize graph changes via `job-finalize`.  If this job is part of a
-# transaction, it will not emit this event until the transaction has
-# converged first.
+#     Emitted when a block job is awaiting explicit authorization to
+#     finalize graph changes via `job-finalize`.  If this job is part
+#     of a transaction, it will not emit this event until the
+#     transaction has converged first.
 #
 # @type: job type
 #
@@ -5833,12 +5831,12 @@
 
 ##
 # @BLOCK_WRITE_THRESHOLD:
-#
-# Emitted when writes on block device reaches or exceeds the
-# configured write threshold.  For thin-provisioned devices, this
-# means the device should be extended to avoid pausing for disk
-# exhaustion.  The event is one shot.  Once triggered, it needs to be
-# re-registered with another `block-set-write-threshold` command.
+#     Emitted when writes on block device reaches or exceeds the
+#     configured write threshold.  For thin-provisioned devices, this
+#     means the device should be extended to avoid pausing for disk
+#     exhaustion.  The event is one shot.  Once triggered, it needs to
+#     be re-registered with another `block-set-write-threshold`
+#     command.
 #
 # @node-name: graph node name on which the threshold was exceeded.
 #
-- 
2.55.0


