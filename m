Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09AECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ1H-00072p-6M; Mon, 11 May 2026 08:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMQ1E-00072e-No
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:45:57 -0400
Received: from mail-eastusazon11011032.outbound.protection.outlook.com
 ([52.101.52.32] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMQ1C-0007LP-QK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:45:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixxTlgQooYUBgmVAwO4ecSlH3JojUguo7wCwAcPLud63wXUg/I8AmeNxJyJz9JWoB3YluHGOHE/Tw8ZZyTpyVx4gBoZXkYeojk4emtyPnAojpJlmrLtfKow9dcLYD1L5YivZF1M45Gw2GfGnvvdnnTFmliT4UWbHkqnshh6LUuxliQ0j3vXiNlWmd6/D15XLYxu65WOV3puKSqiZuJX5eXPiuMXjI97q8bioKq4KQ4UhpWOUNSzN4ccKr+nHiHUX2g1NOG5KeKZNvsndMpC1Qph67rnkM3npwnt29vn1T+2OVd9Z9tpDYEsDpQ7YSxyBT/taQvT4jnZ1vNHpVXNBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7by7l2cCrNVdVUtLm+h3VR4u52EU2184VhCKpgNJVc=;
 b=AQ+N0pNTscI0gOosG5Z7p+0FEWrlTN5zhpLEjTkb84856J6LLncvSf1hsBfeLH5wbdPdWrWh6O3rGyx5e4fZlcSqbBTP7k4ZOj6R3eY8yqbbiPrphW3fCL4Yb/nBSA+OQMQWpb5/AfGImtr0wl67Z8jpL0l8V1Hr95mns3CoPDPuMmnPM7EAmuPSlL1P8W1aHiIvvgv1QXw651GM7Xwccpm7DVuVgz/OnvgLGYLOzBgVbmL5LHXhcbXExM6nfSPnGJi2HUqc8tBI77xxKU6vbYavRUJWoJ2PxMAZCMyM8IUqwYwxcbqRS0ufOuulAAf/eIYsyh6HYEYHMYgDm29/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7by7l2cCrNVdVUtLm+h3VR4u52EU2184VhCKpgNJVc=;
 b=JOwhaZsU80Rl8NEYFu31nMcJwVmo88gZOu+Y/TfUxXtj0FALzlY2WNcmxOwXb5X3133udg4nWcyqVFl7qmEH5yqwxoI3As0mSt6RgueOovr4UzrLTM97A6Kw3adVtkHc48c0l4nN+V4WSOKFOvNJ+yY6hU9hwBZNJ/WH2P7zMdk=
Received: from SA1P222CA0143.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::19)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:40:41 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::d1) by SA1P222CA0143.outlook.office365.com
 (2603:10b6:806:3c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:40:41 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:40:37 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/8] acpi_build: Refactor and cleanup AMD IVRS build
