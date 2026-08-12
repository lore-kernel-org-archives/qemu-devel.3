Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3E4C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFTS-0000om-38; Wed, 12 Aug 2026 16:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFTQ-0000mr-8j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:22:52 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFTO-0007GI-BQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFnuX7e+OdWhQXJ+4P/tSjrVrOdlXa6axbxferO6viOnMgNunmxqEI2DmveA7l4Nvg35iMwKfNOtavJi/jBt8h7dxjrDnAVYB6lfSREpalBZAbdDQAIV7e5yNf0Robed4VWjiMPaOGjStUcZ4BXAqwivUMwtoCdWZkwMhurJYN8DeMMc3sROgzno/QUiHw7vI+l8t0qFOgmH9femVcGHoUfPq+pFFif8UnBgeORAzT/TBBSZVd8SKIY63Yg5iJCFOu7/133iyQF3O/b4/Z4co5xo+M8ylYIF09iBeEFT6CPKA36+KzyFJuSv+IJWlZEHrH5FT5HMD6wCMcusvvt4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHtBvNNv2wZlfWLRLwVIM4XS9qCoKmedY4xK+Mhhpfg=;
 b=A5CDUwGDGCbNChwtHA/APunxZvV1hUSrS2REOCHVpzFH+5rPgjSY2RTWdvy9/iBnNi4h16k3YtBRI3MEk/LgSzogcHUNI3z9atan9N29DdLHpecu7peloiHaQr0HBkDvMOrR1d5ziQ6MfvZ4ENkJQ+8ILXcN7AiuLmPrfuKuoUaptp309irpgtt4Nsu49IWnl/kAn3LrSENcm5kBbjB/L7xfmTuyhqn4gkpHMXjtJuYa9NXeww5Gkfws44iNXjQHCvkiokJa6Hft8IRM+q670ohaVeYArH4YefB9oinqZWukzsiAPj1x+CbJ0oE96DsRyhthQeGfb+8Qj7ERCT7k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHtBvNNv2wZlfWLRLwVIM4XS9qCoKmedY4xK+Mhhpfg=;
 b=x57mzIU8Su96nK5GVvzKDU+CYQ18tL7FK+s45XJlrOMiLlen2oTL1YG4+mmMIHv7DRhZm2TkID0M1mOc9choCTOrkwnMdc0AgcASAule9cTjQTR5SX4vmqqbB2wSrsllHa9KaiMPskGv/wbxUGB3V1osy9TD27FhnYjPy1Xs4qM=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 20:22:45 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::2d) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Wed,
 12 Aug 2026 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:22:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:22:43 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 12/12] tests/migration-test: Add a precopy test for
 guest-memfd
Date: Wed, 12 Aug 2026 15:16:50 -0500
Message-ID: <20260812201938.198915-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: f7da2a83-23bd-4537-8a60-08def8af77b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xXhvhIhh+dxGqhGT2sS/JEEWfgSwCdInxC4ruUlqd1WnGJNTzQlIw2lsOTJf2+FMDK/BBeJ24GdAqwG5x3P5dXpqykEXRwOLwU46T6SYYk/T+9IuzmH8iBPYMLkg9IN+/8+b9MVdj66lI5HSNhQ5arWPc8LuP5Viup4XUzpqnPnCkc8fIrWAVVTYZGQAwCbqiUF/e7pOw1RpyIigJ6RMZGJ8oX+d5uN7Ksf9IctWYLobUUTAZSFaOKk+VZzXLoLVokha/g/UVSCw5FZKZidKUm9mwzIHQa4cnOZLHyiFVNLCq36hKDY2o3XbWhJHPQYjtY7E8P6rscTLy3tDv4h1Yrtt26TK0KhaKpJtz3VZ/Yq4hCSNeL059Q+ufh12bTIjiqH8XyqPZmeg0iNIY/Df0r6n58QNDC27ZV9svB2xGZnkOWQHW/BXlsqcVSrW2HG5N5mTelswmdJzJSqUWgU6LJ8Lana2gcmarIKxgBLyHctC9M/ktAz4OrhZFTBa3gK0hCZL5NyNl9yhDN+atJQoiHxG3OIQk80citnw8I/I12m/gT5aeTnzEexbdBbxkLyQTUccLctxTa6l8qjLp60ZcExEF3OLbw1KSLfoume55JeAoia3c4T7BdTKEdRCDM3Q3JFUw5vGSDiix5OydNF09G4a9Ys/TTG5aXPgktwj1MyvC2pYnxeQhlWf2+mCQcTSSd62GMxbM1VyAt7vZVQ3Zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j7Cd3BrxDK0YOl/6pfhFFmYHEu3uYRGpIUksO5/Wy3SiVbtnm+MszbZTdfVHucuumnCQPgxZyf8H5DxFcck3/QeZyeYiJAHJxrwhgu5vHGR+xcRXtsdhFE4oP6+VR9hOVPgog1KHMGOC/T+N0gxMQVbnkkqnqQMwsX3aM8kir5XvDMnHFtUNdoW1/ad3FZTUoaJJcyTnnnjvUv6aVuvhZF/M4ULtr7xMrPm8Og/Q/oq9EJoQQyTdp4Vlaa8m6Ctml4NEFq1KQ7M/GIoYsiFHrZoAJAayIirgeeqzV8rI6nELN2pfc0pyxNsqtCUPujhJqZexUghZK8AiwVKziqNspBSPh1elpBXKEVp8rY1tbuVKA5vp7L8YLQPYEbiW8uQEQ3m6Udd18sRg+EWm7CyPweTa1PQfy9VcTCjClCS1WsZ7bTHJn9i52ySSNlxS9A0b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:22:44.3252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7da2a83-23bd-4537-8a60-08def8af77b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Add a plain tcp test for guest-memfd.  Note that the test will be
automatically skipped whenever not supported (e.g. qemu compiled without
KVM, or host kernel doesn't support kvm, or old kernels, etc.).

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tests/qtest/migration/precopy-tests.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a23d51126b..8146f37d61 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -182,6 +182,14 @@ static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
+static void test_precopy_tcp_plain_gmemfd(char *name, MigrateCommon *args)
+{
+    args->uri = "tcp:127.0.0.1:0";
+    args->start.mem_type = MEM_TYPE_GUEST_MEMFD;
+
+    test_precopy_common(args);
+}
+
 static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
     /*
@@ -1108,6 +1116,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/plain/guest-memfd",
+                       test_precopy_tcp_plain_gmemfd);
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
-- 
2.43.0


