Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D70CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLH5g-0000uJ-85; Tue, 18 Nov 2025 03:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH5e-0000u5-Su
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:29:30 -0500
Received: from mail-centralusazon11010063.outbound.protection.outlook.com
 ([52.101.61.63] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH5b-0007YV-Ud
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:29:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smEEUxUpF4WZSDCd8ucX/0kcD3khmLyVRTsfF9vFGaBLG7B94if63KdZbrriRLPUK7Xg9ZG9S2QjgOOHHBNUXvpnswgWT5J0fkU8hPQ5olEZDUzZKcwYAMhkdDzwlz5x71+kXWNwPix3DqO61KojBWvI1HnOwZogqUzh2NJ0SdwEBQ7nKl2Bt31/2fyjpRdU3VCDa/jS8xFVSDlhFfYFZci4gt87x5uBQ2kjrC0c+rx+6Wy+JDKLj4DCnaM+tUUx9kg6TZ3AnycjhHBDXUxflFB+OH65SKx9QbtAYoA0cyLP3yMEfa4O9Q6yF8RJ/LanQeulL/E4vabcLK+VM9qX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o4rnuSWLbBF/FtDCWWDJ92eIPLMRJtaM+fpkJzSkzg=;
 b=wkPRflaHL6eIfKT7CN8R28URVZmUyASsvb2FLYfuFUY52qfOwgyxbqEf/dFpgGHxLPrFAXlrhorUvWObNF5XCeC6kz2W7yySwa3wvR13ViccfGEcBgdcH7aKFG68gumtncQA9KFmxfa1ORliLpxA76TLnobJmrrjv+XFnydtz1tqSXKsLYY4QAFvcMm0vIGsCRmwCVoy0svDZkMToZ0BOrglTP9VdyRFdadN2opIQ32WCp9i6RVfodTUYESeKGxpuV9eQUIPlrBj0WJl0d5xvi5/iEBnR1LA2rEJ91tiRkQkCNdL0+tzlMr1Cz5aH8UHyC/HId/SPU1NWuOdqUk1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o4rnuSWLbBF/FtDCWWDJ92eIPLMRJtaM+fpkJzSkzg=;
 b=jIQ973v8nAU5jdBHHJsOfY2Sh0yS8LmmOLh24vof7SB8JfELH1FnAD4WG9Ep9Z2FV11jlVqDbMezP0yMM9H/y54r3djzeJQmjTgav3sodKcSV/iaSAG9akq50HKI6DK7eieukb4Dc7gOiDCpdiEGDC0V1mW1MjdeAFgqeVST+tc=
Received: from CY5PR15CA0223.namprd15.prod.outlook.com (2603:10b6:930:88::9)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 08:24:20 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::4f) by CY5PR15CA0223.outlook.office365.com
 (2603:10b6:930:88::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 08:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:24:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 00:24:17 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 0/3] amd_iommu: Support Generation of IOMMU XT interrupts
