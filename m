Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE926C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrek-0003sY-A5; Wed, 20 Mar 2024 04:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmreh-0003Vx-Uk
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:50:39 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmref-00016B-45
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXABgHA+P+X71X5YjMzYJs39/qkfmDvhiSCWRkSJUf0+HAksZPSWyk30bwY4uvldNIRqW7RuPL+CS0Lvn2Obncw43GqgaZZ6BhL5bav2VoC+kIRpC0SLc/25gGjWoLxh2977uLqLYGM22wFoVy7HgR0cuu4H0gcF7E3fWkIBJZ7HVZqChjYyoqK2L/tyfYx96EMAPKAwTIFCdgPuZDm35QfCs/0BVUcJ0HEcHgx1zOaBxFWoGwa0frKhqE61sIAg0d4JWa2PxdIpIzoH5gjRreHzcUtyShRvTvH5PBrM6t1tft7nwPYiluZdFL5nVS7rE2axBVH8S5zH0rlR2t7DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SiwnHA5evDZT3y+GXVRjpBBKLhqfvbXO3fPYwyUjQU=;
 b=CDkDTtmqa73iV8ajp9IesoVhmLy7up+7PuaF4UCrY5wwD/LlFN8ZDq8orEonFfl+9q3JA8p67H6PFwdm2Iw38BC1uXTcUqAOisHuohadwhnYibDEhIu0CPw2uFbDiBCGe+0siW1dKY9zoYxJebNspRHwd+dNYzRLcrXB3+m3lp2JSfLYzMPq8InhtjlKCBFyeyCj2VRsIDLqk6mzxrhMFV22PXLfhPAlgbdzn9hYWW0zL7yJ/tc5X9Z/fSlWuGceyhWJJhDj7DoUkL+ncG/JNcHzhoPZ/HTtWu6sqNBpbknNAhXvkyVYTX59P6Kw/cf13Dki0bg0aJIR0hXixvak8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SiwnHA5evDZT3y+GXVRjpBBKLhqfvbXO3fPYwyUjQU=;
 b=Mm7281rMQRkXP1a5OLPRwynPgKhqRAK5WmpCOZmlQ7TH9CddPWtsr/4GprnVFC1qSMfJHK3k5WIvHYwNea7+RrK+gCUd70Pn1hriODCIlnd7qs3rJDj6arWQD5ntZT/xONrq1G5K8ExKyBlxbcpy4BgUlb7hZLp7DHDO4xptL2M=
Received: from BN9PR03CA0186.namprd03.prod.outlook.com (2603:10b6:408:f9::11)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:50:34 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::46) by BN9PR03CA0186.outlook.office365.com
 (2603:10b6:408:f9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:50:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:50:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 33/49] kvm: Make kvm_convert_memory() non-static
Date: Wed, 20 Mar 2024 03:39:29 -0500
Message-ID: <20240320083945.991426-34-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a2d5b7-f6ea-4ac9-2cee-08dc48bace7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WOE+XT1FFh1P87IzQMY1FfMxPxzDnck2nmm28j1+W8ZOlcC3HVCnrhBLMr3MQmumzyoTmEs4lldkzBeaj7KX0AiRjGmkYcgXX3AN8QwYiykHuHEGBnFdLKffI67o0WNATo7gCJ5QyT+GrsLVMn6NBZzqVLFBrZTC6e12e32F4/D/TgGhjkAV6NW/taFX4W/TjL5ph7w3TiUYLNmkuLmCB0dtS5/fwPE94KJB1mwKYmrozgG7SAHG2n2e1S3L7MPnjrpwpBmByQFBWSgGrP9y2UM4Q5ZH0pWYmp01VT4YFI+8mshtRKEHORzdQVCtzr4Q1+bDya8JmhO6BlQ8sEc2mgPezXi3mINVBGhaf3gJYabl0tJkmMXUqpkfv5y5GFiGJyHNSi1uREmvk4DNqrjQZbBMRL0Cc26RdlbyR85v6WGcCF3xfL3XqLwDHe7E3P3kYmXyKeun5FUCugFR4Nprp3lYEDHrMXHLXtFOD2usfqjIkYeDcx9803rGIZimj54Jz/o+dnCPf4K9OSA4PCTuLQb9dDbZ+HSrdYdXi/jX4XttU78FsPSzN/HLDiuRJI0fCS62YQnsjIkEsSsDwTN0c3t4c5G5ODe7SZGGMYBqYgT8R2EWztz+bjsulNdLTh20wdo4dTQFsaoZi3E0sKbcEMxoyQ6BEJWHgbQ527XQyOdbZpse44EIFG9+0lHdMreOs7QkTONx9LnEK4w0vVmZGZJ1fvJoyySnLV4pE42ouDV0Tiubr7alIB4hm0JBjsF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:50:34.4857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a2d5b7-f6ea-4ac9-2cee-08dc48bace7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c  | 2 +-
 include/sysemu/kvm.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b5872fdc07..bf0ae0c8ad 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2913,7 +2913,7 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
-static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 {
     MemoryRegionSection section;
     ram_addr_t offset;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 2cb3192509..698f1640fe 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -541,4 +541,6 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
 int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
+
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 #endif
-- 
2.25.1


