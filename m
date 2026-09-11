Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09082C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x577W-0002FL-Bk; Fri, 11 Sep 2026 15:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x577U-0002Ew-OD
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x577Q-0002RP-TV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789155662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dn447okKZ2GsFmhn22Wi4k5vdRBS7gloUR0LWL/lNG8=;
 b=fZ0E5VcqhtkBigbrXydUepf16htqNWKYelxOxXoz0sgAelFX9P9qQIXBafO75vnhLTqYoG
 jPZxIRpr9cA2/sp7KDjLo3EfTCMjRTX9czXCB3XTYQldZyduCQeDYixPLkZrv1Cf8bXiso
 u7pwpR/jTuheAta7IZ5avqhB9vnnFp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-7IJynJk5PPiCf1p8JiWOug-1; Fri, 11 Sep 2026 15:41:01 -0400
X-MC-Unique: 7IJynJk5PPiCf1p8JiWOug-1
X-Mimecast-MFC-AGG-ID: 7IJynJk5PPiCf1p8JiWOug_1789155660
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so9897015e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789155660; x=1789760460; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dn447okKZ2GsFmhn22Wi4k5vdRBS7gloUR0LWL/lNG8=;
 b=doZKl3fVqglcWNrj/uIeEfqSQ96N1phGB3YQYQi2ThD1tgLCd5ZVwWC1Mh31lw6dT9
 yaaMQSsKY2T1JbK4ENTEBPmrC6JpZ+7sXRwZSatz5Q3jZpoVkTnxngVsKeDS1CkhcZlM
 jlXxM79tcZYUEuev9fjV2I+WaBFqX+wunIvtoDWDj92N1IjDbB1DT377EifmnmMDZR66
 tfCdouVAvPsbbTCnrq0b6s97k935OTqeVJaC9GCWzqSCQQHpfNalomsZ+wh6U+gnmeHq
 fEqY11ItUa04WSTdLwW1O+jTeaM7TzaKxwxo1/MCxG2BoebILaLIgr1I+E6NxNOzFW/p
 Eztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789155660; x=1789760460;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dn447okKZ2GsFmhn22Wi4k5vdRBS7gloUR0LWL/lNG8=;
 b=hYoTnWj94oI3DbkJhS48hCe8LAWZYqrgl2nkzEkZAH94x5TK3YZ70qbp+An5j6MI6P
 ZHyG28Er5FWzJrC+StI5a+vmRB5/oTngycg2+P1uaALZiX8twFTVHxSwLL1ooW27Snus
 PYiB/WCp+B1mBvVTR8YCik+oOMJqKK8BuMWBIZpbU0zkUymr1ki898pkFqizJ0uhibsZ
 +ft22wJlAlJBROTp4YkQzbWhS6DmHnDw7tdZlJnKTM7FqOMV7qOdeZK17WVyzGgriZ9X
 EFouyH8TisBOkFQu+vhaFQgbcK+m/v1RbKq7+eZix5BbxxrGl39NeQBtWa5OhVt6f/Oj
 eT5w==
X-Gm-Message-State: AFuF++mXf4nSxGZCR9uey+FU11rl1arRmq4KUzJcifwdTa3t9GAWiTdX
 p19BKiXBsBNxOV1yU0zBwTUh38AJ9SI8NItRWu7agj30g1A73OWi4d8VdcXKC4i9j8XbGLmeU3M
 X6zgCokgAw6/33xQyrEzMKYThfD2WxPCYkY+i05kFsH4OlOv3ss2NjhOa
X-Gm-Gg: AYBFou1K6A+avKpNX5ckToa298442rKnzY36day0RETi/iik2wKkAOQWOALgVaaQoKW
 nLDvBr/MvvzMQLws+4/708T8x5dPXKLyUdvONe2wq1FrO1AC8hcFlRU9mmTXUVA+71ZDiIynfZU
 0w+qK2e9HgIlA2zCp48l9ZHcXILpjKeXDYLIU4KwQQTDWfe2oUEOObA2vDkjB47QBu5Y7t7cP3e
 Bon1N6pTbOEC3EiLifdqTojCpiPMv9cLgOHt66DfAeA/xUhYLKDXqosQK5F2nZk5abFhzTz14GH
 mcKGpn1KXmPPhtnUZH8/H6lBjm/UsA/3KMzzRiLJROoQgEYv9SFXW1kvlTaHG6Cm9b4=
X-Received: by 2002:a05:600c:34d1:b0:49c:edd2:855 with SMTP id
 5b1f17b1804b1-49e61888914mr68249705e9.6.1789155659788; 
 Fri, 11 Sep 2026 12:40:59 -0700 (PDT)
