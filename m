Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB554CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8tf-00054B-Hl; Mon, 15 Jun 2026 11:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wZ8tb-00053L-EW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:06:39 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wZ8tY-000202-3E
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:06:39 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso7795415a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 08:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535992; cv=none;
 d=google.com; s=arc-20240605;
 b=JYaWPKuKmWnNTy6e9mOT0gF4GLW51sxMK5EG1bMHQMvLqii/v8Xd7WWvy5RDpElznT
 GZhyA2BmLk4TzKGn6NShag3wByAO8tIc+Eqa2ZTX3bNsGbFgKns8euWwWbibn0LkXlIw
 AwPBxU1xkKP7ILhnphVcUg+IUAO1/X6v8bNAoOMp+1tIduy4z3g8iwt/YVicqAHEZafM
 gZy+b/u1MJqDotxrGAWgKYugz+C6zzCDm0mSBP5GP09mX5idqN75zdhwi8Ux5PwZQN3I
 nTbpbpk5Gy15j1BZRWZ/y56MTsxw+FnVpmwXUA9JhUoN5qzwwklmDtwEpC8PVgsp+LmA
 CrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pFYByo20LRa6uECgcZYWwiRTb5caXn3c8lCuM6o+YWQ=;
 fh=NslLSXajYw6/fhaduPFA3iYcwKcIqwkl+hWoUZd07+o=;
 b=JxxkBWtaINzV3Ik0yCVrf47hhY4N0wMBRvL1mIDF9Hpi3F/TiT8tJW85mrjHoMMUX0
 Dr/UvYnpIv5f+ibjckpNnw76HbqvlltKTZ48OverqBnvmUqn0nOMG1cMkBqtCzFNlDgD
 exAsks6d/OiXc6OtU+dYiUB6mqFJzE4p9E/gbVjZZ3gowwkHoINsXevcn0GsrX7J0tHy
 J8lCfx+j8v6yZUJiHDNCrbO8X6g/Kga/YtlNhEXWQcJ8UvO6VR4HiTLWDnKNQeoQV4en
 JcF4rOKq7tQ4WVafCmYQUHeM1NK1rxIR6wx6qerZ4HKzPlfYhsSGcm77o3WFJH5FdQku
 MFlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781535992; x=1782140792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFYByo20LRa6uECgcZYWwiRTb5caXn3c8lCuM6o+YWQ=;
 b=RUMEhSrvq8fhOqrF3Wo3b7M0U6pZtVCaZ2md9z0oaH6gklUDWzDcrDJLNIiWWfNGAc
 4fXZmEqaxheBxo9jCaPPO1DSnbYWgXwlKI48iTeW0KMI3ZB0STh+/rowZnlnyKVPF/cO
 tzzlCC7V9VoedFAGRsXVcmYYPYqbrQnYgihuJ2+z515SFmDOPDhg2DoUPEuZJE5NiZ4X
 JTbMvgADcyATAXpQYX2aikwPynrd6QX96E46wqnlBJkuofd4jTZ002i4pb1VnlP26Btx
 pQBn1zw2nzKY+oUKTlq8fBEVs96Jiu+dhoP8HgSy39c+bgyDNzfifz3Tfjx+R1cdRMWr
 Qfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781535992; x=1782140792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pFYByo20LRa6uECgcZYWwiRTb5caXn3c8lCuM6o+YWQ=;
 b=EmChnuM+Um6HuAVgHJA0JPyvVmw1es1vmf/TTjH2spq6OjMLqRt6xNHjIxDYYHNaP6
 1OyljT5EHyLgtJv0Z8T1cK+g8tNx/c90UAIcrVZXi370bWJdM3sdOzOay3ZvAvm1K1Cn
 I5gE4uUUTlP3BqHyGe90oT1K67Zae+6F4h1gZPtHIHakoDQOIsYQfXRcsz98UTR+iW1e
 nFbyKFv9YT3JoQqcwPx6duHKAVcbrAcSpXs0KGOH76lU89nvMc4eMkdoJxKUy6X70FiT
 zazAzuQ6zmO0OtzocmztC/aBo1FATXChOfC7/MYXaLEfGnzw8p7QbVy6yHG4N0NqkK6i
 GMRw==
