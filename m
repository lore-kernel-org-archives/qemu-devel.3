Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD41C61DBE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOBW-0005jJ-Bw; Wed, 26 Aug 2026 20:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBU-0005hH-Ef; Wed, 26 Aug 2026 20:41:36 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBS-0004l8-Cs; Wed, 26 Aug 2026 20:41:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6k1kdpz4ID4wX6wOxhOReV/79p/JO9zyks/8NPivcBz/U8sQ/i7iyDYuw7tyeN/oMBy6+ItOh2LCstQB0vbI7wzcO2M1pcR7iLxd5TFWJ28amkPNGUFzgtieRuvq4yhSPtHZeef7B7Ajy7fktom56o2CC4hi33/SzYk/qUmDBTOzczuxI3zFoijyMOA4yWClKjmJ4yFpTKDmNPtObXVkc/lK4m21ZEsAYpgfb1YnPEOEnUMtnsB6cXu2i2iF0ABHd2AmEYeQEGVYiXQdHPAyTf+QsTpmBzO1KXXFrCmRAikpUEg+gsdXKAuM9F7taX9xFiV07jFctK2u+eV331vmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yJjByJiJOiqxkmWmyLvymC+i00cYvHkcfiaNJrkWtI=;
 b=R1Jo6PkooC+OYhAbE99mB6P2iOX1knOh6V1/Jj3uYBy24tlyEucHJwCDjfxJW+ea0q00wadtGh4dascKrR8pQJayv+5l+eyR3KynHz/iXQDyn5ddwjtuysViqsPV/0EepQmypXHAvOeDesNMqkpSqgRYoqLbNJXBj2pI+D0IXcgGnUoRRX212LW5Z6sEYzxx0KVBFUEoMPPDy/PsnN5PixfZeWCXC1pjOZQi1u8Pr2vsy8AtrkKnnplDtQ0iBU9enHaE5ZDm5SmWjwRQAc4qC3TsDPW5w2iB/f22u88b0XW/I+6fPiZNWk1LDhuMjWkPqo6hqw9iZA9Rh16F4Ccr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yJjByJiJOiqxkmWmyLvymC+i00cYvHkcfiaNJrkWtI=;
 b=shmBl7Van6Zyf20Xg6eyq70rtryyiHIrn9tt5WpkBkB3BTM/hqG8q0CwMUKKtRJHxCULV7yQjyXCMaFhKPv7IO5sK2O77cbbP2HOFCtkq4mWvv94EzQwSx54yxPyAWMy7w6UafPR6rH7nokNgAWx1olfgYK1q9LVmXpRYNDf1wrnQBdTVQl75PqFQ5QmWVwldch2RJFKiKxUweNHkH/RMfyQ6oOwG004YQRRzKQzKQiVsjB0TI7HHGsnph//vJ99B8T+J7jXs7FkQJc9eU4lO+u0xc1x8WOfNy9rQqcMgvFQHEQHcHP8YqXVIAePBiXqoBY4zS773ip8lMWB2HRWVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 00:41:24 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:41:24 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Date: Wed, 26 Aug 2026 19:40:19 -0500
