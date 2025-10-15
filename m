Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF99ECCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xMW-0003NA-JJ; Wed, 15 Oct 2025 05:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xMV-0003My-9a
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xMQ-0004xF-Dq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760518788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OBctZvTNLS4mpf+cFXel8Z+MWe5ezwNIDUiAeg8hl/w=;
 b=FM3UKa+jIKedFF7T6tVQXAySY5aY5gN9Tmcr9YtQSuZe1oX9omkyvCpLPgN6Z2Tnm4fFbB
 o6w2BcNq5131f/pS9Er8ByzhRgC5GmNWNg5x5RP+D8yT1GClp4N0YqX5K3qS3H2sgcDWGi
 O+y+2YzwmBsqWdY5El24CGKFtJ4B8Ro=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-wmV-cUMlPbyA0h7OLHxy6Q-1; Wed,
 15 Oct 2025 04:59:45 -0400
X-MC-Unique: wmV-cUMlPbyA0h7OLHxy6Q-1
X-Mimecast-MFC-AGG-ID: wmV-cUMlPbyA0h7OLHxy6Q_1760518784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9AEA1956048; Wed, 15 Oct 2025 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.32.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB80E1800353; Wed, 15 Oct 2025 08:59:36 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, jasowang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, hi@alyssa.is,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, david@redhat.com,
 manos.pitsidianakis@linaro.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, slp@redhat.com,
 dbassey@redhat.com, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v9 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Wed, 15 Oct 2025 10:59:23 +0200
Message-ID: <20251015085930.1517330-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v8->v9
- Fixed vhost-user new handlers to ensure that they always
  reply
- Made MMAP request flags field u64 everywhere
- Fixed double memory_region_del_subregion() on UNMAP
- Add mappings cleaning on virtio_reset()
- Some small typos and fixes
- Fixed virtio pci bar mapping for vhost-user-test-device
v7->v8
- Unified VhostUserShmemObject and VirtioSharedMemoryMapping
- Refined shmem_obj lifecycle by transferring ownership
- Other small improvements

This patch series implements dynamic fd-backed memory mapping support
for vhost-user backends, enabling backends to dynamically request memory
mappings and unmappings during runtime through the new
VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.

This feature benefits various VIRTIO devices that require dynamic shared
memory management, including virtiofs (for DAX mappings), virtio-gpu
(for resource sharing), and the recently standardized virtio-media.

The implementation introduces a QOM-based architecture for managing
shared memory lifecycle:

- VirtioSharedMemoryMapping: an intermediate object that manages
  individual memory mappings by acting as generic container for regions
  declared in any vhost-user device type
- Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
  with the frontend creating MemoryRegions from the provided file
  descriptors and adding them as subregions

When a SHMEM_MAP request is received, the frontend:
1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
2. Maps the provided fd with memory_region_init_ram_from_fd()
3. Creates a MemoryRegion backed by the mapped memory
4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region

The QOM reference counting ensures automatic cleanup when mappings are
removed or the device is destroyed.

This patch also includes:
- VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
  vhost-user devices to query shared memory configuration from backends
  at device initialization, enabling the generic vhost-user-device
  frontend to work with any backend regardless of specific shared memory
  requirements.

The implementation has been tested with rust-vmm based backends.

Albert Esteve (7):
  vhost-user: Add VirtIO Shared Memory map request
  vhost_user.rst: Align VhostUserMsg excerpt members
  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
  vhost_user: Add frontend get_shmem_config command
  vhost_user.rst: Add GET_SHMEM_CONFIG message
  qmp: add shmem feature map
  vhost-user-device: Add shared memory BAR

 docs/interop/vhost-user.rst               | 101 +++++++++
 hw/virtio/vhost-user-base.c               |  47 +++-
 hw/virtio/vhost-user-test-device-pci.c    |  35 ++-
 hw/virtio/vhost-user.c                    | 257 ++++++++++++++++++++++
 hw/virtio/virtio-qmp.c                    |   3 +
 hw/virtio/virtio.c                        | 207 +++++++++++++++++
 include/hw/virtio/vhost-backend.h         |  10 +
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                | 138 ++++++++++++
 subprojects/libvhost-user/libvhost-user.c |  70 ++++++
 subprojects/libvhost-user/libvhost-user.h |  54 +++++
 11 files changed, 918 insertions(+), 5 deletions(-)

-- 
2.49.0


