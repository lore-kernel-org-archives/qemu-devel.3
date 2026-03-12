Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43C106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCG-0000nt-Vh; Thu, 12 Mar 2026 17:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCF-0000nB-TU; Thu, 12 Mar 2026 17:03:55 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCE-0002qm-CP; Thu, 12 Mar 2026 17:03:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEuzsaqqXz2Ft1lheE1Iz59vYdRdTkTRYG8bJJBV5hiDG9Hd6HP+NFy0/zZtPq1ZQjQ5gvpFHV6SloxrG8BX/cYx0niD/NMj1qz/16qzSHNc5WRQaN6wZYw8Yl8B0uKOlCw7IDpDMQHJR9H1xGwwQzjncw1WfSD8IPH2wY5onfW5R7SeGCfB8kw3Ap/6BLXoWQyBLrnNTOrKPqinCyiXy+swyq6Za6T1CbchScSF/8Y+TaWNCCyiu9wLU4Cqmt3xBVWnf6xw+L2sg2ZRza780Ag0u1NIRjhFm90ZGSpwyVfSiJT6MnYcxsk7L71FLr3eHc2kKP0icEIn06g0U+lwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm1TkqD2AiyrQSUVeEI+qDYP955TWhA+Rmtd+onl+TY=;
 b=l4k+AFWiuUp9Tc2LYJhYJCYBqe/n/VwyH/gJm5ckhE2zT4zaJdfDlGQ0Q+G0FdL0hEcPsYA8yD96KReCSm+O9W1dsb97RYjqbeInBDgJJhBsbaeg5E/1sVfSImr7gRRAmdfz6WTYX5nRF5RXJIuPD/zyV0AWwSDdFZ28C++YrpalJ5PzHQHZNIuzK71bzWzcYPF47gxqp0jwqQL35STsXNq6gcvwVBXpwg7/MUhnO1mko0m+hhDeXGjG6tuuyNpK9xXhbiRhU0tTkQoBYM4If742FTwXG276lCFwNGFZ8jJQjK9Qa7/UX6oLaTH+QnDZsJVUZL3gtnbkneL9eZRf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm1TkqD2AiyrQSUVeEI+qDYP955TWhA+Rmtd+onl+TY=;
 b=Rcn5NrFQmvq89p/MjdPCtKzrGh+GM90DFf730EprqzIy3U6dXq33u+q2GLBb3VnPUw5Q0FoC6G63oB27S8avvxABuv5OEkB3nl3upuGpEp/PHaLlSv2QPqGO5gW/t4zF/nffvNbIdI6oVogP95QIRtolHRhW0CZ3D5xcAoVU9Pd6+XVRqhndIonCKCVj4d7xlkZxgap7EN942DYdwCf9fGtbJ/VNVAKu/ByoNatNKSMAxxDp3+y1UazT5UlY8sHjRZodjyHSaWmkzlEa7asJBOZufrJN5kMzR2YBBjiicBR+4V99NVf1xZeYjDhTeMbKY2su0/mfXMYrDJVKmoEzQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:47 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:47 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 1/8] hw/arm/smmuv3-accel: Check ATS compatibility between
 host and guest
