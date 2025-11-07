Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67141CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdh-00006M-7y; Fri, 07 Nov 2025 05:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdf-00005g-Mi; Fri, 07 Nov 2025 05:24:15 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJde-0001Cr-4K; Fri, 07 Nov 2025 05:24:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCuo92z5fxm7Y0kHx7y6tkDwuOdUpeylwrUVehPua0pfB2Bc+neoueYCMxEGHNabwFxiJSr6XJSQ7xmZE6GIGYbyyaIHwL2CfTUYL+5vdzLGsg0asbkwlXXZEdDYUx9is6tyW4jT45if9r2ljQyqvBnFjEMyN9EKjG0uYOC0ZLb+ucorQcF0yPstDN9SwWJeP7OsIjIUzbcSoOp0wFaXK4DjNUgFBewsZT6cgWvp4aImgYwYKXqe1IJkGvLu+YbKTmQ/F2VVTpGpxyYkVs3fPdGn1vswIMovG4EG21ADbbXu8+qAvhW4yadWpM4Ebo9usRMnZKbOzzaERx6wwN3ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pD+CDTxpzeQhmAOpieGJUmHrgKqQb+97My2sqoIrKI=;
 b=qdm1Z4Sp7NUq/Zhv0Z+6NBtXqiW/d1LSh8OK7/KANjrZK1zxbRU74DnFVhkLcx8CGiTNjDdwkoWMVCgtjThlBv4qqQWh9EZcssGyqg/s2TK8b1lesAZrJHIk8B4gWXYLf8zFxTPC3WtZEnzofNrISHKIQceOUNh2v8LCzvJgpYzBrHGLqJxim/o9a+haPhPt88I6TL3VbLjaEIkDfXTojTWq4zSTbFxeR4C2iMOxxWA31KFEhp+t33zftLiQzSTPZ1s2640TAec6ErkVtwLasIQSSLqahJrVgBqsZH4lyjuD7ZZRP7BRWpZwmywmnIE87WJ/pun/JdMpEAstc0LZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pD+CDTxpzeQhmAOpieGJUmHrgKqQb+97My2sqoIrKI=;
 b=b5w8LEZeqAjMT2gYw0UlzlBpyN9sHslAQHBivXrBd0mCRnNiAwzomPdEOXMKw9eQxZoQoUlJ/lmeSrugV2EBBDj+XFmEk4TiIff0VgwEoFiafLLtGcGylaL3y44USkuAzpgoituG/dlVaGIBEEUzxlnRMgipWXXfy8T0IonNhOA=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:24:08 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::95) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:07 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:06 -0800
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:24:05 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 7/9] hw/intc/riscv_aclint: riscv_aclint_mtimer_get_ticks: get
 rid of void* argument
