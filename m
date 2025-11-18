Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC1BCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLH1R-0006jD-JJ; Tue, 18 Nov 2025 03:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH1N-0006io-Vq
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:25:06 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH1K-0006me-GX
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdRkUGayFtC0H/MiqDu+oesaVcotKJGGFarjlIPArPAse4wzSRS6z7hCPUfUHkj877mZslnzqFCmamiNmoNi9XQV3uo0cRmLBDHh6S6rvvwchVTamjEuNUf79x0hVfmjwxcXAdQsaUkcinN6Ek3MP9bDGERprKMOS73hBBKqLaObtYk0znxZ86hN/DKNzzyzWZxfm+tPRw27BofuGvTegL55Jpb+7P99VhM2iz2O329WP//eT6bOSVC+tyHihGIp1tanZT5lcVzXwCBhiWBwVKppX0/5rb43u0dH+xzys2PDWUwnHziFcODfIsk53vfCpewN/2NhpTPUijgPHNyDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ZwteG4dkHt2/qEdy/8goqPEJRXivCq3QetjYinR8A=;
 b=Pz1OiBZy1fDJZRoLWQDVVeanWFBjMle36hYKx4f9I5GOz65T5qFhFmm0hQCirMV9eJi23DWsLAKWsPptJg57YxWG9HrrG0IR5LzAEaOsAT4BTQuJwnLr04GpDZmVub9SfbGNFsZcgeng2pqmv/sW1KVMULjbpQL4Trs4Zh/k+r5ocz19TPxRnQPpH5F4yJJab12p2Uu7e4pnsQ4GgWCg4KZMaQTL/HmnvjpIR37Qn/BLtwHuo8Iw6Huw4aLJwEJzrcZnnAjVMZqLuRveVqViX96DFNe0qTn0Pca5GWrxTCVWhzkHwSTYSReWztD6TmrOfU25G1ib+R5b1uDAPB0rXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ZwteG4dkHt2/qEdy/8goqPEJRXivCq3QetjYinR8A=;
 b=MicykQpIXD4XEcjITHSmcmbF78r22SXoPCdlIokg4u/zaNnpNR6VmPhrdvmw366UL/vjtn1RBOEBzdlQ/KknGyx4zgWnNzXqCrHJ1onmSo/vqPhLVYNznd66dbgXY1VmmyjQ9YBxlhCFeUSo0cUxeavqTr3M6+DOYxLvjrqAGBc=
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.23; Tue, 18 Nov 2025 08:24:57 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::ca) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 08:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:24:56 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 00:24:52 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 2/3] amd_iommu: Turn on XT support only when guest has enabled
 it
