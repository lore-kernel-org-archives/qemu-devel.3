Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2B3C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4mJ-0005u1-U8; Fri, 28 Feb 2025 13:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4mB-0005ow-Lp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:07:59 -0500
Received: from mail-dm6nam12on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4m9-0002TP-Mp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:07:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaVXm7e40vJc35Di5x8WGrBxu9gisEU+WgOCoHbze3FihHRESFaRKrlmYLZOovZQLJmzCAeMr2VJuecMysHpvQV31yA4TGX8uus5VL1+wNavivlKXj8g2SI7RT7oipBrlqWnYU8H3hlRCAk8GPtu8VSLCECuTEugr2fh8FxvZXRN8Rq6Ia7IHKCEpPvLHpbSzj1Yt29fjN0najrqSiG0eJmVDuDiOrxFsXERaXFv64qbh3tNYGn/Z92PmV2r3ctse9WIeSGobd1dOnthoA5JTJPYuwJZPpv0KEY0n0aMsEFRr+h0ctxNIQGQpXjLVDDwqte6jh8MU8fEe/bMzuREog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUOALKLUD8axTq0POgFoFfDRxoMGmZUQID+WE5kjQcg=;
 b=cjzJ34FZ3ecQMCYyTWdGJACdmebpWM6clvlJC0EtHb1ySMeYete9ZtmwCT1RAaSOT0ZijuqPRpB6rVHbteh/vmLB+Gtj8p7oH3tMyFhVquSHtY1JinAmq8YtYweM0JPBOnKKJ/a0x87YKfxnW7CuYpvv5bUtSiX1vLh8LdwifJPiN+rD4S9Lm2tKHMENdnL3MQfix7THR0jMFhrzk3wdZBBsXz1HnuB+HGeM78In5nMME0Utx2i6CIlW300bc6057F2kqU3CANOIKGMtXLXIXdQkmu7/GkBWckkLY7ZB12B4oTgbf1PnI5FK0l7SjAB5YEZbUiXHK7A9zA+BnAI8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUOALKLUD8axTq0POgFoFfDRxoMGmZUQID+WE5kjQcg=;
 b=N8FgZjBfZkAtntCYGV0a1udLYIZBpRq2PRQpiq0jsJ6Banr0a4Mk3vmi/bJX2PIFNIn3ohv+L5AzfWu5G6rQ/BRLQUYtNfbwXy+9Tq4aAKdvDbAqvO4j4EJ5W/OOaNSf1WIp2+RXLe0LXjYei3z46sDFRW/fUarww13RG3mC+aw=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 18:07:47 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::ee) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.9 via Frontend Transport; Fri,
 28 Feb 2025 18:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:07:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:07:43 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v6 4/6] target/i386: Add feature that indicates WRMSR to BASE
 reg is non-serializing
