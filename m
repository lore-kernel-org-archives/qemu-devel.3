Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2A9C7114A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 20:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQB9A-0002Dj-Da; Fri, 13 Jun 2025 16:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB95-0002DE-W6
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB92-00051X-3s
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749847018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFx5mdoaQVewcY87O8r8otKteq+zI/GxEYc824j3XDo=;
 b=Bo60bjA9GWTQZevVJlz341a/5zBcFRDYcaa6S6728WgfylkrnwzNbfl60ntMPCCVG6feXK
 R2NDoUxJ1TKG8ePbkyyFv5rH1X30d0smhAMAl4R4FeKsgYR38q6CxgAzQCrlQwJ0r120XT
 P9NOG4vTShN8NEba6auEAanJ0wNb3gI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-kOUu_dinMtGY_iBqrE1huw-1; Fri,
 13 Jun 2025 16:36:55 -0400
X-MC-Unique: kOUu_dinMtGY_iBqrE1huw-1
X-Mimecast-MFC-AGG-ID: kOUu_dinMtGY_iBqrE1huw_1749847013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42295195608B; Fri, 13 Jun 2025 20:36:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.203])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EE2F30044CC; Fri, 13 Jun 2025 20:36:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 03/18] qapi: add cross-references to block layer
Date: Fri, 13 Jun 2025 16:36:05 -0400
Message-ID: <20250613203620.1283814-4-jsnow@redhat.com>
In-Reply-To: <20250613203620.1283814-1-jsnow@redhat.com>
References: <20250613203620.1283814-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json   | 186 ++++++++++++++++++++---------------------
 qapi/block-export.json |  36 ++++----
 qapi/block.json        |  14 ++--
 qapi/transaction.json  |  20 ++---
 4 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f18db3149a3..74e6a81a5e9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -31,7 +31,7 @@
 # @icount: Current instruction count.  Appears when execution
 #     record/replay is enabled.  Used for "time-traveling" to match
 #     the moment in the recorded execution with the snapshots.  This
-#     counter may be obtained through @query-replay command
+#     counter may be obtained through `query-replay` command
 #     (since 5.2)
 #
 # Since: 1.3
@@ -223,7 +223,7 @@
 { 'struct': 'ImageInfoSpecificLUKSWrapper',
   'data': { 'data': 'QCryptoBlockInfoLUKS' } }
 # If we need to add block driver specific parameters for
-# LUKS in future, then we'll subclass QCryptoBlockInfoLUKS
+# LUKS in future, then we'll subclass `QCryptoBlockInfoLUKS`
 # to define a ImageInfoSpecificLUKS
 
 ##
@@ -332,7 +332,7 @@
 # node, annotated with information about that node in relation to its
 # parent.
 #
-# @name: Child name of the root node in the BlockGraphInfo struct, in
+# @name: Child name of the root node in the `BlockGraphInfo` struct, in
 #     its role as the child of some undescribed parent node
 #
 # @info: Block graph information starting at this node
@@ -349,7 +349,7 @@
 # @BlockGraphInfo:
 #
 # Information about all nodes in a block (sub)graph in the form of
-# BlockNodeInfo data.  The base BlockNodeInfo struct contains the
+# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
 # information for the (sub)graph's root node.
 #
 # @children: Array of links to this node's child nodes' information
@@ -614,7 +614,7 @@
 # @inconsistent: true if this is a persistent bitmap that was
 #     improperly stored.  Implies @persistent to be true; @recording
 #     and @busy to be false.  This bitmap cannot be used.  To remove
-#     it, use @block-dirty-bitmap-remove.  (Since 4.0)
+#     it, use `block-dirty-bitmap-remove`.  (Since 4.0)
 #
 # Since: 1.3
 ##
@@ -709,12 +709,12 @@
 # @tray_open: True if the device's tray is open (only present if it
 #     has a tray)
 #
-# @io-status: @BlockDeviceIoStatus.  Only present if the device
+# @io-status: `BlockDeviceIoStatus`.  Only present if the device
 #     supports it and the VM is configured to stop on errors
 #     (supported device models: virtio-blk, IDE, SCSI except
 #     scsi-generic)
 #
-# @inserted: @BlockDeviceInfo describing the device if media is
+# @inserted: `BlockDeviceInfo` describing the device if media is
 #     present
 #
 # Since: 0.14
