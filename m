Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAA6CA5FAB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJz2-00078z-Jh; Mon, 28 Sep 2026 18:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJz1-00078S-8n
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyv-0006EY-Uc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00LKwBdtO5r9ONsfs7tx1cLgo1rTrtOmyfsRW1kpkMY=;
 b=hESihxw3+XsgHYhUmTFAQA9SUvynTZOxRvTlT65/rn5AT5jP7fCFeGYmt3Hn3ZXHkyXleb
 waeIXlZrK7QFGan0xMvDGvA+Ufn9D1+OQhpAV8sONyIikbRAGOmGuQG5nhbRMKYQmJa+PD
 E3vWOrLm5AX1j8luSGaYloavzXhnsnQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-rzm-1WhXNJiDp6iZSZ_V4g-1; Mon,
 28 Sep 2026 18:37:53 -0400
X-MC-Unique: rzm-1WhXNJiDp6iZSZ_V4g-1
X-Mimecast-MFC-AGG-ID: rzm-1WhXNJiDp6iZSZ_V4g_1790635071
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BCA01926B64; Mon, 28 Sep 2026 22:37:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CDF119560AB; Mon, 28 Sep 2026 22:37:43 +0000 (UTC)
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
Subject: [PATCH 05/14] qapi: move 'details' sections to the bottom of doc
 blocks
Date: Mon, 28 Sep 2026 18:36:48 -0400
Message-ID: <20260928223657.2303684-6-jsnow@redhat.com>
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

This patch is focused on moving any and all "Details" sections to
below any Members/Returns/Errors/Features sections, generally
appearing last or after "Since:" sections.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/firmware.json      |  54 +++---
 docs/interop/vhost-user.json    |  30 +--
 qapi/acpi.json                  |  28 +--
 qapi/block-core.json            | 334 ++++++++++++++++----------------
 qapi/block-export.json          |  16 +-
 qapi/block.json                 |  82 ++++----
 qapi/compat.json                |  14 +-
 qapi/crypto.json                |   4 +-
 qapi/introspect.json            |  14 +-
 qapi/job.json                   |  26 +--
 qapi/machine-s390x.json         |  16 +-
 qapi/machine.json               | 184 +++++++++---------
 qapi/migration.json             |  64 +++---
 qapi/misc-i386.json             |  28 +--
 qapi/misc.json                  |  26 +--
 qapi/net.json                   |   4 +-
 qapi/qdev.json                  |  12 +-
 qapi/qom.json                   |  26 +--
 qapi/stats.json                 |   6 +-
 qapi/transaction.json           |  34 ++--
 qapi/ui.json                    |  18 +-
 qga/qapi-schema.json            |  80 ++++----
 tests/qapi-schema/doc-good.json |   4 +-
 tests/qapi-schema/doc-good.out  |   4 +-
 tests/qapi-schema/doc-good.txt  |   4 +-
 25 files changed, 556 insertions(+), 556 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 1efd32c6315..c463fa6d05b 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -457,6 +457,33 @@
 #     Describes a firmware (or a firmware use case) to management
 #     software.
 #
+# @description: Provides a human-readable description of the firmware.
+#     Management software may or may not display @description.
+#
+# @interface-types: Lists the types of interfaces that the firmware
+#     can expose to the guest OS.  This is a non-empty, ordered list;
+#     entries near the beginning of @interface-types are considered
+#     more native to the firmware, and/or to have a higher quality
+#     implementation in the firmware, than entries near the end of
+#     @interface-types.
+#
+# @mapping: Describes the loading / mapping properties of the
+#     firmware.
+#
+# @targets: Collects the target architectures (QEMU system emulators)
+#     and their machine types that may execute the firmware.
+#
+# @features: Lists the features that the firmware supports, and the
+#     platform requirements it presents.
+#
+# @tags: A list of auxiliary strings associated with the firmware for
+#     which @description is not appropriate, due to the latter's
+#     possible exposure to the end-user.  @tags serves development and
+#     debugging purposes only, and management software shall
+#     explicitly ignore it.
+#
+# Since: 3.0
+#
 # It is possible for multiple @Firmware elements to match the search
 # criteria of management software.  Applications thus need rules to
 # pick one of the many matches, and users need the ability to override
@@ -512,33 +539,6 @@
 #
 #   $ vim /etc/qemu/firmware/99-ovmf.json
 #
-# @description: Provides a human-readable description of the firmware.
-#     Management software may or may not display @description.
-#
-# @interface-types: Lists the types of interfaces that the firmware
-#     can expose to the guest OS.  This is a non-empty, ordered list;
-#     entries near the beginning of @interface-types are considered
-#     more native to the firmware, and/or to have a higher quality
-#     implementation in the firmware, than entries near the end of
-#     @interface-types.
-#
-# @mapping: Describes the loading / mapping properties of the
-#     firmware.
-#
-# @targets: Collects the target architectures (QEMU system emulators)
-#     and their machine types that may execute the firmware.
-#
-# @features: Lists the features that the firmware supports, and the
-#     platform requirements it presents.
-#
-# @tags: A list of auxiliary strings associated with the firmware for
-#     which @description is not appropriate, due to the latter's
-#     possible exposure to the end-user.  @tags serves development and
-#     debugging purposes only, and management software shall
-#     explicitly ignore it.
-#
-# Since: 3.0
-#
 # .. qmp-example::
 #
 #     {
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index 65e681a166a..9a49ab6c14d 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -184,6 +184,21 @@
 # @VhostUserBackend:
 #     Describes a vhost user backend to management software.
 #
+# @type: The vhost user backend type.
+#
+# @description: Provides a human-readable description of the backend.
+#     Management software may or may not display @description.
+#
+# @binary: Absolute path to the backend binary.
+#
+# @tags: An optional list of auxiliary strings associated with the
+#     backend for which @description is not appropriate, due to the
+#     latter's possible exposure to the end-user.  @tags serves
+#     development and debugging purposes only, and management software
+#     shall explicitly ignore it.
+#
+# Since: 4.0
+#
 # It is possible for multiple @VhostUserBackend elements to match the
 # search criteria of management software.  Applications thus need
 # rules to pick one of the many matches, and users need the ability to
@@ -242,21 +257,6 @@
 #
 #   $ vim /etc/qemu/vhost-user/99-qemu-gpu.json
 #
-# @type: The vhost user backend type.
-#
-# @description: Provides a human-readable description of the backend.
-#     Management software may or may not display @description.
-#
-# @binary: Absolute path to the backend binary.
-#
-# @tags: An optional list of auxiliary strings associated with the
-#     backend for which @description is not appropriate, due to the
-#     latter's possible exposure to the end-user.  @tags serves
-#     development and debugging purposes only, and management software
-#     shall explicitly ignore it.
-#
-# Since: 4.0
-#
 # .. qmp-example:
 #
 # {
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 82e82d7cf89..8204d7ba52a 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -15,20 +15,6 @@
 # @AcpiTableOptions:
 #     Specify an ACPI table on the command line to load.
 #
-# At most one of @file and @data can be specified.  The list of files
-# specified by any one of them is loaded and concatenated in order.
-# If both are omitted, @data is implied.
-#
-# Other fields / optargs can be used to override fields of the generic
-# ACPI table header; refer to the ACPI specification 5.0, section
-# 5.2.6 System Description Table Header.  If a header field is not
-# overridden, then the corresponding value from the concatenated blob
-# is used (in case of @file), or it is filled in with a hard-coded
-# value (in case of @data).
-#
-# String fields are copied into the matching ACPI member from lowest
-# address upwards, and silently truncated / NUL-padded to length.
-#
 # @sig: table signature / identifier (4 bytes)
 #
 # @rev: table revision number (dependent on signature, 1 byte)
@@ -55,6 +41,20 @@
 #     table header.  At least one file is required.  This field
 #     excludes @file.
 #
