Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A1CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGudw-0005Ku-Nh; Wed, 14 Oct 2026 04:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudo-0005F2-CU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudi-0004Xc-1e
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QtREhvBBQ4dscZunZhcYUDj9CVPBjuyOQRVQuj57wpY=;
 b=Wlu1B3jkG0zyqL1c9QG4m+2i8Rozv5cW3o1p6xe9fD+OlBIuX3K+Y7Q4muzZHVSXhdN9df
 eyrGcbB4D5a6cqOQ0ygBl2CaA4DHcFw628qFMLzjLhcVhlj9li7XH7PUPntAH856Je1tq0
 SIuO4v+ML6wNET/meUL1avxlIdnYr8k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-MB-c0m9lMoG2yCXRTQ9xqw-1; Wed,
 14 Oct 2026 08:47:06 +0000
X-MC-Unique: MB-c0m9lMoG2yCXRTQ9xqw-1
X-Mimecast-MFC-AGG-ID: MB-c0m9lMoG2yCXRTQ9xqw_1791967624
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D1D418005A1; Wed, 14 Oct 2026 08:47:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD711800446; Wed, 14 Oct 2026 08:47:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 00/17] igb: Add experimental VF live migration support
Date: Wed, 14 Oct 2026 10:46:38 +0200
Message-ID: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

Live migration of VFIO-passthrough devices, SR-IOV VFs, vGPUs, is a
growing requirement, but real hardware with migration support is
scarce and hard to debug. An emulated device provides a fully
controlled testbed for developing and validating the entire software
stack, vfio-pci variant drivers, VFIO core migration v2 framework,
QEMU, libvirt, and for tuning complex migration policies such as
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
    └── VFs with migration DVSEC

  L1 kernel
    igb-vfio-pci variant driver [1]
    translates VFIO migration v2 ioctls → DVSEC config writes

  L1 QEMU (stock, unmodified)
    vfio-pci device model, standard migration fd

  L2 guest
    standard igbvf driver, unaware of migration

The L1 QEMU is completely unmodified. It sees a standard VFIO
migratable device and uses the normal migration fd path.

* Design

The migration interface is exposed through a DVSEC (Designated
Vendor-Specific Extended Capability, PCIe cap id 0x23) at offset
0x160 in VF extended config space. The DVSEC uses a command doorbell
model; all commands are synchronous via PCI config space writes.

Device state is serialized as a versioned blob of per-VF register
(offset, value) pairs covering control, interrupt, RX/TX queue,
receive address (RA/RA2), etc. plus TX context descriptors and
VFRE/VFTE enable bits. The buffer address is a guest physical
address (GPA) written by the driver via virt_to_phys; the device
accesses guest RAM directly through the system address space.

Dirty page tracking is implemented with per-range bitmaps maintained
in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
descriptor writeback) are instrumented to record touched pages. The
variant driver registers tracked IOVA ranges and queries dirty bitmaps
through a shared buffer. Buffer structures include len, flags, and
reserved fields for future extensibility.

* Caveats

The x-vf-migration property is experimental (x- prefix, default off).

The current implementation maintains dirty bitmaps inside the device,
which is not realistic for discrete NICs without on-chip DRAM.

On load, MTA/UTA fixup merges missing source entries into the
destination but is not durable: the L1 PF driver zeroes and reprograms
these tables on any multicast update, and has no record of the
migrated VF's hashes. A proper fix requires QEMU to track per-VF
multicast hashes and restore them on load, either through a new DVSEC
command consumed by the variant driver or by injecting a VF mailbox
message to the L1 PF driver.

* Testing

The target scenario is nested virtualization: L0 runs QEMU with an
igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
and an unmodified QEMU, and L2 runs a standard igbvf driver.

Migration under iperf3 load works correctly: dirty page tracking
converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
STOP_COPY), and STOP_COPY stays under 250ms.

* Todo

  1. Add VMState support for L0 migration (dirty bitmaps, tracking
     engines, DVSEC registers, stats)
  2. Add PRE_COPY state transfer to validate device INIT data (magic,
     version, etc.)

* Ideas

  1. RX bandwidth throttle (x-mig-rx-limit, uint32, default 0)

     Return false from can_receive when the per-VF packet count in the
     current tracking interval exceeds the limit. Reduces DMA writes
     and dirty pages realistically.

  2. Migration phase timing (GET_STATS extension)

     Add per-VF timestamps: precopy_start_ns, stopcopy_start_ns,
     precopy_duration_ns, stopcopy_duration_ns,
     state_transition_count. Expose via GET_STATS.

  3. Hot page simulation (x-mig-hot-pages, uint32, default 0)

     Re-set the first N bitmap bits after each DIRTY_QUERY, simulating
     workloads with hot pages that prevent convergence.

  4. Error injection (x-mig-inject-error, uint32, default 0)

     One-shot error code injection before command dispatch. A separate
     x-mig-inject-dma-fail (bool) for persistent DMA failure testing.

* Credits

Alex Williamson suggested the overall approach of a variant driver
with the "x-vf-migration" device property to gate the feature. Thanks
for the ever ongoing support and valuable discussions throughout these
years.

* AI disclaimer

The lack of a migration-capable device has been a recurring pain point
for VFIO development over the years, and we hope this proposal
demonstrates the value of having one.

