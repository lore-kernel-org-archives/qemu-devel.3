Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E23CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGzW-0003hM-MZ; Mon, 28 Sep 2026 15:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzV-0003gd-I5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzR-00034r-Of
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790623576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Bt5lvrabIlQttuRio2irsHxiwwhHuF2bRLN/Ps/4K0=;
 b=iLgwGIlWx48O5yCamTUiHn0yvhmEmRb6QT9JdA1bCQIxaravce9W9FAHS7TKcTbfFxiA9q
 ZIav4iJwI+5gI09WLf9OcYrCEKDy9LTE492juABEp2lQhDt+SlYUQb2+SJW9bSU1TY5ipw
 0Bdufe/QE9QcAivBtRhu+403Me6qw6I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-asUwt7WlPC2eoLXa9SXY4A-1; Mon,
 28 Sep 2026 15:26:11 -0400
X-MC-Unique: asUwt7WlPC2eoLXa9SXY4A-1
X-Mimecast-MFC-AGG-ID: asUwt7WlPC2eoLXa9SXY4A_1790623570
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F1D3180A206; Mon, 28 Sep 2026 19:26:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D28C95BC; Mon, 28 Sep 2026 19:26:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 02/10] qapi: convert/split intros for block-core.json
 commands
Date: Mon, 28 Sep 2026 15:25:49 -0400
Message-ID: <20260928192557.509157-3-jsnow@redhat.com>
In-Reply-To: <20260928192557.509157-1-jsnow@redhat.com>
References: <20260928192557.509157-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert, or split off, intro sections for commands defined in
block-core.json. In general, this does not currently impact the way
these commands are rendered, except:

1. blockdev-reopen sees its arguments shit up to just below the
   formalized introductory section.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 126 +++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 71 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 802a4af74ed..13981d7e69d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1556,8 +1556,7 @@
 
 ##
 # @block_resize:
-#
-# Resize a block image while a guest is running.
+#     Resize a block image while a guest is running.
 #
 # Either @device or @node-name must be set but not both.
 #
@@ -1812,13 +1811,12 @@
 
 ##
 # @blockdev-snapshot:
+#     Takes a snapshot of a block device.
 #
-# Takes a snapshot of a block device.
-#
-# Take a snapshot, by installing 'node' as the backing image of
-# 'overlay'.  Additionally, if 'node' is associated with a block
-# device, the block device changes to using 'overlay' as its new
-# active image.
+#     Take a snapshot, by installing 'node' as the backing image of
+#     'overlay'.  Additionally, if 'node' is associated with a block
+#     device, the block device changes to using 'overlay' as its new
+#     active image.
 #
 # Features:
 #
@@ -1883,9 +1881,8 @@
 
 ##
 # @block-commit:
-#
-# Live commit of data from overlay image nodes into backing nodes -
-# i.e., writes data between 'top' and 'base' into 'base'.
+#     Live commit of data from overlay image nodes into backing nodes
+#     - i.e., writes data between 'top' and 'base' into 'base'.
 #
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
@@ -2510,16 +2507,15 @@
 
 ##
 # @block-dirty-bitmap-merge:
+#     Merge dirty bitmaps listed in @bitmaps to the @target dirty
+#     bitmap.  Dirty bitmaps in @bitmaps will be unchanged, except if
+#     it also appears as the @target bitmap.  Any bits already set in
+#     @target will still be set after the merge, i.e., this operation
+#     does not clear the target.  On error, @target is unchanged.
 #
-# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
-# Dirty bitmaps in @bitmaps will be unchanged, except if it also
-# appears as the @target bitmap.  Any bits already set in @target will
-# still be set after the merge, i.e., this operation does not clear
-# the target.  On error, @target is unchanged.
-#
-# The resulting bitmap will count as dirty any clusters that were
-# dirty in any of the source bitmaps.  This can be used to achieve
-# backup checkpoints, or in simpler usages, to copy bitmaps.
+#     The resulting bitmap will count as dirty any clusters that were
+#     dirty in any of the source bitmaps.  This can be used to achieve
+#     backup checkpoints, or in simpler usages, to copy bitmaps.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2865,8 +2861,7 @@
 
 ##
 # @block-stream:
-#
-# Copy data from a backing file into a block device.
+#     Copy data from a backing file into a block device.
 #
 # The block streaming operation is performed in the background until
 # the entire backing file has been copied.  This command returns
@@ -2977,8 +2972,7 @@
 
 ##
 # @block-job-set-speed:
-#
-# Set maximum speed for a background block operation.
+#     Set maximum speed for a background block operation.
 #
 # This command can only be issued when there is an active block job.
 #
@@ -3003,8 +2997,7 @@
 
 ##
 # @block-job-cancel:
