Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583E310F92EC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jyx-0007ij-0L; Tue, 31 Mar 2026 21:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyq-0007gM-G1; Tue, 31 Mar 2026 21:02:49 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyn-0007bB-Md; Tue, 31 Mar 2026 21:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrhM9IKuXe8bBeyiyAipH3e79ZzP4QP0t9QgacYAoWKcGXfD4jk/V2SjnCigbUaZxOn+CSAuxzo88uqwXO2060hIECthT3M0G3OCD7MVIlbgrnNkhH1usaZZ8h39hmlrx28M7Doe/xnbBQCePnV3AcZ7uQjebcP9KoQg6WyHG6u+DJklLVtXZiamCL4dL5V6vzGe5i0GNHoA0L7ciofTstuPeKKr9nMx9GymOPfc4dTgRCtBf/hsuOH6hDTZoPW4P6cvRDSK7HgWf7qW45WuW5LnBliFGG6i8Afxv2RCxfTVUlcLoYw9YBD3xrfmYOU0RV22kWxnJyAGMVTPmNN15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBzZ2Eo6p1Dl0vN5H0RBSs0vCydnH4L9+TGgAvbIJIE=;
 b=kwFbirfZHkg1X6kLHBurmCVV11qPKSO6v+3UvCGdbNQUs2kjPULcpl/1TetzqksQm68wQ9QODJ+2GIOJZXFoGTmyn3mc2ten1v8+t9/HGehJIP6Ao7hCXTut07pPxCqi5OGLQKYRd+KGI2fKc8FVdYBjLKbTRQOqae6rw7Z5dXb8t8ZQg9DO+QZ77UEfFS344M6ldocmVM4H/k+wC9CxUNyhatE1gDcZlYxfTHE7NPGISWD7p7u5HO7+vowGhtVX0BGiMoza+ygflF2D/Y/9zU93DT/palJy4mU5alVRTc7qcXElZOqeIwdF37rF596mvbKHS8jFz4b9HLdA9UVY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBzZ2Eo6p1Dl0vN5H0RBSs0vCydnH4L9+TGgAvbIJIE=;
 b=ewUWGR7EWCkaeo2tFil7giY8upuwOeqp65xb2I7CrHEyhe0ESuuQhooDHAzYukIsWl6dd19Ecb36bPQC9u5sfgLB+9c4/fEFatcnCCdUL/J7ZIKYBtzZf8b2Q511k7gakX/PcpMMaUZqtM4T4rYmHvHF2lNuficCXlL1JtFsILefUng2IMs78S+ClOcB3l5mhv7CRJ2DPKFKrNiBGUblV+kPHCfLlUlQy48EMlYrc4yuJtxWivbS/2Zdk0cQF/vTkwwCedzN+0sg3aTdHBnu95x4sJ99J+lEwhAqgyaKS06/HW4065Jglj5KFGIkjsdUZ+bDipoRztJaPuuJf0NpQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:34 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:34 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 00/11] hw/arm/smmuv3-accel: Resolve AUTO properties
