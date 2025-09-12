Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB1CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eu-0002xE-9P; Fri, 12 Sep 2025 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0dB-0007jK-Mq; Fri, 12 Sep 2025 06:03:58 -0400
Received: from mail-mw2nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d0-0001Pv-2c; Fri, 12 Sep 2025 06:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC0DIKDyboqwNzgyzR0dEGAAGTF/UeMHu/c5nm0sWkKcyfF2RdSENpI7Bude/CA3XIjp7KHXqCIeqmAabn6Vj3eLmPJHzohjrrKJwPXpZbStGULm+ha9SyqgFNy2UPbBBePTJWDJ388s+asrlzTHwC/mbTsEmcvn759ZfG+yvKKPhhsGzdD18ddfcWQA85ulLW4uNpM6O5ad/iwkQsNSeXgEy+QWtpQUHZo4k+zHI18mAVsWx52M1yRdw/SS+1BoY5pWLUIMTMWu30nZ4kt19KcV9vVon94eXVy3iJi+Pq/2hQ0qyb7PtafDkOhsJbG34c1pqhQso9E1gnlN5EUFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=EIX6B42mfFJvr1rkk8wCnNHKIlfxTrjE86h/QRBgSPZFivyoFhkjjzMWoW29BQz7ylojwnSg78dgCjcba3LNn8CNso+gOVbtkcedzEO66F7X89KOlyLKjKrgJe2tPJPBf55se3/aBLRU/bTZShfIwvWtPiOlfnY0iJntGpT1AC2TZr/K6eG1hwxxVRSAmyB2Fre6cPF/zVvjIWVgBN5a1N+oD9H16SB8pjlrNeiJGbpKB2s5ovilVrglpXc5knXNC164xpi8AYluhx1tY9pYvluzvz+8+lhsXzFAfRtmqhprtSF+r8EwM1QPq7K06yfBkfnEMuTTx7WKfYBZJMDx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=bmqzcmINN61umT4VEF8hfz+KQABULqoW5L7thdYprPlWGNtS8M3tnBWaqBsrYDQG7Zac6NCtCy+RXc+GOGVFmAWBzICjsB53cI0MDGnlw9EsJ2BK0XGZZ9SVoZasL8GC8peiyEJiVtO7OF2HScp4dPPd1hzLIkKjZnvbYjIjvUM=
Received: from CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::18)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 10:03:19 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::7d) by CH0P220CA0012.outlook.office365.com
 (2603:10b6:610:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:41 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:39 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 45/47] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Fri, 12 Sep 2025 12:00:54 +0200
