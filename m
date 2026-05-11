Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A531CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPyj-0005n1-6G; Mon, 11 May 2026 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPyh-0005k3-Pp
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:43:19 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPyf-0005QJ-Jj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:43:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN7KeHb292550mW0nDdMGgQXgmXL/y0A1XA3GWHmBZCZH9/qYxsrJE3KqdN9/8rivh5htc6fUYuS0sqecAbcLxDw/yZvu/VN83sQgcNKeAyMXyeeeTHA8dNZgRwXL4IIMFe8b2WnXr3PFJ0/QkTFKCHBlifjOrGOXAMO5Fbsgx+VUG4kKuDgru+cv6h+40GgFh3IvkXh1F6eB5WNfiSAou1l7pHJ0jK6ubkL/jre1hsI1Z495eIIbEBN90/w2LY4wo6e9f9IaRWBwLqO5f38N7vOfqbcW9t3CbthDZ7e1/GVoK4+NxKmURGsgfgzk421BVzhIPUdzC03yf5v2dyEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmS0cs095RwYLkrbQXHVxVIKCxuZzOpzOXjLu0jY4aI=;
 b=QqWqRVyI1T3ur+mw90kSlAMf9CTtTzj+jK4Kezq0xGzWWDzjHxfSh+6B7asU/rgsYuJrR/7EBog3YD8TEp8QiYc0XnbfeMP3eS5dhvqsx9cjWLE7s/NQeafPea4soqvzTtQ9Yt4TvxbK66UxOQSX30+0G2vM+MNSshFaBRMMZ79bulus47zqUiDtIX+yCn15V3v6NAvVcdJDYlZ9Xr0fCS20y2yECt1zm5fAFyHo4eFCiovv1DhVh0Msb14n5O3BpMYAwes/xBPhS0CW2VOuf43MVSy67jATlrPlN8TUIYgRtw5X42wIDaEfw1iLz5WRnn4aYXDKb8m5Nq+qiSp8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmS0cs095RwYLkrbQXHVxVIKCxuZzOpzOXjLu0jY4aI=;
 b=bu+InhFAQpI0CoHz9l8L1ZyBRp1UhR4gvIMBpGgKoIKq/id4HxOnAOmnUnnjzmIui2tdVaskv1PwkTFD/WZyFzbALGPhwjNRLWFeLsU4wVTpt7MRw8jfTRuAe0plzGRj2fWihQqp8yHIbvlBtnq2ysBHsu3Biqn1n6qBc9hSFCE=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:43:11 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::66) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 12:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:43:11 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:43:06 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 8/8] tests/acpi: x86: update golden masters for IVRS
