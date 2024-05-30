Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517A3C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdr7-000273-Ua; Thu, 30 May 2024 07:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdr4-00021w-FW
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:21:58 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com
 ([40.107.220.67] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdr0-0002Mb-WE
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:21:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmg4yI4X0hR5wxxil6w6dwHF24qvhP+DRKZNLe0JV7p6JMHjg8NrAV2eRF0btQ8ttJgeLbwVkhX0iDWdhTgkB9Ahuu1EjlPYolY8YwIPD2bsGbi55UdDtbvo84rK5BkKE096icXEDTIISReGCa1NqH7dtaXnIC3QLV7GaSMWlYl8AYar95+JWFZawhBGxMUzzpj4xDHndvGdh/g9nmlwcBEBBMykZmQdBz73mNOB3lYtmR5QUimBbOsXpPz7sL8th8DUqSv3BfY6oiIJzHpkipdrIlglkgdmmftS7bop0cqYoWDin/HKaXCsVUfCuJFjFZhTmh3tpBDI4BF3f97s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHDPUk3qDcJUq2+XauMilZ6tBTfb5QzNxjQVcPify5U=;
 b=naVuXZW/gqis8LzNym8UGdNAHmBLQ+FOmPMJuaZhkUEADRlW85WFNf7wPnIaKv5d4IVK8u7a1sU0NN1EYaQHUSDxltzkumkCL4PHa38d5RDz5wwhtVK5XkUkO9iSNWp9YJ0kp0MPudXHP+kBLTVbb6q//61XijOLfh9KuHfY5ks+8HVDYvIjTQyyu9APp0Ck4Pro6UIe7wqUuXcGQH7lQ0Uhj2KteKjX3kaCNwgRko5eP5MAsWUngHTmVdV06AenlIz+TCtNdnBfnOieE3+Yx32RHTMh/KCoVSqRcUo7z/tQrGnPvve7ai1Q5MJcuTliSLU5p9SPZZw1lum1eLs3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHDPUk3qDcJUq2+XauMilZ6tBTfb5QzNxjQVcPify5U=;
 b=1L5ZO1qfsmHjHUF/C2F7CmN3M+U1pgthcs3hPAeXWDzvheDkW/gxVeb1Qs7/MgAcDXNwKx9m/itY/E7quAiGpnvE/ykkTqL7KPitsRS4TEywq6m7VJ8BZrRpPEetWYcjAAJv/JPamtPKUsrGjrKFlLOi8drQHUz3R8DvHn/YTps=
Received: from BL0PR02CA0137.namprd02.prod.outlook.com (2603:10b6:208:35::42)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Thu, 30 May 2024 11:16:45 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::50) by BL0PR02CA0137.outlook.office365.com
 (2603:10b6:208:35::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 11:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:44 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:44 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 01/31] i386/sev: Replace error_report with error_setg
