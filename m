Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED1C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgqK-0000fL-3y; Fri, 18 Jul 2025 04:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqG-0000Us-JP
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqE-00014N-Nk
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kPyyQ2PBnOZSzO3RtqsQGHHh8YMRL4h7XkVs+HJKY20=;
 b=cCJrgQ55MiP9qRgfmudETIK8F5oIUCU1XGdVZ5yPdT2ft+BkBlnJOiwnOSC1FcRSYa6Axf
 sjqSdqXyYU4qW2cgWvjoLbuIhER55wSIQEFzNTCHj76tMeGXx9bMptN/vh8GEZUe+to7YZ
 mHsz00px0ib92BgK2Tp9iAxWR7dIUqk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-aVJisPXhNIiWQ9vvwYyWIw-1; Fri,
 18 Jul 2025 04:53:13 -0400
X-MC-Unique: aVJisPXhNIiWQ9vvwYyWIw-1
X-Mimecast-MFC-AGG-ID: aVJisPXhNIiWQ9vvwYyWIw_1752828792
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 674BC19560AD; Fri, 18 Jul 2025 08:53:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1F371956089; Fri, 18 Jul 2025 08:53:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC v3 00/13] virtio: introduce support for GSO over UDP tunnel
Date: Fri, 18 Jul 2025 10:52:26 +0200
Message-ID: <cover.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

Currently the qemu virtio support limits the features space to 64 bits,
while the virtio specification allows for a larger number of features.
Specifically the GSO-over-UDP-tunnel-related virtio features use bits
65-69; the larger part of this series (patches 3-11) actually deals with
extending the features space.

The extended features are carried by fixed size uint64_t arrays,
bringing the current maximum features number to 128.

The patches use some syntactic sugar to try to minimize the otherwise
very large code churn. Specifically the extended features are boundled
in an union with 'legacy' features definition, allowing no changes in
the virtio devices not needing the extended features set.

The actual offload implementation is in patches 12 and 13 and boils down
to propagating the new offload to the tun devices and the vhost backend.

Finally patch 1 is a small pre-req refactor that ideally could enter the
tree separately; it's presented here in the same series to help
reviewers more easily getting the full picture and patch 2 is a needed
linux headers update.

Tested with basic stream transfer with all the possible permutations of
host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
vs snapshots creation and restore and vs migration.

Sharing again as RFC as the kernel bits have not entered the Linus tree
yet - but they should on next merge window.

---
v2 -> v3:
  - consolidated suffixes for new fields to '_ex'
  - avoid pre/post load trickery and relay on reset zeroing the features
  - cleaned-up virtio store implementation deduplicating a bit of code
  - many more cleanups, see the individual patches changelog for the
    details
  - I left patch 1 unmodified, still some hope we could live with that;)

Paolo Abeni (13):
  net: bundle all offloads in a single struct
  linux-headers: Update to Linux ~v6.16-rc5 net-next
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

 hw/net/e1000e_core.c                         |   5 +-
 hw/net/igb_core.c                            |   5 +-
 hw/net/vhost_net-stub.c                      |   8 +-
 hw/net/vhost_net.c                           |  46 ++--
 hw/net/virtio-net.c                          | 226 +++++++++++++------
 hw/net/vmxnet3.c                             |  13 +-
 hw/virtio/vhost-backend.c                    |  62 ++++-
 hw/virtio/vhost.c                            |  73 +++++-
 hw/virtio/virtio-bus.c                       |  11 +-
 hw/virtio/virtio-hmp-cmds.c                  |   3 +-
 hw/virtio/virtio-pci.c                       |  54 ++++-
 hw/virtio/virtio-qmp.c                       |  89 +++++---
 hw/virtio/virtio-qmp.h                       |   3 +-
 hw/virtio/virtio.c                           | 102 ++++++---
 include/hw/virtio/vhost-backend.h            |   6 +
 include/hw/virtio/vhost.h                    |  33 ++-
 include/hw/virtio/virtio-features.h          | 123 ++++++++++
 include/hw/virtio/virtio-net.h               |   2 +-
 include/hw/virtio/virtio-pci.h               |   2 +-
 include/hw/virtio/virtio.h                   |  11 +-
 include/net/net.h                            |  20 +-
 include/net/vhost_net.h                      |  33 ++-
 include/standard-headers/linux/ethtool.h     |   4 +-
 include/standard-headers/linux/vhost_types.h |   5 +
 include/standard-headers/linux/virtio_net.h  |  33 +++
 linux-headers/linux/vhost.h                  |   7 +
 net/net.c                                    |  17 +-
 net/netmap.c                                 |   3 +-
 net/tap-bsd.c                                |   8 +-
 net/tap-linux.c                              |  38 +++-
 net/tap-linux.h                              |   9 +
 net/tap-solaris.c                            |   9 +-
 net/tap-stub.c                               |   8 +-
 net/tap.c                                    |  21 +-
 net/tap_int.h                                |   5 +-
 qapi/virtio.json                             |   8 +-
 36 files changed, 857 insertions(+), 248 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

-- 
2.50.0