Date: Fri, 7 Nov 2025 11:23:33 +0100
Message-ID: <20251107102340.471141-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: aa54938c-2a7e-44b5-c16d-08de1de7c8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUYU9Joj4a89zFf82MEvlnqqulz/BctzQu7EA17sz0KshsooycNvcfvPAlD1?=
 =?us-ascii?Q?TK55c4oXfHh0OI8TZt6Tf5m/E79RC7uxe7gi8IJHB00r7tR13TkNX7AhHzCv?=
 =?us-ascii?Q?xMw4pHFgCBg+2flqj20NJk9g49XjiGIeh+r/HQYF4G4FpT1N85UX1ZBfPObg?=
 =?us-ascii?Q?gBxEm0ybkaBRR4DLiejgHRa6YnoCSUjCnFyQsaMapeohxznz3uDI0kO91BUD?=
 =?us-ascii?Q?rcs0ZDc7pjnyFCvhthP5gBZea7OKcCryjviFWX/wGRBylo5sKoxmWJCQBwyo?=
 =?us-ascii?Q?6gfr6OqLONSCxlNspUiI4QYVvMKIa0Y601mKJu9ELDBBvOmGhZK7zXYJ0GQ+?=
 =?us-ascii?Q?pLtT8/APa3b22L41bNegn5dhOT0qwPZKKFKPl050ZFgygoXDXBcpJZKMF7iZ?=
 =?us-ascii?Q?I6TOWXlnKyl95ecpoNhmKRvmHLjSN8sAWzfhSUeKUpx1vcjJ1V7au4WZyb+s?=
 =?us-ascii?Q?KWmZfKzhHzD7JfX2NpqU8HzaYStp3VLqnghm4j1jnW+Q10Dnkp/COKarzCBD?=
 =?us-ascii?Q?EUxK1RP9xVC1mFADMj6yw6ZKC8Jkndn3RJgEqHKfrjvf/MKDfkuhdOJIDCNe?=
 =?us-ascii?Q?HgJgReeKJNWdVGTwspI7wUwUDA7cRf/PAZvBxauEJAAy76Ag/qsVDqFbA7Ah?=
 =?us-ascii?Q?c28h9gMactfbTSdfB/n6UxEosHxXWV7yjvHAfXSlxW1jnhxvrXbYTWlaq3aY?=
 =?us-ascii?Q?kRJcjcLsiws2j+xIQlWbgkvSEOMxAtSZUSq9ea36F69FUDcY7sSC1JGUcMZm?=
 =?us-ascii?Q?6NOXjvrzXJ3uwKTciCyD78Dqnit2lc9c2Uh5g53tAMqeoiQMZlwo+eI4f4CM?=
 =?us-ascii?Q?IAvEDBfNT6TbdIRxMh5MSYJhP+NyRXZvYUGNDoSdFE7wLun3Ui51e3CsGP97?=
 =?us-ascii?Q?bXHacVtyFHSrMRKpxfZ7yTrk3XK2VJzqv6rILihI8kaMpbiHrn40OP+/5NIA?=
 =?us-ascii?Q?z4MIcP/9PpamKlVyHCm+K5Qu4++ckDRKFlNWT5Xo0p80+2ky9nWmsfhJMTe3?=
 =?us-ascii?Q?kPW0lI36AQVkhidAOyzseB8QwGtX4NGPyJ2rzZ7pIJXtYrGCZtcitVfk5xgD?=
 =?us-ascii?Q?KifsB1cM9ZxF12cC2thUHv095yxi8kvxP5iJeVFPNQDJPbQd02Ef/XkR65fB?=
 =?us-ascii?Q?5x+2GYhSg8u6qqZaUuE49UD8ISNsoVBtQB99LpK8gxr0aXak9/0iuIwZNEtM?=
 =?us-ascii?Q?xoOahzze84QB1Zzhwu1zydtRmejAqtgGBA63xHE8yCk4xdK/MtUjiO+ok7gS?=
 =?us-ascii?Q?iFb8ozIyb/6QagwGJinJz8wsGI3FWRF1rZXxyRfDsrPkr4Bp6R5o/cZuIrkK?=
 =?us-ascii?Q?nCcc1ZfEZBywlxmqmnk9Mw3uePG5N02otbKnenx66d/CmJMXQk5Gwp32dDTZ?=
 =?us-ascii?Q?IxqXZE0B4Fx44+pj4oWSFTiXqLOjmbzt4wXBzZGPuzPgHYmTBmLJbDWvgVfV?=
 =?us-ascii?Q?sMmUSK11YLQAQFIJYVccGvbmhCJzYNnTlMjE2AftfWBYjWLeQ+ly58ABfnla?=
 =?us-ascii?Q?nyi2Dab9W1D/Xvq1Eqkbm/MJ+7XzzbdnDCFR1cAP6mTrzILC+wQCKKdevtdC?=
 =?us-ascii?Q?6r94Fd2BAYOu2UcHWpE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:07.8570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa54938c-2a7e-44b5-c16d-08de1de7c8ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that the riscv_aclint_mtimer_get_ticks is only used internally,
replace its void* argument with the proper RISCVAclintMTimerState type.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/intc/riscv_aclint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 8d001a5eb20..014b733d72f 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -44,13 +44,12 @@ static uint64_t riscv_aclint_mtimer_get_ticks_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
         timebase_freq, NANOSECONDS_PER_SECOND);
 }
 
-static uint64_t riscv_aclint_mtimer_get_ticks(void *opaque)
+static uint64_t riscv_aclint_mtimer_get_ticks(RISCVAclintMTimerState *mtimer)
 {
-    RISCVAclintMTimerState *mtimer = opaque;
     return riscv_aclint_mtimer_get_ticks_raw(mtimer->timebase_freq) +
            mtimer->time_delta;
 }
 
 /*
-- 
2.51.0


