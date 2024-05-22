Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC05C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9igz-0003Vu-1H; Wed, 22 May 2024 05:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igo-0003Ru-JV
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igm-0001QY-FZ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VQ9NVIxSHCsEaByjV2CBIUySE2+PXzk48re8ExyFxo=;
 b=dkNjqezOrvKS6ljF359JAChoNQmvspXjqhIgUIFnYBtYWP8NkcxvNtxlbwUD205hsOedVU
 PlTM05hsnuzJvmM6/2epKl/BWWAfYBL/VQz2iihqevPSGui3mCVkC9NSV+htBGe4/uVvTG
 hkFksD60IoEPnoPbcHpr+lUK+LzR8zM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-7kB82LrMOQO0fKBWph7wUA-1; Wed,
 22 May 2024 05:55:12 -0400
X-MC-Unique: 7kB82LrMOQO0fKBWph7wUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAC2B3C025C2;
 Wed, 22 May 2024 09:55:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A942E28E2;
 Wed, 22 May 2024 09:55:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/47] qapi/vfio: Add VFIO migration QAPI event
Date: Wed, 22 May 2024 11:54:10 +0200
Message-ID: <20240522095442.195243-16-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Add a new QAPI event for VFIO migration. This event will be emitted when
a VFIO device changes its migration state, for example, during migration
or when stopping/starting the guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

Note that this new event is introduced since VFIO devices have a unique
set of migration states which cannot be described as accurately by other
existing events such as run state or migration status.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS           |  1 +
 qapi/qapi-schema.json |  1 +
 qapi/vfio.json        | 67 +++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 4 files changed, 70 insertions(+)
 create mode 100644 qapi/vfio.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b79767d61960189eaa9d3d736e77722b8d5d9f0..448dc951c50913e7111d3bb6833a00acea7f50f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2164,6 +2164,7 @@ F: hw/vfio/*
 F: include/hw/vfio/
 F: docs/igd-assign.txt
 F: docs/devel/migration/vfio.rst
+F: qapi/vfio.json
 
 vfio-ccw
 M: Eric Farman <farman@linux.ibm.com>
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 5e33da7228f22abd20fa49f32c95e6a381ababd1..b1581988e4eba99cbe9ca53501918dd2d9bcfe44 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -78,5 +78,6 @@
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
+{ 'include': 'vfio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
diff --git a/qapi/vfio.json b/qapi/vfio.json
new file mode 100644
index 0000000000000000000000000000000000000000..a0e5013188a4d16d842c8463d6e4c33742e06a97
--- /dev/null
+++ b/qapi/vfio.json
@@ -0,0 +1,67 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+
+##
+# = VFIO devices
+##
+
+##
+# @VfioMigrationState:
+#
+# An enumeration of the VFIO device migration states.
+#
+# @stop: The device is stopped.
+#
+# @running: The device is running.
+#
+# @stop-copy: The device is stopped and its internal state is available
+#     for reading.
+#
+# @resuming: The device is stopped and its internal state is available
+#     for writing.
+#
+# @running-p2p: The device is running in the P2P quiescent state.
+#
+# @pre-copy: The device is running, tracking its internal state and its
+#     internal state is available for reading.
+#
+# @pre-copy-p2p: The device is running in the P2P quiescent state,
+#     tracking its internal state and its internal state is available
+#     for reading.
+#
+# Since: 9.1
+##
+{ 'enum': 'VfioMigrationState',
+  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
+            'pre-copy', 'pre-copy-p2p' ],
+  'prefix': 'QAPI_VFIO_MIGRATION_STATE' }
+
+##
+# @VFIO_MIGRATION:
+#
+# This event is emitted when a VFIO device migration state is changed.
+#
+# @device-id: The device's id, if it has one.
+#
+# @qom-path: The device's QOM path.
+#
+# @device-state: The new changed device migration state.
+#
+# Since: 9.1
+#
+# Example:
+#
+#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
+#          "event": "VFIO_MIGRATION",
+#          "data": {
+#              "device-id": "vfio_dev1",
+#              "qom-path": "/machine/peripheral/vfio_dev1",
+#              "device-state": "stop" } }
+##
+{ 'event': 'VFIO_MIGRATION',
+  'data': {
+      'device-id': 'str',
+      'qom-path': 'str',
+      'device-state': 'VfioMigrationState'
+  } }
diff --git a/qapi/meson.build b/qapi/meson.build
index c92af6e063a1b13ec3cce18e0572a859779b2ce4..e7bc54e5d047090aa2cdb823ef9ff4b892adb614 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -52,6 +52,7 @@ qapi_all_modules = [
   'stats',
   'trace',
   'transaction',
+  'vfio',
   'virtio',
   'yank',
 ]
-- 
2.45.1


