Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E668BCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8AlP-00053P-HZ; Mon, 13 Oct 2025 01:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8AlJ-00051U-2s
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:06:22 -0400
Received: from mail-eastusazon11011023.outbound.protection.outlook.com
 ([52.101.52.23] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8AlG-0007DC-PN
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:06:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHPkkCIj2WC9UPMhChIG8K9sHIzw1qA8ix3EDqtzS0aAoZIOdltSwJ8QbdGvFtZi49dvXK1lU+WncuOFIyHqIPK1q5ubxQeX43boEIuoUBswnoLM6xM1GXxRL3sFfiEU52zbNAdc/5yTtwgDX7pJYVie5Jsrhxt7wabY+2K0DYN3S0be9oZ9VAaYULAwOJT+OuzUThAzWZj+VUGJYbhZMTICnbnHYusj0f2eRJhVUu/YRTLsjuuAQHF4OeT5RczJMfeU1gRCGQ+3igNI4OzpA+YGIG4Jb93ItWxgxlpxyKCohjl/hxIhRoHa8lXgsSQkC1Zt863H17BqnBKnqQEtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dwLrP6aMYe0+x7+ggDRj7NeyItl8ItPdmU5lA7sm50=;
 b=N9tcmNT4RSNgqJjFcZtqlkQKIJhBYY518uYkNlzWj64xHcoZWpZqPw3sxdWxKCZ23SVPuGocpdHJ2d3VPoWO6RZSClofa8IhuEW95vQLmw7DATEuU3RuzJTcrpdiJrqieubuWzGsjb8sLbengt8b73jys2FjPd2QyJeUxeNlR4zyBJnRDlvb6h+WHKS9F79Dcz4LpO4n54Wf4pMzWWkJZfjU+0KsxhXyjJ3LbOYj4dTnOEcJmAgFTTSjuFe9Kacko0w01ZukTH19JPrm3iO4fFE41ufrj6DsYUZzEWx4dOAdUPChK6uLp5Jm/yoeMvPrvFOyR/Akv2NJI7snB3pSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dwLrP6aMYe0+x7+ggDRj7NeyItl8ItPdmU5lA7sm50=;
 b=3sLlusfRL0E+YyjE9VGZQBas6xERmJEgQXHN3j0abwwaXcq6+czCcB65FEwVbEI6En8vaoh7RhjAVusdSolh4S17tHzHXF0jnRhwfbVKBZSVaVnBkbZC3NL4NpeuplByd7VU4h1JbwifUaOWUZ0cMPSeNYbHFy8qqVHq4DGdbLg=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:01:10 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::ce) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 05:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 05:01:09 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Oct
 2025 22:00:58 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>