Claude was used to analyze the IGB PF and VF internal state and
identify the pain points of a working live migration of such devices.
The generated code served as a starting point but *significant* time
was then spent cleaning up, reworking, and shaping it into a clear,
reviewable IGB model extension.

Thanks,

C.

[1] https://github.com/legoater/vfio-pci-extras


* Changes since rfc-v2

  - DVSEC vendor ID: PCI_VENDOR_ID_INTEL -> PCI_VENDOR_ID_REDHAT_QUMRANET
  - Added migration blocker when VF migration is enabled  
  - Changed Initial VF state: RUNNING -> ERROR (driver must activate
    via SET_STATE)  
  - Dropped igbvf_mig_state_reset(), handled by driver
  - Extended and renumbered error codes 
  - Split monolithic VF state serialization into :
    . registers: dynamic register list, validated on load    
    . TX context descriptors
    . RA entries: pool-bit-aware, clear/restore, dry-run validation    
    . VLVF filters: pool-bit-aware clear/restore, dry-run validation,
      VFTA bit set on load      
    . MTA/UTA hash tables: save and fixup on load (merge missing
      entries into destination with warning)      
  - Save and restore effective VF interrupt masks (capture from
    PF aggregates EIMS/EIAC/EIAM, not PVT shadows)
  - Re-raise pending VF interrupt causes on unquiesce
  - Dropped VF number relocation support 
  - LOAD: data size from CTRL arg field, validated before buffer read
  - Clear VFLRE before state restore on destination
  - Added trace events
  - Added igb VF migration tests (DVSEC discovery, state machine,
    save/load roundtrip, blob validation, error codes, dirty tracking)

* Changes since rfc-v1

  - Migration BAR replaced with DVSEC at offset 0x160 (no BAR needed)
  - Wire-format structs (IgbMigBlob, IgbMigRegPair, IgbMigTxCtx)
    replace raw pointer arithmetic and memcpy
  - RA entries separated from fixed regs, scanned by pool bit
  - VFN relocation support (offset remapping + RA pool bit swap)
  - GPA buffer (address_space_read/write) replaces PCI DMA through PF
  - State blob validation on load (magic, version, error codes)
  - NEED_WORDS macro and igb_vf_offset_valid removed
  - Error codes renumbered: removed BAD_VFN, added UNK_CMD (1-11)

  Reported by Akihiko Odaki:

  - propagate_irqs: clear VF bits before OR (EIMS/EIAC/EIAM)
  - propagate_ivar: clear IVAR entry when source VTIVAR is invalid
  - rearm_irqs: restore actual PVTEICR causes, not all three
  - Dirty bitmap allocation uses BITS_TO_LONGS (heap corruption fix)
  - Dirty query validates range before g_malloc0 (memory exhaustion)
  - Dirty bits cleared only after successful bitmap DMA write
  - Dirty query buffer uses struct offsets (layout mismatch fix)
  - Load path: register offsets validated against VF whitelist
  - VMBMEM (mailbox payload) documented as transient, not serialized
  - dma_writes counter: consistently uint64_t
  - Dirty range_size: consistently uint64_t (was truncated to 32 bits)
  - ERROR->STOP: quiesce VF (clear VFRE/VFTE) on transition
  - rearm_irqs: runs on re || te, not just re (TX-only VF fix)
  - Stats DMA-written atomically via GET_STATS (no split MMIO tear)
  - Bisectability: DVSEC + state machine introduced together
  - Removed NAPI reference and "===" comment decoration

Cédric Le Goater (17):
  igb: Add x-vf-migration property and DVSEC extended capability
  igb: Add migration blocker when VF migration is enabled
  igb: Add migration state machine via extended config space
  igb: Add VF state serialization for live migration
  igb: Add VF register state serialization
  igb: Add VF post-load fixups for live migration
  igb: Add VF TX context state serialization
  igb: Add VF RA entries state serialization
  igb: Add VF VLAN filters (VLVF) serialization
  igb: Save MTA/UTA hash tables and fixup on VF migration load
  igb: Add dirty page tracking for IGBVF migration
  igb: Quiesce VFs on STOP and include PF enable state in migration
  igb: Save and restore effective VF interrupt masks for migration
  igb: Re-raise pending VF interrupt causes on unquiesce
  igb: Add dirty page tracking statistics
  docs: Add igb VF migration testing setup guide
  tests/qtest: Add igb VF migration tests

 MAINTAINERS                           |    7 +
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/igb-migration.rst |  410 +++++++
 docs/system/devices/igb.rst           |    6 +
 hw/net/igb_common.h                   |   17 +
 hw/net/igb_core.h                     |   10 +
 hw/net/igb_migration.h                |  193 +++
 hw/net/igb.c                          |    7 +
 hw/net/igb_core.c                     |   93 +-
 hw/net/igb_migration.c                | 1602 +++++++++++++++++++++++++
 hw/net/igbvf.c                        |   56 +-
 tests/qtest/igb-migration-test.c      |  921 ++++++++++++++
 hw/net/meson.build                    |    2 +-
 hw/net/trace-events                   |   16 +
 tests/qtest/meson.build               |    1 +
 15 files changed, 3318 insertions(+), 24 deletions(-)
 create mode 100644 docs/system/devices/igb-migration.rst
 create mode 100644 hw/net/igb_migration.h
 create mode 100644 hw/net/igb_migration.c
 create mode 100644 tests/qtest/igb-migration-test.c

-- 
2.56.0


