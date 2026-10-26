Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB1606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Nbt15hPe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbP-0002NZ-5K; Mon, 26 Oct 2026 08:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPA-0002lE-8G; Mon, 26 Oct 2026 05:54:12 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHP6-00080Z-V2; Mon, 26 Oct 2026 05:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008448; x=1824544448;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w6UU+vIiuqZc0J6GyS2zK2hsjo3ELADEVjFwNOBX6P8=;
 b=Nbt15hPe9Y/BM8YpgFuELsnpC5dQyXOvwwYLKhLyLi+x8P5A/csZpxHZ
 /WcnTWbNw+SyVmBOSk0cG6/M7aqWbJMn8XY7ncLLBBUM9xSDD9aoKGzBK
 kETaF/ceYf+VtpI6PFnFPWMj0M3oXObHmaQikC3wqY3bKx0IqWeZxaIE2
 VLlJhFVeQVvGyx4zIyMNb6Gyz4vTDeMeeT03C6VYLkOuPnxvwMmhCsd9A
 ZttECL+Zwi4xhuMe5zWwC4BuYHTHe5cU+IrALIMHlJEpjycXi1z+2j7IY
 qQSTMv0Of0O6TF8UbTbu+QOFbN9D+8oJW3MreRec389hhceB4l1f+rN+m Q==;
X-CSE-ConnectionGUID: MPphLMynQQmMgDYyZT/wAg==
X-CSE-MsgGUID: TWPwxJGrRDSX6wHgCGNP0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="247435593"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="247435593"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:04 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 0DB001C1C711;
 Mon, 26 Oct 2026 09:54:04 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTP id 74D3214003B5;
 Mon, 26 Oct 2026 09:54:03 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 0931B2069EA7;
 Mon, 26 Oct 2026 18:54:02 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anisa Su <anisa.su@samsung.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
 y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 0/7] QEMU/hw/cxl: Allow CXL Type 3 memory regions to be
 initialized at guest boot
Date: Mon, 26 Oct 2026 19:03:21 +0900
Message-ID: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.253; envelope-from=fj2110jc@fujitsu.com;
 helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello everyone,

I’m a student intern, and this is my first time sending patches to an open source mailing list.

This patch series configures QEMU’s CXL Type 3 devices so that guest operating systems can automatically discover
and create CXL regions during boot, aligning QEMU’s behavior with real hardware.

Background and motivation
  Currently, during guest boot QEMU does not provide the information or register programming needed for the guest OS
  to initialize CXL Type 3 memory, so using it still requires an explicit action in the guest (for example, running the cxl create-region command).
  By contrast, on some physical systems the firmware automatically allocates CXL memory ranges and exposes them to the OS,
   allowing the Linux CXL driver to discover and create regions during boot.
  This patch series is a first, experimental attempt to reproduce that behavior in QEMU.

  Some parts of this implementation are based on Li, Zhijian’s work in:
  https://github.com/zhijianli88/qemu/tree/program-decoder-v2

  I would like to ask for feedback on whether this approach makes sense and whether I should continue to enhance it.

Approach
  This patch first adds a program_hdm_decoder option to cxl-type3.
  When program-hdm-decoder is enabled on cxl-type3, QEMU will:
    1) program endpoint/host-bridge HDM decoder state,
    2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
    3) create memory-only NUMA nodes for those ranges,
    4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to its node ID

  On real hardware, HDM decoder programming and memory layout are typically handled by firmware, so they would ideally be managed by SeaBIOS.
  However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on the QEMU side, and pushing HDM decoder programming
  into SeaBIOS would introduce additional complexity and risk inconsistencies.

