Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA100CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDZW-00032E-HP; Mon, 15 Jun 2026 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDZR-00031N-B0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDZI-0001ro-N8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781553953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEb54gd2Rtp2Daygv7fuzjQ7K8iflHr16hYCFnoSgKc=;
 b=H6/ORjWv75oeyt8OO/DjCnGc9t7MA45X17jABlbGSHdkws5K1PNX0f/XGJre/jR69RtwqD
 KiMPTdCiV5sfYcNhspdvbSeJ9Yiw0BnAFLc6JbnayDwZ2P9/LGBFnLU5QOcuzSvT2AEFFp
 RIRonzWw/OGqogkN+ZCFPILabPqS4jI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-B4trDMMrP6iXWvhh-gFYtQ-1; Mon, 15 Jun 2026 16:05:52 -0400
X-MC-Unique: B4trDMMrP6iXWvhh-gFYtQ-1
X-Mimecast-MFC-AGG-ID: B4trDMMrP6iXWvhh-gFYtQ_1781553951
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c4f61a34so25721975e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781553951; x=1782158751; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IEb54gd2Rtp2Daygv7fuzjQ7K8iflHr16hYCFnoSgKc=;
 b=bc7309pso5hPlw8ewx2rwg4SnEz5FjKUuGLWX+DoCHNSYiNPvJc8sHJ5BlUsfU40AH
 POe6pQyiHf2j2z1L7eUIeRlln+b1IoFfdHJ5GQxV3iJtlJGgrlHej8uBKsW3a6mpHETr
 FYHpm4MN2O3CxPIcXxDdfQDGZSSOYpdN5bk9Bj3C+X0RvHhzjEZkAHbI+Py8H2PaLkyt
 aU2o3mbaRnip1FZoPuN+nrpMKUAioI7Q3+rIZe1h2pT5sEASO4U9NFi7PY+fpeJfVQS6
 5XEk+YPR817HZ7q1vjCIpQ/7jgr+QWRePunb/LyR3TeH1ocyytF1OtjdlxKvHhB8Aj/N
 GHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781553951; x=1782158751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEb54gd2Rtp2Daygv7fuzjQ7K8iflHr16hYCFnoSgKc=;
 b=fHZa6RpZcbCIs9oza6GxMuZjd3pe/VqkvD3qNNQLKr7Pl7JeYJW+HBzoWnPyI3k9/6
 J/sVMUmU9LCXEZrgBW9IonxU4Q8Virn9nmDK3lKbPDvmb69WkpnZARaDgVz9sgDUWlvM
 lSRumI0rpEtHQk4bCljoJyQvgBXGD6z5zXsBj/NCsO7MeyVgd4Vw4wQuL3A2apaL+kv2
 VtBOFK6mcSKk7GMokd86tygHIJxE11mZka3/h80TWi1fiOutthUNu48TeOmx/3kYysOv
 vgT6QuXx4X3unajhlq7SarYLDvaNOeSvpsx7zCaTLByV6WfJZz4tfQxHvEEkUDupESQF
 /gzA==
X-Gm-Message-State: AOJu0YysG0P1h8JzZPpagJC5Z6GBWiTrUI6wnpCJu/fBSOoX2yZV50eD
 +z/PI3w/vJXDzhUfo/4yNy+up7iMBuUov1GiMPG5zrGmKbgR8HiGPg79gOl2yFr6lxHqt4ofBx8
 dbz+DwOOp/8rSYVjoxtA00gZKqyeiqgLnLqVLjv/A/fvUKNS+cf60604L
