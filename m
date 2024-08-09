Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04450C52D7F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2w-0001yr-SI; Fri, 09 Aug 2024 14:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2u-0001xk-OZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2s-0007Dl-5N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so1413301f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226937; x=1723831737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eVnCY3qbuf5yLSqsOtwFDfk5cUSu4Pud+DjVgvKddbU=;
 b=FmvDQkMtUFDbWqraL1xnvsbM5wxsXBJrCYeiMBFIc+asJ6vJahAL7nim3/4eHnhPnz
 n//cl1XXrIN5pUtnKhgs26e3+Q8lO9QLWqK4KLNliOia0qXowsb9wTVyL1i92+T+rOCR
 dlvlZcZPiH5ce6yVqIelh2Q030uxHLl/I3l2L9vrMhj6dkjRYiWgqgum/sPndEZp350B
 IjkRlXGKSbPNzEPmhGyqtQe5fgLcF4JsNUNtPyHsU5AIB6FHa3mlQVTtNF6cp+Qy1Tlu
 SfpNwLpuPGK9fCEYci1KtzOOsdzoa6/yYNuk5gd9c3EaYY1KCl4iSrPukmR4gGXFOhAH
 0l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226937; x=1723831737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVnCY3qbuf5yLSqsOtwFDfk5cUSu4Pud+DjVgvKddbU=;
 b=D2y6U2YGd4BPsCfjGp93YJX6eEyLOQGyySrs2z3lQQAdJaqSCc7oPNm5Jixb14HwyS
 K5pBCbqA6xSOY0Mq0QWdFTUnTXABFSDFuRCRLpOQmNXLwwqNsiG4n/f+e03lv1wc+d3j
 zi3qCuWp5c7GRk9g178Anp0/6TS8PmOKUahKHUx6yCmh1ZbWxFV3gso89M+b9mBGDVSm
 Le2IXmXTciwSEdq1vMhFA9zJiIAfKCPUZ7vSmj4k9sS8gkdGJp3Twd0mRQrcsmveBfWu
 JYLuz6/gOstsBOz3ouJRdr/503mo8OmfK/b96nY7JSXNqlM6A6yfRjWfE7XMGxaNfvO/
 n1vQ==
X-Gm-Message-State: AOJu0Yz1tVSFFNSazhkuFMz4xjaWNfA9KtadKN3s0XsNqEeGLUbR1RqA
 RoxylsVG1Gc69jEBTdOyEalXRMftme5+hR3ZcEmb1xAkuUq/QFwK7owdsoI96vWlirdui0ImAEr
 L
X-Google-Smtp-Source: AGHT+IHY9uBYR75FJdTa6r3S2Wa2eM5Pw7kV713Ce5j5Lf5iZvQcAipmX8W8chTs7twW7pQ9v7m5Yw==
X-Received: by 2002:adf:ed52:0:b0:367:8e53:7fd7 with SMTP id
 ffacd0b85a97d-36d5fe78063mr1642524f8f.28.1723226936414; 
 Fri, 09 Aug 2024 11:08:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] docs/interop/prl-xml.txt: Convert to rST
Date: Fri,  9 Aug 2024 19:08:30 +0100
Message-Id: <20240809180835.1243269-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert prl-xml.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20240801170131.3977807-5-peter.maydell@linaro.org
---
 MAINTAINERS              |   1 +
 docs/interop/index.rst   |   1 +
 docs/interop/prl-xml.rst | 187 +++++++++++++++++++++++++++++++++++++++
 docs/interop/prl-xml.txt | 158 ---------------------------------
 4 files changed, 189 insertions(+), 158 deletions(-)
 create mode 100644 docs/interop/prl-xml.rst
 delete mode 100644 docs/interop/prl-xml.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index ae8bed8c757..3584d6a6c6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3965,6 +3965,7 @@ S: Supported
 F: block/parallels.c
 F: block/parallels-ext.c
 F: docs/interop/parallels.rst
+F: docs/interop/prl-xml.rst
 T: git https://src.openvz.org/scm/~den/qemu.git parallels
 
 qed
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 70bba62d907..999e44eae19 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -16,6 +16,7 @@ are useful for making QEMU interoperate with other software.
    live-block-operations
    nbd
    parallels
+   prl-xml
    pr-helper
    qmp-spec
    qemu-ga
