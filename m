Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA1DC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYbS-0002ew-VF; Wed, 24 Jul 2024 05:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYbR-0002X8-6f
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYbO-0003Or-VM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3tnQlbYIo9RiEVK0g0LNnHZV6TRGTyfv8yD2i1HDZ0=;
 b=hBoLdAb5BX8nSe7TPyZZyOlEOny/3PhvEu5OFqNYxGhJI2Rp0O8jp+6pw8vTI3cDmwM5RS
 cTiDsN0Pg2AaNHU/FgOeYUmwz/N9RKF+GsMD6WlOSd/wK4SNV6o10q+IF95/nBfgck68hs
 kLSiaiKEsWGXdZ6JpAQWCADdfqenkio=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-aA-5vbvgMtWiCxWGmpcuDQ-1; Wed,
 24 Jul 2024 05:48:03 -0400
X-MC-Unique: aA-5vbvgMtWiCxWGmpcuDQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C5981955D52; Wed, 24 Jul 2024 09:48:02 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4787D19560AA; Wed, 24 Jul 2024 09:47:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 04/11] docs/devel: Add introduction to LUKS volume with
 detached header
Date: Wed, 24 Jul 2024 10:46:59 +0100
Message-ID: <20240724094706.30396-5-berrange@redhat.com>
In-Reply-To: <20240724094706.30396-1-berrange@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS                         |   1 +
 docs/devel/crypto.rst               |  10 ++
 docs/devel/index-internals.rst      |   1 +
 docs/devel/luks-detached-header.rst | 182 ++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 docs/devel/crypto.rst
 create mode 100644 docs/devel/luks-detached-header.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 73040829b1..98eddf7ae1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3451,6 +3451,7 @@ Detached LUKS header
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
 F: tests/qemu-iotests/tests/luks-detached-header
+F: docs/devel/luks-detached-header.rst
 
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
diff --git a/docs/devel/crypto.rst b/docs/devel/crypto.rst
new file mode 100644
index 0000000000..39b1c910e7
--- /dev/null
+++ b/docs/devel/crypto.rst
@@ -0,0 +1,10 @@
+.. _crypto-ref:
+
+====================
+Cryptography in QEMU
+====================
+
+.. toctree::
+   :maxdepth: 2
+
+   luks-detached-header
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 5636e9cf1d..4ac7725d72 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -20,3 +20,4 @@ Details about QEMU's various subsystems including how to add features to them.
    vfio-iommufd
    writing-monitor-commands
    virtio-backends
