Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9A1CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvE-0006GM-OG; Tue, 23 Jun 2026 03:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv9-0006FZ-Dt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:48 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv7-0000hb-QC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcHuwXsBx7HjcVjwlblocBAdbztEy45oSWcy/Lwj59qZG8CgzPaai8zk/Vu++0vubdGy4dGxjugTyi7LOUY+CvWbN9eYEuY9KuEJH4m/TyNMUnRgbspV4WtAGQ/1ydz8+HFDX5F09HmB2adkLQvJvAKCuBgerQ3yAuIFZZ6gVJrOIKnNMHnCQRY8evwx5X+OJaj+Elaje8hTzo2l924c1paTBBlQqr8fHypID3A8bCDuvzNqGw3I9UYENT3l7qkDmUva9Qf1cT/91R13jRMf1wjiwJJcihSy3v+oTnsSMYE9Y+TMI2FBJTHpKEAkRv7TGRYHnhv78gTvw4gDX38StQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uI5ScM+oJRFbfYfZjtlPlPXO6mvy8/mwyn0hWf88JaQ=;
 b=YAjdBOkqCGOHzsb6zOKL9KuHsxisiCZDlIcQHFcAEQzpTLeuKTyAHBbxI6xpou6AI2dphKXl3N/EeAadanmZHylAqyA5I6/ghbHpZfguik2SZWn00pZKaSAAdSd4o35JzTmTjjdmddWyniL4Cq9sR+zTvUED6ZhnRn7W/GOQUPLEkKI+crEUStSsK+GLhRcacaZ/tsACetOVzfrl1Oxkk07ktgrZmbOs6F0CGk2notAtEneEuQfQoDm5R7xmEuWWIgdHEM98IxePdYU2IF/ekAUpCGu3sTHT53h+4CU9ZVDnWr/C4DTbntFqKLiEHoD/VGD6CUmiFWA3wvPotfNGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI5ScM+oJRFbfYfZjtlPlPXO6mvy8/mwyn0hWf88JaQ=;
 b=q9iKoHZT26kVyQ10tgasSAap7kpOfj18HyqiJEytStQGAaEW3ePZ+8iLmwMuPKw+3dyRXUqxfg5SjxQynf40KLGkonHZ2VfjrPSv+gwm2P914a+aeDIx7GtB1n9Hs76xtO4cOdBs4qJyEeq4zIQJA4uE4Rzkh80h0LyguHE61TU=
Received: from SJ0PR05CA0157.namprd05.prod.outlook.com (2603:10b6:a03:339::12)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:51:40 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::70) by SJ0PR05CA0157.outlook.office365.com
 (2603:10b6:a03:339::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Tue,
 23 Jun 2026 07:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:40 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:37 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 05/10] MAINTAINERS: cover sp-mem under Memory devices,
 add R: tag
Date: Tue, 23 Jun 2026 15:50:46 +0800
Message-ID: <20260623075051.3797975-6-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4666f5a2-b20e-4307-7e95-08ded0fc42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: 9PA4sZa+6lSZNI1+WL2hJogiSNJZPGan18o971oZxnCD0M6GbU71BOU59SUh9t0DXioJhlBjs1K1eMGRSN6nxksRd5yXIFFIchCv7QVG949dUOlwrASpu1Jt0QmAslpP89ewS9Rr7VIRtbDHX0rLEWDgKxaq7CiRVIntiiEJn/4jB2Qi7d3x8pnANxMsJ31J2S3GvMueJD/042WsLM4RgcMCRG9bzDfR7Ipc4K8XuojkSZGis7SsR2wcsvGTAHQMLKHZnQRREmmn8hjkVQwD8m+12f4LBWQwYvJynNKiN+PGmQBa9sprwrlB4zjxUnaL0MhhUebscrWGrZQMYgoN9MlTKna1RPOOGsGo++Gsh60YFg6dZqT4FgblHszwtKnILggy42lWKV4/cWqrm2RJ4jDOEj/PIDHeYt2fX4g4uoWVMcRZ5ff5kzmdFL4/+mQmiBEp0wZUdMC+EfUmkn9eshxWgNDwI0iNl09uouwDAHyTRz1Ln6z09Gvdwj6H8iNOO/QN5X3yuvxQWMC9T1Q3KYg7GWCmjScJ2rO0alPSKHONdlzH/LJ0tW9+/VlgnwBdzt6Aks/E5LLsr06y7Z7y1h6DGsklMlqDa+2Kg/GEzchsiTYVi9YwyxgaFmraNRJQSygv5QpVgI0qZx9uZ/nwInozuHWzp84r3SwnBoqzzK17qJJYvxiKtm/wBoQ1zfaTXuUfspn0xS8RBlXchVL+GSdcURkpOpgpeXW3rpN2bdTMDMlAtCQgCOWM2p8X9rWY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kBQ42ZJyJDevBsh+HIMrN8AZRr0HoSzSB80XQ8U8Bxle98xNvLNXGY8bRfleeuw3XPrZmcysbzdQwEgJAXtSAMBiUFoDZsWS6A3m/j3+UBMUFhmXR5EhJO968k3MNCu073TZHXesEw5mB/0zPHRaKvpxbK/fUCm1DZr2ZFdO2AaJ9R0XkT9r+Cm+iz9X37Mzpf2HhKLzpUIXIn7HiIW2JhSvJFXALADWdJhPzZNGYjdIDnfgXsRnKueDK6xRTRUVq1YwGHfEDoDmRq9yoRpywg89n2UjdqABgKCDFNnp455n76uRjAEJGwWTEu2ReAQI8Wx9ZJSBp8FLuaW8wKoA39sI+4zfBBRM2m00qRZnv4LZE1ux78gTQ8O97SIIqWXZ+DQA5vWuSCutvHBQo3nSYCGCsWy/gzAd43+2rMqhlhYt1JlPCVyhhjpfblxoYZk+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:40.2550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4666f5a2-b20e-4307-7e95-08ded0fc42bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..08f0d11a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3364,13 +3364,16 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
+R: FangSheng Huang <FangSheng.Huang@amd.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/sp-mem.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/sp-mem.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
2.34.1


