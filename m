Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B80F53D85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CfP-0002pR-OK; Mon, 16 Mar 2026 14:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CfD-0002WO-5P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Cf7-00080u-S2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfxzquQJshLYiRytIJeCBQUw3IMM2Rr8wzZIp0rCT4E=;
 b=JrFze8H6PgbnOPvIDvwjf+E+Xf4MfyD5ws9nPOoEt0pEu6ZExYB5HDljOA/yLbqc+ON9Je
 8bf2rHvg7FTwOi3HG1HaOd4TeHSshrLaTiiC+gjkogFmWJU7e+pRBFC/CXHTNryfJ57MnH
 Uxjb4DMROynjzohHGHl5/OC43HXZYnc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-cFMugMTWOx6rpdWQpTQKvw-1; Mon,
 16 Mar 2026 14:27:27 -0400
X-MC-Unique: cFMugMTWOx6rpdWQpTQKvw-1
X-Mimecast-MFC-AGG-ID: cFMugMTWOx6rpdWQpTQKvw_1773685644
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6D191956046; Mon, 16 Mar 2026 18:27:24 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABBCB30001A2; Mon, 16 Mar 2026 18:27:14 +0000 (UTC)
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
Subject: [PATCH 7/8] qapi: re-order 'since' sections to always be last
Date: Mon, 16 Mar 2026 14:26:06 -0400
Message-ID: <20260316182608.148628-8-jsnow@redhat.com>
In-Reply-To: <20260316182608.148628-1-jsnow@redhat.com>
References: <20260316182608.148628-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Note that with "Since" being moved to the last position, we open up a
good many new cases of ambiguos intro-vs-details text which must be
corrected with "Details:" tags.

This patch doesn't only add these markers where it would definitively
impact inlining - it adds them to *any* doc block that has more than one
paragraph of plaintext and no other distinguishing features (members,
features, errors, returns).

It may well be the case that not every last one of these *needs* to be
amended in this way, but this is the broad coverage shotgun approach
that demonstrates which places in the code may cause footguns with
regards to automated stub insertions of members/arguments/etc, returns,
or inlining order ambiguities.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/firmware.json   |   4 +-
 docs/interop/vhost-user.json |   3 +-
 qapi/accelerator.json        |   8 +--
 qapi/acpi.json               |   8 ++-
 qapi/block-core.json         | 136 ++++++++++++++++++-----------------
 qapi/block.json              |  40 +++++------
 qapi/char.json               |  36 +++++-----
 qapi/control.json            |  14 ++--
 qapi/dump.json               |  16 ++---
 qapi/machine-s390x.json      |   8 +--
 qapi/machine.json            |  86 ++++++++++++----------
 qapi/migration.json          |  94 ++++++++++++------------
 qapi/misc-arm.json           |   6 +-
 qapi/misc-i386.json          |  40 ++++++-----
 qapi/misc.json               |  64 +++++++++--------
 qapi/net.json                |  40 +++++------
 qapi/pci.json                |   4 +-
 qapi/qdev.json               |  12 ++--
 qapi/qom.json                |  20 +++---
 qapi/replay.json             |  16 +++--
 qapi/rocker.json             |  16 ++---
 qapi/run-state.json          |  66 ++++++++++-------
 qapi/tpm.json                |  12 ++--
 qapi/trace.json              |   8 +--
 qapi/transaction.json        |   4 +-
 qapi/ui.json                 |  76 +++++++++++---------
 qapi/vfio.json               |   4 +-
 qapi/virtio.json             |  20 +++---
 28 files changed, 463 insertions(+), 398 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5ed..bdfb6ccb717 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -551,8 +551,6 @@
 #     debugging purposes only, and management software shall
 #     explicitly ignore it.
 #
-# Since: 3.0
-#
 # .. qmp-example::
 #
 #     {
@@ -752,6 +750,8 @@
 #             "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
 #         ]
 #     }
