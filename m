Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30FDCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhe5-0005wV-9s; Tue, 29 Sep 2026 19:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhe3-0005w0-PM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:53:59 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhe2-0007i0-1m
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0eG/hUC8moz33MatSl3Z2/rYhrr06akzhVFig71i2iKjX1iSyKAgYghyxNNjPvXbDln/HGnfwQ15/Zcb7pLgt4MROki6a2mwP5j6y/RsBaI63YfxRj+nXmNAKRzhYN++8bADEqDmq07Vp1FRgYU0IzDotmgCLQ3r1rdvPgrrP9qLJvQMHcvgQdD/tSaYOztk0NO9vr5VWeeccXYhB4H8gCdkWs+OeFprmtHpsxnGgWdkKDaADbSIvWYl1FgUcDHKiCsArTh5pAkktkJeGy0Tc+0jPxmKC4utdEc/RM6EY7cJTRy19XbF619ZxMd4VbdKk6S6bMvW+O2EligFkKjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSTCCE6BfYc8QrNONzuGB+zj+mnTqlqFaqy3Qctgdy8=;
 b=ogoF9yWAH8taoD/TVAE65UORB6z1TVmiII5dyEyqTqxErJyRLjKFhR96qSS1Muy/A0eljBahO6vU/lRcF+9UwhrcFSxhTfaLAT8EwL4sDjjDJLVcDo6CDphwxUklq6ZgLUy5dxpKmv/esaV12UaJkWgqen9b5oRNkDip4aFnxPEw6qOlV+6ZUt/HFF+Mo9ZAmOz4x3ckTvCxbNiVCQ+lwdDV7ip90jyEskkgUOlto7glYwDY4YLJJBzO+cx6rsq1wLaE7AiTq7VmA36QbW83TUUzCJ3L6Em0ujZAxLVEZyPmJ1QO+w7IAJ1leKpDvYRxWJgl0dTEW2pNbqfYI56dLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSTCCE6BfYc8QrNONzuGB+zj+mnTqlqFaqy3Qctgdy8=;
 b=cDv+J7V4wR3Lyqyub/Zh2ApokVeMimdD/hBiCbEQoggddGnrrLK8RmFGBfKtZ31fAJTDTWi0j/XjDfWBKE72KiUrpkA/VlTisz+jZa5qQWLotc5h7VUtlOIfz7Xnjd/lFUsci1yHY2X8STvuQmSgibruX7v+Cb/6H9Ts0SIvYu0=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 23:53:52 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::1f) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:53:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:53:52 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:53:49 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v7 12/12] tests/migration-test: Add a precopy test for
 guest-memfd
Date: Tue, 29 Sep 2026 18:50:18 -0500
Message-ID: <20260929235109.1398509-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9638c421-6c9f-4925-c4ea-08df1e84ea09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TfF0PCLuZIj1DdLkhJKaHhxr+L3mMJPk9kG/0woITnU/B9DHNIuEm8SRY1kGhbvSzDaTDgY/crd6P21Go5OVYIOlUO/+bNCss3CfiQc7O3CpZZqooOC7x3YGS+M4vehXXQDAbe+bFJG884ghbwBhV3dxmMS8nxdt9AviJqHfs5O3wmb5wK0c95w1UoUItjIsEGhoJpy8pdRF5vZL68fj7v8k10TEC0wLw2JzIeNRccXPn1pd7FT77x+kTVtoDsijUvX+LXhn+6Ce0vCllW0nDrzcAseufGEJ/dnf87rQpl6ScdP4Q0DcCtNsd2ux21Wb43L/PbarPZYYEZLzRaawCmUwCOk3/7Obo1LtgfV088K27kiYPHR7IbEySc5ivE/9hw/jiQQK0liRWvQ3dP6UxYpn3Luux7hcwsnXQOzuNInmCKyq0pRjF6PfCLEtw5h9so86linMJDhxqq567CAbfN+XRbaNXLlPaoCFwCzsb2HMtZ5HV1ckV5tLGqatb1vVGlj9ufKuAZ+O5h2zArQLztFMBmkTHMiFZFTYRR3pVWtEX4EsBWpxnI8ZkTJlfc9/1Z+7eA46lj7+gcxSuuiQjdGmIzrZb+zUFoEdpdcSZ+/tIRWC8Ny1KXy/MK2yizo2XJRjBQzbEApcbXIwCuGSBCnq5BYrg1zwwnkaXV9VzY1wwh8bAsH3n+qXikXpuFPebaz/h5+P+DxoaZ9MqELeRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7AGMj24oVu8IGOgemUWGtWKdg8yV9nDrKkpGjzXMqCvCofhLausf7gXmskbAEPwFr8EW2jgIL6SaTeER/YuWETUgBr1U9ScXE5rqKi5uf/WxEatRd8KM9OAzoCjfRJxbbZdMVNkxuuhCoT+FHyb2GfbITl84d/A/Fb2LrBtkalM5m+kMLjFMD7q2WXXCWZp3lfFagUejKK5tKiV/xMU+w2V1xRPjNrszsbzh+RcaOFSj1x07qXagzW/BnN9tBJShto1Hdap+IJw+NnO3FptfUcv1yXq4MCn7glldT+v2XYUIVfbl+6XlMCNxRReUE3Laj0zsKumMR56uvUBO2HmaSfvdDe/Pc4J5EKrH46ZqPU996w22MgNUbc9qqxIEMIJOAjHC0Ta4O9GGo6vSEaiCDxqqSpLSbngaaPm6dTsRKo6WZnFelfPRKcUeRUArHClI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:53:52.0503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9638c421-6c9f-4925-c4ea-08df1e84ea09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: Peter Xu <peterx@redhat.com>

Add a plain tcp test for guest-memfd.  Note that the test will be
automatically skipped whenever not supported (e.g. qemu compiled without
KVM, or host kernel doesn't support kvm, or old kernels, etc.).

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tests/qtest/migration/precopy-tests.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a23d51126b..d57ffcac23 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -182,6 +182,13 @@ static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
+static void test_precopy_tcp_plain_gmemfd(char *name, MigrateCommon *args)
+{
+    args->start.mem_type = MEM_TYPE_GUEST_MEMFD;
+
+    test_precopy_common(args);
+}
+
 static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
     /*
@@ -1108,6 +1115,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/plain/guest-memfd",
+                       test_precopy_tcp_plain_gmemfd);
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
-- 
2.43.0


