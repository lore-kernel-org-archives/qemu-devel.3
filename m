Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB272CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XGr-000330-Jn; Wed, 08 Oct 2025 12:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6XGp-00032o-Rm
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:44:07 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6XGd-0002YO-Gr
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNMwUW5u7Au71MwPL1H+f/g/DdEXzWM/o5WqcY5lkv3XT3bfFzLXh7H/zXRp8ZmQ5UXwoSrFlwr75c8gTRRTjc4nZXoWTCc9x74o2CeHKkr46gp2Rnugh1WzYb1PMWADWGIFy4K7QzvSxQwYbirv/5p2IBQlb2bwr/y+bxAcro1jDvDrbOjvSLo0/OmLXsTtMgF+6s7jUOwfI0B4QnPWVuAJD92lDdZ8kwkkiJUW6DFAMYKZyIxNJ3+k3Nh0dAzK464tmcXCWJ/Djbnsy50kS/KU8KI9sL9wJv2KRmCY6KKL4Zy2Jn84fTY7VIjvVBZDd3YEq+93Hh4FmgBeg4ijpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vw2Y255YaCFz1cSzME1kJg/KuaUPv8/Ca3CIJ3VKy8=;
 b=NYoeyRiOyaTXOlINnqylxykUkGCIqaQmww5ys1KjrJA4TXzdgZmJCd78BtUptSVJORkqc3hlTZPIXwg21wVyU/4k9poch4WnidLj1OTz4db0avHauTTAe0KwEn4p4I5DMl3aE4SXmC+s+JBAZnxi88rZ7qnGxP8UtQap5CFL0h6nzjoJP9pSU34lIksojNt71zmZ14HT40VwQQ/jGVppVfCcEEvJK1hlGM+aC/YHQc4rnhgxgkClsqxI845D2wXlsppt5SNT0SK/1Ikc8fsWfb0oCZaSOAMR8sjlkDS0y+OIx+UN1UoSnvTxK1fKD8c6iPo4XnE8/WKoucx9iLeNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vw2Y255YaCFz1cSzME1kJg/KuaUPv8/Ca3CIJ3VKy8=;
 b=ZNNPavI8jvgC65X2ZlaSWvEMj3LcUPuNZ772nLKmTzkjyfevbKaw45NdQ3lcZrIPqv4Xlh+0J8uvIJE5npYuw2eCWyW9rLPdkLYy7jd2D8vdDtRKYWoI1kcTcDHclFyVgMMjETR+5n2pzB/FPfMHkuR9zk4Y744xsjA0dbAPhig=
Received: from SA0PR11CA0044.namprd11.prod.outlook.com (2603:10b6:806:d0::19)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 16:43:39 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::f) by SA0PR11CA0044.outlook.office365.com
 (2603:10b6:806:d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 16:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 16:43:38 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 09:43:34 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>,
 <santosh.shukla@amd.com>, <aik@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 0/2] Cleanups and fixes (PART 2)