+#
+# Since: 3.0
 ##
 { 'struct' : 'Firmware',
   'data'   : { 'description'     : 'str',
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index 29c84e86e55..fbcf409838d 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -264,8 +264,6 @@
 #     development and debugging purposes only, and management software
 #     shall explicitly ignore it.
 #
-# Since: 4.0
-#
 # .. qmp-example:
 #
 # {
@@ -278,6 +276,7 @@
 #   ]
 # }
 #
+# Since: 4.0
 ##
 {
   'struct' : 'VhostUserBackend',
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index d333a772384..5624b5d88b7 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -29,12 +29,12 @@
 #
 # Return information about KVM acceleration
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-kvm" }
 #     <- { "return": { "enabled": true, "present": true } }
+#
+# Since: 0.14
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
@@ -101,11 +101,11 @@
 #
 # Returns: @AcceleratorInfo
 #
-# Since: 10.2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-accelerators" }
 #     <- { "return": { "enabled": "mshv", "present": ["kvm", "mshv", "qtest", "tcg"] } }
+#
+# Since: 10.2.0
 ##
 { 'command': 'query-accelerators', 'returns': 'AcceleratorInfo' }
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a55..8dd87fd8f22 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -111,7 +111,7 @@
 # Return a list of `ACPIOSTInfo` for devices that support status
 # reporting via ACPI _OST method.
 #
-# Since: 2.1
+# Details:
 #
 # .. qmp-example::
 #
@@ -121,6 +121,8 @@
 #                      { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
 #                      { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
 #        ]}
+#
+# Since: 2.1
 ##
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
@@ -131,14 +133,14 @@
 #
 # @info: OSPM Status Indication
 #
-# Since: 2.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "ACPI_DEVICE_OST",
 #          "data": { "info": { "device": "d1", "slot": "0",
 #                              "slot-type": "DIMM", "source": 1, "status": 0 } },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 2.1
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index dc97bcb9b66..a979b79fdc2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -862,8 +862,6 @@
 # Returns: a list describing each virtual block device.  Filter nodes
 #     that were created implicitly are skipped over.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-block" }
@@ -947,6 +945,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
   'data': { '*flat': 'bool' },
@@ -1267,8 +1267,6 @@
 #
 # Returns: A list of statistics for each virtual block device.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-blockstats" }
@@ -1370,6 +1368,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-blockstats',
   'data': { '*query-nodes': 'bool' },
@@ -1560,13 +1560,13 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block_resize",
 #          "arguments": { "device": "scratch", "size": 1073741824 } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'block_resize',
   'data': { '*device': 'str',
@@ -1788,8 +1788,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-sync",
@@ -1798,6 +1796,8 @@
 #                         "/some/place/my-image",
 #                         "format": "qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'blockdev-snapshot-sync',
   'data': 'BlockdevSnapshotSync',
@@ -1820,8 +1820,6 @@
 #     backing file of a destination of a `blockdev-mirror`.
 #     (since 5.0)
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -1837,6 +1835,8 @@
 #          "arguments": { "node": "ide-hd0",
 #                         "overlay": "node1534" } }
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-snapshot',
   'data': 'BlockdevSnapshot',
@@ -1963,14 +1963,14 @@
 # @deprecated: Members @base and @top are deprecated.  Use @base-node
 #     and @top-node instead.
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-commit",
 #          "arguments": { "device": "virtio0",
 #                         "top": "/tmp/snap1.qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
@@ -2001,8 +2001,6 @@
 # @deprecated: This command is deprecated.  Use `blockdev-backup`
 #     instead.
 #
-# Since: 1.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "drive-backup",
@@ -2010,6 +2008,8 @@
 #                         "sync": "full",
 #                         "target": "backup.img" } }
 #     <- { "return": {} }
+#
+# Since: 1.6
 ##
 { 'command': 'drive-backup', 'boxed': true,
   'data': 'DriveBackup', 'features': ['deprecated'],
@@ -2027,8 +2027,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 2.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-backup",
@@ -2036,6 +2034,8 @@
 #                         "sync": "full",
 #                         "target": "tgt-id" } }
 #     <- { "return": {} }
+#
+# Since: 2.3
 ##
 { 'command': 'blockdev-backup', 'boxed': true,
   'data': 'BlockdevBackup',
@@ -2049,8 +2049,6 @@
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-named-block-nodes" }
@@ -2099,6 +2097,8 @@
 #                               "virtual-size":2048000
 #                           }
 #                        } } ] }
+#
+# Since: 2.0
 ##
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
@@ -2230,8 +2230,6 @@
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "drive-mirror",
@@ -2240,6 +2238,8 @@
 #                         "sync": "full",
 #                         "format": "qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'drive-mirror', 'boxed': true,
   'data': 'DriveMirror',
@@ -2407,13 +2407,13 @@
 #     - If @node is not a valid block device or node, DeviceNotFound
 #     - If @name is already taken, GenericError
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-add",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
 #     <- { "return": {} }
+#
+# Since: 2.4
 ##
 { 'command': 'block-dirty-bitmap-add',
   'data': 'BlockDirtyBitmapAdd',
@@ -2431,13 +2431,13 @@
 #     - If @name is not found, GenericError
 #     - if @name is frozen by an operation, GenericError
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-remove",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
 #     <- { "return": {} }
+#
+# Since: 2.4
 ##
 { 'command': 'block-dirty-bitmap-remove',
   'data': 'BlockDirtyBitmap',
@@ -2454,13 +2454,13 @@
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-clear",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
 #     <- { "return": {} }
+#
+# Since: 2.4
 ##
 { 'command': 'block-dirty-bitmap-clear',
   'data': 'BlockDirtyBitmap',
@@ -2475,13 +2475,13 @@
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError
 #
-# Since: 4.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-enable",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
 #     <- { "return": {} }
+#
+# Since: 4.0
 ##
 { 'command': 'block-dirty-bitmap-enable',
   'data': 'BlockDirtyBitmap',
@@ -2496,13 +2496,13 @@
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError
 #
-# Since: 4.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-disable",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
 #     <- { "return": {} }
+#
+# Since: 4.0
 ##
 { 'command': 'block-dirty-bitmap-disable',
   'data': 'BlockDirtyBitmap',
@@ -2528,14 +2528,14 @@
 #     - If any of the bitmaps have different sizes or granularities,
 #       GenericError
 #
-# Since: 4.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-merge",
 #          "arguments": { "node": "drive0", "target": "bitmap0",
 #                         "bitmaps": ["bitmap1"] } }
 #     <- { "return": {} }
+#
+# Since: 4.0
 ##
 { 'command': 'block-dirty-bitmap-merge',
   'data': 'BlockDirtyBitmapMerge',
@@ -2637,8 +2637,6 @@
 #     mirror.  Setting this to true when the destination is not
 #     actually all zero can corrupt the destination.  (Since 10.1)
 #
-# Since: 2.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-mirror",
@@ -2646,6 +2644,8 @@
 #                         "target": "target0",
 #                         "sync": "full" } }
 #     <- { "return": {} }
+#
+# Since: 2.6
 ##
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
@@ -2962,14 +2962,14 @@
 # Errors:
 #     - If @device does not exist, DeviceNotFound.
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-stream",
 #          "arguments": { "device": "virtio0",
 #                         "base": "/tmp/master.qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
@@ -4958,7 +4958,7 @@
 #
 # Creates a new block device.
 #
-# Since: 2.9
+# Details:
 #
 # .. qmp-example::
 #
@@ -4999,6 +4999,8 @@
 #          }
 #
 #     <- { "return": {} }
+#
+# Since: 2.9
 ##
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true,
   'allow-preconfig': true }
@@ -5062,8 +5064,6 @@
 #
 # @node-name: Name of the graph node to delete.
 #
-# Since: 2.9
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -5082,6 +5082,8 @@
 #          "arguments": { "node-name": "node0" }
 #        }
 #     <- { "return": {} }
+#
+# Since: 2.9
 ##
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' },
   'allow-preconfig': true }
@@ -5102,8 +5104,6 @@
 # @active: true if the nodes should be active when the command returns
 #     success, false if they should be inactive.
 #
-# Since: 10.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-set-active",
@@ -5113,6 +5113,8 @@
 #          }
 #        }
 #     <- { "return": {} }
+#
+# Since: 10.0
 ##
 { 'command': 'blockdev-set-active',
   'data': { '*node-name': 'str', 'active': 'bool' },
@@ -5796,8 +5798,6 @@
 #
 # .. note:: This event is rate-limited, except if action is "stop".
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_IO_ERROR",
@@ -5808,6 +5808,8 @@
 #                    "action": "stop",
 #                    "reason": "No space left on device" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 0.13
 ##
 { 'event': 'BLOCK_IO_ERROR',
   'data': { 'qom-path': 'str', 'device': 'str', '*node-name': 'str',
@@ -5837,8 +5839,6 @@
 #     other than that streaming has failed and clients should not try
 #     to interpret the error string
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_COMPLETED",
@@ -5846,6 +5846,8 @@
 #                    "len": 10737418240, "offset": 10737418240,
 #                    "speed": 0 },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 1.1
 ##
 { 'event': 'BLOCK_JOB_COMPLETED',
   'data': { 'type'  : 'JobType',
@@ -5872,8 +5874,6 @@
 #
 # @speed: rate limit, bytes per second
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_CANCELLED",
@@ -5881,6 +5881,8 @@
 #                    "len": 10737418240, "offset": 134217728,
 #                    "speed": 0 },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 1.1
 ##
 { 'event': 'BLOCK_JOB_CANCELLED',
   'data': { 'type'  : 'JobType',
@@ -5901,8 +5903,6 @@
 #
 # @action: action that has been taken
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_ERROR",
@@ -5910,6 +5910,8 @@
 #                    "operation": "write",
 #                    "action": "stop" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 1.3
 ##
 { 'event': 'BLOCK_JOB_ERROR',
   'data': { 'device'   : 'str',
@@ -5936,14 +5938,14 @@
 # .. note:: The "ready to complete" status is always reset by a
 #    `BLOCK_JOB_ERROR` event.
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_READY",
 #          "data": { "device": "drive0", "type": "mirror", "speed": 0,
 #                    "len": 2097152, "offset": 2097152 },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 1.3
 ##
 { 'event': 'BLOCK_JOB_READY',
   'data': { 'type'  : 'JobType',
@@ -5964,13 +5966,13 @@
 #
 # @id: The job identifier.
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_PENDING",
 #          "data": { "type": "mirror", "id": "backup_1" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 2.12
 ##
 { 'event': 'BLOCK_JOB_PENDING',
   'data': { 'type'  : 'JobType',
@@ -6038,14 +6040,14 @@
 # @write-threshold: configured threshold for the block device, bytes.
 #     Use 0 to disable the threshold.
 #
-# Since: 2.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block-set-write-threshold",
 #          "arguments": { "node-name": "mydev",
 #                         "write-threshold": 17179869184 } }
 #     <- { "return": {} }
+#
+# Since: 2.3
 ##
 { 'command': 'block-set-write-threshold',
   'data': { 'node-name': 'str', 'write-threshold': 'uint64' },
@@ -6079,8 +6081,6 @@
 #     'children' list of `BlockdevOptionsQuorum`, as returned by
 #     .bdrv_refresh_filename().
 #
-# Since: 2.7
-#
 # .. qmp-example::
 #    :title: Add a new node to a quorum
 #
@@ -6103,6 +6103,8 @@
 #          "arguments": { "parent": "disk1",
 #                         "child": "children.1" } }
 #     <- { "return": {} }
+#
+# Since: 2.7
 ##
 { 'command': 'x-blockdev-change',
   'data' : { 'parent': 'str',
@@ -6131,8 +6133,6 @@
 # @unstable: This command is experimental and intended for test cases
 #     that need control over IOThreads only.
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #    :title: Move a node into an IOThread
 #
@@ -6148,6 +6148,8 @@
 #          "arguments": { "node-name": "disk1",
 #                         "iothread": null } }
 #     <- { "return": {} }
+#
+# Since: 2.12
 ##
 { 'command': 'x-blockdev-set-iothread',
   'data' : { 'node-name': 'str',
@@ -6185,13 +6187,13 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     <- { "event": "QUORUM_FAILURE",
 #          "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+# Since: 2.0
 ##
 { 'event': 'QUORUM_FAILURE',
   'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'int' } }
@@ -6216,8 +6218,6 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #    :title: Read operation
 #
@@ -6233,6 +6233,8 @@
 #          "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
 #                    "type": "flush", "error": "Broken pipe" },
 #          "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#
+# Since: 2.0
 ##
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
@@ -6269,8 +6271,6 @@
 # .. note:: Only some image formats such as qcow2 and rbd support
 #    internal snapshots.
 #
-# Since: 1.7
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-internal-sync",
@@ -6278,6 +6278,8 @@
 #                         "name": "snapshot0" }
 #        }
 #     <- { "return": {} }
+#
+# Since: 1.7
 ##
 { 'command': 'blockdev-snapshot-internal-sync',
   'data': 'BlockdevSnapshotInternal',
@@ -6305,8 +6307,6 @@
 #       GenericError
 #     - If @id and @name are both not specified, GenericError
 #
-# Since: 1.7
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-delete-internal-sync",
@@ -6324,6 +6324,8 @@
 #                        "icount": 220414
 #          }
 #        }
+#
+# Since: 1.7
 ##
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
diff --git a/qapi/block.json b/qapi/block.json
index 54bc0056318..a29907e0be1 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -118,12 +118,12 @@
 #
 # .. note:: Ejecting a device with no media results in success.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'eject',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -162,8 +162,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-open-tray",
@@ -177,6 +175,8 @@
 #                    "tray-open": true } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-open-tray',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -200,8 +200,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-close-tray",
@@ -215,6 +213,8 @@
 #                    "tray-open": false } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-close-tray',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -232,8 +232,6 @@
 #
 # @id: The name or QOM path of the guest device
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-remove-medium",
@@ -258,6 +256,8 @@
 #          "arguments": { "id": "ide0-1-0" } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.12
 ##
 { 'command': 'blockdev-remove-medium',
   'data': { 'id': 'str' } }
@@ -273,8 +273,6 @@
 #
 # @node-name: name of a node in the block driver state graph
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -290,6 +288,8 @@
 #                         "node-name": "node0" } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.12
 ##
 { 'command': 'blockdev-insert-medium',
   'data': { 'id': 'str',
@@ -343,8 +343,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #    :title: Change a removable medium
 #
@@ -374,6 +372,8 @@
 #                         "read-only-mode": "read-only" } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-change-medium',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -398,8 +398,6 @@
 # @tray-open: true if the tray has been opened or false if it has been
 #     closed
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "DEVICE_TRAY_MOVED",
@@ -408,6 +406,8 @@
 #                    "tray-open": true
 #          },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 1.1
 ##
 { 'event': 'DEVICE_TRAY_MOVED',
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
@@ -422,8 +422,6 @@
 #
 # @connected: true if the PR manager is connected to a backend
 #
-# Since: 3.0
-#
 # .. qmp-example::
 #
 #     <- { "event": "PR_MANAGER_STATUS_CHANGED",
@@ -431,6 +429,8 @@
 #                    "connected": true
 #          },
 #          "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
+#
+# Since: 3.0
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
@@ -464,8 +464,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "block_set_io_throttle",
@@ -505,6 +503,8 @@
 #                         "bps_max_length": 60,
 #                         "iops_size": 0 } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'block_set_io_throttle', 'boxed': true,
   'data': 'BlockIOThrottle',
@@ -546,8 +546,6 @@
 # Errors:
 #     - if device is not found or any boundary arrays are invalid.
 #
-# Since: 4.0
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -594,6 +592,8 @@
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0" } }
 #     <- { "return": {} }
+#
+# Since: 4.0
 ##
 { 'command': 'block-latency-histogram-set',
   'data': {'id': 'str',
diff --git a/qapi/char.json b/qapi/char.json
index a4abafa6803..74408cc6d39 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -38,8 +38,6 @@
 #
 # Return information about current character devices.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-chardev" }
@@ -62,6 +60,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-chardev', 'returns': ['ChardevInfo'],
   'allow-preconfig': true }
@@ -82,8 +82,6 @@
 #
 # Return information about character device backends.
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-chardev-backends" }
@@ -103,6 +101,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 2.0
 ##
 { 'command': 'query-chardev-backends', 'returns': ['ChardevBackendInfo'] }
 
@@ -137,8 +137,6 @@
 #     - data itself is always Unicode regardless of format, like any
 #       other string.
 #
-# Since: 1.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "ringbuf-write",
@@ -146,6 +144,8 @@
 #                         "data": "abcdefgh",
 #                         "format": "utf8" } }
 #     <- { "return": {} }
+#
+# Since: 1.4
 ##
 { 'command': 'ringbuf-write',
   'data': { 'device': 'str',
@@ -173,8 +173,6 @@
 #
 # Returns: data read from the device
 #
-# Since: 1.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "ringbuf-read",
@@ -182,6 +180,8 @@
 #                         "size": 1000,
 #                         "format": "utf8" } }
 #     <- { "return": "abcdefgh" }
+#
+# Since: 1.4
 ##
 { 'command': 'ringbuf-read',
   'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
@@ -761,8 +761,6 @@
 #
 # @backend: backend type and parameters
 #
-# Since: 1.4
-#
 # .. qmp-example::
 #
 #     -> { "execute" : "chardev-add",
@@ -784,6 +782,8 @@
 #          "arguments" : { "id" : "baz",
 #                          "backend" : { "type" : "pty", "data" : {} } } }
 #     <- { "return": { "pty" : "/dev/pty/42" } }
+#
+# Since: 1.4
 ##
 { 'command': 'chardev-add',
   'data': { 'id': 'str',
@@ -799,8 +799,6 @@
 #
 # @backend: new backend type and parameters
 #
-# Since: 2.10
-#
 # .. qmp-example::
 #
 #     -> { "execute" : "chardev-change",
@@ -825,6 +823,8 @@
 #                      "server" : true,
 #                      "wait" : false }}}}
 #     <- {"return": {}}
+#
+# Since: 2.10
 ##
 { 'command': 'chardev-change',
   'data': { 'id': 'str',
@@ -838,12 +838,12 @@
 #
 # @id: the chardev's ID, must exist and not be in use
 #
-# Since: 1.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
+#
+# Since: 1.4
 ##
 { 'command': 'chardev-remove',
   'data': { 'id': 'str' } }
@@ -855,12 +855,12 @@
 #
 # @id: the chardev's ID, must exist
 #
-# Since: 2.10
-#
 # .. qmp-example::
 #
 #     -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
+#
+# Since: 2.10
 ##
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
@@ -876,13 +876,13 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 2.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "VSERPORT_CHANGE",
 #          "data": { "id": "channel0", "open": true },
 #          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+# Since: 2.1
 ##
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d6..758b176de72 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -97,8 +97,6 @@
 #
 # Returns: An object describing the current version of QEMU.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-version" }
@@ -112,6 +110,8 @@
 #              "package":""
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-version', 'returns': 'VersionInfo',
   'allow-preconfig': true }
@@ -134,8 +134,6 @@
 #
 # Returns: A list of all supported commands
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-commands" }
@@ -152,6 +150,8 @@
 #        }
 #
 # This example has been shortened as the real response is too long.
+#
+# Since: 0.14
 ##
 { 'command': 'query-commands', 'returns': ['CommandInfo'],
   'allow-preconfig': true }
@@ -161,16 +161,18 @@
 #
 # Request graceful QEMU process termination.
 #
+# Details:
+#
 # While every attempt is made to send the QMP response before
 # terminating, this is not guaranteed.  When using this interface, a
 # premature EOF would not be unexpected.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "quit" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'quit',
   'allow-preconfig': true }
diff --git a/qapi/dump.json b/qapi/dump.json
index 726b5208703..bda1c731544 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -94,13 +94,13 @@
 #
 # .. note:: All boolean arguments default to false.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "dump-guest-memory",
 #          "arguments": { "paging": false, "protocol": "fd:dump" } }
 #     <- { "return": {} }
+#
+# Since: 1.2
 ##
 { 'command': 'dump-guest-memory',
   'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
@@ -150,13 +150,13 @@
 #
 # Returns: An object showing the dump status.
 #
-# Since: 2.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-dump" }
 #     <- { "return": { "status": "active", "completed": 1024000,
 #                      "total": 2048000 } }
+#
+# Since: 2.6
 ##
 { 'command': 'query-dump', 'returns': 'DumpQueryResult' }
 
@@ -171,14 +171,14 @@
 #     failed.  Only presents on failure.  The user should not try to
 #     interpret the error string.
 #
-# Since: 2.6
-#
 # .. qmp-example::
 #
 #     <- { "event": "DUMP_COMPLETED",
 #          "data": { "result": { "total": 1090650112, "status": "completed",
 #                                "completed": 1090650112 } },
 #          "timestamp": { "seconds": 1648244171, "microseconds": 950316 } }
+#
+# Since: 2.6
 ##
 { 'event': 'DUMP_COMPLETED' ,
   'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
@@ -201,13 +201,13 @@
 #
 # Returns: An object listing available formats for `dump-guest-memory`
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-dump-guest-memory-capability" }
 #     <- { "return": { "formats":
 #                      ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] } }
+#
+# Since: 2.0
 ##
 { 'command': 'query-dump-guest-memory-capability',
   'returns': 'DumpGuestMemoryCapability' }
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index e67f180a272..adc986418d7 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -79,13 +79,13 @@
 #
 # @unstable: This event is experimental.
 #
-# Since: 8.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "CPU_POLARIZATION_CHANGE",
 #          "data": { "polarization": "horizontal" },
 #          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+# Since: 8.2
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'S390CpuPolarization' },
@@ -130,12 +130,12 @@
 #
 # @unstable: This event is experimental.
 #
-# Since: 10.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
 #          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+# Since: 10.2
 ##
 { 'event': 'SCLP_CPI_INFO_AVAILABLE',
   'features': [ 'unstable' ]
diff --git a/qapi/machine.json b/qapi/machine.json
index 2052ebbbb5b..54d5ade610d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -108,8 +108,6 @@
 #
 # Return information about all virtual CPUs.
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-cpus-fast" }
@@ -138,6 +136,8 @@
 #             }
 #         ]
 #     }
+#
+# Since: 2.12
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
@@ -223,8 +223,6 @@
 #
 # @unstable: Argument @compat-props is experimental.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-machines", "arguments": { "compat-props": true } }
@@ -247,6 +245,8 @@
 #               },
 #               ...
 #        }
+#
+# Since: 1.2
 ##
 { 'command': 'query-machines',
   'data': { '*compat-props': { 'type': 'bool',
@@ -303,10 +303,10 @@
 #
 # @UUID: the UUID of the guest
 #
-# Since: 0.14
-#
 # .. note:: If no UUID was specified for the guest, the nil UUID (all
 #    zeroes) is returned.
+#
+# Since: 0.14
 ##
 { 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
 
@@ -315,12 +315,12 @@
 #
 # Query the guest UUID information.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-uuid" }
 #     <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
+#
+# Since: 0.14
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
 
@@ -349,12 +349,14 @@
 #
 # Performs a hard reset of a guest.
 #
-# Since: 0.14
+# Details:
 #
 # .. qmp-example::
 #
 #     -> { "execute": "system_reset" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'system_reset' }
 
@@ -363,7 +365,7 @@
 #
 # Requests that a guest perform a powerdown operation.
 #
-# Since: 0.14
+# Details:
 #
 # .. note:: A guest may or may not respond to this command.  This
 #    command returning does not indicate that a guest has accepted the
@@ -374,6 +376,8 @@
 #
 #     -> { "execute": "system_powerdown" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'system_powerdown' }
 
@@ -385,7 +389,7 @@
 # `query-current-machine`), wake-up guest from suspend if the guest is
 # in SUSPENDED state.  Return an error otherwise.
 #
-# Since: 1.1
+# Details:
 #
 # .. note:: Prior to 4.0, this command does nothing in case the guest
 #    isn't suspended.
@@ -394,6 +398,8 @@
 #
 #     -> { "execute": "system_wakeup" }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'system_wakeup' }
 
@@ -436,7 +442,7 @@
 # all CPUs (ppc64).  The command fails when the guest doesn't support
 # injecting.
 #
-# Since: 0.14
+# Details:
 #
 # .. note:: Prior to 2.1, this command was only supported for x86 and
 #    s390 VMs.
@@ -445,6 +451,8 @@
 #
 #     -> { "execute": "inject-nmi" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'inject-nmi' }
 
@@ -806,8 +814,6 @@
 # @cpu-index: the index of the virtual CPU to use for translating the
 #     virtual address (defaults to CPU 0)
 #
-# Since: 0.14
-#
 # .. caution:: Errors were not reliably returned until 1.1.
 #
 # .. qmp-example::
@@ -817,6 +823,8 @@
 #                         "size": 100,
 #                         "filename": "/tmp/virtual-mem-dump" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'memsave',
   'data': {
@@ -836,8 +844,6 @@
 #
 # @filename: the file to save the memory to as binary data
 #
-# Since: 0.14
-#
 # .. caution:: Errors were not reliably returned until 1.1.
 #
 # .. qmp-example::
@@ -847,6 +853,8 @@
 #                         "size": 100,
 #                         "filename": "/tmp/physical-mem-dump" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'pmemsave',
   'data': {
@@ -900,7 +908,7 @@
 #
 # Return information for all memory backends.
 #
-# Since: 2.1
+# Details:
 #
 # .. qmp-example::
 #
@@ -927,6 +935,8 @@
 #            }
 #          ]
 #        }
+#
+# Since: 2.1
 ##
 { 'command': 'query-memdev', 'returns': ['Memdev'], 'allow-preconfig': true }
 
@@ -1015,8 +1025,6 @@
 #
 # TODO: Better documentation; currently there is none.
 #
-# Since: 2.7
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -1067,6 +1075,8 @@
 #             "props": { "core-id": 0 }
 #          }
 #        ]}
+#
+# Since: 2.7
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
              'allow-preconfig': true }
@@ -1105,8 +1115,6 @@
 #    returns, the balloon size may not have changed.  A guest can
 #    change the balloon size independent of this command.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -1116,6 +1124,8 @@
 #      <- { "return": {} }
 #
 #    With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#
+# Since: 0.14
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
@@ -1141,8 +1151,6 @@
 #       the KVM kernel module cannot support it, KVMMissingCap
 #     - If no balloon device is present, DeviceNotActive
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-balloon" }
@@ -1150,6 +1158,8 @@
 #              "actual": 1073741824
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-balloon', 'returns': 'BalloonInfo' }
 
@@ -1165,13 +1175,13 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "BALLOON_CHANGE",
 #          "data": { "actual": 944766976 },
 #          "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
+# Since: 1.2
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
@@ -1204,8 +1214,6 @@
 #       reporting is not enabled or no guest memory status report
 #       received yet, GenericError
 #
-# Since: 8.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-hv-balloon-status-report" }
@@ -1214,6 +1222,8 @@
 #              "available": 3333054464
 #           }
 #        }
+#
+# Since: 8.2
 ##
 { 'command': 'query-hv-balloon-status-report', 'returns': 'HvBalloonInfo' }
 
@@ -1223,15 +1233,17 @@
 # Emitted when the hv-balloon driver receives a "STATUS" message from
 # the guest.
 #
-# .. note:: This event is rate-limited.
+# Details:
 #
-# Since: 8.2
+# .. note:: This event is rate-limited.
 #
 # .. qmp-example::
 #
 #     <- { "event": "HV_BALLOON_STATUS_REPORT",
 #          "data": { "committed": 816640000, "available": 3333054464 },
 #          "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
+#
+# Since: 8.2
 ##
 { 'event': 'HV_BALLOON_STATUS_REPORT',
   'data': 'HvBalloonInfo' }
@@ -1538,7 +1550,7 @@
 #
 # Lists available memory devices and their state
 #
-# Since: 2.1
+# Details:
 #
 # .. qmp-example::
 #
@@ -1554,6 +1566,8 @@
 #                             "slot": 0},
 #                        "type": "dimm"
 #                      } ] }
+#
+# Since: 2.1
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
 
@@ -1572,14 +1586,14 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 5.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 #          "data": { "id": "vm0", "size": 1073741824,
 #                    "qom-path": "/machine/unattached/device[2]" },
 #          "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
+#
+# Since: 5.1
 ##
 { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
@@ -1812,13 +1826,13 @@
 #
 # @filename: name of the dtb file to be created
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "dumpdtb" }
 #          "arguments": { "filename": "fdt.dtb" } }
 #     <- { "return": {} }
+#
+# Since: 7.2
 ##
 { 'command': 'dumpdtb',
   'data': { 'filename': 'str' },
@@ -1877,13 +1891,13 @@
 #
 # @filename: the path to the file to dump to
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "dump-skeys",
 #          "arguments": { "filename": "/tmp/skeys" } }
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'dump-skeys',
   'data': { 'filename': 'str' } }
diff --git a/qapi/migration.json b/qapi/migration.json
index 558b4f145ed..b88473aa2dd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -339,8 +339,6 @@
 # Return information about current migration process.  If migration is
 # active there will be another json-object with RAM migration status.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #    :title: Before the first migration
 #
@@ -426,6 +424,8 @@
 #              }
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-migrate', 'returns': 'MigrationInfo' }
 
@@ -562,13 +562,13 @@
 #
 # @capabilities: json array of capability modifications to make
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-set-capabilities" , "arguments":
 #          { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
 #     <- { "return": {} }
+#
+# Since: 1.2
 ##
 { 'command': 'migrate-set-capabilities',
   'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
@@ -578,8 +578,6 @@
 #
 # Return information about the current migration capabilities status
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-migrate-capabilities" }
@@ -591,6 +589,8 @@
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
 #        ]}
+#
+# Since: 1.2
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
 
@@ -838,13 +838,15 @@
 #
 # Set migration parameters.  All arguments are optional.
 #
-# Since: 2.4
+# Details:
 #
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-set-parameters" ,
 #          "arguments": { "multifd-channels": 5 } }
 #     <- { "return": {} }
+#
+# Since: 2.4
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
   'data': 'MigrationParameters' }
@@ -1056,8 +1058,6 @@
 # @block-bitmap-mapping, which is only present if it has been
 # previously set.
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-migrate-parameters" }
@@ -1069,6 +1069,8 @@
 #              "downtime-limit": 300
 #           }
 #        }
+#
+# Since: 2.4
 ##
 { 'command': 'query-migrate-parameters',
   'returns': 'MigrationParameters' }
@@ -1080,12 +1082,14 @@
 # mode.  The postcopy-ram capability must be set on both source and
 # destination before the original migration command.
 #
-# Since: 2.5
+# Details:
 #
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-start-postcopy" }
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'migrate-start-postcopy' }
 
@@ -1096,13 +1100,13 @@
 #
 # @status: `MigrationStatus` describing the current migration status.
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
 #         "event": "MIGRATION",
 #         "data": {"status": "completed"} }
+#
+# Since: 2.4
 ##
 { 'event': 'MIGRATION',
   'data': {'status': 'MigrationStatus'}}
@@ -1115,12 +1119,12 @@
 #
 # @pass: An incrementing count (starting at 1 on the first pass)
 #
-# Since: 2.6
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
 #           "event": "MIGRATION_PASS", "data": {"pass": 2} }
+#
+# Since: 2.6
 ##
 { 'event': 'MIGRATION_PASS',
   'data': { 'pass': 'int' } }
@@ -1199,12 +1203,12 @@
 #
 # @reason: describes the reason for the COLO exit.
 #
-# Since: 3.1
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
 #          "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
+#
+# Since: 3.1
 ##
 { 'event': 'COLO_EXIT',
   'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
@@ -1242,12 +1246,12 @@
 #
 # @unstable: This command is experimental.
 #
-# Since: 2.8
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-colo-lost-heartbeat" }
 #     <- { "return": {} }
+#
+# Since: 2.8
 ##
 { 'command': 'x-colo-lost-heartbeat',
   'features': [ 'unstable' ],
@@ -1260,15 +1264,17 @@
 # migration to be started right after.  When postcopy-ram is in use,
 # cancelling is not allowed after the postcopy phase has started.
 #
+# Details:
+#
 # .. note:: This command succeeds even if there is no migration
 #    process running.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate_cancel" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'migrate_cancel' }
 
@@ -1279,13 +1285,13 @@
 #
 # @state: The state the migration is currently expected to be in
 #
-# Since: 2.11
-#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-continue" , "arguments":
 #          { "state": "pre-switchover" } }
 #     <- { "return": {} }
+#
+# Since: 2.11
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
@@ -1394,8 +1400,6 @@
 #     will fail unless migration is in "postcopy-paused" state.
 #     (default: false, since 3.0)
 #
-# Since: 0.14
-#
 # .. admonition:: Notes
 #
 #     1. The `query-migrate` command should be used to check
@@ -1449,6 +1453,8 @@
 #                                        "filename": "/tmp/migfile",
 #                                        "offset": "0x1000" } } ] } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'migrate',
   'data': {'*uri': 'str',
@@ -1472,8 +1478,6 @@
 #     :qapi:event:`MIGRATION` event, and error details could be
 #     retrieved with `query-migrate`.  (since 9.1)
 #
-# Since: 2.3
-#
 # .. admonition:: Notes
 #
 #     1. It's a bad idea to use a string for the uri, but it needs to
@@ -1521,6 +1525,8 @@
 #                                        "host": "10.12.34.9",
 #                                        "port": "1050" } } ] } }
 #     <- { "return": {} }
+#
+# Since: 2.3
 ##
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
@@ -1540,13 +1546,13 @@
 # @live: Optional argument to ask QEMU to treat this command as part
 #     of a live migration.  Default to true.  (since 2.11)
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-save-devices-state",
 #          "arguments": { "filename": "/tmp/save" } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'xen-save-devices-state',
   'data': {'filename': 'str', '*live':'bool' } }
@@ -1558,13 +1564,13 @@
 #
 # @enable: true to enable, false to disable.
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-set-global-dirty-log",
 #          "arguments": { "enable": true } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
 
@@ -1578,13 +1584,13 @@
 #     data.  See `xen-save-devices-state`.txt for a description of the
 #     binary format.
 #
-# Since: 2.7
-#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-load-devices-state",
 #          "arguments": { "filename": "/tmp/resume" } }
 #     <- { "return": {} }
+#
+# Since: 2.7
 ##
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
 
@@ -1747,13 +1753,13 @@
 #
 # @device-id: QEMU device id of the unplugged device
 #
-# Since: 4.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "UNPLUG_PRIMARY",
 #          "data": { "device-id": "hostdev0" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 4.2
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
@@ -1907,8 +1913,6 @@
 #     'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
 #     (Since 6.1)
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
@@ -1924,6 +1928,8 @@
 #         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
 #
 #     <- { "return": {} }
+#
+# Since: 5.2
 ##
 { 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
                                          '*calc-time-unit': 'TimeUnit',
@@ -1938,8 +1944,6 @@
 # @calc-time-unit: time unit in which to report calculation time.
 #     By default it is reported in seconds.  (Since 8.2)
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #    :title: Measurement is in progress
 #
@@ -1953,6 +1957,8 @@
 #     <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
 #         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
 #         "calc-time-unit": "second"}
+#
+# Since: 5.2
 ##
 { 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' },
                                  'returns': 'DirtyRateInfo' }
@@ -1989,14 +1995,14 @@
 #
 # @dirty-rate: upper limit of dirty page rate (MB/s) for virtual CPUs.
 #
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     -> {"execute": "set-vcpu-dirty-limit"}
 #         "arguments": { "dirty-rate": 200,
 #                        "cpu-index": 1 } }
 #     <- { "return": {} }
+#
+# Since: 7.1
 ##
 { 'command': 'set-vcpu-dirty-limit',
   'data': { '*cpu-index': 'int',
@@ -2013,13 +2019,13 @@
 #
 # @cpu-index: index of a virtual CPU, default is all.
 #
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     -> {"execute": "cancel-vcpu-dirty-limit"},
 #         "arguments": { "cpu-index": 1 } }
 #     <- { "return": {} }
+#
+# Since: 7.1
 ##
 { 'command': 'cancel-vcpu-dirty-limit',
   'data': { '*cpu-index': 'int'} }
@@ -2029,14 +2035,14 @@
 #
 # Return information about virtual CPU dirty page rate limits, if any.
 #
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     -> {"execute": "query-vcpu-dirty-limit"}
 #     <- {"return": [
 #            { "limit-rate": 60, "current-rate": 3, "cpu-index": 0},
 #            { "limit-rate": 60, "current-rate": 3, "cpu-index": 1}]}
+#
+# Since: 7.1
 ##
 { 'command': 'query-vcpu-dirty-limit',
   'returns': [ 'DirtyLimitInfo' ] }
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f921d740f15..31a44c52a04 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -33,15 +33,17 @@
 # It will return a list of `GICCapability` objects that describe its
 # capability bits.
 #
+# Details:
+#
 # On non-ARM targets this command will report an error as the GIC
 # technology is not applicable.
 #
-# Since: 2.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-gic-capabilities" }
 #     <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
 #                     { "version": 3, "emulated": false, "kernel": true } ] }
+#
+# Since: 2.6
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 05a94d6c416..01cdf8d706e 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -10,16 +10,18 @@
 # mechanism to synchronize guest time is in effect, for example QEMU
 # guest agent's `guest-set-time` command.
 #
+# Details:
+#
 # Use of this command is only applicable for x86 machines with an RTC,
 # and on other machines will silently return without performing any
 # action.
 #
-# Since: 2.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "rtc-reset-reinjection" }
 #     <- { "return": {} }
+#
+# Since: 2.1
 ##
 { 'command': 'rtc-reset-reinjection' }
 
@@ -127,18 +129,20 @@
 #
 # Return information about SEV/SEV-ES/SEV-SNP.
 #
+# Details:
+#
 # If unavailable due to an incompatible configuration the returned
 # @enabled field is set to 'false' and the state of all other fields
 # is unspecified.
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev" }
 #     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
 #                      "build-id" : 0, "policy" : 0, "state" : "running",
 #                      "handle" : 1 } }
+#
+# Since: 2.12
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo' }
 
@@ -169,12 +173,12 @@
 #       invalid guest configuration or if the guest has not reached
 #       the required SEV state, GenericError
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev-launch-measure" }
 #     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+#
+# Since: 2.12
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo' }
 
@@ -214,14 +218,14 @@
 # Errors:
 #     - If SEV is not available on the platform, GenericError
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sev-capabilities" }
 #     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
 #                      "cpu0-id": "2lvmGwo+...61iEinw==",
 #                      "cbitpos": 47, "reduced-phys-bits": 1}}
+#
+# Since: 2.12
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
 
@@ -280,13 +284,13 @@
 #       invalid guest configuration or because the guest has not
 #       reached the required SEV state, GenericError
 #
-# Since: 6.1
-#
 # .. qmp-example::
 #
 #     -> { "execute" : "query-sev-attestation-report",
 #                      "arguments": { "mnonce": "aaaaaaa" } }
 #     <- { "return" : { "data": "aaaaaaaabbbddddd"} }
+#
+# Since: 6.1
 ##
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
@@ -336,7 +340,7 @@
 #
 # Return information about configured SGX capabilities of guest
 #
-# Since: 6.2
+# Details:
 #
 # .. qmp-example::
 #
@@ -345,6 +349,8 @@
 #                      "flc": true,
 #                      "sections": [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
+#
+# Since: 6.2
 ##
 { 'command': 'query-sgx', 'returns': 'SgxInfo' }
 
@@ -353,7 +359,7 @@
 #
 # Return information about SGX capabilities of host
 #
-# Since: 6.2
+# Details:
 #
 # .. qmp-example::
 #
@@ -362,6 +368,8 @@
 #                      "flc": true,
 #                      "section" : [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
+#
+# Since: 6.2
 ##
 { 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo' }
 
@@ -424,8 +432,6 @@
 #
 # Returns: list of open event channel ports.
 #
-# Since: 8.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-event-list" }
@@ -450,6 +456,8 @@
 #             }
 #          ]
 #        }
+#
+# Since: 8.0
 ##
 { 'command': 'xen-event-list',
   'returns': ['EvtchnInfo'] }
@@ -461,12 +469,12 @@
 #
 # @port: The port number
 #
-# Since: 8.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
 #     <- { "return": { } }
+#
+# Since: 8.0
 ##
 { 'command': 'xen-event-inject',
   'data': { 'port': 'uint32' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index 05866837f09..abb14bbd397 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -30,13 +30,13 @@
 #
 # @tls: whether to perform TLS.  Only applies to the "spice" protocol
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
 #                                                  "fdname": "myclient" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'add_client',
   'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
@@ -58,12 +58,12 @@
 #
 # Return the name information of a guest.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-name" }
 #     <- { "return": { "name": "qemu-name" } }
+#
+# Since: 0.14
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
@@ -109,8 +109,6 @@
 #
 # Returns: a list of info for each iothread
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-iothreads" }
@@ -125,6 +123,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 2.0
 ##
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
@@ -134,7 +134,7 @@
 #
 # Stop guest VM execution.
 #
-# Since: 0.14
+# Details:
 #
 # .. note:: This function will succeed even if the guest is already in
 #    the stopped state.  In "inmigrate" state, it will ensure that the
@@ -148,6 +148,8 @@
 #
 #     -> { "execute": "stop" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'stop' }
 
@@ -156,7 +158,7 @@
 #
 # Resume guest VM execution.
 #
-# Since: 0.14
+# Details:
 #
 # .. note:: This command will succeed if the guest is currently
 #    running.  It will also succeed if the guest is in the "inmigrate"
@@ -172,6 +174,8 @@
 #
 #     -> { "execute": "cont" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'cont' }
 
@@ -190,12 +194,12 @@
 #
 # @unstable: This command is experimental.
 #
-# Since: 3.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-exit-preconfig" }
 #     <- { "return": {} }
+#
+# Since: 3.0
 ##
 { 'command': 'x-exit-preconfig', 'allow-preconfig': true,
   'features': [ 'unstable' ] }
@@ -217,8 +221,6 @@
 #     monitor-owned nodes if they have no parents.  This allows the
 #     use of 'savevm' with -blockdev.  (since 4.2)
 #
-# Since: 0.14
-#
 # .. note:: This command only exists as a stop-gap.  Its use is highly
 #    discouraged.  The semantics of this command are not guaranteed:
 #    this means that command names, arguments and responses can change
@@ -237,6 +239,8 @@
 #     -> { "execute": "human-monitor-command",
 #          "arguments": { "command-line": "info kvm" } }
 #     <- { "return": "kvm support: enabled\r\n" }
+#
+# Since: 0.14
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
@@ -250,8 +254,6 @@
 #
 # @fdname: file descriptor name
 #
-# Since: 0.14
-#
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
@@ -262,6 +264,8 @@
 #
 #     -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'getfd', 'data': {'fdname': 'str'}, 'if': 'CONFIG_POSIX' }
 
@@ -277,8 +281,6 @@
 #
 # @fdname: file descriptor name
 #
-# Since: 8.0
-#
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
@@ -290,6 +292,8 @@
 #     -> { "execute": "get-win32-socket",
 #          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
 #     <- { "return": {} }
+#
+# Since: 8.0
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
 
@@ -300,12 +304,12 @@
 #
 # @fdname: file descriptor name
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
@@ -341,12 +345,12 @@
 # .. note:: If @fdset-id is not specified, a new fd set will be
 #    created.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
 #     <- { "return": { "fdset-id": 1, "fd": 3 } }
+#
+# Since: 1.2
 ##
 { 'command': 'add-fd',
   'data': { '*fdset-id': 'int',
@@ -365,8 +369,6 @@
 # Errors:
 #     - If @fdset-id or @fd is not found, GenericError
 #
-# Since: 1.2
-#
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
 # .. note:: If @fd is not specified, all file descriptors in @fdset-id
@@ -376,6 +378,8 @@
 #
 #     -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
 #     <- { "return": {} }
+#
+# Since: 1.2
 ##
 { 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
 
@@ -412,7 +416,7 @@
 #
 # Return information describing all fd sets.
 #
-# Since: 1.2
+# Details:
 #
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
@@ -446,6 +450,8 @@
 #            }
 #          ]
 #        }
+#
+# Since: 1.2
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
 
@@ -516,8 +522,6 @@
 # Errors:
 #     - if the given @option doesn't exist
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-command-line-options",
@@ -538,6 +542,8 @@
 #             }
 #          ]
 #        }
+#
+# Since: 1.5
 ##
 {'command': 'query-command-line-options',
  'data': {'*option': 'str'},
@@ -558,13 +564,13 @@
 #    RTC in the system implements this event, or even that the system
 #    has an RTC at all.
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "RTC_CHANGE",
 #          "data": { "offset": 78 },
 #          "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
+# Since: 0.13
 ##
 { 'event': 'RTC_CHANGE',
   'data': { 'offset': 'int', 'qom-path': 'str' } }
@@ -585,8 +591,6 @@
 #
 # @dev-qom-path: path to attached PCI device in the QOM tree
 #
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "VFU_CLIENT_HANGUP",
@@ -595,6 +599,8 @@
 #                    "dev-id": "sas1",
 #                    "dev-qom-path": "/machine/peripheral/sas1" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 7.1
 ##
 { 'event': 'VFU_CLIENT_HANGUP',
   'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
diff --git a/qapi/net.json b/qapi/net.json
index c011d6dc1a9..2deb0b6dfdf 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -22,8 +22,6 @@
 # Errors:
 #     - If @name is not a valid network device, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. note:: Not all network adapters support setting link status.
 #    This command will succeed even if the network adapter does not
 #    support link status notification.
@@ -33,6 +31,8 @@
 #     -> { "execute": "set_link",
 #          "arguments": { "name": "e1000.0", "up": false } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'set_link', 'data': {'name': 'str', 'up': 'bool'} }
 
@@ -43,8 +43,6 @@
 #
 # Additional arguments depend on the type.
 #
-# Since: 0.14
-#
 # Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
@@ -54,6 +52,8 @@
 #          "arguments": { "type": "user", "id": "netdev1",
 #                         "dnssearch": [ { "str": "example.org" } ] } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'netdev_add', 'data': 'Netdev', 'boxed': true,
   'allow-preconfig': true }
@@ -68,12 +68,12 @@
 # Errors:
 #     - If @id is not a valid network backend, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'netdev_del', 'data': {'id': 'str'},
   'allow-preconfig': true }
@@ -975,8 +975,6 @@
 #     - if the given NIC doesn't support rx-filter querying
 #     - if the given net client isn't a NIC
 #
-# Since: 1.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
@@ -1005,6 +1003,8 @@
 #             }
 #           ]
 #        }
+#
+# Since: 1.6
 ##
 { 'command': 'query-rx-filter',
   'data': { '*name': 'str' },
@@ -1020,14 +1020,14 @@
 #
 # @path: device path
 #
-# Since: 1.6
-#
 # .. qmp-example::
 #
 #     <- { "event": "NIC_RX_FILTER_CHANGED",
 #          "data": { "name": "vnet0",
 #                    "path": "/machine/peripheral/vnet0/virtio-backend" },
 #          "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#
+# Since: 1.6
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
@@ -1095,13 +1095,13 @@
 #
 # @device-id: QEMU device id of the unplugged device
 #
-# Since: 4.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "FAILOVER_NEGOTIATED",
 #          "data": { "device-id": "net1" },
 #          "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#
+# Since: 4.2
 ##
 { 'event': 'FAILOVER_NEGOTIATED',
   'data': {'device-id': 'str'} }
@@ -1115,8 +1115,6 @@
 #
 # @addr: The destination address
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
@@ -1131,6 +1129,8 @@
 #          "data": { "netdev-id": "netdev0",
 #                    "addr": { "path": "/tmp/qemu0", "type": "unix" } },
 #          "timestamp": { "seconds": 1666269706, "microseconds": 413651 } }
+#
+# Since: 7.2
 ##
 { 'event': 'NETDEV_STREAM_CONNECTED',
   'data': { 'netdev-id': 'str',
@@ -1143,13 +1143,13 @@
 #
 # @netdev-id: QEMU netdev id that is disconnected
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "NETDEV_STREAM_DISCONNECTED",
 #          "data": {"netdev-id": "netdev0"},
 #          "timestamp": {"seconds": 1663330937, "microseconds": 526695} }
+#
+# Since: 7.2
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
@@ -1163,13 +1163,13 @@
 #
 # @chardev-id: The character device id used by the QEMU netdev
 #
-# Since: 10.0
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
 #          "event": "NETDEV_VHOST_USER_CONNECTED",
 #          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
+#
+# Since: 10.0
 ##
 { 'event': 'NETDEV_VHOST_USER_CONNECTED',
   'data': { 'netdev-id': 'str', 'chardev-id': 'str' } }
@@ -1181,13 +1181,13 @@
 #
 # @netdev-id: QEMU netdev id that is disconnected
 #
-# Since: 10.0
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
 #          "event": "NETDEV_VHOST_USER_DISCONNECTED",
 #          "data": { "netdev-id": "netdev0" } }
+#
+# Since: 10.0
 ##
 { 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
diff --git a/qapi/pci.json b/qapi/pci.json
index 694c741e420..c36af01a100 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -182,8 +182,6 @@
 #     of all PCI devices attached to it.  Each device is represented
 #     by a json-object.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-pci" }
@@ -314,5 +312,7 @@
 #        }
 #
 # This example has been shortened as the real response is too long.
+#
+# Since: 0.14
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 974cf9c5830..483bc9eb9cd 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -103,8 +103,6 @@
 #    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
 #    event is sent.  Some errors cannot be detected.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "device_del",
@@ -116,6 +114,8 @@
 #     -> { "execute": "device_del",
 #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
 
@@ -131,14 +131,14 @@
 #
 # @path: the device's QOM path
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     <- { "event": "DEVICE_DELETED",
 #          "data": { "device": "virtio-net-pci-0",
 #                    "path": "/machine/peripheral/virtio-net-pci-0" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 1.5
 ##
 { 'event': 'DEVICE_DELETED',
   'data': { '*device': 'str', 'path': 'str' } }
@@ -153,14 +153,14 @@
 #
 # @path: the device's QOM path
 #
-# Since: 6.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
 #          "data": { "device": "core1",
 #                    "path": "/machine/peripheral/core1" },
 #          "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
+#
+# Since: 6.2
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
diff --git a/qapi/qom.json b/qapi/qom.json
index fd88be07e13..9733a815a9b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -85,8 +85,6 @@
 #
 # Returns: a list that describe the properties of the object.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "qom-list",
@@ -95,6 +93,8 @@
 #                      { "name": "parallel0", "type": "child<chardev-vc>" },
 #                      { "name": "serial0", "type": "child<chardev-vc>" },
 #                      { "name": "mon0", "type": "child<chardev-stdio>" } ] }
+#
+# Since: 1.2
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
@@ -129,8 +129,6 @@
 #     child<> and link<> properties are returned as #str pathnames.
 #     All integer property types (u8, u16, etc) are returned as #int.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #    :title: Use absolute path
 #
@@ -146,6 +144,8 @@
 #          "arguments": { "path": "unattached/sysbus",
 #                         "property": "type" } }
 #     <- { "return": "System" }
+#
+# Since: 1.2
 ##
 { 'command': 'qom-get',
   'data': { 'path': 'str', 'property': 'str' },
@@ -186,8 +186,6 @@
 # @value: a value who's type is appropriate for the property type.
 #     See `qom-get` for a description of type mapping.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "qom-set",
@@ -195,6 +193,8 @@
 #                         "property": "graphics",
 #                         "value": false } }
 #     <- { "return": {} }
+#
+# Since: 1.2
 ##
 { 'command': 'qom-set',
   'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
@@ -1342,14 +1342,14 @@
 # Errors:
 #     - If @qom-type is not a valid class name
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "object-add",
 #          "arguments": { "qom-type": "rng-random", "id": "rng1",
 #                         "filename": "/dev/hwrng" } }
 #     <- { "return": {} }
+#
+# Since: 2.0
 ##
 { 'command': 'object-add', 'data': 'ObjectOptions', 'boxed': true,
   'allow-preconfig': true }
@@ -1364,12 +1364,12 @@
 # Errors:
 #     - If @id is not a valid id for a QOM object
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "object-del", "arguments": { "id": "rng1" } }
 #     <- { "return": {} }
+#
+# Since: 2.0
 ##
 { 'command': 'object-del', 'data': {'id': 'str'},
   'allow-preconfig': true }
diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68ef..bdee8e0ecfe 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -54,12 +54,12 @@
 #
 # Returns: record/replay information.
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-replay" }
 #     <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#
+# Since: 5.2
 ##
 { 'command': 'query-replay',
   'returns': 'ReplayInfo' }
@@ -76,12 +76,12 @@
 #
 # @icount: instruction count to stop at
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
+#
+# Since: 5.2
 ##
 { 'command': 'replay-break', 'data': { 'icount': 'int' } }
 
@@ -91,12 +91,14 @@
 # Remove replay breakpoint which was set with `replay-break`.  The
 # command is ignored when there are no replay breakpoints.
 #
-# Since: 5.2
+# Details:
 #
 # .. qmp-example::
 #
 #     -> { "execute": "replay-delete-break" }
 #     <- { "return": {} }
+#
+# Since: 5.2
 ##
 { 'command': 'replay-delete-break' }
 
@@ -112,11 +114,11 @@
 #
 # @icount: target instruction count
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
+#
+# Since: 5.2
 ##
 { 'command': 'replay-seek', 'data': { 'icount': 'int' } }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5d2dbd26034..e8efffc4c9f 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -30,12 +30,12 @@
 #
 # @name: switch name
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
 #     <- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker',
   'data': { 'name': 'str' },
@@ -98,8 +98,6 @@
 #
 # @name: port name
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
@@ -108,6 +106,8 @@
 #                      {"duplex": "full", "enabled": true, "name": "sw1.2",
 #                       "autoneg": "off", "link-up": true, "speed": 10000}
 #        ]}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker-ports',
   'data': { 'name': 'str' },
@@ -240,8 +240,6 @@
 #
 # Returns: rocker OF-DPA flow information
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker-of-dpa-flows",
@@ -254,6 +252,8 @@
 #                      },
 #                      ...
 #        ]}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker-of-dpa-flows',
   'data': { 'name': 'str', '*tbl-id': 'uint32' },
@@ -315,8 +315,6 @@
 #
 # Returns: rocker OF-DPA group information
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker-of-dpa-groups",
@@ -334,6 +332,8 @@
 #                       "pport": 0, "vlan-id": 3840,
 #                       "pop-vlan": 1, "id": 251658240}
 #        ]}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker-of-dpa-groups',
   'data': { 'name': 'str', '*type': 'uint8' },
diff --git a/qapi/run-state.json b/qapi/run-state.json
index a5771ad4681..1bc4e905f00 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -121,13 +121,15 @@
 #
 # Query the run status of the VM
 #
-# Since: 0.14
+# Details:
 #
 # .. qmp-example::
 #
 #     -> { "execute": "query-status" }
 #     <- { "return": { "running": true,
 #                      "status": "running" } }
+#
+# Since: 0.14
 ##
 { 'command': 'query-status', 'returns': 'StatusInfo',
   'allow-preconfig': true }
@@ -150,13 +152,13 @@
 #    specified, QEMU will not exit, and a `STOP` event will eventually
 #    follow the `SHUTDOWN` event.
 #
-# Since: 0.12
-#
 # .. qmp-example::
 #
 #     <- { "event": "SHUTDOWN",
 #          "data": { "guest": true, "reason": "guest-shutdown" },
 #          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
+# Since: 0.12
 ##
 { 'event': 'SHUTDOWN', 'data': { 'guest': 'bool', 'reason': 'ShutdownCause' } }
 
@@ -166,12 +168,14 @@
 # Emitted when the virtual machine is powered down through the power
 # control system, such as via ACPI.
 #
-# Since: 0.12
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "event": "POWERDOWN",
 #          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
+# Since: 0.12
 ##
 { 'event': 'POWERDOWN' }
 
@@ -187,13 +191,13 @@
 #
 # @reason: The `ShutdownCause` of the `RESET`.  (since 4.0)
 #
-# Since: 0.12
-#
 # .. qmp-example::
 #
 #     <- { "event": "RESET",
 #          "data": { "guest": false, "reason": "guest-reset" },
 #          "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
+#
+# Since: 0.12
 ##
 { 'event': 'RESET', 'data': { 'guest': 'bool', 'reason': 'ShutdownCause' } }
 
@@ -202,12 +206,14 @@
 #
 # Emitted when the virtual machine is stopped
 #
-# Since: 0.12
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "event": "STOP",
 #          "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#
+# Since: 0.12
 ##
 { 'event': 'STOP' }
 
@@ -216,12 +222,14 @@
 #
 # Emitted when the virtual machine resumes execution
 #
-# Since: 0.12
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "event": "RESUME",
 #          "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
+#
+# Since: 0.12
 ##
 { 'event': 'RESUME' }
 
@@ -231,12 +239,14 @@
 # Emitted when guest enters a hardware suspension state, for example,
 # S3 state, which is sometimes called standby state
 #
-# Since: 1.1
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "event": "SUSPEND",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#
+# Since: 1.1
 ##
 { 'event': 'SUSPEND' }
 
@@ -247,15 +257,17 @@
 # saved on disk, for example, S4 state, which is sometimes called
 # hibernate state
 #
+# Details:
+#
 # .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when
 #    entering this state.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "SUSPEND_DISK",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#
+# Since: 1.2
 ##
 { 'event': 'SUSPEND_DISK' }
 
@@ -265,12 +277,14 @@
 # Emitted when the guest has woken up from suspend state and is
 # running
 #
-# Since: 1.1
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "event": "WAKEUP",
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+# Since: 1.1
 ##
 { 'event': 'WAKEUP' }
 
@@ -287,13 +301,13 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "WATCHDOG",
 #          "data": { "action": "reset" },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 0.13
 ##
 { 'event': 'WATCHDOG',
   'data': { 'action': 'WatchdogAction' } }
@@ -380,13 +394,13 @@
 #
 # @action: `WatchdogAction` action taken when watchdog timer expires.
 #
-# Since: 2.11
-#
 # .. qmp-example::
 #
 #     -> { "execute": "watchdog-set-action",
 #          "arguments": { "action": "inject-nmi" } }
 #     <- { "return": {} }
+#
+# Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
 
@@ -405,8 +419,6 @@
 # @watchdog: `WatchdogAction` action taken when watchdog timer
 #     expires.
 #
-# Since: 6.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "set-action",
@@ -415,6 +427,8 @@
 #                         "panic": "pause",
 #                         "watchdog": "inject-nmi" } }
 #     <- { "return": {} }
+#
+# Since: 6.0
 ##
 { 'command': 'set-action',
   'data': { '*reboot': 'RebootAction',
@@ -432,13 +446,13 @@
 #
 # @info: information about a panic (since 2.9)
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     <- { "event": "GUEST_PANICKED",
 #          "data": { "action": "pause" },
 #          "timestamp": { "seconds": 1648245231, "microseconds": 900001 } }
+#
+# Since: 1.5
 ##
 { 'event': 'GUEST_PANICKED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
@@ -452,13 +466,13 @@
 #
 # @info: information about a panic
 #
-# Since: 5.0
-#
 # .. qmp-example::
 #
 #     <- { "event": "GUEST_CRASHLOADED",
 #          "data": { "action": "run" },
 #          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+#
+# Since: 5.0
 ##
 { 'event': 'GUEST_CRASHLOADED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
@@ -468,12 +482,14 @@
 #
 # Emitted when guest submits a shutdown request via pvpanic interface
 #
-# Since: 9.1
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "event": "GUEST_PVSHUTDOWN",
 #          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+#
+# Since: 9.1
 ##
 { 'event': 'GUEST_PVSHUTDOWN' }
 
@@ -655,8 +671,6 @@
 #
 # @flags: flags for `MemoryFailureAction`.
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "MEMORY_FAILURE",
@@ -665,6 +679,8 @@
 #                    "flags": { "action-required": false,
 #                               "recursive": false } },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 5.2
 ##
 { 'event': 'MEMORY_FAILURE',
   'data': { 'recipient': 'MemoryFailureRecipient',
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 3f2850a5733..8b1be5fa4db 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -29,12 +29,12 @@
 #
 # Return a list of supported TPM models
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-tpm-models" }
 #     <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
+#
+# Since: 1.5
 ##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'],
   'if': 'CONFIG_TPM' }
@@ -58,12 +58,12 @@
 #
 # Return a list of supported TPM types
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-tpm-types" }
 #     <- { "return": [ "passthrough", "emulator" ] }
+#
+# Since: 1.5
 ##
 { 'command': 'query-tpm-types', 'returns': ['TpmType'],
   'if': 'CONFIG_TPM' }
@@ -164,8 +164,6 @@
 #
 # Return information about the TPM device
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-tpm" }
@@ -183,6 +181,8 @@
 #            }
 #          ]
 #        }
+#
+# Since: 1.5
 ##
 { 'command': 'query-tpm', 'returns': ['TPMInfo'],
   'if': 'CONFIG_TPM' }
diff --git a/qapi/trace.json b/qapi/trace.json
index de369dae6b5..63685b3d5ec 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -51,13 +51,13 @@
 #
 # Returns: a list of info for the matching events
 #
-# Since: 2.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "trace-event-get-state",
 #          "arguments": { "name": "qemu_memalign" } }
 #     <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
+#
+# Since: 2.2
 ##
 { 'command': 'trace-event-get-state',
   'data': {'name': 'str' },
@@ -74,13 +74,13 @@
 #
 # @ignore-unavailable: Do not match unavailable events with @name.
 #
-# Since: 2.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "trace-event-set-state",
 #          "arguments": { "name": "qemu_memalign", "enable": true } }
 #     <- { "return": {} }
+#
+# Since: 2.2
 ##
 { 'command': 'trace-event-set-state',
   'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool' } }
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 4b4eb09bf38..1e6b5d37980 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -244,8 +244,6 @@
 #    in an error condition, and subsequent actions will not have been
 #    attempted.
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "transaction",
@@ -266,6 +264,8 @@
 #                                          "device": "ide-hd2",
 #                                          "name": "snapshot0" } } ] } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'transaction',
   'data': { 'actions': [ 'TransactionAction' ],
diff --git a/qapi/ui.json b/qapi/ui.json
index e3da77632a8..0fd6b144394 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -83,13 +83,13 @@
 # Errors:
 #     - If Spice is not enabled, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "set_password", "arguments": { "protocol": "vnc",
 #                                                    "password": "secret" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'set_password', 'boxed': true, 'data': 'SetPasswordOptions' }
 
@@ -145,13 +145,13 @@
 #     - If @protocol is 'spice' and Spice is not active,
 #       DeviceNotFound
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
 #                                                       "time": "+60" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'expire_password', 'boxed': true, 'data': 'ExpirePasswordOptions' }
 
@@ -187,13 +187,13 @@
 #
 # @format: image format for `screendump`.  (default: ppm) (Since 7.1)
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "screendump",
 #          "arguments": { "filename": "/tmp/image" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'screendump',
   'data': {'filename': 'str', '*device': 'str', '*head': 'int',
@@ -328,8 +328,6 @@
 #
 # Return information about the current SPICE server
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-spice" }
@@ -364,6 +362,8 @@
 #              ]
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
   'if': 'CONFIG_SPICE' }
@@ -377,8 +377,6 @@
 #
 # @client: client information
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
@@ -387,6 +385,8 @@
 #            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
 #            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
 #        }}
+#
+# Since: 0.14
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -403,8 +403,6 @@
 #
 # @client: client information
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
@@ -415,6 +413,8 @@
 #                              "connection-id": 1804289383, "host": "127.0.0.1",
 #                              "channel-id": 0, "tls": true}
 #        }}
+#
+# Since: 0.14
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
@@ -430,8 +430,6 @@
 #
 # @client: client information
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
@@ -440,6 +438,8 @@
 #            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
 #            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
 #        }}
+#
+# Since: 0.14
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -451,12 +451,14 @@
 #
 # Emitted when SPICE migration has completed
 #
-# Since: 1.3
+# Details:
 #
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
 #          "event": "SPICE_MIGRATE_COMPLETED" }
+#
+# Since: 1.3
 ##
 { 'event': 'SPICE_MIGRATE_COMPLETED',
   'if': 'CONFIG_SPICE' }
@@ -658,8 +660,6 @@
 #
 # Return information about the current VNC server
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-vnc" }
@@ -679,6 +679,8 @@
 #              ]
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-vnc', 'returns': 'VncInfo',
   'if': 'CONFIG_VNC' }
@@ -700,11 +702,11 @@
 #
 # @password: the new password to use with VNC authentication
 #
-# Since: 1.1
-#
 # .. note:: An empty password in this command will set the password to
 #    the empty string.  Existing clients are unaffected by executing
 #    this command.
+#
+# Since: 1.1
 ##
 { 'command': 'change-vnc-password',
   'data': { 'password': 'str' },
@@ -722,8 +724,6 @@
 # .. note:: This event is emitted before any authentication takes
 #    place, thus the authentication ID is not provided.
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "VNC_CONNECTED",
@@ -733,6 +733,8 @@
 #                "client": { "family": "ipv4", "service": "58425",
 #                            "host": "127.0.0.1", "websocket": false } },
 #          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
+# Since: 0.13
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -749,8 +751,6 @@
 #
 # @client: client information
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <-  { "event": "VNC_INITIALIZED",
@@ -760,6 +760,8 @@
 #                "client": { "family": "ipv4", "service": "46089", "websocket": false,
 #                            "host": "127.0.0.1", "sasl_username": "luiz" } },
 #           "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
+#
+# Since: 0.13
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
@@ -775,8 +777,6 @@
 #
 # @client: client information
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "VNC_DISCONNECTED",
@@ -786,6 +786,8 @@
 #                "client": { "family": "ipv4", "service": "58425", "websocket": false,
 #                            "host": "127.0.0.1", "sasl_username": "luiz" } },
 #          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
+# Since: 0.13
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -825,8 +827,6 @@
 #
 # Returns: a list of info for each device
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-mice" }
@@ -845,6 +845,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-mice', 'returns': ['MouseInfo'] }
 
@@ -1035,8 +1037,6 @@
 # Errors:
 #     - If key is unknown or redundant, GenericError
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "send-key",
@@ -1044,6 +1044,8 @@
 #                                   { "type": "qcode", "data": "alt" },
 #                                   { "type": "qcode", "data": "delete" } ] } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'send-key',
   'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
@@ -1265,8 +1267,6 @@
 #
 # @events: List of `InputEvent` union.
 #
-# Since: 2.6
-#
 # .. note:: The consoles are visible in the qom tree, under
 #    ``/backend/console[$index]``.  They have a device link and head
 #    property, so it is possible to map which console belongs to which
@@ -1308,6 +1308,8 @@
 #                    { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
 #                    { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
 #     <- { "return": {} }
+#
+# Since: 2.6
 ##
 { 'command': 'input-send-event',
   'data': { '*device': 'str',
@@ -1620,13 +1622,15 @@
 #
 # Reload display configuration.
 #
-# Since: 6.0
+# Details:
 #
 # .. qmp-example::
 #
 #     -> { "execute": "display-reload",
 #          "arguments": { "type": "vnc", "tls-certs": true  } }
 #     <- { "return": {} }
+#
+# Since: 6.0
 ##
 { 'command': 'display-reload',
   'data': 'DisplayReloadOptions',
@@ -1677,7 +1681,7 @@
 #
 # Update display configuration.
 #
-# Since: 7.1
+# Details:
 #
 # .. qmp-example::
 #
@@ -1686,6 +1690,8 @@
 #                         [ { "type": "inet", "host": "0.0.0.0",
 #                             "port": "5901" } ] } }
 #     <- { "return": {} }
+#
+# Since: 7.1
 ##
 { 'command': 'display-update',
   'data': 'DisplayUpdateOptions',
@@ -1708,8 +1714,6 @@
 #
 # @cert-subject: server certificate subject
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "client_migrate_info",
@@ -1717,6 +1721,8 @@
 #                         "hostname": "virt42.lab.kraxel.org",
 #                         "port": 1234 } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'client_migrate_info',
   'data': { 'protocol': 'str', 'hostname': 'str', '*port': 'int',
diff --git a/qapi/vfio.json b/qapi/vfio.json
index 17b60468712..630e2595c82 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -58,8 +58,6 @@
 #
 # @device-state: The new changed device migration state.
 #
-# Since: 9.1
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
@@ -68,6 +66,8 @@
 #              "device-id": "vfio_dev1",
 #              "qom-path": "/machine/peripheral/vfio_dev1",
 #              "device-state": "stop" } }
+#
+# Since: 9.1
 ##
 { 'event': 'VFIO_MIGRATION',
   'data': {
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 447fc182625..ae795e1e852 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -34,8 +34,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-query-virtio" }
@@ -62,6 +60,8 @@
 #              }
 #          ]
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio',
   'returns': [ 'VirtioInfo' ],
@@ -203,8 +203,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -437,6 +435,8 @@
 #              "use-started": true
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-status',
   'data': { 'path': 'str' },
@@ -579,8 +579,6 @@
 #    shadow_avail_idx will not be displayed in the case where the
 #    selected VirtIODevice has a running vhost device.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -635,6 +633,8 @@
 #              "vring-num": 128
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-queue-status',
   'data': { 'path': 'str', 'queue': 'uint16' },
@@ -707,8 +707,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :title: Get vhost_virtqueue status for vhost-crypto
 #
@@ -756,6 +754,8 @@
 #              "kick": 0
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-vhost-queue-status',
   'data': { 'path': 'str', 'queue': 'uint16' },
@@ -854,8 +854,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :title: Introspect on virtio-net's VirtQueue 0 at index 5
 #
@@ -943,6 +941,8 @@
 #              }
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-queue-element',
   'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
-- 
2.53.0