Testing
  We ran tests in the following environment and confirmed that CXL regions were created at boot, NUMA nodes were set up,
  and E820_SOFT_RESERVED entries appeared in the E820 table:

  - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
  - CXL memory: 4 GB
  - CFMWS: 4 GB
  - Host bridge: 1

  The following is the startup script.

  sudo /path/to/qemu/build/qemu-system-x86_64 \
    -name guest=cxl \
    -nographic \
    -machine q35,accel=tcg,nvdimm=on,cxl=on \
    -cpu max -smp 4,sockets=4,cores=1,threads=1 \
    -m size=4G,slots=10,maxmem=20G \
    -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
    -bios /path/to/seabios/out/bios.bin \
    -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
    -object memory-backend-ram,size=2G,id=m0 \
    -object memory-backend-ram,size=2G,id=m1 \
    -numa node,nodeid=0,cpus=0-1,memdev=m0 \
    -numa node,nodeid=1,cpus=2-3,memdev=m1 \
    -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
    -object memory-backend-ram,size=4G,share=on,id=vmem0 \
    -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
  
  Furthermore, we conducted the experiment in which we added two CXL Type3.

  - CXL memory: 4 GB × 2
  - CFMWS: 4 GB × 2

  The following is the startup script.
    
  sudo /path/to/qemu/build/qemu-system-x86_64 \
    -name guest=cxl \
    -nographic \
    -machine q35,accel=tcg,nvdimm=on,cxl=on,hmat=on \
    -cpu max -smp 4,sockets=4,cores=1,threads=1 \
    -m size=4G,slots=10,maxmem=20G \
    -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
    -bios /path/to/seabios/out/bios.bin \
    -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
    -object memory-backend-ram,size=2G,id=m0 \
    -object memory-backend-ram,size=2G,id=m1 \
    -numa node,nodeid=0,cpus=0-1,memdev=m0 \
    -numa node,nodeid=1,cpus=2-3,memdev=m1 \
    -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
    -device pcie-root-port,id=pci-root-net,chassis=5,slot=5,bus=pcie.0 \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
    -device cxl-rp,port=3,id=root_port14,bus=cxl.1,chassis=2,slot=4 \
    -object memory-backend-ram,size=4G,share=on,id=vmem0 \
    -object memory-backend-ram,size=4G,share=on,id=vmem1 \
    -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
    -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1,program-hdm-decoder=true \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k


How to use
  Specify the following parameters when starting QEMU:

  - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
  - Add hmat=on to the -machine option [1]
  - Add program-hdm-decoder=true to each -device cxl-type3 option
    [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When multiple CXL Type 3 devices share a contiguous HPA range,
        these ranges tend to be merged into a single region, so the CXL driver cannot reliably initialize per‑device regions based on E820 alone.
        SRAT entries for CXL memory are therefore needed, and the guest seems to discard SRAT when `hmat=on` is not specified,
        so HMAT must be enabled.

QEMU base commit: bddb785e791e415db38884848d068457e226f5e3

TODO
  With the current implementation of this patch, the following configurations are either not supported or have not been sufficiently tested.
  As a result, automatic creation of CXL regions in the guest OS may fail:

  - A CXL persistent memory device is included
  - Interleaved configurations
  - Cases where the memory size specified by CFMWS does not match the size of the CXL Type 3 backend memory
  - Configurations where CXL memory is attached via a switch
  - Multi-target CFMWS environments
  - ARM environments
  - HMAT does not yet include information about CXL memory devices

  The following behaviors are also provisional implementations and may need further refinement:
   - A new NUMA node ID is assigned to each CXL memory device. This should be improved either to reflect more accurate NUMA distances for CXL memory,
     or to allow the NUMA node IDs to be specified by the user.
   - Assignment of CXL Type 3 devices to CFMWS address ranges. On physical systems, platform firmware typically generates CFMWS entries
     based on the detected CXL topology and its address-space allocation. In QEMU, however, CFMWS entries are configured explicitly
     through machine options. The current implementation therefore has to infer which CFMWS range should be used for each Type 3 device.
     This selection logic may need further refinement. Possible approaches include improving the selection and validation logic,
     adding an explicit option to associate each Type 3 device with a CFMWS entry,
     or generating CFMWS entries automatically from the configured CXL topology and devices.
   - HDM decoder reset sequencing and state reconstruction.
     The current implementation prevents the host bridge HDM decoder configuration from being overwritten later in the same reset
     by moving the common initialization of the host bridge component registers from the reset path to the realization path.
     However, ideally, after the registers have been restored to their reset values, the host bridge HDM decoder configuration
     automatically programmed by QEMU should be reconstructed as part of reset processing.

Thanks,

------

Yukiya Takaki (7):
  QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
  QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
  QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
  QEMU/hw/cxl: auto‑program HDM decoders for CXL Type 3
  QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
  QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
  add CXL Type 3 memory ranges to SRAT

 hw/acpi/cxl_type3.c                 |  30 +++++
 hw/acpi/meson.build                 |   1 +
 hw/arm/cxl.c                        |  10 ++
 hw/arm/meson.build                  |   2 +
 hw/cxl/cxl-host.c                   |  63 ++++++++++
 hw/i386/acpi-build.c                |   7 ++
 hw/i386/cxl.c                       |  11 ++
 hw/i386/meson.build                 |   1 +
 hw/i386/pc.c                        |   2 +
 hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge.c |  13 +-
 include/hw/cxl/cxl.h                |   2 +
 include/hw/cxl/cxl_device.h         |   6 +
 include/hw/cxl/cxl_host.h           |   3 +
 include/hw/mem/cxl_type3.h          |   8 ++
 15 files changed, 334 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/cxl_type3.c
 create mode 100644 hw/arm/cxl.c
 create mode 100644 hw/i386/cxl.c
 create mode 100644 include/hw/mem/cxl_type3.h

-- 
2.52.0


