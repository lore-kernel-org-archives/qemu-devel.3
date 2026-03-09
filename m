Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CC6FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgBX-0004xn-Oe; Mon, 09 Mar 2026 15:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBM-0004sy-SL; Mon, 09 Mar 2026 15:22:26 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBK-0003d7-7S; Mon, 09 Mar 2026 15:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF6xk3FaPyX80EMC2tarZm0I9iVqsApcaMrg+eDqBGSh/nNkfJ8Hni+V59AurZjfILksEtG7NRqDbf8hliVrhbqqgyYsREfO5hczNXtpF3yynRHNy/24oZWkXDHTiumNESEj56VebEsWPj53SjaqIz6cmq38bqC7+Jm5S2JW0jzaBQ7kY/ihc+JlM2qHjeSprBjKqtWWbsOjhfquxBpezAU2pKe3gfm7GWfTn0+H7ZCpHU7qya4OI+MCAzG2M6QXN+EUGJ5RctParTlB37IWLZChIXnxPpptRd0L17YsmKJK7JGj7nc38IDvOp6ZSyAAGDVg+kgMHCvt/Z0fydl7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za7G+rX+WA8HiQvmEuwmXFSLrn4lurzic6OfPvxLlyE=;
 b=lGHyk7d/BhlWrlaoZmNDD6u8nhkmmhGlhQZokLlBr6zD0FoaPzmUrZXYW4B80K7ahAc6cBvHaB5bMBRKnqgxw7w/TmRX4xM68WrudcSBlghRTjOoZvzT5N2fZXgnO2GSksJJ57am7DOvcqSqdETQ5Q2ZJ4IFTdsyiE7K7Y5fnpQCkWqKReDOvBlO1nHasNTF093AzXteh5Jn7Z+574nCtAnRhBoyhv5lqa307rEfiZAFQGgHrp01Na/UQGuyoQDQPd4/KbN4U2wWfVqnI/lq6NkUET4j+JwbyD4DP2aJqnmB6AVLvjn2vX8BjgW4LzqBfQgQQ3zIi34QS1ekTWKtUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za7G+rX+WA8HiQvmEuwmXFSLrn4lurzic6OfPvxLlyE=;
 b=GYvLs0CN137tVGO3OOwEtcHhzgGlPxsEYtVSdojnQj4SxFCoMgfBD18aMNuffWuYHukFKbUBl/xbcW50uAHKUqqclMZRswqEqGXTVSteIMrJ16UqwjLxeEwYTR5TQPR+a1hR0xRfBH4y241wRC2YMeGsS/MSrB10dWgy0aocVGiR/U+YOwfy+xg7t7BkHm4vWUeoRwsm+tsBDLgGv/g0U5gSq+XLOtcvacmN5JcXZ5zQph/rvCzjgVX6RoUgVJw6cETDkvpFLnz4G5HnVutVs2rg5b2QTxzxziLFV+19Tg7SvamCSPoxfjiCHSL2j5m/12Id9NfqixXCkpKtoQy9kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:07 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:07 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [RFC PATCH 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Date: Mon,  9 Mar 2026 12:21:11 -0700
Message-ID: <20260309192119.870186-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ac4972-b954-46b2-82b3-08de7e112734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 3EkKXXIhKv8LQ+fzC4OhyVEpQHgWa4R19PN3rq0kUf5rs4iWSd9q98Y/7wBEEZFM43YYz7QsmgkhP3z3HCHkSbVHg5zz+rEY7aDrRnkZG9M7+CzJaTk8urEQr3JQk8hiXNJoJ0FHnGM9YRA4zonH3L+HvEjUMoAd4wMxrFwtFc0PpTMHGORFKFkGsq1d4B+xeunYarYojPWui8jU8jUEH3z1pvHGq00pwahIVlVIArVobv7V667ulmWsnkHISO87c1VSar4bAG4dv0wB9BXPh1fKRCHmjjhFOhsYdV1rv1wjknLy3wTju53XvXwe6vOXJBKOQOxNTkY1nTci/GiKuRsJ8qs4PQ058imEG5+NaOKHN8mP3CHe8f5eOa9qleWFjy9kHDm1iK6i92r4qkJwEQ3CiMumMxbff9BYTKhbd4717ujnXpfgUywsHDt85DK0rSfZHFznQ60nmSZqhufQcyGd4KE/CwcAELyGq09AakIiWIMkgmfkYXSiKPpqheq8mzbUus50OlrxIW7ViS/3dtVC0exzSruQil3GEpc7E3DcomxQTK+oHNNu/Q2mctcho6u46mU8G82IYCw/C9mtRel9/nABBgoYzbU5DSQrX6tjXVbI7Yh7JXajgYwet0SheyqIfN6nIuMnt6SbOO1LFdfbkABdXaU1cs7iT5HBGrSuePfLNmbNd/2a2eQMoers
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4OEZgnQ6oxenIaqDbZktU8EwGtlZ3rLLIiQYxI6QaWTvWBpJcNSqWwRFLRG?=
 =?us-ascii?Q?vve0+3F/83/xaD+nJgXGxXg9Bh8DMDX8f3Z71oA7M30MkXbN5PLhTtgdvy5b?=
 =?us-ascii?Q?AYSh1eomjOszu3baP+JJir6TsY7IqA8xmEdfxXNQ/3R+BEMxwdrGaSKMgNcJ?=
 =?us-ascii?Q?ICfHxopWaixx3a8JCogVthyXFV1CH7WcdPYD3Hh7WVz206XmpTznRmAVr4po?=
 =?us-ascii?Q?snuRvUl3vUdRAcGaiA+WhhQ9vWQ2NTEbzTbn2yYe7VnRt34dWVcQTZT6OR5m?=
 =?us-ascii?Q?Xp5Fxyp4+ohYQV7iWbLlmDcp45U1TLi2rDXXWPsoZml6OBiMMr8AA9xlsRyJ?=
 =?us-ascii?Q?HZa5q7CD9yBI2lsU5XqoAqLNc23AGnYcvX7DESPmR0bq4Lj7Eg+W5CBvMGm9?=
 =?us-ascii?Q?RvgIdYVDMEfmmW0PB/oJU5oQ7liNHjRVDIRjm6JhXFWQcxpGO36MEm1d3/nQ?=
 =?us-ascii?Q?L2F6tXMp1961Lwb0SPD47K0I1nKp2k52wOTczSDROgBz+Ppjz4WxTrv1tunF?=
 =?us-ascii?Q?Sg7kqXsG/0Y+H7R/Szgh5B31Uf44jm+gfq2mmjLlxGMOtobeZz4MQvvGcCUT?=
 =?us-ascii?Q?2/rjf7vSZXw6zE8ncap+9p1BsjwOrxU687cOpCA3by1SWnb6oCjuDi9UAxMO?=
 =?us-ascii?Q?Lka+35VtmBZM1mllPZOo3DbsYpbsD80cbze0QN/GsRKWfYV/DH+HedfkfiMq?=
 =?us-ascii?Q?ME+ri+3JOoLaiANRqaiCSX7b50TvlO0GlQwQ7gyEe83A7DSSgHXtSYMHKHB2?=
 =?us-ascii?Q?yTwAgL9kWRANemJ5JZOK9y/CyspnQ+mjQ+po+7WANlBC5YyGLjiEPRIvZBIz?=
 =?us-ascii?Q?b2K/wVofIJsys0rgfzkf9Y0PubFCIlzRZ+hlsyIMmDge1Z1Jr9QFljGKWuDL?=
 =?us-ascii?Q?sa8OrYG3FaACUA3Dk2ZRWpPSajTK4spdFfzaH6qtfIeIH9at0HmswIsYQvgS?=
 =?us-ascii?Q?mMIEOemvM4x3Q3xVptamxK1cJ0YBppK1/zk6ob2ZpO7T8tgHFNjRQsSiMlst?=
 =?us-ascii?Q?Gufs9chfm9xUFKMUcw8GnY8shBtAZfdFaB01yLeZk+vpNp0UviwZEIGjpcDd?=
 =?us-ascii?Q?0TUUOlij9r7V6sc/yOlngFa8yh4oFke4z6vgY3a00LJOzD5gtr0DOi6SxNUE?=
 =?us-ascii?Q?+Mj7kQtToAkm/Etjz1uq4PiQ2BBMyyzhpG0PEiEn+LSKi+pf17eUukQ5NsIF?=
 =?us-ascii?Q?FsY9s2J+MdLSqr6krA6z8pmFgykRZ5T0/Ss0HuvdH9IwTZcV2zWl2Z1ScoID?=
 =?us-ascii?Q?Zp3K/Oi9ZZZz7EF3v77q4x5aJGY/5DlmrtFRCH4UdKszirNcevWNpIjpL2dU?=
 =?us-ascii?Q?sI7UOWanVjUL09KZce14gcG3vfa4mlMcpCmnxymTyA/EHucJfhOi2ZERNOn1?=
 =?us-ascii?Q?Qc96SUJVi9KcaAbXBkp43xi3KbVoc58EU9WmGIIWMA5b62v5NqSVMi/fCFtc?=
 =?us-ascii?Q?YQkbHkYxMIVILn/7szfrCg4HwJkle6jTFEtkyK+ulRnSr2+UbP6vV0CU94df?=
 =?us-ascii?Q?+0ZSC+h+ofSaUi9aq4Otj3xosdSh2/DaIEPH0Kk3XfNiyNbQMZxilWvZxgPj?=
 =?us-ascii?Q?vrAVCc6MOAZd1jW5MPXn068D9pfcuYBrxznbLWJ4mctEmxVs/zukTxY41HmH?=
 =?us-ascii?Q?ug6SwVVQhUaTZI4d5Ks9d/hyj+maOfstscVBGlxcCXeHDOKscf3ofLGYHxxo?=
 =?us-ascii?Q?g7htaoLGQlVRwmVeRRQ570revtitHGvJVjTb5qr3mkUCOoHy0DiiuK1Z9IrE?=
 =?us-ascii?Q?fUsA99YgKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ac4972-b954-46b2-82b3-08de7e112734
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:07.1881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81v9NODO0ZJ7yT5LFbzyj0CfLzdzQNCW8DVRT7yJ4gwws59qOLvDL7w5LCIf9U/Bu2YoE/amPmclkAGe8SbQPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Hi,

This series introduces support for specifying 'auto' for arm-smmuv3
accelerated mode's ATS, RIL, SSIDSIZE, and OAS feature properties.
When set to 'auto', these feature values are derived directly from
host IOMMU capabilities, avoiding the need for management layers to
introspect host settings.

Accelerated SMMUv3 Address Translation Services support is derived
from IDR0, Range Invalidation support is derived from IDR3, Substream
ID size is derived from IDR1, and output address space is derived from
IDR5.

Additionally, an OnOffAuto "ats" property is added for vfio-pci devices,
where setting 'auto' detects the per-device presence of
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED from the kernel, and the ATS cap can
be advertised or hidden by setting 'on' or 'off'. This is dependent
on Shameer's recent kernel series for reporting effective ATS support
status [0].

The default values are set to 'auto' for all properties.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto

Please take a look and let me know your feedback.

Thanks,
Nathan

Example usage:
qemu-system-aarch64 \
  -object iommufd,id=iommufd0 \
  -machine virt,accel=kvm,gic-version=3,ras=on,highmem-mmio-size=4T \
  -cpu host -smp cpus=4 -m size=16G -nographic \
  -object memory-backend-ram,size=16G,id=m0 \
  -numa node,memdev=m0,cpus=0-3,nodeid=0 \
  -numa node,nodeid=1 -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
  -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 \
  -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0,numa_node=0 \
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on,ats=auto,ssidsize=auto,ril=auto,oas=auto \
  -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
  -device vfio-pci-nohotplug,host=0009:06:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0,ats=auto \
  -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=1 \
  -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=2 \
  -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=3 \
  -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=4 \
  -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=5 \
  -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=6 \
  -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=7 \
  -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=8 \
  -bios /usr/share/AAVMF/AAVMF_CODE.fd \
  -device nvme,drive=nvme0,serial=deadbeaf1,bus=pcie.0 \
  -drive file=/var/lib/libvirt/images/guest.qcow2,index=0,media=disk,format=qcow2,if=none,id=nvme0 \
  -device e1000,romfile=/usr/local/share/qemu/efi-e1000.rom,netdev=net0,bus=pcie.0 \
  -netdev user,id=net0,hostfwd=tcp::5558-:22,hostfwd=tcp::5586-:5586

The properties may also be omitted as they are set to auto by default:

  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on \
  -device vfio-pci-nohotplug,host=0009:06:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0 \

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Observed the
feature properties being set based on host IOMMU capabilities and the
ATS capability for a vfio-pci device reported based on what was reported
from the host. Additional testing and feedback are welcome.

[0] https://lore.kernel.org/all/20260303150348.233997-1-skolothumtho@nvidia.com/#r

Nathan Chen (8):
  hw/arm/smmuv3-accel: Add helper for resolving auto parameters
  hw/arm/smmuv3-accel: Introduce _AUTO support for ATS
  vfio/pci: Add ats property and mask ATS cap when not exposed
  hw/arm/smmuv3-accel: Introduce _AUTO support for RIL
  qdev: Add a SsidSizeMode property
  hw/arm/smmuv3-accel: Introduce _AUTO support for SSID size
  qdev: Add an OasMode property
  hw/arm/smmuv3-accel: Introduce _AUTO support for OAS

 backends/iommufd.c                       |  15 +++
 hw/arm/smmuv3-accel.c                    | 118 ++++++++++++++++++++---
 hw/arm/smmuv3-accel.h                    |   2 +
 hw/arm/smmuv3.c                          |  43 +++++----
 hw/arm/virt-acpi-build.c                 |   2 +-
 hw/core/qdev-properties-system.c         |  27 ++++++
 hw/vfio/pci.c                            |  63 ++++++++++++
 hw/vfio/pci.h                            |   1 +
 include/hw/arm/smmuv3.h                  |   9 +-
 include/hw/core/qdev-properties-system.h |   6 ++
 include/system/host_iommu_device.h       |  10 ++
 qapi/misc-arm.json                       |  31 ++++++
 qapi/pragma.json                         |   1 +
 13 files changed, 292 insertions(+), 36 deletions(-)

-- 
2.43.0


