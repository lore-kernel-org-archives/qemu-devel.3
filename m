Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CC1C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Px-000411-W4; Fri, 11 Sep 2026 10:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mr-0002Ic-I5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mo-0007oc-E2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+bcdSv8ht1KTYbbxjhvCgSBCMHwpciTC1oWfuAQo/wM=;
 b=MP0U6jlsHbUXDsBNPrjS/atfhURRc0UkKCmmu2VIaKK+aXHURZOnlvRpcZ83f6LBGyVASb
 0T420+FjR106/C6IlsCOc1SF4EpIFX11G7F8Zl0LhN9K7lBZH4gblH9o7pwOGpYYhhm+Ia
 UQYyLlF5KMhVKbLNdShPxt3mH0tq5Cs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-PJ2dEpRlNom6jxVT-WltRg-1; Fri,
 11 Sep 2026 10:36:32 -0400
X-MC-Unique: PJ2dEpRlNom6jxVT-WltRg-1
X-Mimecast-MFC-AGG-ID: PJ2dEpRlNom6jxVT-WltRg_1789137390
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D9E9195607C; Fri, 11 Sep 2026 14:36:30 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C523B300022B; Fri, 11 Sep 2026 14:36:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/28] Mark user creatable devices for secure for virt use case
Date: Fri, 11 Sep 2026 15:35:59 +0100
Message-ID: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This (largish) series undertakes the task of marking devices
secure, if they are intended to be used a virtualization
use case.

NB, the maintainer CC list was way too huge to include every
individual, so I've trimmed to just the mailing list CCs.

The approach taken was iterative as follows

 * Machines listed in

    https://www.qemu.org/docs/master/system/security.html#virtualization-use-case

 * All virtio/vhost/vfio/xen related devices

 * Most PCI related devices/controllers/bridges

I then used the RHEL builds of QEMU as an approximation for
what should be considered "virtualization use case", since
they cut out a huge pile of devices from the build. IOW,
more or less everything that RHEL builds for x86_64, ppc64,
aarch64, s390x gets included. Notably since RHEL does not
yet ship riscv or loongarch, I've possibly missed some
devices that ought to be in scope.

Devices are marked secure *regardless* of their maintainer
status, if they are relevant to virt. Notably all the USB
stuff is included despite USB being orphaned. An exception
is CXL which is arguably relevant to virt, but maintainers
agreed it is too immature to include so far.

IOW, the "secure" flag as set in this series mostly avoids
saying anything about the support status of the object types.

Over the long term, IMHO, the set of devices we declare as
providing a security boundary needs to be stable. We should
not declare a device out of scope for the virt use case simply
because a maintainer steps aside. The device doesn't become
instantly less secure. It does mean bug fixes may not be
timely enough, and rely on the goodwill of other contributors
or maintainers to step up and fix.

Or to put it another way. "secure = true" does not guarantee
that the device is secure, but it states our intent that we
*want* it to be secure, as opposed to "secure = false" which
indicates we just don't care either way.

The intersection of (secure, orphaned) highlights to QEMU
contributors or corporate sponsors, where they might step
up their effort / investment.

Finally this is just user creatable devices. Use of these
devices implies use of many more non-user creatable devices.

I don't have a good way to enumerate those yet, and while
the end user doesn't care at runtime, as maintainers we
want to be clear if all devices are in scope for CVE
handling or not.

Based-on: <20260910103628.2326622-1-berrange@redhat.com>

