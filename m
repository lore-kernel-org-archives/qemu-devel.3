Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B123C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8vC-0007by-TP; Wed, 26 Aug 2026 04:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8vA-0007bl-PE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:23:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8v7-0006sy-IH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:23:44 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260826081502epoutp02ee179fe436793d2925ddac608b14dfb7~PTOAxkjYK0332603326epoutp02L
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260826081502epoutp02ee179fe436793d2925ddac608b14dfb7~PTOAxkjYK0332603326epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732102;
 bh=aW6c58pCNidJWu8KY2QyEPP+YaKqlKylzka7cZx3wmg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=erBDm6ME+tB8g8gEB37OkkRcKzjeLdc67Tz0yJanDMxUZyuZZLQyYCK7CXnrAazpq
 tXDAH0fPZVtS2cLZsholJAxm381s4kY/Z+RNRYCMjHaEg6gRf3fyH54vMq6PE78I52
 xVGGa53ofHk1FjaLCMPJeqQ5M7I1u3KQ5VBHOsFw=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260826081502epcas5p36a97eea8494ec4a8a758afa16b249959~PTOAc3R6C1852318523epcas5p34;
 Wed, 26 Aug 2026 08:15:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4hVHWV3Wd1z3hhTH; Wed, 26 Aug
 2026 08:15:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260826051958epcas5p3db6cf2ef9115168c5d8dcec7bdb9b8c3~PQ1KBzMN72432924329epcas5p3i;
 Wed, 26 Aug 2026 05:19:58 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826051956epsmtip29fccddd996c4950feb6b8c93ffb4ecdd~PQ1IXjoMS1127211272epsmtip2M;
 Wed, 26 Aug 2026 05:19:56 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 0/9] hw/pci: hw/cxl: Add UIO support in CXL and PCIe stack.
Date: Wed, 26 Aug 2026 11:04:00 +0530
Message-Id: <1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826051958epcas5p3db6cf2ef9115168c5d8dcec7bdb9b8c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826051958epcas5p3db6cf2ef9115168c5d8dcec7bdb9b8c3
References: <CGME20260826051958epcas5p3db6cf2ef9115168c5d8dcec7bdb9b8c3@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=shrihari.s@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is the RFC V2 version of "UIO feature enablement in Qemu", By addressing
the comments received from the maintainers in the last series [1],
this series adds datapath enablement in both PCIe and CXL stack.

Features added in RFC V2,

    - Device 3 capability in PCIe stack and hooked it to the CXL type 3 device.
    - DVSEC registers related to UIO in CXL stack.
    - Modified UIO as a generic capability, while last series binds it to UIO.
    - extended SVC capability to CXL type 3 device.

New Properties added,

    - x-256b-flit: Apart from the small refactoring added in RFC V1 [1],
                   remains unchanged.

    - x-svc : Added currently in all the CXL/PCIe ports and in CXL type 3
              device to enable SVC capability in them.

    - x-uio : Added in CXL type 3 device so that it can act as a UIO completer.
              This property enables Device3 capability and is dependent on
              "x-svc" and "x-256b-flit".

This patch series introduces enumeration, configuration and data plane
support for the PCIe Unordered I/O (UIO) feature across standard PCIe
and CXL QEMU stack. UIO, is introduced from PCIe 6.1, a transaction layer
enhancement that relaxes strict transaction ordering rules and  shifts the
ordering control from the fabric to the requester device.

This implementation establishes the essential architectural foundation
required for the OS to discover, negotiate, and configure UIO
capabilities.

UIO in CXL follows CXL.io protocol, where a CXL device can send read/write
request to peer .mem device's HDM decoder at fabric level.

      __________________________________________
     |                                          |
     |              CXL Host Bridge             |
     |              (Root Port/RC)              |
     |__________________________________________|
                         |
      ___________________|______________________
     |                                          |
     |               CXL Switch                 |
     |__________________________________________|
        |                  |                 |
     ___|____           ___|_____         ___|____
    |        |         |         |       |        |
    | Dev A  |         | Dev B   |       | Dev C  |
    | (Req)  |         |(Target) |       |(Target)|
    |________|         |_________|       |________|


For example, consider the topology shown above, in that if the requester device
(Dev A) wants to read data from the target device (Dev C), then Dev A can
prepare UIO command with the targeted HPA of Dev C and can send directly to the
Dev C's HDM decoder at switch level. Here the host gets bypassed in the data path.
For this to happen, both the devices and the intermediate fabrics should support
UIO and its dependencies.

The implementation relies on three key dependencies:
    - 256B Flit Mode 
    - Streamlined Virtual Channel (SVC) Extended Capability (from PCIe 6.1)
    - PCIe Device 3 capability

Patch Layout:

Patch 01-02: Refactor 'flitmode' property from PCIESlot to PCIEPort so
             that all derived ports (PCIe and CXL) can use it. This is
             a pure structural refactor with no functional change.

Patch 03-04: Add new properties to PCIe and CXL ports:
             - x-256b-flit: Enable 256B flit mode
             - x-svc: Enable Streamlined Virtual Channel capability

