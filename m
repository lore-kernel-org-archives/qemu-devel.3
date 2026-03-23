Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE83F483E4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyJ-00025B-VT; Mon, 23 Mar 2026 14:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxe-0001no-N8; Mon, 23 Mar 2026 14:25:13 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxd-00043g-1Z; Mon, 23 Mar 2026 14:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYjI7c24vTATkGKWrvC5xWIapdMo1bQ3AvsoS4ertx/Jx6bRDZ7GGVmL6nJWu7xmUUDmb6Yai/AHgQkOQfxbspJqz8M+VZIavToJfFTEYi96JnuZCqJgy5quOt6hiSNImgqM7buHMN1lxbHUty8m6cYlPH9h/WrT7LLOFxXrv4uNwWRhyK9CmGtspH4yaT2UARtJCUAAFcTnKEoZL2JcBjtiPIIgZs//7M0hPLrSb9ukSI4HO8QHxUJcML+Xb8TKv/D/9n1Ct5x9Ox1YPHdrfAJ13WZJ5UMX3cPknwT1Vvjy0zDLAVFusspUcO48CMetRwSq3ooW4bqSqJpZ7npJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adPRUrxXITFSkQUIArj7TzyQH9nU1ofcGSAc84qCnvw=;
 b=KAnO37kw5mTyzl0FIgS7qERhkUpWSbn6dk1+5wLGXMllG/68aI1t570eIFHTiPpEmOVOUYos8EvDjFopL7WIICoII8v1O1gVxs69LMHq1iXqCeskBBCvtXdSJbM8+hv5nDlhSpr3acSeR1BTKrn7eDdvtuGzXhBwp+ltd7pvIfNgSgbxVMJxexIG97tZ13x9ztbak1KpbGUP4VVafkyrGdjEs9xuzn4va/lfzFRkb1kpnNX8PXs2KdzW86Ye+gztt7nmYFUOHLlIeBCJsfoNaRma2eh2PVAjh5DTh5E116gFU6qfWAz3CCNFr38chzYO7AqlS1kB+CkGL/Dnxs8dSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adPRUrxXITFSkQUIArj7TzyQH9nU1ofcGSAc84qCnvw=;
 b=PLqmJEUZbROx8nVGoIwQ3fRXPCb2/dvDDgTlKCD12hWd/boUP69B809Wjrx4zoDRdtKdB2pQI723PMg7Q3tQrgV2FFUKkIZc1ozkt/7yYaZyXQuf71ctBBiN6CbTQErV4BF3CMoUcIucBPFPopHJgyW4KTUJLy1p5oc+vSy+w1Flqpz723rhXsVUyQYIL90W+nuY+pYExUrtDHFNFpwhaf5Uf5U6n3BJpcG429Y18R/SqIV4VbjghXXS8UA6IplQZdYFiJPgsfshM+1+DamZuh7YcZJJKiL7ZOFpo3CPFkulZ9XqI10cDANvSvO662i1vSEEtv8ljrSC3Qb5/sM8tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 18:25:00 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:00 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 1/8] hw/arm/smmuv3-accel: Check ATS compatibility between
 host and guest
