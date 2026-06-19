Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E875BCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX96-0004oA-Q1; Fri, 19 Jun 2026 07:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX94-0004ny-Q8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:22 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX93-0001tU-3B
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN0VYm/aNzkLL0gwOAHb4wHPvtI1duWbkzrghtinDbCNAxXvvFMDUWCzXpGhbhmWg6mqPJAhAmaS5ShLPqZDZGyk8xx2ouQHGGo2Y17yTSMgKCAtxkxf/exNCjl4ytXRyYVkLWZhoSDVp45viNjuwI4DZ3Ng5M7rUxKkukW73n2jLaA52r9RwqtSj8dilAJ7q6LXVSy/SAY82X51/OdU5DSWnJy+/JBIZMRZDeiYNuMXdwMrbMHW00AHkP3P6K0tLrWyVuvQMNfOMcrMJtHEmJqT//rV1x8Lb+nsZh7wOTIpkTNn5LbS8x7UGfSCa1bvFPKI7EAZVyR8P6kePL3riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6XLjWYqyZDpudueIqtegyHqloeqxLiHIe7KdbzTBTI=;
 b=wax8ynUp7XxxAJL2jXKN+UWdw1ZW3woFrsjVGLUQBMaWTMDL0PfnO6ONYDN25vYtRvtiot0I7VyEcFJM9vzuz8x9ZeNOZEB4GyI0vzx6JvFWYsMyBmxUdSgqyn7HrTQcjrFvDDrjA+YmQ1keDuvjdb8gt+aTsnUIpBJvu3F6ztVpxx++cjxa1x1+S3lU2b3PAZz/F1aGjIHzeZvDsd4cGlKofyOepyf2HRlW7g2e7Wm8+zX05aYZzDItuX32lWWNT/1Pl18VeoJ5VyDq14xsK+pWSNreYOJ28gRqvnyYQ0r8J2JDtn774tSEvTuuV+7m+ZmKmSElWi61zP+F7D8KPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6XLjWYqyZDpudueIqtegyHqloeqxLiHIe7KdbzTBTI=;
 b=5LbjK7+lv+Qp+S2bf+zRnWV7tPsDDjTF9ciujo1mGSzjqlk8p8tvwcdVaHiPAnhBsGUg5QcJiYqOcTNDl4Aepdkjvu6mW06QEUxCixZt2XSaQJeKBuN4OuzormDZdy1GqzLmpVs9eB6HusSVUHUsfKOoOJvl/IJcH2aXFuiAoUk=
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 11:12:14 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::86) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 11:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:14 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:11 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 07/10] tests/acpi: add bios-tables-test case for sp-mem
Date: Fri, 19 Jun 2026 19:11:33 +0800
Message-ID: <20260619111136.3481329-8-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: 38949f9e-51bd-437b-0b51-08decdf39e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: pOezvxMf5KxuUDFxOV9ntcl6gcOjCwjtYoASSHqMZdl/mYBOfmOLQXHUiHCTC1bDsNwPU65d7nBw03gRwXs0uDswLnFLFiXp5sV91QE07qkiz1IX+bi1GRqlsXnG+EZ1Bgm587Efd785FTJ8gEVvMrbsOrn5aO6WoHMmB8o+vb3id5rv/aD15NbUMYkcXbvr5TszTCSEmOomDaoSe/BsUuon7l9Zri41Mm3AcVOez51JLDaM3dcI+2bbjH8kUrhYOQTWDeNOcAm9Hf8REIbixzuxNy+NtlXROK7JGPNe7vaDaW4DSBPJVQ03KhorDT9hv1w1jJDnbR8FHs4Un12VQCSSLEdqNU0NPm3zdHoc6SI+73YmCPWUdl9CL2EdE49gyzhLQ1TgTS3z94fPEajMRrwRqgkSUl8g24sMIEizBPKRFRDdyf0vrROPpuLhtuJwqlgcyxEhuL/4NpWuYt1KfgZTnqs/XWlTlelvukIe4jKrXxbNXWUtBWn/GUTNNVa5B/OnAh9FXmdeipSjT47DiC1tBM2xLT73Lf2qzrdAXGAWQq2cHaeG0GFYr7CNNXYJ/4pTCmprq954Xt7FN8DIfy0zcbd811BTF6paOW5XYctGHtCnZkTIMG8yN1nVQ6VjN0AaEC6l1kwHM3YT+nlAMoJMV1LW1fDfzM+jl+PmEbs5QVCFnXnhMbm8tk/Sl2q3/UynGmjwjcSOqx+TwgXK6Vel6Bw40OHapDK+3owPmyOHZBkjzlggNhOCyKfESPcl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pit2hG2+Z0AqQclfIBuTW4A/swNYSRzl+3OiH8Hd1R7CV/rjTwvsIKIkzOAw5Ly49DIf9p+1PlOXAJ9FIwrRi9TUzuD1uZ+X3y3LS0DV6/HrU+CjGYRrcefqUMkYezbH512Ficlqv5fzCMuL43+FNGGUjoCcC9cdDhZU+sueB7cKbuc2Epw6Chb8pBjjnqCnZfgyMJp8E9ZmsJ7eNTC2SIiTSf0pDAy9LfVgQxpgvZUnYgbmVXQi0BoDyMrc1ObQWgSOeKi236+7wsHU1Elf64y23eF+ULxXwxMLjv9A/OedOwOdO0zPCq0y7T107zUCKnSQNJBYZQnVytDpVtpWxM5Jgwt6y/+wTczpIlWiCo3kduEOtejQsR9iZt5Gcut4w98DQBawoW2D+bCGH+vDxdXXoxT8rx2Eck5g6ekk0jlF51hUMJHgJlfx9A9shL4F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:14.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38949f9e-51bd-437b-0b51-08decdf39e1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Add a q35 bios-tables-test case that boots two sp-mem devices on
distinct NUMA nodes within the device_memory window, exercising the
per-kind SRAT partition (per-device ENABLED entries plus HOTPLUGGABLE
placeholders for the remaining sub-ranges).

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
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