@@ -761,7 +761,7 @@
 ##
 # @query-block:
 #
-# Get a list of BlockInfo for all virtual block devices.
+# Get a list of `BlockInfo` for all virtual block devices.
 #
 # Returns: a list describing each virtual block device.
 #     Filter nodes that were created implicitly are skipped over.
@@ -1026,14 +1026,14 @@
 # @timed_stats: Statistics specific to the set of previously defined
 #     intervals of time (Since 2.5)
 #
-# @rd_latency_histogram: @BlockLatencyHistogramInfo.  (Since 4.0)
+# @rd_latency_histogram: `BlockLatencyHistogramInfo`.  (Since 4.0)
 #
-# @wr_latency_histogram: @BlockLatencyHistogramInfo.  (Since 4.0)
+# @wr_latency_histogram: `BlockLatencyHistogramInfo`.  (Since 4.0)
 #
-# @zone_append_latency_histogram: @BlockLatencyHistogramInfo.
+# @zone_append_latency_histogram: `BlockLatencyHistogramInfo`.
 #     (since 8.1)
 #
-# @flush_latency_histogram: @BlockLatencyHistogramInfo.  (Since 4.0)
+# @flush_latency_histogram: `BlockLatencyHistogramInfo`.  (Since 4.0)
 #
 # Since: 0.14
 ##
@@ -1134,7 +1134,7 @@
 # @qdev: The qdev ID, or if no ID is assigned, the QOM path of the
 #     block device.  (since 3.0)
 #
-# @stats: A @BlockDeviceStats for the device.
+# @stats: A `BlockDeviceStats` for the device.
 #
 # @driver-specific: Optional driver-specific stats.  (Since 4.2)
 #
@@ -1158,7 +1158,7 @@
 ##
 # @query-blockstats:
 #
-# Query the @BlockStats for all virtual block devices.
+# Query the `BlockStats` for all virtual block devices.
 #
 # @query-nodes: If true, the command will query all the block nodes
 #     that have a node name, in a list which will include "parent"
@@ -1289,8 +1289,8 @@
 # @report: for guest operations, report the error to the guest; for
 #     jobs, cancel the job
 #
-# @ignore: ignore the error, only report a QMP event (BLOCK_IO_ERROR
-#     or BLOCK_JOB_ERROR).  The backup, mirror and commit block jobs
+# @ignore: ignore the error, only report a QMP event (`BLOCK_IO_ERROR`
+#     or `BLOCK_JOB_ERROR`).  The backup, mirror and commit block jobs
 #     retry the failing request later and may still complete
 #     successfully.  The stream block job continues to stream and will
 #     complete with an error.
@@ -1323,7 +1323,7 @@
 #     (since: 2.4)
 #
 # @bitmap: only copy data described by the dirty bitmap.  Behavior on
-#     completion is determined by the BitmapSyncMode.  (since: 4.2)
+#     completion is determined by the `BitmapSyncMode`.  (since: 4.2)
 #
 # Since: 1.3
 ##
@@ -1530,7 +1530,7 @@
 # @overlay: reference to the existing block device that will become
 #     the overlay of @node, as part of taking the snapshot.  It must
 #     not have a current backing file (this can be achieved by passing
-#     "backing": null to blockdev-add).
+#     "backing": null to `blockdev-add`).
 #
 # Since: 2.5
 ##
@@ -1585,7 +1585,7 @@
 # @bitmap: The name of a dirty bitmap to use.  Must be present if sync
 #     is "bitmap" or "incremental".  Can be present if sync is "full"
 #     or "top".  Must not be present otherwise.
-#     (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
+#     (Since 2.4 (`drive-backup`), 3.1 (`blockdev-backup`))
 #
 # @bitmap-mode: Specifies the type of data the bitmap should contain
 #     after the operation concludes.  Must be present if a bitmap was
@@ -1596,7 +1596,7 @@
 #
 # @on-source-error: the action to take on an error on the source,
 #     default 'report'.  'stop' and 'enospc' can only be used if the
-#     block device supports io-status (see BlockInfo).
+#     block device supports io-status (see `BlockInfo`).
 #
 # @on-target-error: the action to take on an error on the target,
 #     default 'report' (no limitations, since this applies to a
@@ -1606,14 +1606,14 @@
 #     copy-before-write jobs; defaults to break-guest-write.  (Since 10.1)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @job-finalize before