Message-Id: <20260827004024.598351-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0e7dcd-61c0-4061-2551-08df03d3ec14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZsdOhgb8YbQaQcjMUo9ysNBCJr7CjLHbpWGjnLhdeut3SpcZ/JGDS+b/873NggHFG3rpo7FEeAYRctFeEq/JsMrK2NW9lL2LxTmnFJKlKyvMzyI0zftlNCcS87aAjuw+aybagt4N2/fpTZ3KaIJnSPyBkHQj9shrzbhXFdxHAgt/GBJjYBhIgIS9SEmWLL4ykiVLnY8i8zeE6aQ0gb2bMHf2GDkWnYWlPg883nNcUNvICEENF4AIcZRtpJmVBjZcUHrFNSS0o0g/pjgsHZf3J+0OzoLovI6PcYafMiUxqyiUYHMuq4dqyRlzy5Yv/Gc145Kw+bQ51OZ29rN8wnMSNkjXI/IgRAX1jmH57tyty16j1LhBir7AMBc/IC7MK5nO1jnJapctfiCmRkTYv6zVaWp8qc5BKA6X5UcIa70J7xGagKaprZc+M/THR+tv8/Vw3z/mC4WZtUAULW0NFICXBP1szpLkym8VouzPhxiy1Jth5+c4sS8ZmeIpebdwo2zf4PAHxIkr7BeiIOR5+oYwatmXLA+RYg9v/4nS8ZBR56qKE/8mwXNOzE8o+IkvYHVfGv6w2Zp9O3vGkN7OSgeMwFfFEY4hY3tas+NG08cUcMvFMVCBM2qGR9vX6755Q39rF7HHx9LuEC2qXzhRUyk3VEVeHFF2mmWRSvMLLUBDF6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxAMSycADgf6G2IXCfSKWX+y4dSaBqXdFE+SEV5jNWqFgPVpWnunCGiphpnf?=
 =?us-ascii?Q?svptcRrhVsg3kCMd+QgYRi5xhrayu41EyZgT2x1cwMirDcce4Gly7ARlyfht?=
 =?us-ascii?Q?d/OUsZm5tiqVWfGzViPg/sIc8NTwUf32EFWnInTY2vHS7TWVStKhhBNR2mKf?=
 =?us-ascii?Q?vRbQWzQFKN7G+Xt2I9MdciAkH9aqe/i1YaQ6Oph7eAZVMmBCAaowZdcdqXrN?=
 =?us-ascii?Q?dYC3JBhJA870EFNYUZnKl6MH68byF1WtS+rwV5KpCL2Zt4bXgjYOEf9HWSt8?=
 =?us-ascii?Q?8wrB7USU0PDs6mngNpLqp6lEEWLu9KhBIJTC9+QlNLz2pFzH5yrIoP/U3gLa?=
 =?us-ascii?Q?lMo/mruRyk/AKRR/dQSvcWWmYAAiMlACgMFoVc348BClUORtHM5puH6CHq4f?=
 =?us-ascii?Q?c3bJSNxZUpPRToVj4oNoGE/l/vVf7rdP+o95f3HvrPOUyQ7ZI2F/e6LfhBnh?=
 =?us-ascii?Q?wE426prgd8d5cG486ch6Ojatmj6Urw3PSFiumbNAsDIAi1JYy8afRufGf/Pa?=
 =?us-ascii?Q?YSc1PqUKR/HGyIFq1yMm6yUYYz3DDcPnlTXqTUrTD51wwot++OzhoZ/TwdqI?=
 =?us-ascii?Q?CMv8YljSkDD1OiVGz8nhx4S24R4ctyroaZOLHlzpe9Z8odXVIRlbiWMSERxm?=
 =?us-ascii?Q?FDEVs3Aj3dbtYGq4ujHn/W8mWpjFwFlciVQNZpFsuVWtnQ8/7j+vMwEz9gla?=
 =?us-ascii?Q?l3FN7oxzO1hPmGgT2t4VEq/5X23KApXmMdFAfPDPSowbxBAp3J7UK6lPmQBD?=
 =?us-ascii?Q?KQF5r+LMmT70HZb9RMkCK62Vy7l31NN661+zlOH8mPLYTlFOdCfVDRJetqIz?=
 =?us-ascii?Q?HwTRaRTp4g81+2B0OrOTWx8yHKnMn3wJ6OBntAP12oCeU+JREL4HlrG2DTHH?=
 =?us-ascii?Q?k+czBVCE0fA05hxxKS92d7Qu8Oevme7BKNaqHG/2+SRQkVPJ8BCzAs7iGbCz?=
 =?us-ascii?Q?o/gFvBq99cHYq4GOQsXpWvAsv9NWqgrJvQ22I8ch7qFNEs2PNsEpWUXsxWnW?=
 =?us-ascii?Q?iTvFtA1uTK+U2GHjPJbagg0q11wjkbcdO5whYh6+3FL/YIzRQxKCPwrysIu2?=
 =?us-ascii?Q?wYu6dhPmhBm8pajjemumIH8LTs9dK/29r+iJHgt1J3SiU51meiTAoPv7/aaJ?=
 =?us-ascii?Q?d6mvcPcEbvX1lIq8RPo2H/uHug5IlzVFXauBMbl9o5Zx2RncByGq3tc/jslm?=
 =?us-ascii?Q?w5fjlkx1f0++BcQjAof5olbCH6+5MIeXol7aQPvhpe8oMRbjU1e/wWkFtDy2?=
 =?us-ascii?Q?5E7W29RCCKdiHEGVqI4YG8y0jRILrx7R0/ACDmX5CHqNayQ4zDHBG7SAhdR9?=
 =?us-ascii?Q?q/lFlO4AhpLr0yeNWF4Aq1XmHWaTp0UE9LC6cLB3kSauDcST4dTzrN2lfTYD?=
 =?us-ascii?Q?IVPcvkTU8VJn3yWTCJZ5LIyciLBRN/AWRSzMraoz1D0Gz5OgKdBcDZZ3RT+x?=
 =?us-ascii?Q?GIT/LvF133/tPzXPkZvJ6tntARflD25RK4c59Set3wciu5yF7pT64wRWW7HA?=
 =?us-ascii?Q?B0Qea14SsJV3CBB7qib9ONdKQbjXs1th2vh7Ui5uOFYPe2CqgMY1pGKgzFrb?=
 =?us-ascii?Q?WwccU29mZgBgU/8507nAd+DOm5K3aY0CBf3t94LRA/hao0zyfJR6LGA0u82d?=
 =?us-ascii?Q?M2hIFkFIvG3G/8kOnS0vWrYb+BmmOMRdOK3SRVG937ws4ZQTfGPPB/5+oPIQ?=
 =?us-ascii?Q?Q7ibCZLSaLSU+ecG26ikhR2sgD8HdISGouigxmSbab3AuNha?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0e7dcd-61c0-4061-2551-08df03d3ec14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:41:24.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAEZmHl1zI8KRLd/su+zoirT6BM6pRP4p7SCIsvpFpari7UF7ZJYRkUakBwC78kNH0o6XVt2G/y+FMP+CUsVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This RFC v2 is a follow-up to RFC v1 [1].

