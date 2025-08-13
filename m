Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDA4C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 10:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um8jk-0007vY-FI; Wed, 13 Aug 2025 06:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um8jg-0007up-7n
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um8jd-0007bk-Ji
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755080971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=U0b2G9ATpR9Z7jW7J8It8NfnkIx7zaXCF7D/YUKRYhM=;
 b=IGMkewC97ZrfWoP82OkqWuqQZRDfgwpRA/gUIvK9tqjHtXAlkkKgS9VY/xIV7tPaEwmWib
 mJVYdxejVXdEHAUcK6XCfldTAblKoNrfQ7V3O0bqPYP6tl78GnZkrxuU8IEXmq9LiUhzvR
 Rezp6h8oFr8Opp2at4nXUyXR6fO8tBM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-a4fjpYotNB2v8sFlH9DBbQ-1; Wed,
 13 Aug 2025 06:29:29 -0400
X-MC-Unique: a4fjpYotNB2v8sFlH9DBbQ-1
X-Mimecast-MFC-AGG-ID: a4fjpYotNB2v8sFlH9DBbQ_1755080969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EA518003FD; Wed, 13 Aug 2025 10:29:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F27CF19560AB; Wed, 13 Aug 2025 10:29:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
Date: Wed, 13 Aug 2025 12:28:13 +0200
Message-ID: <cover.1755080613.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some virtualized deployments use UDP tunnel pervasively and are impacted
negatively by the lack of GSO support for such kind of traffic in the
virtual NIC driver.

The virtio_net specification recently introduced support for GSO over
UDP tunnel, and the kernel side of the implementation has been merged
into the net-next tree; this series updates the virtio implementation to
support such a feature.

Currently the qemu virtio support limits the feature space to 64 bits,
while the virtio specification allows for a larger number of features.
Specifically the GSO-over-UDP-tunnel-related virtio features use bits
65-69; the larger part of this series (patches 4-12) actually deals with
extending the features space.

The extended features are carried by fixed size uint64_t arrays,
bringing the current maximum features number to 128.

The patches use some syntactic sugar to try to minimize the otherwise
very large code churn. Specifically the extended features are boundled
in an union with 'legacy' features definition, allowing no changes in
the virtio devices not needing the extended features set.

The actual offload implementation is in patches 13 and 14 and boils down
to propagating the new offload to the tun devices and the vhost backend.

Patch 1 is a small pre-req refactor that ideally could enter the
tree separately; it's presented here in the same series to help
reviewers more easily getting the full picture, patch 2 updates to 
linux headers update script to deal with annotations recently introduce
in the kernel and patch 3 is a needed linux headers update.

Tested with basic stream transfer with all the possible permutations of
host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
vs snapshots creation and restore and vs migration.

The new features are disabled by default to avoid compatibilty issues.
They could be enabled after that hw_compat_10_1 will be added, together
with the related compatiblity entries.

Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com
---
v4 -> v5:
  - more sparse cleanup
  - dropped RFC tag
  - disable the new features by default

v4: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05513.html

v3 -> v4:
  - more sparse cleanups
  - fix build failures on a couple of targets
v3: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg04872.html

v2 -> v3:
  - consolidated suffixes for new fields to '_ex'
  - avoid pre/post load trickery and relay on reset zeroing the features
  - cleaned-up virtio store implementation deduplicating a bit of code
  - many more cleanups, see the individual patches changelog for the
    details
  - I left patch 1 unmodified, still some hope we could live with that;)
v2: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg03000.html

