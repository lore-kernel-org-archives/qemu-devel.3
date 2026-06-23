Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8200CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvO-0006cs-5J; Tue, 23 Jun 2026 03:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvM-0006Wo-GC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:52:00 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvK-0000jD-Mu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:52:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXg/fu3GE3SAwsvMtrAt5VHGAt8Me/JIzcdtFrJmfh+AgvWteb4AfU0Znw1Vn+QHXcNk56vXkn4xhBxeO3O4vruUc7uRx/KGpWd31GLUKr2AafGHo2vMi3no1XvBsb18C+jmqO3wGjsnGCtsWe1YAA/3fmsFhFoEp+fCRqEgyknE1rUn5CzNemMtAkS+65YwrWRrxY24AAoxv8FFQoRQ0jYWu54qTMo8759/E7N9LY8HZx65CnugvMmek5HVmdOobgDceOcIU6rBVdBR+nx8o9sAx0tNc/qNC6jQ1jOOJWoqNR2Mo4jmOmv7of4lgG2m886rnNm63QtqzRwEoxL7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP9zeM9FmMTi0J7AJNsJ0SXrUQIFN+IPl5FqEzyALDw=;
 b=Z4/VYjTLMPe7f7HnDv+wby9bhg/Aq7c13tj1UkyL8Kw9mWARahThlM+hp5LHUHmupBK2K66Z1QKuE0W0rEj8PfTMpOQr2PZEyB/8/ZIgmJPyFAf3ldxMcvmcxj0mAEFK2NNpZ/5YbDFQgZ1rYUCX99SykT1wgO00HsFTt7smtONFO7cCFkr0sjrd0He4G0ZIz0NYy25vySSyV9b2Mkdf0ZRaFTgWqim0V0slwJTtcScRmJyuc0udwVGzwCYSyogUwEoTrCGCBY7mQs5WOUdFbW2LYaTr5xWW2O/0YpiRgqu0iNTPLPbJucKlTbYgkupFJE4I4ykr+2ScCFXWKWe+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP9zeM9FmMTi0J7AJNsJ0SXrUQIFN+IPl5FqEzyALDw=;
 b=VOf94Ze64p5GHzTp/cfts16F5FlIiefv2AlTpO5VeHXW2Tw+/DYLpcIoP0vGKupmg0bHXROWc1RNPvbSWdIhdjWWoSuwfKt0ev2Ziz403XrAeHe1ZNKYR+IAMiuMjDzfZZFZvMoueTkUU5ulhsp7sBvwvNwxubTSCcO4DwUb80s=
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 07:51:44 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::2) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 07:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:43 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:40 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 06/10] tests/acpi: add empty expected blobs for sp-mem
 SRAT test
Date: Tue, 23 Jun 2026 15:50:47 +0800
Message-ID: <20260623075051.3797975-7-FangSheng.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd62442-b2c0-43c5-c0fc-08ded0fc44a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|18002099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: d5i35MiWJXpIojelX2CiGb9L5OtnfjWCGz++Bt0puN9+yiFevSH6HU7726Izc9AEnV65fqV3ULLuJuRNn+8RBaP166HLqT8COCGlSF26fZg63e5cuY/vv4sX1+FWm62QTmVy8dl28WH8r9itf6X0UEZFwmL/NXA4QLeJfYmkWsXILdiVXoGnA4I0Ygs4jSgpdpVmkdNfgY3hXu3QwCTbRogwidOpKzeOY4mCUQqhV8oq4rLItsTN9Q0qUNi1fI+n5R8KU9QB7kAWS48Rh/rblDxvn/WqC5wL6uvXTI+csto8VVf0nQ44pTIo5FtkwOu/s70k7haSR1WWqrUgiFGh9BS4xllXngVb8vXwpxUWlx4TsGj3frn1fkvDaX3RyyNB8P91ZtXvkOx/qMe5Gex0ebEtqI6hK4M0xF+/W8kJ9A8F6fzk7/5CC+Yu5U2nPkpJPtT4jQUykaYZ/C+qaarIG/oTKVyjDWK1vFq6Bd1UpnPMxlcu65L3HsYWMhcGy2X10ms7sjdvZIucLuH7ThDsoojam5SpnKnmV8jVkfAUzBez0BdV9co+Hn4PLcJDOjMsrFYJh3NveKV+W8fAGqzv4Kxtn9vSsQvT0vAt0yTKYBOysBrU0obynUMqtfKRwZLj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I0E+69LJq2WWPlFBO4SzxEWMDr9Kp1q9wHu6On/mtAk2WIqvw2jiFvYk7CI2hpzGb4XQbxM+ZPGXi0N3ECOAFJGuJnXE7mUoIgF2lQRnkQ+K2rv/0WDd0h2IgBzR6WsMvcwGK1m+vx+9wPQXqvOOoAzCW3Hkc9g41+CCBmo8RtbKtVIyYnnano0DQ4B5Brt5RfJWuGZfzToVbqYvUgH6+TkSXC7ALYVvLUsp5LUqqFPaEX48ctjaZ2qFVCqRLQOqVwEPrids6X35Dd3qOGYWq/Fi3Bf25HY4NfPlhUj5JSYtESqjobmzWtq/2YpFtsP2h03bDKB0jbAQYl2vOHN7gyDrwBzeHppbO+WY1JUEQ0ktNrzmiPKBg3mySvmutYvQFzY54OVlPNbx5F465bYnULtKQGRTcKi6+s/8AmsopMjeMPC7dAgEUdViI5ZYrB1E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:43.4171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd62442-b2c0-43c5-c0fc-08ded0fc44a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Add empty SRAT.spmem and DSDT.spmem stubs and list them in
bios-tables-test-allowed-diff.h.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
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


