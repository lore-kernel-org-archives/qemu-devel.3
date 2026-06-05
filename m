Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBCACD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFv-0006NF-Iy; Thu, 04 Jun 2026 20:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFm-0006J0-7Z; Thu, 04 Jun 2026 20:17:39 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFi-0007xI-9C; Thu, 04 Jun 2026 20:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzKCF0neQyzpegK9Vnl6PZpOA7FBtupZ5/dSqGVfYyQQoghoFAIKszuDwdvmg0FksGzbAsRYPnDVQAbS109CNKl4POdqD4GufKz4atyC0B9AC62tYlg9eH2PL/S5XHBoF16b51fWKPGSY3532nKrmW3PzkHzP23KsMlSi3D7gDZL0sqNGBXOojF2a+HSea0Joi/wLkTTrC6pZ9EhLHAhgoVySHqvvftE6IgufuZOFgU+y0Lh77U3+Qy4Viwb33Fz/OYhMPSv+uYQw5qWWKfLJia6096lgjZU26AWvhXZw9+xiHAX3NCSaA3cL6T0Ryh94YthTvFweovdtrEWpYGhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvdP5JzRCtiiG35TT5wDqHawS4t4/HUDf4QJ1COx5kk=;
 b=qOOCWU1axdxbAT/fwKH+17ArNJlqRxDO7y2O866vx/Sck4L+JnVBWtLH2RowY5DoyVtozsxmO6xQUXilcSzWZDVyp8x9jNFIKIT7MIU3vCQdGjfQ6lUeYSQ29E4rwUs8ztE7hZ0eN3PfzpfeG9b3+M2X5AglMED87ZEdkIU61exbNgeSx6I1B4XzWwF4BoUt/6GXry5JkeicXsGGqh6GzVbn1MZdiqdvd/bhzHwQn969mkylI2j4eleGe/PqZoy6tKv3MqgnaUBOCLFO4RW2zy+J0aECOWd96G5ACw0Va9i48ZC3bhbW/KoaZSyFd1SG3FN/TNWwaQdkiXqR7cgmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvdP5JzRCtiiG35TT5wDqHawS4t4/HUDf4QJ1COx5kk=;
 b=GGoCcfyexttYwoeIMQb6wnU0sjdhsYy+M2lZSuq/92lgqrnMoscY5yojOR+WXfY5GEShYhvjdMoilP3ldZtcAY2qzOh/M5b6TX7cOf8a+Nfs1zJnZ8l5L111xgb9Jpke4s//35dV9EERnDeJ3JJMLyMXCxhNWTrTPq19e+MIWgLBShZV1VPRVXZU9yBsqBnKM+bibvtEnTOmOTEJXiS3ulP71RzWV1BfI33UqRLRQzS6SZNhCMaXLZn05wEpUBSqIvyXwO3U1K4DZE5O3dxYu97rEiE2sPXb9cK0/3iNFTb3TcWX6N/UzMpZUBUORDKvGVHONXNI9JblIYgwsba1wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:19 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:19 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, qemu-stable@nongnu.org
