Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C225C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 22:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70B4-0006d9-Jq; Tue, 14 May 2024 17:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70As-0006H7-BQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70An-0000Fe-Lt
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3yJeumY1ZGhqd9zHhlMiVKODqIPkJOpbqIauLtEQqs=;
 b=OW+Jyzf1K+GXLFDv9tXSdUzWgS41JPoBE///72CNFymAao1eNQPZ3Jo9FBv1fCW+jHr62x
 eZmUXeOs1Bs9pY70guU3bRJAtgMrpoWjIED4b4Aap72F9r1qXbC6AtiObtTI4PxFakc4sP
 cwHdMftszAWiCWYgX8TGbmuuhU6h/hE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-xUyHT0r1NXat8kxQAyjOSA-1; Tue, 14 May 2024 17:58:49 -0400
X-MC-Unique: xUyHT0r1NXat8kxQAyjOSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03316805965;
 Tue, 14 May 2024 21:58:48 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09B3E3C27;
 Tue, 14 May 2024 21:58:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 20/20] qapi: convert "Example" sections to rST
Date: Tue, 14 May 2024 17:57:39 -0400
Message-ID: <20240514215740.940155-21-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Eliminate the "Example" sections in QAPI doc blocks, converting them
into QMP example code blocks. This is generally done by converting
"Example:" or "Examples:" lines into ".. code-block:: QMP" lines.

This patch does also allow for the use of the rST syntax "Example::" by
exempting double-colon syntax from the QAPI doc parser, but that form is
not used by this conversion patch. The phrase "Example" here is not
special, it is the double-colon syntax that transforms the following
block into a code-block. By default, *this* form does not apply QMP
highlighting.

This patch has several benefits:

1. Example sections can now be written more arbitrarily, mixing
   explanatory paragraphs and code blocks however desired.

2. Example sections can now use fully arbitrary rST.

3. All code blocks are now lexed and validated as QMP; increasing
   usability of the docs and ensuring validity of example snippets.

4. Each code-block can be captioned independently without bypassing the
   QMP lexer/validator.

For any sections with more than one example, examples are split up into
multiple code-block regions. If annotations are present, those
annotations are converted into code-block captions instead, e.g.

```
Examples:

   1. Lorem Ipsum

   -> { "foo": "bar" }
```

Is rewritten as:

```
.. code-block:: QMP
   :caption: Example: Lorem Ipsum

   -> { "foo": "bar" }
```

This process was only semi-automated:

1. Replace "Examples?:" sections with sed:

sed -i 's|# Example:|# .. code-block:: QMP|' *.json
sed -i 's|# Examples:|# .. code-block:: QMP|' *.json

2. Identify sections that no longer parse successfully by attempting the
   doc build, convert annotations into captions manually.
   (Tedious, oh well.)

3. Add captions where still needed:

sed -zi 's|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n#    :caption: Example\n#\n|g' *.json

