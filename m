Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12838606A326
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CoBaf9XT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN36N-0000jL-Iv; Sat, 31 Oct 2026 03:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36I-0000eb-J2
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN36G-0003Kw-UL
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793430120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wv8gx9C/WE7rNmYp3yohwCzAjwmJ0ANihmBT8Ce1Q08=;
 b=CoBaf9XTtGxhmX3IMGVFA2zFV1iszD9VOBEMp+hsqjil4r7b5AOwfIJyLH/v4G2ahdGHhz
 1Mjh2ZekcPi0aqeFE+nJpkBN6BMqZ6FP9kEW0V7IiP+tmtZMkcFeIHom7uWv/OQFPl9QeW
 aufemSqtYmAhYDa9Nz4xIKH3ynw992o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-_uNeLHZbPwiN4LQJzfxRdg-1; Sat,
 31 Oct 2026 03:01:57 -0400
X-MC-Unique: _uNeLHZbPwiN4LQJzfxRdg-1
X-Mimecast-MFC-AGG-ID: _uNeLHZbPwiN4LQJzfxRdg_1793430116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A48195604E
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 07:01:56 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E1D61800495; Sat, 31 Oct 2026 07:01:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/6] vfio queue
Date: Sat, 31 Oct 2026 08:01:46 +0100
Message-ID: <20261031070152.197043-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20261031

for you to fetch changes up to 33229ae31134c58c633c6eb77f1c8507a731a34f:

  vfio/igd: Use version mapping for MTL/ARL quirk selection (2026-10-31 06:48:11 +0100)

----------------------------------------------------------------
vfio queue:

* Extend vfio-user protocol to support multiple file descriptors
  for sparse mmap regions
* Add per-subregion file descriptor and offset to VFIOMmap
* Add setup_sparse_mmaps hook to VFIODeviceIOOps
* Implement client-side multi-FD sparse mmap support in vfio-user
* Reorganize pci.h declarations into sections for readability
* Use version mapping for MTL/ARL quirk selection in IGD passthrough

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio/pci: Reorganize pci.h declarations into sections

Naman Gulati (4):
      vfio-user: add multi-fd region mmap capability
      vfio: add 'fd' and 'fd_offset' to VFIOMmap
      vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
      vfio-user: support multiple FDs for sparse mmap regions

Tomita Moeko (1):
      vfio/igd: Use version mapping for MTL/ARL quirk selection

 docs/interop/vfio-user.rst    |  86 ++++++++++++++++++++++++++--
 hw/vfio-user/protocol.h       |  39 +++++++++++--
 hw/vfio-user/proxy.h          |   2 +
 hw/vfio/pci.h                 |  62 ++++++++++++---------
 hw/vfio/vfio-region.h         |   9 ++-
 include/hw/vfio/vfio-device.h |  16 ++++++
 hw/vfio-user/device.c         | 126 +++++++++++++++++++++++++++++++++++++++---
 hw/vfio-user/proxy.c          |  52 +++++++++++++++--
 hw/vfio/device.c              |   1 +
 hw/vfio/igd.c                 |  30 +++++-----
 hw/vfio/pci.c                 |   2 +
 hw/vfio/region.c              |  45 +++++++++++----
 12 files changed, 400 insertions(+), 70 deletions(-)


