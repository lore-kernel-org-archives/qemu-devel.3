Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6A606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QsOULN5D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT55U-0003kp-Vm; Mon, 16 Nov 2026 17:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55T-0003kg-AI
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55R-0005gp-2w
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794867723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cc5r/KfUpT5wh7ScYiLA/f6lHPNnkL5ZSHMn8a/kv6Q=;
 b=QsOULN5DGk0z1FVsCGQQcG2Ss52ahU6DihxMnM1Ry01mN95qiQZ02tuFp66D/iOC/lUjNW
 W2k+XKZxtGboQgHyAij3ftTUIvCLUJMXDo30AeF4tUumKbfG82c/jli3dpBFz+/MByC0RK
 ZApENuGWXczNNkqTsFQsip5vm+5IamA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686--6yNOi1XOFWB61wYdCeifw-1; Mon,
 16 Nov 2026 17:22:01 -0500
X-MC-Unique: -6yNOi1XOFWB61wYdCeifw-1
X-Mimecast-MFC-AGG-ID: -6yNOi1XOFWB61wYdCeifw_1794867721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1177518004FD
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:22:01 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AED830001A2; Mon, 16 Nov 2026 22:21:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/26] Device security tagging
Date: Mon, 16 Nov 2026 22:21:32 +0000
Message-ID: <20261116222158.2840471-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:

  Merge tag 'pull-nbd-2026-11-10-v2' of https://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/docs-security-devices-pull-request

for you to fetch changes up to 277f11f3e474d03cdff03e541db5a2d731ccb439:

  hw/i386: mark vmmouse / vmport as secure (2026-11-16 18:08:38 +0000)

----------------------------------------------------------------
* Mark user creatable devices as secure where they are
  intended for the virtualization use case and are
  expected to provide security boundary

----------------------------------------------------------------

