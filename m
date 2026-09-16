Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8275C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uns-0006RN-Ih; Wed, 16 Sep 2026 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unq-0006Qe-RR; Wed, 16 Sep 2026 14:56:18 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6uno-00062u-KT; Wed, 16 Sep 2026 14:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4TAGIT1E8nOrA+6RZOJ348R7/Yx8nTBmOPJCVjfjWB1t2yg22TCWDJsmRP+HQGBLhQILR+/zvyEOm35HewaoDy1YuWcZcvs/RC4GQsdRw/p+ygpqDW739jG/eGEZwjdQCE6cOsMg4gk+kS3OlqN0E3nx6TlC95ioudtDKDfB/1sE/4N4zZEVOaNBVjQKAh85dWkClOU1YbEgmfsUpGrrY2ZOdKtSb3UBNKKVp0cZFKg2X9S1S0bPp25gRl02BrBizjx6VTy7XmGEER1Km5CABKPUfrktn77GnPn2wr0fofNLQ5lG88b4PxUjCGE2P4uMTE01Q8gy07ZD7iFcWIjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC9fYwC03Q90E1uTlN1x5aDoXb3U0FHobyK6550K1No=;
 b=UnEB0ywUU2yNfHHCL+nwRmxwHT7aj/w0zvXSS6X4HkadqMoDjh7+oNHSWPtvCHG/nLx0RoA91n6EP00G1kTTC6oQpXKxawaqPqyRL/ay5OAx3LgklX+JBth2CTNTboSjkQetNGkggoUXnR9SI2aRFCwNuipJoGuli+rL+X0BRtl2qIXS6Zx27p9Qu8G1t2CxPWHPJWNRC2R3VS1cjdWaFvBEnfP3JE8Lli69otuBzo5YJ3+zR2+a27TTXFtiSrFueGS1Q23WvPX6i4Z7xOewAqtb3Ubzwznf7DIYg2TnhViG+sweEN4xFu+tn5Xq8VBsjoZMc+XegN+/qdWV0a6Djg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC9fYwC03Q90E1uTlN1x5aDoXb3U0FHobyK6550K1No=;
 b=eXNB4GkFtPEW98pdh8tPWhLMI+Tae4y1XvMMSr0NyZ1fgI33jPDObdXaIXnTl0Keiff/TGSNq1ljcmWBvmKf+WhaIuF9RzBiQ3fI8HGXIgSbzyjDAUHfN8Xri3CBsgf4BX8SUmql1kWoq5noDJaK1rHKljR+xnMAFUuziUbbRGIr7SD8YSDuXeCscX1iHaRKcw69w4SL1gKSl5sCYWSLogYfrh+HJDv6YT8yUTORn1SklxySr6XDyZFf102pgpYXQU1jf9TCJ1cM67iooHeabj6rMQBYOw70a+pHoBUaLK1fR0hJvKftbj/Vkl3VJB41sUnsPPeifkk2HjMZj9tJgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY3PR12MB9631.namprd12.prod.outlook.com
 (2603:10b6:930:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:56:04 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:56:02 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Date: Wed, 16 Sep 2026 13:55:49 -0500
Message-Id: <20260916185554.917526-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: e3565e2e-33a4-49be-5c19-08df142427a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 5LV9XHPfGKgOFimnKo8igeIx8NtBWMFNuFhtAXeU8QZ6rVL33aurjDkAZywrrqUHg0G6qhexoZJQBdyENfM3PorFBZNdPVFFjNTztu+AjmIR9MGPGKGol8TeNIM+tYSoXVjj9WpPY//1KnIvi3SKJN/F6CD80sMSLJoyj8UEyean4YYY4XfR6jj1IHPWEAgVX97cyxmCAQu0If7v4/7bBu0MVw7xeqvS7F0Cn0hK+N3mJ3Iwvc6OECQ/Q6UQPUXdr4D4TN9VOAuE4Ao45zjekki1Tdq2V714kVvby18nYXcOZqdmqoSUD2DoAnqfI3gH4k7T4lO2VRdblFCFxOVPUFRgBKyZYSr+kXX5kMcAHqgRLmkEDzlYT1gmKJqo1qXSaEckNc9UHsQSHZQ2R0D2yp58RAI8DNs1gmk89x77hzMLjoOO3powfoUah5UwUPXT8lPGiHIaOGpJAd1misd8hwjZiz3XTDAVoSgU8Run9e62+eKbqf9gSXGd6GFx3u4vrDKnUZyiQc1IEm5yeT6CabVWYO09T+R4DOlF7dqf/28Y8bdY6Tb+zqIwNx/7U/42bAxDWfWwy8aO392XLyGCrttrHLwVQjq4U8Wy070gZz07x1c1hjw3vQpbsLfl+joHiAuJ6IpwMeQrMTlygB23EuH4Q8ZWYSxW76yM4U0vXYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+TC554bQlbx7Txi824OuJU5qi8A2lvoM1cluu9miqNpkdSXMg/JLv4/l1fz?=
 =?us-ascii?Q?Tkozf6fSze9TTzryKuZFmmDtQLJD+6m0DLnHyB6h8YUrqWwQ/F1WT7IiUUPT?=
 =?us-ascii?Q?AyXBL4LgLbAvXo0PChqGT63gEpyaqEYTaSCPHtZPZsanRaL5AbegfYP+gnCO?=
 =?us-ascii?Q?uBaOxFhKJG7HUvSUc+ynjMfnlrZ+/d6MvY45LsfhIJ/qb42vp2ESM4oMUihA?=
 =?us-ascii?Q?7Ulhof4Bov4ZBL3FIoLVheSVo5xknmHVmGhLgeUMUw/iozDD5ZuocarQlrFj?=
 =?us-ascii?Q?uyo/VF5L5i4sv+jf/0XYSEcnnEyZRjuoh/3L5IqL5ltblsDbhcV0YXi5pk+B?=
 =?us-ascii?Q?QrNWJVWVD3NXlLiBTVfoJq1mJef8YUsPuIlkg40BSZEEKbcBHoqCEUHvJMG2?=
 =?us-ascii?Q?DBfKV25h1fjWaOORFbwwTY4TKnyXRCU+6yx+a02KmcVIXH2IPGRyKV910WN1?=
 =?us-ascii?Q?cD8GIP2ZcXtayztr77yNRlT7PlzSC13mlhVFYwq4PZibEGDNd0qcQmIkOseH?=
 =?us-ascii?Q?0qfxs2RLD0RBDlh/yJoP0k+FxVhqLxyRonT38NHgbBRxU7TLyNrkdeo6gqWq?=
 =?us-ascii?Q?uId81+/Hrmau6+eyh2WkCLk0AiB0mImZNgQzt0kdzRR93coVhh1BVdTYaX5+?=
 =?us-ascii?Q?e/ztfsSDu63hsmRh6rsutBXneh1OBHwWu7KXU72ulEqFWvE5jYDqiyBCbsRu?=
 =?us-ascii?Q?4W5A1G2jsDhXndh+CYuS43i1plHlp09bGnKzVTY0c4i1IpvLWf6owQ6+mXPY?=
 =?us-ascii?Q?2I8qfzETdxSinXNV5STZ0fFDuQXRTySYIdFDitvX+qIHC63iKXI5xWT9z8eB?=
 =?us-ascii?Q?7umfG4dKLvm3kg4G2n0QnvIKMkIpxJ53XQLBKp9kqHT6FDOFIAcKE9WYr5oq?=
 =?us-ascii?Q?MqhQAKO5h+ub/FWy8PthfvXLxmw3p3qYeXR0YIdb0iQAlX6bmExRIy4VbE9d?=
 =?us-ascii?Q?6iEiIkW7nhXRPAIE0lE5t7k/6xrZqJM+WzIJGMfHmceKK5a5lw2Esgs/pd+d?=
 =?us-ascii?Q?Gf5b4zAD2ddNDLRgcJRnSwV+s4dyInhssm8DIkswignbJgK1hOsXujgOL4/K?=
 =?us-ascii?Q?DqstXVHAcTGfTtjNJ3U842Rm2md3VdVWkNTb4MzrYmLBZT0qiGKLGMq2qGhN?=
 =?us-ascii?Q?UBWDUCWxNeP/94jSytsmPDCfH17P9KtCpo2YWpPi7xcDvGJRA/zxaH9GB+Og?=
 =?us-ascii?Q?ROn6HWIYBTGgC806n0FU70A7lIO06kNoLajzxDIKNPe6AkBbt4qU9DhGidRR?=
 =?us-ascii?Q?LF247dcv2SqqScenklEubKPQ9B7k342zQs4ulW0WFl6dRMwja48xprgt3ZrU?=
 =?us-ascii?Q?GRSkdIm6Yv5ehwnziNegAgGGd1u8ehf3f9+Axqxg76mNDYTY8KqU5S1xU3dS?=
 =?us-ascii?Q?6XnYxMpfJTrQLCNRWQp9zlksEDkfqChCN6MHWhnclFhXNgqNJpfTZ4kMrS9r?=
 =?us-ascii?Q?ivY/lNfcmhp4mgD3ATzj4vdCdEbRg0SdJRA7KSmdsZYO+yOBaGipDXkpVNrq?=
 =?us-ascii?Q?eGH34TRXIRmppdq+TzPx04TrZd15ucaylbv/U/JAfa2NWAuQ3GVyHVuuPiVV?=
 =?us-ascii?Q?qKiIIyMV8OixpheRsBore49hsJJwwpPKJxufbxejEYSpYpO6By0D342sJwMf?=
 =?us-ascii?Q?Ippy4ihuas8nQTnTzj2utDgHZGtDkxxk2p9JMmGsisEmP62uHc9CYd9zPVOo?=
 =?us-ascii?Q?RxqpDZfGEv7t5PAidqxzOnfWAFFYGx7ss7ZufbQwj/9RfAUJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3565e2e-33a4-49be-5c19-08df142427a1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:56:02.6705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsFMqmkvF3Lx/r85Hcfznf5eO4TIIDCCYv9B8BHtg8A3bHPRH2aiyk3xmMuWIKlum8H6r/ixolgr8PLUywerrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=tdave@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This patch series introduces a mechanism to specify Guest Physical Addresses
(GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR addresses
to match host physical addresses for assigned devices.

On some platforms, P2P DMA between devices in the same IOMMU group is required
for the desired data path and performance. The PCI fabric ACS is configured
to permit direct P2P without routing traffic through the host bridge.

To support this multi-device IOMMU group P2P scenario in virtualization, the
VM may need to preserve the host PCI BAR addresses in the guest.

A new fixed-bar-N property on a PCI endpoint device specifies the required
guest address for BAR N (N = 0 through 5):

    -device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...

Once any fixed-bar-N property is set on a device, every memory BAR on that
device must have a fixed address. Under a PCIe root port, fixed BAR placement
is all-or-nothing within that root port's subtree. If one endpoint below the
root port has a fixed BAR, every other endpoint with a memory BAR below that
same root port must also have all of its memory BARs fixed.

QEMU validates the configuration during device realization. Each address must
be aligned to its BAR size, fall within the appropriate PCIe MMIO aperture,
and not overlap any other fixed BAR. QEMU aborts on any validation failure.
QEMU performs neither PCI enumeration nor BAR allocation; the validated
configuration is exported to firmware through the "etc/fixed-bars" fw_cfg
blob, which carries each PCI function's vendor/device identification,
firmware device path, and, for fixed devices, the configured address, size,
and type of each BAR.

The fixed-bar-N property and its validation are generic and apply to any PCI
device. This series wires up the fw_cfg export on the virt machine only;
other machine types would need their own equivalent wiring to expose the
same mechanism to firmware.

On the firmware side, the existing IncompatiblePciDeviceSupportDxe driver is
extended to consume this blob. Before PCI enumeration, it reserves the fixed
BAR address ranges in the GCD memory space map. During device discovery, its
CheckDevice() implementation checks for a fixed-bars entry first, falling
back to the existing 64-bit-MMIO preference descriptor otherwise, returning
ACPI address descriptors with _MIF|_MAF set for fixed BARs.

PciBusDxe preserves and programs these fixed addresses when programming each
BAR, and sizes and programs each ancestor bridge's resource window to cover
the union of its fixed descendants' address ranges. This allows fixed BARs
behind one or more PCI bridges to be correctly routed.

Fixed BAR placement requires firmware to preserve QEMU's PCI configuration
across reset. This is requested through the PCI boot configuration
preservation mechanism using ACPI _DSM function 5. Fixed BAR configuration is
rejected when ACPI is disabled.

Example 1: VFIO passthrough device with fixed BARs and the PCIe MMIO
aperture adjusted to accommodate the fixed addresses.

    -machine virt,...,highmem-mmio-base=4T,highmem-mmio-size=4T
    -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
    -device x3130-upstream,id=upstream1,bus=pcie.port1
    -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=2
    -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,id=dev0,\
            fixed-bar-0=0x48000000000,fixed-bar-2=0x50000000000,fixed-bar-4=0x58000000000

Example 2: VFIO and emulated devices under the same root port with fixed BARs
and the PCIe MMIO aperture adjusted using highmem-mmio-base.

    -machine virt,...,highmem-mmio-base=64T,highmem-mmio-size=64T
    -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0
    -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
    -device x3130-upstream,id=upstream1,bus=pcie.port1
    -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=1
    -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,rombar=0,id=dev0,iommufd=iommufd0,\
            fixed-bar-0=0x6b4000000000,fixed-bar-2=0x6b8000000000,fixed-bar-4=0x6c0000000000
    -device xio3130-downstream,id=downstream1_2,bus=upstream1,chassis=1,slot=2
    -device vfio-pci,host=0012:03:00.1,bus=downstream1_2,id=nic1,iommufd=iommufd0,fixed-bar-0=0x6c8000000000
    -device xio3130-downstream,id=downstream1_3,bus=upstream1,chassis=1,slot=3
    -device e1000,netdev=net0,bus=downstream1_3,id=nic_emu,fixed-bar-0=0x20000000

Limitations:

* I/O BARs and the expansion ROM BAR are not covered by fixed-bar-N.
* This has only been tested on the AArch64 virt machine.
* SR-IOV VF BARs are not covered.

Testing:

The series was tested on the AArch64 virt machine across a range of PCIe
topologies: emulated devices, VFIO passthrough devices, PCIe switches,
single and multiple fixed-BAR endpoints under a shared root port, and fixed
BARs behind nested bridges.

Changes since RFC v2:

* Replace pci-bars/fixed-bar with per-BAR fixed-bar-N properties; drop the
  root-port fixed-bar=on property. Fixed-BAR handling is inferred from
  devices in the root-port subtree.
* Drop the separate post-enumeration bridge-window reprogramming pass;
  PciBusDxe's own CalculateResourceAperture()/ProgramPpbApperture() now
  size and program bridge windows for fixed BARs directly, as part of
  normal resource calculation and programming.
* Include the firmware device path in the fw_cfg blob.
* Integrate fixed-BAR handling into the existing
  IncompatiblePciDeviceSupportDxe driver instead of a separate
  QemuFixedBarsDxe driver.

RFC v2:
https://lore.kernel.org/qemu-devel/20260827004024.598351-1-tdave@nvidia.com/

RFC v1:
https://lore.kernel.org/qemu-devel/20260508183717.193630-1-tdave@nvidia.com/

A git branch with this series applied is available at:
https://github.com/tdavenvidia/upstream-qemu/tree/Upstream-fixed-bar-Sep-15-V1

The related EDK2 change is available at:
https://github.com/tdavenvidia/edk2/tree/Upstream-fixed-bar-Sep-15-V1

Tushar Dave (5):
  hw/pci: introduce PCI fixed BAR properties
  pci: add validation for fixed BAR configuration
  pci: add fixed BAR fw_cfg blob export
  hw/arm/virt: export fixed BAR metadata via fw_cfg
  hw/arm/virt: add highmem-mmio-base property

 hw/arm/virt.c                   |  78 +++++++-
 hw/pci/meson.build              |   2 +
 hw/pci/pci-fixed-bar-blob.c     | 305 ++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.c | 326 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  21 ++
 hw/pci/pci-fixed-bar.h          |  63 ++++++
 hw/pci/pci.c                    |  43 +++++
 include/hw/pci/pci_device.h     |   7 +
 8 files changed, 844 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci/pci-fixed-bar-blob.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h
 create mode 100644 hw/pci/pci-fixed-bar.h

-- 
2.34.1


