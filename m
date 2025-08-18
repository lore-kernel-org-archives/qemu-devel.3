Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E982CA0EC6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 10:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unwir-00047N-Hv; Mon, 18 Aug 2025 06:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unwiq-00047B-BR
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unwin-0002pG-OB
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755511446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2gBnq/M8IfPBL4t+VPmM11SRA0GQK2YsfR1Mb1j2sR8=;
 b=NctR3j6X2GA4DYidsuoJO4cN7sTV5wJtbNXqHzn7BcQ9Fbb9UV25ZjFD7iHk/Vr5BmJMkS
 JMEln7a60SIX8WKZ2YklheWvI/vr4WIl6EciiJBSez7JuCMMwSN6sBBHIv5j1Sv6I5Atu8
 HJBsAFpf4b/vvh8F8ZE9ky3Fui4yw9M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-Y5I3lTW9Mwq40iMzqDqO-Q-1; Mon,
 18 Aug 2025 06:04:03 -0400
X-MC-Unique: Y5I3lTW9Mwq40iMzqDqO-Q-1
X-Mimecast-MFC-AGG-ID: Y5I3lTW9Mwq40iMzqDqO-Q_1755511442
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A528719560B3; Mon, 18 Aug 2025 10:04:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1095180047F; Mon, 18 Aug 2025 10:03:55 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is,
 jasowang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 dbassey@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v7 0/8] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Mon, 18 Aug 2025 12:03:45 +0200
Message-ID: <20250818100353.1560655-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

v6->v7
- Fixed vhost_user_shmem_object_new to use
  memory_region_init_ram_from_fd as before
v5->v6
- Added intermediate QOM object to manage shared
  MemoryRegion lifecycle with reference counting,
  and automatic cleanup
- Resolved BAR conflict, change from 2 to 3
  to avoid conflict with `modern-pio-notify=on`
- Added SHMEM_CONFIG validation in vhost-user-test
- Changed VirtSharedMemory -> VirtioSharedMemory
- Changed MappedMemoryRegion -> VirtioSharedMemoryMapping
- Changed from heap-allocated MemoryRegion *mr to
  embedded MemoryRegion mr in VirtioSharedMemory
  structure to eliminate memory leaks and
  simplify cleanup
- Fixed VirtioSharedMemory initialization and
  cleanup with memory_region_init() and object_unparent()
- Other minor fixes, typos, and updates.

This patch series implements dynamic fd-backed
memory mapping support for vhost-user backends,
enabling backends to dynamically request memory
mappings and unmappings during runtime through the new
VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.

This feature benefits various VIRTIO devices that
require dynamic shared memory management, including
virtiofs (for DAX mappings), virtio-gpu (for resource
sharing), and the recently standardized virtio-media
device.

The implementation introduces a robust QOM-based
architecture for managing shared memory lifecycle:

- VhostUserShmemObject: an intermediate object that
  manages individual memory mappings
- VIRTIO Shared Memory Regions: generic container
  regions declared in VirtIODevice to support any
  vhost-user device type
- Dynamic Mapping: backends can request mappings via
  SHMEM_MAP messages, with the frontend creating
  MemoryRegions from the provided file descriptors and
  adding them as subregions

When a SHMEM_MAP request is received, the frontend:
1. Creates VhostUserShmemObject to manage the mapping
   lifecycle
2. Maps the provided fd with memory_region_init_ram_from_fd()
3. Creates a MemoryRegion backed by the mapped memory
4. Adds it as a subregion of the appropiate VIRTIO
   Shared Memory Region

The QOM reference counting ensures automatic cleanup
when mappings are removed or the device is destroyed.

This patch also includes:
- VHOST_USER_GET_SHMEM_CONFIG: a new frontend request
  allowing generic vhost-user devices to query shared
  memory configuration from backends at device
  initialization, enabling the generic vhost-user-device
  frontend to work with any backend regardless of specific
  shared memory requirements.

The implementation has been tested with rust-vmm based
backends and includes SHMEM_CONFIG QTest validation.

Albert Esteve (8):
  vhost-user: Add VirtIO Shared Memory map request
  vhost_user.rst: Align VhostUserMsg excerpt members
  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
  vhost_user: Add frontend get_shmem_config command
  vhost_user.rst: Add GET_SHMEM_CONFIG message
  tests/qtest: Add GET_SHMEM validation test
  qmp: add shmem feature map
  vhost-user-device: Add shared memory BAR

 docs/interop/vhost-user.rst               | 101 +++++++++
 hw/virtio/meson.build                     |   1 +
 hw/virtio/vhost-user-base.c               |  49 ++++-
 hw/virtio/vhost-user-device-pci.c         |  34 ++-
 hw/virtio/vhost-user-shmem.c              | 134 ++++++++++++
 hw/virtio/vhost-user.c                    | 250 +++++++++++++++++++++-
 hw/virtio/virtio-qmp.c                    |   3 +
 hw/virtio/virtio.c                        | 109 ++++++++++
 include/hw/virtio/vhost-backend.h         |  10 +
 include/hw/virtio/vhost-user-shmem.h      |  75 +++++++
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                |  95 ++++++++
 subprojects/libvhost-user/libvhost-user.c |  70 ++++++
 subprojects/libvhost-user/libvhost-user.h |  54 +++++
 tests/qtest/vhost-user-test.c             |  91 ++++++++
 15 files changed, 1070 insertions(+), 7 deletions(-)
 create mode 100644 hw/virtio/vhost-user-shmem.c
 create mode 100644 include/hw/virtio/vhost-user-shmem.h

-- 
2.49.0