Daniel P. Berrangé (26):
  hw: mark most virtio PCI devices as secure
  hw: mark all virtio CCW devices as secure
  hw: mark all vhost devices a secure
  hw: mark most remaining virtio object types as secure
  hw/vfio: mark all VFIO object classes as secure
  hw/xen: mark all Xen related object types as being secure
  hw/net: mark e1000, e1000e, rtl8139 & sPAPR VLAN as secure
  hw/usb: mark commonly used USB devices/hosts as secure
  hw/watchdog: mark some watchdog devices as secure
  hw/scsi: mark spapr SCSI controller as secure
  hw/scsi: mark SCSI disk endpoint devices as secure
  hw/ide: mark ICH9 and ide-hd/ide-cd as secure
  hw: define most common PCI types as secure
  hw/pci-host: mark common x86, ppc, arm and s390 PCI hosts as secure
  hw/display: mark bochs, ramfb and VGA as secure
  hw/tpm: mark all TPM implementations as secure
  hw/misc: mark pvpanic, vmcoreinfo as secure
  hw/audio: mark Intel HDA devices & codecs as secure
  hw/char: mark common serial / console devices as secure
  hw/mem: mark nvdimm, pc-dimm & spapr-nvdimm devices as secure
  hw/uefi: mark the EFI vars service as secure
  hw/acpi: mark erst, vmclock and vmgenid devices as secure
  hw: mark KVM clock and RTC devices as secure
  hw: device AMD, Intel and ARM IOMMUs as secure
  hw/input: mark PS/2 and PC Keyboard devices as secure
  hw/i386: mark vmmouse / vmport as secure

 hw/9pfs/virtio-9p-device.c               |  1 +
 hw/acpi/erst.c                           |  1 +
 hw/acpi/vmclock.c                        |  1 +
 hw/acpi/vmgenid.c                        |  1 +
 hw/arm/smmuv3.c                          |  2 ++
 hw/audio/hda-codec.c                     |  3 +++
 hw/audio/intel-hda.c                     |  3 +++
 hw/audio/virtio-snd.c                    |  1 +
 hw/block/vhost-user-blk.c                |  1 +
 hw/block/virtio-blk.c                    |  1 +
 hw/block/xen-block.c                     |  2 ++
 hw/char/debugcon.c                       |  1 +
 hw/char/sclpconsole-lm.c                 |  1 +
 hw/char/sclpconsole.c                    |  1 +
 hw/char/serial-isa.c                     |  1 +
 hw/char/serial-pci.c                     |  1 +
 hw/char/serial.c                         |  1 +
 hw/char/spapr_vty.c                      |  1 +
 hw/char/virtio-console.c                 |  2 ++
 hw/char/virtio-serial-bus.c              |  2 ++
 hw/char/xen_console.c                    |  1 +
 hw/display/bochs-display.c               |  1 +
 hw/display/ramfb-standalone.c            |  1 +
 hw/display/vga-pci.c                     |  2 ++
 hw/display/vhost-user-gpu.c              |  1 +
 hw/display/virtio-gpu-pci-gl.c           |  2 +-
 hw/display/virtio-gpu.c                  |  1 +
 hw/display/virtio-vga-gl.c               |  2 +-
 hw/display/virtio-vga-rutabaga.c         |  2 +-
 hw/i386/amd_iommu.c                      |  4 +++-
 hw/i386/intel_iommu.c                    |  1 +
 hw/i386/kvm/clock.c                      |  1 +
 hw/i386/vmmouse.c                        |  1 +
 hw/i386/vmport.c                         |  1 +
 hw/i386/xen/xen-hvm.c                    |  1 +
 hw/i386/xen/xen_platform.c               |  1 +
 hw/i386/xen/xen_pvdevice.c               |  1 +
 hw/ide/ich.c                             |  1 +
 hw/ide/ide-dev.c                         |  2 ++
 hw/ide/piix.c                            |  2 ++
 hw/input/pckbd.c                         |  3 ++-
 hw/input/ps2.c                           |  6 ++++--
 hw/input/virtio-input-hid.c              |  4 ++++
 hw/input/virtio-input-host.c             |  1 +
 hw/mem/nvdimm.c                          |  1 +
 hw/mem/pc-dimm.c                         |  1 +
 hw/misc/pvpanic-isa.c                    |  1 +
 hw/misc/pvpanic-mmio.c                   |  1 +
 hw/misc/pvpanic-pci.c                    |  1 +
 hw/misc/vmcoreinfo.c                     |  1 +
 hw/net/e1000.c                           |  1 +
 hw/net/e1000e.c                          |  1 +
 hw/net/rtl8139.c                         |  1 +
 hw/net/spapr_llan.c                      |  1 +
 hw/net/virtio-net.c                      |  1 +
 hw/net/xen_nic.c                         |  1 +
 hw/pci-bridge/gen_pcie_downstream_port.c |  1 +
 hw/pci-bridge/gen_pcie_root_port.c       |  1 +
 hw/pci-bridge/gen_pcie_upstream_port.c   |  1 +
 hw/pci-bridge/i82801b11.c                |  1 +
 hw/pci-bridge/ioh3420.c                  |  1 +
 hw/pci-bridge/pci_bridge_dev.c           |  2 ++
 hw/pci-bridge/pci_expander_bridge.c      |  5 +++++
 hw/pci-bridge/pcie_pci_bridge.c          |  1 +
 hw/pci-bridge/xio3130_downstream.c       |  1 +
 hw/pci-bridge/xio3130_upstream.c         |  1 +
 hw/pci-host/gpex.c                       |  2 ++
 hw/pci-host/i440fx.c                     |  2 ++
 hw/pci-host/q35.c                        |  2 ++
 hw/pci-host/xen_igd_pt.c                 |  1 +
 hw/pci/pci.c                             |  4 ++++
 hw/ppc/spapr_nvdimm.c                    |  1 +
 hw/ppc/spapr_pci.c                       |  1 +
 hw/ppc/spapr_tpm_proxy.c                 |  1 +
 hw/rtc/mc146818rtc.c                     |  1 +
 hw/s390x/s390-pci-bus.c                  |  4 ++++
 hw/s390x/vhost-scsi-ccw.c                |  1 +
 hw/s390x/vhost-user-fs-ccw.c             |  1 +
 hw/s390x/vhost-vsock-ccw.c               |  1 +
 hw/s390x/virtio-ccw-9p.c                 |  1 +
 hw/s390x/virtio-ccw-balloon.c            |  1 +
 hw/s390x/virtio-ccw-blk.c                |  1 +
 hw/s390x/virtio-ccw-crypto.c             |  1 +
 hw/s390x/virtio-ccw-gpu.c                |  1 +
 hw/s390x/virtio-ccw-input.c              |  3 +++
 hw/s390x/virtio-ccw-mem.c                |  1 +
 hw/s390x/virtio-ccw-net.c                |  1 +
 hw/s390x/virtio-ccw-rng.c                |  1 +
 hw/s390x/virtio-ccw-scsi.c               |  1 +
 hw/s390x/virtio-ccw-serial.c             |  1 +
 hw/scsi/scsi-disk.c                      |  3 +++
 hw/scsi/scsi-generic.c                   |  1 +
 hw/scsi/spapr_vscsi.c                    |  1 +
 hw/scsi/vhost-scsi.c                     |  1 +
 hw/scsi/vhost-user-scsi.c                |  1 +
 hw/scsi/virtio-scsi.c                    |  1 +
 hw/tpm/tpm_crb.c                         |  1 +
 hw/tpm/tpm_spapr.c                       |  1 +
 hw/tpm/tpm_tis_i2c.c                     |  1 +
 hw/tpm/tpm_tis_isa.c                     |  1 +
 hw/tpm/tpm_tis_sysbus.c                  |  1 +
 hw/uefi/var-service-sysbus.c             |  2 ++
 hw/usb/ccid-card-emulated.c              |  1 +
 hw/usb/ccid-card-passthru.c              |  1 +
 hw/usb/dev-hid.c                         |  3 +++
 hw/usb/dev-hub.c                         |  1 +
 hw/usb/dev-smartcard-reader.c            |  2 ++
 hw/usb/dev-storage-bot.c                 |  1 +
 hw/usb/dev-storage-classic.c             |  1 +
 hw/usb/hcd-xhci-nec.c                    |  1 +
 hw/usb/hcd-xhci-pci.c                    |  1 +
 hw/usb/hcd-xhci-sysbus.c                 |  3 ++-
 hw/usb/hcd-xhci.c                        |  1 +
 hw/usb/host-libusb.c                     |  1 +
 hw/usb/redirect.c                        |  1 +
 hw/vfio-user/pci.c                       |  1 +
 hw/vfio/ap.c                             |  1 +
 hw/vfio/ccw.c                            |  1 +
 hw/vfio/igd.c                            |  1 +
 hw/vfio/iommufd.c                        |  2 ++
 hw/vfio/pci.c                            |  2 ++
 hw/vfio/spapr.c                          |  1 +
 hw/virtio/vdpa-dev.c                     |  1 +
 hw/virtio/vhost-user-fs.c                |  1 +
 hw/virtio/vhost-user-gpio.c              |  1 +
 hw/virtio/vhost-user-i2c.c               |  1 +
 hw/virtio/vhost-user-input.c             |  1 +
 hw/virtio/vhost-user-rng.c               |  1 +
 hw/virtio/vhost-user-rtc.c               |  1 +
 hw/virtio/vhost-user-scmi.c              |  1 +
 hw/virtio/vhost-user-snd.c               |  1 +
 hw/virtio/vhost-user-spi.c               |  1 +
 hw/virtio/vhost-user-test-device.c       |  1 +
 hw/virtio/vhost-user-vsock.c             |  1 +
 hw/virtio/vhost-vsock.c                  |  1 +
 hw/virtio/virtio-balloon.c               |  1 +
 hw/virtio/virtio-crypto.c                |  1 +
 hw/virtio/virtio-iommu.c                 |  2 ++
 hw/virtio/virtio-mem.c                   |  1 +
 hw/virtio/virtio-mmio.c                  |  2 ++
 hw/virtio/virtio-nsm.c                   |  1 +
 hw/virtio/virtio-pci.c                   | 17 ++++++++++++++++-
 hw/virtio/virtio-pmem.c                  |  1 +
 hw/virtio/virtio-rng.c                   |  1 +
 hw/virtio/virtio-rtc.c                   |  1 +
 hw/watchdog/sbsa_gwdt.c                  |  1 +
 hw/watchdog/spapr_watchdog.c             |  1 +
 hw/watchdog/wdt_diag288.c                |  1 +
 hw/watchdog/wdt_i6300esb.c               |  1 +
 hw/watchdog/wdt_ib700.c                  |  1 +
 hw/xen/xen-bus.c                         |  2 ++
 hw/xen/xen-legacy-backend.c              |  3 +++
 hw/xen/xen_pt.c                          |  1 +
 include/hw/virtio/virtio-pci.h           | 10 +++++++++-
 154 files changed, 227 insertions(+), 10 deletions(-)

-- 
2.56.1