Not fully ideal, but hopefully not something that has to be done very
often. (Or ever again.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi.json                  |   6 +-
 qapi/block-core.json            | 120 ++++++++++++++++----------
 qapi/block.json                 |  60 +++++++------
 qapi/char.json                  |  36 ++++++--
 qapi/control.json               |  16 ++--
 qapi/dump.json                  |  12 ++-
 qapi/machine-target.json        |   3 +-
 qapi/machine.json               |  79 ++++++++++-------
 qapi/migration.json             | 145 +++++++++++++++++++++++---------
 qapi/misc-target.json           |  33 +++++---
 qapi/misc.json                  |  48 +++++++----
 qapi/net.json                   |  30 +++++--
 qapi/pci.json                   |   6 +-
 qapi/qapi-schema.json           |   6 +-
 qapi/qdev.json                  |  15 +++-
 qapi/qom.json                   |  20 +++--
 qapi/replay.json                |  12 ++-
 qapi/rocker.json                |  12 ++-
 qapi/run-state.json             |  45 ++++++----
 qapi/tpm.json                   |   9 +-
 qapi/trace.json                 |   6 +-
 qapi/transaction.json           |   3 +-
 qapi/ui.json                    |  62 +++++++++-----
 qapi/virtio.json                |  38 +++++----
 qapi/yank.json                  |   6 +-
 scripts/qapi/parser.py          |  15 +++-
 tests/qapi-schema/doc-good.json |  12 +--
 tests/qapi-schema/doc-good.out  |  17 ++--
 tests/qapi-schema/doc-good.txt  |  17 +---
 29 files changed, 574 insertions(+), 315 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index aa4dbe57943..3da01f1b7fc 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -111,7 +111,8 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-acpi-ospm-status" }
 #     <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
@@ -131,7 +132,8 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "ACPI_DEVICE_OST",
 #          "data": { "info": { "device": "d1", "slot": "0",
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 530af40404d..bb0447207df 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -763,7 +763,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-block" }
 #     <- {
@@ -1167,7 +1168,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-blockstats" }
 #     <- {
@@ -1460,7 +1462,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block_resize",
 #          "arguments": { "device": "scratch", "size": 1073741824 } }
@@ -1678,7 +1681,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-snapshot-sync",
 #          "arguments": { "device": "ide-hd0",
@@ -1711,7 +1715,8 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": { "driver": "qcow2",
@@ -1857,7 +1862,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-commit",
 #          "arguments": { "device": "virtio0",
@@ -1895,7 +1901,8 @@
 #
 # Since: 1.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "drive-backup",
 #          "arguments": { "device": "drive0",
@@ -1921,7 +1928,8 @@
 #
 # Since: 2.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-backup",
 #          "arguments": { "device": "src-id",
@@ -1945,7 +1953,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-named-block-nodes" }
 #     <- { "return": [ { "ro":false,
@@ -2126,7 +2135,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "drive-mirror",
 #          "arguments": { "device": "ide-hd0",
@@ -2302,7 +2312,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-dirty-bitmap-add",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2326,7 +2337,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-dirty-bitmap-remove",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2349,7 +2361,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-dirty-bitmap-clear",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2370,7 +2383,8 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-dirty-bitmap-enable",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2391,7 +2405,8 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-dirty-bitmap-disable",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2423,7 +2438,8 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-dirty-bitmap-merge",
 #          "arguments": { "node": "drive0", "target": "bitmap0",
@@ -2532,7 +2548,8 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-mirror",
 #          "arguments": { "device": "ide-hd0",
@@ -2856,7 +2873,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-stream",
 #          "arguments": { "device": "virtio0",
@@ -4790,7 +4808,8 @@
 #
 # Since: 2.9
 #
-# Examples:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -4804,6 +4823,9 @@
 #         }
 #     <- { "return": {} }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
 #               "driver": "qcow2",
@@ -4888,7 +4910,8 @@
 #
 # Since: 2.9
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -5537,7 +5560,8 @@
 # .. note:: If action is "stop", a STOP event will eventually follow the
 #    BLOCK_IO_ERROR event.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_IMAGE_CORRUPTED",
 #          "data": { "device": "", "node-name": "drive", "fatal": false,
@@ -5586,7 +5610,8 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_IO_ERROR",
 #          "data": { "device": "ide0-hd1",
@@ -5626,7 +5651,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_JOB_COMPLETED",
 #          "data": { "type": "stream", "device": "virtio-disk0",
@@ -5661,7 +5687,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_JOB_CANCELLED",
 #          "data": { "type": "stream", "device": "virtio-disk0",
@@ -5690,7 +5717,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_JOB_ERROR",
 #          "data": { "device": "ide0-hd1",
@@ -5725,7 +5753,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_JOB_READY",
 #          "data": { "device": "drive0", "type": "mirror", "speed": 0,
@@ -5753,7 +5782,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BLOCK_JOB_PENDING",
 #          "data": { "type": "mirror", "id": "backup_1" },
@@ -5827,7 +5857,8 @@
 #
 # Since: 2.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block-set-write-threshold",
 #          "arguments": { "node-name": "mydev",
@@ -5872,9 +5903,8 @@
 #
 # Since: 2.7
 #
-# Examples:
-#
-#     1. Add a new node to a quorum
+# .. code-block:: QMP
+#    :caption: Example: Add a new node to a quorum
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -5888,7 +5918,8 @@
 #                         "node": "new_node" } }
 #     <- { "return": {} }
 #
-#     2. Delete a quorum's node
+# .. code-block:: QMP
+#    :caption: Example: Delete a quorum's node
 #
 #     -> { "execute": "x-blockdev-change",
 #          "arguments": { "parent": "disk1",
@@ -5924,16 +5955,16 @@
 #
 # Since: 2.12
 #
-# Examples:
-#
-#     1. Move a node into an IOThread
+# .. code-block:: QMP
+#    :caption: Example: Move a node into an IOThread
 #
 #     -> { "execute": "x-blockdev-set-iothread",
 #          "arguments": { "node-name": "disk1",
 #                         "iothread": "iothread0" } }
 #     <- { "return": {} }
 #
-#     2. Move a node into the main loop
+# .. code-block:: QMP
+#    :caption: Example: Move a node into the main loop
 #
 #     -> { "execute": "x-blockdev-set-iothread",
 #          "arguments": { "node-name": "disk1",
@@ -5978,7 +6009,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "QUORUM_FAILURE",
 #          "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
@@ -6009,16 +6041,16 @@
 #
 # Since: 2.0
 #
-# Examples:
-#
-#     1. Read operation
+# .. code-block:: QMP
+#    :caption: Example: Read operation
 #
 #     <- { "event": "QUORUM_REPORT_BAD",
 #          "data": { "node-name": "node0", "sector-num": 345435, "sectors-count": 5,
 #                    "type": "read" },
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
 #
-#     2. Flush operation
+# .. code-block:: QMP
+#    :caption: Example: Flush operation
 #
 #     <- { "event": "QUORUM_REPORT_BAD",
 #          "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
@@ -6066,7 +6098,8 @@
 #
 # Since: 1.7
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-snapshot-internal-sync",
 #          "arguments": { "device": "ide-hd0",
@@ -6105,7 +6138,8 @@
 #
 # Since: 1.7
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-snapshot-delete-internal-sync",
 #          "arguments": { "device": "ide-hd0",
diff --git a/qapi/block.json b/qapi/block.json
index ea81d9e1921..c67bda708a2 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -117,7 +117,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
 #     <- { "return": {} }
@@ -161,7 +162,8 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-open-tray",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -199,7 +201,8 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-close-tray",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -231,7 +234,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-remove-medium",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -272,7 +276,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -342,9 +347,8 @@
 #
 # Since: 2.5
 #
-# Examples:
-#
-#     1. Change a removable medium
+# .. code-block:: QMP
+#    :caption: Example: Change a removable medium
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "ide0-1-0",
@@ -352,7 +356,8 @@
 #                         "format": "raw" } }
 #     <- { "return": {} }
 #
-#     2. Load a read-only medium into a writable drive
+# .. code-block:: QMP
+#    :caption: Example: Load a read-only medium into a writable drive
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "floppyA",
@@ -397,7 +402,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "DEVICE_TRAY_MOVED",
 #          "data": { "device": "ide1-cd0",
@@ -421,7 +427,8 @@
 #
 # Since: 3.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "PR_MANAGER_STATUS_CHANGED",
 #          "data": { "id": "pr-helper0",
@@ -463,7 +470,8 @@
 #
 # Since: 1.1
 #
-# Examples:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "block_set_io_throttle",
 #          "arguments": { "id": "virtio-blk-pci0/virtio-backend",
@@ -483,6 +491,9 @@
 #                         "iops_size": 0 } }
 #     <- { "return": {} }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     -> { "execute": "block_set_io_throttle",
 #          "arguments": { "id": "ide0-1-0",
 #                         "bps": 1000000,
@@ -543,29 +554,27 @@
 #
 # Since: 4.0
 #
-# Example:
-#
-#     Set new histograms for all io types with intervals
-#     [0, 10), [10, 50), [50, 100), [100, +inf):
+# .. code-block:: QMP
+#    :caption: Example:
+#      Set new histograms for all io types with intervals
+#      [0, 10), [10, 50), [50, 100), [100, +inf):
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
 #                         "boundaries": [10, 50, 100] } }
 #     <- { "return": {} }
 #
-# Example:
-#
-#     Set new histogram only for write, other histograms will remain
-#     not changed (or not created):
+# .. code-block:: QMP
+#    :caption: Example: Set new histogram only for write, other
+#       histograms will remain not changed (or not created):
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
 #                         "boundaries-write": [10, 50, 100] } }
 #     <- { "return": {} }
 #
-# Example:
-#
-#     Set new histograms with the following intervals:
+# .. code-block:: QMP
+#    :caption: Example: Set new histograms with the following intervals:
 #       read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
 #       write: [0, 1000), [1000, 5000), [5000, +inf)
 #
@@ -575,9 +584,8 @@
 #                         "boundaries-write": [1000, 5000] } }
 #     <- { "return": {} }
 #
-# Example:
-#
-#     Remove all latency histograms:
+# .. code-block:: QMP
+#    :caption: Example: Remove all latency histograms:
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0" } }
diff --git a/qapi/char.json b/qapi/char.json
index 0f39c2d5cdf..a119bbb70b5 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -40,7 +40,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-chardev" }
 #     <- {
@@ -86,7 +87,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-chardev-backends" }
 #     <- {
@@ -141,7 +143,8 @@
 #
 # Since: 1.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "ringbuf-write",
 #          "arguments": { "device": "foo",
@@ -177,7 +180,8 @@
 #
 # Since: 1.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "ringbuf-read",
 #          "arguments": { "device": "foo",
@@ -698,19 +702,26 @@
 #
 # Since: 1.4
 #
-# Examples:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "foo",
 #                          "backend" : { "type" : "null", "data" : {} } } }
 #     <- { "return": {} }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "bar",
 #                          "backend" : { "type" : "file",
 #                                        "data" : { "out" : "/tmp/bar.log" } } } }
 #     <- { "return": {} }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "baz",
 #                          "backend" : { "type" : "pty", "data" : {} } } }
@@ -734,13 +745,17 @@
 #
 # Since: 2.10
 #
-# Examples:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute" : "chardev-change",
 #          "arguments" : { "id" : "baz",
 #                          "backend" : { "type" : "pty", "data" : {} } } }
 #     <- { "return": { "pty" : "/dev/pty/42" } }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     -> {"execute" : "chardev-change",
 #         "arguments" : {
 #             "id" : "charchannel2",
@@ -771,7 +786,8 @@
 #
 # Since: 1.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
@@ -788,7 +804,8 @@
 #
 # Since: 2.10
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
@@ -809,7 +826,8 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "VSERPORT_CHANGE",
 #          "data": { "id": "channel0", "open": true },
diff --git a/qapi/control.json b/qapi/control.json
index 2498e5dd6ba..938c94eb3ce 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -16,7 +16,8 @@
 #     the QMP greeting message.  If the field is not provided, it
 #     means no QMP capabilities will be enabled.  (since 2.12)
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "qmp_capabilities",
 #          "arguments": { "enable": [ "oob" ] } }
@@ -97,7 +98,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-version" }
 #     <- {
@@ -134,7 +136,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-commands" }
 #     <- {
@@ -149,8 +152,8 @@
 #          ]
 #        }
 #
-#     Note: This example has been shortened as the real response is too
-#     long.
+# This example has been shortened as the real response is too long.
+#
 ##
 { 'command': 'query-commands', 'returns': ['CommandInfo'],
   'allow-preconfig': true }
@@ -165,7 +168,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "quit" }
 #     <- { "return": {} }
