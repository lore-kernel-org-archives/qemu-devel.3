Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB853CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6M-0006WZ-9n; Mon, 08 Jun 2026 13:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6J-0006SD-8E; Mon, 08 Jun 2026 13:49:27 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6H-00074F-NA; Mon, 08 Jun 2026 13:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFK7VU2s1lKEctc7gQeqXXObkz+ENSOvgIQRjLpTHulWgSWd8V/g46pvyUCX2TTMZaQbtOeuQJh7TVovbzTvC1fJepkf/8MSI30DG1msOM2R2jpUlr2+HTqmYzI5ndMam/ZtkgH9dYInQS0fYiuVl8SVPp1gOiGa0QHXByfo0fmLSVptdEavYMOQJKtIKILZqBnmGcNxvsYp3UfwSfmAW5a9vEDNP91mXXfLxt4se87tQ5BxuTKDjOt7dPLVzYRfUQVm3uxVDr4xJWa0KrngTkEr52vpO3NqGOCrVg2c9EJ4LdlLmozSH+XaDK3F0esUOJG4vqX5fXycdIDHZzhi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX/UyE0qMo6tHWXEq6LKTRWLmEOKuSugbFO3Rwzbo3w=;
 b=JwNIa8MYB/RO8auxaJQz27oAm/bmbmkqTFdVKxlPBfBrK780+Ge+Ni8NNcrQAhDcBJL+JGBJ+xaVQ88RCXICZiGR0HmUP+SLQei3jRUBf+oGg40aCk26tCYBd8h/Py0UDLS00WImf2ppnwg5S/fVseHKDfGPsZh5zrFsCb80XNPHWiCZ8fS4k0Wu9B9ehN4KXTKlitT0ZR3FKLD80Qin1ld28h8P1OAe4g5Au3Dn2QdGG0RThKF6NH0EQ55V+RKhBK8hYgaZWm7y+msHUjuHevvtHnq0Uvcvwx3tDWeP6LMV/6LBOk2noM3GQqCLCbi6z/fxGozfgPbC6MngTSxYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX/UyE0qMo6tHWXEq6LKTRWLmEOKuSugbFO3Rwzbo3w=;
 b=toNaQEDtAPvJqS6G9fJRn/b8teft1Acq7c/n/NNcv06CFp6RRzMj/iLq6C6N6hXV8w/bnUfzBA3EIsRwBXreev8e3EhDmUHPgncbA+0j6Ks17I3tmJ6ujV50+iNRb/h0hvv+ybWt9vZJb4RC2DlfZxC8VINojJLLt9Ii6Y7/ist2Q3+dIG01jPHcHxhKG56CYEE7XRDQm6+H9S6FZFb5KJbTFJGHLlLAU65YQ06edKDlmt94C4nQGORkRW1MxLkK+NJuOHAPHISABRbBJkxzQ13KQOSIXOdmiDDdFY3TjBfCKIiCbTwDu1nFHd/V/Vz/PfgSwOWIhSib5OYudpg7Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:16 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:16 +0000
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
Subject: [PATCH v6 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
Date: Mon,  8 Jun 2026 10:48:53 -0700
Message-ID: <20260608174900.2227340-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 93255a47-db05-4910-0c37-08dec586422a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jHNUzl4b8ggGaurHsIg+/baPJ4jqWM8M1hB1s2bqpzL+IxKejY0z/3M4Fzuwim+FAZUp6hcYV5HjnEGtoHYIq2jlCDim/hPdUCWGOtFarPbivZ8gGiwg3GG6gEVD+jFMcAiI8R6ZnGtYcaFP5e7fXPTU7vkNWuh9AzmNflBi9ij09OYjxFR9HrFi5aLH/DAVJoYn/YiA0gM1if19XGM7I5jfFR3X9C7wYtdiKpRsvwMppyMgr2zAls8crphmiIVJxyvE7mPy2TETC2T0Ip2IuaiFCcxyw5+b77aDJOF0WmWx2614PxHL1SWd8G4YUbR/r50XGlKqm5ENxzjJ/eqYKxW2G112yxDZPL/dZZb21A5fwJfLSshAtcQQjiB7Bh7+H9Trz0N276ZxboKpYsOlQk1uveoxfDCDJ/RMbJYeWqO2UCqDt0DuGcMZh9488QpTfc7BFhejsCrA6VQ428E5G8nLsUKeqoGzxI5aj4EChST9Y1aZ1RjPz3NcPiCd/d8uBMTTz1Xxr3EhidtPnJ5Kz1v5yabKm3BNpVjSFK54bimvb9dtOpFUhDBTwjxNVtexmAq6KsI3gujkfFNXykFTKsfrthyNldhCg95EhJk+/l0/KFShElNLqqSJWWUIuiOhQo5DCrWkVNz/LbwiCgou6wEG2PkNpRL5gAd62WfVpwF17HV6GQJ6K/iruAavO+em
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RZuBJlhPtWd1+dq3MXu5tMxumJOmdsDPT0Fx+Un4Cfh92zggE3RrwCGbUftw?=
 =?us-ascii?Q?QdXLMJaYD3tfzFfH0p520mZa8BOk/POhbi7Lr/sOOf8w8uK0hmQNJOQEenH/?=
 =?us-ascii?Q?quPSQZ3bCgK/e+EgLQYkm/eWhUJE3AQ2Pgoy3lIePOJySU5J63iJBCA2z3Ta?=
 =?us-ascii?Q?FRPQ+AYddgDmJ/76UzMZyE0VvqUMt6h+WJk0tnPuSaxdZADhminE0RVpjDRk?=
 =?us-ascii?Q?HjOKKKKKXyn6tN4lgK/iKG9h7qYQr4ZJfIxdInaDl1dxCRTjq/v3XwO03YVV?=
 =?us-ascii?Q?jFKSp7Sp3lac0Hj9p55QmTvco/MQ/TZcliHWlDsco1uffnQcUqStu/5y8eDH?=
 =?us-ascii?Q?LKhgF25FH4ptPHr+V7wWFQlTNNo15Qu6+rzSHaoX1Yx5mNXhd8K9YbiSmkqv?=
 =?us-ascii?Q?oAs/OHM+6pJq464R97HVLtgQIuw2crEv95N7yfJtM/x0P8bUAeAPtloZrEME?=
 =?us-ascii?Q?tb2dmYlDi3k0IeXYx49I50e3IIvZ7MYJ8o8oteEE0KeW8jxSloFWpyJZUFBK?=
 =?us-ascii?Q?mxNPjyEOSlw6QuQd5Nzb/wJa/gX2jRzp0TL8RU7u8YmRPWCurGPV3Czx1t9v?=
 =?us-ascii?Q?fVaih4PbE4Qs0YDRUjCp3SpDCA9Ov4JQhrRXxVptXVLXBuxYpjsN5OQqAz8Z?=
 =?us-ascii?Q?aLsY8reiaL+6JvSroBa5dGV1X1M/gpfJK08SRcZBLH+OVzqGDYnt3O0GN6pK?=
 =?us-ascii?Q?ov5eb3PzleSm6uCghpXnytUld7AtC9119hhNMB+9UBAtihGPCd41oVP6PKvq?=
 =?us-ascii?Q?rbMqDCkXb9FrLTEstz7YPzjYXhP5rqY1HrHxbsDoOYDZpugTsyTLdojMwgqq?=
 =?us-ascii?Q?/ogWqPKc/5+SR+DSTKl1Cn1lfVMactKVNzGwG8xlpkf9iU9sqpGv+wwUSiIt?=
 =?us-ascii?Q?/EVyDW2c9FKq9Ow0cucAM87kVMXQjebGmTyN1DhXrS05VPd/pgX/NJZuCVdq?=
 =?us-ascii?Q?wsqA0lytbnlt6N6Fe8zWjAKm49pC2zAena5SesX0U+6tu1srLhYJVMU6xeee?=
 =?us-ascii?Q?2DIrMTZuDA8eCB4bwnzwTe9lVftdC6hRWkkGkP9JkAAyqC7SV++0glmWbVoA?=
 =?us-ascii?Q?lKJNetUWaPuzs36SX2zmjufTA/1ODfiVzNSpc6vWq7lnZIi4tdDbVmqzYgrH?=
 =?us-ascii?Q?TgwNa8/VvI6p6Wit8v6IzWLJo4cmcEzNMWPpPntEEIt43LRRaQKaxd15Ie4P?=
 =?us-ascii?Q?JPpmR/Uca7DDp8bQ7UvalIM1CVVXcHN2nZ2hrZwjT/+vt1TvyTLjR8Pp0jTO?=
 =?us-ascii?Q?MBtidHVgsh7eEicN7d7x3nUG31ky5cjFbu/KcgLnmxdLh+tF4dFjOgY2wxnH?=
 =?us-ascii?Q?YED21ytSi0Wmmv4SPGV9+yiS3WERuGWP0VjUdbE3aCFh4fop9QhL3bV75oYa?=
 =?us-ascii?Q?LC2uQ/ViGWXV7c2Z/nOJ5w6uOxPh3+Sxcw/2DdKkLaVfkw6N5HjMhL7y6ofN?=
 =?us-ascii?Q?uNi9z8aB/RTcug3RDAiG1o7fBENl+8ytbhAvjUBJ0K3ftuFuj22pO5edUqAP?=
 =?us-ascii?Q?kzS7AOVupqRc2IT+aNA5IHwsgBd7VnZk6lEt47fqL7GUgJorskiCZrQbRJh1?=
 =?us-ascii?Q?6iLnWUqX5BSFETYktoKWIA5A5BXia/8K3iMvwkhErvzAJ7Ext5IwnZsxxcn2?=
 =?us-ascii?Q?fIV+if0MIHFYKrhRRDCcf2RWBDonMAVYKwNPL2aesxwmI1nHpEEf0F/ZTrFS?=
 =?us-ascii?Q?NCrtrbzPQnGk6AhVzNaEYvF1NSEk+OaD72OpOVpQvog1bdWpa13Yh/Jc68Fa?=
 =?us-ascii?Q?OuVC9rckrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93255a47-db05-4910-0c37-08dec586422a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:16.0510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd+VeTlnv9HbU2dfBKLHOnDEQpmADyjzeqtkiWSMADn7mOp8sw3DSn7YJqvfcVd3ZwdVi3T4aVkc6xNw522Eig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Add a statement to clarify that the host SMMUv3 must support HW-accelerated
vfio-pci device assignment when setting accel=on.

Reported-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0c65dc8c91..6b5035e11f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
-        "configured in nested mode for vfio-pci dev assignment");
+        "configured in nested mode for vfio-pci dev assignment. Please "
+        "ensure the host SMMUv3 supports nested translation before "
+        "enabling.");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
-- 
2.43.0


