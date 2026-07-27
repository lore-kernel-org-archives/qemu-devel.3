Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4u-00048f-8M; Mon, 27 Jul 2026 01:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4f-0003rA-24
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4c-0003lf-QB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNpE2nNq2DkmFOVkbIPR6qFBZzODAefD/FRCjOwoQx8=;
 b=aX7oUkBllZrroOAuwDDledtOXN2lpWCz4gEvRgKOB0bVBBOLkhX7Usv2s0/oSV3TNQa00F
 McIyfUpq8MRaMHpykg4kTeAgkf1aycyjnJMyHxfsMeOLT9ei7u/8kyHx49meztmy6ipeqS
 2W7RCj0vzmPGWS89d8MzQK/vbjbq+hw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-T9iYyycTNHKL2ocymMtqLw-1; Mon,
 27 Jul 2026 01:40:17 -0400
X-MC-Unique: T9iYyycTNHKL2ocymMtqLw-1
X-Mimecast-MFC-AGG-ID: T9iYyycTNHKL2ocymMtqLw_1785130815
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7580180134A; Mon, 27 Jul 2026 05:40:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE0481956088; Mon, 27 Jul 2026 05:40:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 10/11] docs: Add igb VF migration testing setup guide
Date: Mon, 27 Jul 2026 07:39:34 +0200
Message-ID: <20260727053935.1392269-11-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Document the NetworkManager configuration and network topology needed
to test igb VF live migration in a nested virtualization environment.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/devices/igb-migration.rst | 155 ++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
index 4a3a93f01dfc..0e34e4b9fc68 100644
--- a/docs/system/devices/igb-migration.rst
+++ b/docs/system/devices/igb-migration.rst
@@ -134,3 +134,158 @@ The driver fills the request fields, issues ``DIRTY_CTRL=QUERY``, and
 polls ``status`` for completion. The device reads the request, writes
 the dirty bitmap and completion fields via DMA, then sets
 ``status = 1``.