diff --git a/qapi/dump.json b/qapi/dump.json
index f9aee7ea1dd..758dc90755a 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -94,7 +94,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "dump-guest-memory",
 #          "arguments": { "paging": false, "protocol": "fd:dump" } }
@@ -150,7 +151,8 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-dump" }
 #     <- { "return": { "status": "active", "completed": 1024000,
@@ -171,7 +173,8 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "DUMP_COMPLETED",
 #          "data": { "result": { "total": 1090650112, "status": "completed",
@@ -202,7 +205,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-dump-guest-memory-capability" }
 #     <- { "return": { "formats":
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a8d9ec87f59..5d31408abfa 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -475,7 +475,8 @@
 #
 # Since: 8.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "CPU_POLARIZATION_CHANGE",
 #          "data": { "polarization": "horizontal" },
diff --git a/qapi/machine.json b/qapi/machine.json
index e9c9bef940d..42f65ce1525 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -104,7 +104,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-cpus-fast" }
 #     <- { "return": [
@@ -221,7 +222,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-machines", "arguments": { "compat-props": true } }
 #     <- { "return": [
@@ -320,7 +322,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-uuid" }
 #     <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
@@ -354,7 +357,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "system_reset" }
 #     <- { "return": {} }
@@ -373,7 +377,8 @@
 #    request or that it has shut down.  Many guests will respond to this
 #    command by prompting the user in some way.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "system_powerdown" }
 #     <- { "return": {} }
@@ -393,7 +398,8 @@
 # .. note:: Prior to 4.0, this command does nothing in case the guest
 #    isn't suspended.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "system_wakeup" }
 #     <- { "return": {} }
@@ -444,7 +450,8 @@
 # .. note:: Prior to 2.1, this command was only supported for x86 and
 #    s390 VMs
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "inject-nmi" }
 #     <- { "return": {} }
@@ -473,7 +480,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-kvm" }
 #     <- { "return": { "enabled": true, "present": true } }
@@ -841,7 +849,8 @@
 #
 # .. caution:: Errors were not reliably returned until 1.1.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "memsave",
 #          "arguments": { "val": 10,
@@ -867,7 +876,8 @@
 #
 # .. caution:: Errors were not reliably returned until 1.1.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "pmemsave",
 #          "arguments": { "val": 10,
@@ -928,7 +938,8 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-memdev" }
 #     <- { "return": [
@@ -1046,10 +1057,8 @@
 #
 # Since: 2.7
 #
