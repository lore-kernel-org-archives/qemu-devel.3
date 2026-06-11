Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AB9CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKn-0000NR-4N; Thu, 11 Jun 2026 05:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKl-0000MU-FK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKj-0004dL-Rv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxoHi3/BVRshoRkYAb1tWFuXo1nZHct01e2GbgnVJ9I=;
 b=HSFItGnkT5ppjuAq21klskp6xGtiBIaDV7v/0nWBlTG8sr1GNt5YC5lTqrOgP1TKF6eyQh
 W2bVr3HpdESMRGZjhGf7yKDzRVekyANU8xEliG75Q9BNpUmJKkN9//y3yndw/S554Rtrq7
 9MrILYjHVQ/BsKLKcGWhp1rOGGAZyrY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-_FLkLpaAMyufAS0mUEx8nQ-1; Thu,
 11 Jun 2026 05:04:14 -0400
X-MC-Unique: _FLkLpaAMyufAS0mUEx8nQ-1
X-Mimecast-MFC-AGG-ID: _FLkLpaAMyufAS0mUEx8nQ_1781168652
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D99A1944F03; Thu, 11 Jun 2026 09:04:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE7B219541B2; Thu, 11 Jun 2026 09:04:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:21 +0400
Subject: [PATCH v3 06/35] docs: start a vfio-pci document
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-6-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b85O20VHUevR2QzmBXGUiER4+nMVtbaVVXPoZyWpLTM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnndaycbxzzZmUePQ70mErJKrN+ll9JDNOAmg
 /zOn7ru3H2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53QAKCRDa6OEJdZac
 5fMtEACzT5JyOmnRMcvrQZvjtV0kTj5ZoaNHyUJa6PvbdhxEUY99yiDvgPddIsjUqcYaIc0n+dt
 Z2BwJ6TuQDoiGH0Gg7bPnUeCc1/S94OxxZlxC2RjbKRRS6V6ZDKaMvvqYs13KV5TfjM6Tearb3O
 /IiICleyqCoDDPuhk2KA8UTeA3jg64Fy9bSRPDGVIP5QsGEFIDuH7v+jxLnJ6W3fqmvd72ujefY
 xblwsvCQ+Dv2AMnJXk2VJeUMr3SnzFYmPEq7bRSqmVyI9V64qjdQs26vG3VW0paPBQNKaX9Q0Qo
 3PBNj/sqmBvffcSDoXDzVUQmvcmYEPU39xQ2B4zOtUHtZ8luPmqUvDm0IpOaj/SAXy4hZgrUz82
 ZTm0u++xAYbQ23MM/JGM8iECoToPx0aGZsK84hSGFQn5MqRYxawu30S6HWXAOR3HsKKoJsrIXnO
 VdjsRsM511zu0jd8c7gvKVf33RZA0ZQInmb59ZdISz1vonlpGG0L2aFO3V8cBXAyCqNJRTRzWpd
 oz1PQkUN3m9+TVNxPqkHtqm3k1SA1YJ5vS54k3z4iFLJOuI05GywXJPu5zbbg1jcLoM72/zn0B6
 r6na5bdz4VXL6TLJu88RZH94It8Jc4Nb2pFKYPZaEI2I/Mq26Nggx6K6gNoQp7Z2GwXSU7GO9hj
 2J5/ozoWbVXJtcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a section to help me remember how to test vfio display hotplug.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/index-internals.rst |  1 +
 docs/devel/vfio-mdpy.rst       | 83 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

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
index 00000000000..14cddd11d81
--- /dev/null
+++ b/docs/devel/vfio-mdpy.rst
@@ -0,0 +1,83 @@
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