+#     after it has finished its work, waiting for `job-finalize` before
 #     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 2.12)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @job-dismiss.  When true, this job will automatically disappear
+#     `job-dismiss`.  When true, this job will automatically disappear
 #     without user intervention.  Defaults to true.  (Since 2.12)
 #
 # @filter-node-name: the node name that should be assigned to the
@@ -1719,7 +1719,7 @@
 #
 # @allow-write-only-overlay: If present, the check whether this
 #     operation is safe was relaxed so that it can be used to change
-#     backing file of a destination of a blockdev-mirror.  (since 5.0)
+#     backing file of a destination of a `blockdev-mirror`.  (since 5.0)
 #
 # Since: 2.5
 #
@@ -1784,7 +1784,7 @@
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
 # itself.  The user needs to complete the job with the
-# job-complete command after getting the ready event.  (Since 2.0)
+# `job-complete` command after getting the ready event.  (Since 2.0)
 #
 # If the base image is smaller than top, then the base image will be
 # resized to be the same size as top.  If top is smaller than the base
@@ -1846,14 +1846,14 @@
 #     autogenerated.  (Since: 2.9)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @job-finalize before
+#     after it has finished its work, waiting for `job-finalize` before
 #     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @job-dismiss.  When true, this job will automatically disappear
+#     `job-dismiss`.  When true, this job will automatically disappear
 #     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # Features:
@@ -1889,14 +1889,14 @@
 # @drive-backup:
 #
 # Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing drive-backup operations can be checked with
-# query-block-jobs where the BlockJobInfo.type field has the value
+# The status of ongoing `drive-backup` operations can be checked with
+# `query-block-jobs` where the `BlockJobInfo`.type field has the value
 # 'backup'.  The operation can be stopped before it has completed
-# using the job-cancel or block-job-cancel command.
+# using the `job-cancel` or `block-job-cancel` command.
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @blockdev-backup
+# @deprecated: This command is deprecated.  Use `blockdev-backup`
 #     instead.
 #
 # Errors:
@@ -1920,10 +1920,10 @@
 # @blockdev-backup:
 #
 # Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing blockdev-backup operations can be checked with
-# query-block-jobs where the BlockJobInfo.type field has the value
+# The status of ongoing `blockdev-backup` operations can be checked with
+# `query-block-jobs` where the `BlockJobInfo`.type field has the value
 # 'backup'.  The operation can be stopped before it has completed
-# using the job-cancel or block-job-cancel command.
+# using the `job-cancel` or `block-job-cancel` command.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2024,7 +2024,7 @@
 # @XDbgBlockGraphNode:
 #
 # @id: Block graph node identifier.  This @id is generated only for
-#     x-debug-query-block-graph and does not relate to any other
+#     `x-debug-query-block-graph` and does not relate to any other
 #     identifiers in QEMU.
 #
 # @type: Type of graph node.  Can be one of block-backend, block-job
@@ -2073,7 +2073,7 @@
 ##
 # @XDbgBlockGraphEdge:
 #
-# Block Graph edge description for x-debug-query-block-graph.
+# Block Graph edge description for `x-debug-query-block-graph`.
 #
 # @parent: parent id
 #
@@ -2191,7 +2191,7 @@
 #
 # @on-source-error: the action to take on an error on the source,
 #     default 'report'.  'stop' and 'enospc' can only be used if the
-#     block device supports io-status (see BlockInfo).
+#     block device supports io-status (see `BlockInfo`).
 #
 # @on-target-error: the action to take on an error on the target,
 #     default 'report' (no limitations, since this applies to a
@@ -2207,14 +2207,14 @@
 #     'background' (Since: 3.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @job-finalize before
+#     after it has finished its work, waiting for `job-finalize` before
 #     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @job-dismiss.  When true, this job will automatically disappear
+#     `job-dismiss`.  When true, this job will automatically disappear
 #     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # Since: 1.3
@@ -2249,16 +2249,16 @@
 # @name: name of the dirty bitmap (must be less than 1024 bytes)
 #
 # @granularity: the bitmap granularity, default is 64k for
-#     block-dirty-bitmap-add
+#     `block-dirty-bitmap-add`
 #
 # @persistent: the bitmap is persistent, i.e. it will be saved to the
 #     corresponding block device image file on its close.  For now
 #     only Qcow2 disks support persistent bitmaps.  Default is false