Date: Mon, 11 May 2026 18:09:29 +0530
Message-ID: <20260511123937.32743-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: c6906dc7-382d-43a9-17bb-08deaf5a82f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|13003099007|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: L1WCIw9LZC3dbAETUBV2BOR4eN+UuMYOPXUflyhowAIhb/iWVgt54Wfk4LYqZX3fd8V2h7Pne/rkK4ZCsho+h5S7TGRSh1ijD/qy66tEcJlmDfe658MKfa6UnFriLm0sVkieHW9r0Ydx/7MZLb6VnnmLVSGHnMHlpTyTAEkuQMR+/U43aGfPUK/zQB6Wt3/whwKlYndeBi7862esIlmk4mCkw87jUIjktioTCKVtRkm32H+YiDgpt21HlILBXmPBPuDqGeYAF+tMGrhcTMk8WuBB+44b1DF9iG5/zYXj2WYjw+MAnXrCxhaNcT8a9AmXq5kJUjutaVMlpOexIZEotxaxybh51nPjCIpV8SIZsMjO2tWFeGLf3qBfJxDH7VnbIQbSCxcTGSARlhj5glWxkZhzv1ptElQfFg/Pj5YtvYeN1TM3YWpSaDJbbD7qEzbjk1tjTJgqAQFcJNaJE7z+HAJPb2LHrL+Rsn5kVPwhrmF1KBNP8xP6ntsjNoFmypmG2UJFNX7+2RvsSqXmAUgKzONzCRX2lXxLVSCJOD2KdXMMl2acerDsBvc1gK4ypdimOf/bR1JRGk9qbHOWlhjCDMqaTjUzii6M13MzjzgVGXgaZcnOKEqrxrGQzZE4ZxHjO5fAInU6QUxoNX6MrGWMeMW1N9iI0C6wnnMo1Cy1riorSN4/u/bkuO8AAkc7hx517gkzrX43gJzwHN5QXAZ4NuawIPXXJW+DLh1GGcZSIDItn2GGWaYQIZuNBdRuUqR0XpUNjkVJEeDG54alK4crowZLTpJJazLzlhg+jjmScXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(13003099007)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y2qlcu5Xrd2/Oe5I3qWBCycF8SXC1bCBXf5OrmdJCXJgu5TIsQWoj9yzsdnVNEdXo05mk9tVewFwshlUNHe4xrdrUXLZUPIVkhuWRH1lfdNIiczCjRi7/CS+EMg7CD/bkn6AccaY88c0yvqAb6rvnUDApioqKqWwt+83TANXXxiODI9vHqjQ8ERXSL0Fy7/pwTwFSNFD7J0GpW/DHTuDzm5VzP3q62nR+FJGBwst16lq6YCcB7cwQvBLkpHY/r9d2oxQiKCBialxgNrhlFT/BtlxFla8KiF0XD8Ik06OG6kMbsIAKbKPGnhsTkl2S3ExSgSY03GSXjJkI/wYBdsjJZSknLRPCmax8hFRn1mWDfUWE7nIbxY+b1mMsl+aj7gBigplbb4bRuY3CALcarqTcmZPJKOoDHwPNw8MovmWN62nzjO/B1CRxYPF6V8VNrre
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:40:41.1922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6906dc7-382d-43a9-17bb-08deaf5a82f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
Received-SPF: permerror client-ip=52.101.52.32; envelope-from=Sairaj.K@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series aims to improve redability and maintainibility of the the AMD IVRS
building by introducing macros and packed structs which represents IVRS, IVHDs
headers and IVHD device entries.

The goal is to land a maintainable baseline before adding AMD
hardware-accelerated vIOMMU support in QEMU, where we will require multiple
vIOMMUs attached to different pcie-pxb buses in order to serve set of
passthrough devices.

Please refer to AMD IOMMU spec [1] for more details about IVRS.
[1] https://docs.amd.com/api/khub/documents/GD6kOXjzWsek8QUbn_qMvg/content

Sairaj Kodilkar (8):
  tests/acpi: x86: Allow IVRS acpi table changes
  amd_iommu: update PA, GVA and VA size macros
  amd_iommu: Return empty efr for stub call
  acpi_build: Use IOMMU pci device to build IOMMU device ID
  acpi_build: Introduce necessary macros and structs for AMD IOMMU IVRS
  acpi_build: Build IVRS feature report using extended feature register
  acpi_build: Cleanup AMD IOMMU IVRS building
  tests/acpi: x86: update golden masters for IVRS

 hw/i386/acpi-build.c     | 191 +++++++++++++++++++--------------------
 hw/i386/acpi-build.h     |  93 ++++++++++++++++++-
 hw/i386/amd_iommu-stub.c |   2 +-
 hw/i386/amd_iommu.c      |   2 +-
 hw/i386/amd_iommu.h      |  12 ++-
 5 files changed, 195 insertions(+), 105 deletions(-)

-- 
2.34.1


