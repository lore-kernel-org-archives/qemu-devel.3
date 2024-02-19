Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE0C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6AZ-0006eb-4X; Mon, 19 Feb 2024 11:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rc6AU-0006eA-B8
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:06:59 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rc6AQ-00049t-8k
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:06:58 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-59a31c14100so1622356eaf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708358690; x=1708963490;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3RO+D3YekMGBsu2bIZAO9/jWE9gPB9Zx0zWLkbEMK5E=;
 b=IOurrxB6JzVO9KPe606CY+/bukQadEpv8wMkPJb8MpB0frCm+3dx9Bi2jrWA4eNw9A
 XP8d6yi8wrcPb2Dt5cPvelYiD/r4cAKlNMcQ0DfWWxf3Be6+/AWOmy8R4Exlvp382kSF
 F6ezDVnix3c+OP2zijPCrpzR/vBkdX6RQuP/zdkDyzcQ39nLhixYlt9UzUnnfqhCyXRo
 jhvg6lSVWubTdn9SeW9ozejPtMe4U2TVvdbJAckuhhOt1ZSZlW7mZH9HKr7ojk/h3HM9
 /SCjxerATT2IUNy5RkQ1r+XK4JcfhgzHd12SSIRXR4uUyW2L5A6qA5ZlXtfWUJ/712qG
 3zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708358690; x=1708963490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RO+D3YekMGBsu2bIZAO9/jWE9gPB9Zx0zWLkbEMK5E=;
 b=LCe+hUY+C/zuxxAPxOJfwgFYLyjFcuEbpk9ErXy5sct5NVV7fyY4X3899LDkCl9Ufj
 iLuW/4Jya1WHIj0/Q+N0OI0HU6iN9n0dgNDfK1Obk4BZQxk9dTFn5LRPY/4l/hqlOAsl
 KXKwJwQFO2kS5NFKBVqBnHKFKVf/tK7eyUTjkqdLbCfafNu779vpHZQ39hOm1Ejkqk9e
 g62j//iRdfOcSxJkW9VPcaM1KsJPveHWrL9Z5OfcUttnYaZgKsDicwU3v6+9TBxd05go
 /I4WcrupO24JAB0NxjGKHC3cuZ5nN0wIQBoiTYuS5OZ0DVfaAV6vzIDmt4ovUsVOE20d
 AkhQ==
X-Gm-Message-State: AOJu0Yxh96Nb5sF6aibNMpQMh1dHzLpApCqw3UrXnBd1Uk2AkNrBEA8e
 LTljMPiFK+kZBhVXd7R0ySkdt7eczwtglMl+e+OkiecxXci6aSvPtHnJTd1kAe58nXE1OujrWSP
 vwPk=
X-Google-Smtp-Source: AGHT+IHkku5k8rDOA5w03o1+XzOqjtx5gIkDbeFcFCG72Cprz497rARH3wA7AzDQlwZIPn7bwZcxNw==
X-Received: by 2002:a05:6358:63a7:b0:17a:e013:9586 with SMTP id
 k39-20020a05635863a700b0017ae0139586mr14460380rwh.29.1708358689310; 
 Mon, 19 Feb 2024 08:04:49 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 p48-20020a056a0026f000b006e466479e90sm1752224pfw.166.2024.02.19.08.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 08:04:48 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH] docs/devel: Add introduction to LUKS volume with detached
 header
Date: Tue, 20 Feb 2024 00:04:42 +0800
Message-Id: <c2049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 MAINTAINERS                         |   1 +
 docs/devel/luks-detached-header.rst | 182 ++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 docs/devel/luks-detached-header.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..e8b03032ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3422,6 +3422,7 @@ Detached LUKS header
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
 F: tests/qemu-iotests/tests/luks-detached-header
+F: docs/devel/luks-detached-header.rst
 
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
diff --git a/docs/devel/luks-detached-header.rst b/docs/devel/luks-detached-header.rst
new file mode 100644
index 0000000000..15e9ccde1d
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
+# qemu-img create --object secret,id=sec0,data=abc123 -f luks \
+> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0 \
+> -o detached-header=true test-header.img
+# qemu-img create -f qcow2 test-payload.qcow2 200G
+# qemu-img info 'json:{"driver":"luks","file":{"filename": \
+> "test-payload.img"},"header":{"filename":"test-header.img"}}'
+
+Set up a VM's LUKS volume with a detached header
+------------------------------------------------
+
+Qemu commandline::
+
+# qemu-system-x86_64 ... \
+> -object '{"qom-type":"secret","id":"libvirt-3-format-secret", \
+> "data":"abc123"}' \
+> -blockdev '{"driver":"file","filename":"/path/to/test-header.img", \
+> "node-name":"libvirt-1-storage"}' \
+> -blockdev '{"node-name":"libvirt-1-format","read-only":false, \
+> "driver":"raw","file":"libvirt-1-storage"}' \
+> -blockdev '{"driver":"file","filename":"/path/to/test-payload.qcow2", \
+> "node-name":"libvirt-2-storage"}' \
+> -blockdev '{"node-name":"libvirt-2-format","read-only":false, \
+> "driver":"qcow2","file":"libvirt-2-storage"}' \
+> -blockdev '{"node-name":"libvirt-3-format","driver":"luks", \
+> "file":"libvirt-2-format","header":"libvirt-1-format","key-secret": \
+> "libvirt-3-format-secret"}' \
+> -device '{"driver":"virtio-blk-pci","bus":XXX,"addr":YYY,"drive": \
+> "libvirt-3-format","id":"virtio-disk1"}'
+
+Add LUKS volume to a VM with a detached header
+----------------------------------------------
+
+1. object-add the secret for decrypting the cipher stored in
+   LUKS header above::
+
+# virsh qemu-monitor-command vm '{"execute":"object-add", \
+> "arguments":{"qom-type":"secret", "id": \
+> "libvirt-4-format-secret", "data":"abc123"}}'
+
+2. block-add the protocol node for LUKS header::
+
+# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+> "arguments":{"node-name":"libvirt-1-storage", "driver":"file", \
+> "filename": "/path/to/test-header.img" }}'
+
+3. block-add the raw-drived node for LUKS header::
+
+# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+> "arguments":{"node-name":"libvirt-1-format", "driver":"raw", \
+> "file":"libvirt-1-storage"}}'
+
+4. block-add the protocol node for disk payload image::
+
+# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+> "arguments":{"node-name":"libvirt-2-storage", "driver":"file", \
+> "filename":"/path/to/test-payload.qcow2"}}'
+
+5. block-add the qcow2-drived format node for disk payload data::
+
+# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+> "arguments":{"node-name":"libvirt-2-format", "driver":"qcow2", \
+> "file":"libvirt-2-storage"}}'
+
+6. block-add the luks-drived format node to link the qcow2 disk
+   with the LUKS header by specifying the field "header"::
+
+# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
+> "arguments":{"node-name":"libvirt-3-format", "driver":"luks", \
+> "file":"libvirt-2-format", "header":"libvirt-1-format", \
+> "key-secret":"libvirt-2-format-secret"}}'
+
+7. hot-plug the virtio-blk device finally::
+
+# virsh qemu-monitor-command vm '{"execute":"device_add", \
+> "arguments": {"driver":"virtio-blk-pci", \
+> "drive": "libvirt-3-format", "id":"virtio-disk2"}}
+
+TODO
+====
+
+1. Support the shared detached LUKS header within the VM.
-- 
2.39.3


