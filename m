Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F0F10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRB-0007EP-1M; Wed, 08 Apr 2026 15:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAY2H-0005ZP-1N
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKyD-0005XT-8J
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5Ulh2KIa7g5Gbcr6yBI+yN2C6y5JN4BDtX1lJgvtR0=;
 b=V2xJLxpxs8IUcHwK0qrfPyJMHEugR3+gIQSuJ/Gwv5Yi49DUHBmi4g+QttEtvEJuQ0mfz7
 k8Rfwszy+2JW47lHHvxB+Ypn9blVX2u7HBB0YK1uKMl3qNYKBBqnicnsZpV4DjunzyrtHX
 Kg6l9rVEnp5lKVoEGPEWSf08t1SJhG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-MFaz0xMyMMa7Uq8c1rOLtA-1; Wed,
 08 Apr 2026 00:56:49 -0400
X-MC-Unique: MFaz0xMyMMa7Uq8c1rOLtA-1
X-Mimecast-MFC-AGG-ID: MFaz0xMyMMa7Uq8c1rOLtA_1775624207
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D777219560B5; Wed,  8 Apr 2026 04:56:46 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6E5D1955F2B; Wed,  8 Apr 2026 04:56:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 07/10] qapi: re-order QAPI doc block sections
Date: Wed,  8 Apr 2026 00:55:28 -0400
Message-ID: <20260408045531.3006678-8-jsnow@redhat.com>
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com>
References: <20260408045531.3006678-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A forthcoming patch will enforce a rigid source order of QAPI Doc block
sections:

(1) Intro
(2) Members
(3) Returns
(4) Errors
(5) Features
(6) Details
(7) Since

This patch specifically ensures the source ordering of items #1-6, with
the positioning of "Since:" left for a subsequent patch, as it is a much
larger commit.

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Many changes to the *.ir files, generally :feat: lines moving
lower. All changes are just relative re-orderings of the field list
section of the output, and all of these changes are intentional. --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/accelerator.json           |  4 +--
 qapi/block-core.json            | 44 +++++++++++++-------------
 qapi/block-export.json          | 20 ++++++------
 qapi/block.json                 |  8 ++---
 qapi/machine-s390x.json         |  8 ++---
 qapi/machine.json               | 56 ++++++++++++++++-----------------
 qapi/misc.json                  |  4 +--
 qapi/qom.json                   |  6 ++--
 qapi/virtio.json                | 32 +++++++++----------
 tests/qapi-schema/doc-good.json |  8 ++---
 tests/qapi-schema/doc-good.txt  | 10 +++---
 11 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 0cf5e0f9d94..d333a772384 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -43,12 +43,12 @@
 #
 # Query accelerator statistics
 #