Date: Thu, 30 May 2024 06:16:13 -0500
Message-ID: <20240530111643.1091816-2-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f98420b-847b-4f10-32a2-08dc8099fd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BA2Ft6ME4jmqtZN/fU6pUCOLAsMt5ivr0OoAmH+RF7EjCpMP1MnfMPpTGHco?=
 =?us-ascii?Q?C/4ghJuUfrUHHSpMP8RuQAY/V/nQPtV7I1cYvRQMaREDexU/t25SAzDEmtZL?=
 =?us-ascii?Q?Zlqhox6/GZyf+B8ehb8fEwM/FKQUY72cRQ0VERON1NZcvu5VpqIP5bkQi/U/?=
 =?us-ascii?Q?8E75Y4lz4M33M8GuYG7upNoL4jnvZQMLq0wk4jK77S44l8j+7xnDfjAQ75mR?=
 =?us-ascii?Q?wp7A6uDSulgDrsimC/qVkR7rHYNBlui2neTf7WJ/ZuZPsTGs68aVvO0SGaYC?=
 =?us-ascii?Q?+nKYnQAT8VXHycJO5+DjIIdZqRZfLA01ceXqkasNdb5+ozWYyFMJKSkm+tUZ?=
 =?us-ascii?Q?CY+r2gcwbslbmUp1OabVsdr+65LokycNApOBDzsYgGY9rFqoib54le0eqSEr?=
 =?us-ascii?Q?XXrO4M1/qnyDRqOMPCX2QaH5AE/G9j/doK7zAcFIzMpUWh8Wcl111b05EMAA?=
 =?us-ascii?Q?nnwQIOnOLO1psPyPfHdSOOtnvJNmorEEmajRcnsmr+vC8EkzkCCjYcXSKyVa?=
 =?us-ascii?Q?1Zjlx47bFAuQNZYpP5yoQf5fjUd+6UZugWs+ewTPmPMFp4inCanKZ/CTOiw5?=
 =?us-ascii?Q?1GYzKhouZqz1urkfFOWwUxtVgASOBYLTvBxirHCEPWStufxwRQ+/BqCKbpLF?=
 =?us-ascii?Q?4TE1L66OpWci3rQTyUMev3+Q4POOltHthUA+NzNAl5/KtNtNOoR2AdR5ltUj?=
 =?us-ascii?Q?0+/WQLnU87Nc1mXUljtDPIz4SAjwwktBnK6EdNJ3L4WKzEcE0JeVofgAlPfY?=
 =?us-ascii?Q?0u+dwqGXSiZUADQAIgnTluBQ/KEh4AhNUsnfxs/Yakhqkbu1SQiVSZwVJdPj?=
 =?us-ascii?Q?iZKSMQmgwIgHZfJPhdEdsTn+t+7RU2xaFcN1ce4BV1eECWpWVU6fLp/OHODG?=
 =?us-ascii?Q?2kc4nheN9h38XVIPbxZGRJsbZMKMn0k8PAZm4AVeiGSOA+QaeUgfiZr5PVdM?=
 =?us-ascii?Q?p/HC0ssZzsqX46xPaV/ux/ZFWL1rUjNijZ7KOi1OUOcE4BkBrqWNYvfGLCMj?=
 =?us-ascii?Q?199Ms8IGjMvWHa/Ew8jxM4TZQD+AI3+0PFyGrwYPZzW9GubgIQzbsrrcaOsu?=
 =?us-ascii?Q?ORdSwCoZ3gBexnDG2LABSST3tz2LL9/R7jBCvgzNUMGqfGze/Eo5syRnyzQo?=
 =?us-ascii?Q?Mt7G2swJVcWm6UYhEfsmcaEJSJMcNEldPLgYk1pgoy4YNypEP5+HknFDGwq5?=
 =?us-ascii?Q?1jIoK2c27HQVdQCq4w0SwRLgjfCi608YAp1bWVqRicYVQqJ8wcd6gB288RlX?=
 =?us-ascii?Q?DWIthGNld5M3JzBQ0fo/2ExlXG+JO3ZOcIwAUzZGl2IUt1c9HqG4S5OuCnnv?=
 =?us-ascii?Q?NLguEc0JIDawe435rkIoZC+KrTuFtisXmgKwWspzgNp/4w800JakjXvdpk7F?=
 =?us-ascii?Q?M8NyM8g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:45.1605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f98420b-847b-4f10-32a2-08dc8099fd8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
Received-SPF: permerror client-ip=40.107.220.67;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d30b68c11e..67ed32e5ea 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -952,13 +952,13 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (sev_es_enabled()) {
         if (!kvm_kernel_irqchip_allowed()) {
-            error_report("%s: SEV-ES guests require in-kernel irqchip support",
-                         __func__);
+            error_setg(errp, "%s: SEV-ES guests require in-kernel irqchip"
+                       "support", __func__);
             goto err;
         }
 
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
-            error_report("%s: guest policy requires SEV-ES, but "
+            error_setg(errp, "%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
                          __func__);
             goto err;
-- 
2.34.1