Date: Mon, 23 Mar 2026 11:24:47 -0700
Message-ID: <20260323182454.1416110-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: f20952ce-bbb3-47c4-1099-08de89097e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: N/W56u5o085v//gIa3aCoRdQlT0bEp7s2NNlkoM8qyEh0L5vaZf53MyWyRCPqN7MK44W8saqSsy6ycq5oox6g9u6s5xk5oBuLEIDbH/Y5vbDGJc6WRqT339bstgpv7nD+JdVd2/r0frT7PVl4pVsYpulDgjd7E5R+uxLYqdvLFkrrIqNu1KHZCm+fbrvcfT+zHAw+e3vt0oDPPku+WbHOoZ8UQiTC2becbV6Auv929pPzOxkk2vM9QO9zHnzSWQcqlXAr1WIjK7XS8kW0NHzC6K3+BtRawYfWqIR54RFSRttjRacc3P+yARBciznUiwvdcR8yUEI1ca4oA6p4A9NJreBmJnGdZYLvwm7IbBLyN9ZpUEDhq+/xvRD42orHfvhRXz/oxvkXCrFGThlkDWd2Sz4KkenuWvSyEAd01QCWbHhGKcX10O3fDWglRUax+7jgVDdSHWNwXCagaEt5ilB9pSKRhvNE/9yp3bgO8l567w31ofdLAWS2jjgAs6j/s2iQYRcaQ4xlCuH3ziEvCuQ0CY5UN/e0khBVPd7fiuWIdwai5NqLWgE8iKJSuW5nLg3rDtMenQx7o/LWjeH8mUyE+vpNzJzV/2SjPAi/NDoCntbcMyOJZL9505RxCTa0PXkerc2wqumhB7mqfscAVuiSFxQKrD3l75J88tcMdffEQ9FgrqZrZ2I40GraC+xHZzT5lK1aCxklujHQ4CkQkFlD2ZgC524cqcT4WIUQYPdWTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uf8s/iu9G2YuixM4BCV2luuOlrqB8f7vK63k2gONuOQ0V87PgXqGmk4rDOfp?=
 =?us-ascii?Q?dlYnT+vlepkFbXcXFhH7kgIXpcLee2PVtnSEv+KbGjLAtI3fC9+rAm33Hdk7?=
 =?us-ascii?Q?w1J8xUaPYjdvrPYRUDG6akR1v1i67zjYiUTC7rfAHbeV+mh3XfoTT6pQrSAM?=
 =?us-ascii?Q?y2Ho83plw77Kw35QMd6R6uFHZcIHPmOkYBGx/7mFu7Bw9xv8Qzy2RDv5Cihj?=
 =?us-ascii?Q?sJCXjhJkOTl2RnkyvEmrroiXJRqaki2sZY8Cd4Khq3PDYMBT2dulpDusS8bc?=
 =?us-ascii?Q?ERjehiiK7XlTdHWFxpbUpfB9B3Mw/TCezGvY99w00as3OB+SSO8fgSiGzajx?=
 =?us-ascii?Q?CktOlNOGcXlxAj/w8fZ3qCmCQWDT6UAHhhpjHt1etqkipiYIRADYL3w1cdf+?=
 =?us-ascii?Q?ilj0omHreaSjay8eGeiMBiSDKhV6gc/LbMiqOZiA380w2rUUNdMRm9sZWJ2D?=
 =?us-ascii?Q?D/ARAC09MRGZFrXIzDTXdHfp2J1N/H1XkmuXBO3Q+dRUjTf56ZYLl7w4FyLv?=
 =?us-ascii?Q?XKxr5ZmfbfBLmWLh/HDZsYAt7StnbIMMiDFWGLWTFs3EyKfwK2HTYiuf+lJL?=
 =?us-ascii?Q?JmEfQEteddbWnTfjn3syKpEiGOv6i5xJ5YYuippq4Yo61qvjnLeWxfgbZAP5?=
 =?us-ascii?Q?IqojgZv5XzkcZEPLE1+W0tTwisCluBKAPWL9WPVhcgcIGNPR9yJpW/ayMBxF?=
 =?us-ascii?Q?7rHvkrUnJ8ZuYLqcU/wLaitF9cPPxu+F3EMlgWJ34rWC1azLbHsBE93PyjTp?=
 =?us-ascii?Q?4BJMWyPlEzx+N8ksm8BhO2x+tUIKROCgxkBltJo+3HkftaPA9Vtu9RMXRuCX?=
 =?us-ascii?Q?YGD+TE9V7c2CdC7oB6cAByVDeNfps17iaUC0Dp8fggKZyYL88EWPqTHo9U+e?=
 =?us-ascii?Q?479ezJVS3p2D1xZADgCuTGXmShsEW2W8oKr3481KCdnXrwh8eDw9nFXSNhPJ?=
 =?us-ascii?Q?PhwBt5W4YYeQQS8eKU1eXdoi7YuaVVPcxRQ94inf/9ZOEo2+ZI0wpWl0Myn1?=
 =?us-ascii?Q?+rwqudspcschluUdbrcfBh4UKUDKqPJDvlL68hHMAhSWdszboQM0xHxcpkhS?=
 =?us-ascii?Q?jTmE2RHGKFk8mioYSVOvXLdpxIao0MkZwpAi7TetehsUpw5lZ0Cdz9KJ/edz?=
 =?us-ascii?Q?uyCR8DnMR38RswjlKAIQSfsRnbHmhi7/imG56ONJgJ5UAXBaGhg78ItT5jN0?=
 =?us-ascii?Q?N8IhEoHpmwR2X6RF8GsybuW+IMrGjlbIOxzmpaIw88ThIMNLtpGTl6R/aeI/?=
 =?us-ascii?Q?2rAwFAVYSsLVVp0sHz6HzLhf3JQYZvk3AYn3fKE4Ujfs9Cdn8u1fwZ6lSuXC?=
 =?us-ascii?Q?Fxu+F++/egv/KpATSKzpUJ/JWjxiiMpdqm9muZwPAxEYX5b3p/MdHX5s1y6R?=
 =?us-ascii?Q?sEruHwOsmc3tFW/RBhN7+PTr1/X45Ja8VVGga3p2RfgEskclrcgWyn4FQhDt?=
 =?us-ascii?Q?8aItXCgkoaeBT4wmDP/9GZJUdrWCXZHuP43Y0A9GGuQ5TtZ7O6yovna+79eI?=
 =?us-ascii?Q?Z2NbFsDT67M4d6/un0wO+T2YZzd+in7NyQXxK8CvvklOIxWEs+AtY5yENy8p?=
 =?us-ascii?Q?wHyl6+/FdW+RsGKkSmMJIyhiRqC7E9l6MFkABECDOX1jxvVJMS6VgDuIc8Zd?=
 =?us-ascii?Q?6Em6OlyIV6G0qrwu4TxQCkyNEMnwiwQ8tKgH3Nu+C8bPutWQNyFF9vZxL6BC?=
 =?us-ascii?Q?DxvQ0oqyQA74X39OGUYjUSh4JSM2tRW2oTu83warzbD2pFbWSxcH+onMvX4U?=
 =?us-ascii?Q?bgyZBreqRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20952ce-bbb3-47c4-1099-08de89097e93
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:00.6172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxIjLHiyh6V7l5TiTN8sxBvwrDH9zFa3dzWpw19qpsiK57AhR9H/8c9M1rrc/f9DfB0gmtC3hZu/5HWzsnyVEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
bit in IDR0 and fail the compatibility check if ATS support is opted as
enabled on the guest SMMUv3 when it is not supported on host SMMUv3.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 17306cd04b..2bb142c47f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -101,6 +101,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                    smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
         return false;
     }
+    /* Check ATS value opted is compatible with Host SMMUv3 */
+    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
+                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Address Translation Services");
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
-- 
2.43.0


