Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D751C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuBF-0000lx-4b; Tue, 16 Jul 2024 22:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuBE-0000ig-6f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuBA-0003dP-Ad
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721182443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ygqr/ke46nvE3h2B3O+9uRbdOkCm1ptpS1GVENMnf0c=;
 b=DCvTOBkSZKuWQ01f+neEhd+joGa7o+CZAa1YhJtKc5wSiIkI5VIhkWqYg44NiK2ltNDhE+
 y1VIAjakaQ4NiBOWlMn1xUPyOm3EhBMtPwhkZwax0cBzte6IwIqCLVh3hAOvzv/O8i1ua6
 HjOSFxp0CaDm+3qPTQRZoy44zJinWUw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-bmANfoOHO0eB53JytCtrpQ-1; Tue,
 16 Jul 2024 22:13:57 -0400
X-MC-Unique: bmANfoOHO0eB53JytCtrpQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C21EA195608B; Wed, 17 Jul 2024 02:13:55 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AA3F1955F40; Wed, 17 Jul 2024 02:13:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 6/9] qapi: convert "Example" sections without titles
Date: Tue, 16 Jul 2024 22:13:08 -0400
Message-ID: <20240717021312.606116-7-jsnow@redhat.com>
In-Reply-To: <20240717021312.606116-1-jsnow@redhat.com>
References: <20240717021312.606116-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use the no-option form of ".. qmp-example::" to convert any Examples
that do not have any form of caption or explanation whatsoever. Note
that in a few cases, example sections are split into two or more
separate example blocks. This is only done stylistically to create a
delineation between two or more logically independent examples.

See commit-3: "docs/qapidoc: create qmp-example directive", for a
              detailed explanation of this custom directive syntax.

See commit+3: "qapi: remove "Example" doc section" for a detailed
              explanation of why.

Note: an empty "TODO" line was added to announce-self to keep the
example from floating up into the body; this will be addressed more
rigorously in the new qapidoc generator.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi.json           |  4 +--
 qapi/block-core.json     | 64 +++++++++++++++++++++-------------------
 qapi/block.json          | 18 ++++++-----
 qapi/char.json           | 24 +++++++++------
 qapi/control.json        |  8 ++---
 qapi/dump.json           |  8 ++---
 qapi/machine-target.json |  2 +-
 qapi/machine.json        | 38 ++++++++++++------------
 qapi/migration.json      | 58 ++++++++++++++++++------------------
 qapi/misc-target.json    | 22 +++++++-------
 qapi/misc.json           | 32 ++++++++++----------
 qapi/net.json            | 22 ++++++++------
 qapi/pci.json            |  2 +-
 qapi/qdev.json           | 10 ++++---
 qapi/qom.json            |  8 ++---
 qapi/replay.json         |  8 ++---
 qapi/rocker.json         |  8 ++---
 qapi/run-state.json      | 32 ++++++++++----------
 qapi/tpm.json            |  6 ++--
 qapi/trace.json          |  4 +--
 qapi/transaction.json    |  2 +-
 qapi/ui.json             | 34 ++++++++++-----------
 qapi/vfio.json           |  2 +-
 qapi/virtio.json         |  2 +-
 qapi/yank.json           |  4 +--
 25 files changed, 219 insertions(+), 203 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index aa4dbe57943..045dab6228b 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -111,7 +111,7 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-acpi-ospm-status" }
 #     <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
@@ -131,7 +131,7 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "ACPI_DEVICE_OST",
 #          "data": { "info": { "device": "d1", "slot": "0",
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 096bdbe0aad..84a020aa9e3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -764,7 +764,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-block" }
 #     <- {
@@ -1168,7 +1168,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-blockstats" }
 #     <- {
@@ -1461,7 +1461,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block_resize",
 #          "arguments": { "device": "scratch", "size": 1073741824 } }
@@ -1680,7 +1680,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-sync",
 #          "arguments": { "device": "ide-hd0",
@@ -1711,7 +1711,7 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": { "driver": "qcow2",
@@ -1857,7 +1857,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-commit",
 #          "arguments": { "device": "virtio0",