Subject: [PATCH v2 0/2] amd_iommu: Cleanups and fixes (PART 2)
Date: Mon, 13 Oct 2025 10:30:44 +0530
Message-ID: <20251013050046.393-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: c0521a0f-aeee-4c86-f3d9-08de0a158645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xrElkgRvoK7ZtDaVJuMtna158BT2bDEZr38CnyWD/SQcd1toIJ97rarxaaQj?=
 =?us-ascii?Q?xIxfYahhNyJb8BVVu0EOBuXdZaVL+0kKyTWBozzxyqnjJZveTgWhXnpYZr7e?=
 =?us-ascii?Q?TaAzU9fZNPkW3Up0Nh6zdL1j323G3aNp1AlqOmxXLkAUAlVK2Vh++n2xxkn4?=
 =?us-ascii?Q?+tnVojR/8g+/LI7nn62kTggS4jOrRITyy0tXp33GUxlvI4Htx2NomwWZYcdJ?=
 =?us-ascii?Q?isDa21ML9bVeuyje0aiVb+sR1Z0dWoOghJqlF0SqUJwy+p0z4PJt9ynZS4rb?=
 =?us-ascii?Q?1z0w4/IXr/rJjVdbEnzSFCMBfvxVo+T5kRpjTLDP2fshF4lrIn80xB9hv/eo?=
 =?us-ascii?Q?noUEk0SMZ9Fa7xOfcgNj27M7WrW8Ps7glknEckCC5r4bj3IhZGRlFdD6fK8X?=
 =?us-ascii?Q?obhqLhercjXaxHaTonBZI7gLRljnr6wvizGJSEd/cGCC+OJy292INMtykh2I?=
 =?us-ascii?Q?TqKkYIGsfbdOv6rl0Z4tZqt7uHx+G2QNAe+Ktz7Bx8mKSQ+cb5kgP0ekN2Nl?=
 =?us-ascii?Q?zqe1PMsolMi4ghMD6JaUvhBQEDAvs2D3XH8TtETYQKhsmDphptLAsc2ganUf?=
 =?us-ascii?Q?9tuDLSAAKB/e4msQEK51GExvj5DJKUPeZx/mzWZOg3ZMXXNV/sMAFMMFnB4x?=
 =?us-ascii?Q?2Gxio4wYsJBFz9e/2ANq4+gr6JaO5jKg8mJKhAdgcLeda/NKwVelkX2M9QqR?=
 =?us-ascii?Q?PcQkHmzSwsvgnkr0oxTPWEvsO3cfBD+TPcNRqc6S4LPfO8tDVVUghq0OouaN?=
 =?us-ascii?Q?e3R8JIczksRgzKPG6pXzBon+AxuqlJj50paiKY3wiZWpTLgrjYWP7UGmE9u4?=
 =?us-ascii?Q?jSHkdMisneB1eVFXAC+sFcynV6loZyRQAknvH5ImyG3cxprVxvaiXWAGVmbB?=
 =?us-ascii?Q?JKolFBwAg+HL/sqVqx4wNW+QEP4+FRGr+kP7x6l0rCRhkJ5PieDamyyW2qgQ?=
 =?us-ascii?Q?wcjnU7WqH/tn7OT0gWcECt0fxkY0sg7fh56urJ69ddr01Na3Bu80fz4wvFoN?=
 =?us-ascii?Q?cW48Nw+I5fyKCANPfhL2zg0PcTNWV5VjHwKSKZy/fngV0sjU1dL4V5CPOf4p?=
 =?us-ascii?Q?fV5XtnO41tG08ICTNf+o4MfHWgmjUT8TR70joH9VNn88jRpiWDCKXXjLZ7RY?=
 =?us-ascii?Q?gMHRO5YQKx8rTzcL/WK8/FBMk2DGMa57k/drjn9FVKH3dUOsWEtciuiTvo9k?=
 =?us-ascii?Q?mlECLwIBlDOm0Bs0IIMaETMArH9r9vT1OPdP3+n8GPLQsIlR1Peegw7QDnk0?=
 =?us-ascii?Q?Ds/l6sCY0MtNyScjFTQr8oUih8wnKEdy/etLGAZW7bxI/Qy73nlsC7pAX/6e?=
 =?us-ascii?Q?gwQ5SLiD5BgHkxpQMTfKYqRBmP1IndXCn6Sqa3hi+VCnzTh0TfpQpdWKvrY7?=
 =?us-ascii?Q?WPwdnhJ23s4K9VfeuURX5nxzf2X8yTt2KUGgCYFarZBVPQhrIOKKj7rYTD6T?=
 =?us-ascii?Q?3vW4x5Z5we3koVPiqR7sBPzV93OAFqGT1j5+kAYYUbiM0QRBWSA9kSm90/Rr?=
 =?us-ascii?Q?TfD5azYEBRWv9dIkIINUIMyBoYAo0tcz0wWF0JhQ77X/13SbTkZGsDMzK6y/?=
 =?us-ascii?Q?kmKoqRGSA13vDqLXgh4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 05:01:09.5995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0521a0f-aeee-4c86-f3d9-08de0a158645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
Received-SPF: permerror client-ip=52.101.52.23;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series provide fixes for following two issues:

1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
   bus id != 0.
   e.g. With following command line, dhclient command fails inside the guest

    -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
    -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
    -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \

2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
   setting up the devices when guest is booted with command line 
   "iommu.forcedac=1".

   One example of the failure is when there are two virtio ethernet devices
   attached to the guest with command line
   
       -netdev user,id=USER0 \
       -netdev user,id=USER1 \
       -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
       -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \
   
   In this case dhclient fails for second device with following dmesg
   
   [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
   [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
   [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago

-------------------------------------------------------------------------------

Change log:
----------
P1:
 - Use fixed type uint8_t for devfn
 - Use uintptr_t instead of uint64_t
 - Build hash key using lower 56 bits of bus pointer and 8 bits of devfn
 - Use gboolean instead of int for amdvi_find_as_by_devid
 - Update comments
 - Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE

P2:
 - Reword commit message
 - Correctly initialize `struct amdvi_iotlb_key`
 - Remove unused macro

-------------------------------------------------------------------------------

Base commit: (qemu uptream) eb7abb4a719f

-------------------------------------------------------------------------------

Sairaj Kodilkar (2):
  amd_iommu: Fix handling device on buses != 0
  amd_iommu: Support 64 bit address for IOTLB lookup

 hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |   6 +-
 2 files changed, 113 insertions(+), 72 deletions(-)

-- 
2.34.1


