Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BCBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPC-0001nA-E0; Tue, 15 Jul 2025 00:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOE-0001Hd-Vd
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOB-0005xt-6j
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ptDPeT215JWuYEFfSWZ6xyz0OgVBAfPjB7Esmn4jB9k=;
 b=V/4FnPBBMUZZoeLMoiywVADzyLvdRqgetU7jNxgCPniqOffw1l4DOCzYRbPAM353/GPN8B
 ZL9vUKXluGSoABx0lhTBeDV3OtDZ6BDvNa2VsthcWohTIHHX3WTuwc3XmmevonOj4VI2K/
 8m4fxLgt9cdzHdnOv1XAsfRsdyb0El4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-zNlojMLaNByOb00ddsinYA-1; Tue,
 15 Jul 2025 00:35:30 -0400
X-MC-Unique: zNlojMLaNByOb00ddsinYA-1
X-Mimecast-MFC-AGG-ID: zNlojMLaNByOb00ddsinYA_1752554130
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFFC7180028D
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:35:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 651501977000; Tue, 15 Jul 2025 04:35:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 00/16] Net patches
Date: Tue, 15 Jul 2025 12:35:08 +0800
Message-ID: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git net-pull-request

for you to fetch changes up to e53d9ec7ccc2dbb9378353fe2a89ebdca5cd7015:

  net/af-xdp: Support pinned map path for AF_XDP sockets (2025-07-15 10:26:55 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmh11cgACgkQ7wSWWzmN
YhGZKAf+PZ3ZnOoHXd5z8hA5d9Xf+U/01YyPN+Q0NPLWVXhYZBeNhhYEnZwGeSwS
n0YFTLiYIrcaSrt74QtBvUVCX7KoILRnzgoLquUnFBlI0BrR5pFKB70gHmLU3Dxw
xOdxtIm/chfiicE39ziTfO28Cv0N1k9NCHsuMsydbhQL8kc/aRaMofizO8MjPLbr
J8hf8N7jivh8fzH3F5vyglaNl2ijSkPm+XDQYAb04laGfdsIlYkmB7lB/17def2a
S9gur484x5w+Yb2LNdyq/3IPzDqzlNbRGVcfTZS8FIc65R+5idIN+7lKHCffURrr
W8zWFy1wA54hJoTxAq0nsf1TSvc9UA==
=DiBC
-----END PGP SIGNATURE-----

Changes since V1:

- add AF_XDP enhancement series

----------------------------------------------------------------
Akihiko Odaki (1):
      virtio-net: Add queues for RSS during migration

Anastasia Belova (1):
      net: fix buffer overflow in af_xdp_umem_create()

Daniel Borkmann (3):
      net/af-xdp: Remove XDP program cleanup logic
      net/af-xdp: Fix up cleanup path upon failure in queue creation
      net/af-xdp: Support pinned map path for AF_XDP sockets

Laurent Vivier (11):
      net: Refactor stream logic for reuse in '-net passt'
      net: Define net_client_set_link()
      vhost_net: Rename vhost_set_vring_enable() for clarity
      net: Add get_vhost_net callback to NetClientInfo
      net: Consolidate vhost feature bits into vhost_net structure
      net: Add get_acked_features callback to VhostNetOptions
      net: Add save_acked_features callback to vhost_net
      net: Allow network backends to advertise max TX queue size
      net: Add is_vhost_user flag to vhost_net struct
      net: Add passt network backend
      net/passt: Implement vhost-user backend support

 docs/system/devices/net.rst   |  50 ++-
 hmp-commands.hx               |   3 +
 hw/net/vhost_net-stub.c       |   3 +-
 hw/net/vhost_net.c            | 145 ++------
 hw/net/virtio-net.c           |  47 +--
 hw/virtio/virtio.c            |  14 +-
 include/hw/virtio/vhost.h     |   5 +
 include/hw/virtio/virtio.h    |  10 +-
 include/net/net.h             |   3 +
 include/net/tap.h             |   3 -
 include/net/vhost-user.h      |  19 --
 include/net/vhost-vdpa.h      |   4 -
 include/net/vhost_net.h       |  10 +-
 meson.build                   |   6 +
 meson_options.txt             |   2 +
 net/af-xdp.c                  |  99 ++++--
 net/clients.h                 |   4 +
 net/hub.c                     |   3 +
 net/meson.build               |   6 +-
 net/net.c                     |  36 +-
 net/passt.c                   | 753 ++++++++++++++++++++++++++++++++++++++++++
 net/stream.c                  | 282 ++++------------
 net/stream_data.c             | 193 +++++++++++
 net/stream_data.h             |  31 ++
 net/tap-win32.c               |   5 -
 net/tap.c                     |  43 ++-
 net/vhost-user-stub.c         |   1 -
 net/vhost-user.c              |  60 +++-
 net/vhost-vdpa.c              |  11 +-
 qapi/net.json                 | 147 ++++++++-
 qemu-options.hx               | 176 +++++++++-
 scripts/meson-buildoptions.sh |   3 +
 32 files changed, 1703 insertions(+), 474 deletions(-)
 delete mode 100644 include/net/vhost-user.h
 create mode 100644 net/passt.c
 create mode 100644 net/stream_data.c
 create mode 100644 net/stream_data.h


