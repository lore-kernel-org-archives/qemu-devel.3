Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C262C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrYd-0007pm-8d; Wed, 20 Mar 2024 04:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrYZ-0007o5-3a
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:44:19 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrYI-0007tw-4Y
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz8v6XJsQk9kW9CVHcCuPQIQp2E0h5nk59CI8mmUgbGXr7yoiAlSepc+Dpg7wk6/H0bQW7xlldCGXtLQjaKK3k1vUJ5IDVlkPZq3WHu2uFmv0eN5LWAUGUt6qA31u1XZvHdAB6Ulxs89+Gd4MLnJ+gxvHP188k0YxmNq72HEcZP04bKj6gUNeg6jnhrSqLWT3oFhG9dLslyXtmO+C4pRjdpx960KC5LJXRX7D8CnJEM2I5jX/UQBAMwC3OvI4QOkRh4oC1AJjPUOS/pyjzoBPscBJvKv9O9prmQSL/+la5PnqAceBTvk8qK+3qstYwCTRzfvz48bOr2vPsAyw8PC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSrmrJQbHUAMRL8clL1jsbrz1sxVZn/0yeZ/G0uTirA=;
 b=SOHMYBuG5LtqFK+aFTSMLO44QIxWQtLGnZTaWI/fjNmn+XPieuR0sTX3jEH2FqDW1sLnQl4JTTvUspPqFNpyQx4xeMB5dzFq8syyJuX3FNsUQ9U9KoLyiGBeGDcooHzSm0lgok9o7/VjvDNwePfPG8Zx2LHi4eV4/mGBqg1QTLFIpfUhfR0hxXpfQPCNx3Ef3l38/7DKB0NKT81VKzz41FHuBaXuyYJtR6/jgM/A2DtCsFNhA4gf+V20XsnwNV7eYWRFtQXoQpeg1ExUwLBBhIGYgIqwjtC31x2VSOV0Ie6No563fG/fhUh69EfCHdbVbQh2FjtqMa7rzRr0P9CIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSrmrJQbHUAMRL8clL1jsbrz1sxVZn/0yeZ/G0uTirA=;
 b=tFPWASVdcMGSrZGZrq0wzeP1lZA/oDqGdnQn5ysKry2u+XpD02xghojbA7D3w6X9DxkLl7pQd0lkR2NpiI1oWnyFt2QCXS59dolXIHduMO6G77RCrdy3Yuhi/3JDsJrcuPjhRMsbgGlX1/4vsbeTILAayZFUwBpjPf2mO00XYl8=
Received: from PR0P264CA0093.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::33)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:43:58 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10a6:100:18:cafe::4e) by PR0P264CA0093.outlook.office365.com
 (2603:10a6:100:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29 via Frontend
 Transport; Wed, 20 Mar 2024 08:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:43:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:43:55 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 16/49] memory: Introduce
 memory_region_init_ram_guest_memfd()
Date: Wed, 20 Mar 2024 03:39:12 -0500
Message-ID: <20240320083945.991426-17-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e605d4-8ac9-46e9-7353-08dc48b9e19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/W8UtLvqFlkTugE9YUplWeyQBakIaTLYh56iS68VPf9BUgWng9wFwnSLAizsESXGLHZiwIzJUaaFBzRGJDtSlXsFhF3oWL4n0iriXev544Jmnx3l2Is7z30+KorCBTVb53LkyG1jkVNkk/3xoGf0wDTYdKuyu21ofQ00DjN2ChSXMqoxphPWd284qRJqpy/G+3vns1kBbL2arN3p45C4LbCp/WUAAR2wwF0UeB6QAclwPUpFEzqiI1JZV5J4fFO8gZeB5bBHQRpLOqyI/wvoBD0GNuJrXn0sbBdnVh1o+s7lcV0ZurbGqWuFCFaSTPG0VIKAVtbJB3ko1lqiHpbpLbgD8Brz3eYHYOBVcwfkqhQMV5XY4U8irKNMPWS9TXBOosj8M6isGtDKX/7HjneEpx/znFCXhQ2O9T6gBAV72IAGNxUiSSxSb/FDNbwj4e6UsSkAGf9HOJVwtRhLq8mzgLiWVGm1dEnL2LKZckEki25QwGIR3uODn+g8+sXUZ+nOnMe7W5py3Phw0d98wlQk6AnHOM4aQamjQNHYEElu8KW0lU3ZDXFm1i1Yvqps5wezpZCHZJ+OTEKRndteCw2mr7LP0IP683fkF+JfRpVpWq2La+lxINd1zsMYCiM+/YlfpNIveSxuaRiribFA+bEbpLCtpi8Kre/z+0b1cFuR2jqKkIs4UTcUpsedBTgYMjn0AhndokzKwaE5csKxM6b5AQrs3gqNnF+js0QWPmVANWJtAeCx8clXJVCFNEtbIJh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:43:57.0706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e605d4-8ac9-46e9-7353-08dc48b9e19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
Received-SPF: permerror client-ip=2a01:111:f403:2417::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Introduce memory_region_init_ram_guest_memfd() to allocate private
guset memfd on the MemoryRegion initialization. It's for the use case of
TDVF, which must be private on TDX case.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v5:
- drop memory_region_set_default_private() because this function is
  dropped in this v5 series;

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 include/exec/memory.h |  6 ++++++
 system/memory.c       | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 679a847685..1e351f6fc8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1603,6 +1603,12 @@ bool memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp);
+
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
  *
diff --git a/system/memory.c b/system/memory.c
index c756950c0c..85a22408e9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3606,6 +3606,31 @@ bool memory_region_init_ram(MemoryRegion *mr,
     return true;
 }
 
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp)
+{
+    DeviceState *owner_dev;
+
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                RAM_GUEST_MEMFD, errp)) {
+        return false;
+    }
+
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+
+    return true;
+}
+
 bool memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
-- 
2.25.1