Date: Tue, 31 Mar 2026 18:02:20 -0700
Message-ID: <20260401010231.4166776-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1011bd58-4a0a-4fe5-81f7-08de8f8a5bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +uU1uCwnlHwXSQjRmzdoj4FmMUy5EonjB1zv/eC/duYcF27JjZAgOxfUjzp4XroNKI95zpaZEQyhNExCLyKygk4CEFwKPmoHTIqbaK5QK8uqURkTqo1LMeeA2xIychEQtY7F285Ndecz89A37SFJi3NwKixtF+paPAhcJ2PR5hbkCDB9cCHgRarKnwdPW4jlTH3XP8pVVL0MDeKd84AqdPgqCpZpGwATxKWfsswHmtAqppf+90w6lM+Q2LgBDqiNza2ln2xGuo7mF6+60TzTR3tgV7AdscwCury/ifl4Uk6ReBboYlmF536vdQ479+JhTt1MVdOAFuQjhXJrR85Uq5K55IvejNqWq7jORulLkOLiDK0NArKgZAUfYCAsIjUyxaAJyWMBuI+UjCsqVtNxTkY242Jyo9gpKyXm/VLhZ7VTKrpPSeYJg/EZMsN/ywMTiIp8Kiz/Pwog4NNpxRXL382G5cmjClJ+Lm//xxdXgqkNxFw7d+dDVB5HFP3PgzJXLlAwoA37THX+AhR43tezX36S6ekwOMqLaSy1BSQxJOVUFEazt38ekR+Hcbwo3u/6hARJ1nNRpAvF2zPrbUWj4y5GOH7QyP2n+YlcsqGs898Tv0qYjimdAw0PqR9t6lpTLr52xriizoC3XPN8QKypBRW9xxpSbK4o+Uh5volbKEJ5ilt8yKZ45eSVUKw2BLF52yDregSg2E7LpWoI0na/9xuOpkxgYbORlpGcrHCw3IU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmPB3DSfkKrNsTfGKlOKEkmFf1VpWHw51XqQ0lpqLM8e8C+1/vOJQ+3R2soT?=
 =?us-ascii?Q?mHnvyXtYLRuuedzftHxBkjm9VRL8p0/ud+smrTHbeJjTjZuS50RUn/0xrXDX?=
 =?us-ascii?Q?ahVjhJ4om5vicyWjH9gOEVlOAxH+ZihU/KwWkFafor/nz2oiJA//twxKi9px?=
 =?us-ascii?Q?T17pnhc7lHplc5Pn7FjTSFAxuXUi4T3rjGgq5WepXRP00ZHVd1+9wxqsYI0o?=
 =?us-ascii?Q?tEJxzJu1VoKjxU2uQn5JLlxmfknfA6XvbAWmOzqi3JbkHoi0DNvrrU/bu44e?=
 =?us-ascii?Q?+tkbIBJkmFP4cAW2NJydEvb2Nm01VqWkfKvvPt3nwlmM6F5lXmZwTcWTzqoV?=
 =?us-ascii?Q?koBgBbWtGvBw9h79gvlZowsVRCnCziaxeOfiQN8jzYZRTRTWLprxd6OyQEEw?=
 =?us-ascii?Q?54+59uDqKZ/TjCnRcuRYRS5i2Hygz+lwg22UgpYah1TwV5ZcK88PQGIg9mQn?=
 =?us-ascii?Q?FscqnslLPgMil4buVqRKd3WryTi9D0qYditQv+X/jo8lyx5O123pjNh7LvXW?=
 =?us-ascii?Q?yczItuI5Gm4siLAkY6poxFqFL2VeF0S8jxAWiuYDS5Z0o/0DLHUa0PklxJCi?=
 =?us-ascii?Q?c0/WeqNTWZBA48S3B8wKm81sNvq82kJalHfGKw600oLjUueHv4kWuEzkirdD?=
 =?us-ascii?Q?xFYu8a4ve6JlZSfIfkFa5kGp77yLjsDvZoLKhzMjodpKTFp7Qhbm4lvhNC3Z?=
 =?us-ascii?Q?c3AfQpkEYWVkzRO59AgAMV7fAJEyfh3Yh9o+ZO/b/hyNNF9cZ6e343NA49z9?=
 =?us-ascii?Q?qjE59Uk6PgLqJFJjoSfPcCmqf0kWeRzoej7hcDWk/35AwohT7+WezM7ZlQhd?=
 =?us-ascii?Q?dg7kkqi9Ne39mdA7f1ZiqOKXcpUG6W5OIG8+jDtNZZztO0KDC66ma/pL37NR?=
 =?us-ascii?Q?nmVB3lmmdcg1pOF4OpRByCYselmLcYvAyrgpocINIeI9ouxIMuzM+EgmfP7R?=
 =?us-ascii?Q?ZYnUGl17iJ2vNyyXRn8GgzOo0tIF8eC6ehihSfwV3LlIg/+mwteG+or4TigQ?=
 =?us-ascii?Q?KLm0vrMjH/7hzNZRTT6sYshZ1su9rMGUkplCnDeT1Kj8Sza2EJ/n8JfdiCnb?=
 =?us-ascii?Q?VZZqOLsE2SiqUSsJ2JmOJHVV7zAxrejU1ngvdq8WYqSUeVj+TEQvBHuDI63o?=
 =?us-ascii?Q?Xu2mvvckRPY/ODzmn5Qpu4JfeqPCsfjqEgqf4ubQ7rGVDWVp3XVotBhuCs+q?=
 =?us-ascii?Q?isIk9swt7E1xSfSq7Po87TqCw8RiAW24XSkFr4SfhkJjWL10pWFOiSOE9/60?=
 =?us-ascii?Q?bIheSDSJ+kvyZlkgy3wS5+svFTASfyEdXhk1a5cTbUVr+64zSCwofvKGW+p3?=
 =?us-ascii?Q?a834soW5SaG334YVMjWue0qVcL9yYlASU41DOSM3D75UfamLlq3eaFaIjH05?=
 =?us-ascii?Q?sDcdS8RihEm9XnxDDGGEm7yOehKtK9XRl5+zQhpusHXYSh2zuOEVyao9CiOA?=
 =?us-ascii?Q?pJYdF8Jsko3NyHOel+uydnxw09/5FNtj4tr+KAM4ohN53nx4cBToEEKLmmQV?=
 =?us-ascii?Q?F9+5T+2lLfgLNROLTX7WXHT4/n+xzkMMXB2w6J192LwYvaLVbzu5zPvfwaqS?=
 =?us-ascii?Q?ERz697c2Mo2frb/hFgEXEs+jtcLM/Iu7hHRIP9R12SQkTvm9eISYw9Ro3FP5?=
 =?us-ascii?Q?Nn9kYlaAZ9MZafmNRViRdZcnknQGeUwjGhvw0P+aJxxp1THVLPB1uoe2Tb43?=
 =?us-ascii?Q?zFBNqTUszWs00t9ED8yW8Fp1sQyWiM0CdhGrBX05BMQqToJfPs3WexEJBPXb?=
 =?us-ascii?Q?E2GzZWhPOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1011bd58-4a0a-4fe5-81f7-08de8f8a5bbb
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:34.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmIos/nJiLSjltJTpGVTXxSwzXQtP/mZODP3YQeJWtNP6ufW8VIL9Fl6bBWB3dHTMR2KxVYkGomFT9XFqg+MeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Hi,

