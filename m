Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D614BCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGrex-0000Mf-2q; Wed, 14 Oct 2026 01:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGrev-0000Lh-QQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:36:13 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGreu-00034C-0C
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV8atrGaOWAk4YE0s+MgQJZJGnOU0jryB+Ia9WrVLcHK16oxgkGfihmR4ahvnO4FeSgulD+nYUAkjwXmu57/+Tj7zaONrRMj8wDPEA5abEOMb7LT13ri/mKJWzMEEr3g6qqGd0xWERu/7a270nxNFIIlKgl2YW5+zPKehjcCmCgxlcUg+H26MjAUhSBwsiewWYGZgDpkXMcQiu3brT0+pN9KE3PWzFH5cFZWm8bXFlVPeN99tRckOcIX73r7QUUicyqCumflb8HEsZdZF1o800Q6b8n8yGSePJsaakBk4GsH1t7HX11Uxp9zB9AqyYeTSoF9fIVG40QgY7+EOQmQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1ThCPunlIMLOtf/FHC0A9H5WS6RBg+1Vpo1Kqiqa/Q=;
 b=DEvwg7NI9Zi703ArXGc4JI5o4r0Utr4USqNpyoHG4IE6SZNX1MeXulAbl8J1q26SNYQfArkFvlJDNE0xjiMf7z/3Lu/muNr/GYU+ZxZYOzCsAkpOUpCrW9unSFTV3E23hzq//yacr5aYAWZNdEysj4mXVBIrHZeK+WdsgFa/GLfLbeL3wXa/3Cw19edz226hPbz4wPs3Cz4q2FlPpoCnxoOMlSdbNAInzwmny2+bDj1qmcWDlxcPMU/e+wQJM5qzRbOtIzYtsLvnKnhwmnau6L5hQIsFgx6x5fkcRyJpz8vUnN879dhMmO/FOnfIEaWER0fPFocy1nTNH+Uz/1/HKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1ThCPunlIMLOtf/FHC0A9H5WS6RBg+1Vpo1Kqiqa/Q=;
 b=BXPWX6hHu0TkDOFWfFx4/0kUXm1VzAygIcFKpXzY/zNjpyXjbK+1Izw4Q2vDsWMOS0FJaY+WFVZ1I0ckARmfa1KWFvMFDWDo4V5ALjsNcPAq7BuCxhgNPiNEk+dkI+tS/DgrHurDQ6LGDTM/ad3tA+uaSa8GOkzZCtqegRzUVdU=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 05:36:01 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:303:87:cafe::45) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 05:36:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:36:00 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:35:49 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/8] amd_iommu: Add support for get_x86_iommu callback
Date: Wed, 14 Oct 2026 11:04:28 +0530
Message-ID: <20261014053433.24564-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dbe68d-8f74-4678-279c-08df29b507ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|22082099003|10067099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: X1VA4D3KdeKIjaB+kd3f3vov1YxWhYiHzk/FqqDc43SeMU5xpl8oiAsnGlTeyc+hvqY1OfCTCrGUlDxLtNGLbKak5QvChcqW8C/oyqlRuRposyThYwacYtXLZC+L6rHuZXO4hkQTe3wmJwAsxbCBFvbBPMDzL9/7TDBtI3EPzVVP0+BmNVESDBrPFuBhVrfbo4qss89/h4BGkxZQmxU/dH/yODWuOyLy77TTI0X57/040b4NSZCeQl/uopiejD9Lh+gY4a2is+lPj4tbRhcEM1X995Z02pNk4cDK5YeaXMCvAETNSmRSw4lZQNtO482Wr3UikM/WG56xsatHvMxOIJAwiPj121ThydHtlGnH4nH4r6gTG4v+wEbiia85/nR8ao/uGIZp4I/DUP77RuCHyDmbf4meVu3Ku3GpDEY0ZzgPhFw7/WNL9E0lvy8DhV+FczJkq02qVUgbx0bpwOpEw4sQA60kPct856M+StrqFdGKy89tdGo8R70QXr7L/yDPdkTcXiGgAhPPr2peIJNxi60PuxSHBAqqPHYHViUUHjjD/PDluq8ikGZtmU2GkhST7UKoG064v8ItHTd3JjUfHvH7Np61bHdj/y1pzrgmu1vTDRN5OK9s3rtV8WVio7jq2HFZDIj5DM3PqHDSLlOtj6rLZ8ibywctkMhscqOkRgger6XPvLlIYjgJch4w3UKrNn43tCLxbuAeFb3spTdUpFEyODbuCQ7BnOpeWnhHvVlIxEa2VepZf0xngFHF2SSb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(10067099003)(18002099003)(921020)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 453UZg58Cn42QSFGxDEwuHne/ro4g8nN+5DDI+LQz+ShqZ2BTDG4wvMAlvA6MYzrQ3a4M71jVSBrchIbYeU3p63fp56e9VVj+fxM7TVEKr2/FQa1cosxPU3oKMCs23FJfumSZT2h/Ib0wDZbJttA0Ork//lqA9yXfojEwruzK6mZHUKVpgOhtThmzr2HzNQnVM9mVeb7H3nufWhFcTrjgpiVd9VnHyZEyx2eW2ki12tTKUrZCI3b6M/me+aGpXgLfj1ZRUvqCseDCQt1QLwn4DTv8uWUpETXbD2hr5TY4dXQy57BM0qf5wdNtyZure4bNxShAAZOPOhSi/0LwUEWQ5bkJJfqo5ddlhOssGB1s9GedI1joaPM8g+JOF/GzZV8XqKq1oKI09q/e0EmbnvLj6Rf0ODZ61dODp51T8U+Mbe8pEaiuoLfe2ntvAOK1siV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:36:00.3679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dbe68d-8f74-4678-279c-08df29b507ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Sairaj.K@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Return X86IOMMUState during get_x86_iommu callback.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 614c7a131482..5c1fb0879c0f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2472,8 +2472,16 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &amdvi_dev_as->as;
 }
 
+static int amdvi_get_x86_iommu(void *opaque, void **x86_iommu)
+{
+    AMDVIState *s = opaque;
+    *x86_iommu = X86_IOMMU_DEVICE(s);
+    return 0;
+}
+
 static const PCIIOMMUOps amdvi_iommu_ops = {
     .get_address_space = amdvi_host_dma_iommu,
+    .get_x86_iommu = amdvi_get_x86_iommu,
 };
 
 static const MemoryRegionOps mmio_mem_ops = {
-- 
2.34.1


