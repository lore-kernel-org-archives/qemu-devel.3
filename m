Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57830C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrYh-0007sJ-Ay; Wed, 20 Mar 2024 04:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrYf-0007rr-MI
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:44:25 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrYb-0007xv-U5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CengPR3DbByT0r33AT8ribI9wVhrOtyyp3i4a3t6xJeRKU0TEcmaT/e2rDk8Iv64Rt7E9GqOyQ6cW964ivTfE9M3yzHNBjMRzbyqDQwtV6rBzRWyDIfdEkZwqvXOoZG35Py/2QjQHUKusNrrv8oRejslCTLj3ipqC7xveasYw48ECDr0Ltj2FDmFrBZHESDWebGRPlQM/FlP90m5K/Ao35BPEufefHwymK6mvt41/vwsaqAKaCHiGrmx6Do0nt/T5AR+bBLVbpBeZPspVtlKtHGKa7DZlgCE37CyizQ2MNU0l+05SI8dNGIAGQ8JKYyUH/mzfKxKfzMUE3ni8woNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HILu8zKv5gIRtw1eQPy3a+lxRUBPKHDNxM2VhGKvB2s=;
 b=cp/u9IDO38bvo2aThGmUg3vayXnEkw+4mlRFaO1bPlc8bx0j399shAN55q+hQJWRT8MWNbivCmAOQmqLuwQAmv+mnw3vljvdGTJAL8Z6ow2Bv2tYjyUsjsWccb4CR7h9DRydnE+Z9IouMv5aM3io94tmjMgGVG1Ng6Q8q3MG9wup2+zOYhhLbj32sdvP4E5yUfRsuPZe5iwQG0liQfVzbGltOHvMNeqsOdJbgtyAsQ0Zi8Hs/MUg5WvlfJ2NEefMldBdMA3oCgx4AAvYa7BWcqj+HPoyXj3Vceghth7OVX9iluxeU650e7ZK1IHSqag+hzJ6RMBCzR4ntwRCHi6aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HILu8zKv5gIRtw1eQPy3a+lxRUBPKHDNxM2VhGKvB2s=;
 b=DMW+MTmsuqqW35N5i7HLoVcRdOpaCUiG2mEStvEsGF7ONtP4UkaJGVYUpTbAVHcSsGTz8+U2qzK1dcArhFSwpcior0+0MMolKMglhqkN31jTGGqb07f2neNA1jWnn8k/8eILZQUy+R6Q7k4tXL3iVVqo4ZDfAMQqTdBZjL7e1g4=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 08:44:18 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::d7) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:44:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:44:16 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH v3 17/49] pci-host/q35: Move PAM initialization above SMRAM
 initialization
Date: Wed, 20 Mar 2024 03:39:13 -0500
Message-ID: <20240320083945.991426-18-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d020731-a33f-4ebe-839d-08dc48b9edd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mulvIQFUeiAC5TB9TJ6UmuVGUBqGZFYpELY6CY5kiW/tkw6VHqqTEEPzZQE+2U1KN+n/+K6/7zT11XNpTdVxokk0gBOyva+OH0VhHGszRVAoWaFUpVCBTUJx5cPuaenZui8qV2pSVrIJL/c0phRH62K9wn45UIXkyLDp2v5W/nAvCZbstFSgGfEstCUk7YgL06hX/MztzQsDHzbA9lT8tAhe+EiM0YfXRMhP/S0UZltgNgNqKnR21aaxSDGfowmgBeh83QyF4pUP1ChEHjHee8hnaxZbaDLHf4Jwxf4MfXVARAdHAqU3cg9jTB/nxy3nhiuXBEE5HuVbJpvtotQGKEmgLs1pc3lcdkEpIA+9RVNKqENyZfZbMFFU2g45Cr76SPEGFZuMx8tcPObwwgtUNCqkFVycZolIu20Qw0eUk1Lda4S8zQTq1IajYvNKvZ1dzCI5uatwvPjLY7g/nYhTD1BIaeRDwuf0D9aTRH8sPJ3fMI4g30rtQRyUGbUpBhJtHZwyf9h8WgPjD68ZwDGNwh+6lxJZB7ZyGEQGJZI3XT2SviO6RE76gq7P5585NuyBxLFRA+fqG29HTWoVm576BIqb42Xs6fwIIjNGxyBUxGQRLEJz3xOhm8DfAjielvc2H30jRr03arAOCXc0RQHM/pDr+ZG/cT+Tq1vCJA1sM1aGnB0U2Fm2rXY1emh5aw6IxRJnHzZS8AqTnMCE8TVzZh/tpPSbc1URaQQWUaOylZebDsPnBWdgXExtM/qCyNV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:44:17.4482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d020731-a33f-4ebe-839d-08dc48b9edd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

In mch_realize(), process PAM initialization before SMRAM initialization so
that later patch can skill all the SMRAM related with a single check.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/pci-host/q35.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0d7d4e3f08..98d4a7c253 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -568,6 +568,16 @@ static void mch_realize(PCIDevice *d, Error **errp)
     /* setup pci memory mapping */
     pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
 
+    /* PAM */
+    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
+             mch->system_memory, mch->pci_address_space,
+             PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
+        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
+                 mch->system_memory, mch->pci_address_space,
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+    }
+
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
@@ -634,15 +644,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram));
-
-    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
-             mch->system_memory, mch->pci_address_space,
-             PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
-        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
-                 mch->system_memory, mch->pci_address_space,
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
-    }
 }
 
 uint64_t mch_mcfg_base(void)
-- 
2.25.1


