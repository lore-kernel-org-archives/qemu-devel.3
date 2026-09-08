Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE231C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42pF-0001Xu-D6; Tue, 08 Sep 2026 16:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42pE-0001Xf-Kt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:53:52 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42pC-0006rf-R7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYnedIR0LCN99kMp2sCIZ4PoM5Bf/khd7TgOOpEPU8xFzNtTwrvB9qgOw3lG6D2BhgA6Rzhx2omz+GYfnDtPNGgtWIp0LUDeveYtvQFahL6enIKFn2jcyvrWap2wswj8CIfreYwm/pA/JWWGyvLzBUIw82ft8907P0RW1jxLzoG46G0E7Fx+l7IP4DSvbIcgUdiOD+gDmnY6dL7hxFKH19WsH+BuE5+JPGDJRFIr39UmhL1DSO4D7ijIUUDwHVGY8YEaUnMjGPoUvEHnSwhxdgBuG8Z+vcMCr/mmAi46SgFSKqLBggybuThraquVGeIJfUEcHltc4JeG8S6WTVDMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnubrSwey481qPqvttJjEsUEfXAuN6ka6eSVU4vRTN0=;
 b=rH4NOvypo5MV4QtWaQ8AvNOac+97OpzBbAK17GljCtsbwUoz5MweJS1rq6FtKza8AdsLCnS2kyVwU+788mgwJKTM/ZcBjVwzmz0LB9HFx/UtRWK7OIUpTpf+P97+Sz6x/C8oDOpwSnB/rg3sfNEOYd6HAkzBc8EHaHeZefotgLNdMjtSxyV+cP4ShOsFzU/aCIRn5fWF35BCy3yOguIs9FwzOIP93UNgQldGQp3EhemQyH2nOUeDjf3y7WIAWG5aKMTk8mBItfLoxcF4WFkDFoAAk6poc8v23+kIrXFQSNg9j62hsoCe4AABNuAN/yvm/hRewAXptbLkAyp2aPCs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnubrSwey481qPqvttJjEsUEfXAuN6ka6eSVU4vRTN0=;
 b=OoS9e4SL66OVEJnE1XbY7jrNO7IEGIImx/OOjA2MthcBksHuazplrwC11PPs0ia8qxBkB0RjsGJgdXcibsTIJBVduQbf4lPN8pFhb0dJ4/qAeJ/gNyM94cM1uQJuIFxVjGw48KpyMUeAYVOQ/b7cLFKUETG3Tb3phSLkMDhh7H8=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 20:53:36 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::5f) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:53:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:53:35 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 10/19] system/memory: Default to guest_memfd for RAM for
 in-place conversion
Date: Tue, 8 Sep 2026 15:48:30 -0500
Message-ID: <20260908205236.838281-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2620fdf2-122c-488b-7d06-08df0deb4096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|7416014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3tc8tMGizcZqG9TY1QqCDdE1CIGagAG1dqjvDeRuZU1HwKoJa/H0mHLLA4EI35jA07xDPIsa+Kx44U88Z2sjiQSN/bgo9tXvN6WSQMVNH5m0a126zW1OSgM4GmcDWHf1MpPvaqprOuhArZIVD84XEU2kX0YKwXEaKuh6VrnUSbtwO1bQaB6qwg+IdF1lDyXfWUCKWoCPFdYQDl+spofnLmVd6VJ7Zjpg3Isx4j4x0GT0MC40gloxwgQKHEuann4/302L36I/4r6VPDOUnTh9iAOlr7fb4/NE2LdfsP+AKd6nuMoSE4jN0BOdkDrTLTD9zDZU7RCZxNYPN0jbLNDzCEwD5Xo+bIPIw0ABsgtP8Rxu1bY7/GR51m9flQnA3Yav6SMNjSABWzkcG4h5dpBUheQgtGdI3CH64ivSm5ndwbWdXorOAFWX25uz6NA09cwvmeVkkK1KZGAaQVvQIVVeQWRQ2TwOq2eJ74Ybvf3b8fneZ8qdhIagO6ux7JyuhGxfIIR18bK+fRZ+68qEHvciTwjvDxitMidhK1oj5SIxsqZjGbb8pM/cEFT+MM4ng+xG/L70q1HHFut60gCWV2uN/gDqUKBoHGsbl25CrSwJNhTSABZqrvvtCTh/iK/0pzCKpFtznRj1ApXB2hdyn7l9mIwRiSYGveRi4hGD2ZfhAb7JFnKVDIeuO3bBAaOJ1PPVfN5+g9/4zNiZreG6E+T6WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YSHVYkpjyZeNWX8BLpMgEYJGMQ+6HHvTM99iKKcR0wGwI1zlbOBre96iev6uvOeQXbEDX7zjVx+K1OC0RNmWwC41rIHFHYS+WaohVMiDrmkB2VyedzR2hJc5s9r2jaHjeK/pyl3tSZFrwhwO8aZqEB7wRelP7q++23ISpVCQTZ8b/7dHqnr4kbbJtoJ83RS2bDcxvic/H7n1HHeazfghsqhZ80Fml/Kr+Wcb0T6PMmGns61e+vVKtgHpg04SG6K78nuRt7I3I90xwSH1u0AeZkqY0N9YVALN+ePeIxZInoJ23QdB3Di2ajkU5H0ANyrHCOgRq8acFGsDouu5BcwaE0cKj21m2MSkdROjGIPhl5DvSIH6EumDcwFVxvIXrLbTGW0kag4154zOIVqW09qBXXOvoh9R51lOuNwFv+avw5bC167ApWEvJFbXeMU1/XXK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:53:36.1425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2620fdf2-122c-488b-7d06-08df0deb4096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Michael.Roth@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

memory_region_init_ram_guest_memfd_private() is called in some cases
(legacy BIOS regions / IGVM regions) to allocate a new RAM region with a
guest_memfd FD under the covers to handle private memory since the GPA
range can be converted between shared/private guest RAM.

When in-place conversion is enabled, the conversions happen with the
guest_memfd inode itself, so the same inode must be used for both shared
and private memory. Handle this accordingly when convert-in-place=true.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 system/memory.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index b3b678617b..ba3ef27b58 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3623,10 +3623,27 @@ bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
                                                 uint64_t size,
                                                 Error **errp)
 {
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
-        return false;
+    if (machine_require_guest_memfd_convert_in_place(current_machine)) {
+        int fd = kvm_create_guest_memfd(size, errp);
+        if (fd < 0) {
+            return false;
+        }
+
+        if (!memory_region_init_ram_from_fd(mr, owner, name, size,
+                                            RAM_SHARED |
+                                            RAM_GUEST_MEMFD_PRIVATE |
+                                            RAM_GUEST_MEMFD_SHARED,
+                                            fd, 0, errp)) {
+            close(fd);
+            return false;
+        }
+    } else {
+        if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                    RAM_GUEST_MEMFD_PRIVATE, errp)) {
+            return false;
+        }
     }
+
     memory_region_register_ram(mr, owner);
     return true;
 }
-- 
2.43.0


