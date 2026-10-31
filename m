Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3876606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y/evEnxA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN38E-0001iB-0S; Sat, 31 Oct 2026 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36S-0000sT-S5
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36Q-0003LU-92
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793430129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhBEslPlqsjAcYuTR9aZrMv5jQQbW5JpgDxoEn/I6Vk=;
 b=Y/evEnxAAqyvJGwJCR+MweCH9NyW4cdLEeHTzXsTG7hlgguhs7NeYcl5SqHwREY+I/F9uj
 CQK9SzZaRbN0bcXB5KkSKLgmoiNkiVozZyLAPVBx+HtJLK+Z9Ze4H/G/6FcowtxGmpckx1
 McP+DJEvsnwuAb651lFVo/p7QCy3ft0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-3o7h5qW3Nn6BOqQ_MN3MVQ-1; Sat,
 31 Oct 2026 03:02:00 -0400
X-MC-Unique: 3o7h5qW3Nn6BOqQ_MN3MVQ-1
X-Mimecast-MFC-AGG-ID: 3o7h5qW3Nn6BOqQ_MN3MVQ_1793430118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA26A1800361; Sat, 31 Oct 2026 07:01:58 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26B9C1800765; Sat, 31 Oct 2026 07:01:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Naman Gulati <namangulati@google.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/6] vfio-user: add multi-fd region mmap capability
Date: Sat, 31 Oct 2026 08:01:47 +0100
Message-ID: <20261031070152.197043-2-clg@redhat.com>
In-Reply-To: <20261031070152.197043-1-clg@redhat.com>
References: <20261031070152.197043-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Naman Gulati <namangulati@google.com>

Extend the vfio-user protocol specification to allow servers to pass
multiple file descriptors for different sparse memory areas within a
single device region with capability
VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS (0x8001), negotiated via the
"sparse_mmap_fds" capability in VFIO_USER_VERSION.

VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS defines an array of sparse mmap
areas where each area contains:
- offset: Start of the area within the device region (BAR).
- fd_offset: Start of the mapping within the backing file descriptor.
- size: Size of the mappable area.
- fd_index: Zero-based index into the array of file descriptors
  received in the SCM_RIGHTS ancillary data of the
  VFIO_USER_DEVICE_GET_REGION_INFO reply message.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
Link: https://lore.kernel.org/qemu-devel/20261023223902.1275539-2-namangulati@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/interop/vfio-user.rst | 86 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 1c92f442d232ce6ce880868bb7062e42481b69ae..b49781a7550a242a2dbb03fa5b777aa87eac84ba 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -125,7 +125,13 @@ Sparse Regions
 A region can be memory-mappable in whole or in part. When only a subset of a
 region can be mapped by the client, a ``VFIO_REGION_INFO_CAP_SPARSE_MMAP``
 capability is included in the region info reply. This capability describes
-which portions can be mapped by the client.
+which portions can be mapped by the client. When sparse mmap areas are backed
+by multiple distinct file descriptors, a
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` capability is included in the region
+info reply instead. ``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` and
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` cannot both be specified for the same
+region; however, different regions of a device may independently use either
+capability.
 
 .. Note::
    For example, in a virtual NVMe controller, sparse regions can be used so
@@ -536,6 +542,10 @@ Capabilities:
 | write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
 |                    |         | are supported if the value is ``true``.       |
 +--------------------+---------+-----------------------------------------------+
+| sparse_mmap_fds    | boolean | ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
+|                    |         | capability is supported if the value is       |
+|                    |         | ``true``.                                     |
++--------------------+---------+-----------------------------------------------+
 
 The ``twin_socket`` capability object holds these name/value pairs:
 
@@ -859,9 +869,11 @@ Reply
   * ``VFIO_REGION_INFO_FLAG_READ`` allows client read access to the region.
   * ``VFIO_REGION_INFO_FLAG_WRITE`` allows client write access to the region.
   * ``VFIO_REGION_INFO_FLAG_MMAP`` specifies the client can mmap() the region.
-    When this flag is set, the reply will include a file descriptor in its
-    meta-data. On ``AF_UNIX`` sockets, the file descriptors will be passed as
-    ``SCM_RIGHTS`` type ancillary data.
+    When this flag is set, the reply will include one or more file descriptors
+    in its meta-data (up to the number of sparse mmap areas when
+    ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` is present, or a single file
+    descriptor otherwise). On ``AF_UNIX`` sockets, the file descriptors will be
+    passed as ``SCM_RIGHTS`` type ancillary data.
   * ``VFIO_REGION_INFO_FLAG_CAPS`` indicates additional capabilities found in the
     reply.
 
@@ -950,6 +962,72 @@ The VFIO sparse mmap area is defined in ``<linux/vfio.h>`` (``struct
 vfio_region_info_cap_sparse_mmap``).
 
 
+VFIO sparse mmap fds cap header
+"""""""""""""""""""""""""""""""
+
++----------------------+--------------------------------------+
+| Name                 | Value                                |
++======================+======================================+
+| id                   | VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS |
++----------------------+--------------------------------------+
+| version              | 0x1                                  |
++----------------------+--------------------------------------+
+| next                 | <next>                               |
++----------------------+--------------------------------------+
+| sparse mmap fds info | VFIO region info sparse mmap fds     |
++----------------------+--------------------------------------+
+
+This capability is defined when a region supports direct access by the client
+via mmap() where different sparse mmap areas are backed by distinct file
+descriptors in the ``SCM_RIGHTS`` ancillary data array. The server may only
+include this capability if the client advertised ``sparse_mmap_fds`` as
+``true`` in ``VFIO_USER_VERSION``. Capability ID
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` is defined as ``0x8001`` to avoid
+clashing with kernel VFIO capabilities.
+
+VFIO region info cap sparse mmap fds
+""""""""""""""""""""""""""""""""""""
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| nr_areas  | 0      | 4    |
++-----------+--------+------+
+| reserved  | 4      | 4    |
++-----------+--------+------+
+| offset    | 8      | 8    |
++-----------+--------+------+
+| fd_offset | 16     | 8    |
++-----------+--------+------+
+| size      | 24     | 8    |
++-----------+--------+------+
+| fd_index  | 32     | 4    |
++-----------+--------+------+
+| pad       | 36     | 4    |
++-----------+--------+------+
+| ...       |        |      |
++-----------+--------+------+
+
+* *nr_areas* is the number of sparse mmap areas in the region.
+* *offset*, *fd_offset*, *size*, and *fd_index* describe a single area that can be
+  mapped by the client. There will be *nr_areas* tuples of offset, fd_offset, size,
+  fd_index, and pad. Sparse mmap areas must not overlap.
+* *offset* specifies the start of the area within the device region (BAR).
+* *fd_offset* specifies the start of the mapping within the backing file descriptor
+  referenced by *fd_index*.
+* *size* specifies the size of the area. Zero-sized areas (*size* equal to 0)
+  are not permitted, and *offset* + *size* must not exceed the region *size*.
+* *fd_index* is the zero-based index into the array of file descriptors
+  received in the ``SCM_RIGHTS`` ancillary data of the
+  ``VFIO_USER_DEVICE_GET_REGION_INFO`` reply message. The number of file
+  descriptors sent in ``SCM_RIGHTS`` must be at least 1 and must not exceed
+  *nr_areas*.
+
+If all sparse mmap areas are backed by a single file descriptor, the server
+may instead send ``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` and exactly one file
+descriptor in ``SCM_RIGHTS`` for compatibility with older clients.
+
+
 ``VFIO_USER_DEVICE_GET_REGION_IO_FDS``
 --------------------------------------
 
-- 
2.56.0


