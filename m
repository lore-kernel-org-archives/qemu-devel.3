Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B97CEC1E85
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvwe-0003ln-5d; Thu, 05 Feb 2026 04:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vnvwc-0003kk-HH
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vnvwA-00026R-OA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770284702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VocTWuxHKncefVi3u1d8zNTzJTdIZ9+PxiV7QPezD80=;
 b=THwK4LYZkqwxce8IhEz1RUlej7z4M5EWukQU1teATtT13magyzeFF1L2eUv5kyEkfJS5wC
 0EnygiZNPdoif79O0QYK8bwNCbhV9BLNv3qnHckjYf7g29+x4gPmF2EtQGgM//gim+HgfC
 oX+TpaT2TYU5p8IIqTqbT2yu84iXdw4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-nV0bt4MEMIG8eOvu1vbBjg-1; Thu, 05 Feb 2026 04:39:17 -0500
X-MC-Unique: nV0bt4MEMIG8eOvu1vbBjg-1
X-Mimecast-MFC-AGG-ID: nV0bt4MEMIG8eOvu1vbBjg_1770284356
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4362456500eso301330f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770284356; x=1770889156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VocTWuxHKncefVi3u1d8zNTzJTdIZ9+PxiV7QPezD80=;
 b=FUtMYjiOLYpBVQkIf8gLipA5FNe+56llY3WGQ+AESasV2XtMvgv8dgtd60oF34MIPw
 446F8o5woC6PtoGafuUlm8GqGuqw25S0Chdb2fLxCN7CMwFJ9LOZNH3Lr7dLEQ2lqoyO
 L4AzHDOMEBZRzgoFuqEYP7LrHoPXwhjm0qGDylr3luqfsVDXfsSxY8MQVZRAkk6uZ+lG
 AlXVgEAEP7KCmLQ/w92weaD3jtHPpNcuB/qFS/0uPsjFLiOrg0uOOxzZSe3RpXdDiuSf
 GvAv/aseo60WxEyLqJE0LQVtjVGVD2PbCJV4/KqdOGbr0n1g2L4qCg4/jWkeLDpfht9C
 TLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770284356; x=1770889156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VocTWuxHKncefVi3u1d8zNTzJTdIZ9+PxiV7QPezD80=;
 b=Ry2gW+T1BmF9rEuMZ5hcixIgFuW2/uHq6WMll6HUm7HG+4C0FKJl7VLOmUsLjz/KOw
 XGqIlkdQCfjdEATnYziWU0HAIgq3jRexI/Gw5Y9FrbVUW9DWF5fmhWr12B/bJ9VCP0fm
 MPSsdqPhyV0Fo4u3iHrSmEoMsN0YX9O46ivyd5O5asmamZ5P1gqezK763qhnwR8BcENB
 cg2yTrvZymRmb6tC30PPXkYPhv56+nYbywrrrq90G7pGC7teoh/V1m+j9LWUeWSQrIEa
 A5IKsseCK3EOoHJSODZMddg3lXNfuasvwHnc/ojJvGnSFErX4IfoTM2WUC84SQdhru0O
 aBog==
X-Gm-Message-State: AOJu0Yzxu4g8z1gGi7vB6Av1V5FZ4nxnmajbs8kaRRMNwTtxRU5Ek7NH
 WmTu5t+HxTpZg8pk42uXiKQlcMMLEF0SWfsVuW51Wvtpga1MWIrGKi833vV2zB1Tu+vmZaGoRwS
 IoLpfvqQn3h1HLa9/EdPzwc+lsJxDWmGjTciQeip1vCYY4ekJFPTsfgb4
X-Gm-Gg: AZuq6aJCn4RNzkMB9R838qqW7IUidJhLaQteK2gJsl95e+GbuiaRmuJTpMvBeesx04k
 PwBFnPv5vVlRODLciCsiPhvBt3x3jHxwaEopNu/IU5FcvsiK1eGzoWRA7IerWjuwt7M1fu4YF7O
 5L6+MPY9WyMDCOIBCXgIdP36HEogaWLzMuSmCz7brVNNYT2qd9QSYI3jaro2FyuoNbQFsXITf/2
 JOmjyXRIzt/cyxnhTxWg5BeuqusvTA7N380MFxvgBvbPswrh99nErOtTDU32OgYiqQ8fsSc/uqX
 mrLhGU3DyRi+mM/fwIaQKcnx9LtQXEjgQ6/Ex2cN4L+diKB6X1Ys3cxUjbtZVH4bLxeF5Q==