Date: Mon, 11 May 2026 18:09:37 +0530
Message-ID: <20260511123937.32743-9-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511123937.32743-1-sarunkod@amd.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|IA4PR12MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: 077b1071-d12a-48be-4044-08deaf5adc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ed8NFZ3Bck/FZKPtKZqkjCqlWtWgB+hL8z5YxIIe5tfNwhOzls55zom63paEUN1nCFkjHJEKxFr+0eesHZfg+W5oTDD8BOgWFjokxD0J8KIIjX3MtGavxHwzas21YSOM3Zaga6r3Rp1X5HxbPA1SU9DfmPgsWTBW/SOf3c2V7lUUlZXgS47BgLgXR8QvGcpAz0qrFeW2fsvpG7oQQCbiE9pOC6mISIDfYNjMhrNhVcJbhXKBefbvmTNAH4xNcEccap/j56yH2Yt3yGfCLrfsq3mWRbqadw1XnfdTRjp10aI2KJ5T++edKMr0KSwL31QZA3dHHpgWjx3/bKbQNq2xudjhWBvEypRbHPJjfmXCP3K/j0vJvcAEjKKShLli0vArqyslGv/YDc4w2O4XPC5IrYvjXsAgCuoiBgh1rAs5c3xOS15oUbru30YMljL7MJC0OA9aYvCo0OANs+f8vtidFp7X7hhagarA/lTCoY376OJ/aUwPTIzPDXT7BoS7wZFgulsX2mUj/2BrNMz32GbTQINnMWi40/h4jALjjsDvDQLps05x+FF/74XRRQBzkJyqlduTndl690wmRY4LPwxZnFLf0HFsDww6GgrA+jbJiLI3zQHDAsTp2n3XzLzuTKVfnztMo8TiPL8Xh9Uwm5iEC7OMq0Nf6G2gPQ62SiA8J4S7hU6gUQBxnji9cg4juReV3Q4GZ24y6LUmBqzXnS5BlvW3v+KF9s7Xel6aLdRjiR9K8oXGQYActtw1GryJa5St60OvdMmSNfCX7x5Uatu1Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lAInZlaT9P7vP1AjsQW6o/Njub0QwJgnsBpKKHGOBfCGST94aW6nGGagQittqceWBuvC4R9M8bH0xuzpOTMPqprQ2X51ydsXqIq07/O0Dr0t6C+ctvriBLsNBhqzqM6w69ODlrNukbB5R4+2RZP/vc9ff5QBHq+RyGYBrDfmcCKX18/EbTO+R2KOoCO/h3fPLlzgA08P4VDujeAAdjmSq7gOCJzyLXnTzz+GbhVJfwF4934mnRtQ2QQ59+DAJR1i/84Zsuo3OVcGv9eunQGwhOhed53RQWRz77Iude3nDZ6F1j1aY3XZPUmTpq8oxqgoNUkYj9Awq9spozRc6MP7lRLAaOPiRKC2ZBbMKLc3bxS6va1k/GB8O7TCXqAUI8mUn5Dc2dwC43/TqT0uxFAZLbrNiwCWAgc8qj1hAfOYEHVjVXKWrIxaYRqcuuki+uEX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:43:11.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077b1071-d12a-48be-4044-08deaf5adc58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Sairaj.K@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Differences between disassembled ASL files for IVRS:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/x86/q35/IVRS.ivrs, Mon May 11 11:21:47 2026
+ * Disassembly of /tmp/aml-NGQ9O3, Mon May 11 11:21:47 2026
  *
  * ACPI Data Table [IVRS]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "IVRS"    [I/O Virtualization Reporting Structure]
 [004h 0004   4]                 Table Length : 000000B0
 [008h 0008   1]                     Revision : 01
-[009h 0009   1]                     Checksum : 74
+[009h 0009   1]                     Checksum : 68
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   4]          Virtualization Info : 00002801
+[024h 0036   4]          Virtualization Info : 00203441
 [028h 0040   8]                     Reserved : 0000000000000000

 [030h 0048   1]                Subtable Type : 10 [Hardware Definition Block]
 [031h 0049   1]                        Flags : D1
 [032h 0050   2]                       Length : 0038
 [034h 0052   2]                     DeviceId : 0010

 [036h 0054   2]            Capability Offset : 0040
 [038h 0056   8]                 Base Address : 00000000FED80000
 [040h 0064   2]            PCI Segment Group : 0000
 [042h 0066   2]          Virtualization Info : 0000
-[044h 0068   4]            Feature Reporting : 00000044
+[044h 0068   4]            Feature Reporting : A0000044

 [048h 0072   1]                   Entry Type : 02
 [049h 0073   2]                    Device ID : 0000
 [04Bh 0075   1]                 Data Setting : 00

 [04Ch 0076   1]                   Entry Type : 02
 [04Dh 0077   2]                    Device ID : 0008
 [04Fh 0079   1]                 Data Setting : 00

 [050h 0080   1]                   Entry Type : 02
 [051h 0081   2]                    Device ID : 0010
 [053h 0083   1]                 Data Setting : 00

 [054h 0084   1]                   Entry Type : 02
 [055h 0085   2]                    Device ID : 00F8
 [057h 0087   1]                 Data Setting : 00
@@ -98,27 +98,27 @@
 [0A1h 0161   2]                    Device ID : 00FA
 [0A3h 0163   1]                 Data Setting : 00

 [0A4h 0164   1]                   Entry Type : 02
 [0A5h 0165   2]                    Device ID : 00FB
 [0A7h 0167   1]                 Data Setting : 00

 [0A8h 0168   1]                   Entry Type : 48
 [0A9h 0169   2]                    Device ID : 0000
 [0ABh 0171   1]                 Data Setting : 00
 [0ACh 0172   1]                       Handle : 00
 [0ADh 0173   2]        Source Used Device ID : 00A0
 [0AFh 0175   1]                      Variety : 01

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 33e998165591..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-tests/data/acpi/x86/q35/IVRS.ivrs
-- 
2.34.1