X-Gm-Gg: Acq92OF0KSK4CpbZvwQWaYM9AjqQS9UxeRZ972xD66PWI53Efk2zQVbFXXm+D1EmRcY
 v6Jb1TVmuJI88WlXJxMLLz37YahGU1pzpISJrqBHyXZI/pzFaaOPT6LTXggMQJiBxLbZ2tGVIcv
 2UIHIBvWoLZRosVqc2Lf8+1//GFQy5XO1XIKZhVAybbWSDsjpjF0xYmz5rPbzKU+hP4XFkWBCwb
 pZKfxLaodCLytIbFlmH/TH3/JEi6cET7n4JMJew9EgIWXB7Hij29h3//S4dm7GlcQ+BFVat/j7A
 tIEz/Wu8eGd0qcjvhvL/5x7Y/cY1u+pGiHP/i2lM4wZ8nGXDPYznn5eBz0+yvEJSrqCZVCAfmSf
 iqIQMLVDS7rHabZ7hUGPrS61DSrZEDyd3WlKuVUKl7E0=
X-Received: by 2002:a05:600c:a210:b0:490:e60b:5fcd with SMTP id
 5b1f17b1804b1-490ec521002mr130998575e9.32.1781553950760; 
 Mon, 15 Jun 2026 13:05:50 -0700 (PDT)
X-Received: by 2002:a05:600c:a210:b0:490:e60b:5fcd with SMTP id
 5b1f17b1804b1-490ec521002mr130998095e9.32.1781553949985; 
 Mon, 15 Jun 2026 13:05:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d933esm35910242f8f.33.2026.06.15.13.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:05:48 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:05:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 000/106] pci, vhost, virtio, iommu: features, fixes,
 cleanups
Message-ID: <20260615155955-mutt-send-email-mst@kernel.org>
References: <cover.1781463125.git.mst@redhat.com>
 <CAJSP0QUL73AEJ0PMsWdDeG=Pf4dHy0WdPvf=W_qLaQAC=kDbAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QUL73AEJ0PMsWdDeG=Pf4dHy0WdPvf=W_qLaQAC=kDbAw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Mon, Jun 15, 2026 at 11:06:17AM -0400, Stefan Hajnoczi wrote:
> On Sun, Jun 14, 2026 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Resolved a bunch of conflicts.
> > If you see anything wrong here, pls holler.
> 
> Hi Michael,
> The check for mangled mailing list author emails is failing. Please
> `git commit --amend --author=...` with their real email and resend
> your pull request:
> 
> Alireza Sanaee via qemu development (2):
>       hw/cxl: Allow cxl_cfmws_find_device() to filter on whether
> interleaved paths are accepted
>       hw/cxl: Add a performant (and correct) path for the non interleaved cases
> ERROR: pull request includes commits attributed to list
> 
> Thanks!
> 
> Stefan


Fixed now, thanks!

new hash 062c1b7d033e675ea622939
 

