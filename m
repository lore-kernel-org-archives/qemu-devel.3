Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZBW-0003Gn-Kv; Thu, 01 Aug 2024 13:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBN-0003BD-AA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBK-0003Pn-4j
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:40 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eecd2c6432so108098981fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531696; x=1723136496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoSj51SSjJB699rYhuOBDdXU19xw1YqlbG/SF8NNBFo=;
 b=iAz19D1D9LcmPgldYYYM3cy+0rWItY8Vcg57XhWdvdBcYaGbeHGUQLRx6FhhEcdvrm
 V8fkK5WE+SeOra9u38Vd5Kw/u80jU15VI5SreZfP9WzpB8tR/BiEi7ApfOv59ptLi9jR
 v6cQ1vIkQAmRXSi1eiMvBT5Is9GN6FNMgMpZW4nKXYWKlUP8I/bld9OZSOmblvRZtpnF
 qMyAQJ5JK4I2gFDwR8dum8Cg9et5yGPTKl0vnadIpeUIJw+S3l4LJ7tA6090VWEbWvoA
 zbVDyZIzH/Gm29Sy+c5t+FVIe3cUGCWOwOFbvq5Qo++JE1XtjTZTaV2RngcxhAoopWEI
 D2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531696; x=1723136496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoSj51SSjJB699rYhuOBDdXU19xw1YqlbG/SF8NNBFo=;
 b=rni7PThHh9YODFrDlLcorzySBO7m+02qpVy4rMUhHunVo2imYfUWgQj32Mgk4zfc6r
 lUVc6LiWFOyLva9fB3tIjxNprWwyJco4TK7W7rLjUcHgAtJpR83qKxNc+obBym1mhscI
 pLOTVWuAinRPPabzkuGzfO8biM/+vI9HyiCBrcLRahUEGPqDbZyB5cLW2PdQCXnkT1CG
 fpcPigpf7cy9QDFV9t513V4Vx0pzA0/2uxIMjP+JtnEaCJg3tGXncje1R0Wyi1RGjNIH
 ZEv/PE9i4PEi5W7LcrjkcAGRBWFARRI//Eran9NUR876ppdQs3olePIYyqFtJAvfYhqw
 AZLA==
X-Gm-Message-State: AOJu0YwzIq2ux6Mv68wJaYF4noRfcqlK7HWpgYsIbrO98VX1aUS30pXq
 hJeU8uL+hOyViFR3f8wsmXXS2GS/2yHKz1wvjnOnGdm7yc68+b3JSlrKreavA80a2m5RktSH/b7
 u
X-Google-Smtp-Source: AGHT+IHxuVOv7FH3kHh7J0+FmEX7qsnMOjSzGhwmS4Ieke5dupfH7/Aetjvs1loJpTCM38+CcliPaw==
X-Received: by 2002:a2e:a302:0:b0:2ef:18ae:5cbd with SMTP id
 38308e7fff4ca-2f15aac498amr8603941fa.27.1722531695880; 
 Thu, 01 Aug 2024 10:01:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e24c2b4csm30385255e9.31.2024.08.01.10.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:01:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 5/5] docs/interop/prl-xml.rst: Fix minor grammar nits
Date: Thu,  1 Aug 2024 18:01:31 +0100
Message-Id: <20240801170131.3977807-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801170131.3977807-1-peter.maydell@linaro.org>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

Fix some minor grammar nits in the prl-xml documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/interop/prl-xml.rst | 73 +++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/docs/interop/prl-xml.rst b/docs/interop/prl-xml.rst
index aacf11f4c44..5bb63bb93a4 100644
--- a/docs/interop/prl-xml.rst
+++ b/docs/interop/prl-xml.rst
@@ -13,15 +13,15 @@ Parallels Disk Format
    See the COPYING file in the top-level directory.
 
 This specification contains minimal information about Parallels Disk Format,
-which is enough to proper work with QEMU. Nevertheless, Parallels Cloud Server
-and Parallels Desktop are able to add some unspecified nodes to xml and use
+which is enough to properly work with QEMU. Nevertheless, Parallels Cloud Server
+and Parallels Desktop are able to add some unspecified nodes to the xml and use
 them, but they are for internal work and don't affect functionality. Also it
-uses auxiliary xml ``Snapshot.xml``, which allows to store optional snapshot
-information, but it doesn't influence open/read/write functionality. QEMU and
-other software should not use fields not covered in this document and
-``Snapshot.xml`` file and must leave them as is.
+uses auxiliary xml ``Snapshot.xml``, which allows storage of optional snapshot
+information, but this doesn't influence open/read/write functionality. QEMU and
+other software should not use fields not covered in this document or the
+``Snapshot.xml`` file, and must leave them as is.
 
-Parallels disk consists of two parts: the set of snapshots and the disk
+A Parallels disk consists of two parts: the set of snapshots and the disk
 descriptor file, which stores information about all files and snapshots.
 
 Definitions
@@ -29,7 +29,7 @@ Definitions
 
 Snapshot
   a record of the contents captured at a particular time, capable
-  of storing current state. A snapshot has UUID and parent UUID.
+  of storing current state. A snapshot has a UUID and a parent UUID.
 
 Snapshot image
   an overlay representing the difference between this
@@ -39,13 +39,13 @@ Overlay
   an image storing the different sectors between two captured states.
 
 Root image