On some platforms, peer-to-peer (P2P) DMA between PCIe devices requires
guest physical addresses (GPAs) assigned to device BARs to match their
corresponding host physical addresses (HPAs).

RFC v1 proposed moving PCI enumeration and BAR assignment into QEMU
before firmware execution, with EDK2 operating in discovery-only mode
via PcdPciDisableBusEnumeration.

The feedback was that PCI enumeration and resource assignment should
remain in firmware rather than being performed by the VMM. The suggested
EDK2 mechanism was EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL, which
provides a per-device interception point for PCI resource assignment.

Following the feedback, RFC v2 keeps PCI enumeration and resource
assignment in firmware. QEMU only validates the user-provided fixed
BAR configuration and provides the required metadata to firmware
through the "etc/fixed-bars" fw_cfg file.

Two new PCI properties are introduced:

* fixed-bar=on on a PCIe root port marks its subordinate hierarchy for
  fixed BAR placement. Every device with memory BARs in that hierarchy
  must provide a complete pci-bars= configuration.

* pci-bars=barN@<addr>[,barM@<addr>]... on a PCI endpoint specifies the
  required address for each memory BAR. All memory BARs on the device
  must have an explicitly assigned address.

QEMU validates the user-specified configuration before passing it to
firmware. Validation checks BAR alignment, verifies that addresses are
within the configured PCIe MMIO apertures, and ensures that fixed BAR
ranges do not overlap. QEMU performs neither PCI enumeration nor BAR
allocation.