Date: Tue, 18 Nov 2025 13:54:02 +0530
Message-ID: <20251118082403.3455-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118082403.3455-1-sarunkod@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: e96556bf-1a2a-4632-a0b0-08de267bf4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KVHIlSgGp4xXQMTg9DHBk791vSy84jH4ynSGPwFvipCyMTYF3qF7AXWTjMYq?=
 =?us-ascii?Q?Wrp3MYhUmkUiZKxFIvSxUWaKFnIVmzr/FZ8bJVPBLMESUwjE4Czo3CbOoikv?=
 =?us-ascii?Q?sZSvAn2z/S9JwR9kdLct9pOwUHIHnE7mLU8wDYHa7W6H32kI89D7qfTDtS/H?=
 =?us-ascii?Q?bZu/WGRECiuqSOYY5wKft626tpy1spNoU4L+EDBi0pKSR9QtAUFNDJXyN8/1?=
 =?us-ascii?Q?1PkOstwToGXvRU3uw0GPK/7K4y0nrjVU0/Xl0CeZams/dkR2XoUk++bnRYsw?=
 =?us-ascii?Q?PP74ddDPSGoXUQT3s9ad722ei7FqJ6IYKScTJFBz5VWGbTApala3ngOyqYy5?=
 =?us-ascii?Q?9mr5fzX1VQWmEkZheSR4YRmAnGmJ+ZA0LP6f93Afo1g4bL+u3lPLBHvgTRIX?=
 =?us-ascii?Q?vu2kxdI8T48edrLtJA8JcwXL+wElSdQwmbXMjsXUgLwD42NPlr1JQcChaknT?=
 =?us-ascii?Q?nB33Ctq1l6tTNRWAG9E/2jOo1XUSvpxMVT2s+YmO4kQoeFT3jEsBBksh5Dw3?=
 =?us-ascii?Q?AG07EsePImoF+9BFcpY8y+l4biQFLohdDhh4bvOELRqPXKuy+VxOcASyQg3P?=
 =?us-ascii?Q?/FzQf0GzNFxJ95qIynPU8MdLyt7N1RbBSmwCj2pHNKiZyA8+hgfC8Svii7+l?=
 =?us-ascii?Q?lViQo9c+tyotcOEV2QMq+XCj2yLOb/vTgtoEGY9qr9ZeM4V1EQGBezf5ZC0V?=
 =?us-ascii?Q?3RpIZahS6S/kI3bJEJWEPgfNCUMoRHGVd+ghvQWj2GTkntaqow2zrA92msi/?=
 =?us-ascii?Q?si9P2XFh3I9S0Q7NzAtZvuZ7bHfNvWTAbteXxDN6y9aP9t3rCXNI1xHzhawz?=
 =?us-ascii?Q?GwtA2AEGmDBXqN1ovorMRV+vLqMaWMd52CQSsr/yeFui4qML4/rCjXP7yJ37?=
 =?us-ascii?Q?iepZI+QlRjzbUy2Dqps7fF+yO0x/AcUhaxzFcEnpZtZ1OZUj2A+ZdW17JU8S?=
 =?us-ascii?Q?jaAd6rQObgnJIHA2vMXlNZeJtXo8nbxhDQHq74l1x8/ovNs95I1aYKmyfNfI?=
 =?us-ascii?Q?PEvviYeKpUoTschnsz5nBg2hvoGPZaAIKIykR21DgEyClBLo1L7997tCd27S?=
 =?us-ascii?Q?hOutUcavglW1Emu6lPXbgOZAg4lRhuZeoKkDfdC459b45Mf8gNL690odHCjO?=
 =?us-ascii?Q?gTM808IKwNaqlf5AVlICwgCyQ6l1tk+aGpdhAN06EkvSf29fBfCw+6Pv1mcc?=
 =?us-ascii?Q?zR+uHUskqSLGCYNV6wWgg5xrWyX2z6u7jesIFAVjgxhb8N6VJPmfZyCfBYFe?=
 =?us-ascii?Q?/ScIqMnl2OF/VTYfneOiQgO/vh4RX+mghx9wLACtx/SqaxJNVt4eoqqni+ga?=
 =?us-ascii?Q?Hid/K40eRwhOIZUFZwu453mkjD3DTKjUlmGZXBM/KE7/rxQXtW9OpfJjLUPP?=
 =?us-ascii?Q?UpvB/Mt6vjAArmxUHZCdgXG2ZKQxrlFrs+dceuPLBYIZERk+MHkdIF7jAWd8?=
 =?us-ascii?Q?rbaW2QL2vl9nu57DOe099zbKAXrna0SKefdCDgQC3UpwP427YGwttbANOTHo?=
 =?us-ascii?Q?tIlQrstwJQF62wsNHbpJL4hix+xJIyHEqtEsKENTChYU37eZaTw85+HGX3Ag?=
 =?us-ascii?Q?9U12XGHx3ISNY9+oSpw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:24:56.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96556bf-1a2a-4632-a0b0-08de267bf4ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Current code uses 32 bit cpu destination irrespective of the fact that
guest has enabled xt support through control register[XTEn] and
completely depends on command line parameter xtsup=on. This is not a
correct hardware behaviour and can cause problems in the guest which has
not enabled XT mode.

Introduce new flag "xten", which is enabled when guest writes 1 to the
control register bit 50 (XTEn).

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 3 ++-
 hw/i386/amd_iommu.h | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a9ee7150ef17..7f08fc31111a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1548,6 +1548,7 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->cmdbuf_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
+    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -2020,7 +2021,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
     irq->vector = irte.hi.fields.vector;
     irq->dest_mode = irte.lo.fields_remap.dm;
     irq->redir_hint = irte.lo.fields_remap.rq_eoi;
-    if (iommu->xtsup) {
+    if (iommu->xten) {
         irq->dest = irte.lo.fields_remap.destination |
                     (irte.hi.fields.destination_hi << 24);
     } else {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca5121f..32467d0bc241 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -106,6 +106,7 @@
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
+#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -418,7 +419,8 @@ struct AMDVIState {
 
     /* Interrupt remapping */
     bool ga_enabled;
-    bool xtsup;
+    bool xtsup;     /* xtsup=on command line */
+    bool xten;      /* Enable x2apic */
 
     /* DMA address translation */
     bool dma_remap;
-- 
2.34.1