Paolo Abeni (13):
  linux-headers: deal with counted_by annotation
  linux-headers: Update to Linux v6.17-rc1
  virtio: introduce extended features type
  virtio: serialize extended features state
  virtio: add support for negotiating extended features
  virtio-pci: implement support for extended features
  vhost: add support for negotiating extended features
  qmp: update virtio features map to support extended features
  vhost-backend: implement extended features support
  vhost-net: implement extended features support
  virtio-net: implement extended features support
  net: implement tunnel probing
  net: implement UDP tunnel features offloading

 hw/net/vhost_net-stub.c                       |   8 +-
 hw/net/vhost_net.c                            |  45 ++--
 hw/net/virtio-net.c                           | 215 ++++++++++++------
 hw/virtio/vhost-backend.c                     |  62 ++++-
 hw/virtio/vhost.c                             |  68 ++++--
 hw/virtio/virtio-bus.c                        |  11 +-
 hw/virtio/virtio-hmp-cmds.c                   |   3 +-
 hw/virtio/virtio-pci.c                        |  74 +++++-
 hw/virtio/virtio-qmp.c                        |  91 +++++---
 hw/virtio/virtio-qmp.h                        |   3 +-
 hw/virtio/virtio.c                            | 100 +++++---
 include/hw/virtio/vhost-backend.h             |   6 +
 include/hw/virtio/vhost.h                     |  56 ++++-
 include/hw/virtio/virtio-features.h           | 127 +++++++++++
 include/hw/virtio/virtio-net.h                |   2 +-
 include/hw/virtio/virtio-pci.h                |   2 +-
 include/hw/virtio/virtio.h                    |  11 +-
 include/net/net.h                             |   5 +
 include/net/vhost_net.h                       |  33 ++-
 include/standard-headers/drm/drm_fourcc.h     |  56 ++++-
 include/standard-headers/linux/ethtool.h      |   4 +-
 .../linux/input-event-codes.h                 |   8 +
 include/standard-headers/linux/input.h        |   1 +
 include/standard-headers/linux/pci_regs.h     |   9 +
 include/standard-headers/linux/vhost_types.h  |   5 +
 include/standard-headers/linux/virtio_net.h   |  33 +++
 linux-headers/LICENSES/preferred/GPL-2.0      |  10 +-
 linux-headers/asm-arm64/unistd_64.h           |   2 +
 linux-headers/asm-generic/unistd.h            |   8 +-
 linux-headers/asm-loongarch/unistd_64.h       |   2 +
 linux-headers/asm-mips/unistd_n32.h           |   2 +
 linux-headers/asm-mips/unistd_n64.h           |   2 +
 linux-headers/asm-mips/unistd_o32.h           |   2 +
 linux-headers/asm-powerpc/kvm.h               |  13 --
 linux-headers/asm-powerpc/unistd_32.h         |   2 +
 linux-headers/asm-powerpc/unistd_64.h         |   2 +
 linux-headers/asm-riscv/kvm.h                 |   1 +
 linux-headers/asm-riscv/unistd_32.h           |   2 +
 linux-headers/asm-riscv/unistd_64.h           |   2 +
 linux-headers/asm-s390/unistd_32.h            |   2 +
 linux-headers/asm-s390/unistd_64.h            |   2 +
 linux-headers/asm-x86/unistd_32.h             |   2 +
 linux-headers/asm-x86/unistd_64.h             |   2 +
 linux-headers/asm-x86/unistd_x32.h            |   2 +
 linux-headers/linux/iommufd.h                 | 154 ++++++++++++-
 linux-headers/linux/kvm.h                     |   2 +
 linux-headers/linux/vfio.h                    |  12 +-
 linux-headers/linux/vhost.h                   |  35 +++
 net/net.c                                     |  12 +-
 net/tap-bsd.c                                 |   5 +
 net/tap-linux.c                               |  17 ++
 net/tap-linux.h                               |   9 +
 net/tap-solaris.c                             |   5 +
 net/tap-stub.c                                |   5 +
 net/tap.c                                     |  13 ++
 net/tap_int.h                                 |   1 +
 qapi/virtio.json                              |   9 +-
 scripts/update-linux-headers.sh               |   1 +
 58 files changed, 1136 insertions(+), 242 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

-- 
2.50.1