-# Examples:
-#
-#     For pseries machine type started with -smp 2,cores=2,maxcpus=4
-#     -cpu POWER8:
+# .. code-block:: QMP
+#    :caption: Example: For pseries machine type started with ``-smp 2,cores=2,maxcpus=4 -cpu POWER8``:
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1059,7 +1068,8 @@
 #            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
 #        ]}
 #
-#     For pc machine type started with -smp 1,maxcpus=2:
+# .. code-block:: QMP
+#    :caption: Example: For pc machine type started with ``-smp 1,maxcpus=2``:
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1074,8 +1084,8 @@
 #          }
 #        ]}
 #
-#     For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2
-#     -cpu qemu (Since: 2.11):
+# .. code-block:: QMP
+#    :caption: Example: For s390x-virtio-ccw machine type started with ``-smp 1,maxcpus=2 -cpu qemu`` (Since: 2.11):
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1129,12 +1139,14 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "balloon", "arguments": { "value": 536870912 } }
 #     <- { "return": {} }
 #
-#     With a 2.5GiB guest this command inflated the ballon to 3GiB.
+# With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
@@ -1165,7 +1177,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-balloon" }
 #     <- { "return": {
@@ -1189,7 +1202,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "BALLOON_CHANGE",
 #          "data": { "actual": 944766976 },
@@ -1230,7 +1244,8 @@
 #
 # Since: 8.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-hv-balloon-status-report" }
 #     <- { "return": {
@@ -1251,7 +1266,8 @@
 #
 # Since: 8.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "HV_BALLOON_STATUS_REPORT",
 #          "data": { "committed": 816640000, "available": 3333054464 },
@@ -1283,7 +1299,8 @@
 # Return the amount of initially allocated and present hotpluggable
 # (if enabled) memory in bytes.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-memory-size-summary" }
 #     <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
@@ -1562,7 +1579,8 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-memory-devices" }
 #     <- { "return": [ { "data":
@@ -1596,7 +1614,8 @@
 #
 # Since: 5.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 #          "data": { "id": "vm0", "size": 1073741824,
@@ -1622,7 +1641,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "MEM_UNPLUG_ERROR",
 #          "data": { "device": "dimm1",
@@ -1882,7 +1902,8 @@
 #
 # Since: 7.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "dumpdtb" }
 #          "arguments": { "filename": "fdt.dtb" } }
diff --git a/qapi/migration.json b/qapi/migration.json
index a7b8ff138e3..a30d519d7c1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -283,14 +283,14 @@
 #
 # Since: 0.14
 #
-# Examples:
-#
-#     1. Before the first migration
+# .. code-block:: QMP
+#    :caption: Example: Before the first migration
 #
 #     -> { "execute": "query-migrate" }
 #     <- { "return": {} }
 #
-#     2. Migration is done and has succeeded
+# .. code-block:: QMP
+#    :caption: Example: Migration is done and has succeeded
 #
 #     -> { "execute": "query-migrate" }
 #     <- { "return": {
@@ -310,12 +310,14 @@
 #          }
 #        }
 #
-#     3. Migration is done and has failed
+# .. code-block:: QMP
+#    :caption: Example: Migration is done and has failed
 #
 #     -> { "execute": "query-migrate" }
 #     <- { "return": { "status": "failed" } }
 #
-#     4. Migration is being performed:
+# .. code-block:: QMP
+#    :caption: Example: Migration is being performed
 #
 #     -> { "execute": "query-migrate" }
 #     <- {
@@ -336,7 +338,35 @@
 #           }
 #        }
 #
-#     5. Migration is being performed and XBZRLE is active:
+# .. code-block:: QMP
+#    :caption: Example: Migration is being performed and XBZRLE is active
+#
+#     -> { "execute": "query-migrate" }
+#     <- {
+#           "return":{
+#              "status":"active",
+#              "total-time":12345,
+#              "setup-time":12345,
+#              "expected-downtime":12345,
+#              "ram":{
+#                 "total":1057024,
+#                 "remaining":1053304,
+#                 "transferred":3720,
+#                 "duplicate":123,
+#                 "normal":123,
+#                 "normal-bytes":123456,
+#                 "dirty-sync-count":15
+#              },
+#              "disk":{
+#                 "total":20971520,
+#                 "remaining":20880384,
+#                 "transferred":91136
+#              }
+#           }
+#        }
+#
+# .. code-block:: QMP
+#    :caption: Example: Migration is being performed and XBZRLE is active
 #
 #     -> { "execute": "query-migrate" }
 #     <- {
@@ -510,7 +540,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-set-capabilities" , "arguments":
 #          { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
@@ -528,7 +559,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-migrate-capabilities" }
 #     <- { "return": [
@@ -1030,7 +1062,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-set-parameters" ,
 #          "arguments": { "multifd-channels": 5 } }
@@ -1228,7 +1261,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-migrate-parameters" }
 #     <- { "return": {
@@ -1252,7 +1286,8 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-start-postcopy" }
 #     <- { "return": {} }
@@ -1268,7 +1303,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
 #         "event": "MIGRATION",
@@ -1287,7 +1323,8 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
 #           "event": "MIGRATION_PASS", "data": {"pass": 2} }
@@ -1371,7 +1408,8 @@
 #
 # Since: 3.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
 #          "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
@@ -1414,7 +1452,8 @@
 #
 # Since: 2.8
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "x-colo-lost-heartbeat" }
 #     <- { "return": {} }
@@ -1433,7 +1472,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate_cancel" }
 #     <- { "return": {} }
@@ -1449,7 +1489,8 @@
 #
 # Since: 2.11
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-continue" , "arguments":
 #          { "state": "pre-switchover" } }
@@ -1582,7 +1623,8 @@
 #     6. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 #     <- { "return": {} }
@@ -1661,7 +1703,8 @@
 #     5. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-incoming",
 #          "arguments": { "uri": "tcp:0:4446" } }
@@ -1712,7 +1755,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-save-devices-state",
 #          "arguments": { "filename": "/tmp/save" } }
@@ -1730,7 +1774,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-set-global-dirty-log",
 #          "arguments": { "enable": true } }
@@ -1750,7 +1795,8 @@
 #
 # Since: 2.7
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-load-devices-state",
 #          "arguments": { "filename": "/tmp/resume" } }
