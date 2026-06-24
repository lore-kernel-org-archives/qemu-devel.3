Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AADCDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzh-0007fV-Ed; Wed, 24 Jun 2026 07:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzf-0007bn-Qi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzd-0007cM-Bi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxPMwAbJHWARXqBVDJL37vTBIOnzY5ypKFLJNezcI/A=;
 b=XlG90qL8kNdeordxV7OeTvJ43BXJQCLzYUo7Zo0GhjETLt4uyjGq6ihMn+RVmC9A+oKEG9
 mB+hmgHV1YFvoenjm/AvH6yl3EO0JmPwH89/g2VDABXMOAi9uVH6OunS3F2JtVzJMG2eiz
 MpLTZfJf11BiJhMwNfaonNUVWIqJkJQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-wi0TcqWWN4G7wfhf0yHBuw-1; Wed,
 24 Jun 2026 07:42:07 -0400
X-MC-Unique: wi0TcqWWN4G7wfhf0yHBuw-1
X-Mimecast-MFC-AGG-ID: wi0TcqWWN4G7wfhf0yHBuw_1782301326
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95F151800370
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6231E36921; Wed, 24 Jun 2026 11:42:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:28 +0400
Subject: [GIT PULL 06/35] docs: add mdpy mdev vfio display testing guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-6-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Dy7irsKVA2yrMbCp9NRN1ooropnjnNEQ2b56VQv9GbM=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGo7wmaijLHYOvN8XuKhh3yYZNpJwWzHJD/AUqR4ovCpZfqgp
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqO8JmAAoJENro4Ql1lpzlaIUP/3BJ
 fu7sOZ+ddTdcY/c/iaj1Oiis/z1s5/kk3K2apOEuLQ20APyCVu5CRnMKpVGT510vlQ2IesZOLOV
 Cj+L5IQGYrFQruOpjRjSv8njIulmJ86aOtg63KGCrPv6hOEqBYy89lhF1i1lEbWBzs4vcWS49Ul
 puDomLUGKB3eb5LwBU2npZBzPl1+i7Mg70e5hUbVdzeV625L69+V33Dzz856RvStX+ctSoRlcCg
 BYtLMr0ysa/LarqF6B6zZEe+L+NRQ9WEcwr33T9C51qIja6+874pdHyF0mBw5Zlyr1WppTSOb7e
 E0VgTyQGoV5IH26QgxgR5kR31h1CVlrmQfr/VSdhy0GfuRJ/FjG6q0OWi8u4D+zpmYAz6YRAjRY
 NlBiYCqJRGAGNQEfkSiUQXzJ/Um92IY/t/fiDHAWiAchudZ1vum9QOfZqh0jzAPNbAFbIVpakU3
 RRVJHvxwP1p2Q1YgYjxdTlL6sYiAzPNiwG0NZwWk/kH8kbsa5dbxyqe52gSS5FC5FU1muiMCG59
 r+cwSJ55YTiy1+5CFCVxoYzKehKbEZJcCheYUmOS+GGBxi9fJTxo/jbP67f31+fMfiQPmcTSZIn
 arCW6DLanW2fT+KP89dLTcQ/1B1SwCmJ1grOn74GBhH3NZLjHlYj4qLAsx/kkH+CLJ6pjq7p7yA
 uup6y
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Document how to test VFIO display hotplug using the kernel mdpy mdev
sample.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-6-4656aec3398d@redhat.com>
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