+
+Testing setup
+~~~~~~~~~~~~~
+
+The target scenario is nested virtualization::
+
+  L0 QEMU
+    igb PF with x-vf-migration=on
+    └── VFs with migration BAR + vendor cap
+
+  L1 kernel
+    igb-vfio-pci variant driver
+    translates VFIO migration v2 ioctls → BAR2 MMIO
+
+  L1 QEMU (stock, unmodified)
+    vfio-pci device model, standard migration fd
+
+  L2 guest
+    standard igbvf driver, unaware of migration
+
+NetworkManager configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In a nested setup, the L1 VMs (source and destination) have emulated
+igb PFs connected to the L0 bridge. By default, NetworkManager
+acquires DHCP leases on those PF interfaces and on any igb VFs created
+later. This causes the VF MAC address to be learned on the L0 bridge,
+which can misdirect iperf3 traffic after migration.
+
+To prevent this, configure NetworkManager on **both L1 VMs** and on the
+**L2 guest disk image**.
+
+L1 VMs (source and destination)
+...............................
+
+1. Prevent NetworkManager from managing igbvf interfaces:
+
+.. code-block:: bash
+
+   cat > /etc/NetworkManager/conf.d/99-no-igbvf.conf <<EOF
+   [keyfile]
+   unmanaged-devices=driver:igbvf
+   EOF
+
+2. Disable IP on the igb PF connections (keep the interfaces UP for
+   bridging, but with no DHCP lease):
+
+.. code-block:: bash
+
+   # Identify the NM connections for the igb PFs (NOT the virtio management NIC)
+   nmcli -t -f NAME,DEVICE connection show
+
+   # For each igb PF connection:
+   nmcli connection modify "<igb-pf-connection>" ipv4.method disabled ipv6.method disabled
+
+3. Reload NetworkManager:
+
+.. code-block:: bash
+
+   nmcli general reload
+
+L2 guest disk image
+...................
+
+Use ``virt-customize`` to add the igbvf unmanaged config to the guest
+image (offline, before any test run):
+
+.. code-block:: bash
+
+   virt-customize -a /srv/migration/rhel10.qcow2 \
+     --write /etc/NetworkManager/conf.d/99-no-igbvf.conf:'[keyfile]
+   unmanaged-devices=driver:igbvf'
+
+Network diagram
+^^^^^^^^^^^^^^^
+
+The diagram below shows the nested setup where the source and
+destination hosts are themselves VMs (L1) running on a physical
+host (L0) that emulates the igb NIC::
+
+  ┌────────────────────────────────────────────────────────────────────────────┐
+  │  L0: physical host                                                         │
+  │                                                                            │
+  │  virbr0  192.168.199.1/24                                                  │
+  │  ├── NFS server: /srv/migration                                            │
+  │  └── iperf3 client: iperf3 -c 192.168.199.200 -t 60 -i 1                   │
+  │      │                                                                     │
+  │      │  L0 virbr0 bridge (192.168.199.0/24)                                │
+  │  ────┼──────────┬──────────────────┬──────────────────────────────         │
+  │      │          │                  │                                       │
+  │      │     ┌────┴────┐        ┌────┴────┐                                  │
+  │      │     │ virtio  │        │ emulated│                                  │
+  │      │     │c0:ff:ee:│        │  igb PF │    L0 QEMU (vm6)                 │
+  │      │     │ :00:06  │        │ + igbvf │    tracks DMA dirty pages        │
+  │      │     └────┬────┘        └────┬────┘                                  │
+  │      │          │                  │                                       │
+  │  ┌───┼──────────┼──────────────────┼──────────────────────────────────┐    │
+  │  │   │  L1: vm6 (source)           │                                  │    │
+  │  │   │  enp1s0: 192.168.199.6      │                                  │    │
+  │  │   │  (management)               │                                  │    │
+  │  │   │                        enp8s0 (igb PF, no IP)                  │    │
+  │  │   │                             │                                  │    │
+  │  │   │                        igb VF0 ──► igb-vfio-pci (VFIO)         │    │
+  │  │   │                             │      dirty_sync → L0 igbvf       │    │
+  │  │   │                             │                                  │    │
+  │  │   │   virbr0                    │ VFIO passthrough                 │    │
+  │  │   │   192.168.200.1/24          │                                  │    │
+  │  │   │       │                     │                                  │    │
+  │  │   │  ┌────┼─────────────────────┼───────────────────────────┐      │    │
+  │  │   │  │    │  L2: rhel10 guest   │                           │      │    │
+  │  │   │  │    │                     │                           │      │    │
+  │  │   │  │  virtio NIC           igb VF (enp7s0)                │      │    │
+  │  │   │  │  192.168.200.130/24   192.168.199.200/24             │      │    │
+  │  │   │  │  (SSH login)          (iperf3 data path)             │      │    │
+  │  │   │  │                          │                           │      │    │
+  │  │   │  │            iperf3 -s -D  │ (listens on 0.0.0.0)      │      │    │
+  │  │   │  └──────────────────────────┼───────────────────────────┘      │    │
+  │  │   │                             │                                  │    │
+  │  │   │  virsh migrate --live ──────┼──────────────────► vm7           │    │
+  │  │   │                             │                                  │    │
+  │  └───┼─────────────────────────────┼──────────────────────────────────┘    │
+  │      │                             │                                       │
+  │      │          iperf3 traffic     │                                       │
+  │      └─────────────────────────────┘                                       │
+  │                                                                            │
+  │  ────────────────────────────────────────────────────────────────          │
+  │      │                  │                                                  │
+  │      │     ┌────────┐   │   ┌─────────┐                                    │
+  │      │     │ virtio │   │   │emulated │    L0 QEMU (vm7)                   │
+  │      │     │c0:ff:ee│   │   │ igb PF  │                                    │
+  │      │     │ :00:07 │   │   │ + igbvf │                                    │
+  │      │     └────┬───┘   │   └────┬────┘                                    │
+  │  ┌──────────────┼───────┼────────┼────────────────────────────────────┐    │
+  │  │   L1: vm7 (destination)       │                                    │    │
+  │  │   enp1s0: 192.168.199.7       │                                    │    │
+  │  │   (management)           enp8s0 (igb PF, no IP)                    │    │
+  │  │                               │                                    │    │
+  │  │                          igb VF0 ──► igb-vfio-pci (VFIO)           │    │
+  │  │                               │                                    │    │
+  │  │   virbr0                      │ VFIO passthrough                   │    │
+  │  │   192.168.200.1/24            │                                    │    │
+  │  │       │                       │                                    │    │
+  │  │  ┌────┼───────────────────────┼────────────────────────────┐       │    │
+  │  │  │    │  L2: rhel10 (after migration)                      │       │    │
+  │  │  │    │                       │                            │       │    │
+  │  │  │  virtio NIC             igb VF (enp7s0)                 │       │    │
+  │  │  │  192.168.200.130/24     192.168.199.200/24              │       │    │
+  │  │  │                            │                            │       │    │
+  │  │  │              iperf3 -s -D  │ (connection survives)      │       │    │
+  │  │  └────────────────────────────┼────────────────────────────┘       │    │
+  │  └───────────────────────────────┼────────────────────────────────────┘    │
+  │                                  │                                         │
+  │      iperf3 traffic resumes ─────┘                                         │
+  │      (same IP, same MAC, same L2 segment → transparent to client)          │
+  └────────────────────────────────────────────────────────────────────────────┘
-- 
2.55.0