Patch 05: Wire UIO capability into CXL HDM decoder capability and
             control registers per CXL 3.2 8.2.4.20.7. The UIO bit in
             the capability register is set for CXL Type 3 devices and
             ports when UIO support is enabled.

Patch 06: Implement the PCIe SVC Extended Capability (PCIe 6.4
          7.9.29). This is the largest patch, adding:
               - hw/pci/pcie_svc.c: SVC capability management
               - include/hw/pci/pcie_svc.h: SVC data structures
               - Updated pcie_cap_fill_lnk() for flitmode signaling
               - Lifecycle hooks (reset and config_write) for SVC state

Patch 07: Wire SVC initialization into the realize() functions of
          PCIe/CXL Root, Upstream, Downstream ports, and
          The 'uio_capable' flag is set in CXL Ports when both SVC and
          flitmode are enabled.

Patch 08: Implement the PCIe Device 3 Extended Capability (PCIe 6.4
          7.7.9). This adds:
              - hw/pci/pcie_dev3.c: Dev3 capability management
              - include/hw/pci/pcie_dev3.h: Dev3 data structures
              - pcie_link_flit_active() helper for flit mode queries
              - Gating logic that ties Dev3 control bits to flit mode

Patch 09: Wire SVC and Dev3 capabilities into the CXL Type 3 device
             realize() function, enabling it to act as a UIO completer.

Patch 10: Adds CXL UIO documentation

This series is written on top of:

Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
Repository: https://gitlab.com/jic23/qemu
Branch: cxl-2026-01-09-draft

Testing:
This series has been validated through the following:

1. Enumeration testing with Linux kernel
   - Verified SVC capability discovery via lspci -vvv
   - Verified Dev3 capability advertisement in config space
   - Verified HDM decoder UIO bits are set correctly
   - Verified capabilities' write_config() path.

2. Dataplane testing:
   - Added UIO requester capability to an existing PCIe device
     and verified DMA data flow using Linux Kernel test driver.

3. Backward compatibility:
   - Verified existing CXL Type 3 configurations (without x-svc/x-uio)
     continue to work unchanged
   - Confirmed no regression in standard PCIe enumeration

(The Linux kernel patches will be upstreamed later)

Future work:
1. Emulation of CXL type 2 device; To add a CXL test device with UIO requester
capability and verify the CXL-CXL P2P DMA datapath (mimicking CXL type2 to CXL
type3 P2P DMA via UIO)

2. Emulation of PCIe UIO test device; To add a PCIe UIO requester test device
and verify the PCIe-CXL P2P DMA path (mimicking PCIe GPU to CXL P2P DMA).
the CXL type2 to CXL type 3 UIO communication.

Thanks!

References
[1] https://lore.kernel.org/qemu-devel/20260609105836.3702787-1-shrihari.s@samsung.com/

Shrihari E S and Dongjoo Seo (9):
  hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
  hw/pci: Move 'x-256b-flit' property from cxl_root_port to pcie_root_port.
  hw/pci: Add SVC capability and UIO properties to PCIe ports
  hw/cxl: Add Streamlined Virtual Channel (SVC) property to CXL ports
  hw/cxl: Wire UIO capability into HDM decoder and DVSEC registers
  hw/pci: Add PCIe Streamlined Virtual Channel (SVC) capability.
  hw/pci: hw/cxl: Wire SVC initialization into port realize functions.
  hw/pci: Adding Device3 capabilities support
  hw/cxl: Wire SVC and Dev3 capability to CXL Type 3 device
  cxl: Add documentation for CXL UIO support.

 hw/cxl/cxl-component-utils.c              |  23 ++-
 hw/mem/cxl_type3.c                        |  26 ++-
 hw/pci-bridge/cxl_downstream.c            |  16 +-
 hw/pci-bridge/cxl_root_port.c             |  19 ++-
 hw/pci-bridge/cxl_upstream.c              |  14 +-
 hw/pci-bridge/gen_pcie_root_port.c        |   3 +
 hw/pci-bridge/pci_expander_bridge.c       |   3 +-
 hw/pci-bridge/pcie_root_port.c            |   6 +
 hw/pci-bridge/xio3130_downstream.c        |   5 +
 hw/pci-bridge/xio3130_upstream.c          |  10 ++
 hw/pci/meson.build                        |   2 +-
 hw/pci/pci.c                              |   6 +
 hw/pci/pcie.c                             |  83 +++++++++-
 hw/pci/pcie_dev3.c                        | 163 ++++++++++++++++++
 hw/pci/pcie_svc.c                         | 192 ++++++++++++++++++++++
 include/hw/cxl/cxl_component.h            |   2 +-
 include/hw/cxl/cxl_device.h               |   3 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |  13 ++
 include/hw/pci/pcie_dev3.h                |  26 +++
 include/hw/pci/pcie_port.h                |   6 +-
 include/hw/pci/pcie_regs.h                |  85 ++++++++++
 include/hw/pci/pcie_svc.h                 |  26 +++
 23 files changed, 705 insertions(+), 28 deletions(-)
 create mode 100644 hw/pci/pcie_dev3.c
 create mode 100644 hw/pci/pcie_svc.c
 create mode 100644 include/hw/pci/pcie_dev3.h
 create mode 100644 include/hw/pci/pcie_svc.h

-- 
2.34.1