Subject: [PATCH v5 1/9] hw/arm/smmuv3: Update ATC invalidation check
Date: Thu,  4 Jun 2026 17:17:04 -0700
Message-ID: <20260605001712.1823737-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: f33643f8-bf3e-48b9-a5f0-08dec297ce79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DQKbxJv5MTFALAy81dzwV+Juz+VUZ17s2GjGz71CYoRBjRD+ARSgejALRKu6KUMaLRWEWHFvDyJUcgBj2GtmAFkLYL5DTWvjT53qzMfrjVTnOQ2bBCK5WQNaHqCqzvNbSp5tmN4GAbIK/+bKae/8GhR6QQlOqLs/YH3EWeSvmlz+VBL6wFPGepfsd9fDNYibDUMba8eUPfgXr29FSRaGrC+O8TtJSK0OuGxP4mfrvsLv68vMAzd/+p640mvMt4lnEHsAZFjhIvzw94mQCoBGjx/9rYnxMMSH6lseHgpOqRFjwYcsFdm606w9D9a7t7NXt7tcpzQfABRsMwEHEoDuZ4oBCMEHbk3+CkYFxWbfigRyEpXLZiaOLx5jIhHYCim3Z8+Pvx0jPs6TVgJnG1tGCU03mM0ZUlN98ZxdP+Iqp2cyJlSJ3MLjU4+duLmxe5zdynuo1JZK0H43AKJKQlMFYaf9Ncw2Uomfq2bnKDsleCQCGlF9hG+pxo6UQk75hZa4aQJ8RZG4vTLnglYrCqmZJEC2Hl+4HJpK3vqrIt4I89iR1trqhOhPeeL/9dC4r7rDuRdrPSt/geTTl5jU62i3pzNXaHS8gX5glLCTHkEvs5N+Oo/ykjOlf+vE5Pz6f2o1ixvVQIDBU0kzEmJoe6bcZFuldDxD6+C3WEAvGcBIw7c0C6MM7Tq8XpzkpKP/30js
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rT24JouodHkxxOz1Lep/ZB3PLDvipWSXaf+4Xcjn49hGR3G6vTsgt7kqXz8l?=
 =?us-ascii?Q?0yntTZ0HyVNvGXyLN+xxCiRpOAPykYNeutaCV6jqz1lpieHRfb3DnpLJx85x?=
 =?us-ascii?Q?tuzM8SmPqHak2EJCIiTeP0daWlCuEyiW6mjZuswnNLy/aQefbOO8EnDRUrEZ?=
 =?us-ascii?Q?rudurYYEmhXpT7dR4634snZexfy08DC9EM7W+zMrplHKL4XvhYExKtyrB5Qe?=
 =?us-ascii?Q?AjkKGL2BR6ptRIgZaxFQ3Pgf+PtvC1l/tOMh4JdfMmDhr7N94UQM0kRDCMAq?=
 =?us-ascii?Q?FD1aqT+P+VjqccGFNmP9wmX2wjWqREIS2Fy0BALTaO4SGPtjDZ9v093P3zVN?=
 =?us-ascii?Q?mHHGlUU3jd62UbJ6KRFT6XwF9O/4tfjKr58VP1Eiv7gBsFEduR5jGtYSNexF?=
 =?us-ascii?Q?WJAXDRBvMniTacU4hVXDPBRwD3CCDCVQzp6qHJzZmjjKS/ON1o3dR7/cmurO?=
 =?us-ascii?Q?3apksD2G1+9+DGk0AUb9Khva3dhk7E6yv6mIUQX7hU0T9oOhZLSLOhyPbUBM?=
 =?us-ascii?Q?lCNROa+BO5QoQx1B2QWEzQ7xY00KlOfPboHbPDFR1w8co+61dt7HwPHiqcBn?=
 =?us-ascii?Q?cFhryG6WIcZXt+r9XJ+p5/LY1HczeWt3N3kBx+2a7mARg9LK7GKoVrUF1z3Z?=
 =?us-ascii?Q?i1Qea+CFpVa0DrR6oDHH1jP+BoCWyrZvqF/IYCR6ZL+t3c7Fc3wlyqctmxpE?=
 =?us-ascii?Q?zU3UMJGRBTIkyE0H2d7QmsSCwPAlExrcnhpUvFqCzrPAtyRDMestG7oweNb1?=
 =?us-ascii?Q?cyiXyeWrV5Fj/N6Fvt/7ZaDW0/RfjTsnZ7rA/a/hlggfk3y6lKedvSFnfMj6?=
 =?us-ascii?Q?ou6F08lhcfnM9tu3kvtrP7JefQtp8o4glU9ChDin8cA/YPgo9ihOrpDtxJYE?=
 =?us-ascii?Q?e/3BMMrBTKPUWwUHI8Pta5F9WVFigwO39n1MVZ5nN3oWnm4MKqpX9BaEgOKY?=
 =?us-ascii?Q?W/5DDSD1gcE+Z6sh5GAlWT54Y115LloO75eGaiAFDf2uUArP6knT31CLd1A/?=
 =?us-ascii?Q?5GIkSjuXxesNU7m7iG6Qh5NYVzXrfRG0XWPlxaF4pIyFMgyMGBdjFBRFxC7M?=
 =?us-ascii?Q?QrjYw0SV2r2CqbUAEZ4qkXIlK0xmLJffOZ2mbRXrHJ0iQABPAMpFaVFBFYVZ?=
 =?us-ascii?Q?dUt8dNi9DzGRWYuuuhrLS0xxk2f/hOGdDykDPaT6gB643S1MFP6f6wuuZhE8?=
 =?us-ascii?Q?TTllpM+r/MScdWLyHsfz5MZ1w/szibOkHb+/wC4ihskrdlo2kBZ/PFoAGcj1?=
 =?us-ascii?Q?ys6N+iaKVoDz3uheir3Bu4JHgcUPQ+Fm37WVRufbRBv2tqPieGdbxRcOev+R?=
 =?us-ascii?Q?tqai9a2UogfmSrsvvwVLI2YGR4M/5PtsPPR+iO6DyzpDWQ7x4WaDC+jmOh4j?=
 =?us-ascii?Q?VUT0pVp6MLt0Wkmw8zR6jmOpVGEfDJbyvMfLe3nnEnDlK/n5MgKqelS/EOe3?=
 =?us-ascii?Q?P4EJ4YMAXvDp0kfoqYxAlOBRR+QeSgQc9anDNJRs/sWztZ7gIDjngQWX1698?=
 =?us-ascii?Q?uZ9dY0a0hXqW9Yigvq5INsBbI7EOnQ/dGPKfzuMQ3LUjb2eGgCjkdbF2XwVX?=
 =?us-ascii?Q?QuKMsb2B6ZuCv0o4501A3sB1VBMARPXZqcrTLP2RY3OrqpLOaHKuVR9ivJL8?=
 =?us-ascii?Q?2tXUUImrYwx9FwlwIuTGUoI+G/NtgOLMTA5FHa3P5rBtvgUGqFjOyw3/u/sr?=
 =?us-ascii?Q?/NFLEf/29EuXvIBdu4xIoEH1Zu4jifCYNBfXBD98FdhEjcDTgMYPA40dkOJv?=
 =?us-ascii?Q?Lwfa/Tl87A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33643f8-bf3e-48b9-a5f0-08dec297ce79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:19.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvSnv0a3/El20icq36Cw9VQYhhC6V8KakzTRh0gXzewaHBatqqJCka9RXygEAMaMs3WMFRy7tOplGQD+3Bk42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Use smmuv3_ats_enabled() to determine whether ATS is enabled for the
guest when handling an ATC invalidation command, as setting the ATS
property value to 'auto' will resolve to ATS being detected as
enabled in the ATC invalidation check otherwise.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5c2855c377..0c65dc8c91 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1528,7 +1528,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
         {
             SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
 
-            if (!sdev || !s->ats) {
+            if (!sdev || !smmuv3_ats_enabled(s)) {
                 trace_smmuv3_unhandled_cmd(type);
                 break;
             }
-- 
2.43.0