X-Received: by 2002:a05:600c:34d1:b0:49c:edd2:855 with SMTP id
 5b1f17b1804b1-49e61888914mr68249405e9.6.1789155659238; 
 Fri, 11 Sep 2026 12:40:59 -0700 (PDT)
Received: from redhat.com ([147.235.223.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a7a686sm77260135e9.1.2026.09.11.12.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 12:40:56 -0700 (PDT)
Date: Fri, 11 Sep 2026 15:40:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>,
 Matej Hrica <mhrica@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PULL v2 00/75] pci, vhost, virtio, iommu, apci: features, fixes
Message-ID: <20260911153858-mutt-send-email-mst@kernel.org>
References: <cover.1789117222.git.mst@redhat.com>
 <CADSE00+UysXRdT68eAUxhmV9hTc2040s1ZNUTaRUWq-M0bjTPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+UysXRdT68eAUxhmV9hTc2040s1ZNUTaRUWq-M0bjTPg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 11, 2026 at 03:41:31PM +0200, Albert Esteve wrote:
> On Fri, Sep 11, 2026 at 11:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
> >
> >   Merge tag 'qom-qapi-pr-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 2f8991c0b9c400f55897849a538580039b61865a:
> >
> >   MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-11 04:59:15 -0400)
> >
> > ----------------------------------------------------------------
> > pci, vhost, virtio, iommu, apci: features, fixes
> >
> > new vhost-user-media device
> > virtio-net now supports live-TAP local migration
> > cxl now supports CFMW restrictions and per-window options
> > intel_iommu now supports concurrent page fault handling with PRI
> > pci now batches memory transactions around mapping updates
> > vhost-user-blk now allows toggling inflight-migration at runtime
> > virtio-rtc now supports smeared UTC clock type
> > intel_iommu now exposes SMPWC when SVM is enabled
> > new reviewer for CXL patches
> >
> > Fixes, cleanups all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi Michael,
> 
> I see you dropped these patches from v1 to v2. Just checking if this
> was intended or if there is an issue/CI failure that needs addressing?
> 
> [...]
> Dorinda Bassey (1):
>       vhost: Fix SHMEM_MAP transaction ordering and resulting deadlock
> 
> Feifan Qian (1):
>       vhost-user: Reject SHMEM_MAP when no KVM memory slot is left
> 
> [...]
> Matej Hrica (2):
>       vhost-user-gpu: Add shared memory region support
>       vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT flags
> [...]
> 
> Thanks!
> Albert


No issue, I just don't normally merge gpu things. This one
was needed originally to resolve some other issue so I picked it up
but I guess the issue's gone because it now passed without.
So I'm happy to have it go through the usual channels.

