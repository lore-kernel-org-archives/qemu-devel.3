Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22D6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZBb-0003pP-1s; Thu, 01 Aug 2024 13:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBN-0003CM-Tm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBK-0003Ph-57
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52f01ec08d6so10551658e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531696; x=1723136496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=200sI/ksV69418bbokbAS37E1QrYoI3FUqDO8+9DHDg=;
 b=UW0lOfLErCUHp2HG1HczSAF5aNmcpa+Z7gNjNsPkRpkAvuQSx2X0tkkElWHiIZRItm
 9p/uD1TCBGNvz89/bg5LYqtxpIzYYEkd1g+OQA0aNhWtNCQWnKBMKoizjsJ9p7ANV0dE
 12Ap6wsmV9+1Og0fJ8qze5wsAf0+/ZdpEEywGrjGXvOtcgAZjn/EMmIDwaJUTYw1iLMs
 HyKbsimzjH8Q0esgyFWDtwEm5LVRtqkHdU+UDeDW2cy/wGY/ZWR6O6brDHSeWyvnkqbF
 vFFcNlSfI1gbiCsX35CG5qwqkfN4Ej8JiVKg5Cr7FZbKVdmF4OJEoLqN8L8wit5+gSz/
 99Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531696; x=1723136496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=200sI/ksV69418bbokbAS37E1QrYoI3FUqDO8+9DHDg=;
 b=QO8BGvQ5waJHf8OO+3xtmr78xoGVsbhCS+dUDBzlVLKe2JgrgIXuazvitgtAYOl6R1
 X9OdhzeORrZwtmVs0M+LNSlENdG+1SegR9fyXB6zS8lLms/gRqLVaH/jiqTFoRN36MFp
 3E5X2VJZ9gJytD/wnlB4XFa32W9cqanNJ6wX/MblXmPiXdsV1UYJOKo8YC0VMyHsYd4v
 usk3J6A+WZRetjVXfWMsmVtj3Yt7qOALD8mHBuyBD5zPKNJajGu+9zYSwHn4lhyrXyQi
 DZyNwbdTISpDm7JiYdlcKywXh5gdLynOwq8v5UmbBIHJXiLIcvilqkm/1ap/DhcBNWUR
 +wfA==
X-Gm-Message-State: AOJu0YyHIqEBdNmLUGBYpGH7aydhl5TMTBkm1kdEef8JIo84VS8u5w0m
 lOx4NDPP/8TaZkg6TMvKq7C2Xkl6jsJXu0eHmzbUm/zmD5n8sQs4xZP5zIwlQQOizgrSRqIa1P5
 W
X-Google-Smtp-Source: AGHT+IGUa+fGDN9j7PB7ToX3tOi3lFi7jnSn8Omrii9/pYvb4yDy2n6KSTwyMDxcukSXPXpaYBPGvg==
X-Received: by 2002:a2e:9606:0:b0:2ef:23ec:9357 with SMTP id
 38308e7fff4ca-2f15a9f988emr7003931fa.0.1722531695232; 
 Thu, 01 Aug 2024 10:01:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e24c2b4csm30385255e9.31.2024.08.01.10.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:01:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 4/5] docs/interop/prl-xml.txt: Convert to rST
Date: Thu,  1 Aug 2024 18:01:30 +0100
Message-Id: <20240801170131.3977807-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801170131.3977807-1-peter.maydell@linaro.org>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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
---
 MAINTAINERS              |   1 +
 docs/interop/index.rst   |   1 +
 docs/interop/prl-xml.rst | 187 +++++++++++++++++++++++++++++++++++++++
 docs/interop/prl-xml.txt | 158 ---------------------------------
 4 files changed, 189 insertions(+), 158 deletions(-)
 create mode 100644 docs/interop/prl-xml.rst
 delete mode 100644 docs/interop/prl-xml.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 37cfe16fd09..5758509edb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3963,6 +3963,7 @@ S: Supported
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