Date: Thu, 12 Mar 2026 14:03:20 -0700
Message-ID: <20260312210328.2016191-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ea8a28-9cc0-44e1-3a6b-08de807ada9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3TWohe2RXa8tCBseV/Iip/4s+a9YPq1DtMZRpk4AiVzI+nyhCJ6CuPxfpNJbz8NmpXU6h+yDBq73skGTi7aSWWwnWx0uDR4BKnaQDGAMPH3Rra9BgcYkVOBnVWLtKToM6DiWkSra93bPUA8pxqQfm1RoxFvkNpX9mCIXQqM3P89+pM+EO7jiPR2waK9qE8CKIt8n0M2yoXSX6EG4F7XJdhR9JxfAxTRVygWe7f/5urw4VOZMTNef1IxU7Zlu1vzkz2rlsdNafJCYP2rx+MRfVIbFvw/ALmXipVbpJZUkSo+92iXA48yhjbgKyyiE2GM3WXgtqllmGsP329m3UITKHq9fHSInPUKNkEtoVm93cwrKQRT2FEufFTjqyEbG2LyaKktilpenQNMKriyR7KEh55vX0I23EwlGmJrSHeHS+PHSACOjJNOk04yarpDlFKWKjrW3m3CTR6pxnwmboEb4hFr4iaOmCnXKOeT2dGzX1U21x8YU0rMgZL11VDt7tNDQmrH+gCgPJMD77YpSx+NhcA+RXaSRZ8GxHDO8m1X7PKgLkLAhke9Tc6GKxk6N/7t6QdGV/GkE8sbgQrgjkB8NSKQ3SEIqxsfV1sBn8R7NUE6agYhRuzJuT0KqIgcgX8/M7szvQqnEZFVqpafEuXJ/IMppg4/GesSFDZR+5gDu/ghVwfgTvyo5gkg6D7IDaI6Z1y4tmGs9h4ytU4LgYGVfNS9wPGXZTN7v1W9JePV+pCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/fBnKPXSCQqxEM5tyytxivB8gUl/CMhuiYljFkISfdbj7kIxBCxJDfpL5U/?=
 =?us-ascii?Q?Q0bHhGTI2slCMWKLxEONu4X1N3AINubeRR41n2ZTi2oNfJAYrvEmACdUyaLM?=
 =?us-ascii?Q?HVRScYN1i2doBxqRHrS9lUqz5z4KeD4+L2ilnGdRq/5B4FV09gE7ougV1dbT?=
 =?us-ascii?Q?xbxw5+ZlSnQsGBcyUxPMYn6Al9rERZVN9SvDDPrPKhY31J7tq5cB8IJk3+7C?=
 =?us-ascii?Q?mrkwPyqD7dnc0bUyWa25L07ofO1VSq33OHj56TFDLNMvaZ9y7LYfSMlVnn9v?=
 =?us-ascii?Q?XPWHtmXVmbctRkj8gHBuCYxmF4RPir3OeZRnevYhGMMmlit7vIZx3YLKfnOH?=
 =?us-ascii?Q?ZD76AyQYAh357uuMvHk32IdB/nvrC6Xj/yEz+0PL/zA7jOdrpzun6iiV8O1l?=
 =?us-ascii?Q?HBfNSAckD+BqlLXOdbCgnG2s4G/P5qpQemLqawvnCMdmRZQMhP2avOr+y8Y3?=
 =?us-ascii?Q?hW8Emaq6Xm+6OH6shmgg46tGdHXwi+WmSsE4jjKJCS1SVvss9obNC38s3d6u?=
 =?us-ascii?Q?dJvrzeb3Xz2F9YX+Zy4ncUw3CZlv+gBtsvhVp+oRGg2+42AV4dq/ATGpmH3Y?=
 =?us-ascii?Q?ULmk2MPbsQ2HxoNlDbe6bpYsYVSNtCdTTa3wZzCTRnUMMd8MeUY5YpDaRXjX?=
 =?us-ascii?Q?s00hLQ/qVk3ko7+uiUx6izVUeEgtyXRmZBoc7eqInjwWM+1DKHtO+fev67BJ?=
 =?us-ascii?Q?vHssCtKnCF8je/vEsNZaqy0wxj0YAS1eofYP3S82V9hsuqQZvWXJOkppfV5k?=
 =?us-ascii?Q?J6s30wJNpEc8V/0L5hcRSLDpG5GyuaL4Pn1aL6SHfXNJQrN2oRMxtLsWinlY?=
 =?us-ascii?Q?uI6tC5ooOX7HHu+pk0sXrcf+c5JIBnybVq3bqE7r06WOGL53orG7/cwFgwCA?=
 =?us-ascii?Q?DPQpq4D5Gjc83DMJVwzp1RejybzvnXLiIQ3v5qz5IM4HmhThxaCrV30v6MRM?=
 =?us-ascii?Q?nkNU+mx2xjl28cQ4Qjz0oOQXybT/mF2rj1oocmUM0d7HkuARHTRsQS9WQ967?=
 =?us-ascii?Q?erA5O1OfVYwyCEd28TLl+tvoyAVFHoO0wund81OdTOITgduLxiH1w0duN0sD?=
 =?us-ascii?Q?Rie4UE7aZ8LQRpvmpjumQ9tsC5gGHT+dPm9aP1RoF4Q+scxqR9Lq7U+lyWSF?=
 =?us-ascii?Q?Vx0C3JLHnzf5ueHEUJNEKYce1RwxHxrDQtx09gNa3VD3WeRzmgaEEePDS/Yu?=
 =?us-ascii?Q?Bzk+4tVssGwsaLFGPlOQ9XZchE+gXfswZwKR0GvUy1JcKfLp7AF4dTBkIBrq?=
 =?us-ascii?Q?9aefgjLSKRPuEIhC9GiUuxCzLCUZDFD0XnwPiOEoUUX3aCIr6OM6ULKVWYlE?=
 =?us-ascii?Q?igTcgKrc0fn7cRemOvvGDIQiP7deZh0gfjRJp0sXyvImZ7iE6RhiaUg5DF2G?=
 =?us-ascii?Q?0bGvTA9o58gij9jRgIIaP81njXEmMOacOVLklGpUUTRERa4MngemhnQXUDKZ?=
 =?us-ascii?Q?Vhi/rdl0xr7SAD4rzJ9400H7DKQh137Lf2S5EV2KGqFbjKX6xSRIwOKNIfye?=
 =?us-ascii?Q?7TnwW+MjjGQ3YyDeX1XJJk3PsY8YPufRqnbvEpHLD0RQ7FLow3DLGcXxfmRg?=
 =?us-ascii?Q?vifPejf/4775JLGoqg3UW9wwa+ZTb1WGLPoLHr2jknpuGTEe03Ue6pv+vBCK?=
 =?us-ascii?Q?rh0gpTZ8775xvsaR7q0J7oYLdwAG+uyvDMEL5iDyEQuy3B2WVUjNP6+kllrg?=
 =?us-ascii?Q?0onkvXHwVfuRsMNwsajk0mhWqi1KuYCxogpjJyuR8MtXbB0hIMSSyYVmNsl6?=
 =?us-ascii?Q?yXMRrQTKuA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ea8a28-9cc0-44e1-3a6b-08de807ada9b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:47.6222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2Mk6AB3xqhVrH6Jej82QUMNHFKOZNsaeGOmPRazzCfRC/UTLbmaCIKcW2Y6U/i8DJhR0yfxLUX2hgBOfLtuug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
bit in IDR0 and fail the compatibility check if ATS support is opted as
enabled on the guest SMMUv3 when it is not supported on host SMMUv3.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 17306cd04b..fe78ce69a5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -101,6 +101,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                    smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
         return false;
     }
+    /* Check ATS value opted is compatible with Host SMMUv3 */
+    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
+                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
+                   " Services");
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
-- 
2.43.0