Date: Wed, 8 Oct 2025 22:13:22 +0530
Message-ID: <20251008164324.21553-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0a79c0-c838-4efa-251e-08de0689d4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d69024qMNchRH+QE8mF4/HEL52q8IGelPdago8tWcKa9ZHzwrnRgk93hD7jo?=
 =?us-ascii?Q?se7VxbIUcLBBs8MGNq2HtHond9Wx+68DS3Zwyq9ZuSMCp2PETg9D8IYFUltw?=
 =?us-ascii?Q?75cIiGWo5LWPF8gS+twsLC0WyqLOvqGMSw2VUD4X7rOyCqmB5IxHj5NQdutf?=
 =?us-ascii?Q?2C3uDFX110w0PPVbfKymqYWhjeewUX7FoyPsAlepxsPsG/emQ1kORXE5cKzB?=
 =?us-ascii?Q?Cct6ay8jQr+XjUrLjzB0jd5ckr9BQgiAuj4L38bj5tWOKw6Av0r63/Ek7C7W?=
 =?us-ascii?Q?pMIbTh3PehioHpi74oUaEnx4zNkPvIk680DhV71VkLOMi7z0ib7ac7nDqGl3?=
 =?us-ascii?Q?vdUnn8G4JDftsqm5ZFTA3aqmSo9LzbJCDNBWi7PzwbRpjeU7s2EjBrz0YaXf?=
 =?us-ascii?Q?zt8f4VTpYTCHVyO6jL0gKO2XnzehaxO90mW/Uemfndz9cJ4WdXe76sR1yv1n?=
 =?us-ascii?Q?fAMJsTccJOWM70BSZyzZkhM+ge8njPE+x+DKq9mDTshQ/4f2kAODImAxmMFL?=
 =?us-ascii?Q?nC4lnzHdTogXr8eA4CNQkl7HesJiwJDxoTILOhVDkDDiqeffNT2OQQrGL2t2?=
 =?us-ascii?Q?AzEh1a5I7KDrfGvvvX+nOqIk0mwzODvdgPq5UgEarPNO/fNsUW3vJ7KJ1A18?=
 =?us-ascii?Q?so+l+MheCjRYY/Xe6PHeCR0ASEx1XUZFEv31L28WCvnPH54u8So4o+2FY4UA?=
 =?us-ascii?Q?TSfVeSIs4+O8/VLbrZA+353HbSfVhtfpFyqAUJHIIkqbVYlJXl7T8JgBOwMz?=
 =?us-ascii?Q?dX4q5AZ0H2FOwKdHd7/oZ9pQDHiUWLz2CoGkLYuaRbKlTs3/DiM6YaVqCIBM?=
 =?us-ascii?Q?lRUnY6cWlA7KC5uRmslNj9gFwLFY5A/reN0MFlIHPSXAZkYfLtVNkbiGNVuO?=
 =?us-ascii?Q?407q6B8aDrLaP3jWTN14+i9rZzEJVN3GjdW3wofjlgtew9jRHDZTvYS6K3Q9?=
 =?us-ascii?Q?Y+LVEsEyRqPR8RRJty87dMXlcdZ6pYhJcCOYbVfjayrqZ5fBaVLAZP9lr41e?=
 =?us-ascii?Q?6xGkZ+MmoH8MHUOnW9V5yUudbFrVh1tQDA+wP8d2uh4GIw2RNqz0DU8U1LIv?=
 =?us-ascii?Q?Gl+jQ8eBKh0O8YfEjGcEhmGd+dVjKfBYkbiOyjVyfP8OSYkXRvwfcAF7BQrP?=
 =?us-ascii?Q?XMYWX4Z919QzDtqdEXBT8K9Ue5hResQDDbvLTSLAIGxEiH38o8KYlGJqwXRY?=
 =?us-ascii?Q?CzoKyuIQZVkkIafD/g6OzifgNDZBsY46rHEXQDJwE1Glg6ciLCPIV+oClETN?=
 =?us-ascii?Q?hxdRQ4jLstN6s/FCuN+2HgSR/C7fvB0lkFkWP6ogZlzb1Vjn4wBqtvWLycuL?=
 =?us-ascii?Q?M74ZJm0WkJYZRURVm+14fr8xVP3cMsBsLPLA1vsCtM9+OUDhJFuI+fjrxHQ7?=
 =?us-ascii?Q?5LXzutYN6v6jkQmZcMqd74zZyN1xVOpg9VQjprWEvPBblHyZOSGH7MmLpkgi?=
 =?us-ascii?Q?I3Hv+Odq2CUWGd3DoS4iXzf/6gGz17zP++X3sCVObGUoAnSCKke4wGJgWM89?=
 =?us-ascii?Q?uU7TjpazAbN0q0q4b0F0rQt2BOTpaI5GGI4BXcl9/lFyGJXPGPlMUzK97/P+?=
 =?us-ascii?Q?q8mF8jo8QKnHle8/nFc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 16:43:38.2962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0a79c0-c838-4efa-251e-08de0689d4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Base commit: (qemu uptream) eb7abb4a719f

Sairaj Kodilkar (2):
  hw/i386/amd_iommu: Fix handling device on buses != 0
  hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup

 hw/i386/amd_iommu.c | 166 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |   7 +-
 2 files changed, 106 insertions(+), 67 deletions(-)

-- 
2.34.1


