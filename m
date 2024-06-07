Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA0C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:52:59 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFeWj-0001J2-0K; Fri, 07 Jun 2024 14:41:25 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeWh-0001Ie-Sd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:41:23 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com
 ([40.107.237.66] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sFeWf-0004zG-PF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 14:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX5VAaqcKcPMPA79ONTSElfz9rBcW9HRTb9zGPAXvKav3m5Yzta4QRhBxxA8iASr/Ibt8w0z4GXxtza7Ji9kKaSzUDkwuA/6NuR/vcQp3zQpEjLkDqa4KZpUeIUe8tjc+SxxUhCwzNVibMnHOcepKiDsKUru1x47AmJjSf0dOzRXbASFUjsmZqj/IML1qFi3w8B68p/bqrwMtFbgQX53PPCiYhQ+PHyzAjAwHxP8k+L966sInGaYRId9EcOWW6t15qZ3G3vLWAYrb8W3cqmoVWgKpCtoHMhpXytDgBcxxIomFaCMPunNlMSzYGVkApYJNZE1w6RcL7hdSHNpg52fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoEPsBZrntgvpqMHJQA3K4x/Je9bBwc5EHsPTJpCPLU=;
 b=JPdxGwRPuBN9blwZCcc6mysLLQzq5TkVLdhJJMGutJKXo2WBOP2IN8Xg0duoHbwESuRdbIjjqlgShEvihjgcKz8VzfcrfCcEzOYfy7Oxof4KwgA2drD8sFw99Vz41Ff8TTU7ZMOHthJloYGDAev+LT+I7R/sKIELJpj5045kiPa/HHu2djJOVAWhXs6OXMn3xuYwb0cpdsBw+eHI3ptkYgZew1rZUU0tZBp5oHC3ZoMabnXx5PXqwjt5FLSEWNAn0eIVcpn/ZFhYhEiNKILztDGrNyId+r3zQ9BtQC1E1TFlikaE+dtMxcjyxGaflA3sJVFIQZCi3SsXtouk13NcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoEPsBZrntgvpqMHJQA3K4x/Je9bBwc5EHsPTJpCPLU=;
 b=lj5gWGCiKSQIomBX08yDeWGpNAPvmRq4Ded5FU8Y7UwdwIVARIf4+H3VLVHjtonC8Z0OUOvz/cwSnsYj304JbZyC9xmF+U7BIhEnEGqwp//ldSxXlYPC1247lYW5D75NDHc4jjkLCO6fvouX29MXC6X4B+JOBsKQ0kvXc363eCo=
Received: from MW2PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:302:1::30)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 18:36:15 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::ca) by MW2PR2101CA0017.outlook.office365.com
 (2603:10b6:302:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Fri, 7 Jun 2024 18:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Fri, 7 Jun 2024 18:36:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 13:36:12 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Jun 2024 13:36:11 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
 <peter.maydell@linaro.org>, <pankaj.gupta@amd.com>
Subject: [PATCH 1/3] i386/sev: fix unreachable code coverity issue
Date: Fri, 7 Jun 2024 13:36:09 -0500
Message-ID: <20240607183611.1111100-2-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607183611.1111100-1-pankaj.gupta@amd.com>
References: <20240607183611.1111100-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: b5644ca6-83a6-4a29-95cd-08dc8720b635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LW3cu4MJXFR9ZtyKO0rtkynD/KE8kL5dKEh+mcZvjxZsGAyCuRRT+JGjNA30?=
 =?us-ascii?Q?ujDsf0VF1BvmTrHdoE6MX37c4z6iQYNUAjfwqSTVkqP7wOWzGTnoqdyU8zYL?=
 =?us-ascii?Q?kupJCE9znQJfkeg7jUw3wy9XcWTFa+JfGw/t+fx+nQ4UJm/0pzKl50NZEm6g?=
 =?us-ascii?Q?CiZmMlPPnVj6DFmHwu6XNaULZrdix7DagDc/+CArzecMheE8T6xfeVOs/5JY?=
 =?us-ascii?Q?tRUhF2GteiViCdbU0g+KTRW1cWgX8tjerRxvef4ja++BIl0JB4iVahgE6yRY?=
 =?us-ascii?Q?r3+Odrf1m9H1er6hTj3RtFBrrIpVX3I5OorZVSe5D9GqHjZUxhp1uonNZhem?=
 =?us-ascii?Q?0UP8+fPF18V/3kBnFc7lLQM0RXL/mBaSZDEUrocmClpS9thdGIubvxK/Ftc+?=
 =?us-ascii?Q?785miaPqYRZp2CkmL0bxbrdpwW4FVroU0yrn2/usUH2bYX76Aup9cqQhhEzh?=
 =?us-ascii?Q?ra+j32CQpKn9/pGtRBRTR+Wl/tbpWKEirbnvwwRIlGDj74Uc3A625CkHtQm9?=
 =?us-ascii?Q?ckZNdc2ov/qgXQA6pfNl5gbUASwHdI9pVqtOw6KFyMz+Kyms17A/McfEykRv?=
 =?us-ascii?Q?EB//p3MhdFHnlPY3a6LTrgcRgSDdQnAffeMiaDsLzXsyRelHwD/HZew6Rig6?=
 =?us-ascii?Q?mtCfGm/c9SiHiT+DmlNOCvOwUcJwNZ1YyPdLLXqPQE+yOOgtEFzAbrK5T6sb?=
 =?us-ascii?Q?zjA4aC7wjFgEdSkDv2mlTeXOX6zkjlAzBVZP/73flIGR013bZFkf3CyDvqV5?=
 =?us-ascii?Q?32+qKXs9rfIKc2mAhYRgyd9eLRpZg1bSMZ6ijIUrp/XzS7jjZ6pBliXhLKD/?=
 =?us-ascii?Q?b3HSJgNwX6JxackJfAX8pimAgSUKi7HEvlKOjqdn5JyeMpoqTwXUMoEieS/0?=
 =?us-ascii?Q?A8SlmAPFyy35iB1u5OH1Jf0yq7ujeFnn0JFNeggk4YzfftdV3qlb9dD1Idyy?=
 =?us-ascii?Q?nP+HlAOQdCG0rq5anGMsTs0prGSvYHznCsEo77nCn/FKZ/I2MXFwxEcXiNXO?=
 =?us-ascii?Q?IyZoT9L2yHIpW2Qt7zKAN2PBT73BfyyoZv5sqSymIszmS0pC3E4dNA5cvj8X?=
 =?us-ascii?Q?PKBUUoAy7L6fh2zRxlzN7ZnhVn+cSjf3/pHSBf6NInu9NfkdThVzJtueQUyj?=
 =?us-ascii?Q?Y58lKC92Eztc5lyz+SdVc0dGqQCNZ2JWfHC3r8ecpKbRejwg+F8cyo3Z1qm9?=
 =?us-ascii?Q?nHVGhoFFH4KQcF/RzKklTNPz+Q6APR3O9yAZsAkytuQHNGmUlnn932mvFXw7?=
 =?us-ascii?Q?51vREdWZTiwo0rBf4U9g13Paxf/z7cPk25WMu4WzcW+f56J5AT+uZQCGO7/6?=
 =?us-ascii?Q?Er1RuccZoIrhLmp72x5bInXhpTioGRXFiIMBqAWY1Of68yPF2ooooBacEjMT?=
 =?us-ascii?Q?Hh/Xy5RKZwpqVkhm8krWwgq36FDryN136W17zf6+RYU7i4P8NA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:36:14.3248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5644ca6-83a6-4a29-95cd-08dc8720b635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
Received-SPF: permerror client-ip=40.107.237.66;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Set 'finish->id_block_en' when block_size read.

coverity #1546887

fixes: 7b34df4426 ("i386/sev: Introduce 'sev-snp-guest' object")
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 004c667ac1..7c9df621de 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2165,6 +2165,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
     gsize len;
 
+    finish->id_block_en = 0;
     g_free(sev_snp_guest->id_block);
     g_free((guchar *)finish->id_block_uaddr);
 
@@ -2184,7 +2185,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
         return;
     }
 
-    finish->id_block_en = (len) ? 1 : 0;
+    finish->id_block_en = 1;
 }
 
 static char *
-- 
2.34.1


