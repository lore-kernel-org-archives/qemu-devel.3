Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5AEC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmL-0005xt-2N; Thu, 30 May 2024 07:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmI-0005vw-Vf
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:02 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmD-0001Qy-W2
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SioOTpnvwdHphJ1sp0uHuuWbfDb/sXyY48L6m84zyGTt85e4A5ag/khSexaoOuqPuZoGutK55SuzYPwPO7in8cihcZsPAmrBAaPDbJ7xgGvyTYKxsBHy5ubcXa2tNbXqO6dN99DWOln55nf/8Zo/6yRC75tiRpprjUxKZekS2o9Nl+ces4CrAVEDJl+fHRoEZt55Di3ksCuRgZwCmgmpdkjk4zlmNciqsuBw3F8g6jpNxMM2fIPq/rKXf/A7l8ViOSsYnM1iSbZNTn1ES82tSGjeDlr/b1oUKbScz/yQWKxz7x1QK7WquCM4bfNJWFndIYsTggNNosSeZ3YOeoiM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MUj7HUGNMWagF8RJh+gApWGW5TbAFgo1Owe6jlLlh8=;
 b=J/d4+85NR3EYquQGaLQ9KCJBYpRB76xT0GMqYDpOqRHGeLvuAvkbJwn4fh2n4L7HSSuwrMj0QsRPW+SD3D4L9MvckYQ+osr+pIm/FANd0PH5fS/00+zxL9G4erxbTJl/GdT3U1kqLzV5XNeMweNLp+UcTkBmeYdlD8dd2AFNv25y9JEooMYUGrfpdR0vlEx2Tly0o3ncpZFUXhz9APoe3hxqG2y5CUMOqO/+aiNuaj8lCU/Wt4tSLmjFLuIeEctWXm71nxbL66/x4b2+/TNLqVAqVz2Nm/ZcLqAwfhUOK2us/J1ws3LTp91xUBdwuztiaUgK8Uf0ToHsDHtsFr0ROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MUj7HUGNMWagF8RJh+gApWGW5TbAFgo1Owe6jlLlh8=;
 b=eSCo7WVYKyuIZ3R7KjHsLlC8PVii4XIVEfwUryrZ2HGgT328qsc8f9uNPbMwMvJKOWoCpn/cmfY/+4uH1ZvrIhNtpOUwujjo1CSy/DwUT7ytv4HGFqiTslveJysWpCDcX3vdWt6EM32Rg3Ul8XImOje0OYVPKqEACawp3SQ+MMk=
Received: from BN1PR14CA0016.namprd14.prod.outlook.com (2603:10b6:408:e3::21)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 11:16:53 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::28) by BN1PR14CA0016.outlook.office365.com
 (2603:10b6:408:e3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 11:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:51 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:51 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 11/31] i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
Date: Thu, 30 May 2024 06:16:23 -0500
Message-ID: <20240530111643.1091816-12-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: fa116370-f440-4c39-5fc0-08dc809a023d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPh7fvzv+MlEoPZ+Y1Op4PGot8xx3x/IJMq/VlpyVOsKwMAEtpBM/ENFcA1r?=
 =?us-ascii?Q?QpznHNrKkvQrAhiTqKfk7L9nYE8a2+wtnlqieUW5zK0r53r17taQxGkgVVPS?=
 =?us-ascii?Q?MqcXd08UaZYZMV0hDIDHYAlupZ2/I5MAgZ9UQPOguom0w2AfijA6M8uhlTNW?=
 =?us-ascii?Q?cvZBuBBEfvlpZrI9R8nSmA70haCofjKcnD97RAsb6w0snIREoIF3EhEb83U2?=
 =?us-ascii?Q?Jnmmp+mW2oK3lIVfNkB2BFk0IotIgx6SdweDvulsV4s5x9lYjHQypyBqtPYv?=
 =?us-ascii?Q?DTXPEdnyKgFCg+yjPCTIJW8v8DzuxUgO8pG/E1UOD1/3Ov/8X2OenfJ+ZbCa?=
 =?us-ascii?Q?tquThROw4EsCRcC/00fAt3fHUKlLPquQAW+vsuu4L8ZJwDx355rUxTYyGANj?=
 =?us-ascii?Q?UBCTMlhpKhI+ECd4oAoZRPsdX9PTRZXeHTUS/ZHmwlx7Tt1CkdYcTUvdqdcj?=
 =?us-ascii?Q?JK2Y328y4BDm0yysRBNWFC5jAovhp+3q47QhRj4goWixa6VEdV1J+X4yEKG0?=
 =?us-ascii?Q?srZzsk3GOuWaXObc4nsSNsGodqc0Qx0VnSzYQw56diq0481DZOw6cvg+Bqhs?=
 =?us-ascii?Q?H0pn2hSGvbUhlcNxwmOW9lxeUNXa/yWIAMk+vrWm1/jocAmiumOmXXOGXOah?=
 =?us-ascii?Q?RGUbnHe5gEJB6bboLwDm3hF4JEvHkEnRFv/BdUUZ1QsuXs7b7IpNz0El4Cdb?=
 =?us-ascii?Q?xv3mr7q1Pd+c/3a4hTf3OlXevGubXGWTGKFQlihdmIxsAmpsjMxKXgfXrV8A?=
 =?us-ascii?Q?AGz4LXRD+qKvODoRjzwCRj2W/Ps9f8CFB+XTcPcmhU6RQryzOyZ4cS3BodHy?=
 =?us-ascii?Q?JQHlSsAuEJh0KtOiuNviOYgLcAxZASbDy8pI4AdxCTg7Q6np1G+rJOidlCAY?=
 =?us-ascii?Q?7Rz21OI8W7YwPFmRCHCTx3TVskzE77Qacgo6EyEC4QeDkcsfAKhrjrzsVTId?=
 =?us-ascii?Q?ECMh+RCut/rlsgBterO6H0po2ov9iXWsEsTVu4ALygzPQc/ObW0WJsE9VpQ6?=
 =?us-ascii?Q?ASkuYx7lUlB5g7ocOkdu8nuGlFkz0VrXOfmuYYo8e07SVlHxX0lbgMotjVK0?=
 =?us-ascii?Q?LuENcGSj4SGMdd3GYn8Gpndm3tUfsyP0W3KTUC2jE/l1IsvrLp9TCFHSUXR1?=
 =?us-ascii?Q?MrwDHBcKuGYxXinGgQCr4FDkRjh2P38ZFwlMpGnqwBx+aBz6CGyz9bCqVstR?=
 =?us-ascii?Q?9mEjwhl7xOQ8yzTb6E7P2wBVvXzkVSkR5MiMgV9pBKcMkhgFtar7TIkJGNwy?=
 =?us-ascii?Q?raNs/pbEvKDmHiJjRMi25PKREtrr3eSIGKJoGKewMK6ILL0Ak+abk0BbXy33?=
 =?us-ascii?Q?giKrBLE8ZWcUxdpedAOrYoevNXPJ6t3AkYRsMWLyvsOsoTYvtwRa5M9QJBQr?=
 =?us-ascii?Q?mVzliuJro2jUWJNQk1ILVGGL77Zm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:53.0350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa116370-f440-4c39-5fc0-08dc809a023d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

From: Michael Roth <michael.roth@amd.com>

SNP guests will rely on this bit to determine certain feature support.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc2dceb647..914bef442c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6979,6 +6979,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (sev_enabled()) {
             *eax = 0x2;
             *eax |= sev_es_enabled() ? 0x8 : 0;
+            *eax |= sev_snp_enabled() ? 0x10 : 0;
             *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
             *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
         }
-- 
2.34.1