-  snapshot image with no parent, the root of snapshot tree.
+  a snapshot image with no parent, the root of the snapshot tree.
 
 Storage
   the backing storage for a subset of the virtual disk. When
   there is more than one storage in a Parallels disk then that
   is referred to as a split image. In this case every storage
-  covers specific address space area of the disk and has its
+  covers a specific address space area of the disk and has its
   particular root image. Split images are not considered here
   and are not supported. Each storage consists of disk
   parameters and a list of images. The list of images always
@@ -55,7 +55,7 @@ Storage
 
 Description file
   ``DiskDescriptor.xml`` stores information about disk parameters,
-  snapshots, storages.
+  snapshots, and storages.
 
 Top Snapshot
   The overlay between actual state and some previous snapshot.
@@ -70,9 +70,9 @@ Description file
 
 All information is placed in a single XML element
 ``Parallels_disk_image``.
-The element has only one attribute ``Version``, that must be ``1.0``.
+The element has only one attribute, ``Version``, which must be ``1.0``.
 
-Schema of ``DiskDescriptor.xml``::
+The schema of ``DiskDescriptor.xml``::
 
  <Parallels_disk_image Version="1.0">
     <Disk_Parameters>
@@ -100,11 +100,11 @@ The ``Disk_Parameters`` element MUST contain the following child elements:
 * ``Heads``     - number of the disk heads.
 * ``Sectors``   - number of the disk sectors per cylinder
   (sector size is 512 bytes)
-  Limitation: Product of the ``Heads``, ``Sectors`` and ``Cylinders``
+  Limitation: The product of the ``Heads``, ``Sectors`` and ``Cylinders``
   values MUST be equal to the value of the Disk_size parameter.
 * ``Padding``   - must be 0. Parallels Cloud Server and Parallels Desktop may
-  use padding set to 1, however this case is not covered
-  by this spec, QEMU and other software should not open
+  use padding set to 1; however this case is not covered
+  by this specification. QEMU and other software should not open
   such disks and should not create them.
 
 ``StorageData`` element
@@ -121,20 +121,20 @@ as shown below::
     </Storage>
  </StorageData>
 
-A ``Storage`` element has following child elements:
+A ``Storage`` element has the following child elements:
 
 * ``Start``     - start sector of the storage, in case of non split storage
   equals to 0.
 * ``End``       - number of sector following the last sector, in case of non
   split storage equals to ``Disk_size``.
 * ``Blocksize`` - storage cluster size, number of sectors per one cluster.
-  Cluster size for each "Compressed" (see below) image in
-  parallels disk must be equal to this field. Note: cluster
-  size for Parallels Expandable Image is in ``tracks`` field of
+  The cluster size for each "Compressed" (see below) image in
+  a parallels disk must be equal to this field. Note: the cluster
+  size for a Parallels Expandable Image is in the ``tracks`` field of
   its header (see :doc:`parallels`).
 * Several ``Image`` child elements.
 
-Each ``Image`` element has following child elements:
+Each ``Image`` element has the following child elements:
 
 * ``GUID`` - image identifier, UUID in curly brackets.
   For instance, ``{12345678-9abc-def1-2345-6789abcdef12}.``
@@ -145,7 +145,7 @@ Each ``Image`` element has following child elements:
   * ``Plain`` for raw files.
   * ``Compressed`` for expanding disks.
 
-* ``File`` - path to image file. Path can be relative to
+* ``File`` - path to image file. The path can be relative to
   ``DiskDescriptor.xml`` or absolute.
 
 ``Snapshots`` element
@@ -171,17 +171,22 @@ Each ``Shot`` element contains the following child elements:
 * ``GUID``       - an image GUID.
 * ``ParentGUID`` - GUID of the image of the parent snapshot.
 
-The software may traverse snapshots from child to parent using ``<ParentGUID>``
-field as reference. ``ParentGUID`` of root snapshot is
-``{00000000-0000-0000-0000-000000000000}``. There should be only one root
-snapshot. Top snapshot could be described via two ways: via ``TopGUID`` child
-element of the ``Snapshots`` element or via predefined GUID
+The software may traverse snapshots from child to parent using the
+``<ParentGUID>`` field as reference. The ``ParentGUID`` of the root
+snapshot is ``{00000000-0000-0000-0000-000000000000}``.
+There should be only one root snapshot.
+
+The Top snapshot could be
+described via two ways: via the ``TopGUID`` child
+element of the ``Snapshots`` element, or via the predefined GUID
 ``{5fbaabe3-6958-40ff-92a7-860e329aab41}``. If ``TopGUID`` is defined,
-predefined GUID is interpreted as usual GUID. All snapshot images
-(except Top Snapshot) should be
-opened read-only. There is another predefined GUID,
+the predefined GUID is interpreted as a normal GUID. All snapshot images
+(except the Top Snapshot) should be
+opened read-only.
+
+There is another predefined GUID,
 ``BackupID = {704718e1-2314-44c8-9087-d78ed36b0f4e}``, which is used by
-original and some third-party software for backup, QEMU and other
-software may operate with images with ``GUID = BackupID`` as usual,
-however, it is not recommended to use this
-GUID for new disks. Top snapshot cannot have this GUID.
+original and some third-party software for backup. QEMU and other
+software may operate with images with ``GUID = BackupID`` as usual.
+However, it is not recommended to use this
+GUID for new disks. The Top snapshot cannot have this GUID.
-- 
2.34.1


