Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E202C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDuU-0006mH-H8; Fri, 07 Aug 2026 02:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDuR-0006kK-Lg
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:18:23 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDuP-0002gC-Dv
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR1w4f0JuwP46n5c6tBUE2pflPQkz69w5ye9iB3vPw5EwRA2L9oqS+Cfz1BVNkF4F7HNzAXRyGExW+QtZ0jvUrUnyhYLZeKoCrZU++ZDYSjzcdXkAnwv2/+mSQKuYRYYwbijQtIYTXRanHynmMgcoTkeZVokx8sfg88Kt6hTS434Xd3OxPJg+X19Fn6FYTIneYLOTwXm79iE9ndwY3S7c0Puu50a5M13lQB0vcB0l1WwOVS+xuQgYaJZ29UMK+l9zrBRkyrlw78NQxTmkK6fj9RkvtU1aSZGd/9Bvtv64wVyzKBX2pxNjOJzF2npvglYXf3IkS5EQVZhqsJSlr9D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj1y8q3EPZQ9AFSCIBsGZmPoe/su1A3KaN+AdCW6EaU=;
 b=fT++QsdWpjvPn/ys65D3kWR0YwTvWk3IzDU8x9wj++sreEFpysiPtbu80PyJc3/hThBKKl4BoKwJ00KhplB8z2cUcHYNT5ebyRwqUm6bU9dLGDHovYru7hsH3CdxcFzc+vCcEnPQLvX+QUmicmlsR9cy/YePIUwqbqZAV30Eo14QVkdjXfZUU1fSlYE0CsvmnZLPd68NxQqSxmNIQsfvoyJoSG+kRAW4sXcoQQ+1Zuv4eSBujZsgzMucFZ/FjZjzsGeuHcWXI2mnzh/2wF9jZ1NvcCPSZjobQWc6iDUWn6gGvBnF44CyAuYfeWXSa1l0JHOUhw0VASLafHJh8zq0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj1y8q3EPZQ9AFSCIBsGZmPoe/su1A3KaN+AdCW6EaU=;
 b=uAzpaEFqXKCAbpFlEKvbx75XJGChz62WhMncLRr9K4MD146Wt63gpek/NqkeBqACbnAowk5+/q+LP8GmS5o637dAeAtOyHyD4blvZwDUuj4tdggKIsmzE50W7cmwH8srBHRJPxSNXazcUjjMppW6D22a06FWulRJlKAmhgkN0QI=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:18:14 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a8) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Fri, 7
 Aug 2026 06:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:18:14 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:18:10 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 7/7] tests/acpi: x86: update golden masters for IVRS