X-Received: by 2002:a05:6000:1ac7:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-43618054ff1mr8084256f8f.34.1770284355504; 
 Thu, 05 Feb 2026 01:39:15 -0800 (PST)
X-Received: by 2002:a05:6000:1ac7:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-43618054ff1mr8084214f8f.34.1770284354967; 
 Thu, 05 Feb 2026 01:39:14 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805813asm12407128f8f.27.2026.02.05.01.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 01:39:14 -0800 (PST)
Date: Thu, 5 Feb 2026 10:39:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/51] virtio,pci,pc: features, fixes
Message-ID: <20260205103911.002c90b5@imammedo>
In-Reply-To: <20260205015956-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
 <20260205015022-mutt-send-email-mst@kernel.org>
 <20260205015956-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Thu, 5 Feb 2026 02:00:22 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 05, 2026 at 01:51:39AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 04, 2026 at 02:16:23PM -0500, Michael S. Tsirkin wrote: =20
> > > The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6=
d85eea:
> > >=20
> > >   Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into=
 staging (2026-02-03 07:52:04 +1000)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstr=
eam
> > >=20
> > > for you to fetch changes up to 1ef708ee4b765b9eac097192d54b69a603589f=
9b:
> > >=20
> > >   hw/cxl: Take into account how many media operations are requested f=
or param check (2026-02-04 07:42:50 -0500) =20
> >=20
> > updated to 591fb214b96be2fab1dcf41282e567d6b64e613d now.
> >=20
> > It is the same patchset with 5 patches dropped (and tag message
> > updated accordingly). So I am guessing it is better not
> > to resend the whole pull, but pls let me know. =20
>=20
> sent too early, there is a dependency i missed.
> will post v2 later.

Michael,

please drop WDAT patches,
I'm preparing to post v2 soon with arm/virt support included
and x86 part changed  as well to make configuration generic.=20
=20
> >  =20
> > > ----------------------------------------------------------------
> > > virtio,pci,pc: features, fixes
> > >=20
> > > cxl:
> > >     Additional RAS features support.
> > >     Back-Invalidate support
> > >     PCIe Flit mode support
> > >     Misc fixes
> > > intel_iommu:
> > >     SVM support
> > > vhost:
> > >     support for indirect descriptors in shadow virtqueue
> > > vhost-user:
> > >     vhost-user-spi support
> > >     vhost-user-blk inflight migration support
> > >     vhost-user-blk inflight migration support
> > > acpi:
> > >     update VIOT maintainer
> > >     WDAT watchdog support
> > >=20
> > > misc fixes in pci, vhost, virtio, acpi
> > > cleanups in acpi/ghes
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >=20
> > > ----------------------------------------------------------------
> > > Akihiko Odaki (1):
> > >       pci/shpc: Do not unparent in instance_finalize()
> > >=20
> > > Alexandr Moshkov (5):
> > >       vhost-user.rst: specify vhost-user back-end action on GET_VRING=
_BASE
> > >       vhost-user: introduce protocol feature for skip drain on GET_VR=
ING_BASE
> > >       vmstate: introduce VMSTATE_VBUFFER_UINT64
> > >       vhost: add vmstate for inflight region with inner buffer
> > >       vhost-user-blk: support inter-host inflight migration
> > >=20
> > > Cl=C3=A9ment Mathieu--Drif (7):
> > >       intel_iommu: Add an IOMMU index for pre-translated addresses
> > >       intel_iommu: Support memory operations with pre-translated addr=
esses
> > >       pcie: Add a function to check if pasid privileged mode is enabl=
ed
> > >       pci: Block ATS requests when privileged mode is disabled
> > >       intel_iommu: Handle insufficient permissions during translation=
 requests
