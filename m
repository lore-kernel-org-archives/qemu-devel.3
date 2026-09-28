Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C36CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJzE-0007M3-Pf; Mon, 28 Sep 2026 18:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzC-0007IP-IB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJz7-0006GW-EW
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p2rHo3xZmKhObMND9uO8PGO3GW2vXVRnW0Y9bXrVLc=;
 b=FCnl8sxXEyK0g+OWd8klWycC/j/DrUXkqlGWofMeQH6qtCL3IbO3r9dEy6191P8KcsA8l/
 L19+aLmj++iCiv7HBzNqJ3cOAjdaSP/xm3m5PKoFSh2MBJCt/ZA2/gZDSSJ/hxCE0zc3B5
 B/ZwklY4ESW2x0IhV0PHChm/r/KaAKg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-1s6aJKc8N92nlLScosiPsA-1; Mon,
 28 Sep 2026 18:38:04 -0400
X-MC-Unique: 1s6aJKc8N92nlLScosiPsA-1
X-Mimecast-MFC-AGG-ID: 1s6aJKc8N92nlLScosiPsA_1790635082
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8452618052C0; Mon, 28 Sep 2026 22:38:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B24AE19560AB; Mon, 28 Sep 2026 22:37:57 +0000 (UTC)
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
Subject: [PATCH 07/14] qapi: re-order 'since' sections to always be last
Date: Mon, 28 Sep 2026 18:36:50 -0400
Message-ID: <20260928223657.2303684-8-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch moves "Since:" sections to always be the last section.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/firmware.json   |   4 +-
 docs/interop/vhost-user.json |   3 +-
 qapi/accelerator.json        |   8 +--
 qapi/acpi.json               |   8 +--
 qapi/block-core.json         | 136 +++++++++++++++++------------------
 qapi/block.json              |  44 ++++++------
 qapi/char.json               |  36 +++++-----
 qapi/control.json            |  12 ++--
 qapi/dump.json               |  16 ++---
 qapi/machine-s390x.json      |   8 +--
 qapi/machine.json            |  84 +++++++++++-----------
 qapi/migration.json          |  92 ++++++++++++------------
 qapi/misc-arm.json           |   4 +-
 qapi/misc-i386.json          |  36 +++++-----
 qapi/misc.json               |  64 ++++++++---------
 qapi/net.json                |  48 ++++++-------
 qapi/pci.json                |   4 +-
 qapi/qdev.json               |  12 ++--
 qapi/qom.json                |  20 +++---
 qapi/replay.json             |  16 ++---
 qapi/rocker.json             |  16 ++---
 qapi/run-state.json          |  64 ++++++++---------
 qapi/tpm.json                |  12 ++--
 qapi/trace.json              |   8 +--
 qapi/transaction.json        |   4 +-
 qapi/ui.json                 |  76 ++++++++++----------
 qapi/vfio.json               |   4 +-
 qapi/virtio.json             |  20 +++---
 28 files changed, 429 insertions(+), 430 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index c463fa6d05b..6366d01672f 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -482,8 +482,6 @@
 #     debugging purposes only, and management software shall
 #     explicitly ignore it.
 #
-# Since: 3.0
-#
 # It is possible for multiple @Firmware elements to match the search
 # criteria of management software.  Applications thus need rules to
 # pick one of the many matches, and users need the ability to override
@@ -738,6 +736,8 @@
 #             "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
 #         ]
 #     }