X-Gm-Message-State: AOJu0Yy0vDZ7rbaDoLHuqCVrkjnEmq3SlDHssiRA1fdqyx/2QXDp9Tyy
 TpG/vKjSHkT60shJt9GkhXXr9pfwvZNw7wosdvK6b1LZIuZkecDoTpbIrr8/XKj2/Gk9C+LMt9v
 nk1e+Uzwhils5aFFcxIJnAY3fKecYDkM=
X-Gm-Gg: Acq92OEwh+N1oh0vC1xqGbRJcBIE5ZmzprbEftXX2oTOx2viS48+wb34jrfxxSjKC7l
 YK+pAYl0AGmMmYuseDBvyn4d4s9JTt5pVq4mlCArQnX/eecKa/JtICaxP55lFPTJkqbkpC0Pw90
 fh/guwDMXbozjGNCTZz9q//BWzAM2pylPTcyLCKeMvyURoXhzS8iI7JpfVF3GpDyLPz/0a9keAt
 nhxTrzxinknsI//TnYtVAhv6XlPfCf1LCSdyzVymRdPizK7F6UQq5Joeg0isRroWyaAVsv4nShW
 WrKUUjvJHVR+ZUoz1HbmdGYRLJdD9rvIWN12Rs3uZqFo+DzfjiFy
X-Received: by 2002:a05:6402:380e:b0:692:4758:f56 with SMTP id
 4fb4d7f45d1cf-69378ffca29mr5519638a12.10.1781535991791; Mon, 15 Jun 2026
 08:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781463125.git.mst@redhat.com>
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 15 Jun 2026 11:06:17 -0400
X-Gm-Features: AVVi8CcmjapWBAr4gU-LUyfqA04QgpH4ZQPzCF3APxB_gqhf5JQeSbUUeAAbGcc
Message-ID: <CAJSP0QUL73AEJ0PMsWdDeG=Pf4dHy0WdPvf=W_qLaQAC=kDbAw@mail.gmail.com>
Subject: Re: [PULL 000/106] pci, vhost, virtio, iommu: features, fixes,
 cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, Jun 14, 2026 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Resolved a bunch of conflicts.
> If you see anything wrong here, pls holler.

Hi Michael,
The check for mangled mailing list author emails is failing. Please
`git commit --amend --author=3D...` with their real email and resend
your pull request:

Alireza Sanaee via qemu development (2):
      hw/cxl: Allow cxl_cfmws_find_device() to filter on whether
interleaved paths are accepted
      hw/cxl: Add a performant (and correct) path for the non interleaved c=
ases
ERROR: pull request includes commits attributed to list

Thanks!

Stefan

>
>
> The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee5=
44:
>
>   Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into=
 staging (2026-05-21 09:00:22 -0400)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 31dbba011d0f3a21432d0629fae0b4885f2eed25:
>
>   hw/scsi/vhost-scsi: fix build with older kernel headers (2026-06-03 08:=
36:42 -0400)
>
> ----------------------------------------------------------------
> pci, vhost, virtio, iommu: features, fixes, cleanups
>
> intel_iommu:
>     PASID support for passthrough
>     some properties renamed
> virtio-rtc:
>     new device
> acpi:
>     watchdog (x86 q35)
>     COM irqs are now shared
> vhost-user:
>     vhost-user passes GPA not HVA now
>     vhost SHMEM_MAP/UNMAP support
> vhost-vdpa:
>     svq IN_ORDER support
> amd_iommu:
>     IOMMU XT interrupt support
>     command buffer fixes
> cxl:
>     PPR support
>     performant path for non-interleaved cases
> vhost-scsi:
>     build fix for older kernel headers
> fixes, cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Aditya Gupta (2):
>       ppc/pnv_phb3: Error out on invalid config access
>       hw/pci: Replace assert with bounds check and return
>
> Albert Esteve (7):
>       vhost-user: Add VirtIO Shared Memory map request
>       vhost_user.rst: Align VhostUserMsg excerpt members
>       vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>       vhost_user: Add frontend get_shmem_config command
>       vhost_user.rst: Add GET_SHMEM_CONFIG message
>       qmp: add shmem feature map
>       vhost-user-device: Add shared memory BAR
>
> Alejandro Jimenez (3):
>       amd_iommu: Update command buffer head ptr in MMIO region after wrap=
around
>       amd_iommu: Follow root pointer before page walk and use 1-based lev=
els
>       amd_iommu: Reject non-decreasing NextLevel in fetch_pte()
>
> Alexandr Moshkov (1):
>       vhost-user.rst: fix typo
>
> Alexey Gerasimenko (1):
>       q35: Fix incorrect values for PCIEXBAR masks
>
> Alireza Sanaee via qemu development (2):
>       hw/cxl: Allow cxl_cfmws_find_device() to filter on whether interlea=
ved paths are accepted
>       hw/cxl: Add a performant (and correct) path for the non interleaved=
 cases
>
> Costas Argyris (1):
>       tests/qtest: Add amd-iommu command buffer head wrap test
>
> Eugenio P=C3=A9rez (8):
>       net/vhost-vdpa: enable vqs before DRIVER_OK if no cvq
>       virtio: Allow to fill a whole virtqueue in order
>       vhost: move svq next desc array to descs state struct
>       vhost: factor out the descriptor next fetching
>       vhost: factor out the get of last used desc in SVQ
>       vhost: factor out the detach buf logic in SVQ
>       vhost: add in_order feature to shadow virtqueue
>       vhost: accept in order feature flag
>
> Igor Mammedov (6):
>       acpi: add API to build WDAT instructions
>       x86: q35: add 'wdat' property
>       x86: q35: generate WDAT ACPI table
>       tests: acpi: x86/q35: whitelist new WDAT table
>       tests: acpi: x86/q35: add WDAT table test case
>       tests: acpi: x86/q35: update expected WDAT blob
>
> Jonathan Cameron (1):
>       MAINTAINERS: Update CXL maintainers entry including adding linux-cx=
l list
>
> Jorge E. Moreira (1):
>       vhost-user.rst: Explicitly allow front-end to write to kick FDs
>
> Junjie Cao (2):
>       intel_iommu: fix guest-triggerable abort on oversized MMIO access
>       tests/qtest: add 8-byte MMIO access sweep for intel-iommu
>
> Kuan-Wei Chiu (3):
>       vhost-user: Fix stale error logs and return values in teardown path=
s
>       standard-headers: Add virtio_rtc.h from Linux 7.0-rc1
>       virtio-rtc: Add basic virtio-rtc support
>
> Mark Cave-Ayland (4):
>       hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ desc=
riptor
>       tests/acpi: allow DSDT acpi table changes
>       hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
>       tests: data: update x86 ACPI tables
>
> Max Makarov (2):
>       vhost-user-blk-server: do not advertise VIRTIO_BLK_F_SIZE_MAX with =
size_max=3D0
>       vhost-user-blk: do not force VIRTIO_BLK_F_SIZE_MAX
>
> Paolo Bonzini (1):
>       amd_iommu: restrict command buffer head/tail ranges to ring size
>
> Quan Sun (1):
>       hw/scsi/vhost-scsi: fix build with older kernel headers
>
> Sairaj Kodilkar (3):
>       amd_iommu: Use switch case to determine mmio register name
>       amd_iommu: Turn on XT support only when guest has enabled it
>       amd_iommu: Generate XT interrupts when xt support is enabled
>
> Shiju Jose (3):
>       hw/cxl: Fix handling of component ID to not assume it is a string
>       hw/cxl: Add fixes in Post Package Repair (PPR)
>       hw/cxl/events: Fix handling of component ID in event records genera=
tion to not assume it is a string
>
> Stefano Garzarella (2):
>       libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc(=
)
>       libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()
>
> Thomas Huth (1):
>       hw/i386/pc: Add a proper owner for the ioport memory regions
>
> Vladimir Sementsov-Ogievskiy (32):
>       vhost-user: rework enabling vrings
>       vhost: drop backend_features field
>       vhost-user: introduce vhost_user_has_protocol_feature() helper
>       vhost: move protocol_features to vhost_user
>       vhost-user-gpu: drop code duplication
>       vhost: make vhost_dev.features private
>       virtio: move common part of _set_guest_notifier to generic code
>       virtio: drop *_set_guest_notifier_fd_handler() helpers
>       vhost-user: keep QIOChannelSocket for backend channel
>       vhost: vhost_virtqueue_start(): fix failure path
>       vhost: make vhost_memory_unmap() null-safe
>       vhost: simplify calls to vhost_memory_unmap()
>       vhost: move vrings mapping to the top of vhost_virtqueue_start()
>       vhost: vhost_virtqueue_start(): drop extra local variables
>       vhost: final refactoring of vhost vrings map/unmap
>       vhost: simplify vhost_dev_init() error-path
>       vhost: move busyloop timeout initialization to vhost_virtqueue_init=
()
>       vhost: vhost_dev_init(): simplify features initialization
>       hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>       vhost-user: make trace events more readable
>       vhost-user-blk: add some useful trace-points
>       vhost: add some useful trace-points
>       vhost: move IOTLB functions from vhost-backend.c to vhost.c
>       vhost: use consistent naming for backend handlers
>       vhost: rename vhost-backend.c to vhost-kernel.c
>       vhost: replace .vhost_vq_get_addr() with .vhost_phys_vring_addr()
>       vhost: simplify vhost_memory_map() and vhost_memory_unmap()
>       qapi: remove user addresses from x-query-virtio-vhost-queue-status
>       vhost: stop reusing vq->desc (and friends) to store physical addres=
s
>       vhost: rename vring pointer fields to reflect user addresses
>       vhost: add .vhost_phys_iotlb_msg() handler
>       vhost-user: add VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
>
> Zhenzhong Duan (19):
>       intel_iommu: Remove 'x-' prefix from 'x-scalable-mode' and 'x-flts'=
 properties