-#     for block-dirty-bitmap-add.  (Since: 2.10)
+#     for `block-dirty-bitmap-add`.  (Since: 2.10)
 #
 # @disabled: the bitmap is created in the disabled state, which means
 #     that it will not track drive changes.  The bitmap may be enabled
-#     with block-dirty-bitmap-enable.  Default is false.  (Since: 4.0)
+#     with `block-dirty-bitmap-enable`.  Default is false.  (Since: 4.0)
 #
 # Since: 2.4
 ##
@@ -2288,7 +2288,7 @@
 # @target: name of the destination dirty bitmap
 #
 # @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or
-#     fully specified BlockDirtyBitmap elements.  The latter are
+#     fully specified `BlockDirtyBitmap` elements.  The latter are
 #     supported since 4.1.
 #
 # Since: 4.0
@@ -2323,7 +2323,7 @@
 # @block-dirty-bitmap-remove:
 #
 # Stop write tracking and remove the dirty bitmap that was created
-# with block-dirty-bitmap-add.  If the bitmap is persistent, remove it
+# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove it
 # from its storage too.
 #
 # Errors:
@@ -2507,7 +2507,7 @@
 #
 # @on-source-error: the action to take on an error on the source,
 #     default 'report'.  'stop' and 'enospc' can only be used if the
-#     block device supports io-status (see BlockInfo).
+#     block device supports io-status (see `BlockInfo`).
 #
 # @on-target-error: the action to take on an error on the target,
 #     default 'report' (no limitations, since this applies to a
@@ -2522,14 +2522,14 @@
 #     'background' (Since: 3.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @job-finalize before
+#     after it has finished its work, waiting for `job-finalize` before
 #     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @job-dismiss.  When true, this job will automatically disappear
+#     `job-dismiss`.  When true, this job will automatically disappear
 #     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # @target-is-zero: Assume the destination reads as all zeroes before
@@ -2777,9 +2777,9 @@
 # The block streaming operation is performed in the background until
 # the entire backing file has been copied.  This command returns
 # immediately once streaming has started.  The status of ongoing block
-# streaming operations can be checked with query-block-jobs.  The
+# streaming operations can be checked with `query-block-jobs`.  The
 # operation can be stopped before it has completed using the
-# job-cancel or block-job-cancel command.
+# `job-cancel` or `block-job-cancel` command.
 #
 # The node that receives the data is called the top image, can be
 # located in any part of the chain (but always above the base image;
@@ -2798,9 +2798,9 @@
 # will be the new backing file.
 #
 # On successful completion the image file is updated to drop the
-# backing file and the BLOCK_JOB_COMPLETED event is emitted.
+# backing file and the `BLOCK_JOB_COMPLETED` event is emitted.
 #
-# In case @device is a filter node, block-stream modifies the first
+# In case @device is a filter node, `block-stream` modifies the first
 # non-filter overlay node below it to point to the new backing node
 # instead of modifying @device itself.
 #
@@ -2841,7 +2841,7 @@
 #
 # @on-error: the action to take on an error (default report).  'stop'
 #     and 'enospc' can only be used if the block device supports
-#     io-status (see BlockInfo).  (Since 1.3)
+#     io-status (see `BlockInfo`).  (Since 1.3)
 #
 # @filter-node-name: the node name that should be assigned to the
 #     filter driver that the stream job inserts into the graph above
@@ -2849,14 +2849,14 @@
 #     autogenerated.  (Since: 6.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @job-finalize before
+#     after it has finished its work, waiting for `job-finalize` before
 #     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @job-dismiss.  When true, this job will automatically disappear
+#     `job-dismiss`.  When true, this job will automatically disappear
 #     without user intervention.  Defaults to true.  (Since 3.1)
 #
 # Errors:
@@ -2917,13 +2917,13 @@
 # command if no operation is in progress.
 #
 # The operation will cancel as soon as possible and then emit the
-# BLOCK_JOB_CANCELLED event.  Before that happens the job is still
-# visible when enumerated using query-block-jobs.
+# `BLOCK_JOB_CANCELLED` event.  Before that happens the job is still
+# visible when enumerated using `query-block-jobs`.
 #
 # Note that if you issue 'block-job-cancel' after 'drive-mirror' has