@@ -1895,7 +1895,7 @@
 #
 # Since: 1.6
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "drive-backup",
 #          "arguments": { "device": "drive0",
@@ -1921,7 +1921,7 @@
 #
 # Since: 2.3
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-backup",
 #          "arguments": { "device": "src-id",
@@ -1945,7 +1945,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-named-block-nodes" }
 #     <- { "return": [ { "ro":false,
@@ -2126,7 +2126,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "drive-mirror",
 #          "arguments": { "device": "ide-hd0",
@@ -2303,7 +2303,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-add",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2327,7 +2327,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-remove",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2350,7 +2350,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-clear",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2371,7 +2371,7 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-enable",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2392,7 +2392,7 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-disable",
 #          "arguments": { "node": "drive0", "name": "bitmap0" } }
@@ -2424,7 +2424,7 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-dirty-bitmap-merge",
 #          "arguments": { "node": "drive0", "target": "bitmap0",
@@ -2533,7 +2533,7 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-mirror",
 #          "arguments": { "device": "ide-hd0",
@@ -2858,7 +2858,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-stream",
 #          "arguments": { "device": "virtio0",
@@ -4797,7 +4797,7 @@
 #
 # Since: 2.9
 #
-# Examples:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -4811,6 +4811,8 @@
 #         }
 #     <- { "return": {} }
 #
+# .. qmp-example::
+#
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
 #               "driver": "qcow2",
@@ -4895,7 +4897,7 @@
 #
 # Since: 2.9
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -5544,7 +5546,7 @@
 # .. note:: If action is "stop", a STOP event will eventually follow the
 #    BLOCK_IO_ERROR event.
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_IMAGE_CORRUPTED",
 #          "data": { "device": "", "node-name": "drive", "fatal": false,
@@ -5593,7 +5595,7 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_IO_ERROR",
 #          "data": { "device": "ide0-hd1",
@@ -5633,7 +5635,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_COMPLETED",
 #          "data": { "type": "stream", "device": "virtio-disk0",
@@ -5668,7 +5670,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_CANCELLED",
 #          "data": { "type": "stream", "device": "virtio-disk0",
@@ -5697,7 +5699,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_ERROR",
 #          "data": { "device": "ide0-hd1",
@@ -5732,7 +5734,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_READY",
 #          "data": { "device": "drive0", "type": "mirror", "speed": 0,
@@ -5760,7 +5762,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BLOCK_JOB_PENDING",
 #          "data": { "type": "mirror", "id": "backup_1" },
@@ -5834,7 +5836,7 @@
 #
 # Since: 2.3
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "block-set-write-threshold",
 #          "arguments": { "node-name": "mydev",
@@ -5985,7 +5987,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "QUORUM_FAILURE",
 #          "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
@@ -6070,7 +6072,7 @@
 #
 # Since: 1.7
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-internal-sync",
 #          "arguments": { "device": "ide-hd0",
@@ -6109,7 +6111,7 @@
 #
 # Since: 1.7
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-snapshot-delete-internal-sync",
 #          "arguments": { "device": "ide-hd0",
diff --git a/qapi/block.json b/qapi/block.json
index ea81d9e1921..c8e52bc2d29 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -117,7 +117,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
 #     <- { "return": {} }
@@ -161,7 +161,7 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-open-tray",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -199,7 +199,7 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-close-tray",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -231,7 +231,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-remove-medium",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -272,7 +272,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -397,7 +397,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "DEVICE_TRAY_MOVED",
 #          "data": { "device": "ide1-cd0",
@@ -421,7 +421,7 @@
 #
 # Since: 3.0
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "PR_MANAGER_STATUS_CHANGED",
 #          "data": { "id": "pr-helper0",
@@ -463,7 +463,7 @@
 #
 # Since: 1.1
 #
-# Examples:
+# .. qmp-example::
 #
 #     -> { "execute": "block_set_io_throttle",
 #          "arguments": { "id": "virtio-blk-pci0/virtio-backend",
