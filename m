Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0DFCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX99-0004q3-9Q; Fri, 19 Jun 2026 07:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX98-0004oq-62
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:26 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX95-0001tq-W1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxJcSKqkWbQyL1zuoC3Q1xCus1oNNYfAC481gMTPfq7Qvn4AeLemjj/qMKN6L+BYaZPLYQIZcfb/ZojdKR0aZK/jZI/4pfV9E3oxp1kmH1u18rfWfQLfl8Qw4RTv4nyXFQPNZlKSIL86bqtR0N0CIbtPC/Wbrue2CdXg8BsRhH9O+GoaaHs6A62qFiwnBrqM5QrCI24yDjYekQz+Z78+jY1QcfgyvS9ODyOOmcCFqNdzqINyCjDBR6m6TsdwaIiayGuOXZ7T+oTWGbIZIdz3h4DGqxvG28LBNHwfBPJehi+MZYr4ttUL99Q9ULFIsifDiYhJzmG3Uiw9yKfMazHM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW+ZF71AKGdIbrZuyAmwU1vROl+1etdFpIAsCr7tDR8=;
 b=QYvEE1RBM+ArwScNQffl6g0/tdLRXZ28bOqoa/Mn64uFsaRU9ehhzHKUJQMVK6DXkn8daT8nqm+57zfaYM5qGwZBgsfi/G7qG71ah9VgUGYd6DxZaZPU6q6CoiC0CaNQIGmqzusvSAcQKeBrRxRKHvEJ0fT4Zy5kWOR+Fa/fdnwxKn8t/9qbajlxGevC95Rhf+ANzff6SpKN+O+Or+7bWMmgryv4YMFXzJGXs2oB8o+5H/rPrwvvTwCSdnXks97tWg1DCKXerG+MWd7cJXy0fZkSS1tgzPY4VHiJ2Lx0DITCtC/lxLQ/Y+coKzjg6gxTaE7I/no1vRS7HA1tmkGepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW+ZF71AKGdIbrZuyAmwU1vROl+1etdFpIAsCr7tDR8=;
 b=JS6Gpv6CP23jWfPhmZKJJBYJ+/ILXJ3YteGQRP3SKzXkLe0A2avlMUcZoTlg9wR7SxXPGkIG3aEPHnAoszVYdGADmMtJaI+9QjRRJir1YUfkc+aVcgdP3+eMAJOPlQDrZr7bLQSvfmlMpuXAnbt5trI/doknp3KenIGVgcqUNa0=
Received: from SJ0PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:33f::22)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:12:17 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::11) by SJ0PR05CA0047.outlook.office365.com
 (2603:10b6:a03:33f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Fri, 19
 Jun 2026 11:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:17 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:14 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 08/10] tests/acpi: generate expected blobs for sp-mem SRAT
 test