-# indicated (via the event BLOCK_JOB_READY) that the source and
+# indicated (via the event `BLOCK_JOB_READY`) that the source and
 # destination are synchronized, then the event triggered by this
-# command changes to BLOCK_JOB_COMPLETED, to indicate that the
+# command changes to `BLOCK_JOB_COMPLETED`, to indicate that the
 # mirroring has ended and the destination now has a point-in-time copy
 # tied to the time of the cancellation.
 #
@@ -2937,7 +2937,7 @@
 #     values.
 #
 # @force: If true, and the job has already emitted the event
-#     BLOCK_JOB_READY, abandon the job immediately (even if it is
+#     `BLOCK_JOB_READY`, abandon the job immediately (even if it is
 #     paused) instead of waiting for the destination to complete its
 #     final synchronization (since 1.3)
 #
@@ -2960,7 +2960,7 @@
 #
 # The job will pause as soon as possible, which means transitioning
 # into the PAUSED state if it was RUNNING, or into STANDBY if it was
-# READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
+# READY.  The corresponding `JOB_STATUS_CHANGE` event will be emitted.
 #
 # Cancelling a paused job automatically resumes it.
 #
@@ -2970,7 +2970,7 @@
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @job-pause
+# @deprecated: This command is deprecated.  Use `job-pause`
 #     instead.
 #
 # Errors:
@@ -2999,7 +2999,7 @@
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @job-resume
+# @deprecated: This command is deprecated.  Use `job-resume`
 #     instead.
 #
 # Errors:
@@ -3020,14 +3020,14 @@
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
@@ -3039,7 +3039,7 @@
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @job-complete
+# @deprecated: This command is deprecated.  Use `job-complete`
 #     instead.
 #
 # Errors:
@@ -3058,21 +3058,21 @@
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
-# the BLOCK_JOB_READY event, job-cancel, block-job-cancel or
-# job-complete will still need to be used as appropriate.
+# the `BLOCK_JOB_READY` event, `job-cancel`, `block-job-cancel` or
+# `job-complete` will still need to be used as appropriate.
 #
 # @id: The job identifier.
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @job-dismiss
+# @deprecated: This command is deprecated.  Use `job-dismiss`
 #     instead.
 #
 # Since: 2.12
@@ -3089,7 +3089,7 @@
 # necessary cleanup.  This command requires that all involved jobs are
 # in the PENDING state.
 #
-# For jobs in a transaction, instructing one job to finalize will
+# For jobs in a :qapi:cmd:`transaction`, instructing one job to finalize will
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
 #
@@ -3100,7 +3100,7 @@
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @job-finalize
+# @deprecated: This command is deprecated.  Use `job-finalize`
 #     instead.
 #
 # Since: 2.12
@@ -3172,7 +3172,7 @@
 # @on: Enabled
 #
 # @unmap: Enabled and even try to unmap blocks if possible.  This
-#     requires also that @BlockdevDiscardOptions is set to unmap for
+#     requires also that `BlockdevDiscardOptions` is set to unmap for
 #     this device.
 #
 # Since: 2.1
@@ -4714,7 +4714,7 @@
 # @driver: block driver name
 #
 # @node-name: the node name of the new node.  This option is required
-#     on the top level of blockdev-add.  Valid node names start with
+#     on the top level of `blockdev-add`.  Valid node names start with
 #     an alphabetic character and may contain only alphanumeric
 #     characters, '-', '.' and '_'.  Their maximum length is 31
 #     characters.  (Since 2.0)
@@ -4918,7 +4918,7 @@
 # cancelled.
 #
 # The command receives a list of block devices to reopen.  For each
-# one of them, the top-level @node-name option (from BlockdevOptions)
+# one of them, the top-level @node-name option (from `BlockdevOptions`)
 # must be specified and is used to select the block device to be
 # reopened.  Other @node-name options must be either omitted or set to
 # the current name of the appropriate node.  This command won't change
@@ -4927,7 +4927,7 @@
 # In the case of options that refer to child nodes, the behavior of
 # this command depends on the value:
 #
-#  1) A set of options (BlockdevOptions): the child is reopened with
+#  1) A set of options (`BlockdevOptions`): the child is reopened with
 #     the specified set of options.
 #
 #  2) A reference to the current child: the child is reopened using