@@ -483,6 +483,8 @@
 #                         "iops_size": 0 } }
 #     <- { "return": {} }
 #
+# .. qmp-example::
+#
 #     -> { "execute": "block_set_io_throttle",
 #          "arguments": { "id": "ide0-1-0",
 #                         "bps": 1000000,
diff --git a/qapi/char.json b/qapi/char.json
index 5eabf8e7645..5e4aeb9799d 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -40,7 +40,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-chardev" }
 #     <- {
@@ -86,7 +86,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-chardev-backends" }
 #     <- {
@@ -141,7 +141,7 @@
 #
 # Since: 1.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "ringbuf-write",
 #          "arguments": { "device": "foo",
@@ -177,7 +177,7 @@
 #
 # Since: 1.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "ringbuf-read",
 #          "arguments": { "device": "foo",
@@ -699,19 +699,23 @@
 #
 # Since: 1.4
 #
-# Examples:
+# .. qmp-example::
 #
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "foo",
 #                          "backend" : { "type" : "null", "data" : {} } } }
 #     <- { "return": {} }
 #
+# .. qmp-example::
+#
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "bar",
 #                          "backend" : { "type" : "file",
 #                                        "data" : { "out" : "/tmp/bar.log" } } } }
 #     <- { "return": {} }
 #
+# .. qmp-example::
+#
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "baz",
 #                          "backend" : { "type" : "pty", "data" : {} } } }
@@ -735,13 +739,15 @@
 #
 # Since: 2.10
 #
-# Examples:
+# .. qmp-example::
 #
 #     -> { "execute" : "chardev-change",
 #          "arguments" : { "id" : "baz",
 #                          "backend" : { "type" : "pty", "data" : {} } } }
 #     <- { "return": { "pty" : "/dev/pty/42" } }
 #
+# .. qmp-example::
+#
 #     -> {"execute" : "chardev-change",
 #         "arguments" : {
 #             "id" : "charchannel2",
@@ -772,7 +778,7 @@
 #
 # Since: 1.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
@@ -789,7 +795,7 @@
 #
 # Since: 2.10
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
@@ -810,7 +816,7 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "VSERPORT_CHANGE",
 #          "data": { "id": "channel0", "open": true },
diff --git a/qapi/control.json b/qapi/control.json
index fe2af45120b..950443df9d4 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -16,7 +16,7 @@
 #     the QMP greeting message.  If the field is not provided, it
 #     means no QMP capabilities will be enabled.  (since 2.12)
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "qmp_capabilities",
 #          "arguments": { "enable": [ "oob" ] } }
@@ -97,7 +97,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-version" }
 #     <- {
@@ -134,7 +134,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-commands" }
 #     <- {
@@ -165,7 +165,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "quit" }
 #     <- { "return": {} }
diff --git a/qapi/dump.json b/qapi/dump.json
index f9aee7ea1dd..d8145dad979 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -94,7 +94,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "dump-guest-memory",
 #          "arguments": { "paging": false, "protocol": "fd:dump" } }
@@ -150,7 +150,7 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-dump" }
 #     <- { "return": { "status": "active", "completed": 1024000,
@@ -171,7 +171,7 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "DUMP_COMPLETED",
 #          "data": { "result": { "total": 1090650112, "status": "completed",
@@ -202,7 +202,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-dump-guest-memory-capability" }
 #     <- { "return": { "formats":
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a8d9ec87f59..7edb876b5c3 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -475,7 +475,7 @@
 #
 # Since: 8.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "CPU_POLARIZATION_CHANGE",
 #          "data": { "polarization": "horizontal" },
diff --git a/qapi/machine.json b/qapi/machine.json
index f15ad1b43e2..83f60b319c7 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -104,7 +104,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-cpus-fast" }
 #     <- { "return": [
@@ -221,7 +221,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-machines", "arguments": { "compat-props": true } }
 #     <- { "return": [
@@ -320,7 +320,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-uuid" }
 #     <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
@@ -354,7 +354,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "system_reset" }
 #     <- { "return": {} }
