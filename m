Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC1EC1EA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 12:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vny9m-000400-6b; Thu, 05 Feb 2026 07:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vny9h-0003zR-HE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 07:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vny9e-0005uA-IQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 07:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770293293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMCo/5OoaDOPqFLQAQthZf7rqPRMmKHjTI8jhMvmg0I=;
 b=dAXwPkFXi45neSUmcaUfOf28vkAm0U+ghEbNgt13UI8U3+LwjUCk48ReoXQS+4Lt2mXBk6
 6QSYauG5S4spEooNcA6+s2u42qDGcoGXUcnbL2WC1+HZWC04YsE0DJJ7d5izsIAcoijSTo
 cFgVOVIoMTRcjHwmhsh3nEeU1wEsBhM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-zZXSyPPsN3qLHbOOVUBWUg-1; Thu, 05 Feb 2026 07:08:11 -0500
X-MC-Unique: zZXSyPPsN3qLHbOOVUBWUg-1
X-Mimecast-MFC-AGG-ID: zZXSyPPsN3qLHbOOVUBWUg_1770293290
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso712634f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 04:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770293290; x=1770898090; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gMCo/5OoaDOPqFLQAQthZf7rqPRMmKHjTI8jhMvmg0I=;
 b=aTuEzaxvVvwUqsI8WDWmnlKuhCK0ZkGq1cFv9Y7MCHaEW9iyppGBsrWr8EsFQ2T3M6
 9WHdrSnORIMFWGBCBzu0xw31wS8xOoA8ippW20v3T/MnW0ahAuz4h5XXqGju2MhHX3Cb
 UqSX53dz86YXZI6U/YR8qeYS92B0BNWdFnuloMmTYrqfZ3AwWipaoziUUbHCLndg8zFG
 kKX1wueweD+YPp3/HGkeOvFj92UlRodw3X8EoJJKZwBamFqpMcppfQGa724LEye70sTU
 XrNnP4Q5z8BF0937tuzrkTSSUKayCxl1mPevr46g8vjbDDgDlwJVUaiHX4aQDMrXPKrQ
 oSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770293290; x=1770898090;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gMCo/5OoaDOPqFLQAQthZf7rqPRMmKHjTI8jhMvmg0I=;
 b=GNkUUWJsnsba2DxYM6+Fvk3piwfTkg3mMWS5VQOTEmOrgwVuZ8HlIln9rjqcUsgn1r
 M60QqJljf6hiDn7qx5AAEmlvDkODrnP8PzTygjjoeV/KFFmtxVE7XZvd2+TKIZv0ivXl
 p0+mNdz3c8PJBlsXtgA8sVGTDdNOoKInSt94Ggg/yEwkyuEODbRQa02zw+PCRb62y/3Y
 PKRpRfKS5bW+MTWL9UVcJoPFyf0XoJaoWPa5FgMYwS4cRyJERhjpyZeANTz/ED9YHo04
 FC++b0jxgOwVNw1VR8MzplQffJfDR0pg8yOGEZeFn2FD8PCoaZ//Om9Ibu5MYq09O10Q
 c55g==
X-Gm-Message-State: AOJu0Yxx8TrQ5vRV1VQAVr/RviGTuHPfPFCIaBaT0P2sEhzeEelq9HRN
 eZEMHzY14BZ6kKfC8hsu+6gEtedlExUPSrX757TZac0ZZ3PatDcSDqxtcor6IBnsaJu8rXd69iN
 rLubvlk2kRVmdZLwqkJ0AXc4W1ve4GmFZ72HGzjb47I69oe6eDVQ6+1cbS9aGvz2j5VdnRmbNR0
 Y3PsVL84QASyRFJciSqx36e17ki36OBtGZMg==
