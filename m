Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98778CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvJ-0006N6-MQ; Tue, 23 Jun 2026 03:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvH-0006Ls-GB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:55 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvF-0000iL-K7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF/r0u+059bad1Yz5dUMGOhb2ve/nEE/Zadnme5BtGRfq1oRALmnXqBBXmBFYXHLyDBIy2oQSwL5HKLtVwvePw1KJ1D72c/Uhn3nf2Zb22KUUeeJgGZ4VVPmnHJBQTGuqEQUu2yVZPoNsiNzud/ZZ7nW8k8wG4xGRVA/iI48HV9b/wZvgbrcjyNFS5Yr6qbF0+MxsF3tirbx7dt0gXri5NgNG9zkBJ4UAFkejTa14/Nf3r9gbaMmeOkb8bFFSmbWNPRic3+sKhvrQI3ojhHkmdOPLLE1T62eABXqGJYWblHvLDq95v3JVy63lF0Fa7YrHeILh7oFZIt/+AAWDMayUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKYEAMa8cYWWXqlG84PAdCOA+Bdi4JeFtZgyp0wZXeM=;
 b=u8ZXiFn6xm8RS0rK5mMj/64o9u5oufrpOgBq6MqsY2WxJXkv+IPZG0VxQ/rMJE3VEJ+4CzXF5InLy7TUNSqN3str5KHjPZ5u0dOA2o+Ljs/I0Euo4qFoiNNSueHHyIu4K+vj3meUSnfGykL4kARlRLJZ+I8ppSb7kyWWC7E2P7KOp3Cy/+sz76W23wATE4gcjL2YnG2DTL9YYNr5ciOPii2B+7ffnGrtHLRYbFAKJT5EtJxV/tD8UhyKhRHX/9Ptf02dAZ8HDYJ+P/v6D4p4szhsiMYmYnn+PP6JqZOL37duED97lQINN5J9AZ8QvQm2xzlsM6bhQ9CnhIL75TpIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKYEAMa8cYWWXqlG84PAdCOA+Bdi4JeFtZgyp0wZXeM=;
 b=S2xQNABVVfEGLR8JUiSkd8kqmKchvRnsGmm+KVTFq/Iag4WTcm6CgnkvUgv1bxTqqMlIr05Za+iIwfJTco8N8GRlVbP+1yaKetUKIjKMF+A62LutpHMW/HhlzSLmfLqguZuHEkyN4JYLd2aYrwsTeROjYJSmaurqNRNqj71W0Bw=
Received: from SJ0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:a03:39e::27)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 07:51:46 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::4b) by SJ0PR03CA0292.outlook.office365.com
 (2603:10b6:a03:39e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 07:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:46 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:43 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 07/10] tests/acpi: add bios-tables-test case for sp-mem
Date: Tue, 23 Jun 2026 15:50:48 +0800
Message-ID: <20260623075051.3797975-8-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bf975b-a4e4-45f7-e44c-08ded0fc465d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: +NADthi0WVY3t5GYBy67pAS+RLOAXW6bD6bcEIsT9cbdwHwA2PdYQhghMgu+JfzmF/gvx7OEwJAH5SbN5JOeYTUNuMnaWoktKJbIZng75w2VPNKgeLATUwSUfvcIEuoX5zmSaxDDNXwzDjDOuoShiKV0fwAWF5HK1LEfT8NLt0FkkJnmTHUb0oOgMLG5eQ1oMEJZyrqgsxw+uU/NBQ+A/kUMsT8ZhvqckcGeFHUeoEdn1cnMgj3c3xLBeojysfdye6Ka2YKxRbYlMICx+OzodBW9Q3SjRn9uTPH2bpWQMygd07kGhAcYIvjrQU7V17Ot0Ge9HNhjB2ML7qDsd5/Cp+HAXk6g6NZwsY8t6hO6n+WMTfI++QIYboV21gUYVSekI1SczQFUpxy7ybp8xkEEDf0HplCdUsaClD0TmRCdDOp/oOzdFpGdtRALEnusr1wp/iBHho4NCA7Ni61ybXOHK14y+WX/oO9CT8mbaqymzjKwsmjvbQFAAtWKNN4m/Br7hXV9SSMxEoWQfNM210IT8KE70NK6F3aZH23EmI1ozYz3q/TaNlt9xnHqtFOOO4DelQrJ/cG/99qoXNLkxADc4R5VZ0wib5dJg3yTQm3Oqv/UfObd0uxnSpH+T3kJEex+38yHiMneIukC+K8r9atlqX43JwkmWO95IIXzQWsGVs7L/g8jlb31NO3er83B5NzEjONGtZTpC4dYVFaWGMQYo+a9ELxuzhBUtZ//OurLm69fOEIKV/uZaWi0wSbvy4rg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BHV91XNlteaMOAd24S59TcQTxySaZcvUIZsjVcRuFT/u3f4gP/ybmli4x/4vOR6B0LkaXP+0u500GoIJn9EUIRvpVcVwz9BgM1a8lsuAM2T1qU7lzCP4vK8FR7nxR+emE2Nz55kh5VtyJNYeNQQZFOGlrOTyLQI+wyJF8fPBiZJREjGAgI+aEkFxpZCDqxY9E4W5Z7p4GZz1pDk+AxV00chfggLk3zURbWgY0/UYrCGMgrwWwmbxnSwt29r9hPQFfIJoPC02tkNLv7Kgy1EuAI7W0pZig7xGGxAotyOjsndjZeHNu6aOA241nS19sUS8N5e0TEtON+Vgsjub5cDW7MqOOF+C3qLQNRAc5PonYXEJ6lLjwGPGz7/Th7dRUC4qfHowpc4WcP/cGaex41l9YdOUB10NCpwqejRhwV1a8AW764qX69GQwMe2z7JS92/6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:46.2757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bf975b-a4e4-45f7-e44c-08ded0fc465d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Add a q35 bios-tables-test case that boots two sp-mem devices on
distinct NUMA nodes within the device_memory window, exercising the
per-kind SRAT partition (per-device ENABLED entries plus HOTPLUGGABLE
placeholders for the remaining sub-ranges).

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index af6d9b5136..45abd8bd8c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1416,6 +1416,26 @@ static void test_acpi_q35_tcg_numamem(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_sp_mem(void)
+{
+    test_data data = {};
+
+    data.machine = MACHINE_Q35;
+    data.arch    = "x86",
+    data.variant = ".spmem";
+    test_acpi_one(" -m 128M,slots=4,maxmem=1G"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,nodeid=0,memdev=ram0"
+                  " -numa node,nodeid=1"
+                  " -numa node,nodeid=2"
+                  " -object memory-backend-ram,id=spm0,size=128M"
+                  " -object memory-backend-ram,id=spm1,size=128M"
+                  " -device sp-mem,id=sp0,memdev=spm0,node=1"
+                  " -device sp-mem,id=sp1,memdev=spm1,node=2",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_kvm_xapic(void)
 {
     test_data data = {};
@@ -2807,6 +2827,7 @@ int main(int argc, char *argv[])
             if (strcmp(arch, "i386")) {
                 qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
                 qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+                qtest_add_func("acpi/q35/sp-mem", test_acpi_q35_tcg_sp_mem);
                 qtest_add_func("acpi/q35/acpihmat",
                                test_acpi_q35_tcg_acpi_hmat);
                 qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.34.1