@@ -1770,7 +1816,8 @@
 # @failover: true to do failover, false to stop.  Cannot be specified
 #     if 'enable' is true.  Default value is false.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-set-replication",
 #          "arguments": {"enable": true, "primary": false} }
@@ -1805,7 +1852,8 @@
 #
 # Returns: A @ReplicationStatus object showing the status.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-xen-replication-status" }
 #     <- { "return": { "error": false } }
@@ -1821,7 +1869,8 @@
 #
 # Xen uses this command to notify replication to trigger a checkpoint.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-colo-do-checkpoint" }
 #     <- { "return": {} }
@@ -1859,7 +1908,8 @@
 #
 # Returns: A @COLOStatus object showing the status.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-colo-status" }
 #     <- { "return": { "mode": "primary", "last-mode": "none", "reason": "request" } }
@@ -1877,7 +1927,8 @@
 #
 # @uri: the URI to be used for the recovery of migration stream.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-recover",
 #          "arguments": { "uri": "tcp:192.168.1.200:12345" } }
@@ -1894,7 +1945,8 @@
 #
 # Pause a migration.  Currently it only supports postcopy.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "migrate-pause" }
 #     <- { "return": {} }
@@ -1915,7 +1967,8 @@
 #
 # Since: 4.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "UNPLUG_PRIMARY",
 #          "data": { "device-id": "hostdev0" },
@@ -2075,13 +2128,15 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example:
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
 #                                                     "sample-pages": 512} }
 #     <- { "return": {} }
 #
-#     Measure dirty rate using dirty bitmap for 500 milliseconds:
+# .. code-block:: QMP
+#    :caption: Example: Measure dirty rate using dirty bitmap for 500 milliseconds:
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
 #         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
@@ -2103,15 +2158,15 @@
 #
 # Since: 5.2
 #
-# Examples:
-#
-#     1. Measurement is in progress:
+# .. code-block:: QMP
+#    :caption: Example: Measurement is in progress
 #
 #     <- {"status": "measuring", "sample-pages": 512,
 #         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
 #         "calc-time-unit": "second"}
 #
-#     2. Measurement has been completed:
+# .. code-block:: QMP
+#    :caption: Example: Measurement has been completed
 #
 #     <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
 #         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
@@ -2154,7 +2209,8 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> {"execute": "set-vcpu-dirty-limit"}
 #         "arguments": { "dirty-rate": 200,
@@ -2178,7 +2234,8 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> {"execute": "cancel-vcpu-dirty-limit"},
 #         "arguments": { "cpu-index": 1 } }
@@ -2195,7 +2252,8 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> {"execute": "query-vcpu-dirty-limit"}
 #     <- {"return": [
@@ -2259,7 +2317,8 @@
 #
 # If @tag already exists, an error will be reported
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "snapshot-save",
 #          "arguments": {
@@ -2329,7 +2388,8 @@
 # device nodes that can have changed since the original @snapshot-save
 # command execution.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "snapshot-load",
 #          "arguments": {
@@ -2390,7 +2450,8 @@
 # to determine completion and to fetch details of any errors that
 # arise.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "snapshot-delete",
 #          "arguments": {
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 4e0a6492a9a..ccbed866195 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -11,7 +11,8 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "rtc-reset-reinjection" }
 #     <- { "return": {} }
@@ -89,7 +90,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-sev" }
 #     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
@@ -120,7 +122,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-sev-launch-measure" }
 #     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
@@ -165,7 +168,8 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-sev-capabilities" }
 #     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
@@ -219,7 +223,8 @@
 #
 # Since: 6.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute" : "query-sev-attestation-report",
 #                      "arguments": { "mnonce": "aaaaaaa" } }
@@ -239,7 +244,8 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "dump-skeys",
 #          "arguments": { "filename": "/tmp/skeys" } }
@@ -284,7 +290,8 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-gic-capabilities" }
 #     <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
@@ -342,7 +349,8 @@
 #
 # Since: 6.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-sgx" }
 #     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
@@ -361,7 +369,8 @@
 #
 # Since: 6.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-sgx-capabilities" }
 #     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
@@ -436,7 +445,8 @@
 #
 # Since: 8.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-event-list" }
 #     <- { "return": [
@@ -474,7 +484,8 @@
 #
 # Since: 8.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
 #     <- { "return": { } }
diff --git a/qapi/misc.json b/qapi/misc.json
index b04efbadec6..39bf8e30df1 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -30,7 +30,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
 #                                                  "fdname": "myclient" } }
@@ -60,7 +61,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-name" }
 #     <- { "return": { "name": "qemu-name" } }
@@ -111,7 +113,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-iothreads" }
 #     <- { "return": [
@@ -144,7 +147,8 @@
 #    In the "suspended" state, it will completely stop the VM and cause
 #    a transition to the "paused" state.  (Since 9.0)
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "stop" }
 #     <- { "return": {} }
@@ -168,7 +172,8 @@
 #    this command will transition back to the "suspended" state.  (Since
 #    9.0)
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "cont" }
 #     <- { "return": {} }
@@ -192,7 +197,8 @@
 #
 # Since: 3.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "x-exit-preconfig" }
 #     <- { "return": {} }
@@ -232,7 +238,8 @@
 #
 #    * Commands that prompt the user for data don't currently work.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "human-monitor-command",
 #          "arguments": { "command-line": "info kvm" } }
@@ -258,7 +265,8 @@
 #    The 'closefd' command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
@@ -285,7 +293,8 @@
 #    The 'closefd' command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "get-win32-socket",
 #          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
@@ -302,7 +311,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
@@ -345,7 +355,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
 #     <- { "return": { "fdset-id": 1, "fd": 3 } }
@@ -374,7 +385,8 @@
 # .. note:: If @fd is not specified, all file descriptors in @fdset-id
 #    will be removed.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
 #     <- { "return": {} }
@@ -420,7 +432,8 @@
 #
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-fdsets" }
 #     <- { "return": [
@@ -523,7 +536,8 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-command-line-options",
 #          "arguments": { "option": "option-rom" } }
