Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE77C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH9o-0000OI-Ef; Sun, 25 May 2025 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH9l-0000Nt-My
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:37:14 -0400
Received: from mail-bn7nam10on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61d]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH9j-0000AG-Sv
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQlx9u9W34n7qz6OPsEGfrisiNlo0gW+PIuhIsNtwIcjuY50o87nI1nYs8nMATkfTFtdig73srbZehkJfEtsrLxs1lYyq2yPs8UKHchvWe3r04kK5T+q5fUL3oyw8xfOxuEgcwSVzLdscZuaoBdC89VtLLcMeR9/la8ChFm0IDGlYYr2E5wnRv3L6dCs4Ii9OKw9WAQolNzHxcSiQl8gtUb/3DbsH5xTUWYoHbtIKpco2dyAX33bwLzqFrJjcVJA8kSdtI3S9cHXDsTHhkzWYWpglP2GG6HfTKvkXbSh1V2GTmjDa7FU0sUcPtLEfXyLMw6hmMCWJgDVZ8u8HEczxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XUdGk+IP72fly6a3qDKuTxazB0OB1dTbzwGpasWgwY=;
 b=kKhME7ZbewLWD6lFx4SDb3s+DqyiQ9ZNbWohPo+JCxsqm0sV19zpGrFlaTfUh1XweF+zuGdV28KaVRQMgumkyAiX/CytGzueOBp8sCfZi0qi6VjzH2pzLGNhbNCXx/dc/qLmmUyZdwWieD0jfUDr93lPjamGKLgleky6RcWft2KWEdsCWys3lxDNTGj9WI0I5NU4z2FsxIC24rm+VXQVikRMOVlMpZqgn6vQTPz53MZiWwvyqQClHpzeB9Nj4cf91ph/YGY9MU515IaInZW8BS1t3c2aTm2YPdHok1uciiqW/5gJdz1NXJfgmFh2/+3QBNdD+1QopFDbLNhRN04UAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XUdGk+IP72fly6a3qDKuTxazB0OB1dTbzwGpasWgwY=;
 b=WyNppcIOQEGjYz4qpmEniz9dNfZ2KijhQIdTH7VO6KFJNH7CPfiU/EXLjnjP1AOAShnuimUjabC8mEm5YUBmt5gg+v+IEg4GkZskHWeVfOKK4SGAXOe4IUTkQfbppLXRQCGndQyTD2sKtmsNl2bFVpMpFJMz9u2U+Jjr8YML+Y0=
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 19:37:04 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::38) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Sun,
 25 May 2025 19:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:37:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:37:02 -0500
Date: Sun, 25 May 2025 21:36:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 08/10] target/microblaze: Use TARGET_LONG_BITS == 32
 for system mode
