Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818FFF0180C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQXU-0005yO-WF; Fri, 06 Mar 2026 03:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vyQXR-0005y7-9k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:28:01 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vyQXP-00020I-Cf
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:28:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLUUgvrCLORTPjUo94JYkxAj45t6/4oGPDTo020HrTTnLNpsi1Rvfzm8MqnlweEHMk8CSEraKwtNoOqI6RpCspwa+GBTrts5A00BLUQ1Xrz/c7Bl+1CaedrUHIkUP8EZWvbs8xzY/3SA3vL+X3CNlBwD+v4nkU/olICkJq0iN0gH8sKBZlMiiecdvTua9krhNHsaG5yfbtm8czk1IkRDk5oSzXTygi8JPXLZXDoQFonO2AT9Cs0tO/2VIp6e37kGHVFBkjl3jjdg6eq8aOXq4CiKjoBFYwKlcrUygYHGyDcojjBNxZmuBrTXfV/ElEtwtpK6fDOU4ywJGnFzjcJmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwLLkMqIq94g8icpnayhcUJMPFZtie/O5S+mL0ew8to=;
 b=kMv8ygVqEfHsge1fz4pMBDXm3/bRwrRcjscJ2u6xRLZE3djV//5DzwieAdeI7aGmYCOVrkaNhZKCl7Q8CJiB3kG4U68N7SW32thKSSlGAKnDhqycpNlY470P+r5FJNeEV0b6Vk+7va3CBGJmYqhnhQHH7UAaOvBKhLBUta6cDLkX/bBvRe5ggFx8FNofFL/8pBCRS1RAwkxjhV50fp6R5mQs4fRQePeD0wtj9ubnMSAApPolWy+9VL5BBckKm13SSTUHkkY+tTJKR/2I4b4giRs4NfzaG5DL+v23/ZNhGdQdCJGxsD77VwN3A8IjAaSKsK/eGXp88vSGgEs7OdXsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwLLkMqIq94g8icpnayhcUJMPFZtie/O5S+mL0ew8to=;
 b=xyOTHdoyeDCq/x/vRlsFC7TksIaihkd8K3oZO737MYK1n0NnYQBWgceyrKTzdiLbDguVhol7uT0O1sZ5K4sD5RHYUy1g+8hlBISjgMJ+tR5wKVY08GXMrqyRiMsIeN0lT7gFHwGV2DM5s91ES+2LgIPjKHTUVYDjivyJwMwawdY=
Received: from SA9PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:20::19)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 08:27:52 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::2) by SA9PR03CA0014.outlook.office365.com
 (2603:10b6:806:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 08:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:27:51 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 02:27:48 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v7 0/1] numa: add 'memmap-type' option for memory type
 configuration
