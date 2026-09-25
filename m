Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6980EC98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vDX-0006qN-7Y; Thu, 24 Sep 2026 21:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vDN-0006hS-4x
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:59:05 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vDJ-0006Oj-5N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVaIQAvM4cets1fDnmfcktryX9cvwAJt6PMx5IB81dzCSt26sg+hUjCeMDNUiY/bEjiA5eXPNyZVcmx2n62gy2LlkX5XH/OS2BSPNRJUaztXeThmse7ur8q1vtkNBW9DJyPU4a79cIKh2Z9G89FdvVejZcbK9tG43CsS/GOmbmtHsHK9wiSGoE7vdfDxOZwiRxf5on2OV9WB0fmwCb5cLrCKWu1teWuJzOZZIIPCEfnpK6KMrzMMU8wEide2q7QIlLJfaqwFKRQ4ZdIgoHR7l78JlWAcRj0BlcWOcJhSB3Zk8+WkoUz0O/ZdwEUpPKpu4MTmn7WTPPDuM4uQUXYSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSTCCE6BfYc8QrNONzuGB+zj+mnTqlqFaqy3Qctgdy8=;
 b=g7zp8x16EQkq/5WtjCxa1YJTqC/joyt0EGcNMcKhBUc7vSORuhz9v+2YLpsZy8z5elB/OqBas3TuCWh0/ZBoq8QDLnPvAYkcjT2zIVglQmYETxeuPgCF/cAszF6imJMNx2bJuZP/tv5BK3zCxMS4uGcZTwwOv5SjRZ/bbBCkDEEHv7VlVFlYSXLcJBTNIuueZpLFQYH4gyls4Nb66I4FdA6wfTg3uXrGPXEaX1vmBTjHjgMWcJcveHpHncpCXz0niKC3jOQn/twKZw+axxyLPaA4IDHXkYmbrDkfkKowfwNjTUp/dtQiv+j6JIf+SlOpUKoV1N2to4LE+aGOiyM65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSTCCE6BfYc8QrNONzuGB+zj+mnTqlqFaqy3Qctgdy8=;
 b=av1UZlKiOTmGf27f/zU5l0CCJFx/BiEXIsTqAGACz7F3Sfon2t/AvgfALCyHuWd0saGtB9Cdx5cZMUMN2B2xuNxz0+O/aDkiGDlugwnW8KFXlvbZFcHRE18HfMlrk/SWPA3RhPu0uxiZsbBG+gqSJCGsePCBWZXEIOw4a314ObU=
Received: from BY3PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:217::29)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:58:56 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::22) by BY3PR04CA0024.outlook.office365.com
 (2603:10b6:a03:217::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Fri,
 25 Sep 2026 01:58:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:58:55 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:58:54 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v6 12/12] tests/migration-test: Add a precopy test for
 guest-memfd
Date: Thu, 24 Sep 2026 20:43:18 -0500
Message-ID: <20260925015700.1260501-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5659f92c-035c-429f-4d81-08df1aa88eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uE6cRwbWrwhMheoGh9/BKqLVTNfnpqojsyhKXpIi/qvgr709PcWbXYnnr0vYnEV5hSbG/wbmgsrH/3XyQi8AMQAbLrhwOVaZXcSp5IgAYdfONyODgTauUIMazebSjarpyJ0Xa0FRln4Wd14GPEkHkRT4OluRMMzLc+5xsa9+DZNMY8UooHt2eZf+dh/hdFurBkqFjUsEyJ2IoieRoINwUKo1HQUTm0ESKRgYwsj0y287fa8acaEGnpQQBzErNX84Rolh6aTLx/KzYGm61Nx1gZA/OkNqevqP3R0irnmGHMYPPE1a+JCe8n28S5WvLLY0iO1EOtYLPk93obxx1BchJVakmBvwivqAcjqIDQHt3n9A4wcoGo/K1KLMkSVfMGWYLwMtmAWx8FT0KrqKKrfvdG0Ul1M9TiySGmOlzFKA3XttZRT2bTJmwaYzU/Bof9eufpGjv/R7GDEhvCsaf/94AUZD6L3LCtZA5Qlw7+Cx5HwApbHYtnoXo2fK71jPhsyoSDX74AV1tNdNrP+HGxS5WfUoAG+p/etgvdB69lZcrMMOyojay6P+AITeMGmDrhyokVGRgWOKGAWfSU+JHEWlt3fNY4fktYpH8Dr+X4olXkOZbDFEMPY7W57/PONTkj1e/2vZgEWUar0ot2Udz24LZacTXVvcVeYNeHCC3CccPwAISFYoUTjlHe2Dp+nkTAxuldKd9JA3YVwfhSh53Wb4bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e7wQu1zCQ7LdALXkcZgVBjo1iMMhbmqLbWzvNn7u5F508ti8cetEsHu7tOX98sZNKQ8i4UQagiIDZtD9B3XRQ893Z9A6xo2YXFdDD2saOInV+1WWTQDjzrIvrieh+ckTALQeIF79MD2H+hR2xkJSdPq4BAefizRMgnGMXHhlPbvagzsW3P11Mm2VWnBLJPW5S//3gqu2rk8qChUC9DWuJ4E5xOiVIhLH3v06Kokmv98iJJRCJ6NZiJjT2a7itoh4+GfE00cjwFci47kXn3nAp3A0iTR7b9tjbE1iQhgglW78JcsrnZiJVZfMncA/a5zSLjyX27q5ADJWU2E39dxpZfSnQHvaUxDZvZS5cz7n/WMskYQ3I0uv+TSW/rJrEPgsK+5ua+sPbQGZjWmQMa4DMzWBpDrAbkXqLEUzP/VpCHTq1xFjz7CWHvgSPgFVg0ll
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:58:55.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659f92c-035c-429f-4d81-08df1aa88eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Michael.Roth@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


