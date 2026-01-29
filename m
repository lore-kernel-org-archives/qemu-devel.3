Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B96D73E8C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZRn-0005UF-Fy; Thu, 29 Jan 2026 16:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vlZRm-0005Tq-JI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:21:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vlZRh-0006BF-6c
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769721656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HssO8XaU3aOzfMrJOnBdsvEsYFflmJgynuuBcKjEJ5A=;
 b=RsYM8E/lzNvQVROjYCZIYCphIHxaBIkQjOb5y47Ol+ZrJbLmLy7b4a/zn+YWA1VN9hS6YB
 7hDCZxNXP4WM1CSupFga61AMV1E7B2X7PMRYeYvk5U7/IU6DS2aRLqnpuWolVSUoO2AeTd
 tAFTG33qVDJ51pzpW7iezRhCcCXVq7g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-17TCz4KTNjCJEHzImdo4CQ-1; Thu,
 29 Jan 2026 16:20:51 -0500
X-MC-Unique: 17TCz4KTNjCJEHzImdo4CQ-1
X-Mimecast-MFC-AGG-ID: 17TCz4KTNjCJEHzImdo4CQ_1769721650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2408D1956088; Thu, 29 Jan 2026 21:20:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.153])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C16A13000218; Thu, 29 Jan 2026 21:20:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Qing Wang <qinwang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hannes Reinecke <hare@suse.de>, pkrempa@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Alberto Faria <afaria@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 5/5] docs: add SCSI migrate-pr documentation
Date: Thu, 29 Jan 2026 16:20:35 -0500
Message-ID: <20260129212035.219676-6-stefanha@redhat.com>
In-Reply-To: <20260129212035.219676-1-stefanha@redhat.com>
References: <20260129212035.219676-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/system/device-emulation.rst        |  1 +
 docs/system/devices/scsi/index.rst      | 10 +++++
 docs/system/devices/scsi/migrate-pr.rst | 54 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 docs/system/devices/scsi/index.rst
 create mode 100644 docs/system/devices/scsi/migrate-pr.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 971325527a..40054bb7df 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -95,6 +95,7 @@ Emulated Devices
    devices/keyboard.rst
    devices/net.rst
    devices/nvme.rst
+   devices/scsi/index.rst
    devices/usb-u2f.rst
    devices/usb.rst
    devices/vfio-user.rst
diff --git a/docs/system/devices/scsi/index.rst b/docs/system/devices/scsi/index.rst
new file mode 100644
index 0000000000..4f0929b0ca
--- /dev/null
+++ b/docs/system/devices/scsi/index.rst
@@ -0,0 +1,10 @@
+SCSI Devices
+============
+
+Several SCSI devices are available in QEMU. They are primarily used for block
+storage.
+
+.. toctree::
+   :maxdepth: 1
+
+   migrate-pr.rst
diff --git a/docs/system/devices/scsi/migrate-pr.rst b/docs/system/devices/scsi/migrate-pr.rst
new file mode 100644
index 0000000000..a8f2790a86
--- /dev/null
+++ b/docs/system/devices/scsi/migrate-pr.rst
@@ -0,0 +1,54 @@
+..
+    SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _scsi_migrate_pr:
+
+SCSI Persistent Reservation Live Migration
+==========================================
+
+This document explains how to live migrate SCSI Persistent Reservations.
+
+The ``scsi-block`` device migrates SCSI Persistent Reservations when the
+``migrate-pr=on`` parameter is given. Migration is enabled by default in
+versioned machine types since QEMU 11.0. It is disabled by default on older
+machine types and needs to be explicitly enabled with ``--device
+scsi-block,migrate-pr=on,...``.
+
+When migration is enabled, QEMU snoops PERSISTENT RESERVATION OUT commands and
+tracks the reservation key registered by the guest as well as reservations that
+the guest acquires. This information is migrated along with the guest and the
+destination QEMU submits a PERSISTENT RESERVATION OUT command with the PREEMPT
+service action to atomically transfer the reservation to the destination before
+the guest starts running on the destination.
+
+The following persistent reservation capabilities reported by the PERSISTENT
+RESERVATION IN command with the REPORT CAPABILITIES service action are masked
+from the guest by QEMU when migration is enabled:
+
+ * Specify Initiator Ports Capable (SIP_C)
+ * All Target Ports Capable (ATC_C)
+
+When migration is disabled, the ``scsi-block`` device is live migrated but
+reservations remain in place on the source. Usually this is not the intended
+behavior unless there is another mechanism to update reservations during
+migration. The PERSISTENT RESERVATION IN command also does not mask
+capabilities reported to the guest when migration is disabled.
+
+Limitations
+-----------
+
+QEMU does not remember snooped reservation details across restart, so software
+inside the guest must acquire the reservation after boot in order for live
+migration to work. Similarly, if the reservation is acquired outside the guest
+then it will not live migrate along with the guest.
+
+Snooping only considers the PERSISTENT RESERVATION OUT commands from the guest
+and does not track reservation changes made by other SCSI initiators. QEMU's
+snooped reservation details can become stale if another SCSI initiator
+makes changes to the reservation.
+
+Guests running on the same host share a single SCSI initiator identity unless
+Fibre Channel N_Port ID Virtualization is configured. As a consequence,
+multiple guests on the same hosts may observe unexpected behavior if they use
+the same physical LUN. From the LUN's perspective all guests are the same
+initiator and there is no way to distinguish between guests.
-- 
2.52.0