> > >       intel_iommu: Minimal handling of privileged ATS request
> > >       intel_iommu: Add a CLI option to enable SVM
> > >=20
> > > Daniil Tatianin (1):
> > >       virtio/vhost: don't consider non-MAP_SHARED regions public
> > >=20
> > > Davidlohr Bueso (1):
> > >       hw/cxl: Add support for Maintenance command and Post Package Re=
pair (PPR)
> > >=20
> > > Dorinda Bassey (1):
> > >       virtio-dmabuf: Ensure UUID persistence for hash table insertion
> > >=20
> > > Eugenio P=C3=A9rez (1):
> > >       vhost: accept indirect descriptors in shadow virtqueue
> > >=20
> > > Gavin Shan (5):
> > >       acpi/ghes: Automate data block cleanup in acpi_ghes_memory_erro=
rs()
> > >       acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
> > >       target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
> > >       acpi/ghes: Bail early on error from get_ghes_source_offsets()
> > >       acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> > >=20
> > > Haixu Cui (2):
> > >       standard-headers: Update virtio_spi.h from Linux v6.18-rc3
> > >       virtio-spi: Add vhost-user-spi device support
> > >=20
> > > Honglei Huang (2):
> > >       virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
> > >       virtio-gpu: use consistent error checking for virtio_gpu_create=
_mapping_iov
> > >=20
> > > Igor Mammedov (6):
> > >       x86: q35: ich9: add 'wdat' property
> > >       acpi: add API to build WDAT instructions
> > >       x86: q35: generate WDAT ACPI table
> > >       tests: x86: q35: acpi: add WDAT table test case
> > >       tests: acpi: update expected WDAT blob
> > >       q35: Fix migration of SMRAM state
> > >=20
> > > Jean-Philippe Brucker (1):
> > >       MAINTAINERS: Update VIOT maintainer
> > >=20
> > > Joelle van Dyne (1):
> > >       virtio-gpu-virgl: correct parent for blob memory region
> > >=20
> > > Jonathan Cameron (2):
> > >       hw/cxl: Check for overflow on santize media as both base and of=
fset 64bit.
> > >       hw/cxl: Take into account how many media operations are request=
ed for param check
> > >=20
> > > Kevin Wolf (2):
> > >       virtio: Fix crash when sriov-pf is set for non-PCI-Express devi=
ce
> > >       pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
> > >=20
> > > Li Chen (1):
> > >       virtio-pmem: ignore empty queue notifications
> > >=20
> > > Michael S. Tsirkin (1):
> > >       vhost-user: ancilliary -> ancillary
> > >=20
> > > Philippe Mathieu-Daud=C3=A9 (1):
> > >       hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent class_in=
it()
> > >=20
> > > Shiju Jose (7):
> > >       hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS fea=
ture attributes in cmd_features_set_feature()
> > >       hw/cxl: Add emulation for memory sparing control feature
> > >       qapi: cxl: Refactor CXL event injection for common commands arg=
uments
> > >       hw/cxl/events: Update for rev3.2 common event record format
> > >       hw/cxl/events: Updates for rev3.2 general media event record
> > >       hw/cxl/events: Updates for rev3.2 DRAM event record
> > >       hw/cxl/events: Updates for rev3.2 memory module event record
> > >=20
> > > Wafer Xie (1):
> > >       vdpa: fix vhost-vdpa suspended state not be shared
> > >=20
> > > zhenwei pi (2):
> > >       hw/virtio/virtio-crypto: verify asym request size
> > >       cryptodev-builtin: Limit the maximum size
> > >=20
> > >  MAINTAINERS                                 |   8 +-
> > >  backends/cryptodev-builtin.c                |   9 +-
> > >  docs/interop/vhost-user.rst                 |  60 +--
> > >  docs/system/devices/virtio/vhost-user.rst   |   3 +
> > >  hw/acpi/aml-build.c                         |  14 +
> > >  hw/acpi/ghes-stub.c                         |   6 +-
> > >  hw/acpi/ghes.c                              |  45 +--
> > >  hw/acpi/ich9.c                              |   5 +
> > >  hw/acpi/meson.build                         |   3 +-
> > >  hw/acpi/wdat-ich9.c                         |  85 ++++
> > >  hw/acpi/wdat-stub.c                         |  16 +
> > >  hw/block/vhost-user-blk.c                   |  27 ++
> > >  hw/cxl/cxl-events.c                         |   3 +-
> > >  hw/cxl/cxl-mailbox-utils.c                  | 580 ++++++++++++++++++=
+++++++++-
> > >  hw/display/virtio-dmabuf.c                  |   6 +-
> > >  hw/display/virtio-gpu-virgl.c               |   8 +-
> > >  hw/display/virtio-gpu.c                     |   4 +-
> > >  hw/i386/acpi-build.c                        |  13 +
> > >  hw/i386/intel_iommu.c                       | 204 +++++++---
> > >  hw/i386/intel_iommu_internal.h              |  14 +-
> > >  hw/isa/lpc_ich9.c                           |   1 +
> > >  hw/mem/cxl_type3.c                          | 330 +++++++++++++++-
> > >  hw/mem/cxl_type3_stubs.c                    |  41 +-
> > >  hw/pci-host/articia.c                       |   1 -
> > >  hw/pci-host/aspeed_pcie.c                   |   1 -
> > >  hw/pci-host/designware.c                    |   3 -
> > >  hw/pci-host/gpex.c                          |   2 -
> > >  hw/pci-host/grackle.c                       |   1 -
> > >  hw/pci-host/gt64120.c                       |   1 -
> > >  hw/pci-host/mv64361.c                       |   1 -
> > >  hw/pci-host/pnv_phb.c                       |   1 -
> > >  hw/pci-host/ppce500.c                       |   1 -
> > >  hw/pci-host/q35.c                           |  28 +-
> > >  hw/pci-host/raven.c                         |   1 -
> > >  hw/pci-host/remote.c                        |   1 -
> > >  hw/pci-host/sabre.c                         |   1 -
> > >  hw/pci-host/uninorth.c                      |   4 -
> > >  hw/pci-host/xilinx-pcie.c                   |   2 -
> > >  hw/pci/pci.c                                |   4 +
> > >  hw/pci/pci_host.c                           |   1 +
> > >  hw/pci/pcie.c                               |  21 +-
> > >  hw/pci/pcie_sriov.c                         |   9 +-
> > >  hw/pci/shpc.c                               |   1 -
> > >  hw/virtio/Kconfig                           |   5 +
> > >  hw/virtio/meson.build                       |   3 +
> > >  hw/virtio/vhost-shadow-virtqueue.c          |   1 +
> > >  hw/virtio/vhost-user-spi-pci.c              |  69 ++++
> > >  hw/virtio/vhost-user-spi.c                  |  65 ++++
> > >  hw/virtio/vhost-user.c                      |   7 +
> > >  hw/virtio/vhost-vdpa.c                      |   6 +-
> > >  hw/virtio/vhost.c                           |  66 +++-
> > >  hw/virtio/virtio-crypto.c                   |   7 +
> > >  hw/virtio/virtio-pci.c                      |  20 +-
> > >  hw/virtio/virtio-pmem.c                     |   1 -
> > >  hw/virtio/virtio.c                          |   4 +-
> > >  include/hw/acpi/ghes.h                      |   6 +-
> > >  include/hw/acpi/ich9.h                      |   1 +
> > >  include/hw/acpi/wdat.h                      | 121 ++++++
> > >  include/hw/cxl/cxl_device.h                 | 152 +++++++-
> > >  include/hw/cxl/cxl_events.h                 |  85 +++-
> > >  include/hw/i386/intel_iommu.h               |   1 +
> > >  include/hw/pci/pcie.h                       |   1 +
> > >  include/hw/virtio/vhost-user-blk.h          |   1 +
> > >  include/hw/virtio/vhost-user-spi.h          |  25 ++
> > >  include/hw/virtio/vhost-user.h              |   2 +
> > >  include/hw/virtio/vhost-vdpa.h              |   8 +-
> > >  include/hw/virtio/vhost.h                   |   6 +
> > >  include/migration/vmstate.h                 |  10 +
> > >  include/standard-headers/linux/virtio_spi.h | 181 +++++++++
> > >  qapi/cxl.json                               | 186 ++++++---
> > >  target/arm/kvm.c                            |  10 +-
> > >  tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
> > >  tests/qtest/bios-tables-test.c              |  13 +
> > >  tests/qtest/q35-test.c                      |   6 -
> > >  74 files changed, 2342 insertions(+), 297 deletions(-)
> > >  create mode 100644 hw/acpi/wdat-ich9.c
> > >  create mode 100644 hw/acpi/wdat-stub.c
> > >  create mode 100644 hw/virtio/vhost-user-spi-pci.c
> > >  create mode 100644 hw/virtio/vhost-user-spi.c
> > >  create mode 100644 include/hw/acpi/wdat.h
> > >  create mode 100644 include/hw/virtio/vhost-user-spi.h
> > >  create mode 100644 include/standard-headers/linux/virtio_spi.h
> > >  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat =20
>=20
>=20