@@ -373,7 +373,7 @@
 #    request or that it has shut down.  Many guests will respond to this
 #    command by prompting the user in some way.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "system_powerdown" }
 #     <- { "return": {} }
@@ -393,7 +393,7 @@
 # .. note:: Prior to 4.0, this command does nothing in case the guest
 #    isn't suspended.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "system_wakeup" }
 #     <- { "return": {} }
@@ -444,7 +444,7 @@
 # .. note:: Prior to 2.1, this command was only supported for x86 and
 #    s390 VMs.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "inject-nmi" }
 #     <- { "return": {} }
@@ -473,7 +473,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-kvm" }
 #     <- { "return": { "enabled": true, "present": true } }
@@ -842,7 +842,7 @@
 #
 # .. caution:: Errors were not reliably returned until 1.1.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "memsave",
 #          "arguments": { "val": 10,
@@ -868,7 +868,7 @@
 #
 # .. caution:: Errors were not reliably returned until 1.1.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "pmemsave",
 #          "arguments": { "val": 10,
@@ -929,7 +929,7 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-memdev" }
 #     <- { "return": [
@@ -1166,7 +1166,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-balloon" }
 #     <- { "return": {
@@ -1190,7 +1190,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "BALLOON_CHANGE",
 #          "data": { "actual": 944766976 },
@@ -1232,7 +1232,7 @@
 #
 # Since: 8.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-hv-balloon-status-report" }
 #     <- { "return": {
@@ -1253,7 +1253,7 @@
 #
 # Since: 8.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "HV_BALLOON_STATUS_REPORT",
 #          "data": { "committed": 816640000, "available": 3333054464 },
@@ -1285,7 +1285,7 @@
 # Return the amount of initially allocated and present hotpluggable
 # (if enabled) memory in bytes.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-memory-size-summary" }
 #     <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
@@ -1564,7 +1564,7 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-memory-devices" }
 #     <- { "return": [ { "data":
@@ -1598,7 +1598,7 @@
 #
 # Since: 5.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 #          "data": { "id": "vm0", "size": 1073741824,
@@ -1856,7 +1856,7 @@
 #
 # Since: 7.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "dumpdtb" }
 #          "arguments": { "filename": "fdt.dtb" } }
diff --git a/qapi/migration.json b/qapi/migration.json
index 1234bef8888..3c657202389 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -514,7 +514,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-set-capabilities" , "arguments":
 #          { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
@@ -532,7 +532,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-migrate-capabilities" }
 #     <- { "return": [
@@ -1053,7 +1053,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-set-parameters" ,
 #          "arguments": { "multifd-channels": 5 } }
@@ -1256,7 +1256,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-migrate-parameters" }
 #     <- { "return": {
@@ -1280,7 +1280,7 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-start-postcopy" }
 #     <- { "return": {} }
@@ -1296,7 +1296,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
 #         "event": "MIGRATION",
@@ -1315,7 +1315,7 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
 #           "event": "MIGRATION_PASS", "data": {"pass": 2} }
@@ -1399,7 +1399,7 @@
 #
 # Since: 3.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
 #          "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
@@ -1442,7 +1442,7 @@
 #
 # Since: 2.8
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "x-colo-lost-heartbeat" }
 #     <- { "return": {} }
@@ -1461,7 +1461,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate_cancel" }
 #     <- { "return": {} }
@@ -1477,7 +1477,7 @@
 #
 # Since: 2.11
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-continue" , "arguments":
 #          { "state": "pre-switchover" } }
@@ -1610,7 +1610,7 @@
 #     6. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 #     <- { "return": {} }
@@ -1689,7 +1689,7 @@
 #     5. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-incoming",
 #          "arguments": { "uri": "tcp:0:4446" } }
@@ -1740,7 +1740,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-save-devices-state",
 #          "arguments": { "filename": "/tmp/save" } }
@@ -1758,7 +1758,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-set-global-dirty-log",
 #          "arguments": { "enable": true } }