Date: Fri, 7 Aug 2026 11:42:50 +0530
Message-ID: <20260807061250.27739-8-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807061250.27739-1-sarunkod@amd.com>
References: <20260807061250.27739-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: aad6c485-79e1-4bdd-7920-08def44ba9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kw1AFpwdmw29IHGVbGKR2e+uPDOnRn7+0p98j/zUJKM9HE9TErFd5a/Zm4BT13Ji5ZHUfzhYwXhyOvJ2p6T+DGkpvpMNcgVUE4gDKky9+L6ZzYU0PsEZ0ubopYjZUVlBxp9kIGGX+P1O47ZWb8Ez9ch+UUgMdbNxLePM3y2hridCF5WQekuxA6vnz59NEJLl9SLRsDTcgx9bGBYTbEJGUBQwCxldMeKe9YaHpJv6vE7RfQpHbhi258b5bu12pUI7xOxXlYlC70k7BnNNRnCGJMA6QAOxfILMPFiOJRFTcua2bRGSdGIdmJDRN0ZSnYl2moJJuOhFgaSB82PvAh8pqgm9Sc69hDtXc7NEImeF+22KupfoDMn0Iip5Bb/j61MwnpXBz4z9oBxmCJgQCauVD5LhDx7Y+d+w6X5oCH2M1elq6VJqN7WCZChqWsLO1B0UrReEA939FBmrQDr9P8Cp1PevF/3/EYAyGpo4z/eYod6wO4UwDEuSH8v3gvd22ZXAx9Zj/CzzT/kCVrWbZIYgLtGgXalGmAVUl4vlpf9IlXq4MHTnZYNx1cBxjAkLEBFOW71a6i2eIGyHj63/lPdqH6XXo9kWz+BJbzpxyWwZ4cZL6tNHpV2iqOea6w0oXahX9rsfJzZ0GxlMgsdtfF6/OXz8ygmmGYZYXRB333i/VZTHaqlDgtmxxf0zLMxQFr+j0vpRjBojInGZ+sbO9F1Www==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PfWXWIX9YnGDF3CbX8vhHAkUIkvLmqaBTNoeNb7RsIzfFaCA2IZnSvrDp8G2rF70XEuGTzA+oUsw24MBA/PSmN+t7hr8iBScHiKSXbLjR8BIfLQbcRi3PMDQeA6+Ucnxi0g6Q1hg3wjIIIPdDNPQkD2IpuGgsqIzVTD0LIWUvie6B4nqr9JsShwrfTdeK7VMkJ0ZFcMoaonmolor1v40Lo7LRhWrxyav1vEfoZgmK8pBAUvPmQx0gzVni7rl2wWCydr2PfnNY03I2q6q7U3ES4iss4weqapoAszXxXAQOs+ZsJjz1+r3m4vuieYO7bDL3AiZhPEQn2Xm3wTkn7N8/GAUlyTZtFVyU7oE/MSwD1Ia0/7UCfGVPAXPsLJQV2hcgzSyoNRSIzNq+hkSlxiPakkCJdiSqSQFEKyZcoAHTrHfwz0rFqzMIlMvvYfYqhJD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:18:14.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad6c485-79e1-4bdd-7920-08def44ba9e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Sairaj.K@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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
+[009h 0009   1]                     Checksum : CB
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   4]          Virtualization Info : 00002801
+[024h 0036   4]          Virtualization Info : 00203441
 [028h 0040   8]                     Reserved : 0000000000000000

 [030h 0048   1]                Subtable Type : 10 [Hardware Definition Block]
-[031h 0049   1]                        Flags : D1
+[031h 0049   1]                        Flags : 51
 [032h 0050   2]                       Length : 0038
 [034h 0052   2]                     DeviceId : 0010

 [036h 0054   2]            Capability Offset : 0040
 [038h 0056   8]                 Base Address : 00000000FED80000
 [040h 0064   2]            PCI Segment Group : 0000
 [042h 0066   2]          Virtualization Info : 0000
-[044h 0068   4]            Feature Reporting : 00000044
+[044h 0068   4]            Feature Reporting : A0000064

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
@@ -62,33 +62,33 @@
 [061h 0097   2]                    Device ID : 0000
 [063h 0099   1]                 Data Setting : 00
 [064h 0100   1]                       Handle : 00
 [065h 0101   2]        Source Used Device ID : 00A0
 [067h 0103   1]                      Variety : 01

 [068h 0104   1]                Subtable Type : 11 [Hardware Definition Block]
 [069h 0105   1]                        Flags : 11
 [06Ah 0106   2]                       Length : 0048
 [06Ch 0108   2]                     DeviceId : 0010

 [06Eh 0110   2]            Capability Offset : 0040
 [070h 0112   8]                 Base Address : 00000000FED80000
 [078h 0120   2]            PCI Segment Group : 0000
 [07Ah 0122   2]          Virtualization Info : 0000
 [07Ch 0124   4]                   Attributes : 00000000
-[080h 0128   8]                    EFR Image : 00000000000029D3
+[080h 0128   8]                    EFR Image : 00000000000028D1
 [088h 0136   8]                     Reserved : 0000000000000000

 [090h 0144   1]                   Entry Type : 02
 [091h 0145   2]                    Device ID : 0000
 [093h 0147   1]                 Data Setting : 00

 [094h 0148   1]                   Entry Type : 02
 [095h 0149   2]                    Device ID : 0008
 [097h 0151   1]                 Data Setting : 00

 [098h 0152   1]                   Entry Type : 02
 [099h 0153   2]                    Device ID : 0010
 [09Bh 0155   1]                 Data Setting : 00

 [09Ch 0156   1]                   Entry Type : 02
 [09Dh 0157   2]                    Device ID : 00F8
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


