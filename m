Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE53C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57tX-0001M9-Fk; Fri, 11 Sep 2026 16:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tR-0001Ka-Kt
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tE-000556-Q8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789158627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmDWgqMA466KBmRXKNBu7VpdocFww0XxxuHkKsNs8Aw=;
 b=Aqc3vpbWI9dhS9N/rBxiFBEm3kySygw63kQyohpNj00l+2S8cDcw7HoELZ1zpjcwDdmPk4
 9KjCeEBe47/c2gCv80gbtJ1YAvdBvilSCwRbf2uR3kYrJ6ItLe9Zxq/QOls7MyKm9LK1sT
 pKFvOeIpUNgP9bjLAxYlRCXVuZ0onA4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-uttjgL19NS-MIlTSVF1B5w-1; Fri,
 11 Sep 2026 16:30:23 -0400
X-MC-Unique: uttjgL19NS-MIlTSVF1B5w-1
X-Mimecast-MFC-AGG-ID: uttjgL19NS-MIlTSVF1B5w_1789158622
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8109E1954AC8; Fri, 11 Sep 2026 20:30:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CCDD41B; Fri, 11 Sep 2026 20:30:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 2/9] qapi: convert multi-paragraph intros (commands)
Date: Fri, 11 Sep 2026 16:29:55 -0400
Message-ID: <20260911203002.305316-3-jsnow@redhat.com>
In-Reply-To: <20260911203002.305316-1-jsnow@redhat.com>
References: <20260911203002.305316-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

This patch converts some slightly-non-trivial intros with more than
one paragraph, but doesn't create any new intro/details splits.

Review notes: Some of these possibly could be split, but as they are commands
(not eligible as an inlining source) and the additional information in
the intro is not terribly long, I opted to leave them alone instead of
laboring on prose rewrites.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 49 +++++++++++++++++++++-----------------------
 qapi/block.json      | 29 +++++++++++++-------------
 qapi/migration.json  |  9 ++++----
 qapi/misc-arm.json   |  9 ++++----
 qapi/misc.json       | 13 ++++++------
 qapi/qdev.json       | 14 ++++++-------
 6 files changed, 58 insertions(+), 65 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1ca147285e7..c505369aeb2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1772,13 +1772,12 @@
 
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
@@ -2471,15 +2470,15 @@
 ##
 # @block-dirty-bitmap-merge:
 #
-# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
-# Dirty bitmaps in @bitmaps will be unchanged, except if it also
-# appears as the @target bitmap.  Any bits already set in @target will
-# still be set after the merge, i.e., this operation does not clear
-# the target.  On error, @target is unchanged.
+#     Merge dirty bitmaps listed in @bitmaps to the @target dirty
+#     bitmap.  Dirty bitmaps in @bitmaps will be unchanged, except if
+#     it also appears as the @target bitmap.  Any bits already set in
+#     @target will still be set after the merge, i.e., this operation
+#     does not clear the target.  On error, @target is unchanged.
 #
-# The resulting bitmap will count as dirty any clusters that were
-# dirty in any of the source bitmaps.  This can be used to achieve
-# backup checkpoints, or in simpler usages, to copy bitmaps.
+#     The resulting bitmap will count as dirty any clusters that were
+#     dirty in any of the source bitmaps.  This can be used to achieve
+#     backup checkpoints, or in simpler usages, to copy bitmaps.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -5848,15 +5847,14 @@
 
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
@@ -5938,11 +5936,10 @@
 
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
diff --git a/qapi/block.json b/qapi/block.json
index e47592d5500..15f08372564 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -181,12 +181,13 @@
 
 ##
 # @blockdev-close-tray:
+#     Closes a block device's tray.
 #
-# Closes a block device's tray.  If there is a block driver state tree
-# associated with the block device (which is currently ejected), that
-# tree will be loaded as the medium.
+#     If there is a block driver state tree associated with the block
+#     device (which is currently ejected), that tree will be loaded as
+#     the medium.
 #
-# If the tray was already closed before, this will be a no-op.
+#     If the tray was already closed before, this will be a no-op.
 #
 # @device: Block device name
 #
