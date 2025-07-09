Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3106CC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQ6u-0000zL-TA; Wed, 09 Jul 2025 04:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ6e-0000gB-O0
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ6a-000676-Sv
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752049477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SVzeJovGGfOQSvtfSc/ExDUX4iJksJHU86v31dQBUg0=;
 b=TMpR6joAZHMGUTvJSrieJFSjxFG3QF7OFBviCpBsxBxJbdO2lWIBTWJMEScuY2Pg5GKl0a
 NyvBlTkdBd1CvUAQA0+ZDmvUzCM8PH2KMABweS5VU0ejmg9lvbRcCExv6kAm7hBMfzZjML
 x5Wq8RsAYQgZq2BB62omin6TwH6+sGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-J5swbFtPP3OUX_u9ahGfKg-1; Wed,
 09 Jul 2025 04:24:33 -0400
X-MC-Unique: J5swbFtPP3OUX_u9ahGfKg-1
X-Mimecast-MFC-AGG-ID: J5swbFtPP3OUX_u9ahGfKg_1752049472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F389A1954237; Wed,  9 Jul 2025 08:24:31 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B90D195608F; Wed,  9 Jul 2025 08:24:27 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 00/11] net: Add passt netdev backend
Date: Wed,  9 Jul 2025 10:24:14 +0200
Message-ID: <20250709082425.601990-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
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

This series introduces support for passt as a new network backend for=0D
QEMU.=0D
=0D
The purpose of this new backend is to help to use passt daemon as=0D
easily as the user backend ('-nic passt' as we have '-nic user').=0D
All the passt functionalities will not be available to keep it simple,=0D
and the goal is not to be supported by libvirt, as in these cases the=0D
best way to use passt will be to use stream or vhost-user backend=0D
with an externaly started passt daemon.=0D
=0D
passt is a modern, unprivileged, user-mode networking solution that=0D
provides guest connectivity by launching an external helper process. This=0D
series adds the core backend and integrates it with vhost-user for=0D
high-performance, accelerated networking.=0D
=0D
The series is structured to first improve the general networking code=0D
before adding the new feature. The first patch extracts from the stream=0D
backend the functions that will be reused in the passt backend. The=0D
following patches are a preparatory refactoring to decouple the generic=0D
vhost layer from specific backend implementations (tap, vhost-user, etc.).=
=0D
This is achieved by replacing hardcoded type checks with a callback-based=0D
system in NetClientInfo and vhost-net, making the vhost infrastructure more=
=0D
modular and extensible.=0D
=0D
With the refactoring in place, subsequent patches introduce the passt=0D
backend itself, reusing the generic stream handling logic. The final=0D
patch adds vhost-user support to passt, which plugs cleanly into the=0D
newly refactored vhost layer.=0D
=0D
Some benchmarks:=0D
=0D
 Reference '-net user':=0D
=0D
  -net user,hostfwd=3Dtcp::10001-:10001=0D
=0D
    iperf3 -c localhost -p 10001  -t 60 -4=0D