Date: Tue, 18 Nov 2025 13:54:00 +0530
Message-ID: <20251118082403.3455-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 47098f1c-95cf-460b-bf62-08de267bdf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+UOxz/a+nEhpvkSRJrWBmUPgbBn8OtegtaArraX+2CqrYJXu5e+F0n81XKRT?=
 =?us-ascii?Q?aSRohY6Sv8rlJ/YfAOuxrYyItitxMOJgtzGM48lI56SvTEDZ9dItrffak+yQ?=
 =?us-ascii?Q?OSZxOUXklz56z/MwXAx2Cf+O8+NjcwIcImTbMIun+mMJDWGRFRzffdCfX1U8?=
 =?us-ascii?Q?vS/6dQJSx0qMTqwttmUvSPNHbv4ybDCx5hPrB8Pckg8jepeVMb0BS8N9wvfn?=
 =?us-ascii?Q?1/dCjKNs66Q7u+z5e968GFf+03VI+UdFyD94plwJsjZ5Jeodnr2g0T0vOm/E?=
 =?us-ascii?Q?ZPD7ATw7WuSL0cqPTHsawwo2d+XGhaN8limhfWnCemT4O/OeygUT9yJOTt3a?=
 =?us-ascii?Q?e+uzFMlO7hbCyDQLFCGD9q1kW3gdlZ6pkhvL3xheAS05Qa8aMkmrFZJFzo53?=
 =?us-ascii?Q?2Am6zybPA4LeCsRXCd/A+z7uuywQcmILZaizLQpG+ffvmmtgekMu9avYj7FB?=
 =?us-ascii?Q?k6PshFSzJtmYNnyv77jgABhYNjKUQC1VfQ22u1V3tse6OGyaAUf2Hds2JxqR?=
 =?us-ascii?Q?+M78um67nbVx83d+C6AzheNP5xjsDhTnjiDVIDZCwn0Iu1YRj8TSXtlDjPQw?=
 =?us-ascii?Q?ZHsT4SMBWmWbtIjtVBAlv0xj+t9AtLGGEKE5Q9TQWpXODJKZhs2sWwOYbL9z?=
 =?us-ascii?Q?9RwHxLQ8HInKwEQDHSXfepKYcZ37GoPRT9gm90C2FILVvRL0inU+fCvZc8Nw?=
 =?us-ascii?Q?iVVD+zVjStH3UWCl6gQIeihiGYibuTL0VrQ/y24bKk3FPQ3sUnsqkNrrfXdD?=
 =?us-ascii?Q?41M3iBNqVcOC3bFhT9wWXjpAB8S+KK2dBePEh3doLn72MJFF2AE051DZ9N8h?=
 =?us-ascii?Q?DfpEICbPatDuR2Y0t5cvLpQXghNHdkpGsRoxVliDKs0X3fA72s2eE/no93Ua?=
 =?us-ascii?Q?/ssXuMRis2uAmouW7unmM2px+i5UpwVnrRIlsGGCijj+mjtJ+D+gmihz3Tzw?=
 =?us-ascii?Q?xTW25nUeLsZElrOr8hanRmRTu+VGdOHukteUlne0s62NfkZt9+hodhFNB4Fd?=
 =?us-ascii?Q?axRzqXTP1VnbP0eapeKuirfZKDkDSGbIxUSmbBwQGlbPPYb3AHe8Je7VgJGb?=
 =?us-ascii?Q?ZMyONvCUd4reR+NvhS9Vdabpen1urTiEiFRJNTeUYIZSLNc8YEW45wRB+i47?=
 =?us-ascii?Q?m1lznb0oHhD4fhr2PgmEA3E4iyDy6YBRx9Qn/SO/lDozXmpvjG2DBw/gfJug?=
 =?us-ascii?Q?QHqek/ojnkrq/zo1ezBMmHNt67x4iYV3ALP7oD+g2uCuFThsoD1t+Mht9wxg?=
 =?us-ascii?Q?64zl7jV1F6UyA6+6eUFchfw0y/rH4Glh2NoR6F8Mlo17w9zK4JPS6ocCi/JM?=
 =?us-ascii?Q?nCOLhzvw1g0qnsRLx0eUlYbaLNEBaqKmGPEEb0fJOXR6/88YmWHv2h6KS9fY?=
 =?us-ascii?Q?uGjy0pYSkhF4be14i3/1sqYzsMa6l5I7bRhpCqBgJGCG5UwBqhmEkvOuugj2?=
 =?us-ascii?Q?je7kHrPYphBF7KMoHOepjI9DFA3rmik4wz08XVQ63moFPOmlsShpZLziqzE+?=
 =?us-ascii?Q?WpJEupP1fjy+1h3iTRRZn1KnJ7JGtYpkDsYwd3n9H+ANeMwST9JXzd41WUl9?=
 =?us-ascii?Q?zFkmaB2wW7rvor9PXHI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:24:20.0640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47098f1c-95cf-460b-bf62-08de267bdf3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713
Received-SPF: permerror client-ip=52.101.61.63;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The patches are based on top of upstream qemu master (e88510fcdc13)

-------------------------------------------------------------------------------

Sairaj Kodilkar (3):
  amd_iommu: Use switch case to determine mmio register name
  amd_iommu: Turn on XT support only when guest has enabled it
  amd_iommu: Generate XT interrupts when xt support is enabled

 hw/i386/amd_iommu.c  | 130 ++++++++++++++++++++++++++++---------------
 hw/i386/amd_iommu.h  |   7 ++-
 hw/i386/trace-events |   1 +
 3 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.34.1


