Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1CFC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vxl-0002M8-1I; Tue, 08 Sep 2026 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vxg-00028K-Ik
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:34:08 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vxc-0005h2-Le
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:34:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrf23gJSG24rW1geGNHzDr31wZAvnDaf9IVslK7OmMrFS3oygwDE++8o3uYmne1zKqb7lmdj8XCP83CjawF+yCtAow9cd4GtrsVo4Muv0vGu7akiuBi1QtOE8SvKH1hS2bnFC80Jd5XU26GSYfLCw5l40+WdfjfzJLEngLXhkbnzeJP5jRCQyXYpxF6VlsWhlgHyu3II3WwbZ+eSj6TfU5gr4NCwyj8uBZyR6TJhkF+nuDd9uy9+T01He2IPwDlSACnlSd4WhxD9KF5EIIFua09JN8UhGHc7asY8Fb9CsCPi/F+GYgAq2ZiFiyIBmCRKYwtAN6TE4NRYQl0KFjrFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSTCCE6BfYc8QrNONzuGB+zj+mnTqlqFaqy3Qctgdy8=;
 b=li1ASY3Bz0iladXLBINwywaeQLap+fwFoCS9zIUaTaP7CxVFlLW6ssOSA4w8wugTYCZh1R0jEPhL99880X1gjrs9NdUiovezaIMYpL9PrNTclglCsEBp38PD2wzVD94ropwaNO07DLUK/JOc2rsL0ydG1nZ3h5mND5RNjjUOLFEqh7vwtmq4WOWlLCvV6BrhKtE40mFT6tODSfwggNHFKI3HMXK+93NaUDGecHLfP776xN0yoTcbKGGkwVOP7vCRz7EiE05zW1oAhCwgSGZ63idZp8T7yqXBrsMF4vDEwh9febPu5HwfBoCjaEZYmSuX8IQ6zc3PQKv5XGu53HNklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSTCCE6BfYc8QrNONzuGB+zj+mnTqlqFaqy3Qctgdy8=;
 b=jRNbtxj820iBXtxBjgxDR/e3R69ymPGVY8fXTgbny7fq0PWqYC6W0+uwLm9WpquUpsHIdpC0TAj8V0OoYFDLR6zu9dUVHS1cJbqGzAAgUv3W1My6ncWxm4JoHJ/EVp12o3LjW0Cg/43/+TVqic8hFt0nN+3DwbC0Ywq2Ru9cR88=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 13:33:51 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::82) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:33:50 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:33:50 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 12/12] tests/migration-test: Add a precopy test for
 guest-memfd
Date: Tue, 8 Sep 2026 08:31:02 -0500
Message-ID: <20260908133151.836685-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d395de2-b3a8-4071-e19b-08df0dadd182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|7416014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M60EFubtUdLwOFEgtlLTsdJXhgyRMWG1/nL1BTfq0PmIjaouysGzQ6QptK0mvaHlqAFkuEM/hm08Wx9tMxXJqm4MgdvsPMcdiO/uouSHGVgrtfxQQZiBgZrJ8GKLbmV9dUGesEqiltsBdj9xd4OAcCYpDHc6xk96qbAmjkfj5LTaG6gRjNrPoPnGpDn7Tq2p4+o/GquhfrojezCtSY2mt2dtbRFY7jf7BS+U2ZpAJ3oYOFEAjSo499MjFtLde6yQVMdlA0rFto7ZOPfQIXf/ZFqlnXoe5/P8QWVzhdVJuu9wKsE2BWX0sK8/Gkxx+t/994KiQbf13jfG/Er/aeDIdVP+pGdyfdGDKsStNJcKbtRxy9Zk2JAgjxSMMSHP/HCz4G8cbApqo37hWIt7eh1VzApAmonWvCYRU69/Yjx2jRRxhRAfjqBQB+SO1HNHk/Ori3UB+0jHN2ScCsRnRHonfFbauyNC8wfzQxqzbQdyMO8L/8/nNlvAEhph6HJFUqBn5J81H7Omgp3BEUQY7PLgpOe6TDhlAxULD6fjq+70Anp8G1Q+yX+ljuFjTJdUQPO7YLm4AfJSBzlsxF6eLCMyIf4OTOO9hOQhtkC7Q5ib71UT6vxIah4EivUNtQHR6Fwwt+NpZpsuX6Vzv8PAYhkXUQ/CoAaUN577clwIdHfl/ggJJBTSdI4ol1Jreu2oqsBsvP4/9x5A9VyRZ56Ws9amAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b6WFeXRd6FT9Jj8JDLdaB1gbTEA6sU4N4gBzuxHq84Fo8SJ3D46r2hCJnLTijX95BCkPsA7t3oRUsIIzPP1+Qc5hugu1Eyg9nKhy5uIEaAqYtdNhTQsYLPyyHduh4MTG4QzXbKLNuKKJGJBj/t7xHmVFKPl1SsyFSwWQFJ7aAW4oV6Xft3SrHJk00eAfu+YkRGGJ1YIlAC92I/trwoIzNx3IJTIYSekc9GOipcVTlG4GndtmrXYAmEV+Crl8hm1VgaL4tAOZfa10+3ECl2ZyV653HTOM3wKYTGc4OSfnnLLA+EjJRoFz47BtmM7kEPT5zqI9K7Hw/HQo4YAAI969h0uoIDESwrRGn5WuAOvN1WaHFnGUi3GEJoW82aAeIgARWaAR4iRuwDAT+J5EtY/QAQx4dYyoVlwfBC5mKqJFONhklfTbvd3J7vNKJjkhc0/h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:33:50.4965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d395de2-b3a8-4071-e19b-08df0dadd182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


