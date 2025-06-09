Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BD5C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdoR-0005W4-KG; Mon, 09 Jun 2025 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uOdo9-0005Iz-Oz
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uOdo7-0008OV-4a
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749480541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NCM9HWYkivgjtDIOwY89EPvuoKo0jt5wvSKZKKfb5L8=;
 b=HHoADNgBVz1VYfkhgh6RDI3uZmD8RbmwCMZMGbqxLCvu8+JjZZsQJZB44VUKEYP+JS8Kkl
 n6wgXdGzk4rewn0n/kbyCHHYX0y7jq0nPdulJv0sDZfwa00M8QuHH/Nba3m6/FnNnmK8+V
 a++R4DGb4YQJk48bS5c7ePXpyDL2HzE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-Bc2xt8IbNh2CDqNyWM4S2g-1; Mon,
 09 Jun 2025 10:47:38 -0400
X-MC-Unique: Bc2xt8IbNh2CDqNyWM4S2g-1
X-Mimecast-MFC-AGG-ID: Bc2xt8IbNh2CDqNyWM4S2g_1749480457
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1AB91800289; Mon,  9 Jun 2025 14:47:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07B7619560A3; Mon,  9 Jun 2025 14:47:31 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slp@redhat.com, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 stevensd@chromium.org, hi@alyssa.is,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v5 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Mon,  9 Jun 2025 16:47:22 +0200
Message-ID: <20250609144729.884027-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v4->v5
- Change vdev->shmem_list to QSIMPLEQ type
- Dropped MEM_READ/WRITE messages
- Improved message handling for
  SHMEM_MAP/UNMAP (fix leaks, fix
  response logic, reworked field
  checks, etc.)
- Changed VHOST_USER_FLAG_MAP_* to
  have only read-write flag

The goal of this patch is to support
dynamic fd-backed memory maps initiated
from vhost-user backends.
There are many devices that could already
benefit of this feature, e.g.,
virtiofs, virtio-gpu, or the recently
added to the spec, virtio-media device.

After receiving the SHMEM_MAP/UNMAP request,
the frontend creates the RAMBlock form the
fd and maps it by adding it as a subregion
of the shared memory region container.

The VIRTIO Shared Memory Region list is
declared in the `VirtIODevice` struct
to make it generic.

The message handling code has been tested
with a rust-vmm device, which entails
some level of validation.

This patch also includes:
- SHMEM_CONFIG frontend request that is
specifically meant to allow generic
vhost-user-device frontend to be able to
query VIRTIO Shared Memory settings from the
backend (as this device is generic and agnostic
of the actual backend configuration).

Albert Esteve (7):
  vhost-user: Add VirtIO Shared Memory map request
  vhost_user.rst: Align VhostUserMsg excerpt members
  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
  vhost_user: Add frontend get_shmem_config command
  vhost_user.rst: Add GET_SHMEM_CONFIG message
  qmp: add shmem feature map
  vhost-user-devive: Add shmem BAR

 docs/interop/vhost-user.rst               |  98 +++++++++++
 hw/virtio/vhost-user-base.c               |  47 +++++-
 hw/virtio/vhost-user-device-pci.c         |  34 +++-
 hw/virtio/vhost-user.c                    | 193 ++++++++++++++++++++++
 hw/virtio/virtio-qmp.c                    |   3 +
 hw/virtio/virtio.c                        |  97 +++++++++++
 include/hw/virtio/vhost-backend.h         |  10 ++
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                |  31 ++++
 subprojects/libvhost-user/libvhost-user.c |  70 ++++++++
 subprojects/libvhost-user/libvhost-user.h |  54 ++++++
 11 files changed, 633 insertions(+), 5 deletions(-)

-- 
2.49.0