X-Gm-Gg: AZuq6aLj9ouS8i54DwTHah/7Z/yc4Fo0CbKNf9arkPdmYW/MEp/aA2Aimj7IUU69Ai3
 j75Y7CgUaPpMsjSZ53I0rsOk2q26bSM7oMLrTkeJbYU0JlITPwhohfETvkdqsESHAIZRSFWnzkH
 qyPHglfHLP1HVXX+CR+fNQZP9XqBQ1P8LfUZwWrkdaZutVDQOog06Q8rYQ/X6dP7wu8KMx3Ncxm
 437OekGBXedBKi3U6QZSvHG3T9uldzXCh/db2w4X4Hm0B7JQWBHAdEzTfAmio4M/E75HLTf6oyo
 K1ZsDf//iCaZpfZ/Jb0TtkLJn6p1WhW72ORxlPyZggGif2XAUQhkrL16IZgmhM6QtKX2g9WQAQM
 mIwb4via4oQykh18QAKfPHBeGRfwS64EpCA==
X-Received: by 2002:a5d:5f51:0:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-4361805c136mr8439839f8f.47.1770293289893; 
 Thu, 05 Feb 2026 04:08:09 -0800 (PST)
X-Received: by 2002:a5d:5f51:0:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-4361805c136mr8439782f8f.47.1770293289184; 
 Thu, 05 Feb 2026 04:08:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e3a486sm13880189f8f.16.2026.02.05.04.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 04:08:08 -0800 (PST)
Date: Thu, 5 Feb 2026 07:08:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/38] virtio,pci,pc: features, fixes
Message-ID: <cover.1770293044.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Dropped most cxl patches for now.
Dropped WADT due to author's request.

The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:

  Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 25465c0e1fd74d2118dfec03912f2595eeb497d7:

  hw/cxl: Take into account how many media operations are requested for param check (2026-02-05 05:06:46 -0500)

----------------------------------------------------------------
virtio,pci,pc: features, fixes

intel_iommu:
    SVM support
vhost:
    support for indirect descriptors in shadow virtqueue
vhost-user:
    vhost-user-spi support
    vhost-user-blk inflight migration support
    vhost-user-blk inflight migration support

misc fixes in pci, vhost, virtio, acpi, cxl
cleanups in acpi/ghes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      pci/shpc: Do not unparent in instance_finalize()

Alexandr Moshkov (5):
      vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
      vhost-user: introduce protocol feature for skip drain on GET_VRING_BASE
      vmstate: introduce VMSTATE_VBUFFER_UINT64
      vhost: add vmstate for inflight region with inner buffer
      vhost-user-blk: support inter-host inflight migration

Clément Mathieu--Drif (7):
      intel_iommu: Add an IOMMU index for pre-translated addresses
      intel_iommu: Support memory operations with pre-translated addresses
      pcie: Add a function to check if pasid privileged mode is enabled
      pci: Block ATS requests when privileged mode is disabled
      intel_iommu: Handle insufficient permissions during translation requests
      intel_iommu: Minimal handling of privileged ATS request
      intel_iommu: Add a CLI option to enable SVM

Daniil Tatianin (1):
      virtio/vhost: don't consider non-MAP_SHARED regions public

Dorinda Bassey (1):
      virtio-dmabuf: Ensure UUID persistence for hash table insertion

Eugenio Pérez (1):
      vhost: accept indirect descriptors in shadow virtqueue

Gavin Shan (5):
      acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
      acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
      target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
      acpi/ghes: Bail early on error from get_ghes_source_offsets()
      acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()

Haixu Cui (2):
      standard-headers: Update virtio_spi.h from Linux v6.18-rc3
      virtio-spi: Add vhost-user-spi device support

Honglei Huang (2):
      virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
      virtio-gpu: use consistent error checking for virtio_gpu_create_mapping_iov

Igor Mammedov (1):
      q35: Fix migration of SMRAM state

Jean-Philippe Brucker (1):
      MAINTAINERS: Update VIOT maintainer

Joelle van Dyne (1):
      virtio-gpu-virgl: correct parent for blob memory region

Jonathan Cameron (2):
      hw/cxl: Check for overflow on santize media as both base and offset 64bit.
      hw/cxl: Take into account how many media operations are requested for param check

Kevin Wolf (2):
      virtio: Fix crash when sriov-pf is set for non-PCI-Express device
      pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()

Li Chen (1):
      virtio-pmem: ignore empty queue notifications

Michael S. Tsirkin (1):
      vhost-user: ancilliary -> ancillary

