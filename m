Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCBC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHuBL-00082O-MG; Thu, 13 Jun 2024 19:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sHuBI-00081g-TN; Thu, 13 Jun 2024 19:48:37 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sHuBG-00058M-C5; Thu, 13 Jun 2024 19:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7LZsx0/XGltzxZqDI6MyYSdn982cp8VaKnKGXTaPTUsSkTcBmWvSU73dn7/Gz1iA9yb4jFJmUwHcVdK9gad0D8iRvh+o2uu4MC0LoZ4y6SmnovN0DNc9lrgzx++sso1iCnDDr70geBVXCcZ+fISbPC7TB/ABTvKxcvtNnzXmcqPRTLv+dWB6gBJtJGV8FAcLHVZiSyNxBRjn1U0PG/MEFbPDAmieaJQbC1uraoDvxo2n5XqAQ5Z8YTlz6ZH/z6gzc2fcOpbfJoQEMYNFASe4luPFCUtGdgburn+Z76D2PmUsEZuX2ScwxAVeCPaISqyaZTQW03ZRFW2HLm/VLMbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejjzgFlBtS5Xryo4wZz/3xDSXSs2vXyQIpD8CZb/pYM=;
 b=auTcFM1cPf8iUN8lx7wMGLZmNM0zcAOC8RHfItJGQKKevo+rOq4igymT6LEfXus+vuFW5G5/HQEgIKEM3jzOk9WhN2KR5ojWZLC7ilkDxBBOF2uUCMo1Wk/i+O82BV6G8dP9iK3yO2TFaGZ7U75IVA/5NZc0YukToL9qpgjP4+sOU01xihP4d/v7dCi5sY+ZlcrFeYH/VwYIgraC+Pn3JzpnZ0RsP+Y7WSYAnFZA8Lp6gZo3sMQ1/1fKrxlVR2Io3XmFaeWZcg4rrWkEzgONq6S94xpj6iYxd0YaRgo2GReXZ/Q0VY8qrc7bjcCxAnkUsxltuprDn54f6o4uHWnIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejjzgFlBtS5Xryo4wZz/3xDSXSs2vXyQIpD8CZb/pYM=;
 b=CphK42MLrhXjPp4GGRYddpluxCMDOP5gjH+ICvktIywGe46SvutIz1UP03vEAD4kzLf1zD8ozSU/pLXXo+hK8stiyAyRuo6h8yDv6RDwt4Ik72usp3vIDS4bujne1VrCQUu84fUB2ngELss23aAJmNr4N+HomsXeHJOYcbOVRsXiaLm9pKoaMgNe9m2aRhKwIkKaRdpKks8cor1P02dbhGeMHcZ/jCPvzVKUCtYADr8lIxp/GF2g0gogrAmeMg+G1AxcWLylsFzJDcgDs+9c8qDLbyN8fDajDVzgE0OuYYT1uztPYqMDS5wyC50IIOBkMhvdQ3M/5jbEWeVHCuSIDg==
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 23:48:27 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::c1) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 23:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 23:48:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 16:48:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 16:48:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Jun 2024 16:48:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH] hw/arm/virt-acpi-build: Fix IORT id_count
Date: Thu, 13 Jun 2024 16:48:02 -0700
Message-ID: <20240613234802.828265-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ce6589-39f7-4928-3bce-08dc8c035233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|1800799019|376009|82310400021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0NIfUZi3NakSoICHGfVSzsOGEhZfnD0H/J+zv9A50QIw77c7GzIZuR5YlrB4?=
 =?us-ascii?Q?rAsGB5sk5SePXyNcnwj1y2DMTmME568KdUS9tL9vTZ9xRzTsROWnj8kKdpHN?=
 =?us-ascii?Q?q19YfK1tbGe9MYijgEl7MmB6O+xBVPWI6HDA/4147frTM1MosEPEQod4U/rk?=
 =?us-ascii?Q?18SbJd+vYGqmnHVHzp9vAjlt2+mhye2UpzrdoMGnJR7h1CkooBnpnJfsHQtv?=
 =?us-ascii?Q?ZU+tCCH3aqKI1Pt1O45jdWjxZQ3uOH7rOPTB7MoYEkWdIdqdV/MHnmMOEqwW?=
 =?us-ascii?Q?7egf44Px4CJi7j9nwCIFMN6VTdzdcI4II1p9IlKvITSEA40Cj++WpW28k8qT?=
 =?us-ascii?Q?ge9ne1pjMBWA4jfe6cffqYocoBfDnLjn5IOIi3O46vzRVLwU8e2zzJ0QXUMn?=
 =?us-ascii?Q?ajTIwWU5EEQThu3N/rTxebvlIR7Zl3SGo7hkAHp+HYX3iono6K0J6APZeZP3?=
 =?us-ascii?Q?MMKc37NzW7MEGTdcy/P2ic0ot4hydHdy5YzIcw+Qo8mAlp+1tXwQ+fHeK39d?=
 =?us-ascii?Q?MOFogQRX+qyNf/P+TGSaMXn8s+4OmAI/Oik+QpChRsA9T6bfsOujmn1FA4RB?=
 =?us-ascii?Q?k7Bckzcvnli3qKgitmW7Chx4Vn0wYw9GeFC5Ud2WxBu2hbRVz9uwSh19B7o/?=
 =?us-ascii?Q?BfLNYGoJNYToal5i0fVckG29RFcZeJcJzu68ZhPyR6xpQ2wyEWAAjTvSRQyC?=
 =?us-ascii?Q?4jCsHakXXvmqIy/K4N4ky2jVXCLLaxmfOjVw62T0bywK2Zo8+6nol4yCl+J4?=
 =?us-ascii?Q?NfygZhDL1eTse0q86mAh4mXmVf8xKHnbAbgqG+1bg59upaXbFbeh48fayPeY?=
 =?us-ascii?Q?o5T6/q+58uGgfPPGOlsMmjXhVtxjo0IWJS8iQHeZhehU5paYPPdb01EhkqRX?=
 =?us-ascii?Q?ADnmST5Ol+Ie3LkiJ+zmQXNaIJtF6el6YD9doR3Oi0242sFqUlqylwGB8PCZ?=
 =?us-ascii?Q?+yNYj+9cU/12oR0QQpczaerdAQJgtJVpnkBYmTSmuhV87BsPDT0tqzCLD/xx?=
 =?us-ascii?Q?gFLVa252NlvEgmJP/y3jsY6+1NK2oMdDlHYmNDZNN5TUI9w12pyaBQibYeZn?=
 =?us-ascii?Q?FpeRw1Hq2/PDKyahs+BddXKcpxt9poqv1yvbnT3cxipPPZqEQcxo0iERee7K?=
 =?us-ascii?Q?OgBBd7qXLtYhLtoN9mTI+uBzbHm3zHmUf5HPvhgj4hlGB2ZK0arrkj5emG2o?=
 =?us-ascii?Q?PDVSqbSwGdLq3mab/Fc2KhnbNC+25g31507rhmVMPAMldDiPK4QiHovpm6QO?=
 =?us-ascii?Q?2cg59yuMpxMH5lYYXsPZGizo+2f0BYk2dkjpkGLeRr+CO7crg8CGraWJ2ZVo?=
 =?us-ascii?Q?DqgUPZubSV2lVEJvLFJOtOx30CzAir7zChXCUwOE0k0gq/rug5XRUmC52BwD?=
 =?us-ascii?Q?pZSWEG9znx9D2V6Y+0dhVvMNEqRu8ep02QB1BcSigME/Ix56cQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230035)(36860700008)(1800799019)(376009)(82310400021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:48:26.9303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ce6589-39f7-4928-3bce-08dc8c035233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
to be "the number of IDs in the range minus one". Otherwise, Linux kernel
reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.

Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026..b9343dde0f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -243,7 +243,8 @@ iort_host_bridges(Object *obj, void *opaque)
 
             AcpiIortIdMapping idmap = {
                 .input_base = min_bus << 8,
-                .id_count = (max_bus - min_bus + 1) << 8,
+                /* id_count is the number of IDs in the range minus one */
+                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
             };
             g_array_append_val(idmap_blob, idmap);
         }
@@ -298,7 +299,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
 
             if (next_range.input_base < idmap->input_base) {
+                /* id_count is the number of IDs in the range minus one */
                 next_range.id_count = idmap->input_base - next_range.input_base;
+                next_range.id_count -= 1;
                 g_array_append_val(its_idmaps, next_range);
             }
 
-- 
2.43.0