@@ -565,7 +579,8 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "RTC_CHANGE",
 #          "data": { "offset": 78 },
@@ -592,7 +607,8 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "VFU_CLIENT_HANGUP",
 #          "data": { "vfu-id": "vfu1",
diff --git a/qapi/net.json b/qapi/net.json
index 4ac7fdc7e6c..adef3e6633d 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -26,7 +26,8 @@
 #    command will succeed even if the network adapter does not support
 #    link status notification.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "set_link",
 #          "arguments": { "name": "e1000.0", "up": false } }
@@ -46,7 +47,8 @@
 # Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "netdev_add",
 #          "arguments": { "type": "user", "id": "netdev1",
@@ -68,7 +70,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
 #     <- { "return": {} }
@@ -835,7 +838,8 @@
 #
 # Since: 1.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
 #     <- { "return": [
@@ -880,7 +884,8 @@
 #
 # Since: 1.6
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "NIC_RX_FILTER_CHANGED",
 #          "data": { "name": "vnet0",
@@ -927,7 +932,8 @@
 # switches.  This can be useful when network bonds fail-over the
 # active slave.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "announce-self",
 #          "arguments": {
@@ -952,7 +958,8 @@
 #
 # Since: 4.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "FAILOVER_NEGOTIATED",
 #          "data": { "device-id": "net1" },
@@ -972,7 +979,8 @@
 #
 # Since: 7.2
 #
-# Examples:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
 #          "data": { "netdev-id": "netdev0",
@@ -980,6 +988,9 @@
 #                              "host": "::1", "type": "inet" } },
 #          "timestamp": { "seconds": 1666269863, "microseconds": 311222 } }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
 #          "data": { "netdev-id": "netdev0",
 #                    "addr": { "path": "/tmp/qemu0", "type": "unix" } },
@@ -998,7 +1009,8 @@
 #
 # Since: 7.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "NETDEV_STREAM_DISCONNECTED",
 #          "data": {"netdev-id": "netdev0"},
diff --git a/qapi/pci.json b/qapi/pci.json
index f51159a2c4c..9192212661b 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -182,7 +182,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-pci" }
 #     <- { "return": [
@@ -311,8 +312,7 @@
 #           ]
 #        }
 #
-#     Note: This example has been shortened as the real response is too
-#     long.
+# This example has been shortened as the real response is too long.
 #
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 5e33da7228f..66fbcbd3619 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -20,11 +20,7 @@
 # understand.  However, in real protocol usage, they're emitted as a
 # single line.
 #
-# Also, the following notation is used to denote data flow:
-#
-# Example:
-#
-# ::
+# Also, the following notation is used to denote data flow::
 #
 #   -> data issued by the Client
 #   <- Server data response
diff --git a/qapi/qdev.json b/qapi/qdev.json
index d031fc3590d..cfe403fea20 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -62,7 +62,8 @@
 #        the ``-device DEVICE,help`` command-line argument, where DEVICE
 #        is the device's name.
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "device_add",
 #          "arguments": { "driver": "e1000", "id": "net1",
@@ -104,12 +105,16 @@
 #
 # Since: 0.14
 #
-# Examples:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "device_del",
 #          "arguments": { "id": "net1" } }
 #     <- { "return": {} }
 #
+# .. code-block:: QMP
+#    :caption: Example
+#
 #     -> { "execute": "device_del",
 #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
@@ -130,7 +135,8 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "DEVICE_DELETED",
 #          "data": { "device": "virtio-net-pci-0",
@@ -152,7 +158,8 @@
 #
 # Since: 6.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
 #          "data": { "device": "core1",
diff --git a/qapi/qom.json b/qapi/qom.json
index e927f4a3c5d..80357537b65 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -59,7 +59,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "qom-list",
 #          "arguments": { "path": "/chardevs" } }
@@ -104,16 +105,16 @@
 #
 # Since: 1.2
 #
-# Examples:
-#
-#     1. Use absolute path
+# .. code-block:: QMP
+#    :caption: Example: Use absolute path
 #
 #     -> { "execute": "qom-get",
 #          "arguments": { "path": "/machine/unattached/device[0]",
 #                         "property": "hotplugged" } }
 #     <- { "return": false }
 #
-#     2. Use partial path
+# .. code-block:: QMP
+#    :caption: Example: Use partial path
 #
 #     -> { "execute": "qom-get",
 #          "arguments": { "path": "unattached/sysbus",
@@ -139,7 +140,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "qom-set",
 #          "arguments": { "path": "/machine",
@@ -1080,7 +1082,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "object-add",
 #          "arguments": { "qom-type": "rng-random", "id": "rng1",
@@ -1102,7 +1105,8 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "object-del", "arguments": { "id": "rng1" } }
 #     <- { "return": {} }
diff --git a/qapi/replay.json b/qapi/replay.json
index d3559f9c8f7..f0351b6d9c1 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -54,7 +54,8 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-replay" }
 #     <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
@@ -76,7 +77,8 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
@@ -91,7 +93,8 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "replay-delete-break" }
 #     <- { "return": {} }
@@ -112,7 +115,8 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 9f95e638309..da5cc2b9e01 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -30,7 +30,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
 #     <- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
@@ -98,7 +99,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
 #     <- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
@@ -240,7 +242,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-rocker-of-dpa-flows",
 #          "arguments": { "name": "sw1" } }
@@ -315,7 +318,8 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-rocker-of-dpa-groups",
 #          "arguments": { "name": "sw1" } }
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 252d7d6afa7..6b0322de4d7 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -123,7 +123,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-status" }
 #     <- { "return": { "running": true,
@@ -152,7 +153,8 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "SHUTDOWN",
 #          "data": { "guest": true, "reason": "guest-shutdown" },
@@ -168,7 +170,8 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "POWERDOWN",
 #          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
@@ -189,7 +192,8 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "RESET",
 #          "data": { "guest": false, "reason": "guest-reset" },
@@ -204,7 +208,8 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "STOP",
 #          "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
@@ -218,7 +223,8 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "RESUME",
 #          "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