@@ -1778,7 +1778,7 @@
 #
 # Since: 2.7
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-load-devices-state",
 #          "arguments": { "filename": "/tmp/resume" } }
@@ -1798,7 +1798,7 @@
 # @failover: true to do failover, false to stop.  Cannot be specified
 #     if 'enable' is true.  Default value is false.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-set-replication",
 #          "arguments": {"enable": true, "primary": false} }
@@ -1833,7 +1833,7 @@
 #
 # Returns: A @ReplicationStatus object showing the status.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-xen-replication-status" }
 #     <- { "return": { "error": false } }
@@ -1849,7 +1849,7 @@
 #
 # Xen uses this command to notify replication to trigger a checkpoint.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-colo-do-checkpoint" }
 #     <- { "return": {} }
@@ -1887,7 +1887,7 @@
 #
 # Returns: A @COLOStatus object showing the status.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-colo-status" }
 #     <- { "return": { "mode": "primary", "last-mode": "none", "reason": "request" } }
@@ -1905,7 +1905,7 @@
 #
 # @uri: the URI to be used for the recovery of migration stream.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-recover",
 #          "arguments": { "uri": "tcp:192.168.1.200:12345" } }
@@ -1922,7 +1922,7 @@
 #
 # Pause a migration.  Currently it only supports postcopy.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "migrate-pause" }
 #     <- { "return": {} }
@@ -1943,7 +1943,7 @@
 #
 # Since: 4.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "UNPLUG_PRIMARY",
 #          "data": { "device-id": "hostdev0" },
@@ -2182,7 +2182,7 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> {"execute": "set-vcpu-dirty-limit"}
 #         "arguments": { "dirty-rate": 200,
@@ -2206,7 +2206,7 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> {"execute": "cancel-vcpu-dirty-limit"},
 #         "arguments": { "cpu-index": 1 } }
@@ -2223,7 +2223,7 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> {"execute": "query-vcpu-dirty-limit"}
 #     <- {"return": [
@@ -2287,7 +2287,7 @@
 #
 # If @tag already exists, an error will be reported
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "snapshot-save",
 #          "arguments": {
@@ -2357,7 +2357,7 @@
 # device nodes that can have changed since the original @snapshot-save
 # command execution.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "snapshot-load",
 #          "arguments": {
@@ -2418,7 +2418,7 @@
 # to determine completion and to fetch details of any errors that
 # arise.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "snapshot-delete",
 #          "arguments": {
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 2d7d4d89bd5..8d70bd24d8c 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -11,7 +11,7 @@
 #
 # Since: 2.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "rtc-reset-reinjection" }
 #     <- { "return": {} }
@@ -133,7 +133,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-sev" }
 #     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
@@ -164,7 +164,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-sev-launch-measure" }
 #     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
@@ -209,7 +209,7 @@
 #
 # Since: 2.12
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-sev-capabilities" }
 #     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
@@ -263,7 +263,7 @@
 #
 # Since: 6.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute" : "query-sev-attestation-report",
 #                      "arguments": { "mnonce": "aaaaaaa" } }
@@ -283,7 +283,7 @@
 #
 # Since: 2.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "dump-skeys",
 #          "arguments": { "filename": "/tmp/skeys" } }
@@ -328,7 +328,7 @@
 #
 # Since: 2.6
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-gic-capabilities" }
 #     <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
@@ -386,7 +386,7 @@
 #
 # Since: 6.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-sgx" }
 #     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
@@ -405,7 +405,7 @@
 #
 # Since: 6.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-sgx-capabilities" }
 #     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
@@ -480,7 +480,7 @@
 #
 # Since: 8.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-event-list" }
 #     <- { "return": [
@@ -518,7 +518,7 @@
 #
 # Since: 8.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
 #     <- { "return": { } }
diff --git a/qapi/misc.json b/qapi/misc.json
index b04efbadec6..4a6f3baeaed 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -30,7 +30,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
 #                                                  "fdname": "myclient" } }
@@ -60,7 +60,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-name" }
 #     <- { "return": { "name": "qemu-name" } }