>       intel_iommu: Change 'flts' property naming to 'fsts'
>       vfio/iommufd: Extend attach/detach_hwpt callback implementations wi=
th pasid
>       iommufd: Extend attach/detach_hwpt callbacks to support pasid
>       vfio/iommufd: Create nesting parent hwpt with IOMMU_HWPT_ALLOC_PASI=
D flag
>       intel_iommu: Create the nested hwpt with IOMMU_HWPT_ALLOC_PASID fla=
g
>       intel_iommu: Rename pasid property to "pasid-bits" and define it as=
 type uint8
>       intel_iommu: make vtd_dev_get_pe_from_pasid() more generic
>       intel_iommu: Export some functions
>       intel_iommu: Fix PASID validity check in fault reporting
>       intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
>       intel_iommu: Refactor PASID processing to use IOMMU_NO_PASID intern=
ally
>       intel_iommu_accel: Handle PASID entry addition for pc_inv_dsc reque=
st
>       intel_iommu_accel: Handle PASID entry removal for pc_inv_dsc reques=
t
>       intel_iommu_accel: Bypass PASID entry addition for just deleted ent=
ry
>       intel_iommu_accel: Handle PASID entry removal for system reset
>       intel_iommu_accel: Switch to VTDAccelPASIDCacheEntry for PASID bind=
/unbind and PIOTLB invalidation
>       intel_iommu_accel: Add pasid bits size check
>       intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED and VIOMMU_FLA=
G_WANT_PASID_ATTACH
>
>  MAINTAINERS                                       |  12 +-
>  backends/cryptodev-vhost.c                        |   9 +-
>  backends/iommufd.c                                |  23 +-
>  backends/vhost-user.c                             |   8 +-
>  block/export/vhost-user-blk-server.c              |   2 +-
>  docs/devel/vfio-iommufd.rst                       |  10 +-
>  docs/interop/vhost-user.rst                       | 135 +++++-
>  hw/acpi/aml-build-stub.c                          |   6 +
>  hw/acpi/aml-build.c                               |  41 ++
>  hw/acpi/meson.build                               |   3 +-
>  hw/acpi/wdat-ich9-stub.c                          |  15 +
>  hw/acpi/wdat-ich9.c                               |  90 ++++
>  hw/arm/smmuv3-accel.c                             |  12 +-
>  hw/block/trace-events                             |  10 +
>  hw/block/vhost-user-blk.c                         |  36 +-
>  hw/char/serial-isa.c                              |   3 +-
>  hw/cxl/cxl-component-utils.c                      |   6 +
>  hw/cxl/cxl-host.c                                 | 234 ++++++++-
>  hw/cxl/cxl-mailbox-utils.c                        |   6 +-
>  hw/display/vhost-user-gpu.c                       |  11 +-
>  hw/i386/acpi-build.c                              |  12 +
>  hw/i386/amd_iommu.c                               | 288 +++++++----
>  hw/i386/amd_iommu.h                               |  36 +-
>  hw/i386/intel_iommu.c                             | 352 +++++++-------
>  hw/i386/intel_iommu_accel.c                       | 401 ++++++++++++---
>  hw/i386/intel_iommu_accel.h                       |  20 +-
>  hw/i386/intel_iommu_internal.h                    |  44 +-
>  hw/i386/pc.c                                      |   6 +-
>  hw/i386/pc_q35.c                                  |  18 +
>  hw/i386/trace-events                              |   1 +
>  hw/mem/cxl_type3.c                                |  17 +-
>  hw/net/vhost_net.c                                |  35 +-
>  hw/pci-host/pnv_phb3.c                            |  10 +
>  hw/pci-host/q35.c                                 |   6 +-
>  hw/pci/pci_host.c                                 |  14 +-
>  hw/s390x/virtio-ccw.c                             |  35 +-
>  hw/scsi/vhost-scsi-common.c                       |   2 +-
>  hw/scsi/vhost-scsi.c                              |   2 +-
>  hw/scsi/vhost-user-scsi.c                         |   1 -
>  hw/vfio/device.c                                  |  11 +
>  hw/vfio/iommufd.c                                 |  68 ++-
>  hw/vfio/trace-events                              |   4 +-
>  hw/virtio/Kconfig                                 |   5 +
>  hw/virtio/meson.build                             |   5 +-
>  hw/virtio/trace-events                            |  16 +-
>  hw/virtio/vdpa-dev.c                              |   3 +-
>  hw/virtio/{vhost-backend.c =3D> vhost-kernel.c}     |  90 +---
>  hw/virtio/vhost-shadow-virtqueue.c                | 215 ++++++--
>  hw/virtio/vhost-shadow-virtqueue.h                |  38 +-
>  hw/virtio/vhost-user-base.c                       |  63 ++-
>  hw/virtio/vhost-user-fs.c                         |   9 +-
>  hw/virtio/vhost-user-scmi.c                       |   9 +-
>  hw/virtio/vhost-user-stub.c                       |   6 +
>  hw/virtio/vhost-user-test-device-pci.c            |  42 +-
>  hw/virtio/vhost-user.c                            | 566 ++++++++++++++++=
++----
>  hw/virtio/vhost-vdpa.c                            |  19 +-
>  hw/virtio/vhost-vsock-common.c                    |   9 +-
>  hw/virtio/vhost.c                                 | 384 +++++++++------
>  hw/virtio/virtio-bus.c                            |  18 +-
>  hw/virtio/virtio-hmp-cmds.c                       |   5 -
>  hw/virtio/virtio-mmio.c                           |  41 +-
>  hw/virtio/virtio-pci.c                            |  34 +-
>  hw/virtio/virtio-qmp.c                            |  18 +-
>  hw/virtio/virtio-rtc-pci.c                        |  65 +++
>  hw/virtio/virtio-rtc.c                            | 190 ++++++++
>  hw/virtio/virtio.c                                | 251 +++++++++-
>  include/hw/acpi/aml-build.h                       |   2 +
>  include/hw/acpi/wdat-ich9.h                       |  15 +
>  include/hw/acpi/wdat.h                            | 118 +++++
>  include/hw/core/iommu.h                           |  14 +
>  include/hw/cxl/cxl.h                              |   1 +
>  include/hw/cxl/cxl_device.h                       |   4 +
>  include/hw/i386/intel_iommu.h                     |   4 +-
>  include/hw/i386/pc.h                              |   1 +
>  include/hw/pci-host/q35.h                         |   4 +-
>  include/hw/vfio/vfio-device.h                     |   1 +
>  include/hw/virtio/vhost-backend.h                 |  47 +-
>  include/hw/virtio/vhost-user.h                    |   6 +
>  include/hw/virtio/vhost.h                         |  71 ++-
>  include/hw/virtio/virtio-pci.h                    |   3 -
>  include/hw/virtio/virtio-rtc.h                    |  22 +
>  include/hw/virtio/virtio.h                        | 151 +++++-
>  include/standard-headers/linux/virtio_rtc.h       | 237 +++++++++
>  include/system/iommufd.h                          |  18 +-
>  include/system/memory.h                           |   4 +-
>  net/vhost-vdpa.c                                  |  37 +-
>  qapi/virtio.json                                  |  18 -
>  subprojects/libvduse/libvduse.c                   |   7 +-
>  subprojects/libvhost-user/libvhost-user.c         |  77 ++-
>  subprojects/libvhost-user/libvhost-user.h         |  56 +++
>  system/memory.c                                   |  14 +
>  tests/data/acpi/x86/microvm/DSDT                  | Bin 365 -> 366 bytes
>  tests/data/acpi/x86/microvm/DSDT.ioapic2          | Bin 365 -> 366 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie             | Bin 2985 -> 2986 byt=
es
>  tests/data/acpi/x86/microvm/DSDT.rtc              | Bin 404 -> 405 bytes
>  tests/data/acpi/x86/microvm/DSDT.usb              | Bin 414 -> 415 bytes
>  tests/data/acpi/x86/pc/DSDT                       | Bin 8598 -> 8599 byt=
es
>  tests/data/acpi/x86/pc/DSDT.acpierst              | Bin 8509 -> 8510 byt=
es
>  tests/data/acpi/x86/pc/DSDT.acpihmat              | Bin 9923 -> 9924 byt=
es
>  tests/data/acpi/x86/pc/DSDT.bridge                | Bin 15469 -> 15470 b=
ytes
>  tests/data/acpi/x86/pc/DSDT.cphp                  | Bin 9062 -> 9063 byt=
es
>  tests/data/acpi/x86/pc/DSDT.dimmpxm               | Bin 10252 -> 10253 b=
ytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge              | Bin 8549 -> 8550 byt=
es
>  tests/data/acpi/x86/pc/DSDT.hpbrroot              | Bin 5087 -> 5088 byt=
es
>  tests/data/acpi/x86/pc/DSDT.ipmikcs               | Bin 8670 -> 8671 byt=
es
>  tests/data/acpi/x86/pc/DSDT.memhp                 | Bin 9957 -> 9958 byt=
es
>  tests/data/acpi/x86/pc/DSDT.nohpet                | Bin 8456 -> 8457 byt=
es
>  tests/data/acpi/x86/pc/DSDT.numamem               | Bin 8604 -> 8605 byt=
es
>  tests/data/acpi/x86/pc/DSDT.roothp                | Bin 12391 -> 12392 b=
ytes
>  tests/data/acpi/x86/q35/DSDT                      | Bin 8427 -> 8428 byt=
es
>  tests/data/acpi/x86/q35/DSDT.acpierst             | Bin 8444 -> 8445 byt=
es
>  tests/data/acpi/x86/q35/DSDT.acpihmat             | Bin 9752 -> 9753 byt=
es
>  tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x   | Bin 12637 -> 12638 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator | Bin 8706 -> 8707 byt=
es
>  tests/data/acpi/x86/q35/DSDT.applesmc             | Bin 8473 -> 8474 byt=
es
>  tests/data/acpi/x86/q35/DSDT.bridge               | Bin 12040 -> 12041 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.core-count           | Bin 12985 -> 12986 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.core-count2          | Bin 33842 -> 33843 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.cphp                 | Bin 8891 -> 8892 byt=
es
>  tests/data/acpi/x86/q35/DSDT.cxl                  | Bin 13218 -> 13219 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm              | Bin 10081 -> 10082 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt               | Bin 8502 -> 8503 byt=
es
>  tests/data/acpi/x86/q35/DSDT.ipmismbus            | Bin 8515 -> 8516 byt=
es
>  tests/data/acpi/x86/q35/DSDT.ivrs                 | Bin 8444 -> 8445 byt=
es
>  tests/data/acpi/x86/q35/DSDT.memhp                | Bin 9786 -> 9787 byt=
es
>  tests/data/acpi/x86/q35/DSDT.mmio64               | Bin 9557 -> 9558 byt=
es
>  tests/data/acpi/x86/q35/DSDT.multi-bridge         | Bin 13280 -> 13281 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp             | Bin 8289 -> 8290 byt=
es
>  tests/data/acpi/x86/q35/DSDT.nohpet               | Bin 8285 -> 8286 byt=
es
>  tests/data/acpi/x86/q35/DSDT.numamem              | Bin 8433 -> 8434 byt=
es
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa          | Bin 8528 -> 8529 byt=
es
>  tests/data/acpi/x86/q35/DSDT.thread-count         | Bin 12985 -> 12986 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2        | Bin 33842 -> 33843 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12            | Bin 9033 -> 9034 byt=
es
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2             | Bin 9059 -> 9060 byt=
es
>  tests/data/acpi/x86/q35/DSDT.type4-count          | Bin 18661 -> 18662 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.viot                 | Bin 14684 -> 14685 b=
ytes
>  tests/data/acpi/x86/q35/DSDT.xapic                | Bin 35790 -> 35791 b=
ytes
>  tests/data/acpi/x86/q35/WDAT.wdat                 | Bin 0 -> 308 bytes
>  tests/qtest/amd-iommu-test.c                      |  76 +++
>  tests/qtest/bios-tables-test.c                    |  13 +
>  tests/qtest/intel-iommu-test.c                    |  32 +-
>  tests/qtest/iommu-intel-test.c                    |   4 +-
>  tests/qtest/meson.build                           |   1 +
>  144 files changed, 4056 insertions(+), 1158 deletions(-)
>  create mode 100644 hw/acpi/wdat-ich9-stub.c
>  create mode 100644 hw/acpi/wdat-ich9.c
>  rename hw/virtio/{vhost-backend.c =3D> vhost-kernel.c} (83%)
>  create mode 100644 hw/virtio/vhost-user-stub.c
>  create mode 100644 hw/virtio/virtio-rtc-pci.c
>  create mode 100644 hw/virtio/virtio-rtc.c
>  create mode 100644 include/hw/acpi/wdat-ich9.h
>  create mode 100644 include/hw/acpi/wdat.h
>  create mode 100644 include/hw/virtio/virtio-rtc.h
>  create mode 100644 include/standard-headers/linux/virtio_rtc.h
>  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
>  create mode 100644 tests/qtest/amd-iommu-test.c
>
>