Date: Fri, 6 Mar 2026 16:27:34 +0800
Message-ID: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: db9133cf-0c04-4edf-003e-08de7b5a41cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: BaHs5V0j75j7rNZhI+bBGKS3AQC6ZyfF0pHaIWIeRqvUOzxzzN9rs7LQEc9upejH6mV5ahPWSjx87YDSCGnkLbvOwzqKwVssiejYni5fXLNmKqmlOEsS+8ee10+VyAkMpVDUnbgOcChfDCPlhXypwLxCDce31rWt26rmbSR1Oex4derE790oYkGmmja6VfR2B+l9ylhOBld5pfFe44/6BIL37Fx7Y6D77ccut72ZQPWizrcSCx6oXll5TIX6T0aLnRbpGcz/66EWxOXZGomFVW6ft/SjmgdL0gLivLLAWWC6/poW7t1UtH4dQLufGN6s0dNxRFUGuLTak8xJUiWxs96QVEVo3+LPznGGfIPV0C8mRDFggFjoT0QtdSPb7Ojt5EbIzedUkEWAXYKmaKiZdI0FyMhvF76+hfJ4UkqQT2xYUUDMvgMzX8AI+Kr2qLHkCD9KChlgA7QD7aioxP8lweSyzIOy7kzEkIoMO3FBGuDl77gH6cngjztnoIvzvCEeBKmBnwDB9bTbBJn6gzNmFcy82za08Gjqx3SpWpw69uvVZwX7G/nIpZM2JfL5qzTDAmywQBJEtzS/amCpA4tmNdv92O+Z+9piNVipiKGoiw9nLrhoNILJG9uG5+EPsuLKw+jPmNuDy9lqTO8RYyMhFGzXUJoIxEBWscekYzOijHcU0gy17iRlRADfIRcH6mXnnW/MSnY96aoy1FHLNfsTZxy4P27vPCv2RuuFIC19r4dukTqJbjpDhbpNtR++YEG8uJjRTt6ojtt+mhOB3GPZVMhie7kdfxpvBtdmOvkY6wBJZssQIfPDOoN/y4glzAro
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x61TY9f3eV5aOtR82vW0LdRsQzmDcQP0PI6UXAcqJnLQj72RyRF/Q//CrvYG40/pf0j0cKa4VjPJxSU+S/s2Q5KPvACOErUawdddHI90mT5Rdc0h7vYfpwtO5+oN2VcyLbtMdwcqbcgvnB44v+kwh078etnIu/ub9EDQypBHD/uoAal4G/JwpgYbEQDySF8GC3QKxFxfepI6wJymWp7w54PWLj5f2FbspOobep7Zgzo0b1IRixBl42r+hAcUDPo0o8x1oP50RTmA68KGOZS5vK+TuYQfclxqaKYbr/A1+nc8Sxc06v9KxzXokIHBwEWIfEKcPgW7sVVaB/tzzyNLDdTpnPUu7qcr6MlGfeHOo2Td1FF48+iWWZnjtaDZOgHW2iqj3JVLsSJ55HnQJS/02MiVfP5l+USyITTBxmaKa6nOAXi/qJcwWiNGiLP3jJMi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:27:51.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9133cf-0c04-4edf-003e-08de7b5a41cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi all,

This is v7 of the SPM (Specific Purpose Memory) patch. Thank you
David for the Acked-by, and Gregory for the Reviewed-by and for
catching the hardcoded address bug.

Changes in v7:
- Fixed pc_update_numa_memory_types() to use x86ms->above_4g_mem_start
  instead of hardcoded 0x100000000ULL (4 GiB). On AMD hosts with IOMMU,
  above_4g_mem_start is relocated to above 1 TB, so the hardcode would
  produce wrong guest physical addresses. (spotted by Gregory Price)

Changes in v6:
- Added validation: memmap-type now requires memdev to be specified,
  to avoid misconfiguration on memory-less NUMA nodes
- Simplified pc_update_numa_memory_types() by replacing switch/goto
  with a direct conditional expression
- Reserved memory nodes are now excluded from SRAT memory affinity
  entries, since E820 already marks them as reserved and SRAT should
  not report them as enabled memory affinity

Use case:
This feature allows marking NUMA node memory as Specific Purpose Memory
(SPM) or reserved in the E820 table. SPM serves as a hint to the guest
that this memory might be managed by device drivers based on guest policy

Example usage:
  -object memory-backend-ram,size=8G,id=m0
  -object memory-backend-memfd,size=8G,id=m1
  -numa node,nodeid=0,memdev=m0
  -numa node,nodeid=1,memdev=m1,memmap-type=spm

Supported memmap-type values:
  - normal:   Regular system RAM (E820 type 1, default)
  - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF), a hint
              that this memory might be managed by device drivers
  - reserved: Reserved memory (E820 type 2), not usable as RAM

Please review. Thanks!

Best regards,
Jerry Huang

fanhuang (1):
  numa: add 'memmap-type' option for memory type configuration

 hw/core/numa.c               | 24 ++++++++++++
 hw/i386/acpi-build.c         |  8 ++++
 hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
 hw/i386/e820_memory_layout.h | 12 +++---
 hw/i386/pc.c                 | 48 ++++++++++++++++++++++++
 include/system/numa.h        |  7 ++++
 qapi/machine.json            | 24 ++++++++++++
 qemu-options.hx              | 14 ++++++-
 8 files changed, 202 insertions(+), 7 deletions(-)

-- 
2.34.1