> >
> > ----------------------------------------------------------------
> > Albert Esteve (4):
> >       linux-headers: add VIRTIO_ID_MEDIA
> >       hw/display: add vhost-user-media device
> >       hw/display/vhost-user-media: add shared memory region BAR
> >       linux-headers: Update to Linux v7.3-rc1
> >
> > Alexandr Moshkov (6):
> >       vhost-user: add skip_drain param to do_vhost_virtqueue_stop
> >       vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
> >       vhost-user: use skip_drain with GET_VRING_BASE_SKIP_DRAIN message
> >       vhost-user-blk: make inflight-migration prop mutable on running vm
> >       vhost-user-blk: move inflight_needed higher
> >       vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN when inflight-migration is on
> >
> > Alyssa Ross (1):
> >       vhost-user.rst: fix typo
> >
> > Bin Guo (2):
> >       libvhost-user: accept the postcopy client base ack in vu_add_mem_reg()
> >       libvhost-user: return the backend mapping address for added regions
> >
> > Clément MATHIEU--DRIF (4):
> >       intel_iommu: Support concurrent page fault handling with PRI
> >       intel_iommu: Only set dirty bit when PTE exposes write permission
> >       intel_iommu: Always write all the flags passed to vtd_set_flag_in_pte
> >       intel_iommu: Expose SMPWC when SVM is enabled
> >
> > Davidlohr Bueso (5):
> >       tests/bios-tables-test: Exclude CEDT.cxl for the CFMW restriction change
> >       hw/cxl: Drop Back-Invalidate from default CFMW window restrictions
> >       tests/acpi/cxl: Update CEDT.cxl for the default CFMW restrictions
> >       hw/cxl: Add configurable CXL Fixed Memory Window restriction flags
> >       tests/qtest/cxl: Add CXL Fixed Memory Window restriction flag tests
> >
> > Denis V. Lunev (2):
> >       pci: batch BAR remapping into one memory transaction
> >       pci: load a device's config inside one memory transaction
> >
> > GuoHan Zhao (1):
> >       virtio-crypto: clean up every data queue
> >
> > Hanna Czenczek (6):
> >       hw/virtio-blk: Account discard operations
> >       hw/virtio-blk: Complete zone-append cookies
> >       hw/nvme: Fix block accounting in nvme_copy()
> >       hw/nvme: Fix block accounting for compare
> >       hw/ide: Have ide_dma_cb() complete accounting
> >       hw/scsi-disk: Fix accounting for IGNORE, ret > 0
> >
> > Jia Jia (2):
> >       virtio: reduce code duplication for split ring
> >       hw/virtio: reject inverted virtio-iommu IOVA ranges
> >
> > Junjie Cao (3):
> >       hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
> >       hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
> >       MAINTAINERS: add Junjie Cao as CXL reviewer
> >
> > Kuan-Wei Chiu (1):
> >       virtio-rtc: Report smeared UTC clock type
> >
> > Laurent Vivier (2):
> >       hw/net/virtio-net: check packet size before VLAN tag access in receive_filter()
> >       hw/net/virtio-net: strip trailing padding when caching RSC segment
> >
> > Michael S. Tsirkin (7):
> >       virtio: fix exit(1) on DMA mapping failure during migration restore
> >       virtio: fix config_len DoS in migration restore path
> >       virtio-pci: reject Q_ENABLE write on already-enabled queue
> >       meson: disable "maybe uninitilized" errors with -Og
> >       virtio-balloon: fix free-page BH teardown on unrealize
> >       net/tap-solaris: Fix resource leaks on error paths
> >       virtio-net: validate IHL in virtio_net_rsc_extract_unit4 before use
> >
> > Philippe Mathieu-Daudé (4):
> >       hw/acpi: Make AcpiGedState const in build_ged_aml()
> >       hw/hotplug: Mark various HotplugHandlerClass variables as const
> >       hw/hotplug: Reduce some HotplugHandler variables scope
> >       hw/hotplug: Constify HotplugHandler
> >
> > Sairaj Kodilkar (7):
> >       amd_iommu: Return empty efr for stub call
> >       tests/acpi: x86: Allow IVRS acpi table changes
> >       amd_iommu: acpi-build: update PA, GVA and VA size macros
> >       acpi_build: Use IOMMU pci device to build IOMMU DeviceID
> >       acpi_build: Build IVRS feature report using extended feature register
> >       amd_iommu: acpi-build: Remove unsupported PPR and HE feature
> >       tests/acpi: x86: update golden masters for IVRS
> >
> > Stefan Hajnoczi (1):
> >       virtio-scsi: set dataplane_started to false upon failure
> >
> > Vladimir Sementsov-Ogievskiy (16):
> >       net/tap: rework tap_parse_script
> >       net/tap: improve script/downscript options documentation
> >       net/tap: deprecate "no" as special value for script/downscript
> >       net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
> >       net/tap: move vhost initialization to tap_setup_vhost()
> >       net/tap: use container_of instead of DO_UPCAST
> >       net/tap: QOMify tap backend
> >       net/tap: add TYPE_VMSTATE_IF interface
> >       qapi: add local migration parameter
> >       migration/fd: fix fd leak when fd is not valid for migration
> >       migration/fd: add errp parameter to migration_fd_valid()
> >       migration: check that transfer is UNIX socket when "local" set
> >       virtio-net: support local migration of backend
> >       net/tap: disable read polling for stopped VM
> >       net/tap: support local migration with virtio-net
> >       tests/functional: add test_tap_migration
> >
> > Xiong Weimin (1):
> >       hw/virtio: Propagate vhost_virtqueue_mask errors
> >
> >  MAINTAINERS                                   |   7 +
> >  docs/about/deprecated.rst                     |  18 +
> >  docs/interop/vhost-user.rst                   |  44 ++-
> >  docs/system/devices/cxl.rst                   |  25 +-
> >  docs/system/i386/microvm.rst                  |   4 +-
> >  docs/system/i386/xenpvh.rst                   |   2 +-
> >  docs/system/ppc/ppce500.rst                   |   4 +-
> >  docs/system/riscv/microchip-icicle-kit.rst    |   2 +-
> >  docs/system/riscv/sifive_u.rst                |   2 +-
> >  meson.build                                   |   4 +
> >  qapi/machine.json                             |  28 ++
> >  qapi/migration.json                           |  21 +-
> >  qapi/net.json                                 |  45 ++-
> >  hw/i386/amd_iommu.h                           |  27 +-
> >  hw/i386/intel_iommu_internal.h                |   1 +
> >  hw/s390x/ccw-device.h                         |   2 +-
> >  include/hw/acpi/cpu.h                         |   4 +-
> >  include/hw/acpi/cpu_hotplug.h                 |   2 +-
> >  include/hw/acpi/generic_event_device.h        |   3 +-
> >  include/hw/acpi/ich9.h                        |  10 +-
> >  include/hw/acpi/memory_hotplug.h              |   4 +-
> >  include/hw/acpi/pcihp.h                       |   8 +-
> >  include/hw/core/boards.h                      |   4 +-
> >  include/hw/core/hotplug.h                     |  13 +-
> >  include/hw/core/qdev.h                        |  14 +-
> >  include/hw/cxl/cxl.h                          |  12 +
> >  include/hw/i386/microvm.h                     |   4 +-
> >  include/hw/i386/x86.h                         |  10 +-
> >  include/hw/mem/nvdimm.h                       |   2 +-
> >  include/hw/pci/pci_bridge.h                   |   6 +-
> >  include/hw/pci/pcie.h                         |   8 +-
> >  include/hw/pci/shpc.h                         |   6 +-
> >  include/hw/ppc/spapr_nvdimm.h                 |   2 +-
> >  include/hw/virtio/vhost-backend.h             |   1 +
> >  include/hw/virtio/vhost-user-media.h          |  46 +++
> >  include/hw/virtio/vhost-user.h                |   2 +-
> >  include/hw/virtio/vhost.h                     |  16 +-
> >  include/hw/virtio/virtio-balloon.h            |   1 +
> >  include/hw/virtio/virtio-net.h                |   1 +
> >  include/hw/virtio/virtio.h                    |   2 +-
> >  include/migration/misc.h                      |   2 +
> >  include/migration/vmstate.h                   |   2 +
> >  include/net/net.h                             |   9 +
> >  include/net/tap.h                             |   2 +
> >  include/standard-headers/linux/ethtool.h      |   6 +
> >  include/standard-headers/linux/virtio_ids.h   |   1 +
> >  linux-headers/linux/iommufd.h                 |  45 ++-
> >  linux-headers/linux/userfaultfd.h             |  54 ++-
> >  linux-headers/linux/vduse.h                   |  28 ++
> >  linux-headers/linux/vfio.h                    |  21 ++
> >  linux-headers/linux/vfio_zdev.h               |   2 +
> >  backends/cryptodev-vhost.c                    |   2 +-
> >  backends/vhost-user.c                         |   2 +-
> >  hw/acpi/acpi-cpu-hotplug-stub.c               |   4 +-
> >  hw/acpi/acpi-mem-hotplug-stub.c               |   4 +-
> >  hw/acpi/acpi-nvdimm-stub.c                    |   2 +-
> >  hw/acpi/acpi-pci-hotplug-stub.c               |   8 +-
> >  hw/acpi/cpu.c                                 |   6 +-
> >  hw/acpi/cxl.c                                 |   2 +-
> >  hw/acpi/generic_event_device.c                |  13 +-
> >  hw/acpi/ich9.c                                |  10 +-
> >  hw/acpi/memory_hotplug.c                      |   7 +-
> >  hw/acpi/nvdimm.c                              |   2 +-
> >  hw/acpi/pcihp.c                               |  11 +-
> >  hw/acpi/piix4.c                               |  12 +-
> >  hw/arm/virt.c                                 |  23 +-
> >  hw/block/vhost-user-blk.c                     |  60 +++-
> >  hw/block/virtio-blk.c                         |  38 ++-
> >  hw/char/virtio-serial-bus.c                   |   6 +-
> >  hw/core/hotplug.c                             |  16 +-
> >  hw/core/qdev-hotplug.c                        |  10 +-
> >  hw/core/qdev.c                                |   2 +-
> >  hw/cxl/cxl-host.c                             |  48 ++-
> >  hw/display/vhost-user-media-pci.c             | 115 +++++++
> >  hw/display/vhost-user-media.c                 | 388 ++++++++++++++++++++++
> >  hw/i386/acpi-build.c                          |  65 ++--
> >  hw/i386/amd_iommu-stub.c                      |   2 +-
> >  hw/i386/amd_iommu.c                           |   2 +-
> >  hw/i386/intel_iommu.c                         | 118 ++++---
> >  hw/i386/intel_iommu_accel.c                   |   6 +
> >  hw/i386/microvm.c                             |  12 +-
> >  hw/i386/pc.c                                  |  28 +-
> >  hw/i386/x86-common.c                          |   8 +-
> >  hw/ide/core.c                                 |   3 +-
> >  hw/intc/loongarch_dintc.c                     |   8 +-
> >  hw/intc/loongarch_extioi_common.c             |   4 +-
> >  hw/intc/loongarch_ipi.c                       |   4 +-
> >  hw/loongarch/virt.c                           |  44 +--
> >  hw/mem/cxl_type3.c                            |   6 +-
> >  hw/net/vhost_net.c                            |   9 +-
> >  hw/net/virtio-net.c                           | 131 +++++++-
> >  hw/nvme/ctrl.c                                |  78 +++--
> >  hw/pci-bridge/pci_bridge_dev.c                |   6 +-
> >  hw/pci/pci.c                                  |   8 +
> >  hw/pci/pcie.c                                 |  10 +-
> >  hw/pci/pcie_port.c                            |   2 +-
> >  hw/pci/shpc.c                                 |  11 +-
> >  hw/ppc/e500plat.c                             |   4 +-
> >  hw/ppc/spapr.c                                |  48 +--
> >  hw/ppc/spapr_nvdimm.c                         |   2 +-
> >  hw/ppc/spapr_pci.c                            |  12 +-
> >  hw/remote/machine.c                           |   2 +-
> >  hw/riscv/virt.c                               |   6 +-
> >  hw/s390x/css-bridge.c                         |   2 +-
> >  hw/s390x/s390-pci-bus.c                       |  12 +-
> >  hw/s390x/s390-virtio-ccw.c                    |  16 +-
> >  hw/s390x/virtio-ccw-md.c                      |  10 +-
> >  hw/s390x/virtio-ccw.c                         |   2 +-
> >  hw/scsi/scsi-disk.c                           |   7 +
> >  hw/scsi/vhost-scsi-common.c                   |   2 +-
> >  hw/scsi/virtio-scsi-dataplane.c               |   2 +-
> >  hw/scsi/virtio-scsi.c                         |  10 +-
> >  hw/scsi/vmw_pvscsi.c                          |   4 +-
> >  hw/virtio/vdpa-dev.c                          |   2 +-
> >  hw/virtio/vhost-user-base.c                   |   2 +-
> >  hw/virtio/vhost-user-fs.c                     |   2 +-
> >  hw/virtio/vhost-user-scmi.c                   |   2 +-
> >  hw/virtio/vhost-user.c                        |  47 ++-
> >  hw/virtio/vhost-vsock-common.c                |   2 +-
> >  hw/virtio/vhost.c                             |  44 ++-
> >  hw/virtio/virtio-balloon.c                    |  19 +-
> >  hw/virtio/virtio-crypto.c                     |   5 +-
> >  hw/virtio/virtio-iommu.c                      |  17 +-
> >  hw/virtio/virtio-md-pci.c                     |  10 +-
> >  hw/virtio/virtio-pci.c                        |   7 +
> >  hw/virtio/virtio-rtc.c                        |   3 +-
> >  hw/virtio/virtio.c                            |  85 ++---
> >  hw/xen/xen-bus.c                              |   2 +-
> >  migration/fd.c                                |  28 +-
> >  migration/migration.c                         |  13 +
> >  migration/options.c                           |  18 +-
> >  net/net.c                                     |  14 +-
> >  net/tap-solaris.c                             |  69 ++--
> >  net/tap.c                                     | 448 ++++++++++++++++++++-----
> >  stubs/hotplug-stubs.c                         |   6 +-
> >  subprojects/libvhost-user/libvhost-user.c     |  34 +-
> >  system/qdev-monitor.c                         |   4 +-
> >  tests/qtest/cxl-test.c                        |  95 ++++++
> >  hw/display/Kconfig                            |   5 +
> >  hw/display/meson.build                        |   3 +
> >  qemu-options.hx                               |  13 +-
> >  tests/data/acpi/x86/q35/CEDT.cxl              | Bin 184 -> 184 bytes
> >  tests/data/acpi/x86/q35/IVRS.ivrs             | Bin 176 -> 176 bytes
> >  tests/functional/x86_64/meson.build           |   1 +
> >  tests/functional/x86_64/test_tap_migration.py | 461 ++++++++++++++++++++++++++
> >  145 files changed, 2884 insertions(+), 663 deletions(-)
> >  create mode 100644 include/hw/virtio/vhost-user-media.h
> >  create mode 100644 hw/display/vhost-user-media-pci.c
> >  create mode 100644 hw/display/vhost-user-media.c
> >  create mode 100755 tests/functional/x86_64/test_tap_migration.py
> >
> >