@@ -111,7 +111,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-iothreads" }
 #     <- { "return": [
@@ -144,7 +144,7 @@
 #    In the "suspended" state, it will completely stop the VM and cause
 #    a transition to the "paused" state.  (Since 9.0)
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "stop" }
 #     <- { "return": {} }
@@ -168,7 +168,7 @@
 #    this command will transition back to the "suspended" state.  (Since
 #    9.0)
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "cont" }
 #     <- { "return": {} }
@@ -192,7 +192,7 @@
 #
 # Since: 3.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "x-exit-preconfig" }
 #     <- { "return": {} }
@@ -232,7 +232,7 @@
 #
 #    * Commands that prompt the user for data don't currently work.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "human-monitor-command",
 #          "arguments": { "command-line": "info kvm" } }
@@ -258,7 +258,7 @@
 #    The 'closefd' command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
@@ -285,7 +285,7 @@
 #    The 'closefd' command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "get-win32-socket",
 #          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
@@ -302,7 +302,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
 #     <- { "return": {} }
@@ -345,7 +345,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
 #     <- { "return": { "fdset-id": 1, "fd": 3 } }
@@ -374,7 +374,7 @@
 # .. note:: If @fd is not specified, all file descriptors in @fdset-id
 #    will be removed.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
 #     <- { "return": {} }
@@ -420,7 +420,7 @@
 #
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-fdsets" }
 #     <- { "return": [
@@ -523,7 +523,7 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-command-line-options",
 #          "arguments": { "option": "option-rom" } }
@@ -565,7 +565,7 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "RTC_CHANGE",
 #          "data": { "offset": 78 },
@@ -592,7 +592,7 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "VFU_CLIENT_HANGUP",
 #          "data": { "vfu-id": "vfu1",
diff --git a/qapi/net.json b/qapi/net.json
index dd6c365c34d..31b3417d654 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -26,7 +26,7 @@
 #    command will succeed even if the network adapter does not support
 #    link status notification.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "set_link",
 #          "arguments": { "name": "e1000.0", "up": false } }
@@ -46,7 +46,7 @@
 # Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "netdev_add",
 #          "arguments": { "type": "user", "id": "netdev1",
@@ -68,7 +68,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
 #     <- { "return": {} }
@@ -836,7 +836,7 @@
 #
 # Since: 1.6
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
 #     <- { "return": [
@@ -881,7 +881,7 @@
 #
 # Since: 1.6
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "NIC_RX_FILTER_CHANGED",
 #          "data": { "name": "vnet0",
@@ -930,7 +930,9 @@
 # switches.  This can be useful when network bonds fail-over the
 # active slave.
 #
-# Example:
+# TODO: This line is a hack to separate the example from the body
+#
+# .. qmp-example::
 #
 #     -> { "execute": "announce-self",
 #          "arguments": {
@@ -955,7 +957,7 @@
 #
 # Since: 4.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "FAILOVER_NEGOTIATED",
 #          "data": { "device-id": "net1" },
@@ -975,7 +977,7 @@
 #
 # Since: 7.2
 #
-# Examples:
+# .. qmp-example::
 #
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
 #          "data": { "netdev-id": "netdev0",
@@ -983,6 +985,8 @@
 #                              "host": "::1", "type": "inet" } },
 #          "timestamp": { "seconds": 1666269863, "microseconds": 311222 } }
 #
+# .. qmp-example::
+#
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
 #          "data": { "netdev-id": "netdev0",
 #                    "addr": { "path": "/tmp/qemu0", "type": "unix" } },
@@ -1001,7 +1005,7 @@
 #
 # Since: 7.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "NETDEV_STREAM_DISCONNECTED",
 #          "data": {"netdev-id": "netdev0"},
diff --git a/qapi/pci.json b/qapi/pci.json
index 8287d15dd0b..8e2ca560ee1 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -182,7 +182,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-pci" }
 #     <- { "return": [