diff --git a/docs/interop/prl-xml.rst b/docs/interop/prl-xml.rst
new file mode 100644
index 00000000000..aacf11f4c44
--- /dev/null
+++ b/docs/interop/prl-xml.rst
@@ -0,0 +1,187 @@
+Parallels Disk Format
+=====================
+
+..
+   Copyright (c) 2015-2017, Virtuozzo, Inc.
+   Authors:
+        2015 Denis Lunev <den@openvz.org>
+        2015 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+        2016-2017 Klim Kireev <klim.kireev@virtuozzo.com>
+        2016-2017 Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
+
+   This work is licensed under the terms of the GNU GPL, version 2 or later.
+   See the COPYING file in the top-level directory.
+
+This specification contains minimal information about Parallels Disk Format,
+which is enough to proper work with QEMU. Nevertheless, Parallels Cloud Server
+and Parallels Desktop are able to add some unspecified nodes to xml and use
+them, but they are for internal work and don't affect functionality. Also it
+uses auxiliary xml ``Snapshot.xml``, which allows to store optional snapshot
+information, but it doesn't influence open/read/write functionality. QEMU and
+other software should not use fields not covered in this document and
+``Snapshot.xml`` file and must leave them as is.
+
+Parallels disk consists of two parts: the set of snapshots and the disk
+descriptor file, which stores information about all files and snapshots.
+
+Definitions
+-----------
+
+Snapshot
+  a record of the contents captured at a particular time, capable
+  of storing current state. A snapshot has UUID and parent UUID.
+
+Snapshot image
+  an overlay representing the difference between this
+  snapshot and some earlier snapshot.
+
+Overlay
+  an image storing the different sectors between two captured states.
+
+Root image
+  snapshot image with no parent, the root of snapshot tree.
+
+Storage
+  the backing storage for a subset of the virtual disk. When
+  there is more than one storage in a Parallels disk then that
+  is referred to as a split image. In this case every storage
+  covers specific address space area of the disk and has its
+  particular root image. Split images are not considered here
+  and are not supported. Each storage consists of disk
+  parameters and a list of images. The list of images always
+  contains a root image and may also contain overlays. The
+  root image can be an expandable Parallels image file or
+  plain. Overlays must be expandable.
+
+Description file
+  ``DiskDescriptor.xml`` stores information about disk parameters,
+  snapshots, storages.
+
+Top Snapshot
+  The overlay between actual state and some previous snapshot.
+  It is not a snapshot in the classical sense because it
+  serves as the active image that the guest writes to.
+
+Sector
+  a 512-byte data chunk.
+
+Description file
+----------------
+
+All information is placed in a single XML element
+``Parallels_disk_image``.
+The element has only one attribute ``Version``, that must be ``1.0``.
+
+Schema of ``DiskDescriptor.xml``::
+
+ <Parallels_disk_image Version="1.0">
+    <Disk_Parameters>
+        ...
+    </Disk_Parameters>
+    <StorageData>
+        ...
+    </StorageData>
+    <Snapshots>
+        ...
+    </Snapshots>
+ </Parallels_disk_image>
+
+``Disk_Parameters`` element
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``Disk_Parameters`` element describes the physical layout of the
+virtual disk and some general settings.
+
+The ``Disk_Parameters`` element MUST contain the following child elements:
+
+* ``Disk_size`` - number of sectors in the disk,
+  desired size of the disk.
+* ``Cylinders`` - number of the disk cylinders.
+* ``Heads``     - number of the disk heads.
+* ``Sectors``   - number of the disk sectors per cylinder
+  (sector size is 512 bytes)
+  Limitation: Product of the ``Heads``, ``Sectors`` and ``Cylinders``
+  values MUST be equal to the value of the Disk_size parameter.
+* ``Padding``   - must be 0. Parallels Cloud Server and Parallels Desktop may
+  use padding set to 1, however this case is not covered
+  by this spec, QEMU and other software should not open
+  such disks and should not create them.
+
+``StorageData`` element
+^^^^^^^^^^^^^^^^^^^^^^^
+
+This element of the file describes the root image and all snapshot images.
+
+The ``StorageData`` element consists of the ``Storage`` child element,
+as shown below::
+
+ <StorageData>
+    <Storage>
+        ...
+    </Storage>
+ </StorageData>
+
+A ``Storage`` element has following child elements:
+
+* ``Start``     - start sector of the storage, in case of non split storage
+  equals to 0.
+* ``End``       - number of sector following the last sector, in case of non
+  split storage equals to ``Disk_size``.
+* ``Blocksize`` - storage cluster size, number of sectors per one cluster.
+  Cluster size for each "Compressed" (see below) image in
+  parallels disk must be equal to this field. Note: cluster
+  size for Parallels Expandable Image is in ``tracks`` field of
+  its header (see :doc:`parallels`).
+* Several ``Image`` child elements.
+
+Each ``Image`` element has following child elements:
+
+* ``GUID`` - image identifier, UUID in curly brackets.
+  For instance, ``{12345678-9abc-def1-2345-6789abcdef12}.``
+  The GUID is used by the Snapshots element to reference images
+  (see below)
+* ``Type`` - image type of the element. It can be:
+
+  * ``Plain`` for raw files.
+  * ``Compressed`` for expanding disks.
+
+* ``File`` - path to image file. Path can be relative to
+  ``DiskDescriptor.xml`` or absolute.
+
+``Snapshots`` element
+^^^^^^^^^^^^^^^^^^^^^
+
+The ``Snapshots`` element describes the snapshot relations with the snapshot tree.
+
+The element contains the set of ``Shot`` child elements, as shown below::
+
+ <Snapshots>
+    <TopGUID> ... </TopGUID> /* Optional child element */
+    <Shot>
+        ...
+    </Shot>
+    <Shot>
+        ...
+    </Shot>
+    ...
+ </Snapshots>
+
+Each ``Shot`` element contains the following child elements:
+
+* ``GUID``       - an image GUID.
+* ``ParentGUID`` - GUID of the image of the parent snapshot.
+
+The software may traverse snapshots from child to parent using ``<ParentGUID>``
+field as reference. ``ParentGUID`` of root snapshot is
+``{00000000-0000-0000-0000-000000000000}``. There should be only one root
+snapshot. Top snapshot could be described via two ways: via ``TopGUID`` child
+element of the ``Snapshots`` element or via predefined GUID
+``{5fbaabe3-6958-40ff-92a7-860e329aab41}``. If ``TopGUID`` is defined,
+predefined GUID is interpreted as usual GUID. All snapshot images
+(except Top Snapshot) should be
+opened read-only. There is another predefined GUID,
+``BackupID = {704718e1-2314-44c8-9087-d78ed36b0f4e}``, which is used by
+original and some third-party software for backup, QEMU and other
+software may operate with images with ``GUID = BackupID`` as usual,
+however, it is not recommended to use this
+GUID for new disks. Top snapshot cannot have this GUID.
diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
deleted file mode 100644
index cf9b3fba265..00000000000
--- a/docs/interop/prl-xml.txt
+++ /dev/null
@@ -1,158 +0,0 @@
-= License =
-
-Copyright (c) 2015-2017, Virtuozzo, Inc.
-Authors:
-        2015 Denis Lunev <den@openvz.org>
-        2015 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
-        2016-2017 Klim Kireev <klim.kireev@virtuozzo.com>
-        2016-2017 Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
-This specification contains minimal information about Parallels Disk Format,
-which is enough to proper work with QEMU. Nevertheless, Parallels Cloud Server
-and Parallels Desktop are able to add some unspecified nodes to xml and use
-them, but they are for internal work and don't affect functionality. Also it
-uses auxiliary xml "Snapshot.xml", which allows to store optional snapshot
-information, but it doesn't influence open/read/write functionality. QEMU and
-other software should not use fields not covered in this document and
-Snapshot.xml file and must leave them as is.
-
-= Parallels Disk Format =
-
-Parallels disk consists of two parts: the set of snapshots and the disk
-descriptor file, which stores information about all files and snapshots.
-
-== Definitions ==
-    Snapshot       a record of the contents captured at a particular time,
-                   capable of storing current state. A snapshot has UUID and
-                   parent UUID.
-
- Snapshot image    an overlay representing the difference between this
-                   snapshot and some earlier snapshot.
-
-    Overlay        an image storing the different sectors between two captured
-                   states.
-
-   Root image      snapshot image with no parent, the root of snapshot tree.
-
-    Storage        the backing storage for a subset of the virtual disk. When
-                   there is more than one storage in a Parallels disk then that
-                   is referred to as a split image. In this case every storage
-                   covers specific address space area of the disk and has its
-                   particular root image. Split images are not considered here
-                   and are not supported. Each storage consists of disk
-                   parameters and a list of images. The list of images always
-                   contains a root image and may also contain overlays. The
-                   root image can be an expandable Parallels image file or
-                   plain. Overlays must be expandable.
-
-  Description      DiskDescriptor.xml stores information about disk parameters,
-     file          snapshots, storages.
-
-     Top           The overlay between actual state and some previous snapshot.
-   Snapshot        It is not a snapshot in the classical sense because it
-                   serves as the active image that the guest writes to.
-
-    Sector         a 512-byte data chunk.
-
-== Description file ==
-All information is placed in a single XML element Parallels_disk_image.
-The element has only one attribute "Version", that must be 1.0.
-Schema of DiskDescriptor.xml:
-
-<Parallels_disk_image Version="1.0">
-    <Disk_Parameters>
-        ...
-    </Disk_Parameters>
-    <StorageData>
-        ...
-    </StorageData>
-    <Snapshots>
-        ...
-    </Snapshots>
-</Parallels_disk_image>
-
-== Disk_Parameters element ==
-The Disk_Parameters element describes the physical layout of the virtual disk
-and some general settings.
-
-The Disk_Parameters element MUST contain the following child elements:
-    * Disk_size - number of sectors in the disk,
-                  desired size of the disk.
-    * Cylinders - number of the disk cylinders.
-    * Heads     - number of the disk heads.
-    * Sectors   - number of the disk sectors per cylinder
-                  (sector size is 512 bytes)
-                  Limitation: Product of the Heads, Sectors and Cylinders
-                  values MUST be equal to the value of the Disk_size parameter.
-    * Padding   - must be 0. Parallels Cloud Server and Parallels Desktop may
-                  use padding set to 1, however this case is not covered
-                  by this spec, QEMU and other software should not open
-                  such disks and should not create them.
-
-== StorageData element ==
-This element of the file describes the root image and all snapshot images.
-
-The StorageData element consists of the Storage child element, as shown below:
-<StorageData>
-    <Storage>
-        ...
-    </Storage>
-</StorageData>
-
-A Storage element has following child elements:
-    * Start     - start sector of the storage, in case of non split storage
-                  equals to 0.
-    * End       - number of sector following the last sector, in case of non
-                  split storage equals to Disk_size.
-    * Blocksize - storage cluster size, number of sectors per one cluster.
-                  Cluster size for each "Compressed" (see below) image in
-                  parallels disk must be equal to this field. Note: cluster
-                  size for Parallels Expandable Image is in 'tracks' field of
-                  its header (see docs/interop/parallels.txt).
-    * Several Image child elements.
-
-Each Image element has following child elements:
-    * GUID - image identifier, UUID in curly brackets.
-             For instance, {12345678-9abc-def1-2345-6789abcdef12}.
-             The GUID is used by the Snapshots element to reference images
-             (see below)
-    * Type - image type of the element. It can be:
-             "Plain" for raw files.
-             "Compressed" for expanding disks.
-    * File - path to image file. Path can be relative to DiskDescriptor.xml or
-             absolute.
-
-== Snapshots element ==
-The Snapshots element describes the snapshot relations with the snapshot tree.
-
-The element contains the set of Shot child elements, as shown below:
-<Snapshots>
-    <TopGUID> ... </TopGUID> /* Optional child element */
-    <Shot>
-        ...
-    </Shot>
-    <Shot>
-        ...
-    </Shot>
-    ...
-</Snapshots>
-
-Each Shot element contains the following child elements:
-    * GUID       - an image GUID.
-    * ParentGUID - GUID of the image of the parent snapshot.
-
-The software may traverse snapshots from child to parent using <ParentGUID>
-field as reference. ParentGUID of root snapshot is
-{00000000-0000-0000-0000-000000000000}. There should be only one root
-snapshot. Top snapshot could be described via two ways: via TopGUID child
-element of the Snapshots element or via predefined GUID
-{5fbaabe3-6958-40ff-92a7-860e329aab41}. If TopGUID is defined, predefined GUID is
-interpreted as usual GUID. All snapshot images (except Top Snapshot) should be
-opened read-only. There is another predefined GUID,
-BackupID = {704718e1-2314-44c8-9087-d78ed36b0f4e}, which is used by original and
-some third-party software for backup, QEMU and other software may operate with
-images with GUID = BackupID as usual, however, it is not recommended to use this
-GUID for new disks. Top snapshot cannot have this GUID.
-- 
2.34.1