Message-ID: <20250912100059.103997-46-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d42f6e-5295-4cbc-8a45-08ddf1e399d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t10GhxZ7gvCdOX/u9KfEYfj9LeKCQnS22kNls56sQvqcQOYxtlX8cr3algpf?=
 =?us-ascii?Q?bUWOENNpBu/8G5UxJrIEwOSg248LvWTAW0dqvooUbJRI2aHIpvQTzhAxGPpD?=
 =?us-ascii?Q?ecyv2u6dXa1xG23hl38N66akMQKM6oe6QZ0hi9mgfA8jrVTAxyDjfbIhgTt0?=
 =?us-ascii?Q?u1kiPkKY0VW/kzXMyhJw3oBsbRbsdbYkWkaOJC3eCV3NbEo2SFBCPc8YuxFZ?=
 =?us-ascii?Q?u2gCUt97wr9KcBB6PLWppHCyaM3pDfuaJ7KXoNsKfZP3h1tA+D+RK5q8E3bJ?=
 =?us-ascii?Q?mdB2JvyBep7mu8yQzbcjIuuSoC5OYpoZtnDNdcYdq6gq9eR4sUmGCWUoaB+a?=
 =?us-ascii?Q?CA7cDYSVzYSUv8NGYztr4745OVGnGgUzwhsTK4/UL8B7sepqGpyTtiaIjvhL?=
 =?us-ascii?Q?hULAXdQ0k6MyRzztERoJtjw+1gKSFizENkpSfuadXhk4XS0niLfrY8b6Xpv6?=
 =?us-ascii?Q?Vvo6Xc4KWtWymvXa9tG91ER8bFQjwnRLT9n5+nfxgx3mFH+brXgZIktJISsy?=
 =?us-ascii?Q?kfPCF2LbqaH5AtYWfttLSBeEEPsIKMPEpatL5bMkM1yPYqCuiVy7sUb1WFgO?=
 =?us-ascii?Q?ruXFFQkTf8i9Pcmz7D9+zWhHBkBfy+clBQnI9bwYqF6nhB9gIVrYVUVpwP8b?=
 =?us-ascii?Q?BW0MScEJEPE21mRACOph1fwiYXzjtnc7/ZOqfUzPo7KPMA9mIYppjcr6B+K9?=
 =?us-ascii?Q?p+dnxq9odkiza4ImzHcupVZZ5xg/c7mqD44JwQqH8+fBBEfTUIVS80LwTxrD?=
 =?us-ascii?Q?wzaTkeMr6VsdtgbUb0EOqwnmiTnCAJR4bR+tL2KYSS//v/rRDwH0jAf5hdFQ?=
 =?us-ascii?Q?XaEhT+sg/V2ANGBPNGTNXdljOZiTZkUFuZ+iJqIMsU3JrOHrt4z0FEWe1WgX?=
 =?us-ascii?Q?Ml10rnsMbimYTvyWfFekXfCEQI7NUoZ+D6kImYq4JwdpBrHIuuFcwfp+mSbh?=
 =?us-ascii?Q?78E7LJyLKUmi6zh5je99mmLvRn13YEeMjw/3UoaTu1zpOMFJ+RVpNlFMgZee?=
 =?us-ascii?Q?k2m3w9xmCWPvDwR+ARRa60p+/WQrQLFNAiHschdjuDLsydUtM54ztKXY+7hp?=
 =?us-ascii?Q?tzEFN9Uey5voPSAn0vfins6HpTRwt8hqQ3pTjvpNO3tda/Mo5wC9ZQz2cz5e?=
 =?us-ascii?Q?k2lhF96lfs/eO5XcK5ldSFOCwSLoFlRFMYy4aRCnPCEj5D5ynDx0C4F1aHH5?=
 =?us-ascii?Q?0TPKfTg/QCC5l4sG3gilr+APAbFiA7kidS8EzgVcJXafcYt8Qzl2OEHo1DvU?=
 =?us-ascii?Q?mcBdMauQVnCdWiwmfYGboXm5mPy6GP+/oPIt0lqG/QBib9+STk9fDYyolkFN?=
 =?us-ascii?Q?rLp8NOa+ET8jdk7lbMcV9D1AV3HZSZbhEdlXuql37nf2r+Q39h/zInbQgAnY?=
 =?us-ascii?Q?3NxOveG/8LzXoLDeonoVi85FNtF2QSwLvDOgGHhMbeX7GOc7ooQ4vhQp8zxP?=
 =?us-ascii?Q?jhDF9ikMiteatIZbpCGu+cgTRwd/GU4omzAI0y4EgpPACDNk5v2QwppI0z0Z?=
 =?us-ascii?Q?6B2j6AqnFWRdQbQ5c3CcGz/ky2bElJ14FlGF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:19.6332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d42f6e-5295-4cbc-8a45-08ddf1e399d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
Received-SPF: permerror client-ip=2a01:111:f403:2412::62f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Add a note in the DTB section explaining how to dump the generated DTB
using the dumpdtb machine option.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 94c8bacf61a..5d7fa18592b 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -63,11 +63,17 @@ Users can load firmware or boot-loaders with the ``-device loader`` options.
 
 When loading an OS, QEMU generates a DTB and selects an appropriate address
 where it gets loaded. This DTB will be passed to the kernel in register x0.
 
 If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
-for boot-loaders or firmware to pick it up.
+for boot-loaders or firmware to pick it up. To dump and observe the generated
+DTB, one can use the ``dumpdtb`` machine option:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M amd-versal-virt,dumpdtb=example.dtb -m 2G
+
 
 If users want to provide their own DTB, they can use the ``-dtb`` option.
 These DTBs will have their memory nodes modified to match QEMU's
 selected ram_size option before they get passed to the kernel or FW.
 
-- 
2.50.1