diff --git a/qapi/qdev.json b/qapi/qdev.json
index d031fc3590d..e91ca0309df 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -62,7 +62,7 @@
 #        the ``-device DEVICE,help`` command-line argument, where DEVICE
 #        is the device's name.
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "device_add",
 #          "arguments": { "driver": "e1000", "id": "net1",
@@ -104,12 +104,14 @@
 #
 # Since: 0.14
 #
-# Examples:
+# .. qmp-example::
 #
 #     -> { "execute": "device_del",
 #          "arguments": { "id": "net1" } }
 #     <- { "return": {} }
 #
+# .. qmp-example::
+#
 #     -> { "execute": "device_del",
 #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
@@ -130,7 +132,7 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "DEVICE_DELETED",
 #          "data": { "device": "virtio-net-pci-0",
@@ -152,7 +154,7 @@
 #
 # Since: 6.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
 #          "data": { "device": "core1",
diff --git a/qapi/qom.json b/qapi/qom.json
index 8e75a419c30..544e0a4b736 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -59,7 +59,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "qom-list",
 #          "arguments": { "path": "/chardevs" } }
@@ -139,7 +139,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "qom-set",
 #          "arguments": { "path": "/machine",
@@ -1171,7 +1171,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "object-add",
 #          "arguments": { "qom-type": "rng-random", "id": "rng1",
@@ -1193,7 +1193,7 @@
 #
 # Since: 2.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "object-del", "arguments": { "id": "rng1" } }
 #     <- { "return": {} }
diff --git a/qapi/replay.json b/qapi/replay.json
index d3559f9c8f7..35e0c4a6926 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -54,7 +54,7 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-replay" }
 #     <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
@@ -76,7 +76,7 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
@@ -91,7 +91,7 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "replay-delete-break" }
 #     <- { "return": {} }
@@ -112,7 +112,7 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 9f95e638309..2e63dcb3d6f 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -30,7 +30,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
 #     <- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
@@ -98,7 +98,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
 #     <- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
@@ -240,7 +240,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-rocker-of-dpa-flows",
 #          "arguments": { "name": "sw1" } }
@@ -315,7 +315,7 @@
 #
 # Since: 2.4
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-rocker-of-dpa-groups",
 #          "arguments": { "name": "sw1" } }
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 4d40c88876c..ab7116680b3 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -123,7 +123,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-status" }
 #     <- { "return": { "running": true,
@@ -152,7 +152,7 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "SHUTDOWN",
 #          "data": { "guest": true, "reason": "guest-shutdown" },
@@ -168,7 +168,7 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "POWERDOWN",
 #          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
@@ -189,7 +189,7 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "RESET",
 #          "data": { "guest": false, "reason": "guest-reset" },
@@ -204,7 +204,7 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "STOP",
 #          "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
@@ -218,7 +218,7 @@
 #
 # Since: 0.12
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "RESUME",
 #          "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
@@ -233,7 +233,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "SUSPEND",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
@@ -252,7 +252,7 @@
 #
 # Since: 1.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "SUSPEND_DISK",
 #          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
@@ -267,7 +267,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "WAKEUP",
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
@@ -289,7 +289,7 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "WATCHDOG",
 #          "data": { "action": "reset" },
@@ -382,7 +382,7 @@
 #
 # Since: 2.11
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "watchdog-set-action",
 #          "arguments": { "action": "inject-nmi" } }
@@ -406,7 +406,7 @@
 #
 # Since: 6.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "set-action",
 #          "arguments": { "reboot": "shutdown",
@@ -433,7 +433,7 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "GUEST_PANICKED",
 #          "data": { "action": "pause" },
@@ -453,7 +453,7 @@
 #
 # Since: 5.0
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "GUEST_CRASHLOADED",
 #          "data": { "action": "run" },
@@ -469,7 +469,7 @@
 #
 # Since: 9.1
 #
-# Example:
+# ..qmp-example::
 #
 #     <- { "event": "GUEST_PVSHUTDOWN",
 #          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
@@ -611,7 +611,7 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "MEMORY_FAILURE",
 #          "data": { "recipient": "hypervisor",
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 1577b5c259d..a16a72edb98 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -31,7 +31,7 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-tpm-models" }
 #     <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
