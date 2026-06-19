Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B53CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX93-0004nh-Pd; Fri, 19 Jun 2026 07:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX92-0004nA-Eo
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:20 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX90-0001tO-Ow
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3XJHCsJJVv+5ymQGbZsUFm8OB5vUzJfVAGwX0ABxQM9qnDEWYwFvEPdPlBqQMKA7Qk11nErdRqTLZ/oljZeCGfiIsTmxD8ubl+NDKtrd2mLPLrQa7qw4T67XT5nJcDHqpU2/J1NjbyzGEyo8DUZRQB0xXpQrUgOv0O+tXRo0UH8RHZ02f0Z9Cfb/zu6Tz7Gta1H0QY+V3gZVgiH2zNgK18ZF32rAilgc9oCzHvBKuHx2LcO5b5aZGypWwMKTDhMp6J5iNcNHwz4W4Gqc5CPpbg7UxjjH2n9suqEAYTvHdzW0p/6fQuAaOvneglJSxznTBT6Ysw22gyRFY6sMfUivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGzAYDjOObmZuwQhTTJborxVB9Uux53grZ/BSNAOIBI=;
 b=NOIUkyJMn3zDs8+/MqddQK690Ml8fNqj9m6cq3OqFZg3HTcmaC5lMMooUlt1sWdluDL3n5Av3zBFhfU7hvWebwogL/1CA6lA/zFHsn0scNW1xeT6qEyYHnHj/3RaVG+WgXtLv0QPsPSg0pBafEdw7WuaWWBMwP7FCvGj50YIF1eTsHKyxWjiLqcRl4HiQkGKTlVa5GoiIsmeSeL2MOoVZmXoPiN8aBKnRYpDIZdcRkh0xuOhU1zgxefFqR6Mk6tywZPDvbolsMtPNyCPfJHW/yBHV4dkG+5g7CjmCeusBNpj3Nhw6JqyDEgplNiFPwWd4nWJQuPyf7UdpMjnW90R8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGzAYDjOObmZuwQhTTJborxVB9Uux53grZ/BSNAOIBI=;
 b=27RYZlO7bUKPaCWuq5pp/y42UWJdjoxiKsppYyCV+Vq4NvFRPKHulokzoovuxDZx03O7YePLHcCfxh5kpCvGFLlT8pYjpLg3PI+GZhn1SABsOAdo4sjY1fFJfF5mpgQaBr/3xobfN/+eI3beYuZn4MQ+hXlWkcksSGqMBz0xj1w=
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Fri, 19 Jun 2026 11:12:13 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::92) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 11:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:12 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:09 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 06/10] tests/acpi: add empty expected blobs for sp-mem
 SRAT test
Date: Fri, 19 Jun 2026 19:11:32 +0800
Message-ID: <20260619111136.3481329-7-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b38e06-d04f-4272-4db0-08decdf39d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: BU8vfe1SRvp2UIWXdxY5/fqoyk/2K6lAEgnm3w16rkjnfMRf8OGR2BAzL7ftQO9b00vfCcVRVc4ETu9pa6+tGKa8ohoFuJrDbYi66k0oS4l1VswWr60HEhUhYItuDdcDXI37y3/kA/Nsl3Gb6UEPBaLBmM02ADNAFKvQJd8CCMyBs67RXPhCHLq0M/IYWaM+7915fT61fd6dsXyFgWadtshloq5yQxyQdEzCmUm4T46+jqqYVZB/l+nv7rDamIK3nrZLxFU7NA2yjVvVCq+5hmFHdRtFdVKx4tYb1B71tQtXOGgBcRA7UER4prBrYah9WA0N5PbADna90kkN5wSk3E075zw/xxw0m3jOWXKPCmpg2TCLFbujGNHGi89oooHM+xkMw9cKDFq36erqUQ2lrnUKpMT1P/Hye21FlJvSbkRKxhg+jopYDPkzyBSU7ZWunwJEkaCCao2rhKXC2+INFpqacdlcNSxKdITF6Filzq0RxCWyH8W6qYqc/iYrBms2dp43SJ215ggg0ABwKSjSDnjEUEbYPJtUFfzlOLITSKBctIQ9zDil9aaDX99ORjRV57JwAUMcc8vE7rl1/78YdlLKvV2qT9Uf3yKR4IWvTNQK8FD3qZ5nQb7db8Mqh2JSsL72OISbyN4wAKTFejU6bqoti5EEdIHwpVWY/2DPZW4gusoy5jEaDv/80riM4BjWhhOjcEqvrBYtVPxag8f1FN7KnPAVhxFm9pnMidhMMnlGv4Nr9cdLah+MRwLqX00P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MLNxKS29I4v0IRGUsp9+qYSoyeBxm3WK7ZEG2lKrWve/sVMgNVN4WU26iDKfmML3Jpu5vt0l9YdZnadYtCk6RSFdqVWsrWgJJXwzY4gMaQadty3qE19C2sCapwb7fe6Vc12qOiCatmGOopAGnqtV2huiLEqGeu/Mnq60y+lUD4r21yF46ZtAbsRffW0tibouvwfTT10/NMw7QWA9asWNgHhS6h8rr7iHhdsA3gdpFFI4gREqs1DwbdonwYKQgrGFSuGALcTQIDMUMeQy/xaVDiPrXEIjf0rxWWd4lwBbrOlHqkX2i+Hxw5RKG+NLxknq2eFiY1LOprDbI3AHl0glKCR4Hf17B71TirWB4bus9al9PahSFEcxMNcCzqnqR/rNLVGAGayiDKrI5LGOm5wVWsaQzBSfrh9b/rjPtHt9u2lIIKAOMUjgqWFRXO2HaF1g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:12.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b38e06-d04f-4272-4db0-08decdf39d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

Add empty SRAT.spmem and DSDT.spmem stubs and list them in
bios-tables-test-allowed-diff.h.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 tests/data/acpi/x86/q35/DSDT.spmem          | 0
 tests/data/acpi/x86/q35/SRAT.spmem          | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
 create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..188003fa90 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/DSDT.spmem",
+"tests/data/acpi/x86/q35/SRAT.spmem",
diff --git a/tests/data/acpi/x86/q35/DSDT.spmem b/tests/data/acpi/x86/q35/DSDT.spmem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/SRAT.spmem b/tests/data/acpi/x86/q35/SRAT.spmem
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.34.1


