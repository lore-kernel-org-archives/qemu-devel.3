Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FA7C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ86-0006ea-72; Tue, 30 Jun 2026 00:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ85-0006eE-5c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ83-0002yr-Gw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjbNF6RYtLwlGy7eCg9LgEfJgJ+JbZZyoXxcb8uVLPM=;
 b=OwWkRXhuQ2c50WragSifU4Z+mCeeRtItgODQbahNLn3ctoDJFIHeZb0ELNAWTv/X+onOwE
 txK1aYoLk8W9XojDxD5d5lUPHMIhftdoco6JkfvJGIuemAP7rZLyhnE1yrmSxMbFI3aaSB
 QJe8jzcWXPtcOkIGyk94AIAvVdoR2fI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-m4TiMU3QMU2EhEYG5KKMLg-1; Tue,
 30 Jun 2026 00:31:18 -0400
X-MC-Unique: m4TiMU3QMU2EhEYG5KKMLg-1
X-Mimecast-MFC-AGG-ID: m4TiMU3QMU2EhEYG5KKMLg_1782793877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C61B9195604A; Tue, 30 Jun 2026 04:31:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37DE61956045; Tue, 30 Jun 2026 04:31:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mattias Nissler <mnissler@meta.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/23] docs: Update vfio-user spec to describe DMA access mode
 bits
Date: Tue, 30 Jun 2026 06:30:47 +0200
Message-ID: <20260630043107.1511076-4-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_PH_SUBJ_META1=0.001 autolearn=no autolearn_force=no
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

From: Mattias Nissler <mnissler@meta.com>

This makes the intended access mode explicit when registering DMA
regions with the server. A new "file I/O" access mode is defined, which
can be used if the file descriptor provided by the client doesn't
support `mmap()`.

Signed-off-by: Mattias Nissler <mnissler@meta.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260602133829.305842-1-mnissler@meta.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/interop/vfio-user.rst | 82 ++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 12deb25102af217f7f292b4cb655dc4a6a92439a..1c92f442d232ce6ce880868bb7062e42481b69ae 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -604,27 +604,31 @@ Request
 
 The request payload for this message is a structure of the following format:
 
-+-------------+--------+-------------+
-| Name        | Offset | Size        |
-+=============+========+=============+
-| argsz       | 0      | 4           |
-+-------------+--------+-------------+
-| flags       | 4      | 4           |
-+-------------+--------+-------------+
-|             | +-----+------------+ |
-|             | | Bit | Definition | |
-|             | +=====+============+ |
-|             | | 0   | readable   | |
-|             | +-----+------------+ |
-|             | | 1   | writeable  | |
-|             | +-----+------------+ |
-+-------------+--------+-------------+
-| offset      | 8      | 8           |
-+-------------+--------+-------------+
-| address     | 16     | 8           |
-+-------------+--------+-------------+
-| size        | 24     | 8           |
-+-------------+--------+-------------+
++-------------+--------+------------------------+
+| Name        | Offset | Size                   |
++=============+========+========================+
+| argsz       | 0      | 4                      |
++-------------+--------+------------------------+
+| flags       | 4      | 4                      |
++-------------+--------+------------------------+
+|             | +-----+-----------------------+ |
+|             | | Bit | Definition            | |
+|             | +=====+=======================+ |
+|             | | 0   | readable              | |
+|             | +-----+-----------------------+ |
+|             | | 1   | writeable             | |
+|             | +-----+-----------------------+ |
+|             | | 2   | access mode: mmap     | |
+|             | +-----+-----------------------+ |
+|             | | 3   | access mode: file I/O | |
+|             | +-----+-----------------------+ |
++-------------+--------+------------------------+
+| offset      | 8      | 8                      |
++-------------+--------+------------------------+
+| address     | 16     | 8                      |
++-------------+--------+------------------------+
+| size        | 24     | 8                      |
++-------------+--------+------------------------+
 
 * *argsz* is the size of the above structure. Note there is no reply payload,
   so this field differs from other message types.
@@ -634,6 +638,8 @@ The request payload for this message is a structure of the following format:
 
   * *writeable* indicates that the region can be written to.
 
+  * *access mode* bits indicate how the region is to be accessed by the server.
+
 * *offset* is the file offset of the region with respect to the associated file
   descriptor, or zero if the region is not mappable
 * *address* is the base DMA address of the region.
@@ -641,16 +647,30 @@ The request payload for this message is a structure of the following format:
 
 This structure is 32 bytes in size, so the message size is 16 + 32 bytes.
 
-If the DMA region being added can be directly mapped by the server, a file
-descriptor must be sent as part of the message meta-data. The region can be
-mapped via the mmap() system call. On ``AF_UNIX`` sockets, the file descriptor
-must be passed as ``SCM_RIGHTS`` type ancillary data.  Otherwise, if the DMA
-region cannot be directly mapped by the server, no file descriptor must be sent
-as part of the message meta-data and the DMA region can be accessed by the
-server using ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages,
-explained in `Read and Write Operations`_. A command to map over an existing
-region must be failed by the server with ``EEXIST`` set in error field in the
-reply.
+There are several alternative access modes for the server to use when accessing
+the region:
+
+* ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages, explained in
+  `Read and Write Operations`_.
+
+* ``mmap()`` a client-provided file descriptor, then perform direct accesses to
+  the underlying memory.
+
+* File I/O system calls (such as ``pread()`` / ``pwrite()``) against a
+  client-provided file descriptor.
+
+The access mode bits in the flags field indicate which access mode to use. If
+an access mode requiring a file descriptor is specified, but the client does
+not provide a file descriptor, the server must fail the request with
+``EINVAL``. If no access mode flag bit is set, the server should use ``mmap()``
+based access if the client provided a file descriptor and message-based access
+otherwise.
+
+On ``AF_UNIX`` sockets, the file descriptor must be passed as ``SCM_RIGHTS``
+type ancillary data.
+
+A command to map over an existing region must be failed by the server with
+``EEXIST`` set in the error field in the reply.
 
 Reply
 ^^^^^
-- 
2.54.0


