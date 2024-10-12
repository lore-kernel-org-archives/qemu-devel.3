Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815FDD1A431
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 04:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szU4V-0000IO-1V; Sat, 12 Oct 2024 00:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PratikRajesh.Sampat@amd.com>)
 id 1szQbf-0006Zx-Bw; Fri, 11 Oct 2024 21:07:43 -0400
Received: from mail-dm6nam04on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2409::613]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PratikRajesh.Sampat@amd.com>)
 id 1szQbc-0004N8-Tm; Fri, 11 Oct 2024 21:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaQbAGCNvHPPdkIFvyY08iCNc23e1Ye+nHjrb65xLupk2J/AvbEdhZD/p6sNK/MfQ7cnzeji9apq58ucBjmCWsnTte6FVfD3ENQNXvN3QVOZOOowFW6534M1blfOWryxuWuHi0wu2fOgUtoHFIntti2xIkzHxtvT4xJVAYOpbRVbTMn8C5uaXndoNM8U55SZauRMHAvjdMeijTPNITDwfyIs6QbhSIfzkxoUZuT8Y8AkDyMn4fxoad1B4rS6KM6O6HMRiSYnURoDHr+goEiWSMmB/dZAFTdwJNW1oPmDxk8fjiRG6EfDRC+JlDz3Pg97frggX7CJkKxMeCx0O59d6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSWC5+Xn2zaxfGh3wr+I+HG1OPBux4tsM3cpI/d0jdA=;
 b=Tv0EkjtKgNeyE3Pd07/RwUwfp9JUY9+R2bOJr7Re5K2wPnsl0AFiroU5SGp0juX2lyRLAd4xyIUk6ZSG6dF6nzrp6FbvwJaDlcFZsh59acovWqwq3UeStUzKpKyBTsV4WQNCmFp2qJwkGJY7V+tP9ta78j9r81xOeQbiiGXicQHaV0bAAOCkk/AkmXwFMZZNyOkn+fyZ8z/Tv1+6Ptsm16a4wGH329+Q2s4Z2LJmkriir11Uh1GKrVJ270sPdTZQN/ICU171j6suaFDi7fzqlh4aLFpFVurszolNNwTTJ1kWNTgAE0bkxuG8IiK1osCPSAYVKTmxD880Ui9nA3QdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSWC5+Xn2zaxfGh3wr+I+HG1OPBux4tsM3cpI/d0jdA=;
 b=RDTZuyv893ojH7WTPx6F7vOmQBuSPI2agHwhbAkV31yJS5pBdPZnk+0qJv2y7Z7Q9XnSTmzHWe6QCTB5EVbD/6inETwZ6mHk8msqfTUuXej7ns0patjGtPuFAZi0vORMUUL/eCnVAK0hNEcoC7soIXaEtJpf/n2fNJJbesst54s=