Philippe Mathieu-Daudé (1):
      hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent class_init()

Wafer Xie (1):
      vdpa: fix vhost-vdpa suspended state not be shared

zhenwei pi (2):
      hw/virtio/virtio-crypto: verify asym request size
      cryptodev-builtin: Limit the maximum size

 MAINTAINERS                                 |   8 +-
 backends/cryptodev-builtin.c                |   9 +-
 docs/interop/vhost-user.rst                 |  60 +++++---
 docs/system/devices/virtio/vhost-user.rst   |   3 +
 hw/acpi/ghes-stub.c                         |   6 +-
 hw/acpi/ghes.c                              |  45 +++---
 hw/block/vhost-user-blk.c                   |  27 ++++
 hw/cxl/cxl-mailbox-utils.c                  |  11 +-
 hw/display/virtio-dmabuf.c                  |   6 +-
 hw/display/virtio-gpu-virgl.c               |   8 +-
 hw/display/virtio-gpu.c                     |   4 +-
 hw/i386/intel_iommu.c                       | 204 ++++++++++++++++++++--------
 hw/i386/intel_iommu_internal.h              |  14 +-
 hw/pci-host/articia.c                       |   1 -
 hw/pci-host/aspeed_pcie.c                   |   1 -
 hw/pci-host/designware.c                    |   3 -
 hw/pci-host/gpex.c                          |   2 -
 hw/pci-host/grackle.c                       |   1 -
 hw/pci-host/gt64120.c                       |   1 -
 hw/pci-host/mv64361.c                       |   1 -
 hw/pci-host/pnv_phb.c                       |   1 -
 hw/pci-host/ppce500.c                       |   1 -
 hw/pci-host/q35.c                           |  28 ++--
 hw/pci-host/raven.c                         |   1 -
 hw/pci-host/remote.c                        |   1 -
 hw/pci-host/sabre.c                         |   1 -
 hw/pci-host/uninorth.c                      |   4 -
 hw/pci-host/xilinx-pcie.c                   |   2 -
 hw/pci/pci.c                                |   4 +
 hw/pci/pci_host.c                           |   1 +
 hw/pci/pcie.c                               |  21 ++-
 hw/pci/pcie_sriov.c                         |   9 +-
 hw/pci/shpc.c                               |   1 -
 hw/virtio/Kconfig                           |   5 +
 hw/virtio/meson.build                       |   3 +
 hw/virtio/vhost-shadow-virtqueue.c          |   1 +
 hw/virtio/vhost-user-spi-pci.c              |  69 ++++++++++
 hw/virtio/vhost-user-spi.c                  |  65 +++++++++
 hw/virtio/vhost-user.c                      |   7 +
 hw/virtio/vhost-vdpa.c                      |   6 +-
 hw/virtio/vhost.c                           |  66 ++++++++-
 hw/virtio/virtio-crypto.c                   |   7 +
 hw/virtio/virtio-pci.c                      |  20 +--
 hw/virtio/virtio-pmem.c                     |   1 -
 hw/virtio/virtio.c                          |   4 +-
 include/hw/acpi/ghes.h                      |   6 +-
 include/hw/i386/intel_iommu.h               |   1 +
 include/hw/pci/pcie.h                       |   1 +
 include/hw/virtio/vhost-user-blk.h          |   1 +
 include/hw/virtio/vhost-user-spi.h          |  25 ++++
 include/hw/virtio/vhost-user.h              |   2 +
 include/hw/virtio/vhost-vdpa.h              |   8 +-
 include/hw/virtio/vhost.h                   |   6 +
 include/migration/vmstate.h                 |  10 ++
 include/standard-headers/linux/virtio_spi.h | 181 ++++++++++++++++++++++++
 target/arm/kvm.c                            |  10 +-
 tests/qtest/q35-test.c                      |   6 -
 57 files changed, 792 insertions(+), 209 deletions(-)
 create mode 100644 hw/virtio/vhost-user-spi-pci.c
 create mode 100644 hw/virtio/vhost-user-spi.c
 create mode 100644 include/hw/virtio/vhost-user-spi.h
 create mode 100644 include/standard-headers/linux/virtio_spi.h


