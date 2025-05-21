Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD73EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhjV-0003bK-Kf; Wed, 21 May 2025 07:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjL-0003Zj-EJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjC-000108-7K
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZGJVdpExX3Cc45GeCGVAJ3Kq21Pgw3U+VPt6wNHS4Lk=;
 b=OD/e2rzhvnDscORf8cDrA9qkJgzxdze/QmA/UdkNcP/MUVRZ9vroYQoSlohM/AqgDnOGvZ
 NJMd1rcsVBNugQBSr4D0EW8yzu8GitT2jpELoSFWqzws8qTrzO0hDNO7kb98N+x9GIVosL
 HJY2HP7rkcFIVaKJp9gQ0Dnf1gZ4jxA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-1F56r0-_Oomx_DME8DDzMA-1; Wed,
 21 May 2025 07:35:11 -0400
X-MC-Unique: 1F56r0-_Oomx_DME8DDzMA-1
X-Mimecast-MFC-AGG-ID: 1F56r0-_Oomx_DME8DDzMA_1747827310
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1461851071; Wed, 21 May 2025 11:34:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBBD619560B7; Wed, 21 May 2025 11:34:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 00/16] virtio: introduce support for GSO over UDP tunnel
Date: Wed, 21 May 2025 13:33:54 +0200
Message-ID: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Some virtualized deployments use UDP tunnel pervasively and are impacted
negatively by the lack of GSO support for such kind of traffic in the
virtual NIC driver.

The virtio_net specification recently introduced support for GSO over
UDP tunnel, this series updates the virtio implementation to support
such a feature.

One of the reasons for the RFC tag is that the kernel-side
implementation has just been shared upstream and is not merged yet, but
there are also other relevant reasons, see below.

Currently, the kernel virtio support limits the feature space to 64 bits,
while the virtio specification allows for a larger number of features.
Specifically, the GSO-over-UDP-tunnel-related virtio features use bits
65-69; the larger part of this series (patches 2-11) actually deals with
the extended feature space.

I tried to minimize the otherwise very large code churn by limiting the
extended features support to arches with native 128 integer support and
introducing the extended features space support only in virtio/vhost
core and in the relevant device driver.

The actual offload implementation is in patches 12-16 and boils down to
propagating the new offload to the tun devices and the vhost backend.

Tested with basic stream transfer with all the possible permutations of
host kernel/qemu/guest kernel with/without GSO over UDP tunnel support
and vs snapshots creation and restore.

Notably this does not include (yet) any additional tests. Some guidance
on such matter would be really appreciated, and any feedback about the
features extension strategy would be more than welcome!

Paolo Abeni (16):
  linux-headers: Update to Linux v6.15-rc net-next
  migration: introduce support for 128 bit int state.
  virtio: introduce extended features type
  virtio: serialize extended features state
  qmp: update virtio features map to support extended features
  virtio: add support for negotiating extended features.
  virtio-pci: implement support for extended features.
  vhost: add support for negotiating extended features.
  vhost-backend: implement extended features support.
  vhost-net: implement extended features support.
  qdev-properties: add property for extended virtio features
  virtio-net: implement extended features support.
  net: implement tunnel probing
  net: bundle all offloads in a single struct
  net: implement tnl feature offloading
  net: make vhost-net aware of GSO over UDP tunnel hdr layout

 hw/core/qdev-properties.c                     |  46 +++++
 hw/net/e1000e_core.c                          |   5 +-
 hw/net/igb_core.c                             |   5 +-
 hw/net/vhost_net-stub.c                       |   7 +-
 hw/net/vhost_net.c                            |  35 ++--
 hw/net/virtio-net.c                           | 195 +++++++++++++-----
 hw/net/vmxnet3.c                              |  13 +-
 hw/virtio/vhost-backend.c                     |  59 +++++-
 hw/virtio/vhost.c                             |  58 ++++--
 hw/virtio/virtio-bus.c                        |  15 +-
 hw/virtio/virtio-hmp-cmds.c                   |   3 +-
 hw/virtio/virtio-pci.c                        |  19 +-
 hw/virtio/virtio-qmp.c                        |  28 ++-
 hw/virtio/virtio-qmp.h                        |   3 +-
 hw/virtio/virtio.c                            | 103 ++++++++-
 include/hw/qdev-properties.h                  |  13 ++
 include/hw/virtio/vhost-backend.h             |  10 +
 include/hw/virtio/vhost.h                     |  13 +-
 include/hw/virtio/virtio-features.h           |  90 ++++++++
 include/hw/virtio/virtio-net.h                |   2 +-
 include/hw/virtio/virtio-pci.h                |   2 +-
 include/hw/virtio/virtio.h                    |  17 +-
 include/migration/qemu-file-types.h           |  15 ++
 include/migration/vmstate.h                   |  11 +
 include/net/net.h                             |  20 +-
 include/net/vhost_net.h                       |   8 +-
 include/standard-headers/asm-x86/setup_data.h |   4 +-
 include/standard-headers/drm/drm_fourcc.h     |  41 ++++
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/ethtool.h      | 156 ++++++++------
 include/standard-headers/linux/fuse.h         |  12 +-
 include/standard-headers/linux/pci_regs.h     |  13 +-
 include/standard-headers/linux/virtio_net.h   |  46 +++++
 include/standard-headers/linux/virtio_pci.h   |   1 +
 include/standard-headers/linux/virtio_snd.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |  11 +
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/mman-common.h       |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   2 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   8 +-
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/iommufd.h                 | 129 +++++++++++-
 linux-headers/linux/kvm.h                     |   1 +
 linux-headers/linux/psp-sev.h                 |  21 +-
 linux-headers/linux/stddef.h                  |   2 +
 linux-headers/linux/vfio.h                    |  30 ++-
 linux-headers/linux/vhost.h                   |  12 +-
 migration/qemu-file.c                         |  16 ++
 migration/vmstate-types.c                     |  25 +++
 net/net.c                                     |  21 +-
 net/netmap.c                                  |   3 +-
 net/tap-bsd.c                                 |   8 +-
 net/tap-linux.c                               |  46 ++++-
 net/tap-solaris.c                             |   9 +-
 net/tap-stub.c                                |   8 +-
 net/tap.c                                     |  19 +-
 net/tap_int.h                                 |   5 +-
 qapi/virtio.json                              |   8 +-
 73 files changed, 1209 insertions(+), 271 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

-- 
2.49.0