+# Returns: accelerator statistics
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: accelerator statistics
-#
 # Since: 10.1
 ##
 { 'command': 'x-accel-stats',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index abdcddb0a09..400ceda9e87 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1955,14 +1955,14 @@
 #     `job-dismiss`.  When true, this job will automatically disappear
 #     without user intervention.  Defaults to true.  (Since 3.1)
 #
+# Errors:
+#     - If @device does not exist, DeviceNotFound
+#
 # Features:
 #
 # @deprecated: Members @base and @top are deprecated.  Use @base-node
 #     and @top-node instead.
 #
-# Errors:
-#     - If @device does not exist, DeviceNotFound
-#
 # Since: 1.3
 #
 # .. qmp-example::
@@ -1993,14 +1993,14 @@
 # 'backup'.  The operation can be stopped before it has completed
 # using the `job-cancel` or `block-job-cancel` command.
 #
+# Errors:
+#     - If @device is not a valid block device, GenericError
+#
 # Features:
 #
 # @deprecated: This command is deprecated.  Use `blockdev-backup`
 #     instead.
 #
-# Errors:
-#     - If @device is not a valid block device, GenericError
-#
 # Since: 1.6
 #
 # .. qmp-example::
@@ -2558,14 +2558,14 @@
 #
 # Get bitmap SHA256.
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found or if hashing has failed, GenericError
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 2.10
 ##
 { 'command': 'x-debug-block-dirty-bitmap-sha256',
@@ -3068,15 +3068,15 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
 # Features:
 #
 # @deprecated: This command is deprecated.  Use `job-pause`
 #     instead.
 #
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
 # Since: 1.3
 ##
 { 'command': 'block-job-pause', 'data': { 'device': 'str' },
@@ -3097,15 +3097,15 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
 # Features:
 #
 # @deprecated: This command is deprecated.  Use `job-resume`
 #     instead.
 #
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
 # Since: 1.3
 ##
 { 'command': 'block-job-resume', 'data': { 'device': 'str' },
@@ -3137,15 +3137,15 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
 # Features:
 #
 # @deprecated: This command is deprecated.  Use `job-complete`
 #     instead.
 #
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
 # Since: 1.3
 ##
 { 'command': 'block-job-complete', 'data': { 'device': 'str' },
diff --git a/qapi/block-export.json b/qapi/block-export.json
index dd724acf1cb..d44b509968e 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -249,15 +249,15 @@
 # The export name will be used as the id for the resulting block
 # export.
 #
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `block-export-add`
-#     instead.
-#
 # Errors:
 #     - if the server is not running
 #     - if an export with the same name already exists
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `block-export-add`
+#     instead.
+#
 # Since: 1.3
 ##
 { 'command': 'nbd-server-add',
@@ -297,16 +297,16 @@
 # @mode: Mode of command operation.  See `BlockExportRemoveMode`
 #     description.  Default is 'safe'.
 #
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `block-export-del`
-#     instead.
-#
 # Errors:
 #     - if the server is not running
 #     - if export is not found
 #     - if mode is 'safe' and there are existing connections
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `block-export-del`
+#     instead.
+#
 # Since: 2.12
 ##
 { 'command': 'nbd-server-remove',
diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e3..54bc0056318 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -109,13 +109,13 @@
 # @force: If true, eject regardless of whether the drive is locked.
 #     If not specified, the default value is false.
 #
-# Features:
-#
-# @deprecated: Member @device is deprecated.  Use @id instead.
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
+# Features:
+#
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # .. note:: Ejecting a device with no media results in success.
 #
 # Since: 0.14
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index ea430e1b889..e67f180a272 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -108,12 +108,12 @@
 ##
 # @query-s390x-cpu-polarization:
 #
-# Features:
-#
-# @unstable: This command is experimental.
-#
 # Returns: the machine's CPU polarization
 #
+# Features:
+#
+# @unstable: This command is experimental.
+#
 # Since: 8.2
 ##
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
diff --git a/qapi/machine.json b/qapi/machine.json
index 012f61e2a7e..0a4b758b2d5 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1676,12 +1676,12 @@
 #
 # Query interrupt statistics
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: interrupt statistics
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 6.2
 ##
 { 'command': 'x-query-irq',
@@ -1693,12 +1693,12 @@
 #
 # Query TCG compiler statistics
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: TCG compiler statistics
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 6.2
 ##
 { 'command': 'x-query-jit',
@@ -1711,12 +1711,12 @@
 #
 # Query NUMA topology information
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: topology information
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 6.2
 ##
 { 'command': 'x-query-numa',
@@ -1728,12 +1728,12 @@
 #
 # Query system ramblock information
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: system ramblock information
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 6.2
 ##
 { 'command': 'x-query-ramblock',
@@ -1745,12 +1745,12 @@
 #
 # Query information on the registered ROMS
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: registered ROMs
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 6.2
 ##
 { 'command': 'x-query-roms',
@@ -1762,12 +1762,12 @@
 #
 # Query information on the USB devices
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: USB device information
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 6.2
 ##
 { 'command': 'x-query-usb',
@@ -1831,12 +1831,12 @@
 #
 # Query information on interrupt controller devices
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: Interrupt controller devices information
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 9.1
 ##
 { 'command': 'x-query-interrupt-controllers',
diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2fe..05866837f09 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -209,14 +209,14 @@
 #
 # @cpu-index: The CPU to use for commands that require an implicit CPU
 #
+# Returns: the output of the command as a string
+#
 # Features:
 #
 # @savevm-monitor-nodes: If present, HMP command savevm only snapshots
 #     monitor-owned nodes if they have no parents.  This allows the
 #     use of 'savevm' with -blockdev.  (since 4.2)
 #
-# Returns: the output of the command as a string
-#
 # Since: 0.14
 #
 # .. note:: This command only exists as a stop-gap.  Its use is highly
diff --git a/qapi/qom.json b/qapi/qom.json
index 568b7d4b997..fd88be07e13 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -161,12 +161,12 @@
 # @paths: The absolute or partial path for each object, as described
 #     in `qom-get`.
 #
-# Errors:
-#     - If any path is not valid or is ambiguous
-#
 # Returns: A list where each element is the result for the
 #     corresponding element of @paths.
 #
+# Errors:
+#     - If any path is not valid or is ambiguous
+#
 # Since 10.1
 ##
 { 'command': 'qom-list-get',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 09dd0e6d05a..447fc182625 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -28,12 +28,12 @@
 #
 # Return a list of all realized VirtIODevices
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: List of gathered VirtIODevices
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 7.2
 #
 # .. qmp-example::
@@ -197,12 +197,12 @@
 #
 # @path: Canonical QOM path of the VirtIODevice
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: Status of the virtio device
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 7.2
 #
 # .. qmp-example::
@@ -566,12 +566,12 @@
 #
 # @queue: VirtQueue index to examine
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: Status of the queue
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # .. note:: last_avail_idx will not be displayed in the case where the
 #    selected VirtIODevice has a running vhost device and the
 #    VirtIODevice VirtQueue index (queue) does not exist for the
@@ -701,12 +701,12 @@
 #
 # @queue: vhost_virtqueue index to examine
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: Status of the vhost_virtqueue
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 7.2
 #
 # .. qmp-example::
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 9103fed472e..5b567824280 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -161,14 +161,14 @@
 # @arg2: description starts on the same line
 #     remainder indented differently
 #
-# Features:
-# @cmd-feat1: a feature
-# @cmd-feat2: another feature
-#
 # Returns: @Object
 #
 # Errors: some
 #
+# Features:
+# @cmd-feat1: a feature
+# @cmd-feat2: another feature
+#
 # .. note:: @arg3 is undocumented
 #
 # TODO: frobnicate
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index ded699dd596..226c3d27a36 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -115,17 +115,17 @@ Command cmd (Since: 2.10)
 
       * **arg3** ("boolean") -- Not documented
 
-   Features:
-      * **cmd-feat1** -- a feature
-
-      * **cmd-feat2** -- another feature
-
    Return:
       "Object" -- "Object"
 
    Errors:
       some
 
+   Features:
+      * **cmd-feat1** -- a feature
+
+      * **cmd-feat2** -- another feature
+
    Note:
 
      "arg3" is undocumented
-- 
2.53.0


