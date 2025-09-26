Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB7FCAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v291e-0005yP-Ty; Fri, 26 Sep 2025 10:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291T-0005wG-0U
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291O-0004Xv-KF
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1jLoQvPwEqkL0DhrzoiVyrFe5K823jaGAum5ZB3o2C4=;
 b=GrRWol6xhB6dXPXE+1dq2tIdmry88PT3SsapIpoEl9tyaJDpQ4om+Dmw/8GYXJEjqMXkmL
 AENdbnwt7ZKC4V2qyFqjgQQjm9na5NZ8Yw3+30BLsxBqoBao66nwtP5uS8Wq3Ek/3I9V4k
 emQwq1YLpIgM5uk0b+LgWnor81YMTj0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-wOiQ214_NPGOgp8pGQ-Qgw-1; Fri,
 26 Sep 2025 10:01:51 -0400
X-MC-Unique: wOiQ214_NPGOgp8pGQ-Qgw-1
X-Mimecast-MFC-AGG-ID: wOiQ214_NPGOgp8pGQ-Qgw_1758895310
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D85A119560B0; Fri, 26 Sep 2025 14:01:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 183161956095; Fri, 26 Sep 2025 14:01:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/32] Encode object type security status in code
Date: Fri, 26 Sep 2025 15:01:11 +0100
Message-ID: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

Our docs/system/security.rst file loosely classifies code into that
applicable for 'virtualization' vs 'non-virtualization' use cases.
Only code relevant to the former group is eligible for security
bug handling. Peter's recent proposal pointed out that we are
increasingly hitting the limits of such a crude classification

Michael suggested that with the increased complexity, docs are not
going to be an effective way to convey the information, and we
need to re-consider embedding this info in code.  This also allows
users to validate a configuration's security status when starting
a guest, or modifying a running guest.

This series is an attempt to start the embedding process.

Probably I should split in multiple series. One introducing the
overall framework, and then multiple series doing type annotations,
as the latter really need to be CC'd to maintainers, but the CC
list would be way too huge on this combined series. At least this
combined series shows what the real world implictions of this code
approach will be though.


It starts with QOM, adding a "bool secure" property to the
TypeInfo struct, which get turned into a flag on the Type
struct. This enables querying any ObjectClass to ask whether or
not it is declared secure.

By only using a single boolean flag, at runtime we are unable
to distinguish between "marked insecure" and "no decision,
implicitly insecure". As such, all our existing code is
initially considered insecure, except for that which gets
explicit annotation.

The "-compat" argument gains a new parameter

  * insecure-types=accept|reject|warn

    The default 'accept' preserves historical behaviour of
    anything being permissible. The other two options both
    identify use of types that are not explicitly marked
    as secure.

The code annotations are useful immediately, but to make the
new -compat switch useful, we need to annotate as much as is
possible. This series makes a strong attempt to do that across
a large subset of the codebase. My guidance was to mark enough
as being 'secure', that a downstream RHEL build of QEMU would
have explicit anntation of most of its devices, with most being
secure given they target virtualization use cases.

This annotation is 90% complete for the x86 target, but more
work is needed to finish it and then address the arch specific
devices for arm, ppc, s390.

Example: TCG is explicitly insecure, KVM is explicitly secure:

  $ qemu-system-x86_64 -display none -compat insecure-types=reject -accel tcg
  qemu-system-x86_64: -accel tcg: Type 'tcg-accel' does not provide a security boundary to protect against untrusted workloads
  $ qemu-system-x86_64 -display none -compat insecure-types=reject -accel kvm
  ^C

Example: isapc machine type is explicitly insecure

  $ qemu-system-x86_64 -display none -compat insecure-types=reject -machine isapc
  qemu-system-x86_64: Type 'isapc-machine' does not provide a security boundary to protect against untrusted workloads