+   crypto
diff --git a/docs/devel/luks-detached-header.rst b/docs/devel/luks-detached-header.rst
new file mode 100644
index 0000000000..94ec285c27
--- /dev/null
+++ b/docs/devel/luks-detached-header.rst
@@ -0,0 +1,182 @@
+================================
+LUKS volume with detached header
+================================
+
+Introduction
+============
+
+This document gives an overview of the design of LUKS volume with detached
+header and how to use it.
+
+Background
+==========
+
+The LUKS format has ability to store the header in a separate volume from
+the payload. We could extend the LUKS driver in QEMU to support this use
+case.
+
+Normally a LUKS volume has a layout:
+
+::
+
+         +-----------------------------------------------+
+         |         |                |                    |
+ disk    | header  |  key material  |  disk payload data |
+         |         |                |                    |
+         +-----------------------------------------------+
+
+With a detached LUKS header, you need 2 disks so getting:
+
+::
+
+         +--------------------------+
+ disk1   |   header  | key material |
+         +--------------------------+
+         +---------------------+
+ disk2   |  disk payload data  |
+         +---------------------+
+
+There are a variety of benefits to doing this:
+
+ * Secrecy - the disk2 cannot be identified as containing LUKS
+             volume since there's no header
+ * Control - if access to the disk1 is restricted, then even
+             if someone has access to disk2 they can't unlock
+             it. Might be useful if you have disks on NFS but
+             want to restrict which host can launch a VM
+             instance from it, by dynamically providing access
+             to the header to a designated host
+ * Flexibility - your application data volume may be a given
+                 size and it is inconvenient to resize it to
+                 add encryption.You can store the LUKS header
+                 separately and use the existing storage
+                 volume for payload
+ * Recovery - corruption of a bit in the header may make the
+              entire payload inaccessible. It might be
+              convenient to take backups of the header. If
+              your primary disk header becomes corrupt, you
+              can unlock the data still by pointing to the
+              backup detached header
+
+Architecture
+============
+
+Take the qcow2 encryption, for example. The architecture of the
+LUKS volume with detached header is shown in the diagram below.
+
+There are two children of the root node: a file and a header.
+Data from the disk payload is stored in the file node. The
+LUKS header and key material are located in the header node,
+as previously mentioned.
+
+::
+
+                       +-----------------------------+
+  Root node            |          foo[luks]          |
+                       +-----------------------------+
+                          |                       |
+                     file |                header |
+                          |                       |
+               +---------------------+    +------------------+
+  Child node   |payload-format[qcow2]|    |header-format[raw]|
+               +---------------------+    +------------------+
+                          |                       |
+                     file |                 file  |
+                          |                       |
+               +----------------------+  +---------------------+
+  Child node   |payload-protocol[file]|  |header-protocol[file]|
+               +----------------------+  +---------------------+
+                          |                       |
+                          |                       |
+                          |                       |
+                     Host storage            Host storage
+
+Usage
+=====
+
+Create a LUKS disk with a detached header using qemu-img
+--------------------------------------------------------
+
+Shell commandline::
+
+  # qemu-img create --object secret,id=sec0,data=abc123 -f luks \
+    -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0 \
+    -o detached-header=true test-header.img
+  # qemu-img create -f qcow2 test-payload.qcow2 200G
+  # qemu-img info 'json:{"driver":"luks","file":{"filename": \
+    "test-payload.img"},"header":{"filename":"test-header.img"}}'
+
+Set up a VM's LUKS volume with a detached header
+------------------------------------------------
+
+Qemu commandline::
+
+  # qemu-system-x86_64 ... \
+    -object '{"qom-type":"secret","id":"libvirt-3-format-secret", \
+    "data":"abc123"}' \
+    -blockdev '{"driver":"file","filename":"/path/to/test-header.img", \
+    "node-name":"libvirt-1-storage"}' \
+    -blockdev '{"node-name":"libvirt-1-format","read-only":false, \
+    "driver":"raw","file":"libvirt-1-storage"}' \
+    -blockdev '{"driver":"file","filename":"/path/to/test-payload.qcow2", \
+    "node-name":"libvirt-2-storage"}' \
+    -blockdev '{"node-name":"libvirt-2-format","read-only":false, \
+    "driver":"qcow2","file":"libvirt-2-storage"}' \
+    -blockdev '{"node-name":"libvirt-3-format","driver":"luks", \
+    "file":"libvirt-2-format","header":"libvirt-1-format","key-secret": \
+    "libvirt-3-format-secret"}' \
+    -device '{"driver":"virtio-blk-pci","bus":XXX,"addr":YYY,"drive": \
+    "libvirt-3-format","id":"virtio-disk1"}'
+
+Add LUKS volume to a VM with a detached header
+----------------------------------------------
+
+1. object-add the secret for decrypting the cipher stored in
+   LUKS header above::
+
+    # virsh qemu-monitor-command vm '{"execute":"object-add", \
+      "arguments":{"qom-type":"secret", "id": \
+      "libvirt-4-format-secret", "data":"abc123"}}'
+
+2. block-add the protocol node for LUKS header::
+
+    # virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+      "arguments":{"node-name":"libvirt-1-storage", "driver":"file", \
+      "filename": "/path/to/test-header.img" }}'
+
+3. block-add the raw-drived node for LUKS header::
+
+    # virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+      "arguments":{"node-name":"libvirt-1-format", "driver":"raw", \
+      "file":"libvirt-1-storage"}}'
+
+4. block-add the protocol node for disk payload image::
+
+    # virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+      "arguments":{"node-name":"libvirt-2-storage", "driver":"file", \
+      "filename":"/path/to/test-payload.qcow2"}}'
+
+5. block-add the qcow2-drived format node for disk payload data::
+
+    # virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+      "arguments":{"node-name":"libvirt-2-format", "driver":"qcow2", \
+      "file":"libvirt-2-storage"}}'
+
+6. block-add the luks-drived format node to link the qcow2 disk
+   with the LUKS header by specifying the field "header"::
+
+    # virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+      "arguments":{"node-name":"libvirt-3-format", "driver":"luks", \
+      "file":"libvirt-2-format", "header":"libvirt-1-format", \
+      "key-secret":"libvirt-2-format-secret"}}'
+
+7. hot-plug the virtio-blk device finally::
+
+    # virsh qemu-monitor-command vm '{"execute":"device_add", \
+      "arguments": {"driver":"virtio-blk-pci", \
+      "drive": "libvirt-3-format", "id":"virtio-disk2"}}
+
+TODO
+====
+
+1. Support the shared detached LUKS header within the VM.
-- 
2.45.2