Date: Fri, 19 Jun 2026 19:11:34 +0800
Message-ID: <20260619111136.3481329-9-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c386158-8f00-4f90-a7d2-08decdf39fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|3023799007|18002099003|22082099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: luDGF8BXmf+bCfVV9ROP9DvBsIHG9tjr6b94Z9hxruqHy81d+7UjQPqFwsw/iDmGYtYV8Jb/Kei5cvsMhspBs/933HrPpAuX9eCv4gPfQNzLg8Obkc6XFgZTpd1eutUEg8h4KGhv6WsLPgsxj0TtJI1FnwrCcCEV33Wg9ZBe6Ak5eQtCRgm7IuyT+WmH4/dWdoh2TmYsXzfgJtPb3TqcD5FqOssgiIMPpjQlFMEEMj/xfbuCxKabtsBzuwHjeOxBzlkxCOsb69edhch2eb7m5UrHkc82csV3EUC7r4A/3IDDEeUHLAfRbLacSGDMzdSyjD6ZbaC4B0vw6MCKyHISTOvtSBHdsir8z2cQAw39mmGhPbEtsUCUuke21Vz7ts8AhT8hKJgbRNWeE5AStrIEnmC4CgOre6UwH+p0NVK+NyiNSksCNJzhZoepm+NS222AIiLIxY28je+RqO+47DKNwuUaEFStN2DsJg9F+BdOZjlDkLV1mNeRBNVIwyoz2qIr7+NNe7D20esGdWJzu2ofDLrzFERnWrGZRcAsH+KTaFRhXNYOqygkCuUJcND4ZXwE3f42MjYVNhkVJV5h9SoEvB0ESZoixIS3dGI5F0Rb+FrPh0/wJwQ0wQ1d+hhqyn36OPHVkJRulFeHRCVnTDSHHgW3q8yq2qATPJGoO2Er1Vsv815N1CeeZG4tQlyJXWzAAqh4ilbR7dx5PE9g1eTqnZi4hQkuap5IvRbgeQ9L0obMbjz9flWEnzs9ehzL56OO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TEeyAKTe5V2315VqTFn4qyYcjwYvG6fYvqHlKYSrR7y6r0ffptTG8bQtlkI4vRpWxdCEVNxcwkjgPcFlCZyrNB0iL4M7G3pdVkcuskxwwPn14WcYuQLPNL7PO4gi7hJ9psbtUdgyuPvCqQa2jfBD7KCy+SwynY5zRhu9eqCSNiZ+RZipWn+ey/FLy+F9eB+1AamqvhRqWbqX63nbE93pm6Sy4UknSh/9M41Cw8HLGMvMUmzwvmeH4Q0gSpwJk1uPMyeC2Om+AQkXX8/a73+GaimNpPx0SFJRaGcNhhWnX/z+YahRlxgMFbQFTcMA7nRX5UHppkM9iq9Q9SHJ6hpYoTMQvhLEahDxjiqiU3+pldHYlZQeLzsTN3gsoRdo5SYPPnPCfdwWkvxC7I9hV9B/24jWJLQfGkNmcp+QMcM3JmmCFsmILnIS4rZN176Ojvst
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:17.5162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c386158-8f00-4f90-a7d2-08decdf39fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

Populate the expected ACPI blobs for the sp-mem test and clear the
allowed-diff list.

SRAT memory-affinity entries for the device_memory window (q35,
-m 128M,maxmem=1G, sp0 on node 1 and sp1 on node 2, each 128M):

  Proximity Domain : 1  Base : 0x100000000  Length : 0x08000000  (Enabled)
  Proximity Domain : 2  Base : 0x108000000  Length : 0x08000000  (Enabled)
  Proximity Domain : 2  Base : 0x110000000  Length : 0x128000000 (Hot Pluggable)

Each sp-mem device gets an ENABLED entry at its own proximity domain;
the remaining device_memory window is covered by a HOTPLUGGABLE
placeholder at the highest proximity domain.

(DSDT.spmem differs from the base only by the memory-hotplug AML
enabled by -m,maxmem.)

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/x86/q35/DSDT.spmem          | Bin 0 -> 9910 bytes
 tests/data/acpi/x86/q35/SRAT.spmem          | Bin 0 -> 384 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 188003fa90..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/DSDT.spmem",
-"tests/data/acpi/x86/q35/SRAT.spmem",
diff --git a/tests/data/acpi/x86/q35/DSDT.spmem b/tests/data/acpi/x86/q35/DSDT.spmem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7e6f850e7a25aaa3cb7abc0ff2aeab4ca7fdb716 100644
GIT binary patch
literal 9910
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
MvBJ}12_H=T4{{!rhyVZp

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/SRAT.spmem b/tests/data/acpi/x86/q35/SRAT.spmem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..9ecd266eda68d035f72f170cb1346b97da623c28 100644
GIT binary patch
literal 384
zcmWFzatvu;WME+AbMklg2v%^42yj*a0-z8Bhz+7a7!Cwb`HUKH87PAbE`Y2Lp$=#O
z7<^!dDa5W0CX1a$n1@{+CQ7_Ige#yd4!9XG29RddV1n^Dh*T#4Ri^>7ff;53kOlxB
Ct_cAE

literal 0
HcmV?d00001

-- 
2.34.1