Date: Fri, 28 Feb 2025 12:07:04 -0600
Message-ID: <b55375fa129372b6e10cb919b6e3e6548723d9f6.1740766026.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740766026.git.babu.moger@amd.com>
References: <cover.1740766026.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 44748ea4-78c1-43f2-77a3-08dd5822ce8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MCJ6HEbyx3DGI74i8SJzG/x5lMca4Vqn1HlwY3ufQm3rgZBOT7e5Ap5lP8oC?=
 =?us-ascii?Q?3PG/Mr+ARvBTILCB6NqTeoFqa6BLxvZo/lPAHCb1M4jB6lZhf7g28pDtPKdT?=
 =?us-ascii?Q?pOQGLm0FmE8vxEtibRkUYKRnaQqz3Rciu4bpQ+oOaSAartJ/XJY0v/3ktf5K?=
 =?us-ascii?Q?E0mcqRpqE1idqQ5egCY0d36Tj/qd4oVlpD3Q7sZypYDyKeyJpixyURblGJhg?=
 =?us-ascii?Q?lKiTfkbrSIexZglUcwMLuGKH1QlXaGTbYF2bZZTEAVLDgWFJNk47TnIV+be1?=
 =?us-ascii?Q?JncKHKmtWzLYB74MmdN+08BvLM9UmhpUr+atJBF09yzVwHtedc73XvZsSZw8?=
 =?us-ascii?Q?8AhtIB6I4Wzax4hZCIrf9sxjUMDydTLQHcG18QI+omDIg0F3yTvkbQcDswyC?=
 =?us-ascii?Q?b+idmy32dYwtbc3W0v2l8faLzj7WSuxj9dtXjI+pX4V6KFDtjlwTViV8emGJ?=
 =?us-ascii?Q?XCjS4U3C46OjmKjfK0N/Sqdi1Jgsof3xOlQLiUohE6pdkrkAdZ+fC2qQRgEK?=
 =?us-ascii?Q?9Ov6SYpytqnGF5muqWOafZqlbZh6bPivKDYkrFI5sIDrs8dy9Z2r64QcLVHn?=
 =?us-ascii?Q?9/iT0N6S0ouFCRHqcKvDAuyIcuJGp7lFGFkUDDJT8aplSZQoiv7E+glIxaeL?=
 =?us-ascii?Q?O8yAoJR0rOXsn7aZn7LEMdagCld3wyNsEiwPz1YGjGWy5ofwxMyGBo7JAfA/?=
 =?us-ascii?Q?h32PmSRHG1B/yaG1Td4PXRO1GamFHgJIB99CLeg1OrQd/JYqm69oPTSTY3H2?=
 =?us-ascii?Q?UFlFxuO6q0xRf7cqZ6yuDsEnYQdxonHkZpFBdftGElxhbnSX/BcIvwcOyRH4?=
 =?us-ascii?Q?OYcS47uag2r5tGRyELqBUya7cWv8hGZMIOJ/VWNWZzblI6159i97qBx4E8kZ?=
 =?us-ascii?Q?KjOfXdDvgg8okMpDlUi3FvyuPnWYBj4re71G4YUz2I4mVhe4bzo1SYcPz9fX?=
 =?us-ascii?Q?WIQ4lEsGtc0M1PCusslHar78L2uv9qKWQ67Z3qYyWweJ3cHLdghpaSvt63qU?=
 =?us-ascii?Q?70aK1bzMt4v3DwTknUaIRmUiD98WADq4TuJrFgHcZUDyw+gkDdl6nxt3Xsol?=
 =?us-ascii?Q?RGJOkGdfXTFWp/5pzl0jJ0zES0CBari5r4AiOsWfs1zRs3Ne4otqQLY8nwqY?=
 =?us-ascii?Q?sgJ2YiYqmvpH2bcm3ZvXJJPMxX8xX0QpgaJW3f8bZN3fP7e1mvxZqnyDJNEN?=
 =?us-ascii?Q?rh4/vTgQfPtKsHHA1IUI2EHoAoLAbmaUbfALjnDDqTg6yGN1lyvNziAqYebp?=
 =?us-ascii?Q?Ehpcsrz1Z8/BV7hSnWfOwI1KfAXmxqu+y0+nb70/59bc5e/bTuKn8s25SFH6?=
 =?us-ascii?Q?FQqYDhIJEsGFzCO7YcdBwO0bW5NxdQgvfiUxPVhAvGRi++PITEg0R+ofM37I?=
 =?us-ascii?Q?5JYN1ma733rIklz3gcV1hpE3qMy4i5+hAAsVDxq0swSUazjLzD1mOihYWcM2?=
 =?us-ascii?Q?7uW3KL8uaPQs20JW88aqpCnrvwFO7shs2Q2ohCrC5BA0uM1TSPFh5uNfm2Zn?=
 =?us-ascii?Q?KD3ITZPldgpoXyg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:07:47.2360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44748ea4-78c1-43f2-77a3-08dd5822ce8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
Received-SPF: permerror client-ip=2a01:111:f403:2417::60a;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add the CPUID bit indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
MSR_KERNEL_GS_BASE is non-serializing.

CPUID_Fn80000021_EAX
Bit    Feature description
1      FsGsKernelGsBaseNonSerializing.
       WRMSR to FS_BASE, GS_BASE and KernelGSbase are non-serializing.

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a5427620d0..7a5c5da0f1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1234,7 +1234,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0021_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "no-nested-data-bp", NULL, "lfence-always-serializing", NULL,
+            "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
             NULL, NULL, "null-sel-clr-base", NULL,
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..968b4fd99b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1074,6 +1074,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* Processor ignores nested data breakpoints */
 #define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
+/* WRMSR to FS_BASE, GS_BASE, or KERNEL_GS_BASE is non-serializing */
+#define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
 /* Null Selector Clears Base */
-- 
2.34.1


