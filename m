Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D875C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmreZ-0002Zj-20; Wed, 20 Mar 2024 04:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmreQ-0002CD-50
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:50:23 -0400
Received: from mail-dm6nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::604]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmreM-0000vI-J1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkhiWO2i+rQgi/A55Xr/AYStl+SA4qaU7jeK+ayU7hn0oJ8y5nlAA7r3rGD0co4Kn7LfoKmOM0UydOOdr2ej6M70CuZb1F5QbAdjpcOci9wPeML28gFj0CgMgQ0Lfo1phS9plagqTu8uUn1CWYNO9EfKWLkdQ263ALd04j5Hudf5gORlKt8ULJ//9g7ib6aPCEW7k7rAe7iO1duYeoXrfnjgRKoewE95vt13SvGKX0KWYkpg+Y/LmY18OZLRLRBXtUaFAd6H/M3pFKR+MtGFwWgHnLwe1JEQhRRCGANjROU38cQHN4ttvDSUeikrNPsK4+ZyHqlFgltRw6BVbXTujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34C1YfoGnIhU/dOBQftedsu20IJfwfyy/w4rgp/Mw1w=;
 b=MNEjbPMgwDNk88areKeDjiJ0Vu0JNdyxzm2OqYbZP2YKznCp0TX9ss7XuLACl2ppfTGuanAtKmAnQKmkYF8HygTgtPBRKALDA0xmhyJVUW/7wjf+SDfa7EEMgvWKPRJC3zK6VSVMTod4rVKnv+58tCwu3OBKAOLJh7fNP/lWMwnhyRqNdWo5QK80OR6BQwY3eSPOg+soZx5XAj2QbcRtUtKeORESedoYyd+W+gIC58DjRadnrQpWGtVEE9QiSVaAeKEpHT6le+YNIq7aW9dF/+W5QbCdVVUVvruBXQQYXB1WR0iHe9oCKpfKoq//gNnMPS8PcxZB/Vkn/hmW7gbXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34C1YfoGnIhU/dOBQftedsu20IJfwfyy/w4rgp/Mw1w=;
 b=SmwQoXPW27GgOq+u9RVqCOZ/tyfJvLsnIe0WIRjEIqX5hh1bXHZXHTiqjckUzGJNlGh/p6cmrXvsfTqTVfbnHeWzqT/daFAWgwPU0KB8YjSW4v71R299V+0RvwcSO/rJ+IYrn/QYn8cbSN9P3BWaNDygbUkeQnAEXVOxhZpZtGY=
Received: from CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::22)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 08:50:14 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::53) by CH0P220CA0026.outlook.office365.com
 (2603:10b6:610:ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 20 Mar 2024 08:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:50:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:50:13 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 32/49] i386/sev: Don't return launch measurements for
 SEV-SNP guests
Date: Wed, 20 Mar 2024 03:39:28 -0500
Message-ID: <20240320083945.991426-33-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b2f3b5-324d-4500-9e7c-08dc48bac203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XQ9F871zufoX/qh2H9iDbrDnPRbUXDNOkiIzxA6gRAP6Q0rC2zntrCF3gqssJc0+x4VIw+l4fw2eR1LZuldeh04Am9hN5rCPVTUx5rjzPvrUXyvDHLCFr4t10AYEg53v7K5lIK5TxNaTws3B7mzJDlPHayX2z0mKbjOZQEnUEC5y5zVhEd3XoPAOE9vvj7h1n99PioViRhxbCDMB8p0v/fo/7gupdl1uh31Ui1yiG47NJro2hQK34a6TD6I3267ho5FixkY4hCf/ByRx/Z7ADsH/2qczt0CPoUhMfBDCne0yaUaFr0STpbghZ6q1au2ltZ90a5/jT2tp+A0nwCX+q940IzxfBuG576FJRIwldf92vrGL+7aQ29bc6fldtVCV35bg5VrdGMUnP1FNkh4/VUwuKg4pD+4ubCeTsQ0Y1SpYJ3tOW3Yo1bsrbbD43XD8tQm/kDDurZfCnYgJoCfwOBs+qa+yz4AAmkEGPMZB6LGieoJCi4L4PQP4OK20EAnubt/KoXr+BGOjZ6rGfahTEeBgOHvjLfQjvJkLDxZ7b+5IeI0UePZBNzdhKEjqLDTZaA5Asolf5dRpNW4VqHxmHo1jriyipMrQxamYkssvvtHrV6sH8SaCNgD5ZF5GBehaq800Yl2SzFq9IDrTU1wSYjADQ5xoTm/77tZURXByQkuFxBwFByNhDLP9d71g/6gVWJeIEVHygmmiAQtbMeEB1llkgvzkuDhugLmk4aZL8YqdKbePNyvnuX6Qp39NqVo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:50:13.5433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b2f3b5-324d-4500-9e7c-08dc48bac203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
Received-SPF: permerror client-ip=2a01:111:f400:7e88::604;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For SEV-SNP guests, launch measurement is queried from within the guest
during attestation, so don't attempt to return it as part of
query-sev-launch-measure.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b03d70a3d1..0c8e4bdb4c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -803,7 +803,9 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
 
 static char *sev_get_launch_measurement(void)
 {
-    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+    SevGuestState *sev_guest =
+        (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
 
     if (sev_guest &&
         SEV_COMMON(sev_guest)->state >= SEV_STATE_LAUNCH_SECRET) {
-- 
2.25.1


