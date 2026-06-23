Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B20CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpB-0002Xh-72; Tue, 23 Jun 2026 03:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvow-0002P9-5O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvot-000804-9d
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dlnWvp/uCv+XaxwfGHLQeztxW57sEQxRI5reUU98Sw=;
 b=fi2dm29UPHibo+J1pw5/NJF2KL6CtRamfM7nYxHbKaZG/8vcwRd8wg5tSzHBMKQ55pDhnD
 pgMyad0Ee0NPfx9chSezUrdQTKIEzOvpJEI8Zi0zz68crc2zlWCIrfZfVlj7Ol//kkyQNf
 ICHZ0LQD/xwSphoqAos74+m3/4O1Fb8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-2aNj3dGPMr-v7x6Cyo5SPw-1; Tue,
 23 Jun 2026 03:45:14 -0400
X-MC-Unique: 2aNj3dGPMr-v7x6Cyo5SPw-1
X-Mimecast-MFC-AGG-ID: 2aNj3dGPMr-v7x6Cyo5SPw_1782200713
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06E781955F29; Tue, 23 Jun 2026 07:45:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A078D30001BE; Tue, 23 Jun 2026 07:45:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:21 +0400
Subject: [PATCH v4 06/34] docs: add mdpy mdev vfio display testing guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-6-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3288;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rXOvhoLrcrsbxgHDq3Fn9v1wo1nSjJecvLCkxFeD940=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjld3CkSHmwTR5B17AsXOsRKzT0npj+MrgWHS
 jtQV/cxTnmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5X56D/98Y0bC4Mcm3kH5R+UgDRR0ps0LFb0iKGSMd5R8CRdWIyBC+jXVio28HcHwtx4I34k/126
 xpJ0K9xUBzmOtvv5qqKLrslQdsDRkdqNAI4dsfVs8fb2fpxZnCGA75pZHlAvyHqYlbgXsHvrMqK
 ZMQOs+oCjwANNllQCjPWXWG6KIDn8tVvF50ndHv9c22bwTnRBw+y3actLFy7OuGcHA9wZH3vGuH
 7txlMJJzPE8jucqabXz6vfnytpYJeOSXlZn6CDshq2jIzufYCpxXOvYojFlHUnp9F1aiBlRGEYP
 h8BBq/HsvjST5HjahU0k7Nmtx3zhsPnIjSiIzZNAF3dESXPfIZgqDFmaOXzpYZ7ZZ6XeCqL0OYL
 9BTCWXnVvnI6PSvnEAe+QPQ5jNMDTOE9cBaRGDZCVGoTxeiGJKFN4vHPMSrlOrvS4D4Fr+j/B72
 3vyRSkQjxM0a+eICrSkxCCLP0SqnJkkSGaKccqu3bFFHOiD5XlLJs+OTcs8fnvQuxy187Nokg5y
 4iMBFSg4h4mgWBuXFVIhZQjuoPDbI15OphYJIzO35ddpVV5UdIzj62EpDtOvueQEy9hUSyLAuoL
 9F4Dni6troYaoHvFgIwWHUhphzYLFK5hHtVnUGZwWRFlC+kyN51sFqtmD32z5Xyt/LKPlX3a0IQ
 3JtVmJNopA8vRSQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Document how to test VFIO display hotplug using the kernel mdpy mdev
sample.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/index-internals.rst |  1 +
 docs/devel/vfio-mdpy.rst       | 90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 7a0678cbdd3..198f155247a 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -22,6 +22,7 @@ Details about QEMU's various subsystems including how to add features to them.
    tracing
    uefi-vars
    vfio-iommufd
+   vfio-mdpy
    writing-monitor-commands
    virtio-backends
    crypto
diff --git a/docs/devel/vfio-mdpy.rst b/docs/devel/vfio-mdpy.rst
new file mode 100644
index 00000000000..7875d00d1e0
--- /dev/null
+++ b/docs/devel/vfio-mdpy.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===================================
+Testing VFIO display with mdev mdpy
+===================================
+
+.. contents:: Table of Contents
+
+The kernel provides a sample mediated device driver, ``mdpy``
+(``samples/vfio-mdev/mdpy.c``), that exposes a fake framebuffer through the VFIO
+display region interface. It can be used to test VFIO display support, including
+hotplug, without any real GPU hardware.
+
+The kernel modules
+==================
+
+The ``mdpy`` driver depends on the ``mdev`` subsystem. Enable, build and load
+the modules.
+
+The minimal set is::
+
+    CONFIG_SAMPLE_VFIO_MDEV_MDPY=m
+    CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB=m   # guest framebuffer driver
+
+CONFIG_VFIO_MDEV is selected automatically.
+
+Verify that the driver registered successfully:
+
+.. code-block:: bash
+
+    ls /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/
+
+Creating an mdev instance
+=========================
+
+Available types correspond to different resolutions (e.g. ``mdpy-vga``
+for 640x480, ``mdpy-xga`` for 1024x768, ``mdpy-hd`` for 1920x1080).
+
+Each mdev instance is identified by a UUID:
+
+.. code-block:: bash
+
+    uuid=$(uuidgen)
+    echo "$uuid" > /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/mdpy-xga/create
+
+To remove the instance later:
+
+.. code-block:: bash
+
+    echo 1 > /sys/bus/mdev/devices/$uuid/remove
+
+Make sure your user has the necessary permissions to access the vfio group.
+(ex: chmod 666 /dev/vfio/16)
+
+Starting QEMU
+=============
+
+Boot-time attachment
+--------------------
+
+.. code-block:: bash
+
+    qemu-system-x86_64 -machine q35 -m 1G \
+        -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/$uuid,display=on \
+        -display gtk,gl=on
+
+Hotplug via HMP
+---------------
+
+Start QEMU with a PCIe root port (required for PCIe hotplug) and a
+monitor:
+
+.. code-block:: bash
+
+    qemu-system-x86_64 -machine q35 -m 1G \
+        -device pcie-root-port,id=rp0,slot=1 \
+        -display gtk,gl=on \
+        -monitor stdio
+
+Then at the ``(qemu)`` prompt:
+
+.. code-block:: none
+
+    device_add vfio-pci,sysfsdev=/sys/bus/mdev/devices/<uuid>,display=on,bus=rp0,id=mdpy0
+
+To hot-unplug:
+
+.. code-block:: none
+
+    device_del mdpy0

-- 
2.54.0