-#
-# Stop an active background block operation.
+#     Stop an active background block operation.
 #
 # This command returns immediately after marking the active background
 # block operation for cancellation.  It is an error to call this
@@ -3046,8 +3039,7 @@
 
 ##
 # @block-job-pause:
-#
-# Pause an active background block operation.
+#     Pause an active background block operation.
 #
 # This command returns immediately after marking the active job for
 # pausing.  Pausing an already paused job is an error.
@@ -3079,8 +3071,7 @@
 
 ##
 # @block-job-resume:
-#
-# Resume an active background block operation.
+#     Resume an active background block operation.
 #
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
@@ -3108,9 +3099,9 @@
 
 ##
 # @block-job-complete:
-#
-# Manually trigger completion of an active job in the READY or STANDBY
-# state.  Completing the job in any other state is an error.
+#     Manually trigger completion of an active job in the READY or
+#     STANDBY state.  Completing the job in any other state is an
+#     error.
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
@@ -3148,14 +3139,13 @@
 
 ##
 # @block-job-dismiss:
-#
-# Deletes a job that is in the CONCLUDED state.  This command only
-# needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.  In turn, automatic dismiss may be enabled only for
-# jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
-# and `block-stream`.  @auto-dismiss is enabled by default for these
-# jobs.
+#     Deletes a job that is in the CONCLUDED state.  This command only
+#     needs to be run explicitly for jobs that don't have automatic
+#     dismiss enabled.  In turn, automatic dismiss may be enabled only
+#     for jobs that have @auto-dismiss option, which are
+#     `drive-backup`, `blockdev-backup`, `drive-mirror`,
+#     `blockdev-mirror`, `block-commit` and `block-stream`.
+#     @auto-dismiss is enabled by default for these jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
@@ -3177,11 +3167,10 @@
 
 ##
 # @block-job-finalize:
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
@@ -4917,14 +4906,13 @@
 
 ##
 # @blockdev-reopen:
-#
-# Reopens one or more block devices using the given set of options.
-# Any option not specified will be reset to its default value
-# regardless of its previous status.  If an option cannot be changed
-# or a particular driver does not support reopening then the command
-# will return an error.  All devices in the list are reopened in one
-# transaction, so if one of them fails then the whole transaction is
-# cancelled.
+#     Reopens one or more block devices using the given set of
+#     options.  Any option not specified will be reset to its default
+#     value regardless of its previous status.  If an option cannot be
+#     changed or a particular driver does not support reopening then
+#     the command will return an error.  All devices in the list are
+#     reopened in one transaction, so if one of them fails then the
+#     whole transaction is cancelled.
 #
 # The command receives a list of block devices to reopen.  For each
 # one of them, the top-level @node-name option (from
@@ -4996,9 +4984,8 @@
 
 ##
 # @blockdev-set-active:
-#
-# Activate or deactivate a block device.  Use this to manage the
-# handover of block devices on migration with qemu-storage-daemon.
+#     Activate or deactivate a block device.  Use this to manage the
+#     handover of block devices on migration with qemu-storage-daemon.
 #
 # Activating a node automatically activates all of its child nodes
 # first.  Deactivating a node automatically deactivates any of its
@@ -5881,15 +5868,14 @@
 
 ##
 # @block-set-write-threshold:
+#     Change the write threshold for a block drive.  An event will be
+#     delivered if a write to this block drive crosses the configured
+#     threshold.  The threshold is an offset, thus must be
+#     non-negative.  Default is no write threshold.  Setting the
+#     threshold to zero disables it.
 #
-# Change the write threshold for a block drive.  An event will be
-# delivered if a write to this block drive crosses the configured
-# threshold.  The threshold is an offset, thus must be non-negative.
-# Default is no write threshold.  Setting the threshold to zero
-# disables it.
-#
-# This is useful to transparently resize thin-provisioned drives
-# without the guest OS noticing.
+#     This is useful to transparently resize thin-provisioned drives
+#     without the guest OS noticing.
 #
 # @node-name: graph node name on which the threshold must be set.
 #
@@ -5911,8 +5897,7 @@
 
 ##
 # @x-blockdev-change:
-#
-# Dynamically reconfigure the block driver state graph.
+#     Dynamically reconfigure the block driver state graph.
 #
 # Currently only supports adding and deleting quorum children.  A
 # child will be added at the end of the list of children.  Its
@@ -5971,11 +5956,10 @@
 
 ##
 # @x-blockdev-set-iothread:
+#     Move @node and its children into the @iothread.  If @iothread is
+#     null then move @node and its children into the main loop.
 #
-# Move @node and its children into the @iothread.  If @iothread is
-# null then move @node and its children into the main loop.
-#
-# The node must not be attached to a BlockBackend.
+#     The node must not be attached to a BlockBackend.
 #
 # @node-name: the name of the block driver node
 #
-- 
2.55.0