+# At most one of @file and @data can be specified.  The list of files
+# specified by any one of them is loaded and concatenated in order.
+# If both are omitted, @data is implied.
+#
+# Other fields / optargs can be used to override fields of the generic
+# ACPI table header; refer to the ACPI specification 5.0, section
+# 5.2.6 System Description Table Header.  If a header field is not
+# overridden, then the corresponding value from the concatenated blob
+# is used (in case of @file), or it is filled in with a hard-coded
+# value (in case of @data).
+#
+# String fields are copied into the matching ACPI member from lowest
+# address upwards, and silently truncated / NUL-padded to length.
+#
 # Since: 1.5
 ##
 { 'struct': 'AcpiTableOptions',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1fa6e34e884..c92dbb80818 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -846,6 +846,18 @@
 #     Image file size calculation information.  This structure
 #     describes the size requirements for creating a new image file.
 #
+# @required: Size required for a new image file, in bytes, when
+#     copying just allocated guest-visible contents.
+#
+# @fully-allocated: Image file size, in bytes, once data has been
+#     written to all sectors, when copying just guest-visible
+#     contents.
+#
+# @bitmaps: Additional size required if all the top-level bitmap
+#     metadata in the source image were to be copied to the
+#     destination, present only when source and destination both
+#     support persistent bitmaps.  (since 5.1)
+#
 # The size requirements depend on the new image file format.  File
 # size always equals virtual disk size for the 'raw' format, even for
 # sparse POSIX files.  Compact formats such as 'qcow2' represent
@@ -857,18 +869,6 @@
 # bitmap creation, may require additional space and is not covered
 # here.
 #
-# @required: Size required for a new image file, in bytes, when
-#     copying just allocated guest-visible contents.
-#
-# @fully-allocated: Image file size, in bytes, once data has been
-#     written to all sectors, when copying just guest-visible
-#     contents.
-#
-# @bitmaps: Additional size required if all the top-level bitmap
-#     metadata in the source image were to be copied to the
-#     destination, present only when source and destination both
-#     support persistent bitmaps.  (since 5.1)
-#
 # Since: 2.10
 ##
 { 'struct': 'BlockMeasureInfo',
@@ -1557,8 +1557,6 @@
 # @block_resize:
 #     Resize a block image while a guest is running.
 #
-# Either @device or @node-name must be set but not both.
-#
 # @device: the name of the device to get the image resized
 #
 # @node-name: graph node name to get the image resized (Since 2.0)
@@ -1570,6 +1568,8 @@
 #
 # Since: 0.14
 #
+# Either @device or @node-name must be set but not both.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "block_resize",
@@ -1602,8 +1602,6 @@
 ##
 # @BlockdevSnapshotSync:
 #
-# Either @device or @node-name must be set but not both.
-#
 # @device: the name of the device to take a snapshot of.
 #
 # @node-name: graph node name to generate the snapshot from
@@ -1620,6 +1618,8 @@
 #
 # @mode: whether and how QEMU should create a new image, default is
 #     'absolute-paths'.
+#
+# Either @device or @node-name must be set but not both.
 ##
 { 'struct': 'BlockdevSnapshotSync',
   'data': { '*device': 'str', '*node-name': 'str',
@@ -1883,17 +1883,6 @@
 #     Live commit of data from overlay image nodes into backing nodes
 #     - i.e., writes data between 'top' and 'base' into 'base'.
 #
-# If top == base, that is an error.  If top has no overlays on top of
-# it, or if it is in use by a writer, the job will not be completed by
-# itself.  The user needs to complete the job with the `job-complete`
-# command after getting the ready event.  (Since 2.0)
-#
-# If the base image is smaller than top, then the base image will be
-# resized to be the same size as top.  If top is smaller than the base
-# image, the base will not be truncated.  If you want the base image
-# size to match the size of the smaller top, you can safely truncate
-# it yourself once the commit operation successfully completes.
-#
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
 #
@@ -1968,6 +1957,17 @@
 #
 # Since: 1.3
 #
+# If top == base, that is an error.  If top has no overlays on top of
+# it, or if it is in use by a writer, the job will not be completed by
+# itself.  The user needs to complete the job with the `job-complete`
+# command after getting the ready event.  (Since 2.0)
+#
+# If the base image is smaller than top, then the base image will be
+# resized to be the same size as top.  If top is smaller than the base
+# image, the base will not be truncated.  If you want the base image
+# size to match the size of the smaller top, you can safely truncate
+# it yourself once the commit operation successfully completes.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "block-commit",
@@ -2862,6 +2862,66 @@
 # @block-stream:
 #     Copy data from a backing file into a block device.
 #
+# @job-id: identifier for the newly-created block job.  If omitted,
+#     the device name will be used.  (Since 2.7)
+#
+# @device: the device or node name of the top image
+#
+# @base: the common backing file name.  It cannot be set if @base-node
+#     or @bottom is also set.
+#
+# @base-node: the node name of the backing file.  It cannot be set if
+#     @base or @bottom is also set.  (Since 2.8)
+#
+# @bottom: the last node in the chain that should be streamed into
+#     top.  It cannot be set if @base or @base-node is also set.  It
+#     cannot be filter node.  (Since 6.0)
+#
+# @backing-file: The backing file string to write into the top image.
+#     This filename is not validated.
+#
+#     If a pathname string is such that it cannot be resolved by QEMU,
+#     that means that subsequent QMP or HMP commands must use
+#     node-names for the image in question, as filename lookup methods
+#     will fail.
+#
+#     If not specified, QEMU will automatically determine the backing
+#     file string to use, or error out if there is no obvious choice.
+#     Care should be taken when specifying the string, to specify a
+#     valid filename or protocol.  (Since 2.1)
+#
+# @backing-mask-protocol: If true, replace any protocol mentioned in
+#     the 'backing file format' with 'raw', rather than storing the
+#     protocol name as the backing format.  Can be used even when no
+#     image header will be updated (default false; since 9.0).
+#
+# @speed: the maximum speed, in bytes per second
+#
+# @on-error: the action to take on an error (default report).  'stop'
+#     and 'enospc' can only be used if the block device supports
+#     io-status (see `BlockInfo`).  (Since 1.3)
+#
+# @filter-node-name: the node name that should be assigned to the
+#     filter driver that the stream job inserts into the graph above
+#     @device.  If this option is not given, a node name is
+#     autogenerated.  (Since: 6.0)
+#
+# @auto-finalize: When false, this job will wait in a PENDING state
+#     after it has finished its work, waiting for `job-finalize`
+#     before making any block graph changes.  When true, this job will
+#     automatically perform its abort or commit actions.  Defaults to
+#     true.  (Since 3.1)
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state
+#     after it has completely ceased all work, and awaits
+#     `job-dismiss`.  When true, this job will automatically disappear
+#     without user intervention.  Defaults to true.  (Since 3.1)
+#
+# Errors:
+#     - If @device does not exist, DeviceNotFound.
+#
+# Since: 1.1
+#
 # The block streaming operation is performed in the background until
 # the entire backing file has been copied.  This command returns
 # immediately once streaming has started.  The status of ongoing block
@@ -2892,66 +2952,6 @@
 # non-filter overlay node below it to point to the new backing node
 # instead of modifying @device itself.
 #
-# @job-id: identifier for the newly-created block job.  If omitted,
-#     the device name will be used.  (Since 2.7)
-#
-# @device: the device or node name of the top image
-#
-# @base: the common backing file name.  It cannot be set if @base-node
-#     or @bottom is also set.
-#
-# @base-node: the node name of the backing file.  It cannot be set if
-#     @base or @bottom is also set.  (Since 2.8)
-#
-# @bottom: the last node in the chain that should be streamed into
-#     top.  It cannot be set if @base or @base-node is also set.  It
-#     cannot be filter node.  (Since 6.0)
-#
-# @backing-file: The backing file string to write into the top image.
-#     This filename is not validated.
-#
-#     If a pathname string is such that it cannot be resolved by QEMU,
-#     that means that subsequent QMP or HMP commands must use
-#     node-names for the image in question, as filename lookup methods
-#     will fail.
-#
-#     If not specified, QEMU will automatically determine the backing
-#     file string to use, or error out if there is no obvious choice.
-#     Care should be taken when specifying the string, to specify a
-#     valid filename or protocol.  (Since 2.1)
-#
-# @backing-mask-protocol: If true, replace any protocol mentioned in
-#     the 'backing file format' with 'raw', rather than storing the
-#     protocol name as the backing format.  Can be used even when no
-#     image header will be updated (default false; since 9.0).
-#
-# @speed: the maximum speed, in bytes per second
-#
-# @on-error: the action to take on an error (default report).  'stop'
-#     and 'enospc' can only be used if the block device supports
-#     io-status (see `BlockInfo`).  (Since 1.3)
-#
-# @filter-node-name: the node name that should be assigned to the
-#     filter driver that the stream job inserts into the graph above
-#     @device.  If this option is not given, a node name is
-#     autogenerated.  (Since: 6.0)
-#
-# @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for `job-finalize`
-#     before making any block graph changes.  When true, this job will
-#     automatically perform its abort or commit actions.  Defaults to
-#     true.  (Since 3.1)
-#
-# @auto-dismiss: When false, this job will wait in a CONCLUDED state
-#     after it has completely ceased all work, and awaits
-#     `job-dismiss`.  When true, this job will automatically disappear
-#     without user intervention.  Defaults to true.  (Since 3.1)
-#
-# Errors:
-#     - If @device does not exist, DeviceNotFound.
-#
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-stream",
@@ -2973,10 +2973,6 @@
 # @block-job-set-speed:
 #     Set maximum speed for a background block operation.
 #
-# This command can only be issued when there is an active block job.
-#
-# Throttling can be disabled by setting the speed to 0.
-#
 # @device: The job identifier.  This used to be a device name (hence
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
@@ -2988,6 +2984,10 @@
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
+# This command can only be issued when there is an active block job.
+#
+# Throttling can be disabled by setting the speed to 0.
+#
 # Since: 1.1
 ##
 { 'command': 'block-job-set-speed',
@@ -2998,6 +2998,19 @@
 # @block-job-cancel:
 #     Stop an active background block operation.
 #
+# @device: The job identifier.  This used to be a device name (hence
+#     the name of the parameter), but since QEMU 2.7 it can have other
+#     values.
+#
+# @force: If true, and the job has already emitted the event
+#     `BLOCK_JOB_READY`, abandon the job immediately (even if it is
+#     paused) instead of waiting for the destination to complete its
+#     final synchronization (since 1.3)
+#
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
 # This command returns immediately after marking the active background
 # block operation for cancellation.  It is an error to call this
 # command if no operation is in progress.
@@ -3018,19 +3031,6 @@
 # cancelled.  A new streaming operation can be started at a later time
 # to finish copying all data from the backing file.
 #
-# @device: The job identifier.  This used to be a device name (hence
-#     the name of the parameter), but since QEMU 2.7 it can have other
-#     values.
-#
-# @force: If true, and the job has already emitted the event
-#     `BLOCK_JOB_READY`, abandon the job immediately (even if it is
-#     paused) instead of waiting for the destination to complete its
-#     final synchronization (since 1.3)
-#
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
 # Since: 1.1
 ##
 { 'command': 'block-job-cancel', 'data': { 'device': 'str', '*force': 'bool' },
@@ -3040,6 +3040,19 @@
 # @block-job-pause:
 #     Pause an active background block operation.
 #
+# @device: The job identifier.  This used to be a device name (hence
+#     the name of the parameter), but since QEMU 2.7 it can have other
+#     values.
+#
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `job-pause`
+#     instead.
+#
 # This command returns immediately after marking the active job for
 # pausing.  Pausing an already paused job is an error.
 #
@@ -3049,19 +3062,6 @@
 #
 # Cancelling a paused job automatically resumes it.
 #
-# @device: The job identifier.  This used to be a device name (hence
-#     the name of the parameter), but since QEMU 2.7 it can have other
-#     values.
-#
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `job-pause`
-#     instead.
-#
 # Since: 1.3
 ##
 { 'command': 'block-job-pause', 'data': { 'device': 'str' },
@@ -3072,24 +3072,24 @@
 # @block-job-resume:
 #     Resume an active background block operation.
 #
+# @device: The job identifier.  This used to be a device name (hence
+#     the name of the parameter), but since QEMU 2.7 it can have other
+#     values.
+#
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `job-resume`
+#     instead.
+#
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
 #
 # This command also clears the error status of the job.
 #
-# @device: The job identifier.  This used to be a device name (hence
-#     the name of the parameter), but since QEMU 2.7 it can have other
-#     values.
-#
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `job-resume`
-#     instead.
-#
 # Since: 1.3
 ##
 { 'command': 'block-job-resume', 'data': { 'device': 'str' },
@@ -3102,6 +3102,19 @@
 #     STANDBY state.  Completing the job in any other state is an
 #     error.
 #
+# @device: The job identifier.  This used to be a device name (hence
+#     the name of the parameter), but since QEMU 2.7 it can have other
+#     values.
+#
+# Errors:
+#     - If no background operation is active on this device,
+#       DeviceNotActive
+#
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `job-complete`
+#     instead.
+#
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
 # mirroring includes `drive-mirror`, `blockdev-mirror` and
@@ -3117,19 +3130,6 @@
 # rerror/werror arguments that were specified when starting the
 # operation.
 #
-# @device: The job identifier.  This used to be a device name (hence
-#     the name of the parameter), but since QEMU 2.7 it can have other
-#     values.
-#
-# Errors:
-#     - If no background operation is active on this device,
-#       DeviceNotActive
-#
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `job-complete`
-#     instead.
-#
 # Since: 1.3
 ##
 { 'command': 'block-job-complete', 'data': { 'device': 'str' },
@@ -3146,18 +3146,18 @@
 #     `blockdev-mirror`, `block-commit` and `block-stream`.
 #     @auto-dismiss is enabled by default for these jobs.
 #
+# @id: The job identifier.
+#
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `job-dismiss`
+#     instead.
+#
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
 # the `BLOCK_JOB_READY` event, `job-cancel`, `block-job-cancel` or
 # `job-complete` will still need to be used as appropriate.
 #
-# @id: The job identifier.
-#
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `job-dismiss`
-#     instead.
-#
 # Since: 2.12
 ##
 { 'command': 'block-job-dismiss', 'data': { 'id': 'str' },
@@ -3171,6 +3171,13 @@
 #     do any necessary cleanup.  This command requires that all
 #     involved jobs are in the PENDING state.
 #
+# @id: The job identifier.
+#
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `job-finalize`
+#     instead.
+#
 # For jobs in a transaction, instructing one job to finalize will
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
@@ -3178,13 +3185,6 @@
 # The command is applicable only to jobs which have @auto-finalize
 # option and only when this option is set to false.
 #
-# @id: The job identifier.
-#
-# Features:
-#
-# @deprecated: This command is deprecated.  Use `job-finalize`
-#     instead.
-#
 # Since: 2.12
 ##
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
@@ -4986,10 +4986,6 @@
 #     Activate or deactivate a block device.  Use this to manage the
 #     handover of block devices on migration with qemu-storage-daemon.
 #
-# Activating a node automatically activates all of its child nodes
-# first.  Deactivating a node automatically deactivates any of its
-# child nodes that are not in use by a still active node.
-#
 # @node-name: Name of the graph node to activate or deactivate.  By
 #     default, all nodes are affected by the operation.
 #
@@ -4998,6 +4994,10 @@
 #
 # Since: 10.0
 #
+# Activating a node automatically activates all of its child nodes
+# first.  Deactivating a node automatically deactivates any of its
+# child nodes that are not in use by a still active node.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-set-active",
@@ -5898,12 +5898,6 @@
 # @x-blockdev-change:
 #     Dynamically reconfigure the block driver state graph.
 #
-# Currently only supports adding and deleting quorum children.  A
-# child will be added at the end of the list of children.  Its
-# contents *must* be consistent with the other childrens' contents.
-# Deleting a child that is not last in the list of children is
-# problematic, because it "renumbers" the children following it.
-#
 # @parent: the id or name of the parent node.
 #
 # @child: the name of a child to be deleted.  Mutually exclusive with
@@ -5923,6 +5917,12 @@
 #
 # Since: 2.7
 #
+# Currently only supports adding and deleting quorum children.  A
+# child will be added at the end of the list of children.  Its
+# contents *must* be consistent with the other childrens' contents.
+# Deleting a child that is not last in the list of children is
+# problematic, because it "renumbers" the children following it.
+#
 # .. qmp-example::
 #    :title: Add a new node to a quorum
 #
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 172d18b3556..b335b0620cc 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -157,11 +157,6 @@
 #     Options for exporting a block graph node on some (file)
 #     mountpoint as a raw image.
 #
-# Multi-threading note: The FUSE export supports multi-threading.
-# Currently, requests are distributed across these threads in a
-# round-robin fashion, i.e. independently of the CPU core from which a
-# request originates.
-#
 # @mountpoint: Path on which to export the block device via FUSE.
 #     This must point to an existing regular file.
 #
@@ -178,6 +173,11 @@
 #     mount the export with allow_other, and if that fails, try again
 #     without.  (since 6.1; default: auto)
 #
+# Multi-threading note: The FUSE export supports multi-threading.
+# Currently, requests are distributed across these threads in a
+# round-robin fashion, i.e. independently of the CPU core from which a
+# request originates.
+#
 # Since: 6.0
 ##
 { 'struct': 'BlockExportOptionsFuse',
@@ -236,9 +236,6 @@
 # @nbd-server-add:
 #     Export a block node to QEMU's embedded NBD server.
 #
-# The export name will be used as the id for the resulting block
-# export.
-#
 # Errors:
 #     - if the server is not running
 #     - if an export with the same name already exists
@@ -248,6 +245,9 @@
 # @deprecated: This command is deprecated.  Use `block-export-add`
 #     instead.
 #
+# The export name will be used as the id for the resulting block
+# export.
+#
 # Since: 1.3
 ##
 { 'command': 'nbd-server-add',
diff --git a/qapi/block.json b/qapi/block.json
index 4b96a72fe70..99b888d78e9 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -130,6 +130,21 @@
 # @blockdev-open-tray:
 #     Opens a block device's tray.
 #
+# @device: Block device name
+#
+# @id: The name or QOM path of the guest device (since: 2.8)
+#
+# @force: if false (the default), an eject request will be sent to the
+#     guest if it has locked the tray (and the tray will not be opened
+#     immediately); if true, the tray will be opened regardless of
+#     whether it is locked
+#
+# Features:
+#
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
+# Since: 2.5
+#
 # If there is a block driver state tree inserted as a medium, it will
 # become inaccessible to the guest (but it will remain associated to
 # the block device, so closing the tray will make it accessible
@@ -146,21 +161,6 @@
 #   device attached to it
 # - if the guest device does not have an actual tray
 #
-# @device: Block device name
-#
-# @id: The name or QOM path of the guest device (since: 2.8)
-#
-# @force: if false (the default), an eject request will be sent to the
-#     guest if it has locked the tray (and the tray will not be opened
-#     immediately); if true, the tray will be opened regardless of
-#     whether it is locked
-#
-# Features:
-#
-# @deprecated: Member @device is deprecated.  Use @id instead.
-#
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-open-tray",
@@ -184,22 +184,22 @@
 # @blockdev-close-tray:
 #     Closes a block device's tray.
 #
+# @device: Block device name
+#
+# @id: The name or QOM path of the guest device (since: 2.8)
+#
+# Features:
+#
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
+# Since: 2.5
+#
 # If there is a block driver state tree associated with the block
 # device (which is currently ejected), that tree will be loaded as the
 # medium.
 #
 # If the tray was already closed before, this will be a no-op.
 #
-# @device: Block device name
-#
-# @id: The name or QOM path of the guest device (since: 2.8)
-#
-# Features:
-#
-# @deprecated: Member @device is deprecated.  Use @id instead.
-#
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-close-tray",
@@ -224,13 +224,13 @@
 #     device.  That block device's tray must currently be open
 #     (unless there is no attached guest device).
 #
+# @id: The name or QOM path of the guest device
+#
+# Since: 2.12
+#
 # If the tray is open and there is no medium inserted, this will
 # be a no-op.
 #
-# @id: The name or QOM path of the guest device
-#
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-remove-medium",
@@ -432,6 +432,11 @@
 # @block_set_io_throttle:
 #     Change I/O throttle limits for a block drive.
 #
+# Errors:
+#     - If @device is not a valid block device, DeviceNotFound
+#
+# Since: 1.1
+#
 # Since QEMU 2.4, each device with I/O limits is member of a throttle
 # group.
 #
@@ -453,11 +458,6 @@
 # case the device will be removed from its group and the rest of its
 # members will not be affected.  The 'group' parameter is ignored.
 #
-# Errors:
-#     - If @device is not a valid block device, DeviceNotFound
-#
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block_set_io_throttle",
@@ -506,10 +506,6 @@
 # @block-latency-histogram-set:
 #     Manage read, write and flush latency histograms for the device.
 #
-# If only @id parameter is specified, remove all present latency
-# histograms for the device.  Otherwise, add/reset some of (or all)
-# latency histograms.
-#
 # @id: The name or QOM path of the guest device.
 #
 # @boundaries: list of interval boundary values (see description in
@@ -539,6 +535,10 @@
 #
 # Since: 4.0
 #
+# If only @id parameter is specified, remove all present latency
+# histograms for the device.  Otherwise, add/reset some of (or all)
+# latency histograms.
+#
 # .. qmp-example::
 #    :annotated:
 #
@@ -599,9 +599,6 @@
 # @x-qemu-io:
 #     Run a qemu-io command on a block device.
 #
-# Take either a block backend name or a qdev ID to identify the
-# device.
-#
 # @device: the block backend name, node-name to run the
 #     command on.
 #
@@ -616,6 +613,9 @@
 #
 # Since: 11.2
 #
+# Take either a block backend name or a qdev ID to identify the
+# device.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "x-qemu-io",
diff --git a/qapi/compat.json b/qapi/compat.json
index 0f90ea1f524..16e227c61c6 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -57,13 +57,6 @@
 #
 #     This is intended for testing users of the management interfaces.
 #
-# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
-# with feature 'deprecated' or 'unstable'.  We may want to extend it
-# to cover semantic aspects and CLI.
-#
-# Limitation: deprecated-output policy @hide is not implemented for
-# enumeration values.  They behave the same as with policy @accept.
-#
 # @deprecated-input: how to handle deprecated input (default 'accept')
 #
 # @deprecated-output: how to handle deprecated output (default
@@ -78,6 +71,13 @@
 # @insecure-types: how to handle types that are not declared secure
 #     (default 'accept') (since 11.2)
 #
+# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
+# with feature 'deprecated' or 'unstable'.  We may want to extend it
+# to cover semantic aspects and CLI.
+#
+# Limitation: deprecated-output policy @hide is not implemented for
+# enumeration values.  They behave the same as with policy @accept.
+#
 # Since: 6.0
 ##
 { 'struct': 'CompatPolicy',
diff --git a/qapi/crypto.json b/qapi/crypto.json
index a8d753d360f..5d0bcdf2b40 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -431,12 +431,12 @@
 # @SecretProperties:
 #     Properties for secret objects.
 #
-# Either @data or @file must be provided, but not both.
-#
 # @data: the associated with the secret from
 #
 # @file: the filename to load the data associated with the secret from
 #
+# Either @data or @file must be provided, but not both.
+#
 # Since: 2.6
 ##
 { 'struct': 'SecretProperties',
diff --git a/qapi/introspect.json b/qapi/introspect.json
index d579e5c8554..693ecff6be7 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -22,6 +22,13 @@
 #     and events are available in this QEMU, and their parameters and
 #     results.
 #
+# Returns: an array where each element describes an entity in the ABI:
+#     command, event, type, ...
+#
+#     The order of the various elements is unspecified; however, all
+#     names are guaranteed to be unique (no name will be duplicated
+#     with different meta-types).
+#
 # The `SchemaInfo` can't reflect all the rules and restrictions that
 # apply to QMP.  It's interface introspection (figuring out what's
 # there), not interface specification.  The specification is in the
@@ -36,13 +43,6 @@
 # string into a specific enum or from one specific type into an
 # alternate that includes the original type alongside something else.
 #
-# Returns: an array where each element describes an entity in the ABI:
-#     command, event, type, ...
-#
-#     The order of the various elements is unspecified; however, all
-#     names are guaranteed to be unique (no name will be duplicated
-#     with different meta-types).
-#
 # .. note:: The QAPI schema is also used to help define *internal*
 #    interfaces, by defining QAPI types.  These are not part of the
 #    QMP wire ABI, and therefore not returned by this command.
diff --git a/qapi/job.json b/qapi/job.json
index aa75a8efa24..8ecb50f9228 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -130,6 +130,8 @@
 # @job-pause:
 #     Pause an active job.
 #
+# @id: The job identifier.
+#
 # This command returns immediately after marking the active job for
 # pausing.  Pausing an already paused job is an error.
 #
@@ -139,8 +141,6 @@
 #
 # Cancelling a paused job automatically resumes it.
 #
-# @id: The job identifier.
-#
 # Since: 3.0
 ##
 { 'command': 'job-pause', 'data': { 'id': 'str' } }
@@ -149,14 +149,14 @@
 # @job-resume:
 #     Resume a paused job.
 #
+# @id: The job identifier.
+#
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
 #
 # This command also clears the error status for block-jobs (stream,
 # commit, mirror, backup).
 #
-# @id: The job identifier.
-#
 # Since: 3.0
 ##
 { 'command': 'job-resume', 'data': { 'id': 'str' } }
@@ -167,14 +167,14 @@
 #     opportunity.  This command returns immediately after marking the
 #     active job for cancellation.
 #
+# @id: The job identifier.
+#
 # The job will cancel as soon as possible and then emit a
 # `JOB_STATUS_CHANGE` event.  Usually, the status will change to
 # ABORTING, but it is possible that a job successfully completes (e.g.
 # because it was almost done and there was no opportunity to cancel
 # earlier than completing the job) and transitions to PENDING instead.
 #
-# @id: The job identifier.
-#
 # Since: 3.0
 ##
 { 'command': 'job-cancel', 'data': { 'id': 'str' } }
@@ -185,6 +185,8 @@
 #     STANDBY state.  Completing the job in any other state is an
 #     error.
 #
+# @id: The job identifier.
+#
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
 # mirroring includes `drive-mirror`, `blockdev-mirror` and
@@ -200,8 +202,6 @@
 # rerror/werror arguments that were specified when starting the
 # operation.
 #
-# @id: The job identifier.
-#
 # Since: 3.0
 ##
 { 'command': 'job-complete', 'data': { 'id': 'str' } }
@@ -210,6 +210,8 @@
 # @job-dismiss:
 #     Deletes a job that is in the CONCLUDED state.
 #
+# @id: The job identifier.
+#
 # This command only needs to be run explicitly for jobs that don't
 # have automatic dismiss enabled.  In turn, automatic dismiss may be
 # enabled only for jobs that have @auto-dismiss option, which are
@@ -222,8 +224,6 @@
 # the JOB_READY event, `job-cancel` or `job-complete` will still need
 # to be used as appropriate.
 #
-# @id: The job identifier.
-#
 # Since: 3.0
 ##
 { 'command': 'job-dismiss', 'data': { 'id': 'str' } }
@@ -235,6 +235,9 @@
 #     do any necessary cleanup.  This command requires that all
 #     involved jobs are in the PENDING state.
 #
+# @id: The identifier of any job in the transaction, or of a job that
+#     is not part of any transaction.
+#
 # For jobs in a transaction, instructing one job to finalize will
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
@@ -242,9 +245,6 @@
 # The command is applicable only to jobs which have @auto-finalize
 # option and only when this option is set to false.
 #
-# @id: The identifier of any job in the transaction, or of a job that
-#     is not part of any transaction.
-#
 # Since: 3.0
 ##
 { 'command': 'job-finalize', 'data': { 'id': 'str' } }
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 4a745d0d73f..911989bb4f7 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -59,6 +59,14 @@
 # @CPU_POLARIZATION_CHANGE:
 #     Emitted when the guest asks to change the polarization.
 #
+# @polarization: polarization specified by the guest
+#
+# Features:
+#
+# @unstable: This event is experimental.
+#
+# Since: 8.2
+#
 # The guest can tell the host (via the PTF instruction) whether the
 # CPUs should be provisioned using horizontal or vertical
 # polarization.
@@ -70,14 +78,6 @@
 # differently.  The guest will get information on the details of the
 # provisioning the next time it uses the STSI(15) instruction.
 #
-# @polarization: polarization specified by the guest
-#
-# Features:
-#
-# @unstable: This event is experimental.
-#
-# Since: 8.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "CPU_POLARIZATION_CHANGE",
diff --git a/qapi/machine.json b/qapi/machine.json
index 911132918bd..8aae66fcfde 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -645,9 +645,6 @@
 #     Bandwidth Information Structure of HMAT (Heterogeneous Memory
 #     Attribute Table)
 #
-# For more information about `HmatLBMemoryHierarchy`, see chapter
-# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
-#
 # @memory: the structure represents the memory performance
 #
 # @first-level: first level of memory side cache
@@ -656,6 +653,9 @@
 #
 # @third-level: third level of memory side cache
 #
+# For more information about `HmatLBMemoryHierarchy`, see chapter
+# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
+#
 # Since: 5.0
 ##
 { 'enum': 'HmatLBMemoryHierarchy',
@@ -667,9 +667,6 @@
 #     Information Structure of HMAT (Heterogeneous Memory Attribute
 #     Table)
 #
-# For more information about `HmatLBDataType`, see chapter 5.2.27.4:
-# Table 5-146: Field "Data Type" of ACPI 6.3 spec.
-#
 # @access-latency: access latency (nanoseconds)
 #
 # @read-latency: read latency (nanoseconds)
@@ -682,6 +679,9 @@
 #
 # @write-bandwidth: write bandwidth (Bytes per second)
 #
+# For more information about `HmatLBDataType`, see chapter 5.2.27.4:
+# Table 5-146: Field "Data Type" of ACPI 6.3 spec.
+#
 # Since: 5.0
 ##
 { 'enum': 'HmatLBDataType',
@@ -693,9 +693,6 @@
 #     Set the system locality latency and bandwidth information
 #     between Initiator and Target proximity Domains.
 #
-# For more information about `NumaHmatLBOptions`, see chapter
-# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
-#
 # @initiator: the Initiator Proximity Domain.
 #
 # @target: the Target Proximity Domain.
@@ -712,6 +709,9 @@
 # @bandwidth: the value of bandwidth between @initiator and @target
 #     proximity domain, the bandwidth unit is "Bytes per second".
 #
+# For more information about `NumaHmatLBOptions`, see chapter
+# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
+#
 # Since: 5.0
 ##
 { 'struct': 'NumaHmatLBOptions',
@@ -728,9 +728,6 @@
 #     Cache associativity in the Memory Side Cache Information
 #     Structure of HMAT
 #
-# For more information of `HmatCacheAssociativity`, see chapter
-# 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
-#
 # @none: None (no memory side cache in this proximity domain, or cache
 #     associativity unknown)
 #
@@ -738,6 +735,9 @@
 #
 # @complex: Complex Cache Indexing (implementation specific)
 #
+# For more information of `HmatCacheAssociativity`, see chapter
+# 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
+#
 # Since: 5.0
 ##
 { 'enum': 'HmatCacheAssociativity',
@@ -748,9 +748,6 @@
 #     Cache write policy in the Memory Side Cache Information
 #     Structure of HMAT
 #
-# For more information of `HmatCacheWritePolicy`, see chapter
-# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
-#
 # @none: None (no memory side cache in this proximity domain, or cache
 #     write policy unknown)
 #
@@ -758,6 +755,9 @@
 #
 # @write-through: Write Through (WT)
 #
+# For more information of `HmatCacheWritePolicy`, see chapter
+# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+#
 # Since: 5.0
 ##
 { 'enum': 'HmatCacheWritePolicy',
@@ -767,9 +767,6 @@
 # @NumaHmatCacheOptions:
 #     Set the memory side cache information for a given memory domain.
 #
-# For more information of `NumaHmatCacheOptions`, see chapter
-# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
-#
 # @node-id: the memory proximity domain to which the memory belongs.
 #
 # @size: the size of memory side cache in bytes.
@@ -783,6 +780,9 @@
 #
 # @line: the cache line size in bytes.
 #
+# For more information of `NumaHmatCacheOptions`, see chapter
+# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+#
 # Since: 5.0
 ##
 { 'struct': 'NumaHmatCacheOptions',
@@ -932,15 +932,6 @@
 # @CpuInstanceProperties:
 #     Properties identifying a CPU.
 #
-# Which members are optional and which mandatory depends on the
-# architecture and board.
-#
-# For s390x see :ref:`cpu-topology-s390x`.
-#
-# The ids other than the node-id specify the position of the CPU
-# within the CPU topology (as defined by the machine property "smp",
-# thus see also type `SMPConfiguration`)
-#
 # @node-id: NUMA node ID the CPU belongs to
 #
 # @drawer-id: drawer number within CPU topology the CPU belongs to
@@ -964,6 +955,15 @@
 #
 # @thread-id: thread number within the core the CPU  belongs to
 #
+# Which members are optional and which mandatory depends on the
+# architecture and board.
+#
+# For s390x see :ref:`cpu-topology-s390x`.
+#
+# The ids other than the node-id specify the position of the CPU
+# within the CPU topology (as defined by the machine property "smp",
+# thus see also type `SMPConfiguration`)
+#
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
@@ -1635,18 +1635,6 @@
 #     QEMU figure out a suitable value based on the ones that are
 #     provided.
 #
-# The members other than @cpus and @maxcpus define a topology of
-# containers.
-#
-# The ordering from highest/coarsest to lowest/finest is: @drawers,
-# @books, @sockets, @dies, @clusters, @cores, @threads.
-#
-# Different architectures support different subsets of topology
-# containers.
-#
-# For example, s390x does not have clusters and dies, and the socket
-# is the parent container of cores.
-#
 # @cpus: number of virtual CPUs in the virtual machine
 #
 # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
@@ -1668,6 +1656,18 @@
 #
 # @threads: number of threads per core
 #
+# The members other than @cpus and @maxcpus define a topology of
+# containers.
+#
+# The ordering from highest/coarsest to lowest/finest is: @drawers,
+# @books, @sockets, @dies, @clusters, @cores, @threads.
+#
+# Different architectures support different subsets of topology
+# containers.
+#
+# For example, s390x does not have clusters and dies, and the socket
+# is the parent container of cores.
+#
 # Since: 6.1
 ##
 { 'struct': 'SMPConfiguration', 'data': {
@@ -1894,16 +1894,16 @@
 # @CpuModelInfo:
 #     Virtual CPU model.
 #
+# @name: the name of the CPU definition the model is based on
+#
+# @props: a dictionary of QOM properties to be applied
+#
 # A CPU model consists of the name of a CPU definition, to which delta
 # changes are applied (e.g. features added/removed).  Most magic
 # values that an architecture might require should be hidden behind
 # the name.  However, if required, architectures can expose relevant
 # properties.
 #
-# @name: the name of the CPU definition the model is based on
-#
-# @props: a dictionary of QOM properties to be applied
-#
 # Since: 2.8
 ##
 { 'struct': 'CpuModelInfo',
@@ -2004,6 +2004,21 @@
 #     Compares two CPU models, @modela and @modelb, returning how they
 #     compare in a specific configuration.
 #
+# @modela: description of the first CPU model to compare, referred to
+#     as "model A" in `CpuModelCompareResult`
+#
+# @modelb: description of the second CPU model to compare, referred to
+#     as "model B" in `CpuModelCompareResult`
+#
+# Returns: a `CpuModelCompareInfo` describing how both CPU models
+#     compare
+#
+# Errors:
+#     - if comparing CPU models is not supported by the target
+#     - if a model cannot be used
+#     - if a model contains an unknown cpu definition name, unknown
+#       properties or properties with wrong types.
+#
 # The results indicates how both models compare regarding runnability.
 # This result can be used by tooling to make decisions if a certain
 # CPU model will run in a certain configuration or if a compatible CPU
@@ -2034,21 +2049,6 @@
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
 #
-# @modela: description of the first CPU model to compare, referred to
-#     as "model A" in `CpuModelCompareResult`
-#
-# @modelb: description of the second CPU model to compare, referred to
-#     as "model B" in `CpuModelCompareResult`
-#
-# Returns: a `CpuModelCompareInfo` describing how both CPU models
-#     compare
-#
-# Errors:
-#     - if comparing CPU models is not supported by the target
-#     - if a model cannot be used
-#     - if a model contains an unknown cpu definition name, unknown
-#       properties or properties with wrong types.
-#
 # Since: 2.8
 ##
 { 'command': 'query-cpu-model-comparison',
@@ -2062,6 +2062,18 @@
 #     static, migration-safe CPU model (see "static" CPU model
 #     expansion for details).
 #
+# @modela: description of the first CPU model to baseline
+#
+# @modelb: description of the second CPU model to baseline
+#
+# Returns: a `CpuModelBaselineInfo` describing the baselined CPU model
+#
+# Errors:
+#     - if baselining CPU models is not supported by the target
+#     - if a model cannot be used
+#     - if a model contains an unknown cpu definition name, unknown
+#       properties or properties with wrong types.
+#
 # This interface can be used by tooling to create a compatible CPU
 # model out two CPU models.  The created CPU model will be identical
 # to or a subset of both CPU models when comparing them.  Therefore,
@@ -2088,18 +2100,6 @@
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
 #
-# @modela: description of the first CPU model to baseline
-#
-# @modelb: description of the second CPU model to baseline
-#
-# Returns: a `CpuModelBaselineInfo` describing the baselined CPU model
-#
-# Errors:
-#     - if baselining CPU models is not supported by the target
-#     - if a model cannot be used
-#     - if a model contains an unknown cpu definition name, unknown
-#       properties or properties with wrong types.
-#
 # Since: 2.8
 ##
 { 'command': 'query-cpu-model-baseline',
@@ -2134,28 +2134,6 @@
 #     what a specific CPU model looks like in QEMU under a certain
 #     configuration.
 #
-# This interface can be used to query the "host" CPU model.
-#
-# The data returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU
-#   version.  (Except for CPU models reported as "static" in
-#   `query-cpu-definitions`.)
-# * machine-type: CPU model may look different depending on the
-#   machine-type.  (Except for CPU models reported as "static" in
-#   `query-cpu-definitions`.)
-# * machine options (including accelerator): in some architectures,
-#   CPU models may look different depending on machine and accelerator
-#   options.  (Except for CPU models reported as "static" in
-#   `query-cpu-definitions`.)
-# * "-cpu" arguments and global properties: arguments to the -cpu
-#   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not
-#   advised.
-#
-# Some architectures may not support all expansion types.  s390x
-# supports "full" and "static".  Arm only supports "full".
-#
 # @model: description of the CPU model to expand
 #
 # @type: expansion type, specifying how to expand the CPU model
@@ -2169,6 +2147,28 @@
 #       properties or properties with a wrong type
 #     - if an expansion type is not supported
 #
+# This interface can be used to query the "host" CPU model.
+#
+# The data returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU
+#   version.  (Except for CPU models reported as "static" in
+#   `query-cpu-definitions`.)
+# * machine-type: CPU model may look different depending on the
+#   machine-type.  (Except for CPU models reported as "static" in
+#   `query-cpu-definitions`.)
+# * machine options (including accelerator): in some architectures,
+#   CPU models may look different depending on machine and accelerator
+#   options.  (Except for CPU models reported as "static" in
+#   `query-cpu-definitions`.)
+# * "-cpu" arguments and global properties: arguments to the -cpu
+#   option and global properties may affect expansion of CPU models.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
+#
+# Some architectures may not support all expansion types.  s390x
+# supports "full" and "static".  Arm only supports "full".
+#
 # Since: 2.8
 ##
 { 'command': 'query-cpu-model-expansion',
diff --git a/qapi/migration.json b/qapi/migration.json
index 8d3951ae429..927942910d0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1830,6 +1830,28 @@
 #     retrieved with `query-dirty-rate` after measurements are
 #     completed.
 #
+# @calc-time: time period for which dirty page rate is calculated.  By
+#     default it is specified in seconds, but the unit can be set
+#     explicitly with @calc-time-unit.  Note that larger @calc-time
+#     values will typically result in smaller dirty page rates because
+#     page dirtying is a one-time event.  Once some page is counted as
+#     dirty during @calc-time period, further writes to this page will
+#     not increase dirty page rate anymore.
+#
+# @calc-time-unit: time unit in which @calc-time is specified.  By
+#     default it is seconds.  (Since 8.2)
+#
+# @sample-pages: number of sampled pages per each GiB of guest memory.
+#     Default value is 512.  For 4KiB guest pages this corresponds to
+#     sampling ratio of 0.2%.  This argument is used only in page
+#     sampling mode.  (Since 6.1)
+#
+# @mode: mechanism for tracking dirty pages.  Default value is
+#     'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
+#     (Since 6.1)
+#
+# Since: 5.2
+#
 # Dirty page rate is the number of pages changed in a given time
 # period expressed in MiB/s.  The following methods of calculation are
 # available:
@@ -1855,28 +1877,6 @@
 #    This mode tracks page modification per each vCPU separately.  It
 #    requires that KVM accelerator property "dirty-ring-size" is set.
 #
-# @calc-time: time period for which dirty page rate is calculated.  By
-#     default it is specified in seconds, but the unit can be set
-#     explicitly with @calc-time-unit.  Note that larger @calc-time
-#     values will typically result in smaller dirty page rates because
-#     page dirtying is a one-time event.  Once some page is counted as
-#     dirty during @calc-time period, further writes to this page will
-#     not increase dirty page rate anymore.
-#
-# @calc-time-unit: time unit in which @calc-time is specified.  By
-#     default it is seconds.  (Since 8.2)
-#
-# @sample-pages: number of sampled pages per each GiB of guest memory.
-#     Default value is 512.  For 4KiB guest pages this corresponds to
-#     sampling ratio of 0.2%.  This argument is used only in page
-#     sampling mode.  (Since 6.1)
-#
-# @mode: mechanism for tracking dirty pages.  Default value is
-#     'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
-#     (Since 6.1)
-#
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
@@ -1947,16 +1947,16 @@
 # @set-vcpu-dirty-limit:
 #     Set the upper limit of dirty page rate for virtual CPUs.
 #
+# @cpu-index: index of a virtual CPU, default is all.
+#
+# @dirty-rate: upper limit of dirty page rate (MB/s) for virtual CPUs.
+#
+# Since: 7.1
+#
 # Requires KVM with accelerator property "dirty-ring-size" set.  A
 # virtual CPU's dirty page rate is a measure of its memory load.  To
 # observe dirty page rates, use `calc-dirty-rate`.
 #
-# @cpu-index: index of a virtual CPU, default is all.
-#
-# @dirty-rate: upper limit of dirty page rate (MB/s) for virtual CPUs.
-#
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     -> {"execute": "set-vcpu-dirty-limit"}
@@ -1972,14 +1972,14 @@
 # @cancel-vcpu-dirty-limit:
 #     Cancel the upper limit of dirty page rate for virtual CPUs.
 #
+# @cpu-index: index of a virtual CPU, default is all.
+#
+# Since: 7.1
+#
 # Cancel the dirty page limit for the vCPU which has been set with
 # `set-vcpu-dirty-limit` command.  Note that this command requires
 # support from dirty ring, same as the `set-vcpu-dirty-limit`.
 #
-# @cpu-index: index of a virtual CPU, default is all.
-#
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     -> {"execute": "cancel-vcpu-dirty-limit"},
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 6e0ab46b8ea..52ab5a6389a 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -149,10 +149,6 @@
 # @query-sev-launch-measure:
 #     Query the SEV/SEV-ES guest launch information.
 #
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object.  The launch
-# measurement for SEV-SNP guests is only available within the guest.
-#
 # Returns: The guest's SEV guest launch measurement info
 #
 # Errors:
@@ -162,6 +158,10 @@
 #
 # Since: 2.12
 #
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  The launch
+# measurement for SEV-SNP guests is only available within the guest.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev-launch-measure" }
@@ -198,13 +198,13 @@
 # @query-sev-capabilities:
 #     Get SEV capabilities.
 #
-# This is only supported on AMD X86 platforms with KVM enabled.
-#
 # Errors:
 #     - If SEV is not available on the platform, GenericError
 #
 # Since: 2.12
 #
+# This is only supported on AMD X86 platforms with KVM enabled.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev-capabilities" }
@@ -218,10 +218,6 @@
 # @sev-inject-launch-secret:
 #     Inject a secret blob into a SEV/SEV-ES guest's memory.
 #
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object.  SEV-SNP guests do
-# not support launch secret injection.
-#
 # @packet-header: the launch secret packet header encoded in base64
 #
 # @secret: the launch secret data to be injected encoded in base64
@@ -233,6 +229,10 @@
 #       an invalid guest configuration, or if the guest has not
 #       reached the required SEV state, GenericError
 #
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  SEV-SNP guests do
+# not support launch secret injection.
+#
 # Since: 6.0
 ##
 { 'command': 'sev-inject-launch-secret',
@@ -254,10 +254,6 @@
 # @query-sev-attestation-report:
 #     Get the SEV attestation report.
 #
-# This is only valid on x86 machines configured with KVM and the
-# 'sev-guest' confidential virtualization object.  The attestation
-# report for SEV-SNP guests is only available within the guest.
-#
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
@@ -268,6 +264,10 @@
 #
 # Since: 6.1
 #
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  The attestation
+# report for SEV-SNP guests is only available within the guest.
+#
 # .. qmp-example::
 #
 #     -> { "execute" : "query-sev-attestation-report",
diff --git a/qapi/misc.json b/qapi/misc.json
index 6a96ece6d91..228d1cc1cd7 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -15,9 +15,6 @@
 #     Allow client connections for VNC, Spice and socket based
 #     character devices to be passed in to QEMU via SCM_RIGHTS.
 #
-# If the FD associated with @fdname is not a socket, the command will
-# fail and the FD will be closed.
-#
 # @protocol: protocol name.  Valid names are "vnc", "spice",
 #     "@dbus-display" or the name of a character device (e.g. from
 #     -chardev id=XXXX)
@@ -31,6 +28,9 @@
 #
 # Since: 0.14
 #
+# If the FD associated with @fdname is not a socket, the command will
+# fail and the FD will be closed.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
@@ -104,14 +104,14 @@
 # @query-iothreads:
 #     Return a list of information about each iothread.
 #
+# Returns: a list of info for each iothread
+#
+# Since: 2.0
+#
 # .. note:: This list excludes the QEMU main loop thread, which is not
 #    declared using the ``-object iothread`` command-line option.  It
 #    is always the main thread of the process.
 #
-# Returns: a list of info for each iothread
-#
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-iothreads" }
@@ -186,18 +186,18 @@
 # @x-exit-preconfig:
 #     Exit from "preconfig" state
 #
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 3.0
+#
 # This command makes QEMU exit the preconfig state and proceed with VM
 # initialization using configuration data provided on the command line
 # and via the QMP monitor during the preconfig state.  The command is
 # only available during the preconfig state (i.e. when the --preconfig
 # command line option was in use).
 #
-# Features:
-#
-# @unstable: This command is experimental.
-#
-# Since: 3.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-exit-preconfig" }
diff --git a/qapi/net.json b/qapi/net.json
index 376cd01cb6a..e760b0e84d5 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -39,13 +39,13 @@
 # @netdev_add:
 #     Add a network backend.
 #
-# Additional arguments depend on the type.
-#
 # Since: 0.14
 #
 # Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
+# Additional arguments depend on the type.
+#
 # .. qmp-example::
 #
 #     -> { "execute": "netdev_add",
diff --git a/qapi/qdev.json b/qapi/qdev.json
index f390354d68e..a3fb6a28d94 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -167,16 +167,16 @@
 #     the guest part (frontend).  Then notify guest software that
 #     device configuration changed.
 #
+# @id: the device's ID or QOM path
+#
+# Features:
+#
+# @unstable: The command is experimental.
+#
 # The command may be used to notify the guest about block device
 # capacity change.  Currently only vhost-user-blk device supports
 # this.
 #
-# @id: the device's ID or QOM path
-#
-# Features:
-#
-# @unstable: The command is experimental.
-#
 # Since: 9.2
 ##
 { 'command': 'device-sync-config',
diff --git a/qapi/qom.json b/qapi/qom.json
index 8d626797819..286fb987317 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -467,9 +467,6 @@
 # @FilterRedirectorProperties:
 #     Properties for filter-redirector objects.
 #
-# At least one of @indev or @outdev must be present.  If both are
-# present, they must not refer to the same character device backend.
-#
 # @indev: the name of a character device backend from which packets
 #     are received and redirected to the filtered network device
 #
@@ -479,6 +476,9 @@
 # @vnet_hdr_support: if true, vnet header support is enabled
 #     (default: false)
 #
+# At least one of @indev or @outdev must be present.  If both are
+# present, they must not refer to the same character device backend.
+#
 # Since: 2.6
 ##
 { 'struct': 'FilterRedirectorProperties',
@@ -1040,16 +1040,6 @@
 ##
 # @SevSnpGuestProperties:
 #
-# Properties for sev-snp-guest objects.  Most of these are direct
-# arguments for the KVM_SNP_* interfaces documented in the Linux
-# kernel source under
-# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
-# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
-# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
-#
-# More usage information is also available in the QEMU source tree
-# under docs/amd-memory-encryption.
-#
 # @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
 #     defined in the SEV-SNP firmware ABI (default: 0x30000)
 #
@@ -1086,6 +1076,16 @@
 # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
 #     is enabled (default: zero) (since 11.1)
 #
+# Properties for sev-snp-guest objects.  Most of these are direct
+# arguments for the KVM_SNP_* interfaces documented in the Linux
+# kernel source under
+# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
+# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
+# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
+#
+# More usage information is also available in the QEMU source tree
+# under docs/amd-memory-encryption.
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
diff --git a/qapi/stats.json b/qapi/stats.json
index e9d05390c31..a4e4b0fa50b 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -178,12 +178,12 @@
 #     Return runtime-collected statistics for objects such as the VM
 #     or its vCPUs.
 #
-# The arguments are a `StatsFilter` and specify the provider and
-# objects to return statistics about.
-#
 # Returns: a list of statistics, one for each provider and object
 #     (e.g., for each vCPU).
 #
+# The arguments are a `StatsFilter` and specify the provider and
+# objects to return statistics about.
+#
 # Since: 7.1
 ##
 { 'command': 'query-stats',
diff --git a/qapi/transaction.json b/qapi/transaction.json
index daecf843c90..68df2df44ac 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -201,6 +201,23 @@
 #     If any operation fails, then the entire set of actions will be
 #     abandoned and the appropriate error returned.
 #
+# @actions: List of `TransactionAction`; information needed for the
+#     respective operations.
+#
+# @properties: structure of additional options to control the
+#     execution of the transaction.  See `TransactionProperties` for
+#     additional detail.
+#
+# Errors:
+#     - Any errors from commands in the transaction
+#
+# .. note:: The transaction aborts on the first failure.  Therefore,
+#    there will be information on only one failed operation returned
+#    in an error condition, and subsequent actions will not have been
+#    attempted.
+#
+# Since: 1.1
+#
 # For external snapshots, the dictionary contains the device, the file
 # to use for the new snapshot, and the format.  The default format, if
 # not specified, is qcow2.
@@ -224,23 +241,6 @@
 # in the transaction.  When an I/O error occurs during deletion, the
 # user needs to fix it later with qemu-img or other command.
 #
-# @actions: List of `TransactionAction`; information needed for the
-#     respective operations.
-#
-# @properties: structure of additional options to control the
-#     execution of the transaction.  See `TransactionProperties` for
-#     additional detail.
-#
-# Errors:
-#     - Any errors from commands in the transaction
-#
-# .. note:: The transaction aborts on the first failure.  Therefore,
-#    there will be information on only one failed operation returned
-#    in an error condition, and subsequent actions will not have been
-#    attempted.
-#
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "transaction",
diff --git a/qapi/ui.json b/qapi/ui.json
index 9e3e80a3d70..51e276baba4 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1199,6 +1199,15 @@
 # @input-send-event:
 #     Send input event(s) to guest.
 #
+# @device: display device to send event(s) to.
+#
+# @head: head to send event(s) to, in case the display device supports
+#     multiple scanouts.
+#
+# @events: List of `InputEvent` union.
+#
+# Since: 2.6
+#
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
 # same kind are added to the virtual machine and (b) you have
@@ -1210,15 +1219,6 @@
 # are admissible, but devices with input routing config take
 # precedence.
 #
-# @device: display device to send event(s) to.
-#
-# @head: head to send event(s) to, in case the display device supports
-#     multiple scanouts.
-#
-# @events: List of `InputEvent` union.
-#
-# Since: 2.6
-#
 # .. note:: The consoles are visible in the qom tree, under
 #    ``/backend/console[$index]``.  They have a device link and head
 #    property, so it is possible to map which console belongs to which
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 05fe4ea484d..8efed573367 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -51,6 +51,10 @@
 #     Echo back a unique integer value, and prepend to response a
 #     leading sentinel byte (0xFF) the client can check scan for.
 #
+# @id: randomly generated 64-bit integer
+#
+# Returns: The unique integer id passed in by the client
+#
 # This is used by clients talking to the guest agent over the wire to
 # ensure the stream is in sync and doesn't contain stale data from
 # previous client.  It must be issued upon initial connection, and
@@ -70,10 +74,6 @@
 # byte to make sure the guest agent flushes any partially read JSON
 # data from a previous client connection.
 #
-# @id: randomly generated 64-bit integer
-#
-# Returns: The unique integer id passed in by the client
-#
 # Since: 1.1
 ##
 { 'command': 'guest-sync-delimited',
@@ -84,6 +84,10 @@
 # @guest-sync:
 #     Echo back a unique integer value
 #
+# @id: randomly generated 64-bit integer
+#
+# Returns: The unique integer id passed in by the client
+#
 # This is used by clients talking to the guest agent over the wire to
 # ensure the stream is in sync and doesn't contain stale data from
 # previous client.  All guest agent responses should be ignored until
@@ -106,10 +110,6 @@
 # make sure the guest agent flushes any partially read JSON data from
 # a previous session.
 #
-# @id: randomly generated 64-bit integer
-#
-# Returns: The unique integer id passed in by the client
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-sync',
@@ -140,6 +140,9 @@
 # @guest-set-time:
 #     Set guest time.
 #
+# @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
+#     UTC.
+#
 # When a guest is paused or migrated to a file then loaded from that
 # file, the guest OS has no idea that there was a big gap in the time.
 # Depending on how long the gap was, NTP might not be able to
@@ -153,9 +156,6 @@
 # Windows).  If that's the case users are advised to always pass a
 # value.
 #
-# @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
-#     UTC.
-#
 # Since: 1.5
 ##
 { 'command': 'guest-set-time',
@@ -526,6 +526,9 @@
 # @guest-suspend-disk:
 #     Suspend guest to disk.
 #
+# Errors:
+#     - If suspend to disk is not supported, Unsupported
+#
 # This command attempts to suspend the guest using three strategies,
 # in this order:
 #
@@ -540,9 +543,6 @@
 # VM could also exit (or set its status to "shutdown") due to other
 # reasons.
 #
-# Errors:
-#     - If suspend to disk is not supported, Unsupported
-#
 # .. note:: It's strongly recommended to issue the `guest-sync`
 #    command before sending commands when the guest resumes.
 #
@@ -555,33 +555,33 @@
 # @guest-suspend-ram:
 #     Suspend guest to ram.
 #
-# This command attempts to suspend the guest using three strategies,
-# in this order:
-#
-# - systemd hibernate
-# - pm-utils (via pm-hibernate)
-# - manual write into sysfs
-#
-# IMPORTANT: `guest-suspend-ram` requires working wakeup support in
-# QEMU.  You should check QMP command `query-current-machine` returns
-# wakeup-suspend-support: true before issuing this command.  Failure
-# in doing so can result in a suspended guest that QEMU will not be
-# able to awaken, forcing the user to power cycle the guest to bring
-# it back.
-#
-# This command does NOT return a response on success.  There are two
-# options to check for success:
-#
-# 1. Wait for the `SUSPEND` QMP event from QEMU
-# 2. Issue the `query-status` QMP command to confirm the VM status is
-#    "suspended"
-#
 # Errors:
 #     - If suspend to ram is not supported, Unsupported
 #
 # .. note:: It's strongly recommended to issue the `guest-sync`
 #    command before sending commands when the guest resumes.
 #
+# This command attempts to suspend the guest using three strategies,
+# in this order:
+#
+# - systemd hibernate
+# - pm-utils (via pm-hibernate)
+# - manual write into sysfs
+#
+# IMPORTANT: `guest-suspend-ram` requires working wakeup support in
+# QEMU.  You should check QMP command `query-current-machine` returns
+# wakeup-suspend-support: true before issuing this command.  Failure
+# in doing so can result in a suspended guest that QEMU will not be
+# able to awaken, forcing the user to power cycle the guest to bring
+# it back.
+#
+# This command does NOT return a response on success.  There are two
+# options to check for success:
+#
+# 1. Wait for the `SUSPEND` QMP event from QEMU
+# 2. Issue the `query-status` QMP command to confirm the VM status is
+#    "suspended"
+#
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-ram', 'success-response': false,
@@ -591,6 +591,9 @@
 # @guest-suspend-hybrid:
 #     Save guest state to disk and suspend to ram.
 #
+# Errors:
+#     - If hybrid suspend is not supported, Unsupported
+#
 # This command attempts to suspend the guest by executing, in this
 # order:
 #
@@ -611,9 +614,6 @@
 # 2. Issue the `query-status` QMP command to confirm the VM status is
 #    "suspended"
 #
-# Errors:
-#     - If hybrid suspend is not supported, Unsupported
-#
 # .. note:: It's strongly recommended to issue the `guest-sync`
 #    command before sending commands when the guest resumes.
 #
@@ -1807,13 +1807,13 @@
 # @guest-get-load:
 #     Retrieve CPU process load information
 #
+# Returns: load information
+#
 # .. note:: Windows does not have load average API, so QGA emulates it
 #    by calculating the average CPU usage in the last 1, 5, 15 minutes
 #    similar as Linux does this.  Calculation starts from the first
 #    time this command is called.
 #
-# Returns: load information
-#
 # Since: 10.0
 ##
 { 'command': 'guest-get-load',
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 50e4fdb54d1..89a548e1a8d 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -98,11 +98,11 @@
 #
 #     Another paragraph
 #
-# @var1 is undocumented
-#
 # Features:
 # @variant1-feat: a feature
 # @member-feat: a member feature
+#
+# @var1 is undocumented
 ##
 { 'struct': 'Variant1',
   'features': [ 'variant1-feat' ],
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 3858bfa861d..7a485e46037 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -131,12 +131,12 @@ doc symbol=Variant1
     Another paragraph
     Member=var1
 
-    Details
-@var1 is undocumented
     Feature=variant1-feat
 a feature
     Feature=member-feat
 a member feature
+    Details
+@var1 is undocumented
 doc symbol=Variant2
     Intro
 
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 1f8274ef1f3..e08b838f3fb 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -68,13 +68,13 @@ Object Variant1
    Members:
       * **var1** ("string") -- Not documented
 
-   "var1" is undocumented
-
    Features:
       * **variant1-feat** -- a feature
 
       * **member-feat** -- a member feature
 
+   "var1" is undocumented
+
 Object Variant2
 
 Object Object
-- 
2.55.0