Message-ID: <aDNxWCgDIo6AByRH@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-9-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5305ee-0b7d-4f9e-1b2d-08dd9bc386d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Im6Vg46QcYBHBr2nB+rMWnNopn5l779OpItI+zQJUtXItTqqFKjuN1vuKSS?=
 =?us-ascii?Q?R7rEEpzGHIZdCIrJkmAHPTXFpAeq2oCQBV7ew5oEEFHyzNGlw/QpPnLBuJUC?=
 =?us-ascii?Q?A8qiFkDGKrffkl3rF9730QUr05wSqCTdyVsMAq1RYQ8+BlTkZlUSv1EZwp/e?=
 =?us-ascii?Q?Ba+podYqKz9HaHxmpLu4oQfvwGLYgcmRK1zqGDqy2WQt9J2m/dbkN+2/Qa4G?=
 =?us-ascii?Q?mcVWWfkFyd7a4Wd1I9/9TUPBctONbRfIBY2eYr9YARXYoq8rV5z6eH1/eWl/?=
 =?us-ascii?Q?zgFA20BfMc1NUb6nHQRbraglSRt2lAWvjPyqj0ZR47hdRXCoG3HWwa+r1/Wb?=
 =?us-ascii?Q?pPTnMhQEjw/Nl6K4CYanDcXiJQuJ0rvApM4t75aRDAWwbnVoPi/mJjWHjMx3?=
 =?us-ascii?Q?+BNxvjvPrKgzXnih4RfExDWgIGhCE+ijuqiQQ8dWXBpJhY3CaXACj2tYwO2t?=
 =?us-ascii?Q?hX+IJhVyWWI9ONQqPP2QyZnW2BOxFdwR0csKpMzAtsjDN6fMMFgH0axF9yY4?=
 =?us-ascii?Q?ygTOL50/IVzr5b8dZqeXwLtvwbHXbfAWQqo5mjHatnQavddCqzP6SCnqKKeR?=
 =?us-ascii?Q?FE43JbigTKVcjhH7PkH1R9on1S4N7WuweF89vjpvu5IDXL/hRra9TITajddT?=
 =?us-ascii?Q?2UBNmuOB5PcKKtONrDo3yWqLJJzCnOPiodJqxbNe6TtXdDvBHzqv6Ho3GPq1?=
 =?us-ascii?Q?4vedHk3gCuY2WllqpwL6DbFMwXUgs0D7xiks4jm5tMcuYE0UjcjTV8V4xjL7?=
 =?us-ascii?Q?GMEVujqx80JVYo7KJ/YRbk7GA4U8t2LkubqyMWnVSLqlAlK78h6nxEEtDvHs?=
 =?us-ascii?Q?3MSMWQkMkGkJCgLgblvepp2fNsU20R5Y/75vPWaLfAU6CIdGsxbYrVG0WvS/?=
 =?us-ascii?Q?lokmfN72nz2Cx7Y4VOQ2ppBCHAcSpBjj+QRK38ZIgSuNCyeO9xMu+XuSd7tH?=
 =?us-ascii?Q?lwSuH3XFLwWh3nF/Y9GVhOx0D9I4D6FJteWa6hAe4zeGl9Mk7TrKWiTSxAYq?=
 =?us-ascii?Q?G8tsA0SLkAFJ2Wvo8XJC1tX9esQMyZlFlqsN2JYK26BcrUJSG67evM8VdjrP?=
 =?us-ascii?Q?1g/lir80GnVHlTIzdwFtOwv6ruAXiDh1jSOxqFef8dcSRGB0NbuePRP3UFI1?=
 =?us-ascii?Q?pyAc8D18fDrltUffqoeTIbFd2QU4VT9pIrcHAvtcr63h6oRTHNfsg5GX2o5X?=
 =?us-ascii?Q?Ylopg8i2bmbKlRq/AYxTHdSppFhqNBJQyPMNxOsK0sLonVt17M6D/hX7gY86?=
 =?us-ascii?Q?MKstZZy6vVr1Q9kC0gb8ux4adces/MstuvdOEcke2oGQBPSU7bD/Kri/ITiN?=
 =?us-ascii?Q?vSyI3Bh/Tpuv9MoRJN4zSXPRima07ENfUV8G+EnHUQazzNoj5wttymmTRMwP?=
 =?us-ascii?Q?TCwDwS1dgOOEIH2IydRrJNDAWLPPN2YH7JiG99tpBCcitYx5xIZzuWypJrwc?=
 =?us-ascii?Q?RkbeewgBn7nboeFaossY8QEsWjgeitozl4+22d6v4lnzUECACmRXahadXAjf?=
 =?us-ascii?Q?v7B+SPRaZwmZ1qFLJ+hq2cfK+Tqo/8K36Bvr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:37:03.9160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5305ee-0b7d-4f9e-1b2d-08dd9bc386d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
Received-SPF: permerror client-ip=2a01:111:f403:2009::61d;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 25, 2025 at 05:02:18PM +0100, Richard Henderson wrote:
> Now that the extended address instructions are handled separately
> from virtual addresses, we can narrow the emulation to 32-bit.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configs/targets/microblaze-softmmu.mak   | 4 +---
>  configs/targets/microblazeel-softmmu.mak | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
> index 23457d0ae6..bab7b498c2 100644
> --- a/configs/targets/microblaze-softmmu.mak
> +++ b/configs/targets/microblaze-softmmu.mak
> @@ -3,6 +3,4 @@ TARGET_BIG_ENDIAN=y
>  # needed by boot.c
>  TARGET_NEED_FDT=y
>  TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
> -# System mode can address up to 64 bits via lea/sea instructions.
> -# TODO: These bypass the mmu, so we could emulate these differently.
> -TARGET_LONG_BITS=64
> +TARGET_LONG_BITS=32
> diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
> index c82c509623..8aee7ebc5c 100644
> --- a/configs/targets/microblazeel-softmmu.mak
> +++ b/configs/targets/microblazeel-softmmu.mak
> @@ -2,6 +2,4 @@ TARGET_ARCH=microblaze
>  # needed by boot.c
>  TARGET_NEED_FDT=y
>  TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
> -# System mode can address up to 64 bits via lea/sea instructions.
> -# TODO: These bypass the mmu, so we could emulate these differently.
> -TARGET_LONG_BITS=64
> +TARGET_LONG_BITS=32
> -- 
> 2.43.0
> 

