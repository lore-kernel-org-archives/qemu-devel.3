Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04614C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4Bl-0004MO-2K; Mon, 17 Feb 2025 11:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4Bf-0004Ln-If
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:41:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4BZ-0007ss-Tt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sg2lkku03GRDUzTf6xQC4Gtad59C5/+VDo1OvyFCd5A=;
 b=XHqGkhzSCp7lZXt6HWlwelU0Hk88X9zWBELVOG9HkAuyTghz5LAwsERJZYLccH/4cLRhkB
 qDPuTK8jhODcAFVF2DsD7T84Xe9ZiC++xtsF8Mx5k1XMOciQEc+0EJq5usmKb2r9vv6MDr
 qCbEsXHNhqcKdMEU1vT1hAGY1zyYuDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-tIuEfYs_ODCBDMp1V-gBTA-1; Mon,
 17 Feb 2025 11:40:20 -0500
X-MC-Unique: tIuEfYs_ODCBDMp1V-gBTA-1
X-Mimecast-MFC-AGG-ID: tIuEfYs_ODCBDMp1V-gBTA_1739810419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 462F6180087C; Mon, 17 Feb 2025 16:40:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.252])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A564180056F; Mon, 17 Feb 2025 16:40:13 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
 david@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Mon, 17 Feb 2025 17:40:03 +0100
Message-ID: <20250217164012.246727-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi all,

v3->v4
- Change mmap strategy to use RAM blocks
  and subregions.
- Add new bitfield to qmp feature map
- Followed most review comments from
  last iteration.
- Merged documentation patch again with
  this one. Makes more sense to
  review them together after all.
- Add documentation for MEM_READ/WRITE
  messages.

The goal of this patch is to support
dynamic fd-backed memory maps initiated
from vhost-user backends.
There are many devices that could already
benefit of this feature, e.g.,
virtiofs or virtio-gpu.

After receiving the SHMEM_MAP/UNMAP request,
the frontend creates the RAMBlock form the
fd and maps it by adding it as a subregion
of the shared memory region container.

The VIRTIO Shared Memory Region list is
declared in the `VirtIODevice` struct
to make it generic.

TODO: There was a conversation on the
previous version around adding tests
to the patch (which I have acknowledged).
However, given the numerous changes
that the patch already has, I have
decided to send it early and collect
some feedback while I work on the
tests for the next iteration.
Given that I have been able to
test the implementation with
my local setup, I am more or less
confident that, at least, the code
is in a relatively sane state
so that no reviewing time is
wasted on broken patches.

This patch also includes:
- SHMEM_CONFIG frontend request that is
specifically meant to allow generic
vhost-user-device frontend to be able to
query VIRTIO Shared Memory settings from the
backend (as this device is generic and agnostic
of the actual backend configuration).

- MEM_READ/WRITE backend requests are
added to deal with a potential issue when having
multiple backends sharing a file descriptor.
When a backend calls SHMEM_MAP it makes
accessing to the region fail for other
backend as it is missing from their translation
table. So these requests are a fallback
for vhost-user memory translation fails.

Albert Esteve (9):
  vhost-user: Add VirtIO Shared Memory map request
  vhost_user.rst: Align VhostUserMsg excerpt members
  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
  vhost_user: Add frontend get_shmem_config command
  vhost_user.rst: Add GET_SHMEM_CONFIG message
  qmp: add shmem feature map
  vhost-user-devive: Add shmem BAR
  vhost_user: Add mem_read/write backend requests
  vhost_user.rst: Add MEM_READ/WRITE messages

 docs/interop/vhost-user.rst               | 110 +++++++++
 hw/virtio/vhost-user-base.c               |  47 +++-
 hw/virtio/vhost-user-device-pci.c         |  36 ++-
 hw/virtio/vhost-user.c                    | 272 ++++++++++++++++++++--
 hw/virtio/virtio-qmp.c                    |   3 +
 hw/virtio/virtio.c                        |  81 +++++++
 include/hw/virtio/vhost-backend.h         |   9 +
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                |  29 +++
 subprojects/libvhost-user/libvhost-user.c | 160 +++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  92 ++++++++
 11 files changed, 813 insertions(+), 27 deletions(-)

-- 
2.48.1


