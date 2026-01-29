Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73528D358F7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPGb-0002nn-TQ; Thu, 29 Jan 2026 05:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPGZ-0002mD-KK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:28:47 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPGX-0000aV-7q
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:28:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTlZJ6Q3g27sk51hddxk4E1YCNar117RKCbRK0/Zjr9QaUKwv7vd9YVF1DpsDf4ph1B2PgXp2YKeUA96xB0ONLnYS2OF0L5mgiI/fYdlLMmTJxSt18y3+qy1A0QtNBu0sGghyNEcfBYfL+aqddMPHmkXSBJSsYiuJKeZPjIFYpxPIYgTYoYHBHJJZjj6CHh1eEFGKVTzYrAnBT4rBHRm5rC5XKR7NPWP1BOpABfs130/PXpqiHlyvIxZktiTKDrKnSTAx4pn4evBkDub4etT30sMhGGC7mX//CStDv4My1HxPdMR64eKi4vDHN+hnwMfVsL49SUSJKpDOX06mWD1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqGXrXMtuMu+nqECZu3qGgTQqRibTWZNUozSZa1fbXI=;
 b=IdZ/P4Vxgr+B6SoxxY/MxJdzjNSXRwCExo2i1QimqAKnd3cOT/xKq4CXFr9S4x1ye5eI7JCwXGk5HpNZF4EY+kP1ET7UXgSUvdTSa1chWCITY5Au2tiIBWUQ7dMXe5jji8qUYiEwXtr3xr3E70qdx4mWoVNJqoMIUv0SJoxY4ScmdTyZFPDDceQ1hvKAu18rkV28KgobJuXdImxuQwYpfX28gBuVmxNluBR5ucoOhu/AGSxWx00fQZt8o8qeryy92wl7A9iNybO8ZLjjM+TEpVVL7fXiFll7p5vBDyLbQ0hjNAi2qZ7LiMBQaKVkCPJHtBpmvbgl3N7eHauvXXpawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqGXrXMtuMu+nqECZu3qGgTQqRibTWZNUozSZa1fbXI=;
 b=zOH6UY0oA6mVEZrC5LSSYp1ZVVeWk0VfpShSX4vs0LS3Sn22SeNX9dWnKJpym58zXqyMaWPCuQgpy818H+LiXe54Ik+UCPBnfDBPm6X88FWiPAA91HqI+e+NteqdE3cgJ+Mb+B09ysRqCJMCbwG+GCXvSPpY3mRXGtuQzp33o3c=
Received: from PH7P220CA0167.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::9)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 10:28:37 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::cd) by PH7P220CA0167.outlook.office365.com
 (2603:10b6:510:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 10:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:28:36 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 04:28:33 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH 0/3] amd_iommu: Support Generation of IOMMU XT interrupts
