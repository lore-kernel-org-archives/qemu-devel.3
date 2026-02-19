Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B557AE9A049
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3hC-0007X9-Pt; Thu, 19 Feb 2026 08:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vt3hA-0007WV-HU
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vt3h8-0006GN-MP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771506229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GfnV/zKgRVgL1zzhb9CqiAMAu8czKO3LqF4YsD9cyIE=;
 b=cqwUlWmewmo4lWGTUXZKdEyrSXOXlhoDm/H1M3dZtZXrm7GighzZbbSCbtRI6QPzJKEFdf
 YgTNAoJwoCQQ5DQ9eVWNeOKePTKw8I8UjgNe2NqDxXEIQPwtRssdf3A/4DNJFBRawr0fSN
 08rwbqLS547QhZhzgwnEBfFkSfUWufg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-QmxcmrIdNO6OljSux_ipZw-1; Thu,
 19 Feb 2026 08:03:45 -0500
X-MC-Unique: QmxcmrIdNO6OljSux_ipZw-1
X-Mimecast-MFC-AGG-ID: QmxcmrIdNO6OljSux_ipZw_1771506224
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16AE01956088; Thu, 19 Feb 2026 13:03:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7609D1955F01; Thu, 19 Feb 2026 13:03:36 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com, hi@alyssa.is,
 stevensd@chromium.org
Subject: [PATCH v13 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Thu, 19 Feb 2026 14:03:27 +0100
Message-ID: <20260219130334.787858-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

v12-v13
- SMEM_UNMAP spec update to explicitly state the use of
  VHOST_USER_PROTOCOL_F_REPLY_ACK for replies
- Removed confusing remark for 0-sized regions in
  GET_SHMEM_CONFIG
v11->v12
- Refined VIRTIO Shared Memory Region configuration mem size
  spec description
- Removed unused name in vhost-user-base's vub_device_realize to
  avoid build error
- Initialize shmem in vhost_user_backend_handle_shmem_unmap
  to avoid compiler being confused
- Added stub for memory_region_init_ram_from_fd in memory.h
  for windows builds
- Use memory_region_size for shmem_region handlers instead
  of accessing size member directly in shmem mrs
v10->v11
- Rebase to grab commit fde5930cc37175cfcd0f03a089e26f4458a52311
  and explicitly unset reply_ack on the SHMEM_MAP/UNMAP msg.
- Mention mapping cleanup on device reset in the spec.
v9->v10
- Fix transaction_commit invoked without transaction_begin
  on vhost_user_backend_handle_shmem_map() early errors
- Removed fd tracking on VirtioSharedMemoryMapping, it
  is handled by the RAMBlock
- Reject invalid BAR configurations when VIRTIO Shared Memory
  Regions are in use by vhost-user-test-device

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

 docs/interop/vhost-user.rst               | 104 +++++++++
 hw/virtio/vhost-user-base.c               |  46 +++-
 hw/virtio/vhost-user-test-device-pci.c    |  38 ++-
 hw/virtio/vhost-user.c                    | 269 ++++++++++++++++++++++
 hw/virtio/virtio-qmp.c                    |   3 +
 hw/virtio/virtio.c                        | 201 ++++++++++++++++
 include/hw/virtio/vhost-backend.h         |  10 +
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                | 137 +++++++++++
 include/system/memory.h                   |  13 ++
 subprojects/libvhost-user/libvhost-user.c |  70 ++++++
 subprojects/libvhost-user/libvhost-user.h |  54 +++++
 12 files changed, 941 insertions(+), 5 deletions(-)

-- 
2.52.0