@@ -4941,7 +4941,7 @@
 # Options (1) and (2) are supported in all cases.  Option (3) is
 # supported for @file and @backing, and option (4) for @backing only.
 #
-# Unlike with blockdev-add, the @backing option must always be present
+# Unlike with `blockdev-add`, the @backing option must always be present
 # unless the node being reopened does not have a backing file and its
 # image does not have a default backing file name as part of its
 # metadata.
@@ -4955,7 +4955,7 @@
 ##
 # @blockdev-del:
 #
-# Deletes a block device that has been added using blockdev-add.  The
+# Deletes a block device that has been added using `blockdev-add`.  The
 # command will fail if the node is attached to a device or is
 # otherwise being used.
 #
@@ -5510,7 +5510,7 @@
 # @blockdev-create:
 #
 # Starts a job to create an image format on a given node.  The job is
-# automatically finalized, but a manual job-dismiss is required.
+# automatically finalized, but a manual `job-dismiss` is required.
 #
 # @job-id: Identifier for the newly created job.
 #
@@ -5570,7 +5570,7 @@
 #
 # Starts a job to amend format specific options of an existing open
 # block device.  The job is automatically finalized, but a manual
-# job-dismiss is required.
+# `job-dismiss` is required.
 #
 # @job-id: Identifier for the newly created job.
 #
@@ -5639,10 +5639,10 @@
 #
 # @fatal: if set, the image is marked corrupt and therefore unusable
 #     after this event and must be repaired (Since 2.2; before, every
-#     BLOCK_IMAGE_CORRUPTED event was fatal)
+#     `BLOCK_IMAGE_CORRUPTED` event was fatal)
 #
-# .. note:: If action is "stop", a STOP event will eventually follow
-#    the BLOCK_IO_ERROR event.
+# .. note:: If action is "stop", a `STOP` event will eventually follow
+#    the `BLOCK_IO_ERROR` event.
 #
 # .. qmp-example::
 #
@@ -5683,15 +5683,15 @@
 #
 # @nospace: true if I/O error was caused due to a no-space condition.
 #     This key is only present if query-block's io-status is present,
-#     please see query-block documentation for more information
+#     please see `query-block` documentation for more information
 #     (since: 2.2)
 #
 # @reason: human readable string describing the error cause.  (This
 #     field is a debugging aid for humans, it should not be parsed by
 #     applications) (since: 2.2)
 #
-# .. note:: If action is "stop", a STOP event will eventually follow
-#    the BLOCK_IO_ERROR event.
+# .. note:: If action is "stop", a `STOP` event will eventually follow
+#    the `BLOCK_IO_ERROR` event.
 #
 # .. note:: This event is rate-limited.
 #
@@ -5833,7 +5833,7 @@
 # @speed: rate limit, bytes per second
 #
 # .. note:: The "ready to complete" status is always reset by a
-#    @BLOCK_JOB_ERROR event.
+#    `BLOCK_JOB_ERROR` event.
 #
 # Since: 1.3
 #
@@ -5855,8 +5855,8 @@
 # @BLOCK_JOB_PENDING:
 #
 # Emitted when a block job is awaiting explicit authorization to
-# finalize graph changes via @job-finalize.  If this job is part
-# of a transaction, it will not emit this event until the transaction
+# finalize graph changes via `job-finalize`.  If this job is part
+# of a :qapi:cmd:`transaction`, it will not emit this event until the transaction
 # has converged first.
 #
 # @type: job type
@@ -5904,7 +5904,7 @@
 # configured write threshold.  For thin-provisioned devices, this
 # means the device should be extended to avoid pausing for disk
 # exhaustion.  The event is one shot.  Once triggered, it needs to be
-# re-registered with another block-set-write-threshold command.
+# re-registered with another `block-set-write-threshold` command.
 #
 # @node-name: graph node name on which the threshold was exceeded.
 #
@@ -5975,7 +5975,7 @@
 #
 # TODO: Removing children from a quorum node means introducing
 #     gaps in the child indices.  This cannot be represented in the
-#     'children' list of BlockdevOptionsQuorum, as returned by
+#     'children' list of `BlockdevOptionsQuorum`, as returned by
 #     .bdrv_refresh_filename().
 #
 # Since: 2.7