@@ -233,7 +239,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "SUSPEND",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
@@ -252,7 +259,8 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "SUSPEND_DISK",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
@@ -267,7 +275,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "WAKEUP",
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
@@ -289,7 +298,8 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "WATCHDOG",
 #          "data": { "action": "reset" },
@@ -382,7 +392,8 @@
 #
 # Since: 2.11
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "watchdog-set-action",
 #          "arguments": { "action": "inject-nmi" } }
@@ -406,7 +417,8 @@
 #
 # Since: 6.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "set-action",
 #          "arguments": { "reboot": "shutdown",
@@ -433,7 +445,8 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "GUEST_PANICKED",
 #          "data": { "action": "pause" },
@@ -453,7 +466,8 @@
 #
 # Since: 5.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "GUEST_CRASHLOADED",
 #          "data": { "action": "run" },
@@ -597,7 +611,8 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "MEMORY_FAILURE",
 #          "data": { "recipient": "hypervisor",
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 1577b5c259d..07b7b5bd9fd 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -31,7 +31,8 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-tpm-models" }
 #     <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
@@ -62,7 +63,8 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-tpm-types" }
 #     <- { "return": [ "passthrough", "emulator" ] }
@@ -168,7 +170,8 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-tpm" }
 #     <- { "return":
diff --git a/qapi/trace.json b/qapi/trace.json
index 043d12f83e0..3af64027759 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -64,7 +64,8 @@
 #
 # Since: 2.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "trace-event-get-state",
 #          "arguments": { "name": "qemu_memalign" } }
@@ -94,7 +95,8 @@
 #
 # Since: 2.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "trace-event-set-state",
 #          "arguments": { "name": "qemu_memalign", "enable": true } }
diff --git a/qapi/transaction.json b/qapi/transaction.json
index bcb05fdedd6..3f06ce9c1c6 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -244,7 +244,8 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "transaction",
 #          "arguments": { "actions": [