On the firmware side, a new DXE driver, QemuFixedBarsDxe, installs
EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL before PciBusDxe starts.
When PciBusDxe calls CheckDevice() for a discovered PCI function, the
driver returns ACPI address descriptors with _MIF|_MAF set for fixed
BARs. Two small changes to PciBusDxe preserve these fixed addresses and
program them into the BAR registers during BAR programming.

After PciEnumerationComplete, QemuFixedBarsDxe walks each fixed
root-port hierarchy and programs the bridge memory windows to cover
the fixed BAR ranges assigned to endpoint devices.

Example 1: VFIO passthrough devices under a fixed BAR root port.

    -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0,fixed-bar=on
    -device x3130-upstream,id=upstream1,bus=pcie.port1
    -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=2
    -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,id=dev0
    -set device.dev0.pci-bars=bar0@0x48000000000,bar2@0x50000000000,bar4@0x58000000000

Example 2: Extending the PCIe MMIO aperture with highmem-mmio-base
(and highmem-mmio-size), using a mix of emulated and VFIO devices.

    -machine virt,...,highmem-mmio-base=0x400000000000,highmem-mmio-size=0x400000000000
    -device e1000,netdev=net0,bus=pcie.0,pci-bars=bar0@0x10000000
    -device pcie-root-port,id=pcie.port9,bus=pcie.9,chassis=4,io-reserve=0,fixed-bar=on
    -device x3130-upstream,id=upstream9,bus=pcie.port9
    -device xio3130-downstream,id=downstream9_1,bus=upstream9,chassis=4,slot=1
    -device vfio-pci,host=0012:03:00.1,bus=downstream9_1,id=nic1,pci-bars=bar0@0x7000c0000000
    -device xio3130-downstream,id=downstream9_2,bus=upstream9,chassis=4,slot=2
    -device vfio-pci-nohotplug,host=0019:06:00.0,bus=downstream9_2,id=dev1
    -set device.dev1.pci-bars=bar0@0x6d4000000000,bar2@0x6d8000000000,bar4@0x6e0000000000

The pci-bars= property is generic and may be used with any PCI endpoint
device, including emulated devices and devices with 32-bit memory BARs.

The optional highmem-mmio-base machine property allows the operator to
reposition the high PCIe MMIO window so that the requested BAR
addresses can be placed within the configured address space.

Limitations:
- I/O BARs and the expansion ROM BAR are not covered by pci-bars=.
- This has only been tested on the AArch64 virt machine.
- SR-IOV VF BARs are not covered.

Testing:

The series was tested on the AArch64 virt machine using multiple PCI
topologies, including emulated devices, VFIO passthrough devices, PCIe
switches, and fixed BAR root ports.

A git branch with this series applied is available at:
https://github.com/tdavenvidia/upstream-qemu/tree/RFC-v2-fixed-bar-upstream

[1] RFC v1 upstream thread:
https://lore.kernel.org/qemu-devel/20260508183717.193630-1-tdave@nvidia.com/

Tushar Dave (5):
  hw/pci: add fixed-bar and pci-bars properties
  pci: add validation for fixed BAR configuration
  pci: add fixed BAR fw_cfg blob export
  hw/arm/virt: export fixed BAR metadata via fw_cfg
  hw/arm/virt: add highmem-mmio-base property

 hw/arm/virt.c                   |  78 ++++++++-
 hw/pci-bridge/pcie_root_port.c  |   1 +
 hw/pci/meson.build              |   2 +
 hw/pci/pci-fixed-bar-blob.c     | 291 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.c | 279 ++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  21 +++
 hw/pci/pci-fixed-bar.h          |  60 +++++++
 hw/pci/pci.c                    | 129 ++++++++++++++
 include/hw/pci/pci_device.h     |  10 ++
 include/hw/pci/pcie_port.h      |   1 +
 10 files changed, 871 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci/pci-fixed-bar-blob.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h
 create mode 100644 hw/pci/pci-fixed-bar.h

-- 
2.34.1