Daniel P. Berrangé (28):
  hw: mark secure machines for x86, s390, ppc, arm, loonarch, riscv
  accel: mark kvm and xen accelerators as secure
  hw: mark all virtio PCI devices as secure
  hw: mark all virtio CCW devices as secure
  hw: mark all vhost devices a secure
  hw: mark all remaining virtio object types as secure
  hw/vfio: mark all VFIO object classes as secure
  hw/xen: mark all Xen related object types as being secure
  hw/net: mark e1000, e1000e, IGB, rtl8139 & sPAPR VLAN as secure
  hw/usb: mark commonly used USB devices/hosts as secure
  hw/watchdog: mark some watchdog devices as secure
  hw/scsi: mark spapr and vmware SCSI controllers as secure
  hw/scsi: mark SCSI disk endpoint devices as secure
  hw/ide: mark ICH9 and ide-hd/ide-cd as secure
  hw: define most common PCI types as secure
  hw/pci-host: mark common x86, ppc, arm and s390 PCI hosts as secure
  hw/display: mark bochs, cirrus, qxl, VGA, ramfb as secure
  hw/tpm: mark all TPM implementations as secure
  hw/misc: mark pvpanic, vmcoreinfo as secure
  hw/audio: mark Intel HDA devices & codecs as secure
  hw/char: mark common serial / console devicess a secure
  hw/mem: mark nvdimm, pc-dimm & spapr-nvdimm devices as secure
  hw/uefi: mark the EFI vars service as secure
  hw/acpi: mark erst, vmclock and vmgenid devices as secure
  hw: mark KVM clock and RTC devices as secure
  hw: device AMD, Intel and ARM IOMMUs as secure
  hw/input: mark PS/2 and PC Keyboard devices as secure
  hw/i386: mark vmmouse / vmport as secure

 accel/accel-common.c                 | 2 ++
 accel/accel-system.c                 | 1 +
 accel/kvm/kvm-accel-ops.c            | 1 +
 accel/kvm/kvm-all.c                  | 1 +
 accel/xen/xen-all.c                  | 2 ++
 hw/9pfs/virtio-9p-device.c           | 1 +
 hw/acpi/erst.c                       | 1 +
 hw/acpi/vmclock.c                    | 1 +
 hw/acpi/vmgenid.c                    | 1 +
 hw/arm/smmu-common.c                 | 1 +
 hw/arm/smmuv3.c                      | 2 ++
 hw/arm/virt.c                        | 1 +
 hw/arm/xen-pvh.c                     | 1 +
 hw/audio/hda-codec.c                 | 4 ++++
 hw/audio/intel-hda.c                 | 5 +++++
 hw/audio/virtio-snd.c                | 1 +
 hw/block/vhost-user-blk.c            | 1 +
 hw/block/virtio-blk.c                | 1 +
 hw/block/xen-block.c                 | 3 +++
 hw/char/debugcon.c                   | 1 +
 hw/char/sclpconsole-lm.c             | 1 +
 hw/char/sclpconsole.c                | 1 +
 hw/char/serial-isa.c                 | 1 +
 hw/char/serial-pci.c                 | 1 +
 hw/char/serial.c                     | 1 +
 hw/char/spapr_vty.c                  | 1 +
 hw/char/virtio-console.c             | 2 ++
 hw/char/virtio-serial-bus.c          | 3 +++
 hw/char/xen_console.c                | 1 +
 hw/display/bochs-display.c           | 1 +
 hw/display/cirrus_vga.c              | 1 +
 hw/display/qxl.c                     | 3 +++
 hw/display/ramfb-standalone.c        | 1 +
 hw/display/vga-mmio.c                | 1 +
 hw/display/vga-pci.c                 | 3 +++
 hw/display/vhost-user-gpu.c          | 1 +
 hw/display/virtio-gpu-base.c         | 3 ++-
 hw/display/virtio-gpu-gl.c           | 1 +
 hw/display/virtio-gpu-pci-rutabaga.c | 1 +
 hw/display/virtio-gpu-pci.c          | 3 ++-
 hw/display/virtio-gpu-rutabaga.c     | 1 +
 hw/display/virtio-gpu.c              | 1 +
 hw/i386/amd_iommu.c                  | 4 +++-
 hw/i386/intel_iommu.c                | 1 +
 hw/i386/kvm/clock.c                  | 1 +
 hw/i386/microvm.c                    | 1 +
 hw/i386/pc_piix.c                    | 4 ++--
 hw/i386/vmmouse.c                    | 1 +
 hw/i386/vmport.c                     | 1 +
 hw/i386/xen/xen-pvh.c                | 1 +
 hw/i386/xen/xen_platform.c           | 1 +
 hw/i386/xen/xen_pvdevice.c           | 1 +
 hw/ide/ich.c                         | 1 +
 hw/ide/ide-dev.c                     | 3 +++
 hw/ide/piix.c                        | 2 ++
 hw/input/pckbd.c                     | 3 ++-
 hw/input/ps2.c                       | 9 ++++++---
 hw/input/virtio-input-hid.c          | 5 +++++
 hw/input/virtio-input-host.c         | 1 +
 hw/input/virtio-input.c              | 1 +
 hw/loongarch/virt.c                  | 2 ++
 hw/mem/nvdimm.c                      | 1 +
 hw/mem/pc-dimm.c                     | 1 +
 hw/misc/pvpanic-isa.c                | 1 +
 hw/misc/pvpanic-mmio.c               | 1 +
 hw/misc/pvpanic-pci.c                | 1 +
 hw/misc/vmcoreinfo.c                 | 1 +
 hw/net/e1000.c                       | 1 +
 hw/net/e1000e.c                      | 1 +
 hw/net/igb.c                         | 1 +
 hw/net/rtl8139.c                     | 1 +
 hw/net/spapr_llan.c                  | 1 +
 hw/net/virtio-net.c                  | 1 +
 hw/net/xen_nic.c                     | 1 +
 hw/pci-bridge/gen_pcie_root_port.c   | 1 +
 hw/pci-bridge/i82801b11.c            | 1 +
 hw/pci-bridge/ioh3420.c              | 1 +
 hw/pci-bridge/pci_bridge_dev.c       | 2 ++
 hw/pci-bridge/pci_expander_bridge.c  | 8 ++++++++
 hw/pci-bridge/pcie_pci_bridge.c      | 1 +
 hw/pci-bridge/pcie_root_port.c       | 1 +
 hw/pci-bridge/xio3130_downstream.c   | 1 +
 hw/pci-bridge/xio3130_upstream.c     | 1 +
 hw/pci-host/gpex.c                   | 2 ++
 hw/pci-host/i440fx.c                 | 2 ++
 hw/pci-host/pnv_phb.c                | 2 ++
 hw/pci-host/pnv_phb3.c               | 3 +++
 hw/pci-host/pnv_phb3_msi.c           | 1 +
 hw/pci-host/pnv_phb3_pbcq.c          | 1 +
 hw/pci-host/pnv_phb4.c               | 4 +++-
 hw/pci-host/pnv_phb4_pec.c           | 1 +
 hw/pci-host/q35.c                    | 2 ++
 hw/pci-host/remote.c                 | 1 +
 hw/pci-host/xen_igd_pt.c             | 1 +
 hw/pci/pci.c                         | 7 +++++++
 hw/pci/pci_bridge.c                  | 1 +
 hw/pci/pci_host.c                    | 1 +
 hw/pci/pcie_host.c                   | 1 +
 hw/pci/pcie_port.c                   | 1 +
 hw/ppc/spapr.c                       | 1 +
 hw/ppc/spapr_nvdimm.c                | 1 +
 hw/ppc/spapr_pci.c                   | 1 +
 hw/ppc/spapr_tpm_proxy.c             | 1 +
 hw/riscv/virt.c                      | 1 +
 hw/rtc/mc146818rtc.c                 | 1 +
 hw/s390x/s390-pci-bus.c              | 4 ++++
 hw/s390x/s390-virtio-ccw.c           | 1 +
 hw/s390x/vhost-scsi-ccw.c            | 1 +
 hw/s390x/vhost-user-fs-ccw.c         | 1 +
 hw/s390x/vhost-vsock-ccw.c           | 1 +
 hw/s390x/virtio-ccw-9p.c             | 1 +
 hw/s390x/virtio-ccw-balloon.c        | 1 +
 hw/s390x/virtio-ccw-blk.c            | 1 +
 hw/s390x/virtio-ccw-crypto.c         | 1 +
 hw/s390x/virtio-ccw-gpu.c            | 1 +
 hw/s390x/virtio-ccw-input.c          | 5 +++++
 hw/s390x/virtio-ccw-md.c             | 1 +
 hw/s390x/virtio-ccw-mem.c            | 1 +
 hw/s390x/virtio-ccw-net.c            | 1 +
 hw/s390x/virtio-ccw-rng.c            | 1 +
 hw/s390x/virtio-ccw-scsi.c           | 1 +
 hw/s390x/virtio-ccw-serial.c         | 1 +
 hw/s390x/virtio-ccw.c                | 1 +
 hw/scsi/scsi-disk.c                  | 4 ++++
 hw/scsi/scsi-generic.c               | 1 +
 hw/scsi/spapr_vscsi.c                | 1 +
 hw/scsi/vhost-scsi-common.c          | 1 +
 hw/scsi/vhost-scsi.c                 | 1 +
 hw/scsi/vhost-user-scsi.c            | 1 +
 hw/scsi/virtio-scsi.c                | 2 ++
 hw/scsi/vmw_pvscsi.c                 | 1 +
 hw/tpm/tpm_crb.c                     | 1 +
 hw/tpm/tpm_spapr.c                   | 1 +
 hw/tpm/tpm_tis_i2c.c                 | 1 +
 hw/tpm/tpm_tis_isa.c                 | 1 +
 hw/tpm/tpm_tis_sysbus.c              | 1 +
 hw/uefi/var-service-sysbus.c         | 2 ++
 hw/usb/ccid-card-emulated.c          | 1 +
 hw/usb/ccid-card-passthru.c          | 1 +
 hw/usb/dev-hid.c                     | 4 ++++
 hw/usb/dev-hub.c                     | 1 +
 hw/usb/dev-smartcard-reader.c        | 3 +++
 hw/usb/dev-storage-bot.c             | 1 +
 hw/usb/dev-storage-classic.c         | 1 +
 hw/usb/dev-storage.c                 | 1 +
 hw/usb/hcd-ehci-pci.c                | 2 ++
 hw/usb/hcd-ehci-sysbus.c             | 8 ++++++++
 hw/usb/hcd-ohci-pci.c                | 1 +
 hw/usb/hcd-ohci-sysbus.c             | 1 +
 hw/usb/hcd-uhci.c                    | 2 ++
 hw/usb/hcd-xhci-nec.c                | 1 +
 hw/usb/hcd-xhci-pci.c                | 2 ++
 hw/usb/hcd-xhci-sysbus.c             | 3 ++-
 hw/usb/hcd-xhci.c                    | 1 +
 hw/usb/host-libusb.c                 | 1 +
 hw/usb/redirect.c                    | 1 +
 hw/vfio-user/pci.c                   | 1 +
 hw/vfio/ap.c                         | 1 +
 hw/vfio/ccw.c                        | 1 +
 hw/vfio/container.c                  | 1 +
 hw/vfio/igd.c                        | 1 +
 hw/vfio/iommufd.c                    | 2 ++
 hw/vfio/pci.c                        | 3 +++
 hw/vfio/spapr.c                      | 1 +
 hw/virtio/vdpa-dev.c                 | 1 +
 hw/virtio/vhost-user-base.c          | 3 ++-
 hw/virtio/vhost-user-fs.c            | 1 +
 hw/virtio/vhost-user-gpio.c          | 1 +
 hw/virtio/vhost-user-i2c.c           | 1 +
 hw/virtio/vhost-user-input.c         | 1 +
 hw/virtio/vhost-user-rng.c           | 1 +
 hw/virtio/vhost-user-rtc.c           | 1 +
 hw/virtio/vhost-user-scmi.c          | 1 +
 hw/virtio/vhost-user-snd.c           | 1 +
 hw/virtio/vhost-user-spi.c           | 1 +
 hw/virtio/vhost-user-test-device.c   | 1 +
 hw/virtio/vhost-user-vsock.c         | 1 +
 hw/virtio/vhost-vsock-common.c       | 1 +
 hw/virtio/vhost-vsock.c              | 1 +
 hw/virtio/virtio-balloon.c           | 1 +
 hw/virtio/virtio-bus.c               | 1 +
 hw/virtio/virtio-crypto.c            | 1 +
 hw/virtio/virtio-input-pci.c         | 2 ++
 hw/virtio/virtio-iommu.c             | 2 ++
 hw/virtio/virtio-md-pci.c            | 1 +
 hw/virtio/virtio-mem.c               | 1 +
 hw/virtio/virtio-mmio.c              | 2 ++
 hw/virtio/virtio-nsm.c               | 1 +
 hw/virtio/virtio-pci.c               | 3 +++
 hw/virtio/virtio-pmem.c              | 1 +
 hw/virtio/virtio-rng.c               | 1 +
 hw/virtio/virtio-rtc.c               | 1 +
 hw/watchdog/sbsa_gwdt.c              | 1 +
 hw/watchdog/spapr_watchdog.c         | 1 +
 hw/watchdog/wdt_diag288.c            | 1 +
 hw/watchdog/wdt_i6300esb.c           | 1 +
 hw/watchdog/wdt_ib700.c              | 1 +
 hw/xen/xen-bus.c                     | 3 +++
 hw/xen/xen-legacy-backend.c          | 3 +++
 hw/xen/xen-pvh-common.c              | 1 +
 hw/xen/xen_pt.c                      | 1 +
 hw/xenpv/xen_machine_pv.c            | 2 +-
 include/hw/i386/pc.h                 | 1 +
 203 files changed, 304 insertions(+), 13 deletions(-)

-- 
2.55.0