Date: Thu, 29 Jan 2026 15:58:11 +0530
Message-ID: <20260129102814.4488-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6235f8-b48e-4dd7-87a1-08de5f212996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OJILncL0Na7E7PJKiDQ5lx1Kj7FtbhmoMMgtZe16Hl39MbGlkpbgrLCnoi8v?=
 =?us-ascii?Q?jzypSMdsXu6AArOJyNTgaCyq0eKkFlp456KM2cER95ictO44BuU6AUJjQ1fE?=
 =?us-ascii?Q?1GT+3dfRj4NqIaY8epivCvV8oMz2+5fNMjaOYyrr5Q/Wa/anOzWiF0NZqnSp?=
 =?us-ascii?Q?hF76RQUHZfSy6Y9RhX7XGOLvA3t825hJEphbUPycIdEFlgSxbeggvF6gpeMv?=
 =?us-ascii?Q?nmHG4ZBfLvGXWjGFbfhHjkM7Q91F/ANIEwqf5mcHdSmjht+1rxCUplK+wrlc?=
 =?us-ascii?Q?eE+EwalovhQGq/vlKi9ze3Qr+mb2L2G2O4JRTKzUeAlRmHsrztXZ82cUXc1V?=
 =?us-ascii?Q?HZUTp2jqy46yurlXudWbU0llVjtUoCQqXgl4gAXdQfOcmdAiokIfsi6IB6lG?=
 =?us-ascii?Q?+YOpbDeKUr0lYAK/E14Uyvqrn7OkkrKrsGOvfq84e+ulpFqEKa6rMmf2y9Aw?=
 =?us-ascii?Q?s7K975HsaOiAKMAu4ZMLjCqscIhGfEYA5NYNf0VkScfG/trjvh+13L6KJVPK?=
 =?us-ascii?Q?K0BoPRVqaBHz0tv1EZZfRTzoi6i90dAaBtfuYiCgQFy/8OIBgGq637THN1L9?=
 =?us-ascii?Q?k6CRfI1rvN/eIbyGHJV8DNIpNS+3KY60sJ9sNaa0Grzkf8T80RzMoIUDCQjC?=
 =?us-ascii?Q?nEsKKlh15O5zTxAHzaB5l5LyQicRovT4inm9t7QAwXGyiqq5qJ1f+INBuSD7?=
 =?us-ascii?Q?05nc/2DR+sD9E8J3T5/220yMZDC0xvI+0rXv/+X90BS05TbzA8LJnrZJjEfy?=
 =?us-ascii?Q?MNqUmrTIscRZUvmZMhIM9MG28S7h3zk128ITdTVNrRvl0c2V5QkLo+H/EoUt?=
 =?us-ascii?Q?BwK3iXl7IkbMWb1BclkyWhkh5Vy8YQOr8EXtHtHF9QT0akK3xmKiluIDOdkZ?=
 =?us-ascii?Q?exEPCsDC6sMor3xNv4cmO+LJZb4V5c1yBG/XSc0m65O49r4p6W08r2XMvxLr?=
 =?us-ascii?Q?MDFi/WL5nQgUuk7OxU7k3xLsvxQeOlTHdZmfraq6CAqrlFaQqP5M3uuUqA/Z?=
 =?us-ascii?Q?XBYJelRGh7tRkCiaEaK3Im7v6NlwIRCRNmF/dw23TP2C7viwD4c/tDKKUECw?=
 =?us-ascii?Q?BzfPvNv/mH5PzNugZ+yEZAaoIkMk1KKV3WR74u+PnkPwboQapKyCKEVoacuv?=
 =?us-ascii?Q?rwGuawPc1DyKtQ4jaNKujUtMJM7Rg/lYL40LOTvp6J3fMtNmnL+1l34r/L9A?=
 =?us-ascii?Q?Lxw5JDLxwgkureX+LHNRQJlzh/7MglFA6GZWxMbCcpMunnK2aKp6VuZvByMz?=
 =?us-ascii?Q?Xx4g86U8bns8qCord18boxGRzJmJsuZRlWO62ztj49lrDxQcnLq/B5UwILFb?=
 =?us-ascii?Q?Gc1MSUduWigJUs20lZXy9fMuyNfUy88+5v6Hn+b6iMa3nr+b6vmtqXUuZdV2?=
 =?us-ascii?Q?6dzPNUn4GyuBNZ5TiNqs85xyeMU7q1PIU+vq6ED4p4d49ps/4HhBS+00wdjC?=
 =?us-ascii?Q?ohgJ+pGl6VUWv8kxn1nPV4cDHMBL2c4MkTkZvc69AxI0uD98LXYbxj+L5vIo?=
 =?us-ascii?Q?W3xALlJ5hlzFlKWdfJtxt18XRNYZn0NfD4H/tQ/m9n2OHAFYRTwuKAD133dV?=
 =?us-ascii?Q?yofqA6nK6ZsTfUUglER6Sq12qudc3PhUk8Mdj0nteCBoqaFMYsQhxmvsFHef?=
 =?us-ascii?Q?3EcUcH69LbtbG/4EOX7qgEQbQQ00VkNaeG2pOd6vEUHWsxUgLVcFP76V4Z9I?=
 =?us-ascii?Q?RpvVsqfUnp5l2B5IUouWQZeZP4A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:28:36.9066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6235f8-b48e-4dd7-87a1-08de5f212996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts when guest
has enabled xt support through control register. The guest programs these
registers with appropriate vector and destination ID instead of writing to PCI
MSI capability.

Until now enabling the xt support through command line "xtsup=on" provided
support for 128 bit IRTE. But it has few limitations:

1. It does not consider if guest has actually enabled xt support through MMIO
   control register (0x18). This may cause problems for the guests which do
   not enable this support.
2. The vIOMMU is not capable of generating interrupts using vector and
   destinatio ID in IOMMU x2APIC Control Registers (not supporting event log
   interrupts).

To overcome above limitations, this patch series introduces new internal flag 
"intcapxten" which is set when guest writes "1" to MMIO control register (0x18)
bit 51 (IntCapXTEn) and adds support to generate event log interrupt using
vector and 32 bit destination ID in XT MMIO register 0x170.
-------------------------------------------------------------------------------

Changes since v1:
https://lore.kernel.org/qemu-devel/20251118082403.3455-1-sarunkod@amd.com/t/#m67401571075c42c26cc2560c94c1fc83836c9b20

Patch 1: Return string literals directly instead of copying [AJ]
Patch 2: 
    - Update commit message [AJ]
    - Introduce new subsection for migration compatibility [AJ]
    - Update comment [AJ]
Patch 3: Use ga_enabled flag while setting xten flag [AJ]


-------------------------------------------------------------------------------

The patches are based on top of upstream qemu master (a524ba4ae14)

-------------------------------------------------------------------------------

Sairaj Kodilkar (3):
  amd_iommu: Use switch case to determine mmio register name
  amd_iommu: Turn on XT support only when guest has enabled it
  amd_iommu: Generate XT interrupts when xt support is enabled

 hw/i386/amd_iommu.c  | 129 ++++++++++++++++++++++++++++---------------
 hw/i386/amd_iommu.h  |  21 ++++++-
 hw/i386/trace-events |   1 +
 3 files changed, 104 insertions(+), 47 deletions(-)

-- 
2.34.1