Example: checks also apply in HMP, ne2k_pci is insecure

  $ ./build/qemu-system-x86_64 -display none -compat insecure-types=reject -monitor stdio -accel kvm
  QEMU 10.1.50 monitor - type 'help' for more information
  (qemu) device_add ne2k_pci
  Error: Type 'ne2k_pci' does not provide a security boundary to protect against untrusted workloads

Example: checks also apply in QMP:

  $ ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 -display none -compat insecure-types=reject -accel kvm
  Welcome to the QMP low-level shell!
  Connected
  (QEMU) device_add driver=ne2k_oci
  {"error": {"class": "GenericError", "desc": "Type 'ne2k_pci' does not provide a security boundary to protect against untrusted workloads"}}
  (QEMU) device_add driver=virtio-net
  {"return": {}}

Changes in v2:

 * Report security status in qom-list-types
 * Allow qom-list-types to filter on secure types
 * Remove 'bool insecure' on TypeInfo, assume that no specified
   data is equivalent to '.secure = false'
 * Annotate a massive number of object types

Daniel P. Berrangé (32):
  qom: replace 'abstract' with 'flags'
  qom: add tracking of security state of object types
  qapi: add 'insecure-types' option for -compat argument
  system: check security for accelerator types
  system: report acclerator security status in help output
  system: check security for machine types
  system: report machine security status in help output
  system: check security of device types
  system: report device security status in help output
  hw/core: report security status in query-machines
  qom: report & filter on security status in qom-list-types
  docs: expand security docs with info about security status
  machine: add helpers for declaring secure/insecure machine types
  hw: mark x86, s390, ppc, arm versioned machine types as secure
  hw: declare Xen & microvm machines as secure, isapc as insecure
  hw/core: declare 'none' machine to be insecure
  accel: mark kvm, xen & hvf as secure; tcg & qtest as insecure
  hw: mark all virtio PCI devices as secure
  hw: mark all virtio CCW devices as secure
  hw: mark all vhost devices a secure
  hw: mark all remaining virtio object types as secure
  hw/vfio: mark all VFIO object classes as secure
  hw/xen: mark all Xen related object types as being secure
  hw/net: mark most non-virtio NICs as insecure
  hw/usb: mark most USB devices/hosts as secure
  hw/watchdog: mark some watchdog devices as secure
  hw/scsi: mark most SCSI controllers as insecure / devices as secure
  hw/ide: mark ICH9 and ide-hd/ide-cd as secure
  hw: mark test/demo devices as insecure
  hw: define most common PCI types as secure
  hw/pci-host: define some PCI hosts as secure
  hw/display: mark most display adapters as insecure

 accel/accel-common.c                 |  1 +
 accel/accel-system.c                 |  1 +
 accel/accel-target.c                 |  1 +
 accel/hvf/hvf-accel-ops.c            |  1 +
 accel/hvf/hvf-all.c                  |  1 +
 accel/kvm/kvm-accel-ops.c            |  1 +
 accel/kvm/kvm-all.c                  |  1 +
 accel/qtest/qtest.c                  |  2 ++
 accel/tcg/tcg-accel-ops.c            |  1 +
 accel/tcg/tcg-all.c                  |  1 +
 accel/xen/xen-all.c                  |  2 ++
 docs/system/security.rst             | 43 ++++++++++++++++++++++++++++
 hw/9pfs/virtio-9p-device.c           |  1 +
 hw/arm/virt.c                        |  1 +
 hw/arm/xen-pvh.c                     |  1 +
 hw/audio/virtio-snd.c                |  1 +
 hw/block/vhost-user-blk.c            |  1 +
 hw/block/virtio-blk.c                |  1 +
 hw/block/xen-block.c                 |  3 ++
 hw/char/virtio-console.c             |  2 ++
 hw/char/virtio-serial-bus.c          |  3 ++
 hw/char/xen_console.c                |  1 +
 hw/core/machine-qmp-cmds.c           |  1 +
 hw/core/null-machine.c               |  2 +-
 hw/display/artist.c                  |  1 +
 hw/display/ati.c                     |  1 +
 hw/display/bcm2835_fb.c              |  1 +
 hw/display/bochs-display.c           |  1 +
 hw/display/cg3.c                     |  1 +
 hw/display/cirrus_vga.c              |  1 +
 hw/display/cirrus_vga_isa.c          |  1 +
 hw/display/dm163.c                   |  1 +
 hw/display/dpcd.c                    |  1 +
 hw/display/exynos4210_fimd.c         |  1 +
 hw/display/g364fb.c                  |  1 +
 hw/display/i2c-ddc.c                 |  3 +-
 hw/display/jazz_led.c                |  1 +
 hw/display/macfb.c                   |  2 ++
 hw/display/next-fb.c                 |  1 +
 hw/display/pl110.c                   |  3 ++
 hw/display/qxl.c                     |  4 +++
 hw/display/ramfb-standalone.c        |  1 +
 hw/display/sii9022.c                 |  1 +
 hw/display/sm501.c                   |  1 +
 hw/display/ssd0303.c                 |  1 +
 hw/display/ssd0323.c                 |  1 +
 hw/display/tcx.c                     |  1 +
 hw/display/vga-isa.c                 |  1 +
 hw/display/vga-mmio.c                |  1 +
 hw/display/vga-pci.c                 |  3 ++
 hw/display/vhost-user-gpu.c          |  1 +
 hw/display/virtio-gpu-base.c         |  3 +-
 hw/display/virtio-gpu-gl.c           |  1 +
 hw/display/virtio-gpu-pci-rutabaga.c |  1 +
 hw/display/virtio-gpu-pci.c          |  3 +-
 hw/display/virtio-gpu-rutabaga.c     |  1 +
 hw/display/virtio-gpu.c              |  1 +
 hw/display/vmware_vga.c              |  1 +
 hw/display/xlnx_dp.c                 |  1 +
 hw/hyperv/hyperv_testdev.c           |  1 +
 hw/i386/isapc.c                      |  4 +--
 hw/i386/microvm.c                    |  1 +
 hw/i386/pc_piix.c                    |  8 +++---
 hw/i386/xen/xen-pvh.c                |  1 +
 hw/i386/xen/xen_platform.c           |  1 +
 hw/i386/xen/xen_pvdevice.c           |  1 +
 hw/ide/ich.c                         |  1 +
 hw/ide/ide-dev.c                     |  3 ++
 hw/input/virtio-input-hid.c          |  5 ++++
 hw/input/virtio-input-host.c         |  1 +
 hw/input/virtio-input.c              |  1 +
 hw/misc/edu.c                        |  1 +
 hw/misc/pc-testdev.c                 |  1 +
 hw/misc/pci-testdev.c                |  1 +
 hw/net/allwinner-sun8i-emac.c        |  1 +
 hw/net/allwinner_emac.c              |  3 +-
 hw/net/cadence_gem.c                 |  1 +
 hw/net/can/can_kvaser_pci.c          |  1 +
 hw/net/can/can_mioe3680_pci.c        |  1 +
 hw/net/can/can_pcm3680_pci.c         |  1 +
 hw/net/can/ctucan_pci.c              |  1 +
 hw/net/can/xlnx-versal-canfd.c       |  1 +
 hw/net/can/xlnx-zynqmp-can.c         |  1 +
 hw/net/dp8393x.c                     |  1 +
 hw/net/e1000.c                       |  1 +
 hw/net/e1000e.c                      |  1 +
 hw/net/eepro100.c                    |  1 +
 hw/net/fsl_etsec/etsec.c             |  1 +
 hw/net/ftgmac100.c                   |  1 +
 hw/net/igb.c                         |  1 +
 hw/net/igbvf.c                       |  1 +
 hw/net/imx_fec.c                     |  2 ++
 hw/net/lan9118.c                     |  1 +
 hw/net/lan9118_phy.c                 |  1 +
 hw/net/lance.c                       |  1 +
 hw/net/lasi_i82596.c                 |  1 +
 hw/net/mcf_fec.c                     |  1 +
 hw/net/msf2-emac.c                   |  1 +
 hw/net/mv88w8618_eth.c               |  1 +
 hw/net/ne2000-isa.c                  |  1 +
 hw/net/ne2000-pci.c                  |  1 +
 hw/net/npcm7xx_emc.c                 |  1 +
 hw/net/npcm_gmac.c                   |  1 +
 hw/net/npcm_pcs.c                    |  1 +
 hw/net/opencores_eth.c               |  1 +
 hw/net/pcnet-pci.c                   |  1 +
 hw/net/rocker/rocker.c               |  1 +
 hw/net/rtl8139.c                     |  1 +
 hw/net/smc91c111.c                   |  1 +
 hw/net/spapr_llan.c                  |  1 +
 hw/net/stellaris_enet.c              |  1 +
 hw/net/sungem.c                      |  1 +
 hw/net/sunhme.c                      |  1 +
 hw/net/tulip.c                       |  1 +
 hw/net/virtio-net.c                  |  1 +
 hw/net/vmxnet3.c                     |  1 +
 hw/net/xen_nic.c                     |  1 +
 hw/net/xgmac.c                       |  1 +
 hw/net/xilinx_axienet.c              |  1 +
 hw/net/xilinx_ethlite.c              |  1 +
 hw/pci-bridge/cxl_downstream.c       |  1 +
 hw/pci-bridge/cxl_root_port.c        |  1 +
 hw/pci-bridge/cxl_upstream.c         |  1 +
 hw/pci-bridge/gen_pcie_root_port.c   |  1 +
 hw/pci-bridge/i82801b11.c            |  1 +
 hw/pci-bridge/ioh3420.c              |  1 +
 hw/pci-bridge/pci_bridge_dev.c       |  2 ++
 hw/pci-bridge/pci_expander_bridge.c  |  8 ++++++
 hw/pci-bridge/pcie_pci_bridge.c      |  1 +
 hw/pci-bridge/pcie_root_port.c       |  1 +
 hw/pci-bridge/simba.c                |  1 +
 hw/pci-bridge/xio3130_downstream.c   |  1 +
 hw/pci-bridge/xio3130_upstream.c     |  1 +
 hw/pci-host/articia.c                |  3 ++
 hw/pci-host/astro.c                  |  3 ++
 hw/pci-host/bonito.c                 |  2 ++
 hw/pci-host/designware.c             |  3 ++
 hw/pci-host/dino.c                   |  1 +
 hw/pci-host/fsl_imx8m_phy.c          |  1 +
 hw/pci-host/gpex.c                   |  2 ++
 hw/pci-host/grackle.c                |  2 ++
 hw/pci-host/gt64120.c                |  2 ++
 hw/pci-host/i440fx.c                 |  2 ++
 hw/pci-host/mv64361.c                |  1 +
 hw/pci-host/pnv_phb.c                |  2 ++
 hw/pci-host/pnv_phb3.c               |  3 ++
 hw/pci-host/pnv_phb3_msi.c           |  1 +
 hw/pci-host/pnv_phb3_pbcq.c          |  1 +
 hw/pci-host/pnv_phb4.c               |  4 +++
 hw/pci-host/pnv_phb4_pec.c           |  2 ++
 hw/pci-host/ppc440_pcix.c            |  1 +
 hw/pci-host/ppc4xx_pci.c             |  2 ++
 hw/pci-host/ppce500.c                |  2 ++
 hw/pci-host/q35.c                    |  2 ++
 hw/pci-host/raven.c                  |  2 ++
 hw/pci-host/remote.c                 |  1 +
 hw/pci-host/sabre.c                  |  2 ++
 hw/pci-host/sh_pci.c                 |  2 ++
 hw/pci-host/uninorth.c               |  2 ++
 hw/pci-host/versatile.c              |  3 ++
 hw/pci-host/xen_igd_pt.c             |  1 +
 hw/pci-host/xilinx-pcie.c            |  1 +
 hw/pci/pci.c                         |  7 +++++
 hw/pci/pci_bridge.c                  |  1 +
 hw/pci/pci_host.c                    |  1 +
 hw/pci/pcie_host.c                   |  1 +
 hw/pci/pcie_port.c                   |  1 +
 hw/ppc/spapr.c                       |  1 +
 hw/s390x/s390-virtio-ccw.c           |  1 +
 hw/s390x/vhost-scsi-ccw.c            |  1 +
 hw/s390x/vhost-user-fs-ccw.c         |  1 +
 hw/s390x/vhost-vsock-ccw.c           |  1 +
 hw/s390x/virtio-ccw-9p.c             |  1 +
 hw/s390x/virtio-ccw-balloon.c        |  1 +
 hw/s390x/virtio-ccw-blk.c            |  1 +
 hw/s390x/virtio-ccw-crypto.c         |  1 +
 hw/s390x/virtio-ccw-gpu.c            |  1 +
 hw/s390x/virtio-ccw-input.c          |  5 ++++
 hw/s390x/virtio-ccw-md.c             |  1 +
 hw/s390x/virtio-ccw-mem.c            |  1 +
 hw/s390x/virtio-ccw-net.c            |  1 +
 hw/s390x/virtio-ccw-rng.c            |  1 +
 hw/s390x/virtio-ccw-scsi.c           |  1 +
 hw/s390x/virtio-ccw-serial.c         |  1 +
 hw/s390x/virtio-ccw.c                |  1 +
 hw/scsi/esp-pci.c                    |  2 ++
 hw/scsi/esp.c                        |  2 ++
 hw/scsi/lsi53c895a.c                 |  2 ++
 hw/scsi/megasas.c                    |  2 ++
 hw/scsi/mptsas.c                     |  1 +
 hw/scsi/scsi-disk.c                  |  4 +++
 hw/scsi/scsi-generic.c               |  1 +
 hw/scsi/spapr_vscsi.c                |  1 +
 hw/scsi/vhost-scsi-common.c          |  1 +
 hw/scsi/vhost-scsi.c                 |  1 +
 hw/scsi/vhost-user-scsi.c            |  1 +
 hw/scsi/virtio-scsi.c                |  2 ++
 hw/scsi/vmw_pvscsi.c                 |  1 +
 hw/usb/dev-audio.c                   |  1 +
 hw/usb/dev-hid.c                     |  4 +++
 hw/usb/dev-hub.c                     |  1 +
 hw/usb/dev-mtp.c                     |  1 +
 hw/usb/dev-network.c                 |  1 +
 hw/usb/dev-serial.c                  |  3 ++
 hw/usb/dev-smartcard-reader.c        |  3 ++
 hw/usb/dev-storage-bot.c             |  1 +
 hw/usb/dev-storage-classic.c         |  1 +
 hw/usb/dev-storage.c                 |  1 +
 hw/usb/dev-uas.c                     |  1 +
 hw/usb/dev-wacom.c                   |  1 +
 hw/usb/hcd-dwc2.c                    |  1 +
 hw/usb/hcd-dwc3.c                    |  1 +
 hw/usb/hcd-ehci-pci.c                |  2 ++
 hw/usb/hcd-ehci-sysbus.c             |  8 ++++++
 hw/usb/hcd-ohci-pci.c                |  1 +
 hw/usb/hcd-ohci-sysbus.c             |  1 +
 hw/usb/hcd-uhci.c                    |  2 ++
 hw/usb/hcd-xhci-nec.c                |  1 +
 hw/usb/hcd-xhci-pci.c                |  2 ++
 hw/usb/hcd-xhci-sysbus.c             |  3 +-
 hw/usb/hcd-xhci.c                    |  1 +
 hw/usb/host-libusb.c                 |  1 +
 hw/usb/redirect.c                    |  1 +
 hw/vfio/ap.c                         |  1 +
 hw/vfio/ccw.c                        |  1 +
 hw/vfio/container.c                  |  2 ++
 hw/vfio/igd.c                        |  1 +
 hw/vfio/iommufd.c                    |  2 ++
 hw/vfio/pci.c                        |  3 ++
 hw/vfio/spapr.c                      |  1 +
 hw/virtio/vdpa-dev.c                 |  1 +
 hw/virtio/vhost-user-base.c          |  3 +-
 hw/virtio/vhost-user-device.c        |  1 +
 hw/virtio/vhost-user-fs.c            |  1 +
 hw/virtio/vhost-user-gpio.c          |  1 +
 hw/virtio/vhost-user-i2c.c           |  1 +
 hw/virtio/vhost-user-input.c         |  1 +
 hw/virtio/vhost-user-rng.c           |  1 +
 hw/virtio/vhost-user-scmi.c          |  1 +
 hw/virtio/vhost-user-snd.c           |  1 +
 hw/virtio/vhost-user-vsock.c         |  1 +
 hw/virtio/vhost-vsock-common.c       |  1 +
 hw/virtio/vhost-vsock.c              |  1 +
 hw/virtio/virtio-balloon.c           |  1 +
 hw/virtio/virtio-bus.c               |  1 +
 hw/virtio/virtio-crypto.c            |  1 +
 hw/virtio/virtio-input-pci.c         |  2 ++
 hw/virtio/virtio-iommu.c             |  2 ++
 hw/virtio/virtio-md-pci.c            |  1 +
 hw/virtio/virtio-mem.c               |  1 +
 hw/virtio/virtio-mmio.c              |  2 ++
 hw/virtio/virtio-nsm.c               |  1 +
 hw/virtio/virtio-pci.c               |  3 ++
 hw/virtio/virtio-pmem.c              |  1 +
 hw/virtio/virtio-rng.c               |  1 +
 hw/watchdog/allwinner-wdt.c          |  3 ++
 hw/watchdog/cmsdk-apb-watchdog.c     |  1 +
 hw/watchdog/sbsa_gwdt.c              |  1 +
 hw/watchdog/spapr_watchdog.c         |  1 +
 hw/watchdog/wdt_aspeed.c             |  6 ++++
 hw/watchdog/wdt_diag288.c            |  1 +
 hw/watchdog/wdt_i6300esb.c           |  1 +
 hw/watchdog/wdt_ib700.c              |  1 +
 hw/watchdog/wdt_imx2.c               |  1 +
 hw/xen/xen-bus.c                     |  3 ++
 hw/xen/xen-legacy-backend.c          |  3 ++
 hw/xen/xen-pvh-common.c              |  1 +
 hw/xen/xen_pt.c                      |  1 +
 hw/xenpv/xen_machine_pv.c            |  2 +-
 include/hw/boards.h                  | 12 +++++++-
 include/hw/i386/pc.h                 | 14 ++++++++-
 include/qapi/compat-policy.h         |  5 ++++
 include/qom/object.h                 | 13 +++++++++
 qapi/compat.json                     | 24 +++++++++++++++-
 qapi/machine.json                    |  8 +++++-
 qapi/qapi-util.c                     | 30 +++++++++++++++++++
 qapi/qom.json                        | 10 +++++--
 qom/object.c                         | 30 ++++++++++++++-----
 qom/qom-qmp-cmds.c                   | 30 +++++++++++++++----
 system/qdev-monitor.c                | 12 ++++++++
 system/vl.c                          | 35 ++++++++++++++++++----
 281 files changed, 632 insertions(+), 38 deletions(-)

-- 
2.50.1