@@ -218,13 +219,12 @@
 
 ##
 # @blockdev-remove-medium:
+#     Removes a medium (a block driver state tree) from a block
+#     device.  That block device's tray must currently be open
+#     (unless there is no attached guest device).
 #
-# Removes a medium (a block driver state tree) from a block device.
-# That block device's tray must currently be open (unless there is no
-# attached guest device).
-#
-# If the tray is open and there is no medium inserted, this will be a
-# no-op.
+#     If the tray is open and there is no medium inserted, this will
+#     be a no-op.
 #
 # @id: The name or QOM path of the guest device
 #
@@ -504,12 +504,11 @@
 
 ##
 # @block-latency-histogram-set:
+#     Manage read, write and flush latency histograms for the device.
 #
-# Manage read, write and flush latency histograms for the device.
-#
-# If only @id parameter is specified, remove all present latency
-# histograms for the device.  Otherwise, add/reset some of (or all)
-# latency histograms.
+#     If only @id parameter is specified, remove all present latency
+#     histograms for the device.  Otherwise, add/reset some of (or
+#     all) latency histograms.
 #
 # @id: The name or QOM path of the guest device.
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 8096ef64682..13c446b922f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1965,12 +1965,11 @@
 
 ##
 # @cancel-vcpu-dirty-limit:
+#     Cancel the upper limit of dirty page rate for virtual CPUs.
 #
-# Cancel the upper limit of dirty page rate for virtual CPUs.
-#
-# Cancel the dirty page limit for the vCPU which has been set with
-# `set-vcpu-dirty-limit` command.  Note that this command requires
-# support from dirty ring, same as the `set-vcpu-dirty-limit`.
+#     Cancel the dirty page limit for the vCPU which has been set with
+#     `set-vcpu-dirty-limit` command.  Note that this command requires
+#     support from dirty ring, same as the `set-vcpu-dirty-limit`.
 #
 # @cpu-index: index of a virtual CPU, default is all.
 #
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index 8cb2ea77951..64059b5688d 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -28,12 +28,11 @@
 
 ##
 # @query-gic-capabilities:
+#     It will return a list of `GICCapability` objects that describe
+#     its capability bits.
 #
-# It will return a list of `GICCapability` objects that describe its
-# capability bits.
-#
-# On non-ARM targets this command will report an error as the GIC
-# technology is not applicable.
+#     On non-ARM targets this command will report an error as the GIC
+#     technology is not applicable.
 #
 # Since: 2.6
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index b3c2a1421f3..374711ac6c7 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -178,14 +178,13 @@
 
 ##
 # @x-exit-preconfig:
+#     Exit from "preconfig" state
 #
-# Exit from "preconfig" state
-#
-# This command makes QEMU exit the preconfig state and proceed with VM
-# initialization using configuration data provided on the command line
-# and via the QMP monitor during the preconfig state.  The command is
-# only available during the preconfig state (i.e. when the --preconfig
-# command line option was in use).
+#     This command makes QEMU exit the preconfig state and proceed
+#     with VM initialization using configuration data provided on the
+#     command line and via the QMP monitor during the preconfig state.
+#     The command is only available during the preconfig state
+#     (i.e. when the --preconfig command line option was in use).
 #
 # Features:
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index a35321d2fd1..e19a92a44e8 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -163,14 +163,14 @@
 ##
 # @device-sync-config:
 #
-# Synchronize device configuration from host to guest part.  First,
-# copy the configuration from the host part (backend) to the guest
-# part (frontend).  Then notify guest software that device
-# configuration changed.
+#     Synchronize device configuration from host to guest part.
+#     First, copy the configuration from the host part (backend) to
+#     the guest part (frontend).  Then notify guest software that
+#     device configuration changed.
 #
-# The command may be used to notify the guest about block device
-# capacity change.  Currently only vhost-user-blk device supports
-# this.
+#     The command may be used to notify the guest about block device
+#     capacity change.  Currently only vhost-user-blk device supports
+#     this.
 #
 # @id: the device's ID or QOM path
 #
-- 
2.55.0


