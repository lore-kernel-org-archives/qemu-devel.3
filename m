Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF61C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1gD-0001OP-L3; Wed, 19 Jun 2024 16:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sK1gA-0001Nx-Vc; Wed, 19 Jun 2024 16:13:15 -0400
Received: from mail-sn1nam02on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::610]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sK1g7-00018t-UK; Wed, 19 Jun 2024 16:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfA291dvXFW5i5186SfBRBiuzWS8fZNboXz9kls8OlADzNES2Mt3mzP+JD3VcH8FttfBjErP30IDOr1OfNGC7A0o9W7GWm5gEJlvPXXz0g7L1U6uP4vBzivouPxN/dwSWV3yo5rasE72k6u6zcqmy0C35hh1shTpH6Vl9VuNLrXBDytjy6fhPJYWL3scoobGf6khPJsXrWJcboa6lRcVOvJ0IUWrPSgQUiGQpEybxkfivHGHlGPSPe9NxhZOpcKpWtTZOEh8VhvEKVGg3G4mXNFhjNWq2bNUP2X6LGnpxWivGjyz39uFWakRt8pDAkieXQJuZHAGHqauujRXNPhfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFwxqNBfIzKguoiOu6s7wBkxaBzEBSWcq7N4bQUURVI=;
 b=RAwxoM5B+ppv6ZzR2f0lv161mmCoOhFNQivjV6gQKk0EUFObGoB//JIjMy1qVlmAEN5pkPflNK1JPYwuBBV2F701xbE3beqSmIKyydnlojahviLjSD6zcPBayVQosrmKOqmOiBXoVDJKbLIiIz2icxPoQAjR/nojvXCgJkm0h9OKZBBEs2AdPW5txR8D7SYGDpoyHBBPMgH9ZIsRozQwJjxNX2+5CfWDZrTrx4P3LfbFUzAu1hi17cU8Mz1iyX8Li1fMkMiKiRuMeXRsTYxd8tsP9l8S8kIcpG2nDqcPUXJ4vTZAUUDvGCmh1GOIIORjZlS/Zxx9D3dsr8VqZHK4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFwxqNBfIzKguoiOu6s7wBkxaBzEBSWcq7N4bQUURVI=;
 b=UGg5+tIAbvPlPBRx/Vkz0XmxoWPox5eiNBXGCesnMs8i8rPfn+ie6Y9YtG2copZ1c/C0HQOMihI26/eW4TFY1iHT2ig7kUM+APwqL18Fg1Gpm8wJsvbkSpN8TTiw7F7enQdGXf3RgK8qZkCrkpSLGsp6shGCVwbf9Dj8hA1EaxJ/6VtFbrFcCf3apc4s1sMUj4aajzk7qNdZmBIGZ7L6VqH1AdZAf1k1Pd/HfFCpBIMmoDAluqn+7U+AYVKLlVROu7gBh6iSovuCa+Tw3JA9r1LP9sS0SXpqSGY5Ta0xa+hgnuZHZu5EitK6KMtur0NV8onjREbPRh2LFpKAauuBhw==
