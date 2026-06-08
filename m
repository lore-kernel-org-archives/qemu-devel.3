Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23301CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6I-0006Q8-9n; Mon, 08 Jun 2026 13:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6G-0006P7-LV; Mon, 08 Jun 2026 13:49:24 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6F-00074F-9V; Mon, 08 Jun 2026 13:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+oxABq4KhJu1E3QT04F4lTvQaZ3ZGxjQgd2wU7ULK1250RFvNs8INydfywqXYN78W0o3u9SuM77m96GFv6xITjI4SWhoPKilgXezBg2P1dLG5TBXyXlHy/v+HQGuSdqEblCo6DbtVD9DiI3IhbJMJ4Nyh3jUXt4cDA1EhmIfbYTeAKlGCGcKpzE7/cZlnQKtZ0xaQxZxVy+TKyiLCe0OUReP+GqBFn7I35GS0RsDeVZTRbPah4UTquDQOutd8NUOb44VT5xQUr6JQvbQPlyYyUw/bL53juobO2RZCqSY2R5es1CQRSCKP7VK4AIWhqACmVUyKT7SunXunIYGl4T4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvdP5JzRCtiiG35TT5wDqHawS4t4/HUDf4QJ1COx5kk=;
 b=xYt/NNQhuIlp2GQaM5ANkh7rN4ypc13voRRyKNxFaXepWNfCEeOagQhqDsAER2Gv2gCtqR1s6+dm7SbeeJgaiux3kCVOul7YSqKBom0j/XFZfCbKuEJVVizGfPrqXJKzMq5+DAEGs8WwvUfNpOWxgBuvHzR9HoVypNlO1DBnSKMA1Dt6baUauFtqdvDVk6RjA19e3cz1HwDcfyR6SksnM77vNzJkv7x0+0c16d9Fv9uHVFKFhmrXKJ+2PRYPwxqAMj812K3JJwnPk3qY2h52Ybl1yxhIOHlbuAL0OG9sYKHDWvADjCf8PCBj6ZkTPEjdHC7m0mx3W5Gy3INE+pXZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvdP5JzRCtiiG35TT5wDqHawS4t4/HUDf4QJ1COx5kk=;
 b=c/c19Zee2JYBeL1feTSkLDI+/yYe0focvivCWi+po2lMOaNsxidbu7lCkZhs06m2o/vuKFw3a3E0cJvZm4Ap3HydzdnjGx0+YPB8a0QTnjR1RXbiypRPhJpEsl2gmUl2M2i5ASG2/fg25TXjUyJT/yjMLfASZH7+4jNyA4eYaS8Ywrg267XkBEN7BYOSYTorWuL98GwiXtqn54pyPzAkgV4dDtAuaBlYlWzY0DijlbtaBVzKXPgfQJlO/SHssXAUrqMo7Y7SyaWO/luyZfHthv8sww2Duir2RgKEXSojST9/+AE0DnztZKgOFhtIETbDgEsIVQSWKk23wm8Xi1zOoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:14 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:14 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v6 1/9] hw/arm/smmuv3: Update ATC invalidation check