This series introduces support for resolving 'auto' for arm-smmuv3
accelerated mode's ATS, RIL, SSIDSIZE, and OAS feature properties
based on host IOMMU capabilities. This is dependent on the series [1]
for changing these property types to accept 'auto' values.

Accelerated SMMUv3 Address Translation Services support is derived
from IDR0, Range Invalidation support is derived from IDR3, Substream
ID size is derived from IDR1, and output address space is derived from
IDR5.

Additionally, an OnOffAuto "ats" property is added for vfio-pci devices,
where setting 'auto' detects the per-device presence of
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED from the kernel, and the ATS cap can
be advertised or hidden by setting 'on' or 'off'. This is dependent
on Shameer's recent kernel series for reporting effective ATS support
status [2].

The default values are set to 'auto' for all properties.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve

Please take a look and let me know your feedback.

Thanks,
Nathan

[0] https://lore.kernel.org/qemu-devel/20260309192119.870186-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/
[2] https://lore.kernel.org/all/20260317111603.101456-1-skolothumtho@nvidia.com/

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

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Observed the
feature properties being set based on host IOMMU capabilities and the
ATS capability for a vfio-pci device reported based on what was reported
from the host. Verified that the VM boot will fail without a cold-plugged
device, and that a hot-plugged device re-uses the resolved values from
the initial cold-plug. Additional testing and feedback are welcome.

Nathan Chen (11):
  hw/arm/smmuv3-accel: Add helper for resolving auto parameters
  hw/arm/smmuv3-accel: Implement "auto" value for "ats"
  hw/arm/smmuv3: Change the default ats support to match the host
  vfio/pci: Add ats property and mask ATS cap when not exposed
  hw/arm/smmuv3-accel: Implement "auto" value for "ril"
  hw/arm/smmuv3: Change the default ril support to match the host
  hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
  hw/arm/smmuv3: Change the default ssidsize to match the host
  hw/arm/smmuv3-accel: Implement "auto" value for "oas"
  hw/arm/smmuv3: Change the default oas to match the host
  qemu-options.hx: Support "auto" for accel SMMUv3 properties

 backends/iommufd.c                 | 15 +++++++
 hw/arm/smmuv3-accel.c              | 50 +++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h              |  2 +
 hw/arm/smmuv3.c                    | 61 +++++++++++++++++------------
 hw/core/machine.c                  |  8 ++++
 hw/vfio/pci.c                      | 63 ++++++++++++++++++++++++++++++
 hw/vfio/pci.h                      |  1 +
 include/hw/arm/smmuv3.h            |  2 +
 include/system/host_iommu_device.h | 10 +++++
 qemu-options.hx                    |  1 -
 10 files changed, 185 insertions(+), 28 deletions(-)

-- 
2.43.0


