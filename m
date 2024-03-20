Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5D0C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrd6-0000Mx-30; Wed, 20 Mar 2024 04:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrd1-0000Ge-80
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:48:55 -0400
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrcz-0000ZE-K6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBpF8sjA1/x6p8GYIL6ucaJMkgt9Qn/3HmC9CZr51A5MXRLyqQZ9ff3Mst9q5xD/QNK+JbD3J+eqmwn8SJJJsYHg1xNczbiebOZoyFMnX0xXlT3uYFltsgiJhGQszGhxgLk3RlQBlYRrtIOIVrTHOKbQ/KUC6IXUJ+fnR1L5/dg8AprCrgDtqIV5ZzZu7KrbAD6mLeofJNmEThjlzISLXLbTeg4i0O41Tt6Xq8k3+llKeKCE0lh4HBcJFdre+vjBeMt/HmCTMsjZw3lfAILeHDunWxj6sROFhVek7O9McW4u0OE0uFjybm5U2iykhV3VO92hgQAChLq/313e1O8FKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmlEPPQJRqOq6Z/gGS5LaiJnbCESGk5Pdm6g1pJHzV8=;
 b=FrVEo2ZbBB7rzGmRaElevRwbtlioNCMf2B5ybcmwvM3l/4wtOH0/7pI0KkM73j9iQKdJJIW6bexbh372nVHGDjhMDD5eBm0ehGPZAJBf2rjxy3Nbk98BegXHAYG6icmqKm4mMiEuyoDBMSQtDIIaunbLbwQ8CEm7q0f/q2t1dIDA8JEkrc6BLPMzbst6yB/qMfSu+gVepGuptgy9OS1YhLYdy1L0iaut2qt2qVgT8CA7dGme+M3FmkcbUiH9ZlQLApqGMtwMoiqeUP6MvOQevGGmU0aA5C/qWIaXOSo3X/3C5gUCPHloKyF3mek4hOQm9UryXCX5i4BsaBq9rwwEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmlEPPQJRqOq6Z/gGS5LaiJnbCESGk5Pdm6g1pJHzV8=;
 b=XL9SfU1va//tIBlRWTVaiA5kIx50t8Zh4PA4TfCUHvxkGQ50l02joj3kbAXogm0UA+ldaa/S4K5keJU9Sn7EZ6UbdvfFb+9ndbbPUQvD+/MWtnce9tKVEKA/J30de3NSlvippk0jP7mY6yHR9i9T4Z9r1MPLxTmPH9JQTY0L94k=
Received: from BYAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:c0::37)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:48:50 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::ec) by BYAPR05CA0024.outlook.office365.com
 (2603:10b6:a03:c0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 08:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:48:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:48:49 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 29/49] i386/sev: Don't disable block discarding for SNP
Date: Wed, 20 Mar 2024 03:39:25 -0500
Message-ID: <20240320083945.991426-30-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: bd038284-1131-4317-2d77-08dc48ba9038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Fz64ZhVuhXBo7MhkvkhAeArfNYU24gch9xQEHb6EN8Abs5krahsCZsidOxyIyFdld5RumreJo1rXfv9B3UvOHL/+Vrg+CZv4x4av/IRhKVH0IFvmEXhpQ6mZGutgvelEbttM6UB52y4prLIUyHYwqLgrpfcmuLs6nsktwK5V8LpT2QNoPygpn5UXCxICEW4i1x9Dk46TFrSRVOvKRk6+OVHbBj5e5wgTJPMDgKJOoaBNWQ2VO+/2pAGtYDGLlRCyyYNVu+ypobeC3CuYxLDSeJ8zBd8NiTeqoSkgp6eYoknCwS0Rh16AaAlLFmARU1L7LPnjRAOq8Gj3q1/FIqQ5x784XH8Brad4EonMkYOZRH31BGVnbq/Hi6vPZOuoElyLRDhvLtX6kjqf4BV6/+sBK1iqxx2BGDx10rD6mOCqsYgjeoAyIK/9zG7tpfh9B5gLdICZwMJ7RCe6EgQCZ9U+CCgvjwFTPyyb1j6K8cLBD/z9o3I/E5U20n9G2+qtd1FofXMgewSzdkW+SfeFSk2MyOpwXPsoVgr6FrVW9CPtRo00z6Sg0uw6mglJFNPjA9aZ1FHV3bvShucN1lzMOoz2YKon0OlDc78LS+hmNilKE9EEAr38e6dbAQeWZiOu3hdi67Ae+7/s7trFTFa1XHd/JI9XNbMIuHRHSE2i0nlMGRVrVXUC5/5zyr2ScVPLKfRIZiH4D9ju50zfGcB6d6ZM70EMHk53rzAZhfe3l2Fdp9q962OTCWp7MQ5ylvdbpXU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:48:49.8922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd038284-1131-4317-2d77-08dc48ba9038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
Received-SPF: permerror client-ip=2a01:111:f403:200a::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

SEV/SEV-ES rely on pinned memory to back guest RAM so discarding
isn't actually possible. With SNP, only guest_memfd pages are used
for private guest memory, so discarding of shared memory is still
possible, so only disable discard for SEV/SEV-ES.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 134e8f7c22..43e6c0172f 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -888,10 +888,18 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
-    ret = ram_block_discard_disable(true);
-    if (ret) {
-        error_report("%s: cannot disable RAM discard", __func__);
-        return -1;
+    /*
+     * SEV/SEV-ES rely on pinned memory to back guest RAM so discarding
+     * isn't actually possible. With SNP, only guest_memfd pages are used
+     * for private guest memory, so discarding of shared memory is still
+     * possible..
+     */
+    if (!sev_snp_enabled()) {
+        ret = ram_block_discard_disable(true);
+        if (ret) {
+            error_report("%s: cannot disable RAM discard", __func__);
+            return -1;
+        }
     }
 
     sev_common->state = SEV_STATE_UNINIT;
-- 
2.25.1