@@ -62,7 +62,7 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-tpm-types" }
 #     <- { "return": [ "passthrough", "emulator" ] }
@@ -168,7 +168,7 @@
 #
 # Since: 1.5
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-tpm" }
 #     <- { "return":
diff --git a/qapi/trace.json b/qapi/trace.json
index 9ebb6d9eaf5..eb5f63f5135 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -51,7 +51,7 @@
 #
 # Since: 2.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "trace-event-get-state",
 #          "arguments": { "name": "qemu_memalign" } }
@@ -74,7 +74,7 @@
 #
 # Since: 2.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "trace-event-set-state",
 #          "arguments": { "name": "qemu_memalign", "enable": true } }
diff --git a/qapi/transaction.json b/qapi/transaction.json
index bcb05fdedd6..b0ae3437eba 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -244,7 +244,7 @@
 #
 # Since: 1.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "transaction",
 #          "arguments": { "actions": [
diff --git a/qapi/ui.json b/qapi/ui.json
index 5bcccbfc930..c0e94fd0ed0 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -83,7 +83,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "set_password", "arguments": { "protocol": "vnc",
 #                                                    "password": "secret" } }
@@ -144,7 +144,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
 #                                                       "time": "+60" } }
@@ -186,7 +186,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "screendump",
 #          "arguments": { "filename": "/tmp/image" } }
@@ -330,7 +330,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-spice" }
 #     <- { "return": {
@@ -379,7 +379,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
 #          "event": "SPICE_CONNECTED",
@@ -405,7 +405,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
 #          "event": "SPICE_INITIALIZED",
@@ -432,7 +432,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
 #          "event": "SPICE_DISCONNECTED",
@@ -453,7 +453,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
 #          "event": "SPICE_MIGRATE_COMPLETED" }
@@ -661,7 +661,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-vnc" }
 #     <- { "return": {
@@ -726,7 +726,7 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "VNC_CONNECTED",
 #          "data": {
@@ -753,7 +753,7 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. qmp-example::
 #
 #     <-  { "event": "VNC_INITIALIZED",
 #           "data": {
@@ -779,7 +779,7 @@
 #
 # Since: 0.13
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "event": "VNC_DISCONNECTED",
 #          "data": {
@@ -827,7 +827,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-mice" }
 #     <- { "return": [
@@ -1036,7 +1036,7 @@
 #
 # Since: 1.3
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "send-key",
 #          "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
@@ -1615,7 +1615,7 @@
 #
 # Since: 6.0
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "display-reload",
 #          "arguments": { "type": "vnc", "tls-certs": true  } }
@@ -1672,7 +1672,7 @@
 #
 # Since: 7.1
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "display-update",
 #          "arguments": { "type": "vnc", "addresses":
@@ -1703,7 +1703,7 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "client_migrate_info",
 #          "arguments": { "protocol": "spice",
diff --git a/qapi/vfio.json b/qapi/vfio.json
index a0e5013188a..40cbcde02eb 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -50,7 +50,7 @@
 #
 # Since: 9.1
 #
-# Example:
+# .. qmp-example::
 #
 #     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
 #          "event": "VFIO_MIGRATION",
diff --git a/qapi/virtio.json b/qapi/virtio.json
index b91f3cdd0df..f4323cc35e8 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -34,7 +34,7 @@
 #
 # Since: 7.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "x-query-virtio" }
 #     <- { "return": [
diff --git a/qapi/yank.json b/qapi/yank.json
index 89f2f4d199b..30f46c97c98 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -81,7 +81,7 @@
 # Errors:
 #     - If any of the YankInstances doesn't exist, DeviceNotFound
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "yank",
 #          "arguments": {
@@ -104,7 +104,7 @@
 #
 # Returns: list of @YankInstance
 #
-# Example:
+# .. qmp-example::
 #
 #     -> { "execute": "query-yank" }
 #     <- { "return": [
-- 
2.45.0


