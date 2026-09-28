Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCB4CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJyn-00070t-FU; Mon, 28 Sep 2026 18:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyl-000706-Hu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyj-0006D7-2U
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G27JRL4KEooQSkufMVaczvAaz/ZiFJfGsFvjZcdtJ80=;
 b=RcsgOu2sC4v8a0Vyocj+NQ/GGom+hC0NHiMOYoAaYh48po8/EL6ocZl6n+vWSJpClMK8r1
 VS0yilzjo1Hclkj8nKzEHLQfo9S95O9hJBCmvoeYpnLBUAoObpRn6M93V9+7ndid6/vCOt
 AqTBxdicFkNEl+EtxpTKRO+J45i+hkM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-FRTNlhg6NQerpjDmk7IqGg-1; Mon,
 28 Sep 2026 18:37:40 -0400
X-MC-Unique: FRTNlhg6NQerpjDmk7IqGg-1
X-Mimecast-MFC-AGG-ID: FRTNlhg6NQerpjDmk7IqGg_1790635058
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C8781944D33; Mon, 28 Sep 2026 22:37:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 849EB19560AB; Mon, 28 Sep 2026 22:37:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex@shazbot.org>,
 Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 03/14] qapi: re-order QAPI doc block sections
Date: Mon, 28 Sep 2026 18:36:46 -0400
Message-ID: <20260928223657.2303684-4-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

This patch is focused on making sure that "Returns" appears before
"Errors", and "Errors" appears before "Features".

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/accelerator.json           |  8 ++---
 qapi/block-core.json            | 44 +++++++++++++-------------
 qapi/block-export.json          | 20 ++++++------
 qapi/block.json                 |  8 ++---
 qapi/machine-s390x.json         |  8 ++---
 qapi/machine.json               | 56 ++++++++++++++++-----------------
 qapi/misc.json                  |  4 +--
 qapi/net.json                   | 16 +++++-----
 qapi/qom.json                   | 10 +++---
 qapi/virtio.json                | 32 +++++++++----------
 tests/qapi-schema/doc-good.json | 12 +++----
 tests/qapi-schema/doc-good.out  | 12 +++----
 tests/qapi-schema/doc-good.txt  | 18 +++++------
 13 files changed, 124 insertions(+), 124 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index efc0fa81418..9f6a322685f 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -46,12 +46,12 @@
 # @x-accel-stats:
 #     Query accelerator statistics
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: accelerator statistics
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 10.1
 ##
 { 'command': 'x-accel-stats',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 741c8165c06..1fa6e34e884 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1958,14 +1958,14 @@
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
@@ -1996,14 +1996,14 @@
 #     can be stopped before it has completed using the `job-cancel` or
 #     `block-job-cancel` command.
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
@@ -2551,14 +2551,14 @@
 # @x-debug-block-dirty-bitmap-sha256:
 #     Get bitmap SHA256.
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
@@ -3053,15 +3053,15 @@
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
@@ -3081,15 +3081,15 @@
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
@@ -3121,15 +3121,15 @@
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
index e3cee2fb5ce..172d18b3556 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -239,15 +239,15 @@
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
@@ -285,16 +285,16 @@
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
index 0a88d405a26..4b96a72fe70 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -105,13 +105,13 @@
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
index 8d8cbe2fb75..4a745d0d73f 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -104,12 +104,12 @@
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
index 9b145c635ba..911132918bd 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1686,12 +1686,12 @@
 # @x-query-irq:
 #     Query interrupt statistics
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
@@ -1702,12 +1702,12 @@
 # @x-query-jit:
 #     Query TCG compiler statistics
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
@@ -1719,12 +1719,12 @@
 # @x-query-numa:
 #     Query NUMA topology information
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
@@ -1735,12 +1735,12 @@
 # @x-query-ramblock:
 #     Query system ramblock information
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
@@ -1751,12 +1751,12 @@
 # @x-query-roms:
 #     Query information on the registered ROMS
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
@@ -1767,12 +1767,12 @@
 # @x-query-usb:
 #     Query information on the USB devices
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
@@ -1833,12 +1833,12 @@
 # @x-query-interrupt-controllers:
 #     Query information on interrupt controller devices
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
index 4469e44d057..6a96ece6d91 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -214,14 +214,14 @@
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
diff --git a/qapi/net.json b/qapi/net.json
index f0312dfb714..376cd01cb6a 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1296,12 +1296,12 @@
 # @x-query-usernet:
 #     Query user-mode network stack connection states.
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: list of user-mode network stack information.
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 11.2
 #
 # .. qmp-example::
@@ -1412,12 +1412,12 @@
 # @x-query-network:
 #     Query the network configuration including hubs and clients.
 #
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
 # Returns: @NetworkInfo describing hubs and clients.
 #
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
 # Since: 11.2
 #
 # .. qmp-example::
diff --git a/qapi/qom.json b/qapi/qom.json
index e03ede34421..8d626797819 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -158,12 +158,12 @@
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
 # Since: 10.1
 ##
 { 'command': 'qom-list-get',
@@ -245,12 +245,12 @@
 #
 # @typename: the type name of an object
 #
+# Returns: a list describing object properties
+#
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
 #
-# Returns: a list describing object properties
-#
 # Since: 2.12
 ##
 { 'command': 'qom-list-properties',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 0a4753cc343..219c3f75043 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -26,12 +26,12 @@
 # @x-query-virtio:
 #     Return a list of all realized VirtIODevices
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
@@ -189,12 +189,12 @@
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
@@ -554,12 +554,12 @@
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
@@ -678,12 +678,12 @@
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
index d9a84ccd729..50e4fdb54d1 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -160,16 +160,16 @@
 # @arg2: description starts on the same line
 #     remainder indented differently
 #
-# Features:
-# @cmd-feat1: a feature
-# @cmd-feat2: another feature
-#
-# .. note:: @arg3 is undocumented
-#
 # Returns: @Object
 #
 # Errors: some
 #
+# Features:
+# @cmd-feat1: a feature
+# @cmd-feat2: another feature
+#
+# .. note:: @arg3 is undocumented
+#
 # TODO: frobnicate
 #
 # .. admonition:: Notes
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 1d4fbd3762a..3858bfa861d 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -171,16 +171,16 @@ description starts on the same line
     remainder indented differently
     Member=arg3
 
-    Feature=cmd-feat1
-a feature
-    Feature=cmd-feat2
-another feature
-    Details
-.. note:: @arg3 is undocumented
     Returns
 @Object
     Errors
 some
+    Feature=cmd-feat1
+a feature
+    Feature=cmd-feat2
+another feature
+    Details
+.. note:: @arg3 is undocumented
     Todo
 frobnicate
     Details
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index ba089a7f942..1f8274ef1f3 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -115,21 +115,21 @@ Command cmd (Since: 2.10)
 
       * **arg3** ("boolean") -- Not documented
 
-   Features:
-      * **cmd-feat1** -- a feature
-
-      * **cmd-feat2** -- another feature
-
-   Note:
-
-     "arg3" is undocumented
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
+   Note:
+
+     "arg3" is undocumented
+
    Notes:
 
    * Lorem ipsum dolor sit amet
-- 
2.55.0


