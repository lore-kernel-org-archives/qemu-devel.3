Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2105F53D81
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cex-0002Hv-33; Mon, 16 Mar 2026 14:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Cep-0002GQ-C9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Cen-0007yW-AV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTcbobONOCWjsMmAGPufWq+VCThQt8UN7zBsSY1tMzw=;
 b=c7PkXGg2JCbTnus+YrdfFKnsdkHDADVA4gpOEcJ8J6Z2v5TdEeadDcuUur202Sw+Hub4H/
 quJ18QifEUQUcSm/4ekWRocCFVGpCiy3vnqeffxLUvJPCXenBHkDg26KYOVGlhAhrKBqjG
 vFvXeqDKKWp7sAEqG789tH1f6glOcDY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682---Xj98PIMWi0VzcIVTzL_Q-1; Mon,
 16 Mar 2026 14:27:07 -0400
X-MC-Unique: --Xj98PIMWi0VzcIVTzL_Q-1
X-Mimecast-MFC-AGG-ID: --Xj98PIMWi0VzcIVTzL_Q_1773685625
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 410BA1955DDB; Mon, 16 Mar 2026 18:27:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E969830002DA; Mon, 16 Mar 2026 18:26:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 5/8] qapi: re-order QAPI doc block sections
Date: Mon, 16 Mar 2026 14:26:04 -0400
Message-ID: <20260316182608.148628-6-jsnow@redhat.com>
In-Reply-To: <20260316182608.148628-1-jsnow@redhat.com>
References: <20260316182608.148628-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
the positioning of "Since:" left for the following patch as it is a much
bigger patch.

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
index c5ff15ae7a1..dc97bcb9b66 100644
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
index bc2279b2526..2052ebbbb5b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1674,12 +1674,12 @@
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
@@ -1691,12 +1691,12 @@
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
@@ -1709,12 +1709,12 @@
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
@@ -1726,12 +1726,12 @@
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
@@ -1743,12 +1743,12 @@
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
@@ -1760,12 +1760,12 @@
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
@@ -1829,12 +1829,12 @@
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


