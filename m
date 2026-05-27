Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE3CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYZ-0004hc-Oq; Wed, 27 May 2026 18:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYX-0004gl-A8; Wed, 27 May 2026 18:16:53 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYV-0002I5-UU; Wed, 27 May 2026 18:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9N+/bulpVdLC2JjzAA61lU8pwM4Gn0p1MU/o2xK8NOQk8cIfZzrT+krjcfm0VLEGecRR5aYe48WB1hlW4eZR/Rg7aRSG6Qtqgqd50WgxkfRQDdYMdmR+OeaamtGMR8JFNvPaE5wzyuA28IyxpiUb8sraFh8BCk8VV+BXU5NGTfAYhdvWzusKXqmUDLcvaDQKEbZMTmXW6DYlEkxPplX9PveSJYjrcJQTsG/L87W/ljOwhNd90CjmcxH2lBDPBt9aaGvv4l6ishR30m+crgOXU0UBqYVzHa5nrve140/1UlD+lMi0KLb9y//9P+5Smwb6BAPdS16mKLE3KYy14t+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Wkc7yf/mo4n2+QI3YZ2y29cI5cGezGD+raGNoK7Mmo=;
 b=ixTz+8TBKIPDq2z5bgiiwg5n3XXdNQ3A+2xRxiq2hOUwo6yd0HSgECqDzXu/dMdmJBiVEcj38KJbIGGoUifOc4x5J5SajTaHP+dKw0FbAFAGc6fnldeBAbvzDF5eOjSFwZfpyeZhOCnyqzumt18vEsnXED9zeuVEoyJ+tloZFGynxPD7d9K5w/Wz478G5tysvNKdDv2+APK2sROP/kQH7l+jJusyPqzBjH6N090myv3N423pRqWUL7IZDAHZG+UWpId8qF216urmFC3a02zaUw5KSp1tJ7EfxQzJ3TszYqV/gYKvDsxJY7ukdL2Cja4sOn7cNHHBtVm0910EM9eNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wkc7yf/mo4n2+QI3YZ2y29cI5cGezGD+raGNoK7Mmo=;
 b=H+SEh70Q/vbPaR37B0P3xiesLlCtTIGN5NXIEg7bvKmnNmB3gJn5vVU6j3RdK6ogOIcf9aNS03GWlbRsEHQlvbZB89ruV4AHVjscVGwD3JfNsa9BpmWzZs/S2nAs8o/4/Nn4OgYECTRAaXBF0+cRvMgXxnLPcd2etGxCt2WRijP9Rvmt8ntDZLzI5XrTgt615tZPIGefJzYeYp4/aIeP87c7isps07FVzaCwf6CgWtz6SBhXeDa2RmpmeQy+QcGjaIYRMSP09fYY/xg+DVjA7tw4B93NdHAeXQg/oItr7XQB35bNgfAHpDp5rxmNrXKklB+wB5gwfsgA6mnwiVE03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:45 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:44 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 1/9] hw/arm/smmuv3: Update ATC invalidation check