Received: from SN6PR01CA0022.prod.exchangelabs.com (2603:10b6:805:b6::35) by
 LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Sat, 12 Oct
 2024 01:07:33 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::c7) by SN6PR01CA0022.outlook.office365.com
 (2603:10b6:805:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Sat, 12 Oct 2024 01:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 01:07:32 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 20:07:30 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-trivial@nongnu.org>
Subject: [PATCH] pc-bios: Add amd-sev-es to edk2 json
Date: Fri, 11 Oct 2024 20:07:24 -0500
Message-ID: <20241012010724.107510-1-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b26fb0-45e7-47d7-d2ef-08dcea5a405b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PzKjJz1PopJLVWuSpsLPUz7uzdqqFUjuq6njjU53HRdBhiSq1ifmLUaFQSHw?=
 =?us-ascii?Q?ZEe/iuTE5l/Ffb7SjPYpNCEjWw4SOKPhdmKzNGcb8w5K0UBipbICjJ2J35d4?=
 =?us-ascii?Q?gGAjPd8ggo3v0CpkR+cpd08CG4A2c1my62y80Pz6MxhiiwLbkx65MFeALWN7?=
 =?us-ascii?Q?bK5UOb0c9oFdM1Le1rUPlsHeT373Z87+sO2S7/JGvjKMbOjlyisHjjaYEtfw?=
 =?us-ascii?Q?8xk/Uqh4ZO5zEu4CAD/uyCB+I0FBu1D7+5A7cAxOXWb7SyXnhjzFuhjEbsK0?=
 =?us-ascii?Q?AEQ6DfW+Vx6xT6QSlUL/p+QAyS9FD7H/dOx130+CB88XmjV8oogD/3+pd+sb?=
 =?us-ascii?Q?81BqYi3WPlO+fe8ac6AUP8Gkr3//ysiroQomZrMhb5Pwn9Mz7Sb21lC6IPnN?=
 =?us-ascii?Q?N/z3AuEGHqyRBUkvGETVMTDKslMKoA0DIftIn5wwAplLpk5dRKi8L5Bc5O1o?=
 =?us-ascii?Q?FPtl3I7SpkA49K1i6UxP1WEQS0Y4CJj6FkZM0XNXfRy1WcaxrgMffh71E29Y?=
 =?us-ascii?Q?b49XVWH4y9fifp5DC91p16NV7RqOyXfJmTkp0dKrd3G/L24PieALAP0kJwDr?=
 =?us-ascii?Q?blIrTyBYyuxGrKl0uqYaYB9U9j4t4NdvxRC6paddCoNTnXwR0CnoEDL09Ejp?=
 =?us-ascii?Q?n3jK3Uam/OT+yssj6rJsGQ7+V09LegqyC46v8xgeAliV7EsaXojtpiWQ/jWc?=
 =?us-ascii?Q?tyK+uiVST2XoyBqTS/jvr72d5fr4V/PVSMgVsNohXVANLy0yauq0QNB0m8kX?=
 =?us-ascii?Q?qltzlonSuVPHphrHiZQf8wFzUrjjWt4+SfS4Dn2srxwIElbduLtTI+qJJ4vJ?=
 =?us-ascii?Q?gSI3b7xnqH4Et467g3wN7pVqm7imHYgnazI7m8kiohiO38i+LiRLZVNG7c5L?=
 =?us-ascii?Q?KGDsTozbSDAfkJTngk+KJ2sGLgv0JH8bDrMQKxb8Av1ZQZL0BklTm+lxrXVf?=
 =?us-ascii?Q?5mIr0B1oCEr0B0afoX3lHbsQdRlMCI3bdenwLv3HQYh0Vzrc21Lvjy/chxrL?=
 =?us-ascii?Q?z7qs6Y+cJq3MJl6YGw/yn78kJgwvqy596X/JdzNIrdgBpyhhtFnM/tdiSXcu?=
 =?us-ascii?Q?zHNeSTlRMtgYRcT3skoDAX2zvE66d7rZzzah62TU65ojX2N7Asnw6JilXuNX?=
 =?us-ascii?Q?E42N4vMkkv8XpfDl4MuvZlWfuq+R0k6JO8HJ+xSKD0IPELf4EDk1rPWs5jqq?=
 =?us-ascii?Q?64WrmSu+GULJprbJNJsCv+8UllF2K0dNvgujp7kKkknJ7FVRJsERgq7J9e66?=
 =?us-ascii?Q?p0wa+zaYoWV6H5P5wwtHesSFaRecRRsgc1hP2OiYusNi7DUH5FWIsppTfZwt?=
 =?us-ascii?Q?ipe6DG4tzspCr8RMBdwfER1+sj24IB+eV9LX0TTIMaJbDflg1g9EYH4Encv8?=
 =?us-ascii?Q?em/ix64ZSSzGIs9hRwi/FIvUe9PT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 01:07:32.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b26fb0-45e7-47d7-d2ef-08dcea5a405b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
Received-SPF: permerror client-ip=2a01:111:f403:2409::613;
 envelope-from=PratikRajesh.Sampat@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 12 Oct 2024 00:49:40 -0400
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

With the default BIOS being compatible with amd-sev-es add the feature
to the json to indicate it's support

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 pc-bios/descriptors/60-edk2-x86_64.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/descriptors/60-edk2-x86_64.json b/pc-bios/descriptors/60-edk2-x86_64.json
index 968cb65cf9..4599c63f14 100644
--- a/pc-bios/descriptors/60-edk2-x86_64.json
+++ b/pc-bios/descriptors/60-edk2-x86_64.json
@@ -26,6 +26,7 @@
     "features": [
         "acpi-s3",
         "amd-sev",
+        "amd-sev-es",
         "verbose-dynamic"
     ],
     "tags": [
-- 
2.34.1