diff --git a/qapi/ui.json b/qapi/ui.json
index ec72998e28e..856b3779d77 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -81,7 +81,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "set_password", "arguments": { "protocol": "vnc",
 #                                                    "password": "secret" } }
@@ -140,7 +141,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
 #                                                       "time": "+60" } }
@@ -182,7 +184,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "screendump",
 #          "arguments": { "filename": "/tmp/image" } }
@@ -324,7 +327,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-spice" }
 #     <- { "return": {
@@ -373,7 +377,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
 #          "event": "SPICE_CONNECTED",
@@ -399,7 +404,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
 #          "event": "SPICE_INITIALIZED",
@@ -426,7 +432,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
 #          "event": "SPICE_DISCONNECTED",
@@ -447,7 +454,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
 #          "event": "SPICE_MIGRATE_COMPLETED" }
@@ -653,7 +661,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-vnc" }
 #     <- { "return": {
@@ -718,7 +727,8 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "VNC_CONNECTED",
 #          "data": {
@@ -745,7 +755,8 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <-  { "event": "VNC_INITIALIZED",
 #           "data": {
@@ -771,7 +782,8 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     <- { "event": "VNC_DISCONNECTED",
 #          "data": {
@@ -819,7 +831,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-mice" }
 #     <- { "return": [
@@ -1028,7 +1041,8 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "send-key",
 #          "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
@@ -1264,9 +1278,8 @@
 #    property, so it is possible to map which console belongs to which
 #    device and display.
 #
-# Examples:
-#
-#     1. Press left mouse button.
+# .. code-block:: QMP
+#    :caption: Example: Press left mouse button.
 #
 #     -> { "execute": "input-send-event",
 #         "arguments": { "device": "video0",
@@ -1280,7 +1293,8 @@
 #                        "data" : { "down": false, "button": "left" } } ] } }
 #     <- { "return": {} }
 #
-#     2. Press ctrl-alt-del.
+# .. code-block:: QMP
+#    :caption: Example: Press ctrl-alt-del.
 #
 #     -> { "execute": "input-send-event",
 #          "arguments": { "events": [
@@ -1292,7 +1306,8 @@
 #               "key": {"type": "qcode", "data": "delete" } } } ] } }
 #     <- { "return": {} }
 #
-#     3. Move mouse pointer to absolute coordinates (20000, 400).
+# .. code-block:: QMP
+#    :caption: Example: Move mouse pointer to absolute coordinates (20000, 400).
 #
 #     -> { "execute": "input-send-event" ,
 #       "arguments": { "events": [
@@ -1605,7 +1620,8 @@
 #
 # Since: 6.0
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "display-reload",
 #          "arguments": { "type": "vnc", "tls-certs": true  } }
@@ -1658,7 +1674,8 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "display-update",
 #          "arguments": { "type": "vnc", "addresses":
@@ -1689,7 +1706,8 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "client_migrate_info",
 #          "arguments": { "protocol": "spice",
diff --git a/qapi/virtio.json b/qapi/virtio.json
index b91f3cdd0df..adf5def9dd6 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -34,7 +34,8 @@
 #
 # Since: 7.2
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "x-query-virtio" }
 #     <- { "return": [
@@ -203,9 +204,8 @@
 #
 # Since: 7.2
 #
-# Examples:
-#
-#     1. Poll for the status of virtio-crypto (no vhost-crypto active)
+# .. code-block:: QMP
+#    :caption: Example: Poll for the status of virtio-crypto (no vhost-crypto active)
 #
 #     -> { "execute": "x-query-virtio-status",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
@@ -261,7 +261,8 @@
 #          }
 #        }
 #
-#     2. Poll for the status of virtio-net (vhost-net is active)
+# .. code-block:: QMP
+#    :caption: Example: Poll for the status of virtio-net (vhost-net is active)
 #
 #     -> { "execute": "x-query-virtio-status",
 #          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
@@ -568,9 +569,8 @@
 #
 # Since: 7.2
 #
-# Examples:
-#
-#     1. Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+# .. code-block:: QMP
+#    :caption: Example: Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
 #
 #     -> { "execute": "x-query-virtio-queue-status",
 #          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
@@ -593,7 +593,8 @@
 #          }
 #        }
 #
-#     2. Get VirtQueueStatus for virtio-serial (no vhost)
+# .. code-block:: QMP
+#    :caption: Example: Get VirtQueueStatus for virtio-serial (no vhost)
 #
 #     -> { "execute": "x-query-virtio-queue-status",
 #          "arguments": { "path": "/machine/peripheral-anon/device[0]/virtio-backend",
@@ -690,9 +691,8 @@
 #
 # Since: 7.2
 #
-# Examples:
-#
-#     1. Get vhost_virtqueue status for vhost-crypto
+# .. code-block:: QMP
+#    :caption: Example: Get vhost_virtqueue status for vhost-crypto
 #
 #     -> { "execute": "x-query-virtio-vhost-queue-status",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
@@ -715,7 +715,8 @@
 #          }
 #        }
 #
-#     2. Get vhost_virtqueue status for vhost-vsock
+# .. code-block:: QMP
+#    :caption: Example: Get vhost_virtqueue status for vhost-vsock
 #
 #     -> { "execute": "x-query-virtio-vhost-queue-status",
 #          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
@@ -839,9 +840,8 @@
 #
 # Since: 7.2
 #
-# Examples:
-#
-#     1. Introspect on virtio-net's VirtQueue 0 at index 5
+# .. code-block:: QMP
+#    :caption: Example: Introspect on virtio-net's VirtQueue 0 at index 5
 #
 #     -> { "execute": "x-query-virtio-queue-element",
 #          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
@@ -870,7 +870,8 @@
 #          }
 #        }
 #
-#     2. Introspect on virtio-crypto's VirtQueue 1 at head
+# .. code-block:: QMP
+#    :caption: Example: Introspect on virtio-crypto's VirtQueue 1 at head
 #
 #     -> { "execute": "x-query-virtio-queue-element",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
@@ -898,7 +899,8 @@
 #          }
 #        }
 #
-#     3. Introspect on virtio-scsi's VirtQueue 2 at head
+# .. code-block:: QMP
+#    :caption: Example: Introspect on virtio-scsi's VirtQueue 2 at head
 #
 #     -> { "execute": "x-query-virtio-queue-element",
 #          "arguments": { "path": "/machine/peripheral-anon/device[2]/virtio-backend",
diff --git a/qapi/yank.json b/qapi/yank.json
index 89f2f4d199b..a64b77e846c 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -81,7 +81,8 @@
 # Errors:
 #     - If any of the YankInstances doesn't exist, DeviceNotFound
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "yank",
 #          "arguments": {
@@ -104,7 +105,8 @@
 #
 # Returns: list of @YankInstance
 #
-# Example:
+# .. code-block:: QMP
+#    :caption: Example
 #
 #     -> { "execute": "query-yank" }
 #     <- { "return": [
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 8b1da96124e..afc0b444034 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -554,9 +554,12 @@ def get_doc(self) -> 'QAPIDoc':
                     no_more_args = True
                     intro = False
                 elif match := re.match(
-                        r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
+                        r'(Returns|Errors|Since|Notes?|Examples?(?!::)|TODO)'
+                        r': *',
                         line):
-                    # tagged section
+                    # tagged section.
+                    # Examples sections followed by two colons are excluded;
+                    # those are raw rST syntax!
 
                     if 'Note' in match.group(1):
                         emsg = (
@@ -566,6 +569,14 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
+                    if match.group(1).startswith("Example"):
+                        emsg = (
+                            f"The '{match.group(1)}' section is deprecated. "
+                            "Please use rST's '.. code-block:: QMP' directive,"
+                            " 'Example::', or other suitable markup instead."
+                        )
+                        raise QAPIParseError(self, emsg)
+
                     doc.new_tagged_section(self.info, match.group(1))
                     text = line[match.end():]
                     if text:
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 0a294eb324e..57e2e591938 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -46,11 +46,12 @@
 #
 # Duis aute irure dolor
 #
-# Example:
+# .. code-block:: QMP
 #
 # -> in
 # <- out
-# Examples:
+# .. code-block::
+#
 # - *verbatim*
 # - {braces}
 ##
@@ -170,12 +171,13 @@
 #
 #  Duis aute irure dolor
 #
-# Example:
+# .. code-block::
 #
 #  -> in
 #  <- out
 #
-# Examples:
+# .. code-block::
+#
 #  - *verbatim*
 #  - {braces}
 #
@@ -194,7 +196,7 @@
 # @cmd-feat1: a feature
 # @cmd-feat2: another feature
 #
-# Example:
+# .. code-block::
 #
 #  -> in
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 2c9b4e419cb..cd967c8b2e0 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -93,11 +93,12 @@ Notes:
 
 Duis aute irure dolor
 
-Example:
+.. code-block:: QMP
 
 -> in
 <- out
-Examples:
+.. code-block::
+
 - *verbatim*
 - {braces}
 doc symbol=Enum
@@ -184,10 +185,14 @@ frobnicate
  - Ut enim ad minim veniam
 
  Duis aute irure dolor
-    section=Example
+
+.. code-block::
+
  -> in
  <- out
-    section=Examples
+
+.. code-block::
+
  - *verbatim*
  - {braces}
     section=Since
@@ -199,7 +204,9 @@ If you're bored enough to read this, go see a video of boxed cats
 a feature
     feature=cmd-feat2
 another feature
-    section=Example
+    section=None
+.. code-block::
+
  -> in
 
  <- out
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index b89f35d5476..808ca7f73a1 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -33,9 +33,10 @@ Returns: the King Since: the first age Notes:
 
 Duis aute irure dolor
 
-Example:
+-> in <- out .. code-block:
 
--> in <- out Examples: - *verbatim* - {braces}
+   - *verbatim*
+   - {braces}
 
 
 "Enum" (Enum)
@@ -219,17 +220,9 @@ Notes:
 
 Duis aute irure dolor
 
-
-Example
-~~~~~~~
-
    -> in
    <- out
 
-
-Examples
-~~~~~~~~
-
    - *verbatim*
    - {braces}
 
@@ -260,10 +253,6 @@ Features
 "cmd-feat2"
    another feature
 
-
-Example
-~~~~~~~
-
    -> in
 
    <- out
-- 
2.44.0


