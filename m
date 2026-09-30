Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC6CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrjs-00033M-Cv; Wed, 30 Sep 2026 06:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBris-0001S9-60
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrii-0006mj-F0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oUF2eB96Si0y+4x5lMq3nLYPnGDB4LsQc1DhCN/OeE=;
 b=Y0faP4sWmsSsW/xr+/8TYWYo0/7MobafIRz92t8p9bRvDIT39VClbSb54B9v1+YJSXl/lW
 ciTQ0GzdTISdzkUByFRwp3YhH/PnMCvqyT6ruiF6eXnvQfL+IUeymKix4Z6BeEmdg26LJr
 ZfQBcEF1Jntk7g3IqPEdnc4wy1c/YcY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-slQTzaLqON-54fg_VSESGw-1; Wed,
 30 Sep 2026 06:39:25 -0400
X-MC-Unique: slQTzaLqON-54fg_VSESGw-1
X-Mimecast-MFC-AGG-ID: slQTzaLqON-54fg_VSESGw_1790764765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6F8D1953977; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66A811800576; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7795121E66FA; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 055/105] qapi: convert simple command intros for block-core.json
Date: Wed, 30 Sep 2026 12:38:20 +0200
Message-ID: <20260930103910.3934848-56-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260901194324.458482-13-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 96 +++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index a583bcc05c..5c6a882a24 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1856,12 +1856,12 @@
 
 ##
 # @change-backing-file:
-#
-# Change the backing file in the image file metadata.  This does not
-# cause QEMU to reopen the image file to reparse the backing filename
-# (it may, however, perform a reopen to change permissions from r/o ->
-# r/w -> r/o, if needed).  The new backing file string is written into
-# the image file metadata, and the QEMU internal strings are updated.
+#     Change the backing file in the image file metadata.  This does
+#     not cause QEMU to reopen the image file to reparse the backing
+#     filename (it may, however, perform a reopen to change
+#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
+#     file string is written into the image file metadata, and the
+#     QEMU internal strings are updated.
 #
 # @image-node-name: The name of the block driver state node of the
 #     image to modify.  The "device" argument is used to verify
@@ -1997,12 +1997,12 @@
 
 ##
 # @drive-backup:
-#
-# Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing `drive-backup` operations can be checked with
-# `query-block-jobs` where the `BlockJobInfo`.type field has the value
-# 'backup'.  The operation can be stopped before it has completed
-# using the `job-cancel` or `block-job-cancel` command.
+#     Start a point-in-time copy of a block device to a new
+#     destination.  The status of ongoing `drive-backup` operations
+#     can be checked with `query-block-jobs` where the
+#     `BlockJobInfo`.type field has the value 'backup'.  The operation
+#     can be stopped before it has completed using the `job-cancel` or
+#     `block-job-cancel` command.
 #
 # Features:
 #
@@ -2028,12 +2028,12 @@
 
 ##
 # @blockdev-backup:
-#
-# Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing `blockdev-backup` operations can be checked
-# with `query-block-jobs` where the `BlockJobInfo`.type field has the
-# value 'backup'.  The operation can be stopped before it has
-# completed using the `job-cancel` or `block-job-cancel` command.
+#     Start a point-in-time copy of a block device to a new
+#     destination.  The status of ongoing `blockdev-backup` operations
+#     can be checked with `query-block-jobs` where the
+#     `BlockJobInfo`.type field has the value 'backup'.  The operation
+#     can be stopped before it has completed using the `job-cancel` or
+#     `block-job-cancel` command.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2225,13 +2225,13 @@
 
 ##
 # @drive-mirror:
-#
-# Start mirroring a block device's writes to a new destination.
-# target specifies the target of the new image.  If the file exists,
-# or if it is a device, it will be used as the new destination for
-# writes.  If it does not exist, a new file will be created.  @format
-# specifies the format of the mirror image, default is to probe if
-# mode='existing', else the format of the source.
+#     Start mirroring a block device's writes to a new destination.
+#     target specifies the target of the new image.  If the file
+#     exists, or if it is a device, it will be used as the new
+#     destination for writes.  If it does not exist, a new file will
+#     be created.  @format specifies the format of the mirror image,
+#     default is to probe if mode='existing', else the format of the
+#     source.
 #
 # Errors:
 #     - If @device is not a valid block device, GenericError
@@ -2427,10 +2427,9 @@
 
 ##
 # @block-dirty-bitmap-remove:
-#
-# Stop write tracking and remove the dirty bitmap that was created
-# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove
-# it from its storage too.
+#     Stop write tracking and remove the dirty bitmap that was created
+#     with `block-dirty-bitmap-add`.  If the bitmap is persistent,
+#     remove it from its storage too.
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
@@ -4977,10 +4976,9 @@
 
 ##
 # @blockdev-del:
-#
-# Deletes a block device that has been added using `blockdev-add`.
-# The command will fail if the node is attached to a device or is
-# otherwise being used.
+#     Deletes a block device that has been added using `blockdev-add`.
+#     The command will fail if the node is attached to a device or is
+#     otherwise being used.
 #
 # @node-name: Name of the graph node to delete.
 #
@@ -5493,9 +5491,9 @@
 
 ##
 # @blockdev-create:
-#
-# Starts a job to create an image format on a given node.  The job is
-# automatically finalized, but a manual `job-dismiss` is required.
+#     Starts a job to create an image format on a given node.  The job
+#     is automatically finalized, but a manual `job-dismiss` is
+#     required.
 #
 # @job-id: Identifier for the newly created job.
 #
@@ -5550,10 +5548,9 @@
 
 ##
 # @x-blockdev-amend:
-#
-# Starts a job to amend format specific options of an existing open
-# block device.  The job is automatically finalized, but a manual
-# `job-dismiss` is required.
+#     Starts a job to amend format specific options of an existing
+#     open block device.  The job is automatically finalized, but a
+#     manual `job-dismiss` is required.
 #
 # @job-id: Identifier for the newly created job.
 #
@@ -6127,11 +6124,10 @@
 
 ##
 # @blockdev-snapshot-internal-sync:
-#
-# Synchronously take an internal snapshot of a block device, when the
-# format of the image used supports it.  If the name is an empty
-# string, or a snapshot with name already exists, the operation will
-# fail.
+#     Synchronously take an internal snapshot of a block device, when
+#     the format of the image used supports it.  If the name is an
+#     empty string, or a snapshot with name already exists, the
+#     operation will fail.
 #
 # Errors:
 #     - If @device is not a valid block device, GenericError
@@ -6159,11 +6155,11 @@
 
 ##
 # @blockdev-snapshot-delete-internal-sync:
-#
-# Synchronously delete an internal snapshot of a block device, when
-# the format of the image used support it.  The snapshot is identified
-# by name or id or both.  One of the name or id is required.  Return
-# `SnapshotInfo` for the successfully deleted snapshot.
+#     Synchronously delete an internal snapshot of a block device,
+#     when the format of the image used support it.  The snapshot is
+#     identified by name or id or both.  One of the name or id is
+#     required.  Return `SnapshotInfo` for the successfully deleted
+#     snapshot.
 #
 # @device: the device name or node-name of a root node to delete the
 #     snapshot from
-- 
2.55.0