@@ -6188,7 +6188,7 @@
 # Synchronously delete an internal snapshot of a block device, when
 # the format of the image used support it.  The snapshot is identified
 # by name or id or both.  One of the name or id is required.  Return
-# SnapshotInfo for the successfully deleted snapshot.
+# `SnapshotInfo` for the successfully deleted snapshot.
 #
 # @device: the device name or node-name of a root node to delete the
 #     snapshot from
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 3edbc5436a3..776740fe6fd 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -37,9 +37,9 @@
 ##
 # @NbdServerOptions:
 #
-# Keep this type consistent with the NbdServerOptionsLegacy type.  The
-# only intended difference is using SocketAddress instead of
-# SocketAddressLegacy.
+# Keep this type consistent with the `NbdServerOptionsLegacy` type.  The
+# only intended difference is using `SocketAddress` instead of
+# `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
 ##
@@ -50,9 +50,9 @@
 ##
 # @NbdServerOptionsLegacy:
 #
-# Keep this type consistent with the NbdServerOptions type.  The only
-# intended difference is using SocketAddressLegacy instead of
-# SocketAddress.
+# Keep this type consistent with the `NbdServerOptions` type.  The only
+# intended difference is using `SocketAddressLegacy` instead of
+# `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
 ##
@@ -64,7 +64,7 @@
 # @nbd-server-start:
 #
 # Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using @nbd-server-add.  The NBD server
+# devices can then be exported using `nbd-server-add`.  The NBD server
 # will present them as named exports; for example, another QEMU
 # instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
 #
@@ -80,8 +80,8 @@
 ##
 # @BlockExportOptionsNbdBase:
 #
-# An NBD block export (common options shared between nbd-server-add
-# and the NBD branch of block-export-add).
+# An NBD block export (common options shared between `nbd-server-add`
+# and the NBD branch of `block-export-add`).
 #
 # @name: Export name.  If unspecified, the @device parameter is used
 #     as the export name.  (Since 2.12)
@@ -98,7 +98,7 @@
 # @BlockExportOptionsNbd:
 #
 # An NBD block export (distinct options used in the NBD branch of
-# block-export-add).
+# `block-export-add`).
 #
 # @bitmaps: Also export each of the named dirty bitmaps reachable from
 #     @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
@@ -124,7 +124,7 @@
 # A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
-#     'fd' SocketAddress types are supported.  Passed fds must be UNIX
+#     'fd' `SocketAddress` types are supported.  Passed fds must be UNIX
 #     domain sockets.
 #
 # @logical-block-size: Logical block size in bytes.  Defaults to 512
@@ -216,7 +216,7 @@
 ##
 # @NbdServerAddOptions:
 #
-# An NBD block export, per legacy nbd-server-add command.
+# An NBD block export, per legacy `nbd-server-add` command.
 #
 # @device: The device name or node name of the node to be exported
 #
@@ -245,7 +245,7 @@
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @block-export-add
+# @deprecated: This command is deprecated.  Use `block-export-add`
 #     instead.
 #
 # Errors:
@@ -288,12 +288,12 @@
 #
 # @name: Block export id.
 #
-# @mode: Mode of command operation.  See @BlockExportRemoveMode
+# @mode: Mode of command operation.  See `BlockExportRemoveMode`
 #     description.  Default is 'safe'.
 #
 # Features:
 #
-# @deprecated: This command is deprecated.  Use @block-export-del
+# @deprecated: This command is deprecated.  Use `block-export-del`
 #     instead.
 #
 # Errors:
@@ -312,7 +312,7 @@
 # @nbd-server-stop:
 #
 # Stop QEMU's embedded NBD server, and unregister all devices
-# previously added via @nbd-server-add.
+# previously added via `nbd-server-add`.
 #
 # Since: 1.3
 ##
@@ -421,7 +421,7 @@
 #
 # @id: Block export id.
 #
-# @mode: Mode of command operation.  See @BlockExportRemoveMode
+# @mode: Mode of command operation.  See `BlockExportRemoveMode`
 #     description.  Default is 'safe'.
 #
 # Errors:
@@ -459,7 +459,7 @@
 # @node-name: The node name of the block node that is exported
 #
 # @shutting-down: True if the export is shutting down (e.g. after a
-#     block-export-del command, but before the shutdown has completed)
+#     `block-export-del` command, but before the shutdown has completed)
 #
 # Since: 5.2
 ##