Date: Mon,  8 Jun 2026 10:48:52 -0700
Message-ID: <20260608174900.2227340-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::12) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: f70c5d3a-cd39-459b-ba67-08dec5864112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vE+tapHM1JG6bfWfZD8E/ecCx4AcK35sNQzHunJTIZ+IZ0pvjwQAZ1CHUPSXjJbL7gPavcaBnfnJxUMHNmXuXCQ87v6b1hK8MzGe/KX4rQs+hOiZ4OKQ3OsD6kgwmbmpekxHBqHxQ2XqcuUWv71DFiDIDEkz0JZsspYxNsoB+0SBYaR0nnLE0C1ClDV1K5M4g3dbzc0VYKPNHSNdO1TR/iHCYwKUAvURJTEi8Ko3evlWPln9mHpeCeTLc/Oj43ymBV7G+cYrDcGIMJmy/Jcq1WEp2ntxxT0toyKJIWJDKl3NpAylsGUuYZEYbiaCdlmrOHiSOVIHV2Yb7z1jl57hsadQ5+MJWWTri+i0k1BRp/ga7yjLxkb41vX5wO9966yZEM75mW+sBnC/uqDIzlMP1e/FC0YkbYUDMUET1fGk0FQTZbhA2WTvuzgnnbyWDVE2eH0npaXmwPOpKALA3yNXazZXE97Xq/peJnqjeTn09Z59luxn3GBjwyHrJNL9wM37V5V5WBcTjvOiKt0Q6MNvvXI4IaqotemwchKTt1IuyQeJgkHx4pXMEuptaKKdjv6iO4WCG7WnjrBt0R9bf00aOOWZiO0550omOcALkB4TyXUJRH1qbsiQ9ZVb5dPWIGROxgVGg6tXbgaJHS/3IuvViXXx3INBa6Htikl9UBlu2LK1HBkHGXBjqlYYPihfyCnH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcWhMiamhKlVJRHKKyQ11bDAZEr8IS+DdhkPlIhFCydCT242ZdXjHXB37HQg?=
 =?us-ascii?Q?6Nys04x4W4g4BI7uUWPvym/mSLf5DNfyUkir9f2LYyg/k0sFUjTBYxcQDAFI?=
 =?us-ascii?Q?BS/3gcYu3U+s9tt24xMpO+Z23avM3mtCaVzz5CrK4X+caW7YmiHGa1Bw0zFm?=
 =?us-ascii?Q?dxC6hAqG0PG5eouZyBraQBfHbN36ELzvhM1A2woUimLzKQuukPuKWarLxLYY?=
 =?us-ascii?Q?Kav73sakGOzG7zV5kebBStiQJcxmXFgClADE6PqHqfajYNcqViPbXlN2BsRA?=
 =?us-ascii?Q?OZHXgZKLMcY2BIVfcaITdA1DKdn4i/tgJGg9MfuAJycHUJq+bqkr8Z1RLEND?=
 =?us-ascii?Q?iJLXHzoEFG6L9maNAVPvxzOSYmjnxzX/PkfXfb9FEtN3j+WwjuIV4o/asiSf?=
 =?us-ascii?Q?8hTp43W7zmmuBhhYL0JM3+ujvf97lMZoX/cR6lWIyWZoB9BzRjgB4ELIg7Rj?=
 =?us-ascii?Q?UX3rkAsoO4mi5k4HocQsjHwTYhTARLu9gkjvaORTlweZg5yuA5OCAR8OS3ZT?=
 =?us-ascii?Q?eo8IByYOnJ8RBREqxvGlohNqHdRSvD/kf06k3csBRpvdJJM4s8ZSCp0xqls7?=
 =?us-ascii?Q?lMPUF07e33XRwrNggugNTiE6Fp2FNCk7Zr7I/w/f1Xlb0ugqyBuJR5MkD3Vr?=
 =?us-ascii?Q?cSCyWZ+bq0SlagmLheuDlEkfbgu0Bl7I7Op/nvygHNkQHvpj9OjALfdR/gy5?=
 =?us-ascii?Q?mfDn9YBUinpNEsgbO+zaJ5+pP8mLaLAPr5kt7WxBaE6iuWyUKDHHKkPGrx/l?=
 =?us-ascii?Q?EHBUN6A3Zi/B3bHjCGlHgMAJegn4JgeixTg6Lg7j8rVkL8xCZVemTt65UsxX?=
 =?us-ascii?Q?zbVTqWVrZ9JOWlb2G6syYALTYtliuVo4rqRfRA2Mvk05nCMhDrYNZ3KmN21n?=
 =?us-ascii?Q?GwTN5dAAUtSsKLIfZN8ZpPldVQqCxJg2lxxKk5iGAlcrfjlXiPYMnWn31zVQ?=
 =?us-ascii?Q?C0Rp7LNtUcqVPmrgPP6WbxQP3d2eX2LzJ/zgWGiQTB4XAmzn2ZqPSwpUW1tM?=
 =?us-ascii?Q?YYkYDwulm9rJFJSKTc5Ok3gsZoHHz1SJmP1Qhv8ukbTcmhoY5umwKiCvOh7z?=
 =?us-ascii?Q?LO/9BdnA7xBzqrsm6Bs9VvJYndJ3qdGxrGzZ0n1y+YccNiTGRv9bcDeREBSi?=
 =?us-ascii?Q?3bNrVJJWg5d1xsC4IqlLbSW9u1cqPFb8sBY1F0+uplxGyFAmjp2WSTtmqj0l?=
 =?us-ascii?Q?4GgrKFa11ndlk0fAxreFGDADS0vph/lgjacWiAjZoaQwVHTJgqZynVmKsS/1?=
 =?us-ascii?Q?vTxj8dYnJKhtu1obZNnRNqTDhKTrXEPmb4SCrABUKT8oZMFPUzzFCfkDp6wg?=
 =?us-ascii?Q?31kI1MTb3gx54Ad8FU7STjZEzxgf7MWy7CUWvDDVtNkdP8J8QpzfeRSzIKSq?=
 =?us-ascii?Q?T7cwMnLhBc9LB7eVHsDYO+NDH8khBJRsb+aNNT3g2hqbeMgxJbZNISQvQ/4s?=
 =?us-ascii?Q?PM0bl+ztG/hiMbgVgGGVcU1VYc3ogWBY/qrwxilXxrmbcLfnsu1vqoZnnH3z?=
 =?us-ascii?Q?9oOWF+vAxGLbOaWgBn0hlKoQmG92k5n69ufjBjSGWWxKqtbHm+GqwoNiioNk?=
 =?us-ascii?Q?EREkpPq6YSzMNDQ9BlVreWskgw43zHOhZIOTtZrlZQtp02a7mEjDkdb4xbHE?=
 =?us-ascii?Q?BsD52bhOih6BjBOpnir86rE18HvRVV7XPfVI/dgFlJ5GAGOE86qzb1GDmh2M?=
 =?us-ascii?Q?pzLSAvRKO4GM7vMBAdbxmVaD54so1aWvzRSW+umZBJZNGt/XU7HZUWUwtMvZ?=
 =?us-ascii?Q?otMZtVIwlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c5d3a-cd39-459b-ba67-08dec5864112
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:14.2188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BC0gfQrv/10C3NiYmJj9oIR+LdnUhN9MPsG8xVmQToTg8OtI8fVtVnP2/tcwm36NfoBuybKsd+5b73gmuqjtVw==
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