Received: from BYAPR08CA0030.namprd08.prod.outlook.com (2603:10b6:a03:100::43)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 20:13:02 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::ff) by BYAPR08CA0030.outlook.office365.com
 (2603:10b6:a03:100::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 20:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 20:13:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 13:12:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 13:12:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 13:12:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>
Subject: [PATCH v4] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Date: Wed, 19 Jun 2024 13:12:43 -0700
Message-ID: <20240619201243.936819-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4f1075-e56c-40a8-6aed-08dc909c38b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Bu2VfdPTVMlEonpi7AeBUmz71e7j/QLZDa3woZLP6LInCB8Uw0/LI2iHTJq?=
 =?us-ascii?Q?CYUI08lM39oLj0uh+JMBGNyH/z0KxT4fFOhkdL3WwUFXhJQzwBENi4v3epsK?=
 =?us-ascii?Q?SKxIZw9Fta/HIGZwkCBcSJ8QPwkJqH1VO3jxxAp7UwxpCwkG/o3q893uhY5I?=
 =?us-ascii?Q?Jy0VBwpanNinGoNG3ERnfLD0ZNPns287/x9ypDo9/zuhu3ceaJOHZPJ8v4y6?=
 =?us-ascii?Q?8Wjyj+i7slJYquNxKROFvFnp/WZAxdofAbt5aMIXyBZI5ZcUoYVcUrxjnVZb?=
 =?us-ascii?Q?9F0GDmBs6lFQJkNLzfgxmat1iB8XzAWqEehAjxEPT5xoJ0O05XvnNiCQ24/p?=
 =?us-ascii?Q?45jLV6CnVUJ4IwX54JiqzIEOWuYon3kZqmtE1w60ARchvpN7Kq7W7ytyayex?=
 =?us-ascii?Q?PTFOP5r9x+3Dc0CO3lnkzHROX16KdxYfhojlR6PLiAHD1ptsABZWPR1SpRCl?=
 =?us-ascii?Q?+Xh47NcyVrMQHBrNY3aGRHng0wXSXQpvDcCU0Om3FeCcnJxF5Q4441acDQLb?=
 =?us-ascii?Q?j6zQ7gZAex3XlFk9KU1fwsCCYinUPbTn8HkunZVj6T1XpRNjfjFuHD+cHAvD?=
 =?us-ascii?Q?KzZYLdJVMqqVxjM3J8BVHm3OhW1+06VFSR5rnCRdTvc1GK9QEl/Cql2MEJXG?=
 =?us-ascii?Q?miSQUH0C3i4WU6KeLKbgh+VAA7JR5QRd05LwMs/owmZg7ylwj0NqI5ctC/lq?=
 =?us-ascii?Q?cia6cIzQNDKTsUplT4aajLqZbuzIPRMCSVItxLus94I5gMLuaBuXMU73/KQj?=
 =?us-ascii?Q?7CpriV7KiokFN9gXiqStVNqJ6TxGpBlJsfyZxZUKGAslntjsAK0O7eL0415W?=
 =?us-ascii?Q?G+fNO+WmMURLO1lRMfoBB/FcnimDBKP6rDCUqojjU0bfpMFA9mhM6e0Z010m?=
 =?us-ascii?Q?LJ6sdlOepjoigQxpbhHiruKwPKxDJdeOjocFFk1LyG5iaBmetuQP6/QtUiNl?=
 =?us-ascii?Q?j3ZJOp1xQfPdD5gobr2tvVWv3JX75MyZzZDzJoTGEbsuXilxIu6BkzWpXdzD?=
 =?us-ascii?Q?U2JTwZ3NcHtgTpM2ZT5OIyH5ssnSVWFJ7PVsI4GaODTmGtszky7HxjyJgvYv?=
 =?us-ascii?Q?OlRiDom1c4V7mVByW1lserqs5H/X33iCel+CSFQ/r/TqPsto2NcZaTNy4bsW?=
 =?us-ascii?Q?NLYhH7Ss7+5Pb51L8zDaEZdPRS45t1UPO+G+szNk2bZA/03e4ISZyY/BVEN4?=
 =?us-ascii?Q?b6qFPHRMSQlod54x9tXd9cBvjVQyazhgrRWIRbOUc4ew6hQIfO5J8JytN1oP?=
 =?us-ascii?Q?CEJlC9IziQa9UBkMBJfKL5b8E+zeWq8muhnY966vG7OxZmoge6Afy3Cr9dMk?=
 =?us-ascii?Q?xjPEZQ7Wv4RdWNBVQGWLtifc6+Dt7HkQGYBd1WvqUNvneD20Ys3JjZhMUTgO?=
 =?us-ascii?Q?uh3mJmzdNlg3IBf4vGFsg7LO8u65DC9CNvhA0Sj8Hfpadf/Ar6piiuE++7c8?=
 =?us-ascii?Q?+1NiowTzrpY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:13:01.9279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4f1075-e56c-40a8-6aed-08dc909c38b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::610;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

It's observed that Linux kernel booting with the VM reports a "conflicting
mapping for input ID" FW_BUG.

The IORT doc defines "Number of IDs" to be "the number of IDs in the range
minus one", while virt-acpi-build.c simply stores the number of IDs in the
id_count without the "minus one". Meanwhile, some of the callers pass in a
0xFFFF following the spec. So, this is a mismatch between the function and
its callers.

Fix build_iort_id_mapping() by internally subtracting one from the pass-in
@id_count. Accordingly make sure that all existing callers pass in a value
without the "minus one", i.e. change all 0xFFFFs to 0x10000s.

Also, add a few lines of comments to highlight this change along with the
referencing document for this build_iort_id_mapping().

Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v4:
 * Rephrased the function documentation and used the latest IORT spec ver.
 * Added "Reviewed-by" from Eric
v3:
 https://lore.kernel.org/all/20240618211110.922809-1-nicolinc@nvidia.com/
 * Added "-1" internally in build_iort_id_mapping() instead
 * Added comments to highlight this and referencing doc
v2:
 https://lore.kernel.org/all/20240617223945.906996-1-nicolinc@nvidia.com/
 * Moved "-1" to the same line of id_count calculation
 * Added "+1" to the next_range.input_base calculation
v1:
 https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/

 hw/arm/virt-acpi-build.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026..60a79b91ca 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -209,12 +209,19 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+/*
+ * Append an ID mapping entry as described by "Table 4 ID mapping format" in
+ * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
+ * Document number: ARM DEN 0049E.f, Apr 2024
+ *
+ * Note that @id_count gets internally subtracted by one, following the spec.
+ */
 static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
                                   uint32_t id_count, uint32_t out_ref)
 {
-    /* Table 4 ID mapping format */
     build_append_int_noprefix(table_data, input_base, 4); /* Input base */
-    build_append_int_noprefix(table_data, id_count, 4); /* Number of IDs */
+    /* Number of IDs - The number of IDs in the range minus one */
+    build_append_int_noprefix(table_data, id_count - 1, 4);
     build_append_int_noprefix(table_data, input_base, 4); /* Output base */
     build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
     /* Flags */
@@ -306,8 +313,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
 
         /* Append the last RC -> ITS ID mapping */
-        if (next_range.input_base < 0xFFFF) {
-            next_range.id_count = 0xFFFF - next_range.input_base;
+        if (next_range.input_base < 0x10000) {
+            next_range.id_count = 0x10000 - next_range.input_base;
             g_array_append_val(its_idmaps, next_range);
         }
 
@@ -366,7 +373,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4);
 
         /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
     /* Table 17 Root Complex Node */
@@ -419,7 +426,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     } else {
         /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
     acpi_table_end(linker, &table);
-- 
2.43.0