> >
> >
> > The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee544:
> >
> >   Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into staging (2026-05-21 09:00:22 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 31dbba011d0f3a21432d0629fae0b4885f2eed25:
> >
> >   hw/scsi/vhost-scsi: fix build with older kernel headers (2026-06-03 08:36:42 -0400)
> >
> > ----------------------------------------------------------------
> > pci, vhost, virtio, iommu: features, fixes, cleanups
> >
> > intel_iommu:
> >     PASID support for passthrough
> >     some properties renamed
> > virtio-rtc:
> >     new device
> > acpi:
> >     watchdog (x86 q35)
> >     COM irqs are now shared
> > vhost-user:
> >     vhost-user passes GPA not HVA now
> >     vhost SHMEM_MAP/UNMAP support
> > vhost-vdpa:
> >     svq IN_ORDER support
> > amd_iommu:
> >     IOMMU XT interrupt support
> >     command buffer fixes
> > cxl:
> >     PPR support
> >     performant path for non-interleaved cases
> > vhost-scsi:
> >     build fix for older kernel headers
> > fixes, cleanups all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Aditya Gupta (2):
> >       ppc/pnv_phb3: Error out on invalid config access
> >       hw/pci: Replace assert with bounds check and return
> >
> > Albert Esteve (7):
> >       vhost-user: Add VirtIO Shared Memory map request
> >       vhost_user.rst: Align VhostUserMsg excerpt members
> >       vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
> >       vhost_user: Add frontend get_shmem_config command
> >       vhost_user.rst: Add GET_SHMEM_CONFIG message
> >       qmp: add shmem feature map
> >       vhost-user-device: Add shared memory BAR
> >
> > Alejandro Jimenez (3):
> >       amd_iommu: Update command buffer head ptr in MMIO region after wraparound
> >       amd_iommu: Follow root pointer before page walk and use 1-based levels
> >       amd_iommu: Reject non-decreasing NextLevel in fetch_pte()
> >
> > Alexandr Moshkov (1):
> >       vhost-user.rst: fix typo
> >
> > Alexey Gerasimenko (1):
> >       q35: Fix incorrect values for PCIEXBAR masks
> >
> > Alireza Sanaee via qemu development (2):
> >       hw/cxl: Allow cxl_cfmws_find_device() to filter on whether interleaved paths are accepted
> >       hw/cxl: Add a performant (and correct) path for the non interleaved cases
> >
> > Costas Argyris (1):
> >       tests/qtest: Add amd-iommu command buffer head wrap test
> >
> > Eugenio Pérez (8):
> >       net/vhost-vdpa: enable vqs before DRIVER_OK if no cvq
> >       virtio: Allow to fill a whole virtqueue in order
> >       vhost: move svq next desc array to descs state struct
> >       vhost: factor out the descriptor next fetching
> >       vhost: factor out the get of last used desc in SVQ
> >       vhost: factor out the detach buf logic in SVQ
> >       vhost: add in_order feature to shadow virtqueue
> >       vhost: accept in order feature flag
> >
> > Igor Mammedov (6):
> >       acpi: add API to build WDAT instructions
> >       x86: q35: add 'wdat' property
> >       x86: q35: generate WDAT ACPI table
> >       tests: acpi: x86/q35: whitelist new WDAT table
> >       tests: acpi: x86/q35: add WDAT table test case
> >       tests: acpi: x86/q35: update expected WDAT blob
> >
> > Jonathan Cameron (1):
> >       MAINTAINERS: Update CXL maintainers entry including adding linux-cxl list
> >
> > Jorge E. Moreira (1):
> >       vhost-user.rst: Explicitly allow front-end to write to kick FDs
> >
> > Junjie Cao (2):
> >       intel_iommu: fix guest-triggerable abort on oversized MMIO access
> >       tests/qtest: add 8-byte MMIO access sweep for intel-iommu
> >
> > Kuan-Wei Chiu (3):
> >       vhost-user: Fix stale error logs and return values in teardown paths
> >       standard-headers: Add virtio_rtc.h from Linux 7.0-rc1
> >       virtio-rtc: Add basic virtio-rtc support
> >
> > Mark Cave-Ayland (4):
> >       hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ descriptor
> >       tests/acpi: allow DSDT acpi table changes
> >       hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
> >       tests: data: update x86 ACPI tables
> >
> > Max Makarov (2):
> >       vhost-user-blk-server: do not advertise VIRTIO_BLK_F_SIZE_MAX with size_max=0
> >       vhost-user-blk: do not force VIRTIO_BLK_F_SIZE_MAX
> >
> > Paolo Bonzini (1):
> >       amd_iommu: restrict command buffer head/tail ranges to ring size
> >
> > Quan Sun (1):
> >       hw/scsi/vhost-scsi: fix build with older kernel headers
> >
> > Sairaj Kodilkar (3):
> >       amd_iommu: Use switch case to determine mmio register name
> >       amd_iommu: Turn on XT support only when guest has enabled it
> >       amd_iommu: Generate XT interrupts when xt support is enabled
> >
> > Shiju Jose (3):
> >       hw/cxl: Fix handling of component ID to not assume it is a string
> >       hw/cxl: Add fixes in Post Package Repair (PPR)
> >       hw/cxl/events: Fix handling of component ID in event records generation to not assume it is a string
> >
> > Stefano Garzarella (2):
> >       libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc()
> >       libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()
> >
> > Thomas Huth (1):
> >       hw/i386/pc: Add a proper owner for the ioport memory regions
> >
> > Vladimir Sementsov-Ogievskiy (32):
> >       vhost-user: rework enabling vrings
> >       vhost: drop backend_features field
> >       vhost-user: introduce vhost_user_has_protocol_feature() helper
> >       vhost: move protocol_features to vhost_user
> >       vhost-user-gpu: drop code duplication
> >       vhost: make vhost_dev.features private
> >       virtio: move common part of _set_guest_notifier to generic code
> >       virtio: drop *_set_guest_notifier_fd_handler() helpers
> >       vhost-user: keep QIOChannelSocket for backend channel
> >       vhost: vhost_virtqueue_start(): fix failure path
> >       vhost: make vhost_memory_unmap() null-safe
> >       vhost: simplify calls to vhost_memory_unmap()
> >       vhost: move vrings mapping to the top of vhost_virtqueue_start()
> >       vhost: vhost_virtqueue_start(): drop extra local variables
> >       vhost: final refactoring of vhost vrings map/unmap
> >       vhost: simplify vhost_dev_init() error-path
> >       vhost: move busyloop timeout initialization to vhost_virtqueue_init()
> >       vhost: vhost_dev_init(): simplify features initialization
> >       hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
> >       vhost-user: make trace events more readable
> >       vhost-user-blk: add some useful trace-points
> >       vhost: add some useful trace-points
> >       vhost: move IOTLB functions from vhost-backend.c to vhost.c
> >       vhost: use consistent naming for backend handlers
> >       vhost: rename vhost-backend.c to vhost-kernel.c
> >       vhost: replace .vhost_vq_get_addr() with .vhost_phys_vring_addr()
> >       vhost: simplify vhost_memory_map() and vhost_memory_unmap()
> >       qapi: remove user addresses from x-query-virtio-vhost-queue-status
> >       vhost: stop reusing vq->desc (and friends) to store physical address
> >       vhost: rename vring pointer fields to reflect user addresses
> >       vhost: add .vhost_phys_iotlb_msg() handler
> >       vhost-user: add VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
> >
> > Zhenzhong Duan (19):
> >       intel_iommu: Remove 'x-' prefix from 'x-scalable-mode' and 'x-flts' properties
> >       intel_iommu: Change 'flts' property naming to 'fsts'
> >       vfio/iommufd: Extend attach/detach_hwpt callback implementations with pasid
> >       iommufd: Extend attach/detach_hwpt callbacks to support pasid
> >       vfio/iommufd: Create nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID flag
> >       intel_iommu: Create the nested hwpt with IOMMU_HWPT_ALLOC_PASID flag
> >       intel_iommu: Rename pasid property to "pasid-bits" and define it as type uint8
> >       intel_iommu: make vtd_dev_get_pe_from_pasid() more generic
> >       intel_iommu: Export some functions
> >       intel_iommu: Fix PASID validity check in fault reporting
> >       intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
> >       intel_iommu: Refactor PASID processing to use IOMMU_NO_PASID internally
> >       intel_iommu_accel: Handle PASID entry addition for pc_inv_dsc request
> >       intel_iommu_accel: Handle PASID entry removal for pc_inv_dsc request
> >       intel_iommu_accel: Bypass PASID entry addition for just deleted entry
> >       intel_iommu_accel: Handle PASID entry removal for system reset
> >       intel_iommu_accel: Switch to VTDAccelPASIDCacheEntry for PASID bind/unbind and PIOTLB invalidation
> >       intel_iommu_accel: Add pasid bits size check
> >       intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED and VIOMMU_FLAG_WANT_PASID_ATTACH
> >
> >  MAINTAINERS                                       |  12 +-
> >  backends/cryptodev-vhost.c                        |   9 +-
> >  backends/iommufd.c                                |  23 +-
> >  backends/vhost-user.c                             |   8 +-
> >  block/export/vhost-user-blk-server.c              |   2 +-
> >  docs/devel/vfio-iommufd.rst                       |  10 +-
> >  docs/interop/vhost-user.rst                       | 135 +++++-
> >  hw/acpi/aml-build-stub.c                          |   6 +
> >  hw/acpi/aml-build.c                               |  41 ++
> >  hw/acpi/meson.build                               |   3 +-
> >  hw/acpi/wdat-ich9-stub.c                          |  15 +
> >  hw/acpi/wdat-ich9.c                               |  90 ++++
> >  hw/arm/smmuv3-accel.c                             |  12 +-
> >  hw/block/trace-events                             |  10 +
> >  hw/block/vhost-user-blk.c                         |  36 +-
> >  hw/char/serial-isa.c                              |   3 +-
> >  hw/cxl/cxl-component-utils.c                      |   6 +
> >  hw/cxl/cxl-host.c                                 | 234 ++++++++-
> >  hw/cxl/cxl-mailbox-utils.c                        |   6 +-
> >  hw/display/vhost-user-gpu.c                       |  11 +-
> >  hw/i386/acpi-build.c                              |  12 +
> >  hw/i386/amd_iommu.c                               | 288 +++++++----
> >  hw/i386/amd_iommu.h                               |  36 +-
> >  hw/i386/intel_iommu.c                             | 352 +++++++-------
> >  hw/i386/intel_iommu_accel.c                       | 401 ++++++++++++---
> >  hw/i386/intel_iommu_accel.h                       |  20 +-
> >  hw/i386/intel_iommu_internal.h                    |  44 +-
> >  hw/i386/pc.c                                      |   6 +-
> >  hw/i386/pc_q35.c                                  |  18 +
> >  hw/i386/trace-events                              |   1 +
> >  hw/mem/cxl_type3.c                                |  17 +-
> >  hw/net/vhost_net.c                                |  35 +-
> >  hw/pci-host/pnv_phb3.c                            |  10 +
> >  hw/pci-host/q35.c                                 |   6 +-
> >  hw/pci/pci_host.c                                 |  14 +-
> >  hw/s390x/virtio-ccw.c                             |  35 +-
> >  hw/scsi/vhost-scsi-common.c                       |   2 +-
> >  hw/scsi/vhost-scsi.c                              |   2 +-
> >  hw/scsi/vhost-user-scsi.c                         |   1 -
> >  hw/vfio/device.c                                  |  11 +
> >  hw/vfio/iommufd.c                                 |  68 ++-
> >  hw/vfio/trace-events                              |   4 +-
> >  hw/virtio/Kconfig                                 |   5 +
> >  hw/virtio/meson.build                             |   5 +-
> >  hw/virtio/trace-events                            |  16 +-
> >  hw/virtio/vdpa-dev.c                              |   3 +-
> >  hw/virtio/{vhost-backend.c => vhost-kernel.c}     |  90 +---
> >  hw/virtio/vhost-shadow-virtqueue.c                | 215 ++++++--
> >  hw/virtio/vhost-shadow-virtqueue.h                |  38 +-
> >  hw/virtio/vhost-user-base.c                       |  63 ++-
> >  hw/virtio/vhost-user-fs.c                         |   9 +-
> >  hw/virtio/vhost-user-scmi.c                       |   9 +-
> >  hw/virtio/vhost-user-stub.c                       |   6 +
> >  hw/virtio/vhost-user-test-device-pci.c            |  42 +-
> >  hw/virtio/vhost-user.c                            | 566 ++++++++++++++++++----
> >  hw/virtio/vhost-vdpa.c                            |  19 +-
> >  hw/virtio/vhost-vsock-common.c                    |   9 +-
> >  hw/virtio/vhost.c                                 | 384 +++++++++------
> >  hw/virtio/virtio-bus.c                            |  18 +-
> >  hw/virtio/virtio-hmp-cmds.c                       |   5 -
> >  hw/virtio/virtio-mmio.c                           |  41 +-
> >  hw/virtio/virtio-pci.c                            |  34 +-
> >  hw/virtio/virtio-qmp.c                            |  18 +-
> >  hw/virtio/virtio-rtc-pci.c                        |  65 +++
> >  hw/virtio/virtio-rtc.c                            | 190 ++++++++
> >  hw/virtio/virtio.c                                | 251 +++++++++-
> >  include/hw/acpi/aml-build.h                       |   2 +
> >  include/hw/acpi/wdat-ich9.h                       |  15 +
> >  include/hw/acpi/wdat.h                            | 118 +++++
> >  include/hw/core/iommu.h                           |  14 +
> >  include/hw/cxl/cxl.h                              |   1 +
> >  include/hw/cxl/cxl_device.h                       |   4 +
> >  include/hw/i386/intel_iommu.h                     |   4 +-
> >  include/hw/i386/pc.h                              |   1 +
> >  include/hw/pci-host/q35.h                         |   4 +-
> >  include/hw/vfio/vfio-device.h                     |   1 +
> >  include/hw/virtio/vhost-backend.h                 |  47 +-
> >  include/hw/virtio/vhost-user.h                    |   6 +
> >  include/hw/virtio/vhost.h                         |  71 ++-
> >  include/hw/virtio/virtio-pci.h                    |   3 -
> >  include/hw/virtio/virtio-rtc.h                    |  22 +
> >  include/hw/virtio/virtio.h                        | 151 +++++-
> >  include/standard-headers/linux/virtio_rtc.h       | 237 +++++++++
> >  include/system/iommufd.h                          |  18 +-
> >  include/system/memory.h                           |   4 +-
> >  net/vhost-vdpa.c                                  |  37 +-
> >  qapi/virtio.json                                  |  18 -
> >  subprojects/libvduse/libvduse.c                   |   7 +-
> >  subprojects/libvhost-user/libvhost-user.c         |  77 ++-
> >  subprojects/libvhost-user/libvhost-user.h         |  56 +++
> >  system/memory.c                                   |  14 +
> >  tests/data/acpi/x86/microvm/DSDT                  | Bin 365 -> 366 bytes
> >  tests/data/acpi/x86/microvm/DSDT.ioapic2          | Bin 365 -> 366 bytes
> >  tests/data/acpi/x86/microvm/DSDT.pcie             | Bin 2985 -> 2986 bytes
> >  tests/data/acpi/x86/microvm/DSDT.rtc              | Bin 404 -> 405 bytes
> >  tests/data/acpi/x86/microvm/DSDT.usb              | Bin 414 -> 415 bytes
> >  tests/data/acpi/x86/pc/DSDT                       | Bin 8598 -> 8599 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpierst              | Bin 8509 -> 8510 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpihmat              | Bin 9923 -> 9924 bytes
> >  tests/data/acpi/x86/pc/DSDT.bridge                | Bin 15469 -> 15470 bytes
> >  tests/data/acpi/x86/pc/DSDT.cphp                  | Bin 9062 -> 9063 bytes
> >  tests/data/acpi/x86/pc/DSDT.dimmpxm               | Bin 10252 -> 10253 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbridge              | Bin 8549 -> 8550 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbrroot              | Bin 5087 -> 5088 bytes
> >  tests/data/acpi/x86/pc/DSDT.ipmikcs               | Bin 8670 -> 8671 bytes
> >  tests/data/acpi/x86/pc/DSDT.memhp                 | Bin 9957 -> 9958 bytes
> >  tests/data/acpi/x86/pc/DSDT.nohpet                | Bin 8456 -> 8457 bytes
> >  tests/data/acpi/x86/pc/DSDT.numamem               | Bin 8604 -> 8605 bytes
> >  tests/data/acpi/x86/pc/DSDT.roothp                | Bin 12391 -> 12392 bytes
> >  tests/data/acpi/x86/q35/DSDT                      | Bin 8427 -> 8428 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpierst             | Bin 8444 -> 8445 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpihmat             | Bin 9752 -> 9753 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x   | Bin 12637 -> 12638 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator | Bin 8706 -> 8707 bytes
> >  tests/data/acpi/x86/q35/DSDT.applesmc             | Bin 8473 -> 8474 bytes
> >  tests/data/acpi/x86/q35/DSDT.bridge               | Bin 12040 -> 12041 bytes
> >  tests/data/acpi/x86/q35/DSDT.core-count           | Bin 12985 -> 12986 bytes
> >  tests/data/acpi/x86/q35/DSDT.core-count2          | Bin 33842 -> 33843 bytes
> >  tests/data/acpi/x86/q35/DSDT.cphp                 | Bin 8891 -> 8892 bytes
> >  tests/data/acpi/x86/q35/DSDT.cxl                  | Bin 13218 -> 13219 bytes
> >  tests/data/acpi/x86/q35/DSDT.dimmpxm              | Bin 10081 -> 10082 bytes
> >  tests/data/acpi/x86/q35/DSDT.ipmibt               | Bin 8502 -> 8503 bytes
> >  tests/data/acpi/x86/q35/DSDT.ipmismbus            | Bin 8515 -> 8516 bytes
> >  tests/data/acpi/x86/q35/DSDT.ivrs                 | Bin 8444 -> 8445 bytes
> >  tests/data/acpi/x86/q35/DSDT.memhp                | Bin 9786 -> 9787 bytes
> >  tests/data/acpi/x86/q35/DSDT.mmio64               | Bin 9557 -> 9558 bytes
> >  tests/data/acpi/x86/q35/DSDT.multi-bridge         | Bin 13280 -> 13281 bytes
> >  tests/data/acpi/x86/q35/DSDT.noacpihp             | Bin 8289 -> 8290 bytes
> >  tests/data/acpi/x86/q35/DSDT.nohpet               | Bin 8285 -> 8286 bytes
> >  tests/data/acpi/x86/q35/DSDT.numamem              | Bin 8433 -> 8434 bytes
> >  tests/data/acpi/x86/q35/DSDT.pvpanic-isa          | Bin 8528 -> 8529 bytes
> >  tests/data/acpi/x86/q35/DSDT.thread-count         | Bin 12985 -> 12986 bytes
> >  tests/data/acpi/x86/q35/DSDT.thread-count2        | Bin 33842 -> 33843 bytes
> >  tests/data/acpi/x86/q35/DSDT.tis.tpm12            | Bin 9033 -> 9034 bytes
> >  tests/data/acpi/x86/q35/DSDT.tis.tpm2             | Bin 9059 -> 9060 bytes
> >  tests/data/acpi/x86/q35/DSDT.type4-count          | Bin 18661 -> 18662 bytes
> >  tests/data/acpi/x86/q35/DSDT.viot                 | Bin 14684 -> 14685 bytes
> >  tests/data/acpi/x86/q35/DSDT.xapic                | Bin 35790 -> 35791 bytes
> >  tests/data/acpi/x86/q35/WDAT.wdat                 | Bin 0 -> 308 bytes
> >  tests/qtest/amd-iommu-test.c                      |  76 +++
> >  tests/qtest/bios-tables-test.c                    |  13 +
> >  tests/qtest/intel-iommu-test.c                    |  32 +-
> >  tests/qtest/iommu-intel-test.c                    |   4 +-
> >  tests/qtest/meson.build                           |   1 +
> >  144 files changed, 4056 insertions(+), 1158 deletions(-)
> >  create mode 100644 hw/acpi/wdat-ich9-stub.c
> >  create mode 100644 hw/acpi/wdat-ich9.c
> >  rename hw/virtio/{vhost-backend.c => vhost-kernel.c} (83%)
> >  create mode 100644 hw/virtio/vhost-user-stub.c
> >  create mode 100644 hw/virtio/virtio-rtc-pci.c
> >  create mode 100644 hw/virtio/virtio-rtc.c
> >  create mode 100644 include/hw/acpi/wdat-ich9.h
> >  create mode 100644 include/hw/acpi/wdat.h
> >  create mode 100644 include/hw/virtio/virtio-rtc.h
> >  create mode 100644 include/standard-headers/linux/virtio_rtc.h
> >  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
> >  create mode 100644 tests/qtest/amd-iommu-test.c
> >
> >