=0D
    [ ID] Interval           Transfer     Bitrate         Retr=0D
    [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec    1            se=
nder=0D
    [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec                  r=
eceiver=0D
=0D
 New backend '-netdev passt'=0D
=0D
  -netdev passt,vhost-user=3Doff,tcp-ports=3D10001=0D
=0D
    iperf3 -c localhost -p 10001  -t 60 -4=0D
=0D
    [ ID] Interval           Transfer     Bitrate         Retr=0D
    [  5]   0.00-60.00  sec  27.1 GBytes  3.88 Gbits/sec    0            se=
nder=0D
    [  5]   0.00-60.03  sec  27.1 GBytes  3.88 Gbits/sec                  r=
eceiver=0D
=0D
  -netdev passt,vhost-user=3Don,tcp-ports=3D10001=0D
=0D
    iperf3 -c localhost -p 10001  -t 60 -4=0D
=0D
    [ ID] Interval           Transfer     Bitrate         Retr=0D
    [  5]   0.00-60.00  sec   224 GBytes  32.1 Gbits/sec    4            se=
nder=0D
    [  5]   0.00-60.05  sec   224 GBytes  32.0 Gbits/sec                  r=
eceiver=0D
=0D
v4:=0D
  - back to v2 parameters (except debug and trace parameters) + v3 generic =
"param"=0D
  - update documentation=0D
=0D
v3:=0D
  - tested with=0D
        -nic passt=0D
    and=0D
        -nic passt,model=3Dvirtio,vhost-user=3Don=0D
=0D
    and fixed passt_check_peer_type()=0D
  - moved new fields from NetClientInfo to vhost-net struct=0D
  - Remove most of the hardcoded parameters to introduce a generic=0D
    "param" parameter, like:=0D
      -nic passt,param=3D--tcp-ports=3D10001,param=3D--udp-ports=3D10001=0D
  - added patches:=0D
    vhost_net: Rename vhost_set_vring_enable() for clarity=0D
    net: Add is_vhost_user flag to vhost_net struct=0D
    (this one replaces "net: Introduce helper to identify vhost-user client=
s")=0D
  - update documentation=0D
=0D
v2:=0D
  - rebase:=0D
      fix conflict with=0D
        837b87c4c5ba ("net/stream: skip automatic zero-init of large array"=
)=0D
  - add path parameter to provide path of passt if it is not in PATH=0D
  - add 2 patches:=0D
        "net: Allow network backends to advertise max TX queue size"=0D
        "net: Consolidate vhost feature bits into NetClientInfo"=0D
=0D
Thanks,=0D
Laurent=0D
=0D
Laurent Vivier (11):=0D
  net: Refactor stream logic for reuse in '-net passt'=0D
  net: Define net_client_set_link()=0D
  vhost_net: Rename vhost_set_vring_enable() for clarity=0D
  net: Add get_vhost_net callback to NetClientInfo=0D
  net: Consolidate vhost feature bits into vhost_net structure=0D
  net: Add get_acked_features callback to VhostNetOptions=0D
  net: Add save_acked_features callback to vhost_net=0D
  net: Allow network backends to advertise max TX queue size=0D
  net: Add is_vhost_user flag to vhost_net struct=0D
  net: Add passt network backend=0D
  net/passt: Implement vhost-user backend support=0D
=0D
 docs/system/devices/net.rst   |  50 ++-=0D
 hmp-commands.hx               |   3 +=0D
 hw/net/vhost_net-stub.c       |   3 +-=0D
 hw/net/vhost_net.c            | 145 +------=0D
 hw/net/virtio-net.c           |  36 +-=0D
 include/hw/virtio/vhost.h     |   5 +=0D
 include/net/net.h             |   3 +=0D
 include/net/tap.h             |   3 -=0D
 include/net/vhost-user.h      |  19 -=0D
 include/net/vhost-vdpa.h      |   4 -=0D
 include/net/vhost_net.h       |  10 +-=0D
 meson.build                   |   6 +=0D
 meson_options.txt             |   2 +=0D
 net/clients.h                 |   4 +=0D
 net/hub.c                     |   3 +=0D
 net/meson.build               |   6 +-=0D
 net/net.c                     |  36 +-=0D
 net/passt.c                   | 753 ++++++++++++++++++++++++++++++++++=0D
 net/stream.c                  | 282 +++----------=0D
 net/stream_data.c             | 193 +++++++++=0D
 net/stream_data.h             |  31 ++=0D
 net/tap-win32.c               |   5 -=0D
 net/tap.c                     |  43 +-=0D
 net/vhost-user-stub.c         |   1 -=0D
 net/vhost-user.c              |  60 ++-=0D
 net/vhost-vdpa.c              |  11 +-=0D
 qapi/net.json                 | 118 ++++++=0D
 qemu-options.hx               | 153 ++++++-=0D
 scripts/meson-buildoptions.sh |   3 +=0D
 29 files changed, 1564 insertions(+), 427 deletions(-)=0D
 delete mode 100644 include/net/vhost-user.h=0D
 create mode 100644 net/passt.c=0D
 create mode 100644 net/stream_data.c=0D
 create mode 100644 net/stream_data.h=0D
=0D
-- =0D
2.49.0=0D
=0D