diff --git a/qapi/block.json b/qapi/block.json
index d288344c648..13f717cd8e8 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -137,7 +137,7 @@
 #
 # If the tray was already open before, this will be a no-op.
 #
-# Once the tray opens, a DEVICE_TRAY_MOVED event is emitted.  There
+# Once the tray opens, a `DEVICE_TRAY_MOVED` event is emitted.  There
 # are cases in which no such event will be generated, these include:
 #
 # - if the guest has locked the tray, @force is false and the guest
@@ -296,7 +296,7 @@
 # @BlockdevChangeReadOnlyMode:
 #
 # Specifies the new read-only mode of a block device subject to the
-# @blockdev-change-medium command.
+# `blockdev-change-medium` command.
 #
 # @retain: Retains the current read-only mode
 #
@@ -314,9 +314,9 @@
 #
 # Changes the medium inserted into a block device by ejecting the
 # current medium and loading a new image file which is inserted as the
-# new medium (this command combines blockdev-open-tray,
-# blockdev-remove-medium, blockdev-insert-medium and
-# blockdev-close-tray).
+# new medium (this command combines `blockdev-open-tray`,
+# `blockdev-remove-medium`, `blockdev-insert-medium` and
+# `blockdev-close-tray`).
 #
 # @device: Block device name
 #
@@ -331,7 +331,7 @@
 #     to 'retain'
 #
 # @force: if false (the default), an eject request through
-#     blockdev-open-tray will be sent to the guest if it has locked
+#     `blockdev-open-tray` will be sent to the guest if it has locked
 #     the tray (and the tray will not be opened immediately); if true,
 #     the tray will be opened regardless of whether it is locked.
 #     (since 7.1)
@@ -519,7 +519,7 @@
 # @id: The name or QOM path of the guest device.
 #
 # @boundaries: list of interval boundary values (see description in
-#     BlockLatencyHistogramInfo definition).  If specified, all
+#     `BlockLatencyHistogramInfo` definition).  If specified, all
 #     latency histograms are removed, and empty ones created for all
 #     io types with intervals corresponding to @boundaries (except for
 #     io types, for which specific boundaries are set through the
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 9d9e7af26cb..c02e402790e 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -11,7 +11,7 @@
 ##
 # @Abort:
 #
-# This action can be used to test transaction failure.
+# This action can be used to test `transaction` failure.
 #
 # Since: 1.6
 ##
@@ -67,8 +67,8 @@
 #
 # Features:
 #
-# @deprecated: Member @drive-backup is deprecated.  Use member
-#     @blockdev-backup instead.
+# @deprecated: Member `drive-backup` is deprecated.  Use member
+#     `blockdev-backup` instead.
 #
 # Since: 1.1
 ##
@@ -156,7 +156,7 @@
 # @TransactionAction:
 #
 # A discriminated record of operations that can be performed with
-# @transaction.
+# `transaction`.
 #
 # @type: the operation to be performed
 #
@@ -187,7 +187,7 @@
 #
 # @completion-mode: Controls how jobs launched asynchronously by
 #     Actions will complete or fail as a group.  See
-#     @ActionCompletionMode for details.
+#     `ActionCompletionMode` for details.
 #
 # Since: 2.5
 ##
@@ -224,20 +224,20 @@
 # support it, for example, qcow2, and rbd,
 #
 # On failure, QEMU will try delete the newly created internal snapshot
-# in the transaction.  When an I/O error occurs during deletion, the
+# in the `transaction`.  When an I/O error occurs during deletion, the
 # user needs to fix it later with qemu-img or other command.
 #
-# @actions: List of @TransactionAction; information needed for the
+# @actions: List of `TransactionAction`; information needed for the
 #     respective operations.
 #
 # @properties: structure of additional options to control the
-#     execution of the transaction.  See @TransactionProperties for
+#     execution of the `transaction`.  See `TransactionProperties` for
 #     additional detail.
 #
 # Errors:
-#     - Any errors from commands in the transaction
+#     - Any errors from commands in the `transaction`
 #
-# .. note:: The transaction aborts on the first failure.  Therefore,
+# .. note:: The `transaction` aborts on the first failure.  Therefore,
 #    there will be information on only one failed operation returned
 #    in an error condition, and subsequent actions will not have been
 #    attempted.
-- 
2.48.1