+#
+# Since: 3.0
 ##
 { 'struct' : 'Firmware',
   'data'   : { 'description'     : 'str',
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index 9a49ab6c14d..a64da30bad7 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -197,8 +197,6 @@
 #     development and debugging purposes only, and management software
 #     shall explicitly ignore it.
 #
-# Since: 4.0
-#
 # It is possible for multiple @VhostUserBackend elements to match the
 # search criteria of management software.  Applications thus need
 # rules to pick one of the many matches, and users need the ability to
@@ -269,6 +267,7 @@
 #   ]
 # }
 #
+# Since: 4.0
 ##
 {
   'struct' : 'VhostUserBackend',
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 9f6a322685f..a4e40f3286d 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -32,12 +32,12 @@
 # @deprecated: This command is deprecated.  Use `query-accelerators`
 #     instead.
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
 { 'command': 'query-kvm', 'returns': 'KvmInfo',
   'features': [ 'deprecated' ] }
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
index 8204d7ba52a..f52533300ea 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -108,8 +108,6 @@
 #     Return a list of `ACPIOSTInfo` for devices
 #     that support status reporting via ACPI _OST method.
 #
-# Since: 2.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-acpi-ospm-status" }
@@ -118,6 +116,8 @@
 #                      { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
 #                      { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
 #        ]}
+#
+# Since: 2.1
 ##
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
@@ -127,14 +127,14 @@
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
index c92dbb80818..3c7ef1ef251 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -885,8 +885,6 @@
 # Returns: a list describing each virtual block device.  Filter nodes
 #     that were created implicitly are skipped over.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-block" }
@@ -970,6 +968,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
   'data': { '*flat': 'bool' },
@@ -1283,8 +1283,6 @@
 #
 # Returns: A list of statistics for each virtual block device.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-blockstats" }
@@ -1386,6 +1384,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-blockstats',
   'data': { '*query-nodes': 'bool' },
@@ -1566,8 +1566,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 0.14
-#
 # Either @device or @node-name must be set but not both.
 #
 # .. qmp-example::
@@ -1575,6 +1573,8 @@
 #     -> { "execute": "block_resize",
 #          "arguments": { "device": "scratch", "size": 1073741824 } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'block_resize',
   'data': { '*device': 'str',
@@ -1793,8 +1793,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-sync",
@@ -1803,6 +1801,8 @@
 #                         "/some/place/my-image",
 #                         "format": "qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'blockdev-snapshot-sync',
   'data': 'BlockdevSnapshotSync',
@@ -1824,8 +1824,6 @@
 #     backing file of a destination of a `blockdev-mirror`.
 #     (since 5.0)
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -1841,6 +1839,8 @@
 #          "arguments": { "node": "ide-hd0",
 #                         "overlay": "node1534" } }
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-snapshot',
   'data': 'BlockdevSnapshot',
@@ -1955,8 +1955,6 @@
 # @deprecated: Members @base and @top are deprecated.  Use @base-node
 #     and @top-node instead.
 #
-# Since: 1.3
-#
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
 # itself.  The user needs to complete the job with the `job-complete`
@@ -1974,6 +1972,8 @@
 #          "arguments": { "device": "virtio0",
 #                         "top": "/tmp/snap1.qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
@@ -2004,8 +2004,6 @@
 # @deprecated: This command is deprecated.  Use `blockdev-backup`
 #     instead.
 #
-# Since: 1.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "drive-backup",
@@ -2013,6 +2011,8 @@
 #                         "sync": "full",
 #                         "target": "backup.img" } }
 #     <- { "return": {} }
+#
+# Since: 1.6
 ##
 { 'command': 'drive-backup', 'boxed': true,
   'data': 'DriveBackup', 'features': ['deprecated'],
@@ -2030,8 +2030,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 2.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-backup",
@@ -2039,6 +2037,8 @@
 #                         "sync": "full",
 #                         "target": "tgt-id" } }
 #     <- { "return": {} }
+#
+# Since: 2.3
 ##
 { 'command': 'blockdev-backup', 'boxed': true,
   'data': 'BlockdevBackup',
@@ -2051,8 +2051,6 @@
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-named-block-nodes" }
@@ -2101,6 +2099,8 @@
 #                               "virtual-size":2048000
 #                           }
 #                        } } ] }
+#
+# Since: 2.0
 ##
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
@@ -2228,8 +2228,6 @@
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "drive-mirror",
@@ -2238,6 +2236,8 @@
 #                         "sync": "full",
 #                         "format": "qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'drive-mirror', 'boxed': true,
   'data': 'DriveMirror',
@@ -2405,13 +2405,13 @@
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
@@ -2428,13 +2428,13 @@
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
@@ -2450,13 +2450,13 @@
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
@@ -2471,13 +2471,13 @@
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
@@ -2492,13 +2492,13 @@
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
@@ -2523,14 +2523,14 @@
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
@@ -2629,8 +2629,6 @@
 #     mirror.  Setting this to true when the destination is not
 #     actually all zero can corrupt the destination.  (Since 10.1)
 #
-# Since: 2.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-mirror",
@@ -2638,6 +2636,8 @@
 #                         "target": "target0",
 #                         "sync": "full" } }
 #     <- { "return": {} }
+#
+# Since: 2.6
 ##
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
@@ -2920,8 +2920,6 @@
 # Errors:
 #     - If @device does not exist, DeviceNotFound.
 #
-# Since: 1.1
-#
 # The block streaming operation is performed in the background until
 # the entire backing file has been copied.  This command returns
 # immediately once streaming has started.  The status of ongoing block
@@ -2958,6 +2956,8 @@
 #          "arguments": { "device": "virtio0",
 #                         "base": "/tmp/master.qcow2" } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
@@ -4858,8 +4858,6 @@
 # @blockdev-add:
 #     Creates a new block device.
 #
-# Since: 2.9
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -4899,6 +4897,8 @@
 #          }
 #
 #     <- { "return": {} }
+#
+# Since: 2.9
 ##
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true,
   'allow-preconfig': true }
@@ -4957,8 +4957,6 @@
 #
 # @node-name: Name of the graph node to delete.
 #
-# Since: 2.9
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -4977,6 +4975,8 @@
 #          "arguments": { "node-name": "node0" }
 #        }
 #     <- { "return": {} }
+#
+# Since: 2.9
 ##
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' },
   'allow-preconfig': true }
@@ -4992,8 +4992,6 @@
 # @active: true if the nodes should be active when the command returns
 #     success, false if they should be inactive.
 #
-# Since: 10.0
-#
 # Activating a node automatically activates all of its child nodes
 # first.  Deactivating a node automatically deactivates any of its
 # child nodes that are not in use by a still active node.
@@ -5007,6 +5005,8 @@
 #          }
 #        }
 #     <- { "return": {} }
+#
+# Since: 10.0
 ##
 { 'command': 'blockdev-set-active',
   'data': { '*node-name': 'str', 'active': 'bool' },
@@ -5646,8 +5646,6 @@
 #
 # .. note:: This event is rate-limited, except if action is "stop".
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_IO_ERROR",
@@ -5658,6 +5656,8 @@
 #                    "action": "stop",
 #                    "reason": "No space left on device" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 0.13
 ##
 { 'event': 'BLOCK_IO_ERROR',
   'data': { 'qom-path': 'str', 'device': 'str', '*node-name': 'str',
@@ -5686,8 +5686,6 @@
 #     other than that streaming has failed and clients should not try
 #     to interpret the error string
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_COMPLETED",
@@ -5695,6 +5693,8 @@
 #                    "len": 10737418240, "offset": 10737418240,
 #                    "speed": 0 },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 1.1
 ##
 { 'event': 'BLOCK_JOB_COMPLETED',
   'data': { 'type'  : 'JobType',
@@ -5720,8 +5720,6 @@
 #
 # @speed: rate limit, bytes per second
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_CANCELLED",
@@ -5729,6 +5727,8 @@
 #                    "len": 10737418240, "offset": 134217728,
 #                    "speed": 0 },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 1.1
 ##
 { 'event': 'BLOCK_JOB_CANCELLED',
   'data': { 'type'  : 'JobType',
@@ -5748,8 +5748,6 @@
 #
 # @action: action that has been taken
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_ERROR",
@@ -5757,6 +5755,8 @@
 #                    "operation": "write",
 #                    "action": "stop" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 1.3
 ##
 { 'event': 'BLOCK_JOB_ERROR',
   'data': { 'device'   : 'str',
@@ -5782,14 +5782,14 @@
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
@@ -5809,13 +5809,13 @@
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
@@ -5881,14 +5881,14 @@
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
@@ -5915,8 +5915,6 @@
 #     'children' list of `BlockdevOptionsQuorum`, as returned by
 #     .bdrv_refresh_filename().
 #
-# Since: 2.7
-#
 # Currently only supports adding and deleting quorum children.  A
 # child will be added at the end of the list of children.  Its
 # contents *must* be consistent with the other childrens' contents.
@@ -5945,6 +5943,8 @@
 #          "arguments": { "parent": "disk1",
 #                         "child": "children.1" } }
 #     <- { "return": {} }
+#
+# Since: 2.7
 ##
 { 'command': 'x-blockdev-change',
   'data' : { 'parent': 'str',
@@ -5972,8 +5972,6 @@
 # @unstable: This command is experimental and intended for test cases
 #     that need control over IOThreads only.
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #    :title: Move a node into an IOThread
 #
@@ -5989,6 +5987,8 @@
 #          "arguments": { "node-name": "disk1",
 #                         "iothread": null } }
 #     <- { "return": {} }
+#
+# Since: 2.12
 ##
 { 'command': 'x-blockdev-set-iothread',
   'data' : { 'node-name': 'str',
@@ -6025,13 +6025,13 @@
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
@@ -6055,8 +6055,6 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #    :title: Read operation
 #
@@ -6072,6 +6070,8 @@
 #          "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
 #                    "type": "flush", "error": "Broken pipe" },
 #          "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#
+# Since: 2.0
 ##
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
@@ -6107,8 +6107,6 @@
 # .. note:: Only some image formats such as qcow2 and rbd support
 #    internal snapshots.
 #
-# Since: 1.7
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-internal-sync",
@@ -6116,6 +6114,8 @@
 #                         "name": "snapshot0" }
 #        }
 #     <- { "return": {} }
+#
+# Since: 1.7
 ##
 { 'command': 'blockdev-snapshot-internal-sync',
   'data': 'BlockdevSnapshotInternal',
@@ -6143,8 +6143,6 @@
 #       GenericError
 #     - If @id and @name are both not specified, GenericError
 #
-# Since: 1.7
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-delete-internal-sync",
@@ -6162,6 +6160,8 @@
 #                        "icount": 220414
 #          }
 #        }
+#
+# Since: 1.7
 ##
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
diff --git a/qapi/block.json b/qapi/block.json
index 99b888d78e9..51be0c8eb0f 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -114,12 +114,12 @@
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
@@ -143,8 +143,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Since: 2.5
-#
 # If there is a block driver state tree inserted as a medium, it will
 # become inaccessible to the guest (but it will remain associated to
 # the block device, so closing the tray will make it accessible
@@ -174,6 +172,8 @@
 #                    "tray-open": true } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-open-tray',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -192,8 +192,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Since: 2.5
-#
 # If there is a block driver state tree associated with the block
 # device (which is currently ejected), that tree will be loaded as the
 # medium.
@@ -213,6 +211,8 @@
 #                    "tray-open": false } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-close-tray',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -226,8 +226,6 @@
 #
 # @id: The name or QOM path of the guest device
 #
-# Since: 2.12
-#
 # If the tray is open and there is no medium inserted, this will
 # be a no-op.
 #
@@ -255,6 +253,8 @@
 #          "arguments": { "id": "ide0-1-0" } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.12
 ##
 { 'command': 'blockdev-remove-medium',
   'data': { 'id': 'str' } }
@@ -270,8 +270,6 @@
 #
 # @node-name: name of a node in the block driver state graph
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
@@ -287,6 +285,8 @@
 #                         "node-name": "node0" } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.12
 ##
 { 'command': 'blockdev-insert-medium',
   'data': { 'id': 'str',
@@ -338,8 +338,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #    :title: Change a removable medium
 #
@@ -369,6 +367,8 @@
 #                         "read-only-mode": "read-only" } }
 #
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'blockdev-change-medium',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -392,8 +392,6 @@
 # @tray-open: true if the tray has been opened or false if it has been
 #     closed
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "DEVICE_TRAY_MOVED",
@@ -402,6 +400,8 @@
 #                    "tray-open": true
 #          },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 1.1
 ##
 { 'event': 'DEVICE_TRAY_MOVED',
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
@@ -415,8 +415,6 @@
 #
 # @connected: true if the PR manager is connected to a backend
 #
-# Since: 3.0
-#
 # .. qmp-example::
 #
 #     <- { "event": "PR_MANAGER_STATUS_CHANGED",
@@ -424,6 +422,8 @@
 #                    "connected": true
 #          },
 #          "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
+#
+# Since: 3.0
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
@@ -435,8 +435,6 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Since: 1.1
-#
 # Since QEMU 2.4, each device with I/O limits is member of a throttle
 # group.
 #
@@ -497,6 +495,8 @@
 #                         "bps_max_length": 60,
 #                         "iops_size": 0 } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'block_set_io_throttle', 'boxed': true,
   'data': 'BlockIOThrottle',
@@ -533,8 +533,6 @@
 # Errors:
 #     - if device is not found or any boundary arrays are invalid.
 #
-# Since: 4.0
-#
 # If only @id parameter is specified, remove all present latency
 # histograms for the device.  Otherwise, add/reset some of (or all)
 # latency histograms.
@@ -585,6 +583,8 @@
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0" } }
 #     <- { "return": {} }
+#
+# Since: 4.0
 ##
 { 'command': 'block-latency-histogram-set',
   'data': {'id': 'str',
@@ -611,8 +611,6 @@
 #
 # @unstable: This command is for testing only.
 #
-# Since: 11.2
-#
 # Take either a block backend name or a qdev ID to identify the
 # device.
 #
@@ -622,6 +620,8 @@
 #          "arguments": { "device": "virtio0",
 #                         "command": "read 0 512" } }
 #     <- { "return": {} }
+#
+# Since: 11.2
 ##
 { 'command': 'x-qemu-io',
   'data': { '*device': 'str',
diff --git a/qapi/char.json b/qapi/char.json
index 7ae67eedff8..cad2c0ecd5f 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -36,8 +36,6 @@
 # @query-chardev:
 #     Return information about current character devices.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-chardev" }
@@ -60,6 +58,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-chardev', 'returns': ['ChardevInfo'],
   'allow-preconfig': true }
@@ -78,8 +78,6 @@
 # @query-chardev-backends:
 #     Return information about character device backends.
 #
-# Since: 2.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-chardev-backends" }
@@ -99,6 +97,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 2.0
 ##
 { 'command': 'query-chardev-backends', 'returns': ['ChardevBackendInfo'] }
 
@@ -131,8 +131,6 @@
 #     - data itself is always Unicode regardless of format, like any
 #       other string.
 #
-# Since: 1.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "ringbuf-write",
@@ -140,6 +138,8 @@
 #                         "data": "abcdefgh",
 #                         "format": "utf8" } }
 #     <- { "return": {} }
+#
+# Since: 1.4
 ##
 { 'command': 'ringbuf-write',
   'data': { 'device': 'str',
@@ -166,8 +166,6 @@
 #
 # Returns: data read from the device
 #
-# Since: 1.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "ringbuf-read",
@@ -175,6 +173,8 @@
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
@@ -798,8 +798,6 @@
 #
 # @backend: new backend type and parameters
 #
-# Since: 2.10
-#
 # .. qmp-example::
 #
 #     -> { "execute" : "chardev-change",
@@ -824,6 +822,8 @@
 #                      "server" : true,
 #                      "wait" : false }}}}
 #     <- {"return": {}}
+#
+# Since: 2.10
 ##
 { 'command': 'chardev-change',
   'data': { 'id': 'str',
@@ -836,12 +836,12 @@
 #
 # @id: the chardev's ID, must not be in use
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
@@ -852,12 +852,12 @@
 #
 # @id: the chardev's ID
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
@@ -872,13 +872,13 @@
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
index ef63a8a261b..1f687d42b47 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -93,8 +93,6 @@
 #
 # Returns: An object describing the current version of QEMU.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-version" }
@@ -108,6 +106,8 @@
 #              "package":""
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-version', 'returns': 'VersionInfo',
   'allow-preconfig': true }
@@ -128,8 +128,6 @@
 #
 # Returns: A list of all supported commands
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-commands" }
@@ -146,6 +144,8 @@
 #        }
 #
 # This example has been shortened as the real response is too long.
+#
+# Since: 0.14
 ##
 { 'command': 'query-commands', 'returns': ['CommandInfo'],
   'allow-preconfig': true }
@@ -158,12 +158,12 @@
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
index 9e97e8431f4..4e238fb67cd 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -99,13 +99,13 @@
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
@@ -153,13 +153,13 @@
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
 
@@ -173,14 +173,14 @@
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
@@ -202,13 +202,13 @@
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
index 911989bb4f7..ed8f424ddd5 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -65,8 +65,6 @@
 #
 # @unstable: This event is experimental.
 #
-# Since: 8.2
-#
 # The guest can tell the host (via the PTF instruction) whether the
 # CPUs should be provisioned using horizontal or vertical
 # polarization.
@@ -83,6 +81,8 @@
 #     <- { "event": "CPU_POLARIZATION_CHANGE",
 #          "data": { "polarization": "horizontal" },
 #          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+# Since: 8.2
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'S390CpuPolarization' },
@@ -125,12 +125,12 @@
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
index 8aae66fcfde..7832708950d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -103,8 +103,6 @@
 # @query-cpus-fast:
 #     Return information about all virtual CPUs.
 #
-# Since: 2.12
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-cpus-fast" }
@@ -133,6 +131,8 @@
 #             }
 #         ]
 #     }
+#
+# Since: 2.12
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
@@ -221,8 +221,6 @@
 #
 # @unstable: Argument @compat-props is experimental.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-machines", "arguments": { "compat-props": true } }
@@ -245,6 +243,8 @@
 #               },
 #               ...
 #        }
+#
+# Since: 1.2
 ##
 { 'command': 'query-machines',
   'data': { '*compat-props': { 'type': 'bool',
@@ -297,10 +297,10 @@
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
 
@@ -308,12 +308,12 @@
 # @query-uuid:
 #     Query the guest UUID information.
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
 
@@ -339,12 +339,12 @@
 # @system_reset:
 #     Performs a hard reset of a guest.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "system_reset" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'system_reset' }
 
@@ -352,8 +352,6 @@
 # @system_powerdown:
 #     Requests that a guest perform a powerdown operation.
 #
-# Since: 0.14
-#
 # .. note:: A guest may or may not respond to this command.  This
 #    command returning does not indicate that a guest has accepted the
 #    request or that it has shut down.  Many guests will respond to
@@ -363,6 +361,8 @@
 #
 #     -> { "execute": "system_powerdown" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'system_powerdown' }
 
@@ -373,8 +373,6 @@
 #     `query-current-machine`), wake-up guest from suspend if the
 #     guest is in SUSPENDED state.  Return an error otherwise.
 #
-# Since: 1.1
-#
 # .. note:: Prior to 4.0, this command does nothing in case the guest
 #    isn't suspended.
 #
@@ -382,6 +380,8 @@
 #
 #     -> { "execute": "system_wakeup" }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'system_wakeup' }
 
@@ -423,8 +423,6 @@
 #     machines all vCPUs receive it).  The command fails when the
 #     guest doesn't support injecting.
 #
-# Since: 0.14
-#
 # .. note:: Prior to 2.1, this command was only supported for x86 and
 #    s390 VMs.
 #
@@ -432,6 +430,8 @@
 #
 #     -> { "execute": "inject-nmi" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'inject-nmi' }
 
@@ -807,8 +807,6 @@
 # @cpu-index: the index of the virtual CPU to use for translating the
 #     virtual address (defaults to CPU 0)
 #
-# Since: 0.14
-#
 # .. caution:: Errors were not reliably returned until 1.1.
 #
 # .. qmp-example::
@@ -818,6 +816,8 @@
 #                         "size": 100,
 #                         "filename": "/tmp/virtual-mem-dump" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'memsave',
   'data': {
@@ -836,8 +836,6 @@
 #
 # @filename: the file to save the memory to as binary data
 #
-# Since: 0.14
-#
 # .. caution:: Errors were not reliably returned until 1.1.
 #
 # .. qmp-example::
@@ -847,6 +845,8 @@
 #                         "size": 100,
 #                         "filename": "/tmp/physical-mem-dump" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'pmemsave',
   'data': {
@@ -898,8 +898,6 @@
 # @query-memdev:
 #     Return information for all memory backends.
 #
-# Since: 2.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-memdev" }
@@ -925,6 +923,8 @@
 #            }
 #          ]
 #        }
+#
+# Since: 2.1
 ##
 { 'command': 'query-memdev', 'returns': ['Memdev'], 'allow-preconfig': true }
 
@@ -1012,8 +1012,6 @@
 #
 # TODO: Better documentation; currently there is none.
 #
-# Since: 2.7
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -1064,6 +1062,8 @@
 #             "props": { "core-id": 0 }
 #          }
 #        ]}
+#
+# Since: 2.7
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
              'allow-preconfig': true }
@@ -1101,8 +1101,6 @@
 #    returns, the balloon size may not have changed.  A guest can
 #    change the balloon size independent of this command.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -1112,6 +1110,8 @@
 #      <- { "return": {} }
 #
 #    With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#
+# Since: 0.14
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
@@ -1135,8 +1135,6 @@
 #       the KVM kernel module cannot support it, KVMMissingCap
 #     - If no balloon device is present, DeviceNotActive
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-balloon" }
@@ -1144,6 +1142,8 @@
 #              "actual": 1073741824
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-balloon', 'returns': 'BalloonInfo' }
 
@@ -1158,13 +1158,13 @@
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
@@ -1195,8 +1195,6 @@
 #       reporting is not enabled or no guest memory status report
 #       received yet, GenericError
 #
-# Since: 8.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-hv-balloon-status-report" }
@@ -1205,6 +1203,8 @@
 #              "available": 3333054464
 #           }
 #        }
+#
+# Since: 8.2
 ##
 { 'command': 'query-hv-balloon-status-report', 'returns': 'HvBalloonInfo' }
 
@@ -1215,13 +1215,13 @@
 #
 # .. note:: This event is rate-limited.
 #
-# Since: 8.2
-#
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
@@ -1553,8 +1553,6 @@
 # @query-memory-devices:
 #     Lists available memory devices and their state
 #
-# Since: 2.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-memory-devices" }
@@ -1569,6 +1567,8 @@
 #                             "slot": 0},
 #                        "type": "dimm"
 #                      } ] }
+#
+# Since: 2.1
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
 
@@ -1586,14 +1586,14 @@
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
@@ -1817,13 +1817,13 @@
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
@@ -1879,13 +1879,13 @@
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
index 927942910d0..86a9d139dca 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -337,8 +337,6 @@
 #     migration is active there will be another json-object with RAM
 #     migration status.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #    :title: Before the first migration
 #
@@ -424,6 +422,8 @@
 #              }
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-migrate', 'returns': 'MigrationInfo' }
 
@@ -556,13 +556,13 @@
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
@@ -572,8 +572,6 @@
 #     Return information about the current migration capabilities
 #     status
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-migrate-capabilities" }
@@ -585,6 +583,8 @@
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
 #        ]}
+#
+# Since: 1.2
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
 
@@ -826,13 +826,13 @@
 # @migrate-set-parameters:
 #     Set migration parameters.  All arguments are optional.
 #
-# Since: 2.4
-#
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
@@ -1063,8 +1063,6 @@
 #     @block-bitmap-mapping, which is only present if it has been
 #     previously set.
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-migrate-parameters" }
@@ -1076,6 +1074,8 @@
 #              "downtime-limit": 300
 #           }
 #        }
+#
+# Since: 2.4
 ##
 { 'command': 'query-migrate-parameters',
   'returns': 'MigrationParameters' }
@@ -1086,12 +1086,12 @@
 #     postcopy mode.  The postcopy-ram capability must be set on both
 #     source and destination before the original migration command.
 #
-# Since: 2.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-start-postcopy" }
 #     <- { "return": {} }
+#
+# Since: 2.5
 ##
 { 'command': 'migrate-start-postcopy' }
 
@@ -1101,13 +1101,13 @@
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
@@ -1119,12 +1119,12 @@
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
@@ -1200,12 +1200,12 @@
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
@@ -1241,12 +1241,12 @@
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
@@ -1262,12 +1262,12 @@
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
 
@@ -1277,13 +1277,13 @@
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
 
@@ -1387,8 +1387,6 @@
 #     will fail unless migration is in "postcopy-paused" state.
 #     (default: false, since 3.0)
 #
-# Since: 0.14
-#
 # .. admonition:: Notes
 #
 #     1. The `query-migrate` command should be used to check
@@ -1442,6 +1440,8 @@
 #                                        "filename": "/tmp/migfile",
 #                                        "offset": "0x1000" } } ] } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'migrate',
   'data': {'*uri': 'str',
@@ -1464,8 +1464,6 @@
 #     :qapi:event:`MIGRATION` event, and error details could be
 #     retrieved with `query-migrate`.  (since 9.1)
 #
-# Since: 2.3
-#
 # .. admonition:: Notes
 #
 #     1. It's a bad idea to use a string for the uri, but it needs to
@@ -1513,6 +1511,8 @@
 #                                        "host": "10.12.34.9",
 #                                        "port": "1050" } } ] } }
 #     <- { "return": {} }
+#
+# Since: 2.3
 ##
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
@@ -1531,13 +1531,13 @@
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
@@ -1548,13 +1548,13 @@
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
 
@@ -1567,13 +1567,13 @@
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
 
@@ -1720,13 +1720,13 @@
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
@@ -1850,8 +1850,6 @@
 #     'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
 #     (Since 6.1)
 #
-# Since: 5.2
-#
 # Dirty page rate is the number of pages changed in a given time
 # period expressed in MiB/s.  The following methods of calculation are
 # available:
@@ -1892,6 +1890,8 @@
 #         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
 #
 #     <- { "return": {} }
+#
+# Since: 5.2
 ##
 { 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
                                          '*calc-time-unit': 'TimeUnit',
@@ -1906,8 +1906,6 @@
 # @calc-time-unit: time unit in which to report calculation time.
 #     By default it is reported in seconds.  (Since 8.2)
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #    :title: Measurement is in progress
 #
@@ -1921,6 +1919,8 @@
 #     <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
 #         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
 #         "calc-time-unit": "second"}
+#
+# Since: 5.2
 ##
 { 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' },
                                  'returns': 'DirtyRateInfo' }
@@ -1951,8 +1951,6 @@
 #
 # @dirty-rate: upper limit of dirty page rate (MB/s) for virtual CPUs.
 #
-# Since: 7.1
-#
 # Requires KVM with accelerator property "dirty-ring-size" set.  A
 # virtual CPU's dirty page rate is a measure of its memory load.  To
 # observe dirty page rates, use `calc-dirty-rate`.
@@ -1963,6 +1961,8 @@
 #         "arguments": { "dirty-rate": 200,
 #                        "cpu-index": 1 } }
 #     <- { "return": {} }
+#
+# Since: 7.1
 ##
 { 'command': 'set-vcpu-dirty-limit',
   'data': { '*cpu-index': 'int',
@@ -1974,8 +1974,6 @@
 #
 # @cpu-index: index of a virtual CPU, default is all.
 #
-# Since: 7.1
-#
 # Cancel the dirty page limit for the vCPU which has been set with
 # `set-vcpu-dirty-limit` command.  Note that this command requires
 # support from dirty ring, same as the `set-vcpu-dirty-limit`.
@@ -1985,6 +1983,8 @@
 #     -> {"execute": "cancel-vcpu-dirty-limit"},
 #         "arguments": { "cpu-index": 1 } }
 #     <- { "return": {} }
+#
+# Since: 7.1
 ##
 { 'command': 'cancel-vcpu-dirty-limit',
   'data': { '*cpu-index': 'int'} }
@@ -1994,14 +1994,14 @@
 #     Return information about virtual CPU dirty page rate limits, if
 #     any.
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
index 70859b2c37d..a0287dd79d6 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -34,13 +34,13 @@
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
index 52ab5a6389a..a0dc4c70d63 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -13,12 +13,12 @@
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
 
@@ -124,14 +124,14 @@
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
 
@@ -156,8 +156,6 @@
 #       invalid guest configuration or if the guest has not reached
 #       the required SEV state, GenericError
 #
-# Since: 2.12
-#
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The launch
 # measurement for SEV-SNP guests is only available within the guest.
@@ -166,6 +164,8 @@
 #
 #     -> { "execute": "query-sev-launch-measure" }
 #     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+#
+# Since: 2.12
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo' }
 
@@ -201,8 +201,6 @@
 # Errors:
 #     - If SEV is not available on the platform, GenericError
 #
-# Since: 2.12
-#
 # This is only supported on AMD X86 platforms with KVM enabled.
 #
 # .. qmp-example::
@@ -211,6 +209,8 @@
 #     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
 #                      "cpu0-id": "2lvmGwo+...61iEinw==",
 #                      "cbitpos": 47, "reduced-phys-bits": 1}}
+#
+# Since: 2.12
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
 
@@ -262,8 +262,6 @@
 #       invalid guest configuration or because the guest has not
 #       reached the required SEV state, GenericError
 #
-# Since: 6.1
-#
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The attestation
 # report for SEV-SNP guests is only available within the guest.
@@ -273,6 +271,8 @@
 #     -> { "execute" : "query-sev-attestation-report",
 #                      "arguments": { "mnonce": "aaaaaaa" } }
 #     <- { "return" : { "data": "aaaaaaaabbbddddd"} }
+#
+# Since: 6.1
 ##
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
@@ -319,8 +319,6 @@
 # @query-sgx:
 #     Return information about configured SGX capabilities of guest
 #
-# Since: 6.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sgx" }
@@ -328,6 +326,8 @@
 #                      "flc": true,
 #                      "sections": [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
+#
+# Since: 6.2
 ##
 { 'command': 'query-sgx', 'returns': 'SgxInfo' }
 
@@ -335,8 +335,6 @@
 # @query-sgx-capabilities:
 #     Return information about SGX capabilities of host
 #
-# Since: 6.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-sgx-capabilities" }
@@ -344,6 +342,8 @@
 #                      "flc": true,
 #                      "section" : [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
+#
+# Since: 6.2
 ##
 { 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo' }
 
@@ -403,8 +403,6 @@
 #
 # Returns: list of open event channel ports.
 #
-# Since: 8.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-event-list" }
@@ -429,6 +427,8 @@
 #             }
 #          ]
 #        }
+#
+# Since: 8.0
 ##
 { 'command': 'xen-event-list',
   'returns': ['EvtchnInfo'] }
@@ -439,12 +439,12 @@
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
index 228d1cc1cd7..3770dea41eb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -26,8 +26,6 @@
 #
 # @tls: whether to perform TLS.  Only applies to the "spice" protocol
 #
-# Since: 0.14
-#
 # If the FD associated with @fdname is not a socket, the command will
 # fail and the FD will be closed.
 #
@@ -36,6 +34,8 @@
 #     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
 #                                                  "fdname": "myclient" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'add_client',
   'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
@@ -55,12 +55,12 @@
 # @query-name:
 #     Return the name information of a guest.
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
 
@@ -106,8 +106,6 @@
 #
 # Returns: a list of info for each iothread
 #
-# Since: 2.0
-#
 # .. note:: This list excludes the QEMU main loop thread, which is not
 #    declared using the ``-object iothread`` command-line option.  It
 #    is always the main thread of the process.
@@ -134,6 +132,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 2.0
 ##
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
@@ -142,8 +142,6 @@
 # @stop:
 #     Stop guest VM execution.
 #
-# Since: 0.14
-#
 # .. note:: This function will succeed even if the guest is already in
 #    the stopped state.  In "inmigrate" state, it will ensure that the
 #    guest remains paused once migration finishes, as if the ``-S``
@@ -156,6 +154,8 @@
 #
 #     -> { "execute": "stop" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'stop' }
 
@@ -163,8 +163,6 @@
 # @cont:
 #     Resume guest VM execution.
 #
-# Since: 0.14
-#
 # .. note:: This command will succeed if the guest is currently
 #    running.  It will also succeed if the guest is in the "inmigrate"
 #    state; in this case, the effect of the command is to make sure
@@ -179,6 +177,8 @@
 #
 #     -> { "execute": "cont" }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'cont' }
 
@@ -190,8 +190,6 @@
 #
 # @unstable: This command is experimental.
 #
-# Since: 3.0
-#
 # This command makes QEMU exit the preconfig state and proceed with VM
 # initialization using configuration data provided on the command line
 # and via the QMP monitor during the preconfig state.  The command is
@@ -202,6 +200,8 @@
 #
 #     -> { "execute": "x-exit-preconfig" }
 #     <- { "return": {} }
+#
+# Since: 3.0
 ##
 { 'command': 'x-exit-preconfig', 'allow-preconfig': true,
   'features': [ 'unstable' ] }
@@ -222,8 +222,6 @@
 #     monitor-owned nodes if they have no parents.  This allows the
 #     use of 'savevm' with -blockdev.  (since 4.2)
 #
-# Since: 0.14
-#
 # .. note:: This command only exists as a stop-gap.  Its use is highly
 #    discouraged.  The semantics of this command are not guaranteed:
 #    this means that command names, arguments and responses can change
@@ -242,6 +240,8 @@
 #     -> { "execute": "human-monitor-command",
 #          "arguments": { "command-line": "info kvm" } }
 #     <- { "return": "kvm support: enabled\r\n" }
+#
+# Since: 0.14
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
@@ -255,8 +255,6 @@
 #
 # @fdname: file descriptor name
 #
-# Since: 0.14
-#
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
@@ -267,6 +265,8 @@
 #
 #     -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'getfd', 'data': {'fdname': 'str'}, 'if': 'CONFIG_POSIX' }
 
@@ -281,8 +281,6 @@
 #
 # @fdname: file descriptor name
 #
-# Since: 8.0
-#
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
@@ -294,6 +292,8 @@
 #     -> { "execute": "get-win32-socket",
 #          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
 #     <- { "return": {} }
+#
+# Since: 8.0
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
 
@@ -303,12 +303,12 @@
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
 
@@ -343,12 +343,12 @@
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
@@ -366,8 +366,6 @@
 # Errors:
 #     - If @fdset-id or @fd is not found, GenericError
 #
-# Since: 1.2
-#
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
 # .. note:: If @fd is not specified, all file descriptors in @fdset-id
@@ -377,6 +375,8 @@
 #
 #     -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
 #     <- { "return": {} }
+#
+# Since: 1.2
 ##
 { 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
 
@@ -410,8 +410,6 @@
 # @query-fdsets:
 #     Return information describing all fd sets.
 #
-# Since: 1.2
-#
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
 # .. qmp-example::
@@ -444,6 +442,8 @@
 #            }
 #          ]
 #        }
+#
+# Since: 1.2
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
 
@@ -510,8 +510,6 @@
 # Errors:
 #     - if the given @option doesn't exist
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-command-line-options",
@@ -532,6 +530,8 @@
 #             }
 #          ]
 #        }
+#
+# Since: 1.5
 ##
 {'command': 'query-command-line-options',
  'data': {'*option': 'str'},
@@ -551,13 +551,13 @@
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
@@ -577,8 +577,6 @@
 #
 # @dev-qom-path: path to attached PCI device in the QOM tree
 #
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "VFU_CLIENT_HANGUP",
@@ -587,6 +585,8 @@
 #                    "dev-id": "sas1",
 #                    "dev-qom-path": "/machine/peripheral/sas1" },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+# Since: 7.1
 ##
 { 'event': 'VFU_CLIENT_HANGUP',
   'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
diff --git a/qapi/net.json b/qapi/net.json
index e760b0e84d5..de0182f9931 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -21,8 +21,6 @@
 # Errors:
 #     - If @name is not a valid network device, DeviceNotFound
 #
-# Since: 0.14
-#
 # .. note:: Not all network adapters support setting link status.
 #    This command will succeed even if the network adapter does not
 #    support link status notification.
@@ -32,6 +30,8 @@
 #     -> { "execute": "set_link",
 #          "arguments": { "name": "e1000.0", "up": false } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'set_link', 'data': {'name': 'str', 'up': 'bool'} }
 
@@ -39,8 +39,6 @@
 # @netdev_add:
 #     Add a network backend.
 #
-# Since: 0.14
-#
 # Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
@@ -52,6 +50,8 @@
 #          "arguments": { "type": "user", "id": "netdev1",
 #                         "dnssearch": [ { "str": "example.org" } ] } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'netdev_add', 'data': 'Netdev', 'boxed': true,
   'allow-preconfig': true }
@@ -65,12 +65,12 @@
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
@@ -1066,8 +1066,6 @@
 #     - if the given NIC doesn't support rx-filter querying
 #     - if the given net client isn't a NIC
 #
-# Since: 1.6
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
@@ -1096,6 +1094,8 @@
 #             }
 #           ]
 #        }
+#
+# Since: 1.6
 ##
 { 'command': 'query-rx-filter',
   'data': { '*name': 'str' },
@@ -1110,14 +1110,14 @@
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
@@ -1180,13 +1180,13 @@
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
@@ -1199,8 +1199,6 @@
 #
 # @addr: The destination address
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
@@ -1215,6 +1213,8 @@
 #          "data": { "netdev-id": "netdev0",
 #                    "addr": { "path": "/tmp/qemu0", "type": "unix" } },
 #          "timestamp": { "seconds": 1666269706, "microseconds": 413651 } }
+#
+# Since: 7.2
 ##
 { 'event': 'NETDEV_STREAM_CONNECTED',
   'data': { 'netdev-id': 'str',
@@ -1226,13 +1226,13 @@
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
@@ -1245,13 +1245,13 @@
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
@@ -1262,13 +1262,13 @@
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
@@ -1302,13 +1302,13 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 11.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-query-usernet" }
 #     <- { "return": [ { "hub-id": 0, "hub-name": "vnet",
 #                        "info": "..." } ] }
+#
+# Since: 11.2
 ##
 { 'command': 'x-query-usernet',
   'returns': ['UsernetInfo'],
@@ -1418,14 +1418,14 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 11.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-query-network" }
 #     <- { "return": { "clients": [ { "name": "st0",
 #                      "queue-index": 0, "type": "stream",
 #                      "info-str": "listening" } ] } }
+#
+# Since: 11.2
 ##
 { 'command': 'x-query-network',
   'returns': 'NetworkInfo',
diff --git a/qapi/pci.json b/qapi/pci.json
index a6a79f91afc..8736393b6c5 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -173,8 +173,6 @@
 #     of all PCI devices attached to it.  Each device is represented
 #     by a json-object.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-pci" }
@@ -305,5 +303,7 @@
 #        }
 #
 # This example has been shortened as the real response is too long.
+#
+# Since: 0.14
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
diff --git a/qapi/qdev.json b/qapi/qdev.json
index a3fb6a28d94..8a68be1d5f8 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -100,8 +100,6 @@
 #    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
 #    event is sent.  Some errors cannot be detected.
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "device_del",
@@ -113,6 +111,8 @@
 #     -> { "execute": "device_del",
 #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
 
@@ -127,14 +127,14 @@
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
@@ -148,14 +148,14 @@
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
index 286fb987317..d765a59ce23 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -84,8 +84,6 @@
 #
 # Returns: a list that describe the properties of the object.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "qom-list",
@@ -94,6 +92,8 @@
 #                      { "name": "parallel0", "type": "child<chardev-vc>" },
 #                      { "name": "serial0", "type": "child<chardev-vc>" },
 #                      { "name": "mon0", "type": "child<chardev-stdio>" } ] }
+#
+# Since: 1.2
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
@@ -127,8 +127,6 @@
 #     child<> and link<> properties are returned as #str pathnames.
 #     All integer property types (u8, u16, etc) are returned as #int.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #    :title: Use absolute path
 #
@@ -144,6 +142,8 @@
 #          "arguments": { "path": "unattached/sysbus",
 #                         "property": "type" } }
 #     <- { "return": "System" }
+#
+# Since: 1.2
 ##
 { 'command': 'qom-get',
   'data': { 'path': 'str', 'property': 'str' },
@@ -182,8 +182,6 @@
 # @value: a value who's type is appropriate for the property type.
 #     See `qom-get` for a description of type mapping.
 #
-# Since: 1.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "qom-set",
@@ -191,6 +189,8 @@
 #                         "property": "graphics",
 #                         "value": false } }
 #     <- { "return": {} }
+#
+# Since: 1.2
 ##
 { 'command': 'qom-set',
   'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
@@ -1381,14 +1381,14 @@
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
@@ -1402,12 +1402,12 @@
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
index db1440c09a6..ce7d084684f 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -51,12 +51,12 @@
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
@@ -73,12 +73,12 @@
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
 
@@ -87,12 +87,12 @@
 #     Remove replay breakpoint which was set with `replay-break`.  The
 #     command is ignored when there are no replay breakpoints.
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "replay-delete-break" }
 #     <- { "return": {} }
+#
+# Since: 5.2
 ##
 { 'command': 'replay-delete-break' }
 
@@ -107,11 +107,11 @@
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
index 7eb0a88dafd..06e21721993 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -28,12 +28,12 @@
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
@@ -92,8 +92,6 @@
 #
 # @name: port name
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
@@ -102,6 +100,8 @@
 #                      {"duplex": "full", "enabled": true, "name": "sw1.2",
 #                       "autoneg": "off", "link-up": true, "speed": 10000}
 #        ]}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker-ports',
   'data': { 'name': 'str' },
@@ -229,8 +229,6 @@
 #
 # Returns: rocker OF-DPA flow information
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker-of-dpa-flows",
@@ -243,6 +241,8 @@
 #                      },
 #                      ...
 #        ]}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker-of-dpa-flows',
   'data': { 'name': 'str', '*tbl-id': 'uint32' },
@@ -302,8 +302,6 @@
 #
 # Returns: rocker OF-DPA group information
 #
-# Since: 2.4
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-rocker-of-dpa-groups",
@@ -321,6 +319,8 @@
 #                       "pport": 0, "vlan-id": 3840,
 #                       "pop-vlan": 1, "id": 251658240}
 #        ]}
+#
+# Since: 2.4
 ##
 { 'command': 'query-rocker-of-dpa-groups',
   'data': { 'name': 'str', '*type': 'uint8' },
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 8bbd9884087..3c8d790216a 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -117,13 +117,13 @@
 # @query-status:
 #     Query the run status of the VM
 #
-# Since: 0.14
-#
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
@@ -145,13 +145,13 @@
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
 
@@ -160,12 +160,12 @@
 #     Emitted when the virtual machine is powered down through the
 #     power control system, such as via ACPI.
 #
-# Since: 0.12
-#
 # .. qmp-example::
 #
 #     <- { "event": "POWERDOWN",
 #          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
+# Since: 0.12
 ##
 { 'event': 'POWERDOWN' }
 
@@ -180,13 +180,13 @@
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
 
@@ -194,12 +194,12 @@
 # @STOP:
 #     Emitted when the virtual machine is stopped
 #
-# Since: 0.12
-#
 # .. qmp-example::
 #
 #     <- { "event": "STOP",
 #          "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#
+# Since: 0.12
 ##
 { 'event': 'STOP' }
 
@@ -207,12 +207,12 @@
 # @RESUME:
 #     Emitted when the virtual machine resumes execution
 #
-# Since: 0.12
-#
 # .. qmp-example::
 #
 #     <- { "event": "RESUME",
 #          "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
+#
+# Since: 0.12
 ##
 { 'event': 'RESUME' }
 
@@ -221,12 +221,12 @@
 #     Emitted when guest enters a hardware suspension state, for
 #     example, S3 state, which is sometimes called standby state
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "SUSPEND",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#
+# Since: 1.1
 ##
 { 'event': 'SUSPEND' }
 
@@ -239,12 +239,12 @@
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
 
@@ -253,12 +253,12 @@
 #     Emitted when the guest has woken up from suspend state and is
 #     running
 #
-# Since: 1.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "WAKEUP",
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+# Since: 1.1
 ##
 { 'event': 'WAKEUP' }
 
@@ -274,13 +274,13 @@
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
@@ -365,13 +365,13 @@
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
 
@@ -389,8 +389,6 @@
 # @watchdog: `WatchdogAction` action taken when watchdog timer
 #     expires.
 #
-# Since: 6.0
-#
 # .. qmp-example::
 #
 #     -> { "execute": "set-action",
@@ -399,6 +397,8 @@
 #                         "panic": "pause",
 #                         "watchdog": "inject-nmi" } }
 #     <- { "return": {} }
+#
+# Since: 6.0
 ##
 { 'command': 'set-action',
   'data': { '*reboot': 'RebootAction',
@@ -415,13 +415,13 @@
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
@@ -434,13 +434,13 @@
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
@@ -450,12 +450,12 @@
 #     Emitted when guest submits a shutdown request via pvpanic
 #     interface
 #
-# Since: 9.1
-#
 # .. qmp-example::
 #
 #     <- { "event": "GUEST_PVSHUTDOWN",
 #          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+#
+# Since: 9.1
 ##
 { 'event': 'GUEST_PVSHUTDOWN' }
 
@@ -629,8 +629,6 @@
 #
 # @flags: flags for `MemoryFailureAction`.
 #
-# Since: 5.2
-#
 # .. qmp-example::
 #
 #     <- { "event": "MEMORY_FAILURE",
@@ -639,6 +637,8 @@
 #                    "flags": { "action-required": false,
 #                               "recursive": false } },
 #          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+# Since: 5.2
 ##
 { 'event': 'MEMORY_FAILURE',
   'data': { 'recipient': 'MemoryFailureRecipient',
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 6d94be656ae..906ebd7d019 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -27,12 +27,12 @@
 # @query-tpm-models:
 #     Return a list of supported TPM models
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
@@ -54,12 +54,12 @@
 # @query-tpm-types:
 #     Return a list of supported TPM types
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
@@ -155,8 +155,6 @@
 # @query-tpm:
 #     Return information about the TPM device
 #
-# Since: 1.5
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-tpm" }
@@ -174,6 +172,8 @@
 #            }
 #          ]
 #        }
+#
+# Since: 1.5
 ##
 { 'command': 'query-tpm', 'returns': ['TPMInfo'],
   'if': 'CONFIG_TPM' }
diff --git a/qapi/trace.json b/qapi/trace.json
index 29c76256055..ccc68b69b6c 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -48,13 +48,13 @@
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
@@ -70,13 +70,13 @@
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
index 68df2df44ac..5026dc15a57 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -216,8 +216,6 @@
 #    in an error condition, and subsequent actions will not have been
 #    attempted.
 #
-# Since: 1.1
-#
 # For external snapshots, the dictionary contains the device, the file
 # to use for the new snapshot, and the format.  The default format, if
 # not specified, is qcow2.
@@ -261,6 +259,8 @@
 #                                          "device": "ide-hd2",
 #                                          "name": "snapshot0" } } ] } }
 #     <- { "return": {} }
+#
+# Since: 1.1
 ##
 { 'command': 'transaction',
   'data': { 'actions': [ 'TransactionAction' ],
diff --git a/qapi/ui.json b/qapi/ui.json
index 51e276baba4..83ac180ff36 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -78,13 +78,13 @@
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
 
@@ -137,13 +137,13 @@
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
 
@@ -177,13 +177,13 @@
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
@@ -312,8 +312,6 @@
 # @query-spice:
 #     Return information about the current SPICE server
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-spice" }
@@ -348,6 +346,8 @@
 #              ]
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
   'if': 'CONFIG_SPICE' }
@@ -360,8 +360,6 @@
 #
 # @client: client information
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
@@ -370,6 +368,8 @@
 #            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
 #            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
 #        }}
+#
+# Since: 0.14
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -385,8 +385,6 @@
 #
 # @client: client information
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
@@ -397,6 +395,8 @@
 #                              "connection-id": 1804289383, "host": "127.0.0.1",
 #                              "channel-id": 0, "tls": true}
 #        }}
+#
+# Since: 0.14
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
@@ -411,8 +411,6 @@
 #
 # @client: client information
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
@@ -421,6 +419,8 @@
 #            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
 #            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
 #        }}
+#
+# Since: 0.14
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -431,12 +431,12 @@
 # @SPICE_MIGRATE_COMPLETED:
 #     Emitted when SPICE migration has completed
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
 #          "event": "SPICE_MIGRATE_COMPLETED" }
+#
+# Since: 1.3
 ##
 { 'event': 'SPICE_MIGRATE_COMPLETED',
   'if': 'CONFIG_SPICE' }
@@ -629,8 +629,6 @@
 # @query-vnc:
 #     Return information about the current VNC server
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-vnc" }
@@ -650,6 +648,8 @@
 #              ]
 #           }
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-vnc', 'returns': 'VncInfo',
   'if': 'CONFIG_VNC' }
@@ -669,11 +669,11 @@
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
@@ -690,8 +690,6 @@
 # .. note:: This event is emitted before any authentication takes
 #    place, thus the authentication ID is not provided.
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "VNC_CONNECTED",
@@ -701,6 +699,8 @@
 #                "client": { "family": "ipv4", "service": "58425",
 #                            "host": "127.0.0.1", "websocket": false } },
 #          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
+# Since: 0.13
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -716,8 +716,6 @@
 #
 # @client: client information
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <-  { "event": "VNC_INITIALIZED",
@@ -727,6 +725,8 @@
 #                "client": { "family": "ipv4", "service": "46089", "websocket": false,
 #                            "host": "127.0.0.1", "sasl_username": "luiz" } },
 #           "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
+#
+# Since: 0.13
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
@@ -741,8 +741,6 @@
 #
 # @client: client information
 #
-# Since: 0.13
-#
 # .. qmp-example::
 #
 #     <- { "event": "VNC_DISCONNECTED",
@@ -752,6 +750,8 @@
 #                "client": { "family": "ipv4", "service": "58425", "websocket": false,
 #                            "host": "127.0.0.1", "sasl_username": "luiz" } },
 #          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
+# Since: 0.13
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -789,8 +789,6 @@
 #
 # Returns: a list of info for each device
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "query-mice" }
@@ -809,6 +807,8 @@
 #              }
 #           ]
 #        }
+#
+# Since: 0.14
 ##
 { 'command': 'query-mice', 'returns': ['MouseInfo'] }
 
@@ -996,8 +996,6 @@
 # Errors:
 #     - If key is unknown or redundant, GenericError
 #
-# Since: 1.3
-#
 # .. qmp-example::
 #
 #     -> { "execute": "send-key",
@@ -1005,6 +1003,8 @@
 #                                   { "type": "qcode", "data": "alt" },
 #                                   { "type": "qcode", "data": "delete" } ] } }
 #     <- { "return": {} }
+#
+# Since: 1.3
 ##
 { 'command': 'send-key',
   'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
@@ -1206,8 +1206,6 @@
 #
 # @events: List of `InputEvent` union.
 #
-# Since: 2.6
-#
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
 # same kind are added to the virtual machine and (b) you have
@@ -1260,6 +1258,8 @@
 #                    { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
 #                    { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
 #     <- { "return": {} }
+#
+# Since: 2.6
 ##
 { 'command': 'input-send-event',
   'data': { '*device': 'str',
@@ -1562,13 +1562,13 @@
 # @display-reload:
 #     Reload display configuration.
 #
-# Since: 6.0
-#
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
@@ -1615,8 +1615,6 @@
 # @display-update:
 #     Update display configuration.
 #
-# Since: 7.1
-#
 # .. qmp-example::
 #
 #     -> { "execute": "display-update",
@@ -1624,6 +1622,8 @@
 #                         [ { "type": "inet", "host": "0.0.0.0",
 #                             "port": "5901" } ] } }
 #     <- { "return": {} }
+#
+# Since: 7.1
 ##
 { 'command': 'display-update',
   'data': 'DisplayUpdateOptions',
@@ -1646,8 +1646,6 @@
 #
 # @cert-subject: server certificate subject
 #
-# Since: 0.14
-#
 # .. qmp-example::
 #
 #     -> { "execute": "client_migrate_info",
@@ -1655,6 +1653,8 @@
 #                         "hostname": "virt42.lab.kraxel.org",
 #                         "port": 1234 } }
 #     <- { "return": {} }
+#
+# Since: 0.14
 ##
 { 'command': 'client_migrate_info',
   'data': { 'protocol': 'str', 'hostname': 'str', '*port': 'int',
diff --git a/qapi/vfio.json b/qapi/vfio.json
index 47fff8b979d..a8936265052 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -57,8 +57,6 @@
 #
 # @device-state: The new changed device migration state.
 #
-# Since: 9.1
-#
 # .. qmp-example::
 #
 #     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
@@ -67,6 +65,8 @@
 #              "device-id": "vfio_dev1",
 #              "qom-path": "/machine/peripheral/vfio_dev1",
 #              "device-state": "stop" } }
+#
+# Since: 9.1
 ##
 { 'event': 'VFIO_MIGRATION',
   'data': {
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 219c3f75043..fe818719b89 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -32,8 +32,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #
 #     -> { "execute": "x-query-virtio" }
@@ -60,6 +58,8 @@
 #              }
 #          ]
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio',
   'returns': [ 'VirtioInfo' ],
@@ -195,8 +195,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -429,6 +427,8 @@
 #              "use-started": true
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-status',
   'data': { 'path': 'str' },
@@ -567,8 +567,6 @@
 #    shadow_avail_idx will not be displayed in the case where the
 #    selected VirtIODevice has a running vhost device.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :annotated:
 #
@@ -623,6 +621,8 @@
 #              "vring-num": 128
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-queue-status',
   'data': { 'path': 'str', 'queue': 'uint16' },
@@ -684,8 +684,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :title: Get vhost_virtqueue status for vhost-crypto
 #
@@ -727,6 +725,8 @@
 #              "kick": 0
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-vhost-queue-status',
   'data': { 'path': 'str', 'queue': 'uint16' },
@@ -820,8 +820,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Since: 7.2
-#
 # .. qmp-example::
 #    :title: Introspect on virtio-net's VirtQueue 0 at index 5
 #
@@ -909,6 +907,8 @@
 #              }
 #          }
 #        }
+#
+# Since: 7.2
 ##
 { 'command': 'x-query-virtio-queue-element',
   'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
-- 
2.55.0


