Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86496C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2y-000266-SS; Fri, 09 Aug 2024 14:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2x-00020F-AQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2v-0007E0-6O
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so17076715e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226939; x=1723831739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B0ZX+BKezJrv3F6YmQherbds9uPIif5DbFUZSAqPArs=;
 b=KjEF6SV6VTOLFKAxj+2VVrqE7wIBfCap8uSDi2xEvGLH4rxzcmczbWkEVwskRGUMwN
 wl86FJCEKkbNYyVePpGIyoohV3ob6U1MdBPdCshLcCsW8NKlEY0nkKzeKvGF12kwBIUY
 Oem0uX2nUXDz2Hw7OcFrryeIftHe465Xxh6Tais0vB8yJx1tOpfudiSI23A2SSnzPYz5
 60VjtST4gy7W+jvBwYRQJNfTXJWnb03Hop2WsEeP0gUFRWItEr85LN+HdqzxKb1qlQ1J
 NA+3IuF8UDnwBdOT0G56V/upOnKcQnGCR9MLb7rZq2o72F+D+mi3Bi/Ja7rP85AqOp9C
 37ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226939; x=1723831739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0ZX+BKezJrv3F6YmQherbds9uPIif5DbFUZSAqPArs=;
 b=rBpFVgZP4Jfbdh/Ewox41KCAnOkfgBUdp5Av1uWf0zUckXM9FF1+jtkYVS2/EIQ1eq
 RNPre7wdk4fyPU43aPRSaS6hmP5a3KtsO9QFpGR5E2gaVwIO1ecSwTKsu+YvJriUQxKM
 tW9AKRXp/pNP0TAdcOlN75J6FF23gTvl7C5O8t5QdM4W1v2fqDotNdCfkOI4IV18d/qH
 9pbJhVjmsga2IJNHp54o0H06OYpHWMLbitNY1ue+6m/ZCOefzUo857085XWYrUAQzyOT
 A/x2QioWFgZgHDl/w+/Ow52KPASRqJylVSE2DhlIMK0t6sral/QWmQb83ssVJHWO3i1x
 hehg==
X-Gm-Message-State: AOJu0Yx4ypARc0p8ND1U9lU2tT+63TOr67/n39pD2a5W0KqZrguyi0sd
 9JYIgHqITCxf1JlTgXFuXMVPg2Mycij+YLG/Bn+Qbb7m8pNnTV5XBIR+Nec5TXqjcrXq8tumrOD
 3
X-Google-Smtp-Source: AGHT+IHzMTOf/KpTaNbuSLC8n2ArlEblMGSsACLvCZT744EqR9HdtMfGryEzFAuqOSuZ29pwEYoRcA==
X-Received: by 2002:a05:600c:4f92:b0:428:36e:be59 with SMTP id
 5b1f17b1804b1-429c3a23bc6mr16552335e9.11.1723226939438; 
 Fri, 09 Aug 2024 11:08:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] docs/interop/prl-xml.rst: Fix minor grammar nits
Date: Fri,  9 Aug 2024 19:08:31 +0100
Message-Id: <20240809180835.1243269-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20240801170131.3977807-6-peter.maydell@linaro.org
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


