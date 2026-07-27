Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5859EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4M-0003AZ-S7; Mon, 27 Jul 2026 01:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE47-00033M-Fj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE45-0003Sh-Hx
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R85MlKBZ5DmlW2amPhm6ylrCY7IGL8J/1fhAercVnCU=;
 b=Oc1DJjdsf2odXagwCrfqFl7RKS3tE+eW4cySs+VfHDo/cdRWsv4zUoySFapY5EN7Cw0f9f
 nNHU0H2jD4d2gop3WVyd3BjsjclsxuPZ05Y6Sq1egHeJqCZiITluH66q2PBHydXw8olX7q
 V7/Ko3rGcOnXtlJiJpbn5R3jGoh2gwY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-ZoIWaeFmPQy4F-IcS0KtKg-1; Mon,
 27 Jul 2026 01:39:44 -0400
X-MC-Unique: ZoIWaeFmPQy4F-IcS0KtKg-1
X-Mimecast-MFC-AGG-ID: ZoIWaeFmPQy4F-IcS0KtKg_1785130783
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C79B9180060F; Mon, 27 Jul 2026 05:39:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86FE21956088; Mon, 27 Jul 2026 05:39:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 00/11] igb: Add experimental VF live migration support
Date: Mon, 27 Jul 2026 07:39:24 +0200
Message-ID: <20260727053935.1392269-1-clg@redhat.com>
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

Hello,

Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
growing requirement, but real hardware with migration support is
scarce and hard to debug. An emulated device provides a fully
controlled testbed for developing and validating the entire software
stack - vfio-pci variant drivers, VFIO core migration v2 framework,
QEMU, libvirt - and for tuning complex migration policies such as
downtime convergence. It also serves as an educational reference for
understanding VFIO migration end-to-end, from device state
serialization to dirty page tracking.

This series adds an experimental VF live migration interface to the
emulated igb (82576) device. It enables a vfio-pci variant driver
(igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
protocol with stop-copy and pre-copy support.

The target scenario is nested virtualization:

  L0 QEMU (these patches)
    igb PF with x-vf-migration=on
    └── VFs with migration BAR + vendor cap

  L1 kernel
    igb-vfio-pci variant driver [1]
    translates VFIO migration v2 ioctls → BAR2 MMIO

  L1 QEMU (stock, unmodified)
    vfio-pci device model, standard migration fd

  L2 guest
    standard igbvf driver, unaware of migration

The L1 QEMU is completely unmodified -- it sees a standard VFIO
migratable device and uses the normal migration fd path.

* Design

The migration interface is exposed through a hidden 64KB PCI BAR
(BAR2) on each VF, discovered via a vendor-specific PCI capability
("MIGB", PCI_CAP_ID_VNDR). The BAR exposes a register-based state
machine that mirrors VFIO migration states (RUNNING, STOP, STOP_COPY,
RESUMING, PRE_COPY).

Device state is serialized as a versioned blob of per-VF register
(offset, value) pairs covering control, interrupt, RX/TX queue,
receive address (RA/RA2), etc. plus TX context descriptors and
VFRE/VFTE enable bits. The blob is transferred via DMA through the PF
device, since VFIO owns the VF's IOMMU domain and the variant driver
maps its DMA buffers through the PF.

Dirty page tracking is implemented with per-range bitmaps maintained
in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
descriptor writeback) are instrumented to record touched pages. The
variant driver registers tracked IOVA ranges and queries dirty bitmaps
through a DMA shared buffer, using a single MMIO doorbell
(DIRTY_CTRL=QUERY) per iteration.

* Caveats

Patch 1 introduces PCI_BASE_ADDRESS_MEM_ALWAYS_ON, a QEMU-internal
BAR flag that keeps the migration BAR mapped even after VFIO's
Function Level Reset clears PCI_COMMAND_MEMORY.

The x-vf-migration property is experimental (x- prefix, default off)
and the migration BAR register interface may change.