Date: Wed, 27 May 2026 15:16:23 -0700
Message-ID: <20260527221631.612026-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d533f45-4fbf-4517-140e-08debc3da28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BtJ6gfPGPtS1KsV6THyib2QPDsxlBfSXy0vavq8+mEY+NlCVREhW0v97/S1wb0vESlev2b0X+w44OlxrY/jsZp0/V+tmYgjNjKwCn1gOou4/WarCCKi4/874/2gAGP93pJdY2VKYgQR2wgXGhprZvAImzo+HvkItVcbkroy7nNz9D/BkkCV3hbP7y6Quf0GGXMAbLKHeVLKQQ6s718BMfUVjmdmDKKvIPSxyU7D4VOyRNOFfcZRfpxwZAE+I/sX5LmKPceXraxttQNz42/od7gaLeA/J+dchiCQnNrF4zA21rugMZqRvA1jnZaZ0e2FZoUUw5VdHvV4n8KdWe9Fa4SHwJXKETfejOERhFw6y3ABB/g0RMmnTPwJVlrfnnuVZM4Icg3kmcK5L7c/03qj0SVzFlrsbbqmb6551DVWCLgGVV4EKQvgL7QDFdg+XhYXggeJLsYoUnO5gQNv9Z0eVZKX35dA7I9Dsr7k2dtJn4sNsZn/fBpFdKN7r41CKKkDQLHwt1oUW7OxC4GpQ2nRSvG3SdWwn3GBXc3xk4Jku8AtyW27JPempU8UiyjdMuUzOfdy4Iq3qkx9QZwTzmCrH+/xhowHFhkLqzCkzLA4nEXTUnUdeuhE12OXqDUSwUe/5DxiNTzqx+f0BS3GAzqogPttG6hPcoRe56XpIv5Ig/FrQZ7qzjIEV7Qsq1TgeYZPN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AH32yVCDkIp2BTS22IBpzdwEtd1tyJRRaF6H1nuJMam02f7opvwRn9UZSBU5?=
 =?us-ascii?Q?PdO5kpqEaQisoKEvWyTD7nZXVaDfCj1xtdRG8Av5eT2mQzt4d2gFNvTRZGR3?=
 =?us-ascii?Q?13R+8VrYCj7rt4BcZpYmdePREXbNMQXXMfbqvVROkvuVNIfFD6/UJQhV64f+?=
 =?us-ascii?Q?wBU7+yJkqmUIFXGmKbMWTy7jnnCGi/tNxbr/yZO2b5Dq8F0AwftmyCvRcVha?=
 =?us-ascii?Q?R6Dozs7QE8Plgaa6NBSTl0Go8zIgvUL/4AJX5Mai2X2BXj2VJGyq13MjExdf?=
 =?us-ascii?Q?TAkcYsa1C9n+GLlin9r8GbXDEbu+O3MBYLJ1KxBTtj1nMRD+3r1Wkf7SdHHS?=
 =?us-ascii?Q?b/mBjLBkNhi2NZbkXQsyGtyQ/hZI2ETsprgwU7bsmkY2IYPnaCjb/uHE3qNH?=
 =?us-ascii?Q?PPxT3nSAZOj0r0aCiMItguN1d263FQZ3rF2lkeNo9LmBMnFkFgdrrPOuWaGi?=
 =?us-ascii?Q?6hDmZY5ShTlxhwR0kdyKRAyTFr9BFn+Rdp5pq/Otdn+PIheG3lxEoDhvf+Iy?=
 =?us-ascii?Q?juI6pckbTh/Yl7wTCQXtxzQpTFcVlvil3eaRV4gLe5vhUaVQ92Q/x0L5d8gy?=
 =?us-ascii?Q?wC6EBKQY3k5Gg+T2higfpNorB9CytNXAugTQ38vZ+rlg5zvBg/KX3l/XZm8Z?=
 =?us-ascii?Q?G4Bxs8L/OywlPshNToV4yIq/U9h16Q6oCB44//w4PDJN1vE4ANMF835lEvYC?=
 =?us-ascii?Q?buuqacX3pulKmt4KPTyLw7bVvbCugTxJ69S+zWw45TTlcFzQdY5gTUK+ef0B?=
 =?us-ascii?Q?jAN8+MOmAthg+Lp0FROO8w8TPx1Ct/RO5EuHWE8g/yPxCfVYEO9nKC+jLjP2?=
 =?us-ascii?Q?HBRZWx+9b/cUzh+O+l5Iii+brUOARxQm8eSToiVb0OwkMQJToR3xdTpWUD5E?=
 =?us-ascii?Q?KK+m8R4xlFLnr6D359XA7iYZyr+FQnDF/I1JpVKoKd0AlXK1yB0coRCEWjUI?=
 =?us-ascii?Q?j0Rgd2RTMyON3KN2VK8w3ki6uhsgVaRkBjFBJGOlI/KaoGq4R8UC84P7ucUt?=
 =?us-ascii?Q?Oe84bmuk0Je1pw5/CV2s3rhLGRVOOPNTgJuj3cMgHzrVuzlZAj0XObadenqA?=
 =?us-ascii?Q?egjL8PuaVJ2wXoTI68eEN6Sx8WpJS7nC5Fc/BSbSTVcxkXWea+WIA+af6z3f?=
 =?us-ascii?Q?jwNGTXDZRk0tKgBXiDi1DujRCEq6jNMWVn2N0lWOBQ0kblw72zYvjmzQaIhb?=
 =?us-ascii?Q?pQe+d1yPcLNpK1WZeh++o274asLxiigpNNwnyT4kMI90iheoQxj0EDX27uJl?=
 =?us-ascii?Q?E8Z70VWbIYFjNo5WLi6Hs2Y7XXFkMkMmji+QTZLTY18M/7XOMzqU+XVl5zSB?=
 =?us-ascii?Q?S9rWElz/2n6IbumdpNeixI+iF1E5NLd/UPVn0E+5TkyhUKDmLFPqc6XhQPWB?=
 =?us-ascii?Q?94SC7LxhUc1ywpgZNe0Jos/wwas39WPciq+yrRekp2BkwNFsoDXdIUsyjSjV?=
 =?us-ascii?Q?vQU0GB41L0rXlQ7CdiFvwRESW+OJ1k3S6OKQ31Jy3GvQUEmXyfwYzAVUeMRA?=
 =?us-ascii?Q?n68aiX//h8BA4KDm9owvGlOyFZEckekMFpDDULNXqAF8rFYaVKhTgC30Exzg?=
 =?us-ascii?Q?WiD8OAvnjyNX4pkXzmWQteTBJfQNN+QefT6QzCG0aq/T44ietT62CO35jWBZ?=
 =?us-ascii?Q?+jZOFETYW31sVIFZLowunvAyIPttzVQ7BRj3jXWeg3S5SweCg5clAg5qqDyU?=
 =?us-ascii?Q?nI00v/XN7KMcPCYobKXP71gdv7E4grez0lHgk5EbfAMIISl70d15I63j7sWV?=
 =?us-ascii?Q?5umTn5k+XA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d533f45-4fbf-4517-140e-08debc3da28e
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:44.0673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJOqT8HqsF08s7mZ8STSs4o3go6V9M4zBGvEneJJ4qSG/F2m7A0a5fz1nYXmi9dTOx0IBpTC5PK2L69Ns24Qdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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
Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
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