The dirty bitmaps are maintained inside the device, which is not
realistic for discrete NICs without on-chip DRAM.

* Testing

The target scenario is nested virtualization: L0 runs QEMU with an
igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
and an unmodified QEMU, and L2 runs a standard igbvf driver.

Migration under iperf3 load works correctly: dirty page tracking
converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
STOP_COPY), and STOP_COPY stays under 250ms.

* Todo/Ideas

  1. Add migration blocker when x-vf-migration=on (no VMState yet) or
     add VMState support for L0 migration (dirty bitmaps, tracking
     engines, migration BAR registers, stats)
     
  2. Add PRE_COPY match data validation (magic, version, caps)
  
  3. Support driver-provided DMA bitmaps per dirty range
     (DIRTY_RANGE_ADDR_LO/HI)
     
  4. Add QMP/HMP knobs for error injection and capability tuning:
  
    . Dirty rate throttling: artificial delay or rate limit on DMA
      dirty tracking to simulate different convergence scenarios
    . State blob size inflation: pad the migration blob to stress
      large-state transfers and test DATA_SIZE limits
    . Migration phase timing: expose per-VF counters for time spent
      in each state (PRE_COPY duration, STOP_COPY latency)
    . Hot page simulation: mark specific page ranges as always-dirty
      to test worst-case convergence
    . Error injection: force STATUS error codes, fail DMA transfers,
      corrupt state blobs, mask CAPS bits, etc.
      
  5. Add qtests for migration state machine transitions, dirty page
     tracking ?

* Credits

Alex Williamson suggested the overall approach: a hidden migration BAR
discovered via a vendor-specific PCI capability, the "vf-migration"
device property to gate the feature. Thanks for the ever ongoing
support and valuable discussions throughout these years.

* AI disclaimer

The lack of a migration-capable device has been a recurring pain point
for VFIO development over the years, and we hope this proposal
demonstrates the value of having one.

Claude was used to analyze the IGB PF and VF internal state and
identify the pain points of a working live migration of such devices.
The generated code served as a starting point but *significant* time
was then spent cleaning up, reworking, and shaping it into a clear,
reviewable proposal. As QEMU does not yet accept AI-assisted
contributions, this series is submitted as an RFC.

Thanks,

C.

[1] https://github.com/legoater/vfio-pci-extras

Cédric Le Goater (11):
  pci: Add PCI_BASE_ADDRESS_MEM_ALWAYS_ON BAR flag
  igb: Add x-vf-migration property and vendor-specific capability for
    IGBVF
  igb: Add migration BAR with state machine
  igb: Add VF state serialization for live migration
  igb: Add VF post-load fixups for live migration
  igb: Add dirty page tracking for IGBVF migration
  igb: Quiesce VFs on STOP and include PF enable state in migration blob
  igb: Fix post-migration RX ring deadlock
  igb: Send RARP after VF migration to update bridge FDB
  docs: Add igb VF migration testing setup guide
  igb: Add migration statistics registers to VF migration BAR

 MAINTAINERS                           |    6 +
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/igb-migration.rst |  313 +++++++
 docs/system/devices/igb.rst           |    6 +
 hw/net/igb_common.h                   |   11 +
 hw/net/igb_core.h                     |    8 +
 hw/net/igb_migration.h                |  201 +++++
 include/hw/pci/pci.h                  |    6 +
 hw/net/igb.c                          |   18 +
 hw/net/igb_core.c                     |  144 ++-
 hw/net/igb_migration.c                | 1194 +++++++++++++++++++++++++
 hw/net/igbvf.c                        |   29 +-
 hw/pci/pci.c                          |    6 +-
 hw/net/meson.build                    |    2 +-
 hw/net/trace-events                   |   20 +
 15 files changed, 1939 insertions(+), 26 deletions(-)
 create mode 100644 docs/system/devices/igb-migration.rst
 create mode 100644 hw/net/igb_migration.h
 create mode 100644 hw/net/igb_migration.c

-- 
2.55.0


